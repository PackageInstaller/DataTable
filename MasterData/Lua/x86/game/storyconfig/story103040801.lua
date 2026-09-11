return {
	Play304081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304081001
		arg_1_1.duration_ = 6.9

		local var_1_0 = {
			zh = 6.23333333333333,
			ja = 6.89933333333333
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
				arg_1_0:Play304081002(arg_1_1)
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

			local var_4_9 = arg_1_1.actors_["10001ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect10001ui_story == nil then
				arg_1_1.var_.characterEffect10001ui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffect10001ui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffect10001ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect10001ui_story then
				arg_1_1.var_.characterEffect10001ui_story.fillFlat = false
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 1.53333333333333
			local var_4_18 = 0.575

			if 1.53333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_20 = arg_1_1:GetWordFromCfg(304081001)
				local var_4_21 = arg_1_1:FormatText(var_4_20.content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 23 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 23)

				if (23 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 23)) > 0 and var_4_18 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_17 = var_4_17 + 0.3

					if var_4_23 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081001", "story_v_out_304081.awb") ~= 0 then
					local var_4_24 = manager.audio:GetVoiceLength("story_v_out_304081", "304081001", "story_v_out_304081.awb") / 1000

					if var_4_24 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_17
					end

					if var_4_20.prefab_name ~= "" and arg_1_1.actors_[var_4_20.prefab_name] ~= nil then
						local var_4_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_20.prefab_name].transform, "story_v_out_304081", "304081001", "story_v_out_304081.awb")

						arg_1_1:RecordAudio("304081001", var_4_25)
						arg_1_1:RecordAudio("304081001", var_4_25)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304081", "304081001", "story_v_out_304081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304081", "304081001", "story_v_out_304081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_17 + 0.3
			local var_4_27 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304081002
		arg_8_1.duration_ = 3.8

		local var_8_0 = {
			zh = 2.8,
			ja = 3.8
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
				arg_8_0:Play304081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(304081002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 14 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 14)

				if (14 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 14)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081002", "story_v_out_304081.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081002", "story_v_out_304081.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_304081", "304081002", "story_v_out_304081.awb")

						arg_8_1:RecordAudio("304081002", var_11_6)
						arg_8_1:RecordAudio("304081002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304081", "304081002", "story_v_out_304081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304081", "304081002", "story_v_out_304081.awb")
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
	Play304081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304081003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["10001ui_story"]) and arg_12_1.var_.characterEffect10001ui_story == nil then
				arg_12_1.var_.characterEffect10001ui_story = arg_12_1.actors_["10001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["10001ui_story"]) then
				if arg_12_1.var_.characterEffect10001ui_story and not isNil(arg_12_1.actors_["10001ui_story"]) then
					arg_12_1.var_.characterEffect10001ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["10001ui_story"]) and arg_12_1.var_.characterEffect10001ui_story then
				arg_12_1.var_.characterEffect10001ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10001ui_story.fillRatio = 0.5
			end

			if 0.5 < arg_12_1.time_ and arg_12_1.time_ <= 0.5 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_152", "se_story_152_keyboard", "")
			end

			local var_15_2 = 0
			local var_15_3 = 1.075

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(304081003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 42 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 42)

				if (42 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 42)) > 0 and var_15_3 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_7 and arg_12_1.time_ < var_15_2 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304081004
		arg_16_1.duration_ = 4.8

		local var_16_0 = {
			zh = 4.133,
			ja = 4.8
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
				arg_16_0:Play304081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[44].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(304081004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 18)

				if (18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 18)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081004", "story_v_out_304081.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081004", "story_v_out_304081.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_304081", "304081004", "story_v_out_304081.awb")

						arg_16_1:RecordAudio("304081004", var_19_6)
						arg_16_1:RecordAudio("304081004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304081", "304081004", "story_v_out_304081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304081", "304081004", "story_v_out_304081.awb")
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
	Play304081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304081005
		arg_20_1.duration_ = 11.03

		local var_20_0 = {
			zh = 10.7996666666667,
			ja = 11.0326666666667
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
				arg_20_0:Play304081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_0 = arg_20_1.var_.effect12313aa

				if not arg_20_1.var_.effect12313aa then
					var_23_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_datablock_black"), manager.ui.mainCamera.transform)
					var_23_0.name = "12313aa"
					arg_20_1.var_.effect12313aa = var_23_0
				else
					var_23_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_23_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_23_0.transform.localScale = Vector3.New(var_23_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_23_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_23_0.transform.localScale.z)
			end

			if 3.83333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 3.83333333333333 + arg_23_0 then
				if arg_20_1.var_.effect12313aa then
					Object.Destroy(arg_20_1.var_.effect12313aa)

					arg_20_1.var_.effect12313aa = nil
				end
			end

			local var_23_3 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_3 + 3.16666666666667 and arg_20_1.time_ < var_23_3 + 3.16666666666667 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_4 = 2.66666666666667
			local var_23_5 = 0.85

			if 2.66666666666667 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_6 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_6:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[44].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_7 = arg_20_1:GetWordFromCfg(304081005)
				local var_23_8 = arg_20_1:FormatText(var_23_7.content)

				arg_20_1.text_.text = var_23_8

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 34 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_8) / 34)

				if (34 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_8) / 34)) > 0 and var_23_5 < var_23_10 then
					arg_20_1.talkMaxDuration = var_23_10
					var_23_4 = var_23_4 + 0.3

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_8
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081005", "story_v_out_304081.awb") ~= 0 then
					local var_23_11 = manager.audio:GetVoiceLength("story_v_out_304081", "304081005", "story_v_out_304081.awb") / 1000

					if var_23_11 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_4
					end

					if var_23_7.prefab_name ~= "" and arg_20_1.actors_[var_23_7.prefab_name] ~= nil then
						local var_23_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_7.prefab_name].transform, "story_v_out_304081", "304081005", "story_v_out_304081.awb")

						arg_20_1:RecordAudio("304081005", var_23_12)
						arg_20_1:RecordAudio("304081005", var_23_12)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304081", "304081005", "story_v_out_304081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304081", "304081005", "story_v_out_304081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = var_23_4 + 0.3
			local var_23_14 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_13) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_13 + var_23_14 and arg_20_1.time_ < var_23_13 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304081006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 304081006
		arg_26_1.duration_ = 10.9

		local var_26_0 = {
			zh = 10.6,
			ja = 10.9
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play304081007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["10001ui_story"]) and arg_26_1.var_.characterEffect10001ui_story == nil then
				arg_26_1.var_.characterEffect10001ui_story = arg_26_1.actors_["10001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["10001ui_story"]) then
				if arg_26_1.var_.characterEffect10001ui_story and not isNil(arg_26_1.actors_["10001ui_story"]) then
					arg_26_1.var_.characterEffect10001ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["10001ui_story"]) and arg_26_1.var_.characterEffect10001ui_story then
				arg_26_1.var_.characterEffect10001ui_story.fillFlat = false
			end

			local var_29_2 = 0
			local var_29_3 = 0.875

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_4 = arg_26_1:GetWordFromCfg(304081006)
				local var_29_5 = arg_26_1:FormatText(var_29_4.content)

				arg_26_1.text_.text = var_29_5

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_7 = 35 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 35)

				if (35 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 35)) > 0 and var_29_3 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_2
					end
				end

				arg_26_1.text_.text = var_29_5
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081006", "story_v_out_304081.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081006", "story_v_out_304081.awb") / 1000

					if var_29_8 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_2
					end

					if var_29_4.prefab_name ~= "" and arg_26_1.actors_[var_29_4.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_4.prefab_name].transform, "story_v_out_304081", "304081006", "story_v_out_304081.awb")

						arg_26_1:RecordAudio("304081006", var_29_9)
						arg_26_1:RecordAudio("304081006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_304081", "304081006", "story_v_out_304081.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_304081", "304081006", "story_v_out_304081.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_3, arg_26_1.talkMaxDuration)

			if var_29_2 <= arg_26_1.time_ and arg_26_1.time_ < var_29_2 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_2) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_2 + var_29_10 and arg_26_1.time_ < var_29_2 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play304081007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 304081007
		arg_30_1.duration_ = 8.93

		local var_30_0 = {
			zh = 6.466,
			ja = 8.933
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
				arg_30_0:Play304081008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.65

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(304081007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 26 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 26)

				if (26 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 26)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081007", "story_v_out_304081.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081007", "story_v_out_304081.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_304081", "304081007", "story_v_out_304081.awb")

						arg_30_1:RecordAudio("304081007", var_33_6)
						arg_30_1:RecordAudio("304081007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_304081", "304081007", "story_v_out_304081.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_304081", "304081007", "story_v_out_304081.awb")
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
	Play304081008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 304081008
		arg_34_1.duration_ = 3.67

		local var_34_0 = {
			zh = 2.9,
			ja = 3.666
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
				arg_34_0:Play304081009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["10001ui_story"]) and arg_34_1.var_.characterEffect10001ui_story == nil then
				arg_34_1.var_.characterEffect10001ui_story = arg_34_1.actors_["10001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["10001ui_story"]) then
				if arg_34_1.var_.characterEffect10001ui_story and not isNil(arg_34_1.actors_["10001ui_story"]) then
					arg_34_1.var_.characterEffect10001ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_0)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["10001ui_story"]) and arg_34_1.var_.characterEffect10001ui_story then
				arg_34_1.var_.characterEffect10001ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10001ui_story.fillRatio = 0.5
			end

			local var_37_1 = 0
			local var_37_2 = 0.275

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[44].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(304081008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_6 = 11 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_4) / 11)

				if (11 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_4) / 11)) > 0 and var_37_2 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081008", "story_v_out_304081.awb") ~= 0 then
					local var_37_7 = manager.audio:GetVoiceLength("story_v_out_304081", "304081008", "story_v_out_304081.awb") / 1000

					if var_37_7 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_1
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_304081", "304081008", "story_v_out_304081.awb")

						arg_34_1:RecordAudio("304081008", var_37_8)
						arg_34_1:RecordAudio("304081008", var_37_8)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_304081", "304081008", "story_v_out_304081.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_304081", "304081008", "story_v_out_304081.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_9 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_9 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_9

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_9 and arg_34_1.time_ < var_37_1 + var_37_9 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play304081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 304081009
		arg_38_1.duration_ = 9.5

		local var_38_0 = {
			zh = 8.533,
			ja = 9.5
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play304081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.actors_["10045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10045ui_story"))) then
				local var_41_0 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_38_1.stage_.transform)

				var_41_0.name = "10045ui_story"
				var_41_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["10045ui_story"] = var_41_0

				local var_41_1 = var_41_0:GetComponentInChildren(typeof(CharacterEffect))

				var_41_1.enabled = true

				local var_41_2 = GameObjectTools.GetOrAddComponent(var_41_0, typeof(DynamicBoneHelper))

				if var_41_2 then
					var_41_2:EnableDynamicBone(false)
				end

				arg_38_1:ShowWeapon(var_41_1.transform, false)

				arg_38_1.var_["10045ui_story" .. "Animator"] = var_41_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_38_1.var_["10045ui_story" .. "Animator"].applyRootMotion = true
				arg_38_1.var_["10045ui_story" .. "LipSync"] = var_41_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_41_3 = arg_38_1.actors_["10045ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect10045ui_story == nil then
				arg_38_1.var_.characterEffect10045ui_story = var_41_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_4 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 and not isNil(var_41_3) then
				if arg_38_1.var_.characterEffect10045ui_story and not isNil(var_41_3) then
					arg_38_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect10045ui_story then
				arg_38_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_41_6 = 0
			local var_41_7 = 0.7

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_8 = arg_38_1:GetWordFromCfg(304081009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 28 <= 0 and var_41_7 or var_41_7 * (utf8.len(var_41_9) / 28)

				if (28 <= 0 and var_41_7 or var_41_7 * (utf8.len(var_41_9) / 28)) > 0 and var_41_7 < var_41_11 then
					arg_38_1.talkMaxDuration = var_41_11

					if var_41_11 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081009", "story_v_out_304081.awb") ~= 0 then
					local var_41_12 = manager.audio:GetVoiceLength("story_v_out_304081", "304081009", "story_v_out_304081.awb") / 1000

					if var_41_12 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_6
					end

					if var_41_8.prefab_name ~= "" and arg_38_1.actors_[var_41_8.prefab_name] ~= nil then
						local var_41_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_8.prefab_name].transform, "story_v_out_304081", "304081009", "story_v_out_304081.awb")

						arg_38_1:RecordAudio("304081009", var_41_13)
						arg_38_1:RecordAudio("304081009", var_41_13)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_304081", "304081009", "story_v_out_304081.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_304081", "304081009", "story_v_out_304081.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play304081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 304081010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play304081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10045ui_story"]) and arg_42_1.var_.characterEffect10045ui_story == nil then
				arg_42_1.var_.characterEffect10045ui_story = arg_42_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10045ui_story"]) then
				if arg_42_1.var_.characterEffect10045ui_story and not isNil(arg_42_1.actors_["10045ui_story"]) then
					arg_42_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10045ui_story"]) and arg_42_1.var_.characterEffect10045ui_story then
				arg_42_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 1.1

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(304081010).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 44 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 44)

				if (44 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 44)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play304081011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 304081011
		arg_46_1.duration_ = 5.03

		local var_46_0 = {
			zh = 4.133,
			ja = 5.033
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play304081012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_49_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_46_1.stage_.transform)

				var_49_0.name = "10001_tpose"
				var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["10001_tpose"] = var_49_0

				local var_49_1 = var_49_0:GetComponentInChildren(typeof(CharacterEffect))

				var_49_1.enabled = true

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end

				arg_46_1:ShowWeapon(var_49_1.transform, false)

				arg_46_1.var_["10001_tpose" .. "Animator"] = var_49_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_46_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_46_1.var_["10001_tpose" .. "LipSync"] = var_49_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_49_3 = arg_46_1.actors_["10001_tpose"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos10001_tpose = var_49_3.localPosition

				local var_49_4 = GameObjectTools.GetOrAddComponent(var_49_3.gameObject, typeof(DynamicBoneHelper))

				if var_49_4 then
					var_49_4:EnableDynamicBone(false)
				end
			end

			local var_49_5 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_5 then
				var_49_3.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_46_1.time_ - 0) / var_49_5)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_5 and arg_46_1.time_ < 0 + var_49_5 + arg_49_0 then
				var_49_3.localPosition = Vector3.New(0, -1.23, -5.8)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles

				local var_49_6 = GameObjectTools.GetOrAddComponent(var_49_3.gameObject, typeof(DynamicBoneHelper))

				if var_49_6 then
					var_49_6:EnableDynamicBone(true)
				end
			end

			local var_49_7 = arg_46_1.actors_["10001_tpose"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_7) and arg_46_1.var_.characterEffect10001_tpose == nil then
				arg_46_1.var_.characterEffect10001_tpose = var_49_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_8 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_8 and not isNil(var_49_7) then
				if arg_46_1.var_.characterEffect10001_tpose and not isNil(var_49_7) then
					arg_46_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_8 and arg_46_1.time_ < 0 + var_49_8 + arg_49_0 and not isNil(var_49_7) and arg_46_1.var_.characterEffect10001_tpose then
				arg_46_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_49_10 = 0
			local var_49_11 = 0.275

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_12 = arg_46_1:GetWordFromCfg(304081011)
				local var_49_13 = arg_46_1:FormatText(var_49_12.content)

				arg_46_1.text_.text = var_49_13

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_15 = 11 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_13) / 11)

				if (11 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_13) / 11)) > 0 and var_49_11 < var_49_15 then
					arg_46_1.talkMaxDuration = var_49_15

					if var_49_15 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_15 + var_49_10
					end
				end

				arg_46_1.text_.text = var_49_13
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081011", "story_v_out_304081.awb") ~= 0 then
					local var_49_16 = manager.audio:GetVoiceLength("story_v_out_304081", "304081011", "story_v_out_304081.awb") / 1000

					if var_49_16 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_10
					end

					if var_49_12.prefab_name ~= "" and arg_46_1.actors_[var_49_12.prefab_name] ~= nil then
						local var_49_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_12.prefab_name].transform, "story_v_out_304081", "304081011", "story_v_out_304081.awb")

						arg_46_1:RecordAudio("304081011", var_49_17)
						arg_46_1:RecordAudio("304081011", var_49_17)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_304081", "304081011", "story_v_out_304081.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_304081", "304081011", "story_v_out_304081.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = math.max(var_49_11, arg_46_1.talkMaxDuration)

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_10) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_10 + var_49_18 and arg_46_1.time_ < var_49_10 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play304081012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 304081012
		arg_50_1.duration_ = 7.13

		local var_50_0 = {
			zh = 5.8,
			ja = 7.133
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
				arg_50_0:Play304081013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10045ui_story = arg_50_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10045ui_story, Vector3.New(-0.7, -1.18, -6.05), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10045ui_story"].transform.position).z)
				arg_50_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["10045ui_story"].transform.localEulerAngles = arg_50_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.05)
				arg_50_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10045ui_story"].transform.position).z)
				arg_50_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["10045ui_story"].transform.localEulerAngles = arg_50_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["10001_tpose"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10001_tpose = var_53_1.localPosition

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_1.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end
			end

			local var_53_3 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 then
				var_53_1.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_50_1.time_ - 0) / var_53_3)
				var_53_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_1.position).x, (manager.ui.mainCamera.transform.position - var_53_1.position).y, (manager.ui.mainCamera.transform.position - var_53_1.position).z)
				var_53_1.localEulerAngles.z = 0
				var_53_1.localEulerAngles.x = 0
				var_53_1.localEulerAngles = var_53_1.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 then
				var_53_1.localPosition = Vector3.New(0.7, -1.23, -5.8)
				var_53_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_1.position).x, (manager.ui.mainCamera.transform.position - var_53_1.position).y, (manager.ui.mainCamera.transform.position - var_53_1.position).z)
				var_53_1.localEulerAngles.z = 0
				var_53_1.localEulerAngles.x = 0
				var_53_1.localEulerAngles = var_53_1.localEulerAngles

				local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_1.gameObject, typeof(DynamicBoneHelper))

				if var_53_4 then
					var_53_4:EnableDynamicBone(true)
				end
			end

			local var_53_5 = arg_50_1.actors_["10045ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect10045ui_story == nil then
				arg_50_1.var_.characterEffect10045ui_story = var_53_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_6 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_6 and not isNil(var_53_5) then
				if arg_50_1.var_.characterEffect10045ui_story and not isNil(var_53_5) then
					arg_50_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_6 and arg_50_1.time_ < 0 + var_53_6 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect10045ui_story then
				arg_50_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_53_8 = arg_50_1.actors_["10001_tpose"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.characterEffect10001_tpose == nil then
				arg_50_1.var_.characterEffect10001_tpose = var_53_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_9 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_9 and not isNil(var_53_8) then
				if arg_50_1.var_.characterEffect10001_tpose and not isNil(var_53_8) then
					arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_50_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_9)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_9 and arg_50_1.time_ < 0 + var_53_9 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.characterEffect10001_tpose then
				arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_50_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action3_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_10 = 0
			local var_53_11 = 0.6

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_12 = arg_50_1:GetWordFromCfg(304081012)
				local var_53_13 = arg_50_1:FormatText(var_53_12.content)

				arg_50_1.text_.text = var_53_13

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_15 = 24 <= 0 and var_53_11 or var_53_11 * (utf8.len(var_53_13) / 24)

				if (24 <= 0 and var_53_11 or var_53_11 * (utf8.len(var_53_13) / 24)) > 0 and var_53_11 < var_53_15 then
					arg_50_1.talkMaxDuration = var_53_15

					if var_53_15 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_15 + var_53_10
					end
				end

				arg_50_1.text_.text = var_53_13
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081012", "story_v_out_304081.awb") ~= 0 then
					local var_53_16 = manager.audio:GetVoiceLength("story_v_out_304081", "304081012", "story_v_out_304081.awb") / 1000

					if var_53_16 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_16 + var_53_10
					end

					if var_53_12.prefab_name ~= "" and arg_50_1.actors_[var_53_12.prefab_name] ~= nil then
						local var_53_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_12.prefab_name].transform, "story_v_out_304081", "304081012", "story_v_out_304081.awb")

						arg_50_1:RecordAudio("304081012", var_53_17)
						arg_50_1:RecordAudio("304081012", var_53_17)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_304081", "304081012", "story_v_out_304081.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_304081", "304081012", "story_v_out_304081.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_18 = math.max(var_53_11, arg_50_1.talkMaxDuration)

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_18 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_10) / var_53_18

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_10 + var_53_18 and arg_50_1.time_ < var_53_10 + var_53_18 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play304081013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 304081013
		arg_54_1.duration_ = 9.03

		local var_54_0 = {
			zh = 7.4,
			ja = 9.033
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play304081014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10001_tpose"]) and arg_54_1.var_.characterEffect10001_tpose == nil then
				arg_54_1.var_.characterEffect10001_tpose = arg_54_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10001_tpose"]) then
				if arg_54_1.var_.characterEffect10001_tpose and not isNil(arg_54_1.actors_["10001_tpose"]) then
					arg_54_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10001_tpose"]) and arg_54_1.var_.characterEffect10001_tpose then
				arg_54_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_57_2 = arg_54_1.actors_["10045ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect10045ui_story == nil then
				arg_54_1.var_.characterEffect10045ui_story = var_57_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_3 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.characterEffect10045ui_story and not isNil(var_57_2) then
					arg_54_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_3)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect10045ui_story then
				arg_54_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_57_4 = 0
			local var_57_5 = 0.675

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(304081013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 27 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 27)

				if (27 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 27)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081013", "story_v_out_304081.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081013", "story_v_out_304081.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_304081", "304081013", "story_v_out_304081.awb")

						arg_54_1:RecordAudio("304081013", var_57_11)
						arg_54_1:RecordAudio("304081013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_304081", "304081013", "story_v_out_304081.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_304081", "304081013", "story_v_out_304081.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play304081014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 304081014
		arg_58_1.duration_ = 6.47

		local var_58_0 = {
			zh = 4.966,
			ja = 6.466
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
				arg_58_0:Play304081015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_2")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_61_0 = 0
			local var_61_1 = 0.5

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(304081014)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 20 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_3) / 20)

				if (20 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_3) / 20)) > 0 and var_61_1 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081014", "story_v_out_304081.awb") ~= 0 then
					local var_61_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081014", "story_v_out_304081.awb") / 1000

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end

					if var_61_2.prefab_name ~= "" and arg_58_1.actors_[var_61_2.prefab_name] ~= nil then
						local var_61_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_2.prefab_name].transform, "story_v_out_304081", "304081014", "story_v_out_304081.awb")

						arg_58_1:RecordAudio("304081014", var_61_7)
						arg_58_1:RecordAudio("304081014", var_61_7)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_304081", "304081014", "story_v_out_304081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_304081", "304081014", "story_v_out_304081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_8 and arg_58_1.time_ < var_61_0 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play304081015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 304081015
		arg_62_1.duration_ = 10.87

		local var_62_0 = {
			zh = 8.6,
			ja = 10.866
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play304081016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10045ui_story"]) and arg_62_1.var_.characterEffect10045ui_story == nil then
				arg_62_1.var_.characterEffect10045ui_story = arg_62_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10045ui_story"]) then
				if arg_62_1.var_.characterEffect10045ui_story and not isNil(arg_62_1.actors_["10045ui_story"]) then
					arg_62_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10045ui_story"]) and arg_62_1.var_.characterEffect10045ui_story then
				arg_62_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["10001_tpose"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect10001_tpose == nil then
				arg_62_1.var_.characterEffect10001_tpose = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect10001_tpose and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_62_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect10001_tpose then
				arg_62_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_62_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action3_2")
			end

			local var_65_4 = 0
			local var_65_5 = 0.65

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(304081015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 26 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 26)

				if (26 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 26)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081015", "story_v_out_304081.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081015", "story_v_out_304081.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_304081", "304081015", "story_v_out_304081.awb")

						arg_62_1:RecordAudio("304081015", var_65_11)
						arg_62_1:RecordAudio("304081015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_304081", "304081015", "story_v_out_304081.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_304081", "304081015", "story_v_out_304081.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play304081016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 304081016
		arg_66_1.duration_ = 6.6

		local var_66_0 = {
			zh = 5.133,
			ja = 6.6
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play304081017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_69_0 = 0
			local var_69_1 = 0.4

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(304081016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 16 <= 0 and var_69_1 or var_69_1 * (utf8.len(var_69_3) / 16)

				if (16 <= 0 and var_69_1 or var_69_1 * (utf8.len(var_69_3) / 16)) > 0 and var_69_1 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081016", "story_v_out_304081.awb") ~= 0 then
					local var_69_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081016", "story_v_out_304081.awb") / 1000

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end

					if var_69_2.prefab_name ~= "" and arg_66_1.actors_[var_69_2.prefab_name] ~= nil then
						local var_69_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_2.prefab_name].transform, "story_v_out_304081", "304081016", "story_v_out_304081.awb")

						arg_66_1:RecordAudio("304081016", var_69_7)
						arg_66_1:RecordAudio("304081016", var_69_7)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_304081", "304081016", "story_v_out_304081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_304081", "304081016", "story_v_out_304081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_8 and arg_66_1.time_ < var_69_0 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play304081017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304081017
		arg_70_1.duration_ = 11.47

		local var_70_0 = {
			zh = 8.1,
			ja = 11.466
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play304081018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10001_tpose"]) and arg_70_1.var_.characterEffect10001_tpose == nil then
				arg_70_1.var_.characterEffect10001_tpose = arg_70_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10001_tpose"]) then
				if arg_70_1.var_.characterEffect10001_tpose and not isNil(arg_70_1.actors_["10001_tpose"]) then
					arg_70_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10001_tpose"]) and arg_70_1.var_.characterEffect10001_tpose then
				arg_70_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["10045ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect10045ui_story == nil then
				arg_70_1.var_.characterEffect10045ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect10045ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect10045ui_story then
				arg_70_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_73_4 = 0
			local var_73_5 = 0.9

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(304081017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 36 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 36)

				if (36 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 36)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081017", "story_v_out_304081.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081017", "story_v_out_304081.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_304081", "304081017", "story_v_out_304081.awb")

						arg_70_1:RecordAudio("304081017", var_73_11)
						arg_70_1:RecordAudio("304081017", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_304081", "304081017", "story_v_out_304081.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_304081", "304081017", "story_v_out_304081.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304081018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304081018
		arg_74_1.duration_ = 7.7

		local var_74_0 = {
			zh = 4.7,
			ja = 7.7
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play304081019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_77_0 = 0
			local var_77_1 = 0.4

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(304081018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 16 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 16)

				if (16 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 16)) > 0 and var_77_1 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081018", "story_v_out_304081.awb") ~= 0 then
					local var_77_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081018", "story_v_out_304081.awb") / 1000

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end

					if var_77_2.prefab_name ~= "" and arg_74_1.actors_[var_77_2.prefab_name] ~= nil then
						local var_77_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_2.prefab_name].transform, "story_v_out_304081", "304081018", "story_v_out_304081.awb")

						arg_74_1:RecordAudio("304081018", var_77_7)
						arg_74_1:RecordAudio("304081018", var_77_7)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304081", "304081018", "story_v_out_304081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304081", "304081018", "story_v_out_304081.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304081019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 304081019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play304081020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10045ui_story = arg_78_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10045ui_story"].transform.position).z)
				arg_78_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["10045ui_story"].transform.localEulerAngles = arg_78_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10045ui_story"].transform.position).z)
				arg_78_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["10045ui_story"].transform.localEulerAngles = arg_78_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["10001_tpose"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10001_tpose = var_81_1.localPosition

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_1.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end
			end

			local var_81_3 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_3)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0, 100, 0)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles

				local var_81_4 = GameObjectTools.GetOrAddComponent(var_81_1.gameObject, typeof(DynamicBoneHelper))

				if var_81_4 then
					var_81_4:EnableDynamicBone(true)
				end
			end

			local var_81_5 = arg_78_1.actors_["10001_tpose"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect10001_tpose == nil then
				arg_78_1.var_.characterEffect10001_tpose = var_81_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_6 and not isNil(var_81_5) then
				if arg_78_1.var_.characterEffect10001_tpose and not isNil(var_81_5) then
					arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_78_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_6)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_6 and arg_78_1.time_ < 0 + var_81_6 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect10001_tpose then
				arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_78_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_81_7 = 0
			local var_81_8 = 1.05

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_7 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(304081019).content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 42 <= 0 and var_81_8 or var_81_8 * (utf8.len(var_81_9) / 42)

				if (42 <= 0 and var_81_8 or var_81_8 * (utf8.len(var_81_9) / 42)) > 0 and var_81_8 < var_81_11 then
					arg_78_1.talkMaxDuration = var_81_11

					if var_81_11 + var_81_7 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_7
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_8, arg_78_1.talkMaxDuration)

			if var_81_7 <= arg_78_1.time_ and arg_78_1.time_ < var_81_7 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_7) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_7 + var_81_12 and arg_78_1.time_ < var_81_7 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play304081020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 304081020
		arg_82_1.duration_ = 13.9

		local var_82_0 = {
			zh = 9.633,
			ja = 13.9
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play304081021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10001_tpose = arg_82_1.actors_["10001_tpose"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["10001_tpose"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10001_tpose"].transform.position).z)
				arg_82_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["10001_tpose"].transform.localEulerAngles = arg_82_1.actors_["10001_tpose"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["10001_tpose"].transform.localPosition = Vector3.New(0.7, -1.23, -5.8)
				arg_82_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10001_tpose"].transform.position).z)
				arg_82_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["10001_tpose"].transform.localEulerAngles = arg_82_1.actors_["10001_tpose"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["10001_tpose"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect10001_tpose == nil then
				arg_82_1.var_.characterEffect10001_tpose = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect10001_tpose and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect10001_tpose then
				arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action445")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_85_6 = 0
			local var_85_7 = 0.975

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(304081020)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 39 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 39)

				if (39 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 39)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081020", "story_v_out_304081.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_304081", "304081020", "story_v_out_304081.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_304081", "304081020", "story_v_out_304081.awb")

						arg_82_1:RecordAudio("304081020", var_85_13)
						arg_82_1:RecordAudio("304081020", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_304081", "304081020", "story_v_out_304081.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_304081", "304081020", "story_v_out_304081.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play304081021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 304081021
		arg_86_1.duration_ = 7.7

		local var_86_0 = {
			zh = 7.333,
			ja = 7.7
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
				arg_86_0:Play304081022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10045ui_story = arg_86_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10045ui_story, Vector3.New(-0.7, -1.18, -6.05), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10045ui_story"].transform.position).z)
				arg_86_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10045ui_story"].transform.localEulerAngles = arg_86_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.05)
				arg_86_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10045ui_story"].transform.position).z)
				arg_86_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10045ui_story"].transform.localEulerAngles = arg_86_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["10045ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect10045ui_story == nil then
				arg_86_1.var_.characterEffect10045ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect10045ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect10045ui_story then
				arg_86_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["10001_tpose"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10001_tpose == nil then
				arg_86_1.var_.characterEffect10001_tpose = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_5 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 and not isNil(var_89_4) then
				if arg_86_1.var_.characterEffect10001_tpose and not isNil(var_89_4) then
					arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_86_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_5)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10001_tpose then
				arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_86_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action4_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_6 = 0
			local var_89_7 = 0.65

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(304081021)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 26 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 26)

				if (26 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 26)) > 0 and var_89_7 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081021", "story_v_out_304081.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_304081", "304081021", "story_v_out_304081.awb") / 1000

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end

					if var_89_8.prefab_name ~= "" and arg_86_1.actors_[var_89_8.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_8.prefab_name].transform, "story_v_out_304081", "304081021", "story_v_out_304081.awb")

						arg_86_1:RecordAudio("304081021", var_89_13)
						arg_86_1:RecordAudio("304081021", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_304081", "304081021", "story_v_out_304081.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_304081", "304081021", "story_v_out_304081.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play304081022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304081022
		arg_90_1.duration_ = 8.6

		local var_90_0 = {
			zh = 5.7,
			ja = 8.6
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304081023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10001_tpose"]) and arg_90_1.var_.characterEffect10001_tpose == nil then
				arg_90_1.var_.characterEffect10001_tpose = arg_90_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10001_tpose"]) then
				if arg_90_1.var_.characterEffect10001_tpose and not isNil(arg_90_1.actors_["10001_tpose"]) then
					arg_90_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10001_tpose"]) and arg_90_1.var_.characterEffect10001_tpose then
				arg_90_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["10045ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect10045ui_story == nil then
				arg_90_1.var_.characterEffect10045ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect10045ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect10045ui_story then
				arg_90_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_93_4 = 0
			local var_93_5 = 0.575

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(304081022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 23 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 23)

				if (23 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 23)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081022", "story_v_out_304081.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081022", "story_v_out_304081.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_304081", "304081022", "story_v_out_304081.awb")

						arg_90_1:RecordAudio("304081022", var_93_11)
						arg_90_1:RecordAudio("304081022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_304081", "304081022", "story_v_out_304081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_304081", "304081022", "story_v_out_304081.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304081023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304081023
		arg_94_1.duration_ = 11.7

		local var_94_0 = {
			zh = 9.066,
			ja = 11.7
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
				arg_94_0:Play304081024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_97_0 = 0
			local var_97_1 = 0.8

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(304081023)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 32 <= 0 and var_97_1 or var_97_1 * (utf8.len(var_97_3) / 32)

				if (32 <= 0 and var_97_1 or var_97_1 * (utf8.len(var_97_3) / 32)) > 0 and var_97_1 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081023", "story_v_out_304081.awb") ~= 0 then
					local var_97_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081023", "story_v_out_304081.awb") / 1000

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end

					if var_97_2.prefab_name ~= "" and arg_94_1.actors_[var_97_2.prefab_name] ~= nil then
						local var_97_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_2.prefab_name].transform, "story_v_out_304081", "304081023", "story_v_out_304081.awb")

						arg_94_1:RecordAudio("304081023", var_97_7)
						arg_94_1:RecordAudio("304081023", var_97_7)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304081", "304081023", "story_v_out_304081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304081", "304081023", "story_v_out_304081.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play304081024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304081024
		arg_98_1.duration_ = 3.4

		local var_98_0 = {
			zh = 2.966,
			ja = 3.4
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
				arg_98_0:Play304081025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["10045ui_story"]) and arg_98_1.var_.characterEffect10045ui_story == nil then
				arg_98_1.var_.characterEffect10045ui_story = arg_98_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["10045ui_story"]) then
				if arg_98_1.var_.characterEffect10045ui_story and not isNil(arg_98_1.actors_["10045ui_story"]) then
					arg_98_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["10045ui_story"]) and arg_98_1.var_.characterEffect10045ui_story then
				arg_98_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["10001_tpose"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10001_tpose == nil then
				arg_98_1.var_.characterEffect10001_tpose = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect10001_tpose and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_98_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10001_tpose then
				arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_98_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045actionlink/10045action442")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_101_4 = 0
			local var_101_5 = 0.125

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(304081024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 5 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 5)

				if (5 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 5)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081024", "story_v_out_304081.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081024", "story_v_out_304081.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_304081", "304081024", "story_v_out_304081.awb")

						arg_98_1:RecordAudio("304081024", var_101_11)
						arg_98_1:RecordAudio("304081024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304081", "304081024", "story_v_out_304081.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304081", "304081024", "story_v_out_304081.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play304081025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 304081025
		arg_102_1.duration_ = 8.97

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play304081026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_9002
			local var_105_9001
			local var_105_9000

			if arg_102_1.bgs_.S0102 == nil then
				local var_105_0 = Object.Instantiate(arg_102_1.paintGo_)

				var_105_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0102")
				var_105_0.name = "S0102"
				var_105_0.transform.parent = arg_102_1.stage_.transform
				var_105_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.bgs_.S0102 = var_105_0
			end

			if 1.63333333333333 < arg_102_1.time_ and arg_102_1.time_ <= 1.63333333333333 + arg_105_0 then
				local var_105_1 = arg_102_1.bgs_.S0102

				arg_102_1.bgs_.S0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_105_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_2 = var_105_1:GetComponent("SpriteRenderer")

				if var_105_2 and var_105_2.sprite then
					local var_105_3 = 2 * (var_105_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_105_1.transform.localScale = Vector3.New(var_105_3 / var_105_2.sprite.bounds.size.y < var_105_3 * manager.ui.mainCameraCom_.aspect / var_105_2.sprite.bounds.size.x and var_105_3 * manager.ui.mainCameraCom_.aspect / var_105_2.sprite.bounds.size.x or var_105_3 / var_105_2.sprite.bounds.size.y, var_105_3 / var_105_2.sprite.bounds.size.y < var_105_3 * manager.ui.mainCameraCom_.aspect / var_105_2.sprite.bounds.size.x and var_105_3 * manager.ui.mainCameraCom_.aspect / var_105_2.sprite.bounds.size.x or var_105_3 / var_105_2.sprite.bounds.size.y, 0)
				end

				for iter_105_0, iter_105_1 in pairs(arg_102_1.bgs_) do
					if iter_105_0 ~= "S0102" then
						iter_105_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_4 = 1.66666666666667

			if 1.66666666666667 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			if arg_102_1.time_ >= var_105_4 + 0.3 and arg_102_1.time_ < var_105_4 + 0.3 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			local var_105_5 = 2.33333333333333

			if 2.33333333333333 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_6 = 0.233333333333333

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 then
				local var_105_7 = Color.New(1, 1, 1)

				var_105_7.a = Mathf.Lerp(1, 0, (arg_102_1.time_ - var_105_5) / var_105_6)
				arg_102_1.mask_.color = var_105_7
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 then
				local var_105_8 = Color.New(1, 1, 1)

				arg_102_1.mask_.enabled = false
				var_105_8.a = 0
				arg_102_1.mask_.color = var_105_8
			end

			local var_105_9 = 2.73333333333333

			if 2.73333333333333 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_10 = 0.233333333333333

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_10 then
				local var_105_11 = Color.New(1, 1, 1)

				var_105_11.a = Mathf.Lerp(1, 0, (arg_102_1.time_ - var_105_9) / var_105_10)
				arg_102_1.mask_.color = var_105_11
			end

			if arg_102_1.time_ >= var_105_9 + var_105_10 and arg_102_1.time_ < var_105_9 + var_105_10 + arg_105_0 then
				local var_105_12 = Color.New(1, 1, 1)

				arg_102_1.mask_.enabled = false
				var_105_12.a = 0
				arg_102_1.mask_.color = var_105_12
			end

			local var_105_13 = 0

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_14 = 1.66666666666667

			if var_105_13 <= arg_102_1.time_ and arg_102_1.time_ < var_105_13 + var_105_14 then
				local var_105_15 = Color.New(0, 0, 0)

				var_105_15.a = Mathf.Lerp(0, 1, (arg_102_1.time_ - var_105_13) / var_105_14)
				arg_102_1.mask_.color = var_105_15
			end

			if arg_102_1.time_ >= var_105_13 + var_105_14 and arg_102_1.time_ < var_105_13 + var_105_14 + arg_105_0 then
				local var_105_16 = Color.New(0, 0, 0)

				var_105_16.a = 1
				arg_102_1.mask_.color = var_105_16
			end

			local var_105_17 = 1.66666666666667

			if 1.66666666666667 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_18 = 0.666666666666667

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_18 then
				local var_105_19 = Color.New(0, 0, 0)

				var_105_19.a = Mathf.Lerp(1, 0, (arg_102_1.time_ - var_105_17) / var_105_18)
				arg_102_1.mask_.color = var_105_19
			end

			if arg_102_1.time_ >= var_105_17 + var_105_18 and arg_102_1.time_ < var_105_17 + var_105_18 + arg_105_0 then
				local var_105_20 = Color.New(0, 0, 0)

				arg_102_1.mask_.enabled = false
				var_105_20.a = 0
				arg_102_1.mask_.color = var_105_20
			end

			local var_105_21 = arg_102_1.actors_["10045ui_story"].transform

			if 1.66666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 1.66666666666667 + arg_105_0 then
				arg_102_1.var_.moveOldPos10045ui_story = var_105_21.localPosition
			end

			local var_105_22 = 0.001

			if 1.66666666666667 <= arg_102_1.time_ and arg_102_1.time_ < 1.66666666666667 + var_105_22 then
				var_105_21.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 1.66666666666667) / var_105_22)
				var_105_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_21.position).x, (manager.ui.mainCamera.transform.position - var_105_21.position).y, (manager.ui.mainCamera.transform.position - var_105_21.position).z)
				var_105_21.localEulerAngles.z = 0
				var_105_21.localEulerAngles.x = 0
				var_105_21.localEulerAngles = var_105_21.localEulerAngles
			end

			if arg_102_1.time_ >= 1.66666666666667 + var_105_22 and arg_102_1.time_ < 1.66666666666667 + var_105_22 + arg_105_0 then
				var_105_21.localPosition = Vector3.New(0, 100, 0)
				var_105_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_21.position).x, (manager.ui.mainCamera.transform.position - var_105_21.position).y, (manager.ui.mainCamera.transform.position - var_105_21.position).z)
				var_105_21.localEulerAngles.z = 0
				var_105_21.localEulerAngles.x = 0
				var_105_21.localEulerAngles = var_105_21.localEulerAngles
			end

			local var_105_23 = arg_102_1.actors_["10001_tpose"].transform

			if 1.66666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 1.66666666666667 + arg_105_0 then
				arg_102_1.var_.moveOldPos10001_tpose = var_105_23.localPosition

				local var_105_24 = GameObjectTools.GetOrAddComponent(var_105_23.gameObject, typeof(DynamicBoneHelper))

				if var_105_24 then
					var_105_24:EnableDynamicBone(false)
				end
			end

			local var_105_25 = 0.001

			if 1.66666666666667 <= arg_102_1.time_ and arg_102_1.time_ < 1.66666666666667 + var_105_25 then
				var_105_23.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_102_1.time_ - 1.66666666666667) / var_105_25)
				var_105_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_23.position).x, (manager.ui.mainCamera.transform.position - var_105_23.position).y, (manager.ui.mainCamera.transform.position - var_105_23.position).z)
				var_105_23.localEulerAngles.z = 0
				var_105_23.localEulerAngles.x = 0
				var_105_23.localEulerAngles = var_105_23.localEulerAngles
			end

			if arg_102_1.time_ >= 1.66666666666667 + var_105_25 and arg_102_1.time_ < 1.66666666666667 + var_105_25 + arg_105_0 then
				var_105_23.localPosition = Vector3.New(0, 100, 0)
				var_105_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_23.position).x, (manager.ui.mainCamera.transform.position - var_105_23.position).y, (manager.ui.mainCamera.transform.position - var_105_23.position).z)
				var_105_23.localEulerAngles.z = 0
				var_105_23.localEulerAngles.x = 0
				var_105_23.localEulerAngles = var_105_23.localEulerAngles

				local var_105_26 = GameObjectTools.GetOrAddComponent(var_105_23.gameObject, typeof(DynamicBoneHelper))

				if var_105_26 then
					var_105_26:EnableDynamicBone(true)
				end
			end

			local var_105_27 = arg_102_1.actors_["10045ui_story"]

			if 1.66666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 1.66666666666667 + arg_105_0 and not isNil(var_105_27) and arg_102_1.var_.characterEffect10045ui_story == nil then
				arg_102_1.var_.characterEffect10045ui_story = var_105_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_28 = 0.200000002980232

			if 1.66666666666667 <= arg_102_1.time_ and arg_102_1.time_ < 1.66666666666667 + var_105_28 and not isNil(var_105_27) then
				if arg_102_1.var_.characterEffect10045ui_story and not isNil(var_105_27) then
					arg_102_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 1.66666666666667) / var_105_28)
				end
			end

			if arg_102_1.time_ >= 1.66666666666667 + var_105_28 and arg_102_1.time_ < 1.66666666666667 + var_105_28 + arg_105_0 and not isNil(var_105_27) and arg_102_1.var_.characterEffect10045ui_story then
				arg_102_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_105_29 = arg_102_1.bgs_.S0102.transform

			if 1.66666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 1.66666666666667 + arg_105_0 then
				arg_102_1.var_.moveOldPosS0102 = var_105_29.localPosition
			end

			local var_105_30 = 2.3

			if 1.66666666666667 <= arg_102_1.time_ and arg_102_1.time_ < 1.66666666666667 + var_105_30 then
				var_105_29.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPosS0102, Vector3.New(0, 1.09, 9), (arg_102_1.time_ - 1.66666666666667) / var_105_30)
			end

			if arg_102_1.time_ >= 1.66666666666667 + var_105_30 and arg_102_1.time_ < 1.66666666666667 + var_105_30 + arg_105_0 then
				var_105_29.localPosition = Vector3.New(0, 1.09, 9)
			end

			if 2.96666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 2.96666666666667 + arg_105_0 then
				local var_105_31 = arg_102_1.var_.effectqweer

				if not arg_102_1.var_.effectqweer then
					var_105_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), manager.ui.mainCamera.transform)
					var_105_31.name = "qweer"
					arg_102_1.var_.effectqweer = var_105_31
				else
					var_105_31.transform:SetParent(var_105_9002)
				end

				var_105_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_105_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_105_31.transform.localScale = Vector3.New(var_105_31.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_105_31.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_105_31.transform.localScale.z)
			end

			if 4.86489579901099 < arg_102_1.time_ and arg_102_1.time_ <= 4.86489579901099 + arg_105_0 then
				local var_105_33 = arg_102_1.var_.effect43344

				if not arg_102_1.var_.effect43344 then
					var_105_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao2_end"), manager.ui.mainCamera.transform)
					var_105_33.name = "43344"
					arg_102_1.var_.effect43344 = var_105_33
				else
					var_105_33.transform:SetParent(var_105_9001)
				end

				var_105_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_105_33.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 6.46666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 6.46666666666667 + arg_105_0 then
				if arg_102_1.var_.effect43344 then
					Object.Destroy(arg_102_1.var_.effect43344)

					arg_102_1.var_.effect43344 = nil
				end
			end

			if 2.09822913234433 < arg_102_1.time_ and arg_102_1.time_ <= 2.09822913234433 + arg_105_0 then
				local var_105_36 = arg_102_1.var_.effect43344111

				if not arg_102_1.var_.effect43344111 then
					var_105_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao2_start"), manager.ui.mainCamera.transform)
					var_105_36.name = "43344111"
					arg_102_1.var_.effect43344111 = var_105_36
				else
					var_105_36.transform:SetParent(var_105_9000)
				end

				var_105_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_105_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.86489579901099 < arg_102_1.time_ and arg_102_1.time_ <= 4.86489579901099 + arg_105_0 then
				if arg_102_1.var_.effect43344111 then
					Object.Destroy(arg_102_1.var_.effect43344111)

					arg_102_1.var_.effect43344111 = nil
				end
			end

			if 0.4 < arg_102_1.time_ and arg_102_1.time_ <= 0.4 + arg_105_0 then
				arg_102_1:AudioAction("play", "effect", "se_story_152", "se_story_152_clap", "")
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_40 = 3.96666666666667
			local var_105_41 = 1.125

			if 3.96666666666667 < arg_102_1.time_ and arg_102_1.time_ <= var_105_40 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_42 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_42:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_43 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(304081025).content)

				arg_102_1.text_.text = var_105_43

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_45 = 45 <= 0 and var_105_41 or var_105_41 * (utf8.len(var_105_43) / 45)

				if (45 <= 0 and var_105_41 or var_105_41 * (utf8.len(var_105_43) / 45)) > 0 and var_105_41 < var_105_45 then
					arg_102_1.talkMaxDuration = var_105_45
					var_105_40 = var_105_40 + 0.3

					if var_105_45 + var_105_40 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_45 + var_105_40
					end
				end

				arg_102_1.text_.text = var_105_43
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_46 = var_105_40 + 0.3
			local var_105_47 = math.max(var_105_41, arg_102_1.talkMaxDuration)

			if var_105_40 + 0.3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_46 + var_105_47 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_46) / var_105_47

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_46 + var_105_47 and arg_102_1.time_ < var_105_46 + var_105_47 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0102",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.3,
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 6.23),
					endPos = Vector3.New(0, 1.09, 9),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play304081026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304081026
		arg_108_1.duration_ = 6.63

		local var_108_0 = {
			zh = 5,
			ja = 6.633
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
				arg_108_0:Play304081027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.425

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(304081026)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 17 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 17)

				if (17 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 17)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081026", "story_v_out_304081.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081026", "story_v_out_304081.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_304081", "304081026", "story_v_out_304081.awb")

						arg_108_1:RecordAudio("304081026", var_111_6)
						arg_108_1:RecordAudio("304081026", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304081", "304081026", "story_v_out_304081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304081", "304081026", "story_v_out_304081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play304081027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 304081027
		arg_112_1.duration_ = 10.9

		local var_112_0 = {
			zh = 5.933,
			ja = 10.9
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play304081028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.65

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:GetWordFromCfg(304081027)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 26 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 26)

				if (26 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 26)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081027", "story_v_out_304081.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081027", "story_v_out_304081.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_304081", "304081027", "story_v_out_304081.awb")

						arg_112_1:RecordAudio("304081027", var_115_6)
						arg_112_1:RecordAudio("304081027", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_304081", "304081027", "story_v_out_304081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_304081", "304081027", "story_v_out_304081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play304081028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 304081028
		arg_116_1.duration_ = 9.5

		local var_116_0 = {
			zh = 9.5,
			ja = 7.733
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play304081029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.825

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:GetWordFromCfg(304081028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 33 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 33)

				if (33 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 33)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081028", "story_v_out_304081.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081028", "story_v_out_304081.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_304081", "304081028", "story_v_out_304081.awb")

						arg_116_1:RecordAudio("304081028", var_119_6)
						arg_116_1:RecordAudio("304081028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_304081", "304081028", "story_v_out_304081.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_304081", "304081028", "story_v_out_304081.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play304081029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304081029
		arg_120_1.duration_ = 5.7

		local var_120_0 = {
			zh = 5.366,
			ja = 5.7
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play304081030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.4

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:GetWordFromCfg(304081029)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 16 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 16)

				if (16 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 16)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081029", "story_v_out_304081.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081029", "story_v_out_304081.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_304081", "304081029", "story_v_out_304081.awb")

						arg_120_1:RecordAudio("304081029", var_123_6)
						arg_120_1:RecordAudio("304081029", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_304081", "304081029", "story_v_out_304081.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_304081", "304081029", "story_v_out_304081.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play304081030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 304081030
		arg_124_1.duration_ = 13.2

		local var_124_0 = {
			zh = 9.466,
			ja = 13.2
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play304081031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.2

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(304081030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 48 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 48)

				if (48 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 48)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081030", "story_v_out_304081.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081030", "story_v_out_304081.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_304081", "304081030", "story_v_out_304081.awb")

						arg_124_1:RecordAudio("304081030", var_127_6)
						arg_124_1:RecordAudio("304081030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_304081", "304081030", "story_v_out_304081.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_304081", "304081030", "story_v_out_304081.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play304081031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304081031
		arg_128_1.duration_ = 9.17

		local var_128_0 = {
			zh = 5.8,
			ja = 9.166
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play304081032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.9

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(304081031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 36 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 36)

				if (36 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 36)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081031", "story_v_out_304081.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081031", "story_v_out_304081.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_304081", "304081031", "story_v_out_304081.awb")

						arg_128_1:RecordAudio("304081031", var_131_6)
						arg_128_1:RecordAudio("304081031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304081", "304081031", "story_v_out_304081.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304081", "304081031", "story_v_out_304081.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play304081032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 304081032
		arg_132_1.duration_ = 10.93

		local var_132_0 = {
			zh = 7.2,
			ja = 10.933
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play304081033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.7

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_1 = arg_132_1:GetWordFromCfg(304081032)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 28 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 28)

				if (28 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 28)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081032", "story_v_out_304081.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081032", "story_v_out_304081.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_304081", "304081032", "story_v_out_304081.awb")

						arg_132_1:RecordAudio("304081032", var_135_6)
						arg_132_1:RecordAudio("304081032", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_304081", "304081032", "story_v_out_304081.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_304081", "304081032", "story_v_out_304081.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play304081033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 304081033
		arg_136_1.duration_ = 10.1

		local var_136_0 = {
			zh = 8.9,
			ja = 10.1
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play304081034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.725

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(304081033)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 29 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 29)

				if (29 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 29)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081033", "story_v_out_304081.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081033", "story_v_out_304081.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_304081", "304081033", "story_v_out_304081.awb")

						arg_136_1:RecordAudio("304081033", var_139_6)
						arg_136_1:RecordAudio("304081033", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_304081", "304081033", "story_v_out_304081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_304081", "304081033", "story_v_out_304081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play304081034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 304081034
		arg_140_1.duration_ = 3.67

		local var_140_0 = {
			zh = 3.666,
			ja = 1.333
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play304081035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["2018ui_story"]) and arg_140_1.var_.characterEffect2018ui_story == nil then
				arg_140_1.var_.characterEffect2018ui_story = arg_140_1.actors_["2018ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["2018ui_story"]) then
				if arg_140_1.var_.characterEffect2018ui_story and not isNil(arg_140_1.actors_["2018ui_story"]) then
					arg_140_1.var_.characterEffect2018ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["2018ui_story"]) and arg_140_1.var_.characterEffect2018ui_story then
				arg_140_1.var_.characterEffect2018ui_story.fillFlat = false
			end

			local var_143_2 = arg_140_1.actors_["10045ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect10045ui_story == nil then
				arg_140_1.var_.characterEffect10045ui_story = var_143_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_3 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.characterEffect10045ui_story and not isNil(var_143_2) then
					arg_140_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_3)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect10045ui_story then
				arg_140_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_143_4 = 0
			local var_143_5 = 0.35

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2018")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_6 = arg_140_1:GetWordFromCfg(304081034)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 14 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 14)

				if (14 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 14)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081034", "story_v_out_304081.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081034", "story_v_out_304081.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_304081", "304081034", "story_v_out_304081.awb")

						arg_140_1:RecordAudio("304081034", var_143_11)
						arg_140_1:RecordAudio("304081034", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_304081", "304081034", "story_v_out_304081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_304081", "304081034", "story_v_out_304081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play304081035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 304081035
		arg_144_1.duration_ = 8.8

		local var_144_0 = {
			zh = 7.666,
			ja = 8.8
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play304081036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_9000

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPosS0102 = arg_144_1.bgs_.S0102.transform.localPosition
			end

			local var_147_0 = 2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.bgs_.S0102.transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPosS0102, Vector3.New(0, 2.11, 4.58), (arg_144_1.time_ - 0) / var_147_0)
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.bgs_.S0102.transform.localPosition = Vector3.New(0, 2.11, 4.58)
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				local var_147_1 = arg_144_1.var_.effect32131111

				if not arg_144_1.var_.effect32131111 then
					var_147_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_147_1.name = "32131111"
					arg_144_1.var_.effect32131111 = var_147_1
				else
					var_147_1.transform:SetParent(var_147_9000)
				end

				var_147_1.transform.localPosition = Vector3.New(0, 0, -2.91)
				var_147_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_147_1.transform.localScale = Vector3.New(var_147_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_147_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_147_1.transform.localScale.z)
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				if arg_144_1.var_.effectqweer then
					Object.Destroy(arg_144_1.var_.effectqweer)

					arg_144_1.var_.effectqweer = nil
				end
			end

			local var_147_4 = 0

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = false

				arg_144_1:SetGaussion(false)
			end

			local var_147_5 = 0.333333333333333

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_5 then
				local var_147_6 = Color.New(1, 1, 1)

				var_147_6.a = Mathf.Lerp(1, 0, (arg_144_1.time_ - var_147_4) / var_147_5)
				arg_144_1.mask_.color = var_147_6
			end

			if arg_144_1.time_ >= var_147_4 + var_147_5 and arg_144_1.time_ < var_147_4 + var_147_5 + arg_147_0 then
				local var_147_7 = Color.New(1, 1, 1)

				arg_144_1.mask_.enabled = false
				var_147_7.a = 0
				arg_144_1.mask_.color = var_147_7
			end

			local var_147_8 = 0

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			if arg_144_1.time_ >= var_147_8 + 2.25 and arg_144_1.time_ < var_147_8 + 2.25 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_9 = 1.7
			local var_147_10 = 0.55

			if 1.7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_11 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_11:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_12 = arg_144_1:GetWordFromCfg(304081035)
				local var_147_13 = arg_144_1:FormatText(var_147_12.content)

				arg_144_1.text_.text = var_147_13

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 22 <= 0 and var_147_10 or var_147_10 * (utf8.len(var_147_13) / 22)

				if (22 <= 0 and var_147_10 or var_147_10 * (utf8.len(var_147_13) / 22)) > 0 and var_147_10 < var_147_15 then
					arg_144_1.talkMaxDuration = var_147_15
					var_147_9 = var_147_9 + 0.3

					if var_147_15 + var_147_9 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_15 + var_147_9
					end
				end

				arg_144_1.text_.text = var_147_13
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081035", "story_v_out_304081.awb") ~= 0 then
					local var_147_16 = manager.audio:GetVoiceLength("story_v_out_304081", "304081035", "story_v_out_304081.awb") / 1000

					if var_147_16 + var_147_9 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_9
					end

					if var_147_12.prefab_name ~= "" and arg_144_1.actors_[var_147_12.prefab_name] ~= nil then
						local var_147_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_12.prefab_name].transform, "story_v_out_304081", "304081035", "story_v_out_304081.awb")

						arg_144_1:RecordAudio("304081035", var_147_17)
						arg_144_1:RecordAudio("304081035", var_147_17)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_304081", "304081035", "story_v_out_304081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_304081", "304081035", "story_v_out_304081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_18 = var_147_9 + 0.3
			local var_147_19 = math.max(var_147_10, arg_144_1.talkMaxDuration)

			if var_147_9 + 0.3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_18 + var_147_19 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_18) / var_147_19

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_18 + var_147_19 and arg_144_1.time_ < var_147_18 + var_147_19 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0102",
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
					startPos = Vector3.New(0, 1.09, 9),
					endPos = Vector3.New(0, 2.11, 4.58),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play304081036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 304081036
		arg_150_1.duration_ = 7.4

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play304081037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_9000

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10045ui_story = arg_150_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10045ui_story"].transform.position).z)
				arg_150_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10045ui_story"].transform.localEulerAngles = arg_150_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10045ui_story"].transform.position).z)
				arg_150_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10045ui_story"].transform.localEulerAngles = arg_150_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["10001_tpose"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10001_tpose = var_153_1.localPosition

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_1.gameObject, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end
			end

			local var_153_3 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 then
				var_153_1.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_3)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 then
				var_153_1.localPosition = Vector3.New(0, 100, 0)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles

				local var_153_4 = GameObjectTools.GetOrAddComponent(var_153_1.gameObject, typeof(DynamicBoneHelper))

				if var_153_4 then
					var_153_4:EnableDynamicBone(true)
				end
			end

			local var_153_5 = arg_150_1.actors_["10001_tpose"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect10001_tpose == nil then
				arg_150_1.var_.characterEffect10001_tpose = var_153_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 and not isNil(var_153_5) then
				if arg_150_1.var_.characterEffect10001_tpose and not isNil(var_153_5) then
					arg_150_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_150_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_6)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect10001_tpose then
				arg_150_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_150_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 1.26666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.26666666666667 + arg_153_0 then
				if arg_150_1.var_.effect32131111 then
					Object.Destroy(arg_150_1.var_.effect32131111)

					arg_150_1.var_.effect32131111 = nil
				end
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				local var_153_8 = arg_150_1.var_.effectdddff

				if not arg_150_1.var_.effectdddff then
					var_153_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_glowmaskline_black"), manager.ui.mainCamera.transform)
					var_153_8.name = "dddff"
					arg_150_1.var_.effectdddff = var_153_8
				else
					var_153_8.transform:SetParent(var_153_9000)
				end

				var_153_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_153_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_153_8.transform.localScale = Vector3.New(var_153_8.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_153_8.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_153_8.transform.localScale.z)
			end

			local var_153_10 = "STblack"

			if arg_150_1.bgs_.STblack == nil then
				local var_153_11 = Object.Instantiate(arg_150_1.paintGo_)

				var_153_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_153_10)
				var_153_11.name = var_153_10
				var_153_11.transform.parent = arg_150_1.stage_.transform
				var_153_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.bgs_[var_153_10] = var_153_11
			end

			if 1.61386819602922 < arg_150_1.time_ and arg_150_1.time_ <= 1.61386819602922 + arg_153_0 then
				local var_153_12 = arg_150_1.bgs_.STblack

				arg_150_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_153_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_13 = var_153_12:GetComponent("SpriteRenderer")

				if var_153_13 and var_153_13.sprite then
					local var_153_14 = 2 * (var_153_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_153_12.transform.localScale = Vector3.New(var_153_14 / var_153_13.sprite.bounds.size.y < var_153_14 * manager.ui.mainCameraCom_.aspect / var_153_13.sprite.bounds.size.x and var_153_14 * manager.ui.mainCameraCom_.aspect / var_153_13.sprite.bounds.size.x or var_153_14 / var_153_13.sprite.bounds.size.y, var_153_14 / var_153_13.sprite.bounds.size.y < var_153_14 * manager.ui.mainCameraCom_.aspect / var_153_13.sprite.bounds.size.x and var_153_14 * manager.ui.mainCameraCom_.aspect / var_153_13.sprite.bounds.size.x or var_153_14 / var_153_13.sprite.bounds.size.y, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "STblack" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_15 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			if arg_150_1.time_ >= var_153_15 + 2.66666666666667 and arg_150_1.time_ < var_153_15 + 2.66666666666667 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_16 = 2.4
			local var_153_17 = 0.95

			if 2.4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_18 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_18:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_19 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(304081036).content)

				arg_150_1.text_.text = var_153_19

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_21 = 38 <= 0 and var_153_17 or var_153_17 * (utf8.len(var_153_19) / 38)

				if (38 <= 0 and var_153_17 or var_153_17 * (utf8.len(var_153_19) / 38)) > 0 and var_153_17 < var_153_21 then
					arg_150_1.talkMaxDuration = var_153_21
					var_153_16 = var_153_16 + 0.3

					if var_153_21 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_21 + var_153_16
					end
				end

				arg_150_1.text_.text = var_153_19
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = var_153_16 + 0.3
			local var_153_23 = math.max(var_153_17, arg_150_1.talkMaxDuration)

			if var_153_16 + 0.3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_22 + var_153_23 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_22) / var_153_23

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_22 + var_153_23 and arg_150_1.time_ < var_153_22 + var_153_23 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play304081037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 304081037
		arg_156_1.duration_ = 19.3

		local var_156_0 = {
			zh = 19.3,
			ja = 19.066
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play304081038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10045ui_story = arg_156_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10045ui_story, Vector3.New(0, -1.18, -6.05), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10045ui_story"].transform.position).z)
				arg_156_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10045ui_story"].transform.localEulerAngles = arg_156_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.05)
				arg_156_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10045ui_story"].transform.position).z)
				arg_156_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10045ui_story"].transform.localEulerAngles = arg_156_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["10045ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect10045ui_story == nil then
				arg_156_1.var_.characterEffect10045ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect10045ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect10045ui_story then
				arg_156_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_159_4 = 0
			local var_159_5 = 1.65

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(304081037)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 66 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 66)

				if (66 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 66)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081037", "story_v_out_304081.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081037", "story_v_out_304081.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_out_304081", "304081037", "story_v_out_304081.awb")

						arg_156_1:RecordAudio("304081037", var_159_11)
						arg_156_1:RecordAudio("304081037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_304081", "304081037", "story_v_out_304081.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_304081", "304081037", "story_v_out_304081.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play304081038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 304081038
		arg_160_1.duration_ = 9.4

		local var_160_0 = {
			zh = 9.4,
			ja = 7.833
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
				arg_160_0:Play304081039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.65

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(304081038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 26 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 26)

				if (26 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 26)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081038", "story_v_out_304081.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081038", "story_v_out_304081.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_304081", "304081038", "story_v_out_304081.awb")

						arg_160_1:RecordAudio("304081038", var_163_6)
						arg_160_1:RecordAudio("304081038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_304081", "304081038", "story_v_out_304081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_304081", "304081038", "story_v_out_304081.awb")
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
	Play304081039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 304081039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play304081040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["10045ui_story"]) and arg_164_1.var_.characterEffect10045ui_story == nil then
				arg_164_1.var_.characterEffect10045ui_story = arg_164_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["10045ui_story"]) then
				if arg_164_1.var_.characterEffect10045ui_story and not isNil(arg_164_1.actors_["10045ui_story"]) then
					arg_164_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["10045ui_story"]) and arg_164_1.var_.characterEffect10045ui_story then
				arg_164_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_167_1 = arg_164_1.actors_["10045ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10045ui_story = var_167_1.localPosition
			end

			local var_167_2 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 then
				var_167_1.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_2)
				var_167_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_1.position).x, (manager.ui.mainCamera.transform.position - var_167_1.position).y, (manager.ui.mainCamera.transform.position - var_167_1.position).z)
				var_167_1.localEulerAngles.z = 0
				var_167_1.localEulerAngles.x = 0
				var_167_1.localEulerAngles = var_167_1.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 then
				var_167_1.localPosition = Vector3.New(0, 100, 0)
				var_167_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_1.position).x, (manager.ui.mainCamera.transform.position - var_167_1.position).y, (manager.ui.mainCamera.transform.position - var_167_1.position).z)
				var_167_1.localEulerAngles.z = 0
				var_167_1.localEulerAngles.x = 0
				var_167_1.localEulerAngles = var_167_1.localEulerAngles
			end

			local var_167_3 = 0
			local var_167_4 = 1.4

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_3 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_5 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(304081039).content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 56 <= 0 and var_167_4 or var_167_4 * (utf8.len(var_167_5) / 56)

				if (56 <= 0 and var_167_4 or var_167_4 * (utf8.len(var_167_5) / 56)) > 0 and var_167_4 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_3 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_3
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_4, arg_164_1.talkMaxDuration)

			if var_167_3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_3 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_3) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_3 + var_167_8 and arg_164_1.time_ < var_167_3 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play304081040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 304081040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play304081041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.45

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(304081040).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 58 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 58)

				if (58 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 58)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play304081041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 304081041
		arg_172_1.duration_ = 6.7

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play304081042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.45

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(304081041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 18 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 18)

				if (18 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 18)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081041", "story_v_out_304081.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081041", "story_v_out_304081.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_304081", "304081041", "story_v_out_304081.awb")

						arg_172_1:RecordAudio("304081041", var_175_6)
						arg_172_1:RecordAudio("304081041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_304081", "304081041", "story_v_out_304081.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_304081", "304081041", "story_v_out_304081.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play304081042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 304081042
		arg_176_1.duration_ = 8.33

		local var_176_0 = {
			zh = 8.16633333333333,
			ja = 8.33333333333333
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play304081043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if arg_176_1.bgs_.B02f == nil then
				local var_179_0 = Object.Instantiate(arg_176_1.paintGo_)

				var_179_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02f")
				var_179_0.name = "B02f"
				var_179_0.transform.parent = arg_176_1.stage_.transform
				var_179_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_176_1.bgs_.B02f = var_179_0
			end

			if 1.73333333333333 < arg_176_1.time_ and arg_176_1.time_ <= 1.73333333333333 + arg_179_0 then
				local var_179_1 = arg_176_1.bgs_.B02f

				arg_176_1.bgs_.B02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_179_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_2 = var_179_1:GetComponent("SpriteRenderer")

				if var_179_2 and var_179_2.sprite then
					local var_179_3 = 2 * (var_179_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_179_1.transform.localScale = Vector3.New(var_179_3 / var_179_2.sprite.bounds.size.y < var_179_3 * manager.ui.mainCameraCom_.aspect / var_179_2.sprite.bounds.size.x and var_179_3 * manager.ui.mainCameraCom_.aspect / var_179_2.sprite.bounds.size.x or var_179_3 / var_179_2.sprite.bounds.size.y, var_179_3 / var_179_2.sprite.bounds.size.y < var_179_3 * manager.ui.mainCameraCom_.aspect / var_179_2.sprite.bounds.size.x and var_179_3 * manager.ui.mainCameraCom_.aspect / var_179_2.sprite.bounds.size.x or var_179_3 / var_179_2.sprite.bounds.size.y, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "B02f" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_4 = 1.73333333333333

			if 1.73333333333333 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			if arg_176_1.time_ >= var_179_4 + 0.3 and arg_176_1.time_ < var_179_4 + 0.3 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end

			local var_179_5 = 0

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_6 = 1.73333333333333

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 then
				local var_179_7 = Color.New(0, 0, 0)

				var_179_7.a = Mathf.Lerp(0, 1, (arg_176_1.time_ - var_179_5) / var_179_6)
				arg_176_1.mask_.color = var_179_7
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 then
				local var_179_8 = Color.New(0, 0, 0)

				var_179_8.a = 1
				arg_176_1.mask_.color = var_179_8
			end

			local var_179_9 = 1.73333333333333

			if 1.73333333333333 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_10 = 2

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_10 then
				local var_179_11 = Color.New(0, 0, 0)

				var_179_11.a = Mathf.Lerp(1, 0, (arg_176_1.time_ - var_179_9) / var_179_10)
				arg_176_1.mask_.color = var_179_11
			end

			if arg_176_1.time_ >= var_179_9 + var_179_10 and arg_176_1.time_ < var_179_9 + var_179_10 + arg_179_0 then
				local var_179_12 = Color.New(0, 0, 0)

				arg_176_1.mask_.enabled = false
				var_179_12.a = 0
				arg_176_1.mask_.color = var_179_12
			end

			local var_179_13 = "1019ui_story"

			if arg_176_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_179_14 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_176_1.stage_.transform)

				var_179_14.name = var_179_13
				var_179_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_176_1.actors_[var_179_13] = var_179_14

				local var_179_15 = var_179_14:GetComponentInChildren(typeof(CharacterEffect))

				var_179_15.enabled = true

				local var_179_16 = GameObjectTools.GetOrAddComponent(var_179_14, typeof(DynamicBoneHelper))

				if var_179_16 then
					var_179_16:EnableDynamicBone(false)
				end

				arg_176_1:ShowWeapon(var_179_15.transform, false)

				arg_176_1.var_[var_179_13 .. "Animator"] = var_179_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_176_1.var_[var_179_13 .. "Animator"].applyRootMotion = true
				arg_176_1.var_[var_179_13 .. "LipSync"] = var_179_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_179_17 = arg_176_1.actors_["1019ui_story"].transform

			if 3.36666666666667 < arg_176_1.time_ and arg_176_1.time_ <= 3.36666666666667 + arg_179_0 then
				arg_176_1.var_.moveOldPos1019ui_story = var_179_17.localPosition
			end

			local var_179_18 = 0.001

			if 3.36666666666667 <= arg_176_1.time_ and arg_176_1.time_ < 3.36666666666667 + var_179_18 then
				var_179_17.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_176_1.time_ - 3.36666666666667) / var_179_18)
				var_179_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_17.position).x, (manager.ui.mainCamera.transform.position - var_179_17.position).y, (manager.ui.mainCamera.transform.position - var_179_17.position).z)
				var_179_17.localEulerAngles.z = 0
				var_179_17.localEulerAngles.x = 0
				var_179_17.localEulerAngles = var_179_17.localEulerAngles
			end

			if arg_176_1.time_ >= 3.36666666666667 + var_179_18 and arg_176_1.time_ < 3.36666666666667 + var_179_18 + arg_179_0 then
				var_179_17.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_179_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_17.position).x, (manager.ui.mainCamera.transform.position - var_179_17.position).y, (manager.ui.mainCamera.transform.position - var_179_17.position).z)
				var_179_17.localEulerAngles.z = 0
				var_179_17.localEulerAngles.x = 0
				var_179_17.localEulerAngles = var_179_17.localEulerAngles
			end

			local var_179_19 = arg_176_1.actors_["1019ui_story"]

			if 3.36666666666667 < arg_176_1.time_ and arg_176_1.time_ <= 3.36666666666667 + arg_179_0 and not isNil(var_179_19) and arg_176_1.var_.characterEffect1019ui_story == nil then
				arg_176_1.var_.characterEffect1019ui_story = var_179_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_20 = 0.200000002980232

			if 3.36666666666667 <= arg_176_1.time_ and arg_176_1.time_ < 3.36666666666667 + var_179_20 and not isNil(var_179_19) then
				if arg_176_1.var_.characterEffect1019ui_story and not isNil(var_179_19) then
					arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 3.36666666666667 + var_179_20 and arg_176_1.time_ < 3.36666666666667 + var_179_20 + arg_179_0 and not isNil(var_179_19) and arg_176_1.var_.characterEffect1019ui_story then
				arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 3.36666666666667 < arg_176_1.time_ and arg_176_1.time_ <= 3.36666666666667 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 3.36666666666667 < arg_176_1.time_ and arg_176_1.time_ <= 3.36666666666667 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_176_1.time_ and arg_176_1.time_ <= 1.2 + arg_179_0 then
				arg_176_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_176_1.time_ and arg_176_1.time_ <= 0.2 + arg_179_0 then
				arg_176_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 1 < arg_176_1.time_ and arg_176_1.time_ <= 1 + arg_179_0 then
				arg_176_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_179_26 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_176_1.bgmTxt_.text ~= var_179_26 and arg_176_1.bgmTxt_.text ~= "" then
						if arg_176_1.bgmTxt2_.text ~= "" then
							arg_176_1.bgmTxt_.text = arg_176_1.bgmTxt2_.text
						end

						arg_176_1.bgmTxt2_.text = var_179_26

						arg_176_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_176_1.bgmTxt_.text = var_179_26
						arg_176_1.bgmTxt2_.text = var_179_26
					end

					if arg_176_1.bgmTimer then
						arg_176_1.bgmTimer:Stop()

						arg_176_1.bgmTimer = nil
					end

					if arg_176_1.settingData.show_music_name == 1 then
						arg_176_1.musicController:SetSelectedState("show")
						arg_176_1.musicAnimator_:Play("open", 0, 0)

						if arg_176_1.settingData.music_time ~= 0 then
							arg_176_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_176_1.settingData.music_time), function()
								if arg_176_1 == nil or isNil(arg_176_1.bgmTxt_) then
									return
								end

								arg_176_1.musicController:SetSelectedState("hide")
								arg_176_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_176_1.frameCnt_ <= 1 then
				arg_176_1.dialog_:SetActive(false)
			end

			local var_179_28 = 3.73333333333333
			local var_179_29 = 0.475

			if 3.73333333333333 < arg_176_1.time_ and arg_176_1.time_ <= var_179_28 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				arg_176_1.dialog_:SetActive(true)

				arg_176_1.dialogCg_.alpha = 0

				local var_179_30 = LeanTween.value(arg_176_1.dialog_, 0, 1, 0.3)

				var_179_30:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_176_1.dialogCg_.alpha = arg_181_0
				end))
				var_179_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_176_1.dialog_)
					var_179_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_176_1.duration_ = arg_176_1.duration_ + 0.3

				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_31 = arg_176_1:GetWordFromCfg(304081042)
				local var_179_32 = arg_176_1:FormatText(var_179_31.content)

				arg_176_1.text_.text = var_179_32

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_34 = 19 <= 0 and var_179_29 or var_179_29 * (utf8.len(var_179_32) / 19)

				if (19 <= 0 and var_179_29 or var_179_29 * (utf8.len(var_179_32) / 19)) > 0 and var_179_29 < var_179_34 then
					arg_176_1.talkMaxDuration = var_179_34
					var_179_28 = var_179_28 + 0.3

					if var_179_34 + var_179_28 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_34 + var_179_28
					end
				end

				arg_176_1.text_.text = var_179_32
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081042", "story_v_out_304081.awb") ~= 0 then
					local var_179_35 = manager.audio:GetVoiceLength("story_v_out_304081", "304081042", "story_v_out_304081.awb") / 1000

					if var_179_35 + var_179_28 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_35 + var_179_28
					end

					if var_179_31.prefab_name ~= "" and arg_176_1.actors_[var_179_31.prefab_name] ~= nil then
						local var_179_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_31.prefab_name].transform, "story_v_out_304081", "304081042", "story_v_out_304081.awb")

						arg_176_1:RecordAudio("304081042", var_179_36)
						arg_176_1:RecordAudio("304081042", var_179_36)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_304081", "304081042", "story_v_out_304081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_304081", "304081042", "story_v_out_304081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_37 = var_179_28 + 0.3
			local var_179_38 = math.max(var_179_29, arg_176_1.talkMaxDuration)

			if var_179_28 + 0.3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_37 + var_179_38 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_37) / var_179_38

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_37 + var_179_38 and arg_176_1.time_ < var_179_37 + var_179_38 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play304081043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 304081043
		arg_183_1.duration_ = 5.6

		local var_183_0 = {
			zh = 3.933,
			ja = 5.6
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
				arg_183_0:Play304081044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.475

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(304081043)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 19 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 19)

				if (19 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 19)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081043", "story_v_out_304081.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081043", "story_v_out_304081.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_304081", "304081043", "story_v_out_304081.awb")

						arg_183_1:RecordAudio("304081043", var_186_6)
						arg_183_1:RecordAudio("304081043", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_304081", "304081043", "story_v_out_304081.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_304081", "304081043", "story_v_out_304081.awb")
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
	Play304081044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 304081044
		arg_187_1.duration_ = 9.6

		local var_187_0 = {
			zh = 7.633,
			ja = 9.6
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
				arg_187_0:Play304081045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if arg_187_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_190_0 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_187_1.stage_.transform)

				var_190_0.name = "10002ui_story"
				var_190_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["10002ui_story"] = var_190_0

				local var_190_1 = var_190_0:GetComponentInChildren(typeof(CharacterEffect))

				var_190_1.enabled = true

				local var_190_2 = GameObjectTools.GetOrAddComponent(var_190_0, typeof(DynamicBoneHelper))

				if var_190_2 then
					var_190_2:EnableDynamicBone(false)
				end

				arg_187_1:ShowWeapon(var_190_1.transform, false)

				arg_187_1.var_["10002ui_story" .. "Animator"] = var_190_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_187_1.var_["10002ui_story" .. "Animator"].applyRootMotion = true
				arg_187_1.var_["10002ui_story" .. "LipSync"] = var_190_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_190_3 = arg_187_1.actors_["10002ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10002ui_story = var_190_3.localPosition
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_3.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10002ui_story, Vector3.New(-0.7, -1.2, -5.8), (arg_187_1.time_ - 0) / var_190_4)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_3.localPosition = Vector3.New(-0.7, -1.2, -5.8)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			local var_190_5 = arg_187_1.actors_["1019ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1019ui_story = var_190_5.localPosition
			end

			local var_190_6 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 then
				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_187_1.time_ - 0) / var_190_6)
				var_190_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_5.position).x, (manager.ui.mainCamera.transform.position - var_190_5.position).y, (manager.ui.mainCamera.transform.position - var_190_5.position).z)
				var_190_5.localEulerAngles.z = 0
				var_190_5.localEulerAngles.x = 0
				var_190_5.localEulerAngles = var_190_5.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_190_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_5.position).x, (manager.ui.mainCamera.transform.position - var_190_5.position).y, (manager.ui.mainCamera.transform.position - var_190_5.position).z)
				var_190_5.localEulerAngles.z = 0
				var_190_5.localEulerAngles.x = 0
				var_190_5.localEulerAngles = var_190_5.localEulerAngles
			end

			local var_190_7 = arg_187_1.actors_["10002ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.characterEffect10002ui_story == nil then
				arg_187_1.var_.characterEffect10002ui_story = var_190_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_8 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_8 and not isNil(var_190_7) then
				if arg_187_1.var_.characterEffect10002ui_story and not isNil(var_190_7) then
					arg_187_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_8 and arg_187_1.time_ < 0 + var_190_8 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.characterEffect10002ui_story then
				arg_187_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_190_10 = arg_187_1.actors_["1019ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_10) and arg_187_1.var_.characterEffect1019ui_story == nil then
				arg_187_1.var_.characterEffect1019ui_story = var_190_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_11 and not isNil(var_190_10) then
				if arg_187_1.var_.characterEffect1019ui_story and not isNil(var_190_10) then
					arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_11)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_11 and arg_187_1.time_ < 0 + var_190_11 + arg_190_0 and not isNil(var_190_10) and arg_187_1.var_.characterEffect1019ui_story then
				arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_12 = 0
			local var_190_13 = 0.75

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_14 = arg_187_1:GetWordFromCfg(304081044)
				local var_190_15 = arg_187_1:FormatText(var_190_14.content)

				arg_187_1.text_.text = var_190_15

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 30 <= 0 and var_190_13 or var_190_13 * (utf8.len(var_190_15) / 30)

				if (30 <= 0 and var_190_13 or var_190_13 * (utf8.len(var_190_15) / 30)) > 0 and var_190_13 < var_190_17 then
					arg_187_1.talkMaxDuration = var_190_17

					if var_190_17 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_15
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081044", "story_v_out_304081.awb") ~= 0 then
					local var_190_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081044", "story_v_out_304081.awb") / 1000

					if var_190_18 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_18 + var_190_12
					end

					if var_190_14.prefab_name ~= "" and arg_187_1.actors_[var_190_14.prefab_name] ~= nil then
						local var_190_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_14.prefab_name].transform, "story_v_out_304081", "304081044", "story_v_out_304081.awb")

						arg_187_1:RecordAudio("304081044", var_190_19)
						arg_187_1:RecordAudio("304081044", var_190_19)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_304081", "304081044", "story_v_out_304081.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_304081", "304081044", "story_v_out_304081.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_20 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_20 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_20

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_20 and arg_187_1.time_ < var_190_12 + var_190_20 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304081045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 304081045
		arg_191_1.duration_ = 6.77

		local var_191_0 = {
			zh = 6.766,
			ja = 6.5
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
				arg_191_0:Play304081046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.725

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(304081045)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 29 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 29)

				if (29 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 29)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081045", "story_v_out_304081.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081045", "story_v_out_304081.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_304081", "304081045", "story_v_out_304081.awb")

						arg_191_1:RecordAudio("304081045", var_194_6)
						arg_191_1:RecordAudio("304081045", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_304081", "304081045", "story_v_out_304081.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_304081", "304081045", "story_v_out_304081.awb")
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
	Play304081046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 304081046
		arg_195_1.duration_ = 6.3

		local var_195_0 = {
			zh = 3.833,
			ja = 6.3
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
				arg_195_0:Play304081047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) and arg_195_1.var_.characterEffect1019ui_story == nil then
				arg_195_1.var_.characterEffect1019ui_story = arg_195_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) then
				if arg_195_1.var_.characterEffect1019ui_story and not isNil(arg_195_1.actors_["1019ui_story"]) then
					arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) and arg_195_1.var_.characterEffect1019ui_story then
				arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_198_2 = arg_195_1.actors_["10002ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect10002ui_story == nil then
				arg_195_1.var_.characterEffect10002ui_story = var_198_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_3 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.characterEffect10002ui_story and not isNil(var_198_2) then
					arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_3)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect10002ui_story then
				arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_198_4 = 0
			local var_198_5 = 0.5

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(304081046)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 20 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 20)

				if (20 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 20)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081046", "story_v_out_304081.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081046", "story_v_out_304081.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_304081", "304081046", "story_v_out_304081.awb")

						arg_195_1:RecordAudio("304081046", var_198_11)
						arg_195_1:RecordAudio("304081046", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_304081", "304081046", "story_v_out_304081.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_304081", "304081046", "story_v_out_304081.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play304081047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 304081047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play304081048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1019ui_story"]) and arg_199_1.var_.characterEffect1019ui_story == nil then
				arg_199_1.var_.characterEffect1019ui_story = arg_199_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1019ui_story"]) then
				if arg_199_1.var_.characterEffect1019ui_story and not isNil(arg_199_1.actors_["1019ui_story"]) then
					arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1019ui_story"]) and arg_199_1.var_.characterEffect1019ui_story then
				arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.9

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

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(304081047).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 36 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 36)

				if (36 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 36)) > 0 and var_202_2 < var_202_5 then
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
	Play304081048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 304081048
		arg_203_1.duration_ = 6.8

		local var_203_0 = {
			zh = 6.8,
			ja = 4.866
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
				arg_203_0:Play304081049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10002ui_story"]) and arg_203_1.var_.characterEffect10002ui_story == nil then
				arg_203_1.var_.characterEffect10002ui_story = arg_203_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10002ui_story"]) then
				if arg_203_1.var_.characterEffect10002ui_story and not isNil(arg_203_1.actors_["10002ui_story"]) then
					arg_203_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10002ui_story"]) and arg_203_1.var_.characterEffect10002ui_story then
				arg_203_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_206_2 = 0
			local var_206_3 = 0.35

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(304081048)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 14 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 14)

				if (14 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 14)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081048", "story_v_out_304081.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081048", "story_v_out_304081.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_304081", "304081048", "story_v_out_304081.awb")

						arg_203_1:RecordAudio("304081048", var_206_9)
						arg_203_1:RecordAudio("304081048", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_304081", "304081048", "story_v_out_304081.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_304081", "304081048", "story_v_out_304081.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play304081049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 304081049
		arg_207_1.duration_ = 2.67

		local var_207_0 = {
			zh = 1.999999999999,
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
				arg_207_0:Play304081050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1019ui_story"]) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = arg_207_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1019ui_story"]) then
				if arg_207_1.var_.characterEffect1019ui_story and not isNil(arg_207_1.actors_["1019ui_story"]) then
					arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1019ui_story"]) and arg_207_1.var_.characterEffect1019ui_story then
				arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_210_2 = arg_207_1.actors_["10002ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect10002ui_story == nil then
				arg_207_1.var_.characterEffect10002ui_story = var_210_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.characterEffect10002ui_story and not isNil(var_210_2) then
					arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_3)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect10002ui_story then
				arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_4 = 0
			local var_210_5 = 0.15

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(304081049)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 6 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 6)

				if (6 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 6)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081049", "story_v_out_304081.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081049", "story_v_out_304081.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_304081", "304081049", "story_v_out_304081.awb")

						arg_207_1:RecordAudio("304081049", var_210_11)
						arg_207_1:RecordAudio("304081049", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_304081", "304081049", "story_v_out_304081.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_304081", "304081049", "story_v_out_304081.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play304081050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 304081050
		arg_211_1.duration_ = 2.1

		local var_211_0 = {
			zh = 2.1,
			ja = 0.999999999999
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
				arg_211_0:Play304081051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10002ui_story"]) and arg_211_1.var_.characterEffect10002ui_story == nil then
				arg_211_1.var_.characterEffect10002ui_story = arg_211_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10002ui_story"]) then
				if arg_211_1.var_.characterEffect10002ui_story and not isNil(arg_211_1.actors_["10002ui_story"]) then
					arg_211_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10002ui_story"]) and arg_211_1.var_.characterEffect10002ui_story then
				arg_211_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_214_2 = arg_211_1.actors_["1019ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1019ui_story == nil then
				arg_211_1.var_.characterEffect1019ui_story = var_214_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_3 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.characterEffect1019ui_story and not isNil(var_214_2) then
					arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1019ui_story then
				arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_214_4 = 0
			local var_214_5 = 0.05

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(304081050)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 2 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 2)

				if (2 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 2)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081050", "story_v_out_304081.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081050", "story_v_out_304081.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_304081", "304081050", "story_v_out_304081.awb")

						arg_211_1:RecordAudio("304081050", var_214_11)
						arg_211_1:RecordAudio("304081050", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_304081", "304081050", "story_v_out_304081.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_304081", "304081050", "story_v_out_304081.awb")
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

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play304081051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 304081051
		arg_215_1.duration_ = 12.8

		local var_215_0 = {
			zh = 12.8,
			ja = 10.7
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
				arg_215_0:Play304081052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_218_0 = 0
			local var_218_1 = 1.275

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(304081051)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 51 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 51)

				if (51 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 51)) > 0 and var_218_1 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081051", "story_v_out_304081.awb") ~= 0 then
					local var_218_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081051", "story_v_out_304081.awb") / 1000

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end

					if var_218_2.prefab_name ~= "" and arg_215_1.actors_[var_218_2.prefab_name] ~= nil then
						local var_218_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_2.prefab_name].transform, "story_v_out_304081", "304081051", "story_v_out_304081.awb")

						arg_215_1:RecordAudio("304081051", var_218_7)
						arg_215_1:RecordAudio("304081051", var_218_7)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_304081", "304081051", "story_v_out_304081.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_304081", "304081051", "story_v_out_304081.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play304081052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 304081052
		arg_219_1.duration_ = 2.13

		local var_219_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_219_0:Play304081053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = arg_219_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).z)
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles = arg_219_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).z)
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles = arg_219_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_222_1 = "1084ui_story"

			if arg_219_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_222_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_219_1.stage_.transform)

				var_222_2.name = var_222_1
				var_222_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_[var_222_1] = var_222_2

				local var_222_3 = var_222_2:GetComponentInChildren(typeof(CharacterEffect))

				var_222_3.enabled = true

				local var_222_4 = GameObjectTools.GetOrAddComponent(var_222_2, typeof(DynamicBoneHelper))

				if var_222_4 then
					var_222_4:EnableDynamicBone(false)
				end

				arg_219_1:ShowWeapon(var_222_3.transform, false)

				arg_219_1.var_[var_222_1 .. "Animator"] = var_222_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_219_1.var_[var_222_1 .. "Animator"].applyRootMotion = true
				arg_219_1.var_[var_222_1 .. "LipSync"] = var_222_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_222_5 = arg_219_1.actors_["1084ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_5.localPosition
			end

			local var_222_6 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_219_1.time_ - 0) / var_222_6)
				var_222_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_5.position).x, (manager.ui.mainCamera.transform.position - var_222_5.position).y, (manager.ui.mainCamera.transform.position - var_222_5.position).z)
				var_222_5.localEulerAngles.z = 0
				var_222_5.localEulerAngles.x = 0
				var_222_5.localEulerAngles = var_222_5.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(0.7, -0.97, -6)
				var_222_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_5.position).x, (manager.ui.mainCamera.transform.position - var_222_5.position).y, (manager.ui.mainCamera.transform.position - var_222_5.position).z)
				var_222_5.localEulerAngles.z = 0
				var_222_5.localEulerAngles.x = 0
				var_222_5.localEulerAngles = var_222_5.localEulerAngles
			end

			local var_222_7 = arg_219_1.actors_["1084ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_7) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_8 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_8 and not isNil(var_222_7) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_7) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_8 and arg_219_1.time_ < 0 + var_222_8 + arg_222_0 and not isNil(var_222_7) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_10 = arg_219_1.actors_["10002ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_10) and arg_219_1.var_.characterEffect10002ui_story == nil then
				arg_219_1.var_.characterEffect10002ui_story = var_222_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_11 and not isNil(var_222_10) then
				if arg_219_1.var_.characterEffect10002ui_story and not isNil(var_222_10) then
					arg_219_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_11)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_11 and arg_219_1.time_ < 0 + var_222_11 + arg_222_0 and not isNil(var_222_10) and arg_219_1.var_.characterEffect10002ui_story then
				arg_219_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_12 = 0
			local var_222_13 = 0.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_14 = arg_219_1:GetWordFromCfg(304081052)
				local var_222_15 = arg_219_1:FormatText(var_222_14.content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 5 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 5)

				if (5 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 5)) > 0 and var_222_13 < var_222_17 then
					arg_219_1.talkMaxDuration = var_222_17

					if var_222_17 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_17 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081052", "story_v_out_304081.awb") ~= 0 then
					local var_222_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081052", "story_v_out_304081.awb") / 1000

					if var_222_18 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_18 + var_222_12
					end

					if var_222_14.prefab_name ~= "" and arg_219_1.actors_[var_222_14.prefab_name] ~= nil then
						local var_222_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_14.prefab_name].transform, "story_v_out_304081", "304081052", "story_v_out_304081.awb")

						arg_219_1:RecordAudio("304081052", var_222_19)
						arg_219_1:RecordAudio("304081052", var_222_19)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_304081", "304081052", "story_v_out_304081.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_304081", "304081052", "story_v_out_304081.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_20 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_20 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_12) / var_222_20

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_12 + var_222_20 and arg_219_1.time_ < var_222_12 + var_222_20 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play304081053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 304081053
		arg_223_1.duration_ = 11.93

		local var_223_0 = {
			zh = 10.866,
			ja = 11.933
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
				arg_223_0:Play304081054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10002ui_story"]) and arg_223_1.var_.characterEffect10002ui_story == nil then
				arg_223_1.var_.characterEffect10002ui_story = arg_223_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10002ui_story"]) then
				if arg_223_1.var_.characterEffect10002ui_story and not isNil(arg_223_1.actors_["10002ui_story"]) then
					arg_223_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10002ui_story"]) and arg_223_1.var_.characterEffect10002ui_story then
				arg_223_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_226_2 = arg_223_1.actors_["1084ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = var_226_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_3 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.characterEffect1084ui_story and not isNil(var_226_2) then
					arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_3)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1084ui_story then
				arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_226_4 = 0
			local var_226_5 = 1.05

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(304081053)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 42 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 42)

				if (42 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 42)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081053", "story_v_out_304081.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081053", "story_v_out_304081.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_304081", "304081053", "story_v_out_304081.awb")

						arg_223_1:RecordAudio("304081053", var_226_11)
						arg_223_1:RecordAudio("304081053", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_304081", "304081053", "story_v_out_304081.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_304081", "304081053", "story_v_out_304081.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play304081054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 304081054
		arg_227_1.duration_ = 10.17

		local var_227_0 = {
			zh = 10.166,
			ja = 10.033
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
				arg_227_0:Play304081055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_0 = 0
			local var_230_1 = 0.875

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(304081054)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 35 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 35)

				if (35 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 35)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081054", "story_v_out_304081.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081054", "story_v_out_304081.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_out_304081", "304081054", "story_v_out_304081.awb")

						arg_227_1:RecordAudio("304081054", var_230_7)
						arg_227_1:RecordAudio("304081054", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_304081", "304081054", "story_v_out_304081.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_304081", "304081054", "story_v_out_304081.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play304081055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 304081055
		arg_231_1.duration_ = 2.3

		local var_231_0 = {
			zh = 2.3,
			ja = 1.999999999999
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
				arg_231_0:Play304081056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = arg_231_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(arg_231_1.actors_["1084ui_story"]) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_2 = arg_231_1.actors_["10002ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect10002ui_story == nil then
				arg_231_1.var_.characterEffect10002ui_story = var_234_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_3 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.characterEffect10002ui_story and not isNil(var_234_2) then
					arg_231_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_3)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect10002ui_story then
				arg_231_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_4 = 0
			local var_234_5 = 0.25

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(304081055)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 10 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 10)

				if (10 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 10)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081055", "story_v_out_304081.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081055", "story_v_out_304081.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_304081", "304081055", "story_v_out_304081.awb")

						arg_231_1:RecordAudio("304081055", var_234_11)
						arg_231_1:RecordAudio("304081055", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_304081", "304081055", "story_v_out_304081.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_304081", "304081055", "story_v_out_304081.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play304081056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 304081056
		arg_235_1.duration_ = 16.37

		local var_235_0 = {
			zh = 16.366,
			ja = 13.333
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play304081057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10002ui_story"]) and arg_235_1.var_.characterEffect10002ui_story == nil then
				arg_235_1.var_.characterEffect10002ui_story = arg_235_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10002ui_story"]) then
				if arg_235_1.var_.characterEffect10002ui_story and not isNil(arg_235_1.actors_["10002ui_story"]) then
					arg_235_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10002ui_story"]) and arg_235_1.var_.characterEffect10002ui_story then
				arg_235_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_238_2 = arg_235_1.actors_["1084ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_3 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_2) then
					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_3)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1084ui_story then
				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_238_4 = 0
			local var_238_5 = 1.625

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(304081056)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 65 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 65)

				if (65 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 65)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081056", "story_v_out_304081.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081056", "story_v_out_304081.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_304081", "304081056", "story_v_out_304081.awb")

						arg_235_1:RecordAudio("304081056", var_238_11)
						arg_235_1:RecordAudio("304081056", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_304081", "304081056", "story_v_out_304081.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_304081", "304081056", "story_v_out_304081.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play304081057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 304081057
		arg_239_1.duration_ = 16.03

		local var_239_0 = {
			zh = 12.2,
			ja = 16.033
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play304081058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_2")
			end

			local var_242_0 = 0
			local var_242_1 = 1.175

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(304081057)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 47 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 47)

				if (47 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 47)) > 0 and var_242_1 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081057", "story_v_out_304081.awb") ~= 0 then
					local var_242_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081057", "story_v_out_304081.awb") / 1000

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end

					if var_242_2.prefab_name ~= "" and arg_239_1.actors_[var_242_2.prefab_name] ~= nil then
						local var_242_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_2.prefab_name].transform, "story_v_out_304081", "304081057", "story_v_out_304081.awb")

						arg_239_1:RecordAudio("304081057", var_242_7)
						arg_239_1:RecordAudio("304081057", var_242_7)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_304081", "304081057", "story_v_out_304081.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_304081", "304081057", "story_v_out_304081.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_8 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_8 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_8

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_8 and arg_239_1.time_ < var_242_0 + var_242_8 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play304081058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 304081058
		arg_243_1.duration_ = 3.87

		local var_243_0 = {
			zh = 3.866,
			ja = 3.033
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
				arg_243_0:Play304081059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if arg_243_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_246_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_243_1.stage_.transform)

				var_246_0.name = "1011ui_story"
				var_246_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1011ui_story"] = var_246_0

				local var_246_1 = var_246_0:GetComponentInChildren(typeof(CharacterEffect))

				var_246_1.enabled = true

				local var_246_2 = GameObjectTools.GetOrAddComponent(var_246_0, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(false)
				end

				arg_243_1:ShowWeapon(var_246_1.transform, false)

				arg_243_1.var_["1011ui_story" .. "Animator"] = var_246_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_243_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_243_1.var_["1011ui_story" .. "LipSync"] = var_246_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_246_3 = arg_243_1.actors_["1011ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1011ui_story = var_246_3.localPosition
			end

			local var_246_4 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				var_246_3.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_243_1.time_ - 0) / var_246_4)
				var_246_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_3.position).x, (manager.ui.mainCamera.transform.position - var_246_3.position).y, (manager.ui.mainCamera.transform.position - var_246_3.position).z)
				var_246_3.localEulerAngles.z = 0
				var_246_3.localEulerAngles.x = 0
				var_246_3.localEulerAngles = var_246_3.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				var_246_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_246_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_3.position).x, (manager.ui.mainCamera.transform.position - var_246_3.position).y, (manager.ui.mainCamera.transform.position - var_246_3.position).z)
				var_246_3.localEulerAngles.z = 0
				var_246_3.localEulerAngles.x = 0
				var_246_3.localEulerAngles = var_246_3.localEulerAngles
			end

			local var_246_5 = arg_243_1.actors_["1084ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1084ui_story = var_246_5.localPosition
			end

			local var_246_6 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_6 then
				var_246_5.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_6)
				var_246_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_5.position).x, (manager.ui.mainCamera.transform.position - var_246_5.position).y, (manager.ui.mainCamera.transform.position - var_246_5.position).z)
				var_246_5.localEulerAngles.z = 0
				var_246_5.localEulerAngles.x = 0
				var_246_5.localEulerAngles = var_246_5.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_6 and arg_243_1.time_ < 0 + var_246_6 + arg_246_0 then
				var_246_5.localPosition = Vector3.New(0, 100, 0)
				var_246_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_5.position).x, (manager.ui.mainCamera.transform.position - var_246_5.position).y, (manager.ui.mainCamera.transform.position - var_246_5.position).z)
				var_246_5.localEulerAngles.z = 0
				var_246_5.localEulerAngles.x = 0
				var_246_5.localEulerAngles = var_246_5.localEulerAngles
			end

			local var_246_7 = arg_243_1.actors_["1011ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1011ui_story == nil then
				arg_243_1.var_.characterEffect1011ui_story = var_246_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_8 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_8 and not isNil(var_246_7) then
				if arg_243_1.var_.characterEffect1011ui_story and not isNil(var_246_7) then
					arg_243_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_8 and arg_243_1.time_ < 0 + var_246_8 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1011ui_story then
				arg_243_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_246_10 = arg_243_1.actors_["10002ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_10) and arg_243_1.var_.characterEffect10002ui_story == nil then
				arg_243_1.var_.characterEffect10002ui_story = var_246_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_11 and not isNil(var_246_10) then
				if arg_243_1.var_.characterEffect10002ui_story and not isNil(var_246_10) then
					arg_243_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_11)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_11 and arg_243_1.time_ < 0 + var_246_11 + arg_246_0 and not isNil(var_246_10) and arg_243_1.var_.characterEffect10002ui_story then
				arg_243_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_12 = 0
			local var_246_13 = 0.35

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_12 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_14 = arg_243_1:GetWordFromCfg(304081058)
				local var_246_15 = arg_243_1:FormatText(var_246_14.content)

				arg_243_1.text_.text = var_246_15

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_17 = 14 <= 0 and var_246_13 or var_246_13 * (utf8.len(var_246_15) / 14)

				if (14 <= 0 and var_246_13 or var_246_13 * (utf8.len(var_246_15) / 14)) > 0 and var_246_13 < var_246_17 then
					arg_243_1.talkMaxDuration = var_246_17

					if var_246_17 + var_246_12 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_17 + var_246_12
					end
				end

				arg_243_1.text_.text = var_246_15
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081058", "story_v_out_304081.awb") ~= 0 then
					local var_246_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081058", "story_v_out_304081.awb") / 1000

					if var_246_18 + var_246_12 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_18 + var_246_12
					end

					if var_246_14.prefab_name ~= "" and arg_243_1.actors_[var_246_14.prefab_name] ~= nil then
						local var_246_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_14.prefab_name].transform, "story_v_out_304081", "304081058", "story_v_out_304081.awb")

						arg_243_1:RecordAudio("304081058", var_246_19)
						arg_243_1:RecordAudio("304081058", var_246_19)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_304081", "304081058", "story_v_out_304081.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_304081", "304081058", "story_v_out_304081.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_20 = math.max(var_246_13, arg_243_1.talkMaxDuration)

			if var_246_12 <= arg_243_1.time_ and arg_243_1.time_ < var_246_12 + var_246_20 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_12) / var_246_20

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_12 + var_246_20 and arg_243_1.time_ < var_246_12 + var_246_20 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play304081059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 304081059
		arg_247_1.duration_ = 9.23

		local var_247_0 = {
			zh = 9.233,
			ja = 9
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
				arg_247_0:Play304081060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10002ui_story"]) and arg_247_1.var_.characterEffect10002ui_story == nil then
				arg_247_1.var_.characterEffect10002ui_story = arg_247_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10002ui_story"]) then
				if arg_247_1.var_.characterEffect10002ui_story and not isNil(arg_247_1.actors_["10002ui_story"]) then
					arg_247_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10002ui_story"]) and arg_247_1.var_.characterEffect10002ui_story then
				arg_247_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_250_2 = arg_247_1.actors_["1011ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect1011ui_story == nil then
				arg_247_1.var_.characterEffect1011ui_story = var_250_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_3 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.characterEffect1011ui_story and not isNil(var_250_2) then
					arg_247_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_3)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect1011ui_story then
				arg_247_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_250_4 = 0
			local var_250_5 = 1.075

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(304081059)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 42 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 42)

				if (42 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 42)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081059", "story_v_out_304081.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081059", "story_v_out_304081.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_304081", "304081059", "story_v_out_304081.awb")

						arg_247_1:RecordAudio("304081059", var_250_11)
						arg_247_1:RecordAudio("304081059", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_304081", "304081059", "story_v_out_304081.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_304081", "304081059", "story_v_out_304081.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play304081060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 304081060
		arg_251_1.duration_ = 14.07

		local var_251_0 = {
			zh = 11.6,
			ja = 14.066
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
				arg_251_0:Play304081061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_254_0 = 0
			local var_254_1 = 1.1

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(304081060)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 44 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 44)

				if (44 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 44)) > 0 and var_254_1 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081060", "story_v_out_304081.awb") ~= 0 then
					local var_254_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081060", "story_v_out_304081.awb") / 1000

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end

					if var_254_2.prefab_name ~= "" and arg_251_1.actors_[var_254_2.prefab_name] ~= nil then
						local var_254_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_2.prefab_name].transform, "story_v_out_304081", "304081060", "story_v_out_304081.awb")

						arg_251_1:RecordAudio("304081060", var_254_7)
						arg_251_1:RecordAudio("304081060", var_254_7)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_304081", "304081060", "story_v_out_304081.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_304081", "304081060", "story_v_out_304081.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play304081061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 304081061
		arg_255_1.duration_ = 9.2

		local var_255_0 = {
			zh = 9.2,
			ja = 1.333
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play304081062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1084ui_story = arg_255_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1084ui_story"].transform.position).z)
				arg_255_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1084ui_story"].transform.localEulerAngles = arg_255_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_255_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1084ui_story"].transform.position).z)
				arg_255_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1084ui_story"].transform.localEulerAngles = arg_255_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1011ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1011ui_story = var_258_1.localPosition
			end

			local var_258_2 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 then
				var_258_1.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_2)
				var_258_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_1.position).x, (manager.ui.mainCamera.transform.position - var_258_1.position).y, (manager.ui.mainCamera.transform.position - var_258_1.position).z)
				var_258_1.localEulerAngles.z = 0
				var_258_1.localEulerAngles.x = 0
				var_258_1.localEulerAngles = var_258_1.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 then
				var_258_1.localPosition = Vector3.New(0, 100, 0)
				var_258_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_1.position).x, (manager.ui.mainCamera.transform.position - var_258_1.position).y, (manager.ui.mainCamera.transform.position - var_258_1.position).z)
				var_258_1.localEulerAngles.z = 0
				var_258_1.localEulerAngles.x = 0
				var_258_1.localEulerAngles = var_258_1.localEulerAngles
			end

			local var_258_3 = arg_255_1.actors_["1084ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = var_258_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_4 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 and not isNil(var_258_3) then
				if arg_255_1.var_.characterEffect1084ui_story and not isNil(var_258_3) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_258_6 = arg_255_1.actors_["10002ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect10002ui_story == nil then
				arg_255_1.var_.characterEffect10002ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_7 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 and not isNil(var_258_6) then
				if arg_255_1.var_.characterEffect10002ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_7)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect10002ui_story then
				arg_255_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_8 = 0
			local var_258_9 = 1.025

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(304081061)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 41 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 41)

				if (41 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 41)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081061", "story_v_out_304081.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_out_304081", "304081061", "story_v_out_304081.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_out_304081", "304081061", "story_v_out_304081.awb")

						arg_255_1:RecordAudio("304081061", var_258_15)
						arg_255_1:RecordAudio("304081061", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_304081", "304081061", "story_v_out_304081.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_304081", "304081061", "story_v_out_304081.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play304081062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 304081062
		arg_259_1.duration_ = 4.67

		local var_259_0 = {
			zh = 4.666,
			ja = 2.9
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
				arg_259_0:Play304081063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10002ui_story"]) and arg_259_1.var_.characterEffect10002ui_story == nil then
				arg_259_1.var_.characterEffect10002ui_story = arg_259_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10002ui_story"]) then
				if arg_259_1.var_.characterEffect10002ui_story and not isNil(arg_259_1.actors_["10002ui_story"]) then
					arg_259_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10002ui_story"]) and arg_259_1.var_.characterEffect10002ui_story then
				arg_259_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_262_2 = arg_259_1.actors_["1084ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_3 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_2) then
					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_3)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1084ui_story then
				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_262_4 = 0
			local var_262_5 = 0.4

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(304081062)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 16 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 16)

				if (16 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 16)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081062", "story_v_out_304081.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081062", "story_v_out_304081.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_304081", "304081062", "story_v_out_304081.awb")

						arg_259_1:RecordAudio("304081062", var_262_11)
						arg_259_1:RecordAudio("304081062", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_304081", "304081062", "story_v_out_304081.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_304081", "304081062", "story_v_out_304081.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play304081063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 304081063
		arg_263_1.duration_ = 10.87

		local var_263_0 = {
			zh = 7.933,
			ja = 10.866
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
				arg_263_0:Play304081064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			local var_266_0 = 0
			local var_266_1 = 0.925

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(304081063)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 37 <= 0 and var_266_1 or var_266_1 * (utf8.len(var_266_3) / 37)

				if (37 <= 0 and var_266_1 or var_266_1 * (utf8.len(var_266_3) / 37)) > 0 and var_266_1 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081063", "story_v_out_304081.awb") ~= 0 then
					local var_266_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081063", "story_v_out_304081.awb") / 1000

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end

					if var_266_2.prefab_name ~= "" and arg_263_1.actors_[var_266_2.prefab_name] ~= nil then
						local var_266_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_2.prefab_name].transform, "story_v_out_304081", "304081063", "story_v_out_304081.awb")

						arg_263_1:RecordAudio("304081063", var_266_7)
						arg_263_1:RecordAudio("304081063", var_266_7)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_304081", "304081063", "story_v_out_304081.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_304081", "304081063", "story_v_out_304081.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_8 and arg_263_1.time_ < var_266_0 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play304081064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 304081064
		arg_267_1.duration_ = 5.13

		local var_267_0 = {
			zh = 5.133,
			ja = 5.1
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
				arg_267_0:Play304081065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.65

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:GetWordFromCfg(304081064)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 26 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 26)

				if (26 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 26)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081064", "story_v_out_304081.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081064", "story_v_out_304081.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_304081", "304081064", "story_v_out_304081.awb")

						arg_267_1:RecordAudio("304081064", var_270_6)
						arg_267_1:RecordAudio("304081064", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_304081", "304081064", "story_v_out_304081.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_304081", "304081064", "story_v_out_304081.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play304081065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 304081065
		arg_271_1.duration_ = 6.07

		local var_271_0 = {
			zh = 5.033,
			ja = 6.066
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
				arg_271_0:Play304081066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1019ui_story = arg_271_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1019ui_story"].transform.position).z)
				arg_271_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1019ui_story"].transform.localEulerAngles = arg_271_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_271_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1019ui_story"].transform.position).z)
				arg_271_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1019ui_story"].transform.localEulerAngles = arg_271_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1084ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1084ui_story = var_274_1.localPosition
			end

			local var_274_2 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 then
				var_274_1.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_2)
				var_274_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_1.position).x, (manager.ui.mainCamera.transform.position - var_274_1.position).y, (manager.ui.mainCamera.transform.position - var_274_1.position).z)
				var_274_1.localEulerAngles.z = 0
				var_274_1.localEulerAngles.x = 0
				var_274_1.localEulerAngles = var_274_1.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 then
				var_274_1.localPosition = Vector3.New(0, 100, 0)
				var_274_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_1.position).x, (manager.ui.mainCamera.transform.position - var_274_1.position).y, (manager.ui.mainCamera.transform.position - var_274_1.position).z)
				var_274_1.localEulerAngles.z = 0
				var_274_1.localEulerAngles.x = 0
				var_274_1.localEulerAngles = var_274_1.localEulerAngles
			end

			local var_274_3 = arg_271_1.actors_["1019ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect1019ui_story == nil then
				arg_271_1.var_.characterEffect1019ui_story = var_274_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_4 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 and not isNil(var_274_3) then
				if arg_271_1.var_.characterEffect1019ui_story and not isNil(var_274_3) then
					arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect1019ui_story then
				arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_274_6 = arg_271_1.actors_["10002ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10002ui_story == nil then
				arg_271_1.var_.characterEffect10002ui_story = var_274_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_7 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 and not isNil(var_274_6) then
				if arg_271_1.var_.characterEffect10002ui_story and not isNil(var_274_6) then
					arg_271_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_7)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10002ui_story then
				arg_271_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action457")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_274_8 = 0
			local var_274_9 = 0.625

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(304081065)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 25 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 25)

				if (25 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 25)) > 0 and var_274_9 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081065", "story_v_out_304081.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_304081", "304081065", "story_v_out_304081.awb") / 1000

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end

					if var_274_10.prefab_name ~= "" and arg_271_1.actors_[var_274_10.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_10.prefab_name].transform, "story_v_out_304081", "304081065", "story_v_out_304081.awb")

						arg_271_1:RecordAudio("304081065", var_274_15)
						arg_271_1:RecordAudio("304081065", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_304081", "304081065", "story_v_out_304081.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_304081", "304081065", "story_v_out_304081.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play304081066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 304081066
		arg_275_1.duration_ = 10.2

		local var_275_0 = {
			zh = 8.5,
			ja = 10.2
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
				arg_275_0:Play304081067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.125

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(304081066)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 45 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 45)

				if (45 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 45)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081066", "story_v_out_304081.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081066", "story_v_out_304081.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_304081", "304081066", "story_v_out_304081.awb")

						arg_275_1:RecordAudio("304081066", var_278_6)
						arg_275_1:RecordAudio("304081066", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_304081", "304081066", "story_v_out_304081.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_304081", "304081066", "story_v_out_304081.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play304081067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 304081067
		arg_279_1.duration_ = 2.13

		local var_279_0 = {
			zh = 2.133,
			ja = 1.033
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
				arg_279_0:Play304081068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10002ui_story"]) and arg_279_1.var_.characterEffect10002ui_story == nil then
				arg_279_1.var_.characterEffect10002ui_story = arg_279_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10002ui_story"]) then
				if arg_279_1.var_.characterEffect10002ui_story and not isNil(arg_279_1.actors_["10002ui_story"]) then
					arg_279_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10002ui_story"]) and arg_279_1.var_.characterEffect10002ui_story then
				arg_279_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_282_2 = arg_279_1.actors_["1019ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.characterEffect1019ui_story == nil then
				arg_279_1.var_.characterEffect1019ui_story = var_282_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_3 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 and not isNil(var_282_2) then
				if arg_279_1.var_.characterEffect1019ui_story and not isNil(var_282_2) then
					arg_279_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_3)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.characterEffect1019ui_story then
				arg_279_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_4 = 0
			local var_282_5 = 0.2

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(304081067)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 8 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 8)

				if (8 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 8)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081067", "story_v_out_304081.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081067", "story_v_out_304081.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_304081", "304081067", "story_v_out_304081.awb")

						arg_279_1:RecordAudio("304081067", var_282_11)
						arg_279_1:RecordAudio("304081067", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_304081", "304081067", "story_v_out_304081.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_304081", "304081067", "story_v_out_304081.awb")
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

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play304081068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 304081068
		arg_283_1.duration_ = 8.53

		local var_283_0 = {
			zh = 6.6,
			ja = 8.533
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play304081069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1019ui_story = arg_283_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1019ui_story"].transform.position).z)
				arg_283_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1019ui_story"].transform.localEulerAngles = arg_283_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1019ui_story"].transform.position).z)
				arg_283_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1019ui_story"].transform.localEulerAngles = arg_283_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_286_1 = "1013ui_story"

			if arg_283_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_286_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_283_1.stage_.transform)

				var_286_2.name = var_286_1
				var_286_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_[var_286_1] = var_286_2

				local var_286_3 = var_286_2:GetComponentInChildren(typeof(CharacterEffect))

				var_286_3.enabled = true

				local var_286_4 = GameObjectTools.GetOrAddComponent(var_286_2, typeof(DynamicBoneHelper))

				if var_286_4 then
					var_286_4:EnableDynamicBone(false)
				end

				arg_283_1:ShowWeapon(var_286_3.transform, false)

				arg_283_1.var_[var_286_1 .. "Animator"] = var_286_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_283_1.var_[var_286_1 .. "Animator"].applyRootMotion = true
				arg_283_1.var_[var_286_1 .. "LipSync"] = var_286_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_286_5 = arg_283_1.actors_["1013ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1013ui_story = var_286_5.localPosition
			end

			local var_286_6 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_6 then
				var_286_5.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1013ui_story, Vector3.New(0.7, -0.66, -6.15), (arg_283_1.time_ - 0) / var_286_6)
				var_286_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_5.position).x, (manager.ui.mainCamera.transform.position - var_286_5.position).y, (manager.ui.mainCamera.transform.position - var_286_5.position).z)
				var_286_5.localEulerAngles.z = 0
				var_286_5.localEulerAngles.x = 0
				var_286_5.localEulerAngles = var_286_5.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_6 and arg_283_1.time_ < 0 + var_286_6 + arg_286_0 then
				var_286_5.localPosition = Vector3.New(0.7, -0.66, -6.15)
				var_286_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_5.position).x, (manager.ui.mainCamera.transform.position - var_286_5.position).y, (manager.ui.mainCamera.transform.position - var_286_5.position).z)
				var_286_5.localEulerAngles.z = 0
				var_286_5.localEulerAngles.x = 0
				var_286_5.localEulerAngles = var_286_5.localEulerAngles
			end

			local var_286_7 = arg_283_1.actors_["1013ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_7) and arg_283_1.var_.characterEffect1013ui_story == nil then
				arg_283_1.var_.characterEffect1013ui_story = var_286_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_8 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_8 and not isNil(var_286_7) then
				if arg_283_1.var_.characterEffect1013ui_story and not isNil(var_286_7) then
					arg_283_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_8 and arg_283_1.time_ < 0 + var_286_8 + arg_286_0 and not isNil(var_286_7) and arg_283_1.var_.characterEffect1013ui_story then
				arg_283_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_286_10 = arg_283_1.actors_["10002ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_10) and arg_283_1.var_.characterEffect10002ui_story == nil then
				arg_283_1.var_.characterEffect10002ui_story = var_286_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_11 and not isNil(var_286_10) then
				if arg_283_1.var_.characterEffect10002ui_story and not isNil(var_286_10) then
					arg_283_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_11)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_11 and arg_283_1.time_ < 0 + var_286_11 + arg_286_0 and not isNil(var_286_10) and arg_283_1.var_.characterEffect10002ui_story then
				arg_283_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action5_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_286_12 = 0
			local var_286_13 = 0.875

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_12 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_14 = arg_283_1:GetWordFromCfg(304081068)
				local var_286_15 = arg_283_1:FormatText(var_286_14.content)

				arg_283_1.text_.text = var_286_15

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_17 = 35 <= 0 and var_286_13 or var_286_13 * (utf8.len(var_286_15) / 35)

				if (35 <= 0 and var_286_13 or var_286_13 * (utf8.len(var_286_15) / 35)) > 0 and var_286_13 < var_286_17 then
					arg_283_1.talkMaxDuration = var_286_17

					if var_286_17 + var_286_12 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_17 + var_286_12
					end
				end

				arg_283_1.text_.text = var_286_15
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081068", "story_v_out_304081.awb") ~= 0 then
					local var_286_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081068", "story_v_out_304081.awb") / 1000

					if var_286_18 + var_286_12 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_18 + var_286_12
					end

					if var_286_14.prefab_name ~= "" and arg_283_1.actors_[var_286_14.prefab_name] ~= nil then
						local var_286_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_14.prefab_name].transform, "story_v_out_304081", "304081068", "story_v_out_304081.awb")

						arg_283_1:RecordAudio("304081068", var_286_19)
						arg_283_1:RecordAudio("304081068", var_286_19)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_304081", "304081068", "story_v_out_304081.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_304081", "304081068", "story_v_out_304081.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_20 = math.max(var_286_13, arg_283_1.talkMaxDuration)

			if var_286_12 <= arg_283_1.time_ and arg_283_1.time_ < var_286_12 + var_286_20 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_12) / var_286_20

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_12 + var_286_20 and arg_283_1.time_ < var_286_12 + var_286_20 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play304081069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 304081069
		arg_287_1.duration_ = 5.33

		local var_287_0 = {
			zh = 3.666,
			ja = 5.333
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
				arg_287_0:Play304081070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if arg_287_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_290_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_287_1.stage_.transform)

				var_290_0.name = "3008ui_story"
				var_290_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.actors_["3008ui_story"] = var_290_0

				local var_290_1 = var_290_0:GetComponentInChildren(typeof(CharacterEffect))

				var_290_1.enabled = true

				local var_290_2 = GameObjectTools.GetOrAddComponent(var_290_0, typeof(DynamicBoneHelper))

				if var_290_2 then
					var_290_2:EnableDynamicBone(false)
				end

				arg_287_1:ShowWeapon(var_290_1.transform, false)

				arg_287_1.var_["3008ui_story" .. "Animator"] = var_290_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_287_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_287_1.var_["3008ui_story" .. "LipSync"] = var_290_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_290_3 = arg_287_1.actors_["3008ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect3008ui_story == nil then
				arg_287_1.var_.characterEffect3008ui_story = var_290_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_4 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 and not isNil(var_290_3) then
				if arg_287_1.var_.characterEffect3008ui_story and not isNil(var_290_3) then
					arg_287_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect3008ui_story then
				arg_287_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_290_6 = arg_287_1.actors_["1013ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect1013ui_story == nil then
				arg_287_1.var_.characterEffect1013ui_story = var_290_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 and not isNil(var_290_6) then
				if arg_287_1.var_.characterEffect1013ui_story and not isNil(var_290_6) then
					arg_287_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_7)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect1013ui_story then
				arg_287_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 1 < arg_287_1.time_ and arg_287_1.time_ <= 1 + arg_290_0 then
				arg_287_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_290_10 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_10 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_10

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_10
						arg_287_1.bgmTxt2_.text = var_290_10
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_290_11 = 0
			local var_290_12 = 0.325

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_13 = arg_287_1:GetWordFromCfg(304081069)
				local var_290_14 = arg_287_1:FormatText(var_290_13.content)

				arg_287_1.text_.text = var_290_14

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_16 = 13 <= 0 and var_290_12 or var_290_12 * (utf8.len(var_290_14) / 13)

				if (13 <= 0 and var_290_12 or var_290_12 * (utf8.len(var_290_14) / 13)) > 0 and var_290_12 < var_290_16 then
					arg_287_1.talkMaxDuration = var_290_16

					if var_290_16 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_16 + var_290_11
					end
				end

				arg_287_1.text_.text = var_290_14
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081069", "story_v_out_304081.awb") ~= 0 then
					local var_290_17 = manager.audio:GetVoiceLength("story_v_out_304081", "304081069", "story_v_out_304081.awb") / 1000

					if var_290_17 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_17 + var_290_11
					end

					if var_290_13.prefab_name ~= "" and arg_287_1.actors_[var_290_13.prefab_name] ~= nil then
						local var_290_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_13.prefab_name].transform, "story_v_out_304081", "304081069", "story_v_out_304081.awb")

						arg_287_1:RecordAudio("304081069", var_290_18)
						arg_287_1:RecordAudio("304081069", var_290_18)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_304081", "304081069", "story_v_out_304081.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_304081", "304081069", "story_v_out_304081.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_19 = math.max(var_290_12, arg_287_1.talkMaxDuration)

			if var_290_11 <= arg_287_1.time_ and arg_287_1.time_ < var_290_11 + var_290_19 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_11) / var_290_19

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_11 + var_290_19 and arg_287_1.time_ < var_290_11 + var_290_19 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play304081070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 304081070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play304081071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1013ui_story = arg_292_1.actors_["1013ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["1013ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1013ui_story"].transform.position).z)
				arg_292_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1013ui_story"].transform.localEulerAngles = arg_292_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["1013ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1013ui_story"].transform.position).z)
				arg_292_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1013ui_story"].transform.localEulerAngles = arg_292_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["10002ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10002ui_story = var_295_1.localPosition
			end

			local var_295_2 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 then
				var_295_1.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_2)
				var_295_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_1.position).x, (manager.ui.mainCamera.transform.position - var_295_1.position).y, (manager.ui.mainCamera.transform.position - var_295_1.position).z)
				var_295_1.localEulerAngles.z = 0
				var_295_1.localEulerAngles.x = 0
				var_295_1.localEulerAngles = var_295_1.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 then
				var_295_1.localPosition = Vector3.New(0, 100, 0)
				var_295_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_1.position).x, (manager.ui.mainCamera.transform.position - var_295_1.position).y, (manager.ui.mainCamera.transform.position - var_295_1.position).z)
				var_295_1.localEulerAngles.z = 0
				var_295_1.localEulerAngles.x = 0
				var_295_1.localEulerAngles = var_295_1.localEulerAngles
			end

			local var_295_3 = arg_292_1.actors_["3008ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_3) and arg_292_1.var_.characterEffect3008ui_story == nil then
				arg_292_1.var_.characterEffect3008ui_story = var_295_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_4 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 and not isNil(var_295_3) then
				if arg_292_1.var_.characterEffect3008ui_story and not isNil(var_295_3) then
					arg_292_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_292_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_4)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 and not isNil(var_295_3) and arg_292_1.var_.characterEffect3008ui_story then
				arg_292_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_292_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_295_5 = 0
			local var_295_6 = 1.675

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_7 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(304081070).content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 67 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_7) / 67)

				if (67 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_7) / 67)) > 0 and var_295_6 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_5 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_5
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_6, arg_292_1.talkMaxDuration)

			if var_295_5 <= arg_292_1.time_ and arg_292_1.time_ < var_295_5 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_5) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_5 + var_295_10 and arg_292_1.time_ < var_295_5 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play304081071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 304081071
		arg_296_1.duration_ = 5.63

		local var_296_0 = {
			zh = 5.633,
			ja = 1.999999999999
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
				arg_296_0:Play304081072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1084ui_story = arg_296_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).z)
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles = arg_296_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_296_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).z)
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles = arg_296_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1084ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1084ui_story == nil then
				arg_296_1.var_.characterEffect1084ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1084ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1084ui_story then
				arg_296_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_299_4 = 0
			local var_299_5 = 0.65

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(304081071)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 26 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 26)

				if (26 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 26)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081071", "story_v_out_304081.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081071", "story_v_out_304081.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_out_304081", "304081071", "story_v_out_304081.awb")

						arg_296_1:RecordAudio("304081071", var_299_11)
						arg_296_1:RecordAudio("304081071", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_304081", "304081071", "story_v_out_304081.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_304081", "304081071", "story_v_out_304081.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play304081072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 304081072
		arg_300_1.duration_ = 6

		local var_300_0 = {
			zh = 4.866,
			ja = 6
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
				arg_300_0:Play304081073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos3008ui_story = arg_300_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["3008ui_story"].transform.position).z)
				arg_300_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["3008ui_story"].transform.localEulerAngles = arg_300_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0.7, -1.51, -4.3)
				arg_300_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["3008ui_story"].transform.position).z)
				arg_300_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["3008ui_story"].transform.localEulerAngles = arg_300_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["3008ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect3008ui_story == nil then
				arg_300_1.var_.characterEffect3008ui_story = var_303_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 and not isNil(var_303_1) then
				if arg_300_1.var_.characterEffect3008ui_story and not isNil(var_303_1) then
					arg_300_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect3008ui_story then
				arg_300_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_303_4 = arg_300_1.actors_["1084ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_4) and arg_300_1.var_.characterEffect1084ui_story == nil then
				arg_300_1.var_.characterEffect1084ui_story = var_303_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_5 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_5 and not isNil(var_303_4) then
				if arg_300_1.var_.characterEffect1084ui_story and not isNil(var_303_4) then
					arg_300_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_5)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_5 and arg_300_1.time_ < 0 + var_303_5 + arg_303_0 and not isNil(var_303_4) and arg_300_1.var_.characterEffect1084ui_story then
				arg_300_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_303_6 = 0
			local var_303_7 = 0.475

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(304081072)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 19 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 19)

				if (19 <= 0 and var_303_7 or var_303_7 * (utf8.len(var_303_9) / 19)) > 0 and var_303_7 < var_303_11 then
					arg_300_1.talkMaxDuration = var_303_11

					if var_303_11 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081072", "story_v_out_304081.awb") ~= 0 then
					local var_303_12 = manager.audio:GetVoiceLength("story_v_out_304081", "304081072", "story_v_out_304081.awb") / 1000

					if var_303_12 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_6
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_304081", "304081072", "story_v_out_304081.awb")

						arg_300_1:RecordAudio("304081072", var_303_13)
						arg_300_1:RecordAudio("304081072", var_303_13)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_304081", "304081072", "story_v_out_304081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_304081", "304081072", "story_v_out_304081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play304081073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 304081073
		arg_304_1.duration_ = 6.43

		local var_304_0 = {
			zh = 5.633,
			ja = 6.433
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play304081074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.7

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(304081073)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 28 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 28)

				if (28 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 28)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081073", "story_v_out_304081.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081073", "story_v_out_304081.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_304081", "304081073", "story_v_out_304081.awb")

						arg_304_1:RecordAudio("304081073", var_307_6)
						arg_304_1:RecordAudio("304081073", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_304081", "304081073", "story_v_out_304081.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_304081", "304081073", "story_v_out_304081.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play304081074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 304081074
		arg_308_1.duration_ = 5.27

		local var_308_0 = {
			zh = 5.266,
			ja = 1.999999999999
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
				arg_308_0:Play304081075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1084ui_story"]) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = arg_308_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1084ui_story"]) then
				if arg_308_1.var_.characterEffect1084ui_story and not isNil(arg_308_1.actors_["1084ui_story"]) then
					arg_308_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1084ui_story"]) and arg_308_1.var_.characterEffect1084ui_story then
				arg_308_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_311_2 = arg_308_1.actors_["3008ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.characterEffect3008ui_story == nil then
				arg_308_1.var_.characterEffect3008ui_story = var_311_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_3 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_3 and not isNil(var_311_2) then
				if arg_308_1.var_.characterEffect3008ui_story and not isNil(var_311_2) then
					arg_308_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_308_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_3)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_3 and arg_308_1.time_ < 0 + var_311_3 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.characterEffect3008ui_story then
				arg_308_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_308_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action498")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_311_4 = 0
			local var_311_5 = 0.6

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_6 = arg_308_1:GetWordFromCfg(304081074)
				local var_311_7 = arg_308_1:FormatText(var_311_6.content)

				arg_308_1.text_.text = var_311_7

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_9 = 24 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 24)

				if (24 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 24)) > 0 and var_311_5 < var_311_9 then
					arg_308_1.talkMaxDuration = var_311_9

					if var_311_9 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_9 + var_311_4
					end
				end

				arg_308_1.text_.text = var_311_7
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081074", "story_v_out_304081.awb") ~= 0 then
					local var_311_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081074", "story_v_out_304081.awb") / 1000

					if var_311_10 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_4
					end

					if var_311_6.prefab_name ~= "" and arg_308_1.actors_[var_311_6.prefab_name] ~= nil then
						local var_311_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_6.prefab_name].transform, "story_v_out_304081", "304081074", "story_v_out_304081.awb")

						arg_308_1:RecordAudio("304081074", var_311_11)
						arg_308_1:RecordAudio("304081074", var_311_11)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_304081", "304081074", "story_v_out_304081.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_304081", "304081074", "story_v_out_304081.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_12 = math.max(var_311_5, arg_308_1.talkMaxDuration)

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_12 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_4) / var_311_12

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_4 + var_311_12 and arg_308_1.time_ < var_311_4 + var_311_12 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play304081075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 304081075
		arg_312_1.duration_ = 7.53

		local var_312_0 = {
			zh = 4.6,
			ja = 7.533
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
				arg_312_0:Play304081076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["3008ui_story"]) and arg_312_1.var_.characterEffect3008ui_story == nil then
				arg_312_1.var_.characterEffect3008ui_story = arg_312_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["3008ui_story"]) then
				if arg_312_1.var_.characterEffect3008ui_story and not isNil(arg_312_1.actors_["3008ui_story"]) then
					arg_312_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["3008ui_story"]) and arg_312_1.var_.characterEffect3008ui_story then
				arg_312_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_315_2 = arg_312_1.actors_["1084ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.characterEffect1084ui_story == nil then
				arg_312_1.var_.characterEffect1084ui_story = var_315_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_3 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.characterEffect1084ui_story and not isNil(var_315_2) then
					arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_3)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.characterEffect1084ui_story then
				arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_315_4 = 0
			local var_315_5 = 0.575

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(304081075)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 23 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 23)

				if (23 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 23)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081075", "story_v_out_304081.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081075", "story_v_out_304081.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_out_304081", "304081075", "story_v_out_304081.awb")

						arg_312_1:RecordAudio("304081075", var_315_11)
						arg_312_1:RecordAudio("304081075", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_304081", "304081075", "story_v_out_304081.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_304081", "304081075", "story_v_out_304081.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play304081076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 304081076
		arg_316_1.duration_ = 9.2

		local var_316_0 = {
			zh = 5.666,
			ja = 9.2
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
				arg_316_0:Play304081077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_319_0 = 0
			local var_319_1 = 0.625

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:GetWordFromCfg(304081076)
				local var_319_3 = arg_316_1:FormatText(var_319_2.content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 25 <= 0 and var_319_1 or var_319_1 * (utf8.len(var_319_3) / 25)

				if (25 <= 0 and var_319_1 or var_319_1 * (utf8.len(var_319_3) / 25)) > 0 and var_319_1 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081076", "story_v_out_304081.awb") ~= 0 then
					local var_319_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081076", "story_v_out_304081.awb") / 1000

					if var_319_6 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_0
					end

					if var_319_2.prefab_name ~= "" and arg_316_1.actors_[var_319_2.prefab_name] ~= nil then
						local var_319_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_2.prefab_name].transform, "story_v_out_304081", "304081076", "story_v_out_304081.awb")

						arg_316_1:RecordAudio("304081076", var_319_7)
						arg_316_1:RecordAudio("304081076", var_319_7)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_304081", "304081076", "story_v_out_304081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_304081", "304081076", "story_v_out_304081.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_8 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_8 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_8

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_8 and arg_316_1.time_ < var_319_0 + var_319_8 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play304081077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 304081077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play304081078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos3008ui_story = arg_320_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_323_0 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				arg_320_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["3008ui_story"].transform.position).z)
				arg_320_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["3008ui_story"].transform.localEulerAngles = arg_320_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_320_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["3008ui_story"].transform.position).z)
				arg_320_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["3008ui_story"].transform.localEulerAngles = arg_320_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_323_1 = arg_320_1.actors_["1084ui_story"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1084ui_story = var_323_1.localPosition
			end

			local var_323_2 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_2 then
				var_323_1.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_320_1.time_ - 0) / var_323_2)
				var_323_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_323_1.position).x, (manager.ui.mainCamera.transform.position - var_323_1.position).y, (manager.ui.mainCamera.transform.position - var_323_1.position).z)
				var_323_1.localEulerAngles.z = 0
				var_323_1.localEulerAngles.x = 0
				var_323_1.localEulerAngles = var_323_1.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_2 and arg_320_1.time_ < 0 + var_323_2 + arg_323_0 then
				var_323_1.localPosition = Vector3.New(0, 100, 0)
				var_323_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_323_1.position).x, (manager.ui.mainCamera.transform.position - var_323_1.position).y, (manager.ui.mainCamera.transform.position - var_323_1.position).z)
				var_323_1.localEulerAngles.z = 0
				var_323_1.localEulerAngles.x = 0
				var_323_1.localEulerAngles = var_323_1.localEulerAngles
			end

			local var_323_3 = arg_320_1.actors_["3008ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_3) and arg_320_1.var_.characterEffect3008ui_story == nil then
				arg_320_1.var_.characterEffect3008ui_story = var_323_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_4 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 and not isNil(var_323_3) then
				if arg_320_1.var_.characterEffect3008ui_story and not isNil(var_323_3) then
					arg_320_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_320_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_320_1.time_ - 0) / var_323_4)
				end
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 and not isNil(var_323_3) and arg_320_1.var_.characterEffect3008ui_story then
				arg_320_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_320_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_323_5 = 0
			local var_323_6 = 0.85

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_7 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(304081077).content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_9 = 34 <= 0 and var_323_6 or var_323_6 * (utf8.len(var_323_7) / 34)

				if (34 <= 0 and var_323_6 or var_323_6 * (utf8.len(var_323_7) / 34)) > 0 and var_323_6 < var_323_9 then
					arg_320_1.talkMaxDuration = var_323_9

					if var_323_9 + var_323_5 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_9 + var_323_5
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_6, arg_320_1.talkMaxDuration)

			if var_323_5 <= arg_320_1.time_ and arg_320_1.time_ < var_323_5 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_5) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_5 + var_323_10 and arg_320_1.time_ < var_323_5 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
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

		arg_320_1:InitPlayNodeList()
	end,
	Play304081078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 304081078
		arg_324_1.duration_ = 8.2

		local var_324_0 = {
			zh = 6.533,
			ja = 8.2
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
				arg_324_0:Play304081079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos3008ui_story = arg_324_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_327_0 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 then
				arg_324_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_324_1.time_ - 0) / var_327_0)
				arg_324_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["3008ui_story"].transform.position).z)
				arg_324_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["3008ui_story"].transform.localEulerAngles = arg_324_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 then
				arg_324_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, -1.51, -4.3)
				arg_324_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["3008ui_story"].transform.position).z)
				arg_324_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["3008ui_story"].transform.localEulerAngles = arg_324_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_327_1 = arg_324_1.actors_["3008ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect3008ui_story == nil then
				arg_324_1.var_.characterEffect3008ui_story = var_327_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_2 and not isNil(var_327_1) then
				if arg_324_1.var_.characterEffect3008ui_story and not isNil(var_327_1) then
					arg_324_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_2 and arg_324_1.time_ < 0 + var_327_2 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect3008ui_story then
				arg_324_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_2")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_327_4 = 0
			local var_327_5 = 0.75

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_6 = arg_324_1:GetWordFromCfg(304081078)
				local var_327_7 = arg_324_1:FormatText(var_327_6.content)

				arg_324_1.text_.text = var_327_7

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_9 = 30 <= 0 and var_327_5 or var_327_5 * (utf8.len(var_327_7) / 30)

				if (30 <= 0 and var_327_5 or var_327_5 * (utf8.len(var_327_7) / 30)) > 0 and var_327_5 < var_327_9 then
					arg_324_1.talkMaxDuration = var_327_9

					if var_327_9 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_9 + var_327_4
					end
				end

				arg_324_1.text_.text = var_327_7
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081078", "story_v_out_304081.awb") ~= 0 then
					local var_327_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081078", "story_v_out_304081.awb") / 1000

					if var_327_10 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_10 + var_327_4
					end

					if var_327_6.prefab_name ~= "" and arg_324_1.actors_[var_327_6.prefab_name] ~= nil then
						local var_327_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_6.prefab_name].transform, "story_v_out_304081", "304081078", "story_v_out_304081.awb")

						arg_324_1:RecordAudio("304081078", var_327_11)
						arg_324_1:RecordAudio("304081078", var_327_11)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_304081", "304081078", "story_v_out_304081.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_304081", "304081078", "story_v_out_304081.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_12 = math.max(var_327_5, arg_324_1.talkMaxDuration)

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_12 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_4) / var_327_12

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_4 + var_327_12 and arg_324_1.time_ < var_327_4 + var_327_12 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
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

		arg_324_1:InitPlayNodeList()
	end,
	Play304081079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 304081079
		arg_328_1.duration_ = 6.83

		local var_328_0 = {
			zh = 6.7,
			ja = 6.833
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
				arg_328_0:Play304081080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos1013ui_story = arg_328_1.actors_["1013ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 then
				arg_328_1.actors_["1013ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_328_1.time_ - 0) / var_331_0)
				arg_328_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1013ui_story"].transform.position).z)
				arg_328_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["1013ui_story"].transform.localEulerAngles = arg_328_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["1013ui_story"].transform.localPosition = Vector3.New(0, -0.66, -6.15)
				arg_328_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1013ui_story"].transform.position).z)
				arg_328_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["1013ui_story"].transform.localEulerAngles = arg_328_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			local var_331_1 = arg_328_1.actors_["1013ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect1013ui_story == nil then
				arg_328_1.var_.characterEffect1013ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_2 and not isNil(var_331_1) then
				if arg_328_1.var_.characterEffect1013ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_2 and arg_328_1.time_ < 0 + var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect1013ui_story then
				arg_328_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_331_4 = arg_328_1.actors_["3008ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_4) and arg_328_1.var_.characterEffect3008ui_story == nil then
				arg_328_1.var_.characterEffect3008ui_story = var_331_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_5 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_5 and not isNil(var_331_4) then
				if arg_328_1.var_.characterEffect3008ui_story and not isNil(var_331_4) then
					arg_328_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_328_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_5)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_5 and arg_328_1.time_ < 0 + var_331_5 + arg_331_0 and not isNil(var_331_4) and arg_328_1.var_.characterEffect3008ui_story then
				arg_328_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_328_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action452")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_331_6 = arg_328_1.actors_["3008ui_story"].transform

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos3008ui_story = var_331_6.localPosition
			end

			local var_331_7 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				var_331_6.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_328_1.time_ - 0) / var_331_7)
				var_331_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_6.position).x, (manager.ui.mainCamera.transform.position - var_331_6.position).y, (manager.ui.mainCamera.transform.position - var_331_6.position).z)
				var_331_6.localEulerAngles.z = 0
				var_331_6.localEulerAngles.x = 0
				var_331_6.localEulerAngles = var_331_6.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				var_331_6.localPosition = Vector3.New(0, 100, 0)
				var_331_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_6.position).x, (manager.ui.mainCamera.transform.position - var_331_6.position).y, (manager.ui.mainCamera.transform.position - var_331_6.position).z)
				var_331_6.localEulerAngles.z = 0
				var_331_6.localEulerAngles.x = 0
				var_331_6.localEulerAngles = var_331_6.localEulerAngles
			end

			local var_331_8 = 0
			local var_331_9 = 0.8

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_8 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_10 = arg_328_1:GetWordFromCfg(304081079)
				local var_331_11 = arg_328_1:FormatText(var_331_10.content)

				arg_328_1.text_.text = var_331_11

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_13 = 32 <= 0 and var_331_9 or var_331_9 * (utf8.len(var_331_11) / 32)

				if (32 <= 0 and var_331_9 or var_331_9 * (utf8.len(var_331_11) / 32)) > 0 and var_331_9 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_8 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_8
					end
				end

				arg_328_1.text_.text = var_331_11
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081079", "story_v_out_304081.awb") ~= 0 then
					local var_331_14 = manager.audio:GetVoiceLength("story_v_out_304081", "304081079", "story_v_out_304081.awb") / 1000

					if var_331_14 + var_331_8 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_14 + var_331_8
					end

					if var_331_10.prefab_name ~= "" and arg_328_1.actors_[var_331_10.prefab_name] ~= nil then
						local var_331_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_10.prefab_name].transform, "story_v_out_304081", "304081079", "story_v_out_304081.awb")

						arg_328_1:RecordAudio("304081079", var_331_15)
						arg_328_1:RecordAudio("304081079", var_331_15)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_304081", "304081079", "story_v_out_304081.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_304081", "304081079", "story_v_out_304081.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_9, arg_328_1.talkMaxDuration)

			if var_331_8 <= arg_328_1.time_ and arg_328_1.time_ < var_331_8 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_8) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_8 + var_331_16 and arg_328_1.time_ < var_331_8 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_328_1:InitPlayNodeList()
	end,
	Play304081080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 304081080
		arg_332_1.duration_ = 4.83

		local var_332_0 = {
			zh = 4.833,
			ja = 4.7
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
				arg_332_0:Play304081081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.625

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_1 = arg_332_1:GetWordFromCfg(304081080)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 25 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 25)

				if (25 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 25)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081080", "story_v_out_304081.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_304081", "304081080", "story_v_out_304081.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_304081", "304081080", "story_v_out_304081.awb")

						arg_332_1:RecordAudio("304081080", var_335_6)
						arg_332_1:RecordAudio("304081080", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_304081", "304081080", "story_v_out_304081.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_304081", "304081080", "story_v_out_304081.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play304081081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 304081081
		arg_336_1.duration_ = 4.1

		local var_336_0 = {
			zh = 3.3,
			ja = 4.1
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
				arg_336_0:Play304081082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1019ui_story = arg_336_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1019ui_story"].transform.position).z)
				arg_336_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1019ui_story"].transform.localEulerAngles = arg_336_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_336_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1019ui_story"].transform.position).z)
				arg_336_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1019ui_story"].transform.localEulerAngles = arg_336_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_339_1 = arg_336_1.actors_["1019ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1019ui_story == nil then
				arg_336_1.var_.characterEffect1019ui_story = var_339_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_2 and not isNil(var_339_1) then
				if arg_336_1.var_.characterEffect1019ui_story and not isNil(var_339_1) then
					arg_336_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_2 and arg_336_1.time_ < 0 + var_339_2 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1019ui_story then
				arg_336_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_339_4 = arg_336_1.actors_["1013ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_4) and arg_336_1.var_.characterEffect1013ui_story == nil then
				arg_336_1.var_.characterEffect1013ui_story = var_339_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_5 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_5 and not isNil(var_339_4) then
				if arg_336_1.var_.characterEffect1013ui_story and not isNil(var_339_4) then
					arg_336_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_5)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_5 and arg_336_1.time_ < 0 + var_339_5 + arg_339_0 and not isNil(var_339_4) and arg_336_1.var_.characterEffect1013ui_story then
				arg_336_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_339_6 = arg_336_1.actors_["3008ui_story"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos3008ui_story = var_339_6.localPosition
			end

			local var_339_7 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				var_339_6.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_336_1.time_ - 0) / var_339_7)
				var_339_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_6.position).x, (manager.ui.mainCamera.transform.position - var_339_6.position).y, (manager.ui.mainCamera.transform.position - var_339_6.position).z)
				var_339_6.localEulerAngles.z = 0
				var_339_6.localEulerAngles.x = 0
				var_339_6.localEulerAngles = var_339_6.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				var_339_6.localPosition = Vector3.New(0, 100, 0)
				var_339_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_6.position).x, (manager.ui.mainCamera.transform.position - var_339_6.position).y, (manager.ui.mainCamera.transform.position - var_339_6.position).z)
				var_339_6.localEulerAngles.z = 0
				var_339_6.localEulerAngles.x = 0
				var_339_6.localEulerAngles = var_339_6.localEulerAngles
			end

			local var_339_8 = arg_336_1.actors_["1013ui_story"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1013ui_story = var_339_8.localPosition
			end

			local var_339_9 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_9 then
				var_339_8.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1013ui_story, Vector3.New(-0.7, -0.66, -6.15), (arg_336_1.time_ - 0) / var_339_9)
				var_339_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_8.position).x, (manager.ui.mainCamera.transform.position - var_339_8.position).y, (manager.ui.mainCamera.transform.position - var_339_8.position).z)
				var_339_8.localEulerAngles.z = 0
				var_339_8.localEulerAngles.x = 0
				var_339_8.localEulerAngles = var_339_8.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_9 and arg_336_1.time_ < 0 + var_339_9 + arg_339_0 then
				var_339_8.localPosition = Vector3.New(-0.7, -0.66, -6.15)
				var_339_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_8.position).x, (manager.ui.mainCamera.transform.position - var_339_8.position).y, (manager.ui.mainCamera.transform.position - var_339_8.position).z)
				var_339_8.localEulerAngles.z = 0
				var_339_8.localEulerAngles.x = 0
				var_339_8.localEulerAngles = var_339_8.localEulerAngles
			end

			local var_339_10 = 0
			local var_339_11 = 0.4

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_12 = arg_336_1:GetWordFromCfg(304081081)
				local var_339_13 = arg_336_1:FormatText(var_339_12.content)

				arg_336_1.text_.text = var_339_13

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_15 = 16 <= 0 and var_339_11 or var_339_11 * (utf8.len(var_339_13) / 16)

				if (16 <= 0 and var_339_11 or var_339_11 * (utf8.len(var_339_13) / 16)) > 0 and var_339_11 < var_339_15 then
					arg_336_1.talkMaxDuration = var_339_15

					if var_339_15 + var_339_10 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_15 + var_339_10
					end
				end

				arg_336_1.text_.text = var_339_13
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081081", "story_v_out_304081.awb") ~= 0 then
					local var_339_16 = manager.audio:GetVoiceLength("story_v_out_304081", "304081081", "story_v_out_304081.awb") / 1000

					if var_339_16 + var_339_10 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_16 + var_339_10
					end

					if var_339_12.prefab_name ~= "" and arg_336_1.actors_[var_339_12.prefab_name] ~= nil then
						local var_339_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_12.prefab_name].transform, "story_v_out_304081", "304081081", "story_v_out_304081.awb")

						arg_336_1:RecordAudio("304081081", var_339_17)
						arg_336_1:RecordAudio("304081081", var_339_17)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_304081", "304081081", "story_v_out_304081.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_304081", "304081081", "story_v_out_304081.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_18 = math.max(var_339_11, arg_336_1.talkMaxDuration)

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_18 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_10) / var_339_18

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_10 + var_339_18 and arg_336_1.time_ < var_339_10 + var_339_18 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play304081082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 304081082
		arg_340_1.duration_ = 8.23

		local var_340_0 = {
			zh = 4.666,
			ja = 8.233
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
				arg_340_0:Play304081083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos3008ui_story = arg_340_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_343_0 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 then
				arg_340_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_340_1.time_ - 0) / var_343_0)
				arg_340_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["3008ui_story"].transform.position).z)
				arg_340_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["3008ui_story"].transform.localEulerAngles = arg_340_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 then
				arg_340_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, -1.51, -4.3)
				arg_340_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["3008ui_story"].transform.position).z)
				arg_340_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["3008ui_story"].transform.localEulerAngles = arg_340_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_343_1 = arg_340_1.actors_["1013ui_story"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1013ui_story = var_343_1.localPosition
			end

			local var_343_2 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_2 then
				var_343_1.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_340_1.time_ - 0) / var_343_2)
				var_343_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_1.position).x, (manager.ui.mainCamera.transform.position - var_343_1.position).y, (manager.ui.mainCamera.transform.position - var_343_1.position).z)
				var_343_1.localEulerAngles.z = 0
				var_343_1.localEulerAngles.x = 0
				var_343_1.localEulerAngles = var_343_1.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_2 and arg_340_1.time_ < 0 + var_343_2 + arg_343_0 then
				var_343_1.localPosition = Vector3.New(0, 100, 0)
				var_343_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_1.position).x, (manager.ui.mainCamera.transform.position - var_343_1.position).y, (manager.ui.mainCamera.transform.position - var_343_1.position).z)
				var_343_1.localEulerAngles.z = 0
				var_343_1.localEulerAngles.x = 0
				var_343_1.localEulerAngles = var_343_1.localEulerAngles
			end

			local var_343_3 = arg_340_1.actors_["1019ui_story"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1019ui_story = var_343_3.localPosition
			end

			local var_343_4 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				var_343_3.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_340_1.time_ - 0) / var_343_4)
				var_343_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_3.position).x, (manager.ui.mainCamera.transform.position - var_343_3.position).y, (manager.ui.mainCamera.transform.position - var_343_3.position).z)
				var_343_3.localEulerAngles.z = 0
				var_343_3.localEulerAngles.x = 0
				var_343_3.localEulerAngles = var_343_3.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				var_343_3.localPosition = Vector3.New(0, 100, 0)
				var_343_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_3.position).x, (manager.ui.mainCamera.transform.position - var_343_3.position).y, (manager.ui.mainCamera.transform.position - var_343_3.position).z)
				var_343_3.localEulerAngles.z = 0
				var_343_3.localEulerAngles.x = 0
				var_343_3.localEulerAngles = var_343_3.localEulerAngles
			end

			local var_343_5 = arg_340_1.actors_["3008ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.characterEffect3008ui_story == nil then
				arg_340_1.var_.characterEffect3008ui_story = var_343_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_6 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_6 and not isNil(var_343_5) then
				if arg_340_1.var_.characterEffect3008ui_story and not isNil(var_343_5) then
					arg_340_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_6 and arg_340_1.time_ < 0 + var_343_6 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.characterEffect3008ui_story then
				arg_340_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_343_8 = arg_340_1.actors_["1019ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.characterEffect1019ui_story == nil then
				arg_340_1.var_.characterEffect1019ui_story = var_343_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_9 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_9 and not isNil(var_343_8) then
				if arg_340_1.var_.characterEffect1019ui_story and not isNil(var_343_8) then
					arg_340_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_9)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_9 and arg_340_1.time_ < 0 + var_343_9 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.characterEffect1019ui_story then
				arg_340_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_343_10 = 0
			local var_343_11 = 0.625

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_12 = arg_340_1:GetWordFromCfg(304081082)
				local var_343_13 = arg_340_1:FormatText(var_343_12.content)

				arg_340_1.text_.text = var_343_13

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_15 = 25 <= 0 and var_343_11 or var_343_11 * (utf8.len(var_343_13) / 25)

				if (25 <= 0 and var_343_11 or var_343_11 * (utf8.len(var_343_13) / 25)) > 0 and var_343_11 < var_343_15 then
					arg_340_1.talkMaxDuration = var_343_15

					if var_343_15 + var_343_10 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_15 + var_343_10
					end
				end

				arg_340_1.text_.text = var_343_13
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081082", "story_v_out_304081.awb") ~= 0 then
					local var_343_16 = manager.audio:GetVoiceLength("story_v_out_304081", "304081082", "story_v_out_304081.awb") / 1000

					if var_343_16 + var_343_10 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_16 + var_343_10
					end

					if var_343_12.prefab_name ~= "" and arg_340_1.actors_[var_343_12.prefab_name] ~= nil then
						local var_343_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_12.prefab_name].transform, "story_v_out_304081", "304081082", "story_v_out_304081.awb")

						arg_340_1:RecordAudio("304081082", var_343_17)
						arg_340_1:RecordAudio("304081082", var_343_17)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_304081", "304081082", "story_v_out_304081.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_304081", "304081082", "story_v_out_304081.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_18 = math.max(var_343_11, arg_340_1.talkMaxDuration)

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_18 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_10) / var_343_18

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_10 + var_343_18 and arg_340_1.time_ < var_343_10 + var_343_18 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play304081083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 304081083
		arg_344_1.duration_ = 4

		local var_344_0 = {
			zh = 4,
			ja = 1.999999999999
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
			arg_344_1.auto_ = false
		end

		function arg_344_1.playNext_(arg_346_0)
			arg_344_1.onStoryFinished_()
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			local var_347_0 = 0
			local var_347_1 = 0.425

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(304081083)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 17 <= 0 and var_347_1 or var_347_1 * (utf8.len(var_347_3) / 17)

				if (17 <= 0 and var_347_1 or var_347_1 * (utf8.len(var_347_3) / 17)) > 0 and var_347_1 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081083", "story_v_out_304081.awb") ~= 0 then
					local var_347_6 = manager.audio:GetVoiceLength("story_v_out_304081", "304081083", "story_v_out_304081.awb") / 1000

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end

					if var_347_2.prefab_name ~= "" and arg_344_1.actors_[var_347_2.prefab_name] ~= nil then
						local var_347_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_2.prefab_name].transform, "story_v_out_304081", "304081083", "story_v_out_304081.awb")

						arg_344_1:RecordAudio("304081083", var_347_7)
						arg_344_1:RecordAudio("304081083", var_347_7)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_304081", "304081083", "story_v_out_304081.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_304081", "304081083", "story_v_out_304081.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_8 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_8 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_8

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_8 and arg_344_1.time_ < var_347_0 + var_347_8 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03b",
		"TextureConfig/Background/S0102",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B02f"
	},
	voices = {
		"story_v_out_304081.awb"
	}
}
