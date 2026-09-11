return {
	Play410241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410241001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST67 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_4_0.name = "ST67"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST67 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST67

				arg_1_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST67" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_cave_drip", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.075

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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(410241001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 3 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 3)

				if (3 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 3)) > 0 and var_4_16 < var_4_20 then
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
	Play410241002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410241002
		arg_9_1.duration_ = 3.73

		local var_9_0 = {
			ja = 1.166,
			CriLanguages = 3.733,
			zh = 3.733
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
				arg_9_0:Play410241003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_3")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(410241002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 2 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 2)

				if (2 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 2)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241002", "story_v_out_410241.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241002", "story_v_out_410241.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_410241", "410241002", "story_v_out_410241.awb")

						arg_9_1:RecordAudio("410241002", var_12_6)
						arg_9_1:RecordAudio("410241002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410241", "410241002", "story_v_out_410241.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410241", "410241002", "story_v_out_410241.awb")
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
	Play410241003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410241003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410241004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.825

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(410241003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 33 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 33)

				if (33 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 33)) > 0 and var_16_0 < var_16_3 then
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
	Play410241004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410241004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410241005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.375

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(410241004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 55 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 55)

				if (55 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 55)) > 0 and var_20_0 < var_20_3 then
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
	Play410241005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410241005
		arg_21_1.duration_ = 6.73

		local var_21_0 = {
			ja = 6.733,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_21_0:Play410241006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1061"] == nil then
				local var_24_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_24_0) then
					local var_24_1 = Object.Instantiate(var_24_0, arg_21_1.canvasGo_.transform)

					var_24_1.transform:SetSiblingIndex(1)

					var_24_1.name = "1061"
					var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_["1061"] = var_24_1

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs((var_24_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_2 = arg_21_1.actors_["1061"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 3)

				for iter_24_2 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_2)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_24_5 = arg_21_1.actors_["1061"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_4 then
							if arg_21_1.isInRecall_ then
								iter_24_4.color = Color.New(Mathf.Lerp(iter_24_4.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_4.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_4.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_4.color.r, 1, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_4.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_6 then
						iter_24_6.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("stop", "effect", "se_story_side_1070", "se_story_1070_cave_drip", "")
			end

			local var_24_9 = 0
			local var_24_10 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_11 = arg_21_1:GetWordFromCfg(410241005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_14 = 11 <= 0 and var_24_10 or var_24_10 * (utf8.len(var_24_12) / 11)

				if (11 <= 0 and var_24_10 or var_24_10 * (utf8.len(var_24_12) / 11)) > 0 and var_24_10 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_9 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_9
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241005", "story_v_out_410241.awb") ~= 0 then
					local var_24_15 = manager.audio:GetVoiceLength("story_v_out_410241", "410241005", "story_v_out_410241.awb") / 1000

					if var_24_15 + var_24_9 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_9
					end

					if var_24_11.prefab_name ~= "" and arg_21_1.actors_[var_24_11.prefab_name] ~= nil then
						local var_24_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_11.prefab_name].transform, "story_v_out_410241", "410241005", "story_v_out_410241.awb")

						arg_21_1:RecordAudio("410241005", var_24_16)
						arg_21_1:RecordAudio("410241005", var_24_16)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410241", "410241005", "story_v_out_410241.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410241", "410241005", "story_v_out_410241.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_10, arg_21_1.talkMaxDuration)

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_9) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_9 + var_24_17 and arg_21_1.time_ < var_24_9 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410241006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410241006
		arg_25_1.duration_ = 4.03

		local var_25_0 = {
			ja = 4.033,
			CriLanguages = 2.2,
			zh = 2.2
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
				arg_25_0:Play410241007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10060"] == nil then
				local var_28_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_28_0) then
					local var_28_1 = Object.Instantiate(var_28_0, arg_25_1.canvasGo_.transform)

					var_28_1.transform:SetSiblingIndex(1)

					var_28_1.name = "10060"
					var_28_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_["10060"] = var_28_1

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs((var_28_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_2 = arg_25_1.actors_["10060"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10060 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10060", 3)

				for iter_28_2 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_2)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_28_5 = arg_25_1.actors_["1061"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 7)

				for iter_28_3 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_3)

					if var_28_6.name == "" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_28_8 = arg_25_1.actors_["10060"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10060 == nil then
				arg_25_1.var_.actorSpriteComps10060 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 and not isNil(var_28_8) then
				if arg_25_1.var_.actorSpriteComps10060 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_9), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_9), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_9)))
							else
								local var_28_10 = Mathf.Lerp(iter_28_5.color.r, 1, (arg_25_1.time_ - 0) / var_28_9)

								iter_28_5.color = Color.New(var_28_10, var_28_10, var_28_10)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10060 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10060 = nil
			end

			local var_28_11 = arg_25_1.actors_["1061"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_12 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_12 and not isNil(var_28_11) then
				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_8, iter_28_9 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_28_9 then
							if arg_25_1.isInRecall_ then
								iter_28_9.color = Color.New(Mathf.Lerp(iter_28_9.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_12), Mathf.Lerp(iter_28_9.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_12), (Mathf.Lerp(iter_28_9.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_12)))
							else
								local var_28_13 = Mathf.Lerp(iter_28_9.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_12)

								iter_28_9.color = Color.New(var_28_13, var_28_13, var_28_13)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_12 and arg_25_1.time_ < 0 + var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_10, iter_28_11 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_11 then
						iter_28_11.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_14 = 0
			local var_28_15 = 0.125

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_16 = arg_25_1:GetWordFromCfg(410241006)
				local var_28_17 = arg_25_1:FormatText(var_28_16.content)

				arg_25_1.text_.text = var_28_17

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 5 <= 0 and var_28_15 or var_28_15 * (utf8.len(var_28_17) / 5)

				if (5 <= 0 and var_28_15 or var_28_15 * (utf8.len(var_28_17) / 5)) > 0 and var_28_15 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_14
					end
				end

				arg_25_1.text_.text = var_28_17
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241006", "story_v_out_410241.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_410241", "410241006", "story_v_out_410241.awb") / 1000

					if var_28_20 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_14
					end

					if var_28_16.prefab_name ~= "" and arg_25_1.actors_[var_28_16.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_16.prefab_name].transform, "story_v_out_410241", "410241006", "story_v_out_410241.awb")

						arg_25_1:RecordAudio("410241006", var_28_21)
						arg_25_1:RecordAudio("410241006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410241", "410241006", "story_v_out_410241.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410241", "410241006", "story_v_out_410241.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_15, arg_25_1.talkMaxDuration)

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_14) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_14 + var_28_22 and arg_25_1.time_ < var_28_14 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play410241007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410241007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410241008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10060"]) and arg_29_1.var_.actorSpriteComps10060 == nil then
				arg_29_1.var_.actorSpriteComps10060 = arg_29_1.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10060"]) then
				if arg_29_1.var_.actorSpriteComps10060 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10060"]) and arg_29_1.var_.actorSpriteComps10060 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10060 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(410241007).content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 33)

				if (33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 33)) > 0 and var_32_3 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_7 and arg_29_1.time_ < var_32_2 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410241008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410241008
		arg_33_1.duration_ = 1.97

		local var_33_0 = {
			ja = 1.966,
			CriLanguages = 1.333,
			zh = 1.333
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
				arg_33_0:Play410241009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10060 = arg_33_1.actors_["10060"].transform.localPosition
				arg_33_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10060", 3)

				for iter_36_0 = 0, arg_33_1.actors_["10060"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10060"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_5" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10060"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_36_2 = arg_33_1.actors_["10060"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10060 == nil then
				arg_33_1.var_.actorSpriteComps10060 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10060 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(410241008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 10 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 10)

				if (10 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 10)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241008", "story_v_out_410241.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241008", "story_v_out_410241.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410241", "410241008", "story_v_out_410241.awb")

						arg_33_1:RecordAudio("410241008", var_36_12)
						arg_33_1:RecordAudio("410241008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410241", "410241008", "story_v_out_410241.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410241", "410241008", "story_v_out_410241.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play410241009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410241009
		arg_37_1.duration_ = 3.53

		local var_37_0 = {
			ja = 2.933,
			CriLanguages = 3.533,
			zh = 3.533
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
				arg_37_0:Play410241010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = arg_37_1.actors_["1061"].transform.localPosition
				arg_37_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 2)

				for iter_40_0 = 0, arg_37_1.actors_["1061"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1061"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_5" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_40_2 = arg_37_1.actors_["10060"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10060 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10060", 4)

				for iter_40_1 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_1)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(390, -400, 0)
			end

			local var_40_5 = arg_37_1.actors_["1061"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								iter_40_3.color = Color.New(Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_6), Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_6), (Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_6)))
							else
								local var_40_7 = Mathf.Lerp(iter_40_3.color.r, 1, (arg_37_1.time_ - 0) / var_40_6)

								iter_40_3.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_8 = arg_37_1.actors_["10060"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10060 == nil then
				arg_37_1.var_.actorSpriteComps10060 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.actorSpriteComps10060 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								iter_40_7.color = Color.New(Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_9), Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_9), (Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_9)))
							else
								local var_40_10 = Mathf.Lerp(iter_40_7.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_9)

								iter_40_7.color = Color.New(var_40_10, var_40_10, var_40_10)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10060 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_40_9 then
						iter_40_9.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10060 = nil
			end

			local var_40_11 = 0
			local var_40_12 = 0.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(410241009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 8 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 8)

				if (8 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 8)) > 0 and var_40_12 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16

					if var_40_16 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241009", "story_v_out_410241.awb") ~= 0 then
					local var_40_17 = manager.audio:GetVoiceLength("story_v_out_410241", "410241009", "story_v_out_410241.awb") / 1000

					if var_40_17 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_11
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_410241", "410241009", "story_v_out_410241.awb")

						arg_37_1:RecordAudio("410241009", var_40_18)
						arg_37_1:RecordAudio("410241009", var_40_18)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410241", "410241009", "story_v_out_410241.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410241", "410241009", "story_v_out_410241.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play410241010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410241010
		arg_41_1.duration_ = 7.9

		local var_41_0 = {
			ja = 7.9,
			CriLanguages = 6.366,
			zh = 6.366
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
				arg_41_0:Play410241011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10060 = arg_41_1.actors_["10060"].transform.localPosition
				arg_41_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10060", 4)

				for iter_44_0 = 0, arg_41_1.actors_["10060"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10060"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_44_2 = arg_41_1.actors_["10060"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10060 == nil then
				arg_41_1.var_.actorSpriteComps10060 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10060 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10060 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10060 = nil
			end

			local var_44_5 = arg_41_1.actors_["1061"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_44_6 then
							if arg_41_1.isInRecall_ then
								iter_44_6.color = Color.New(Mathf.Lerp(iter_44_6.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_6), Mathf.Lerp(iter_44_6.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_6), (Mathf.Lerp(iter_44_6.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_6)))
							else
								local var_44_7 = Mathf.Lerp(iter_44_6.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_6)

								iter_44_6.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_8 then
						iter_44_8.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(410241010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 12 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 12)

				if (12 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 12)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241010", "story_v_out_410241.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241010", "story_v_out_410241.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_410241", "410241010", "story_v_out_410241.awb")

						arg_41_1:RecordAudio("410241010", var_44_15)
						arg_41_1:RecordAudio("410241010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410241", "410241010", "story_v_out_410241.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410241", "410241010", "story_v_out_410241.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play410241011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410241011
		arg_45_1.duration_ = 7.4

		local var_45_0 = {
			ja = 7.4,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_45_0:Play410241012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061 = arg_45_1.actors_["1061"].transform.localPosition
				arg_45_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1061", 2)

				for iter_48_0 = 0, arg_45_1.actors_["1061"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1061"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_48_2 = arg_45_1.actors_["10060"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10060 == nil then
				arg_45_1.var_.actorSpriteComps10060 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10060 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_2.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_2.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10060 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10060 = nil
			end

			local var_48_5 = arg_45_1.actors_["1061"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								iter_48_6.color = Color.New(Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_6.color.r, 1, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_6.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_8 then
						iter_48_8.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(410241011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 23 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 23)

				if (23 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 23)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241011", "story_v_out_410241.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241011", "story_v_out_410241.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_410241", "410241011", "story_v_out_410241.awb")

						arg_45_1:RecordAudio("410241011", var_48_15)
						arg_45_1:RecordAudio("410241011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410241", "410241011", "story_v_out_410241.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410241", "410241011", "story_v_out_410241.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play410241012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410241012
		arg_49_1.duration_ = 3.2

		local var_49_0 = {
			ja = 3.2,
			CriLanguages = 2.1,
			zh = 2.1
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
				arg_49_0:Play410241013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10060 = arg_49_1.actors_["10060"].transform.localPosition
				arg_49_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10060", 4)

				for iter_52_0 = 0, arg_49_1.actors_["10060"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["10060"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_52_2 = arg_49_1.actors_["10060"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10060 == nil then
				arg_49_1.var_.actorSpriteComps10060 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10060 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10060 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10060 = nil
			end

			local var_52_5 = arg_49_1.actors_["1061"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								iter_52_6.color = Color.New(Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_6), Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_6), (Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_6)))
							else
								local var_52_7 = Mathf.Lerp(iter_52_6.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_6)

								iter_52_6.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_8 then
						iter_52_8.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(410241012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 7 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 7)

				if (7 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 7)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241012", "story_v_out_410241.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241012", "story_v_out_410241.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_410241", "410241012", "story_v_out_410241.awb")

						arg_49_1:RecordAudio("410241012", var_52_15)
						arg_49_1:RecordAudio("410241012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410241", "410241012", "story_v_out_410241.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410241", "410241012", "story_v_out_410241.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410241013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410241013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410241014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061 = arg_53_1.actors_["1061"].transform.localPosition
				arg_53_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1061", 7)

				for iter_56_0 = 0, arg_53_1.actors_["1061"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1061"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_56_2 = arg_53_1.actors_["10060"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10060 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10060", 7)

				for iter_56_1 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_1)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_5 = arg_53_1.actors_["1061"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								iter_56_3.color = Color.New(Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_3.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_3.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_5 then
						iter_56_5.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_8 = arg_53_1.actors_["10060"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10060 == nil then
				arg_53_1.var_.actorSpriteComps10060 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 and not isNil(var_56_8) then
				if arg_53_1.var_.actorSpriteComps10060 then
					for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_56_7 then
							if arg_53_1.isInRecall_ then
								iter_56_7.color = Color.New(Mathf.Lerp(iter_56_7.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_9), Mathf.Lerp(iter_56_7.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_9), (Mathf.Lerp(iter_56_7.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_9)))
							else
								local var_56_10 = Mathf.Lerp(iter_56_7.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_9)

								iter_56_7.color = Color.New(var_56_10, var_56_10, var_56_10)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10060 then
				for iter_56_8, iter_56_9 in pairs(arg_53_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_56_9 then
						iter_56_9.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10060 = nil
			end

			local var_56_11 = 0
			local var_56_12 = 0.8

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_13 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(410241013).content)

				arg_53_1.text_.text = var_56_13

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_15 = 32 <= 0 and var_56_12 or var_56_12 * (utf8.len(var_56_13) / 32)

				if (32 <= 0 and var_56_12 or var_56_12 * (utf8.len(var_56_13) / 32)) > 0 and var_56_12 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_13
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_16 and arg_53_1.time_ < var_56_11 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play410241014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410241014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410241015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.475

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(410241014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 59 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 59)

				if (59 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 59)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410241015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410241015
		arg_61_1.duration_ = 4.3

		local var_61_0 = {
			ja = 4.3,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_61_0:Play410241016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = arg_61_1.actors_["1061"].transform.localPosition
				arg_61_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 2)

				for iter_64_0 = 0, arg_61_1.actors_["1061"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1061"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_64_2 = arg_61_1.actors_["10060"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10060 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10060", 4)

				for iter_64_1 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_1)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(390, -400, 0)
			end

			local var_64_5 = arg_61_1.actors_["1061"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								iter_64_3.color = Color.New(Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_6), Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_6), (Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_6)))
							else
								local var_64_7 = Mathf.Lerp(iter_64_3.color.r, 1, (arg_61_1.time_ - 0) / var_64_6)

								iter_64_3.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_5 then
						iter_64_5.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_8 = arg_61_1.actors_["10060"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10060 == nil then
				arg_61_1.var_.actorSpriteComps10060 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 and not isNil(var_64_8) then
				if arg_61_1.var_.actorSpriteComps10060 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								iter_64_7.color = Color.New(Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_9), Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_9), (Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_9)))
							else
								local var_64_10 = Mathf.Lerp(iter_64_7.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_9)

								iter_64_7.color = Color.New(var_64_10, var_64_10, var_64_10)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10060 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_64_9 then
						iter_64_9.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10060 = nil
			end

			local var_64_11 = 0
			local var_64_12 = 0.225

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:GetWordFromCfg(410241015)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 9 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_14) / 9)

				if (9 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_14) / 9)) > 0 and var_64_12 < var_64_16 then
					arg_61_1.talkMaxDuration = var_64_16

					if var_64_16 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241015", "story_v_out_410241.awb") ~= 0 then
					local var_64_17 = manager.audio:GetVoiceLength("story_v_out_410241", "410241015", "story_v_out_410241.awb") / 1000

					if var_64_17 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_11
					end

					if var_64_13.prefab_name ~= "" and arg_61_1.actors_[var_64_13.prefab_name] ~= nil then
						local var_64_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_13.prefab_name].transform, "story_v_out_410241", "410241015", "story_v_out_410241.awb")

						arg_61_1:RecordAudio("410241015", var_64_18)
						arg_61_1:RecordAudio("410241015", var_64_18)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410241", "410241015", "story_v_out_410241.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410241", "410241015", "story_v_out_410241.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_19 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_19 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_19

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_19 and arg_61_1.time_ < var_64_11 + var_64_19 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410241016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410241016
		arg_65_1.duration_ = 9.6

		local var_65_0 = {
			ja = 9.6,
			CriLanguages = 7.533,
			zh = 7.533
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
				arg_65_0:Play410241017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10060 = arg_65_1.actors_["10060"].transform.localPosition
				arg_65_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10060", 4)

				for iter_68_0 = 0, arg_65_1.actors_["10060"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10060"].transform:GetChild(iter_68_0)

					if var_68_0.name == "" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_68_2 = arg_65_1.actors_["10060"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10060 == nil then
				arg_65_1.var_.actorSpriteComps10060 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10060 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								iter_68_2.color = Color.New(Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_2.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_2.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10060 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10060 = nil
			end

			local var_68_5 = arg_65_1.actors_["1061"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								iter_68_6.color = Color.New(Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_6.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_6.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						iter_68_8.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.825

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(410241016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 32 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 32)

				if (32 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 32)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241016", "story_v_out_410241.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241016", "story_v_out_410241.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_410241", "410241016", "story_v_out_410241.awb")

						arg_65_1:RecordAudio("410241016", var_68_15)
						arg_65_1:RecordAudio("410241016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410241", "410241016", "story_v_out_410241.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410241", "410241016", "story_v_out_410241.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410241017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410241017
		arg_69_1.duration_ = 5.13

		local var_69_0 = {
			ja = 5.133,
			CriLanguages = 4.066,
			zh = 4.066
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
				arg_69_0:Play410241018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = arg_69_1.actors_["1061"].transform.localPosition
				arg_69_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 2)

				for iter_72_0 = 0, arg_69_1.actors_["1061"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1061"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_72_2 = arg_69_1.actors_["10060"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10060 == nil then
				arg_69_1.var_.actorSpriteComps10060 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10060 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10060 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10060 = nil
			end

			local var_72_5 = arg_69_1.actors_["1061"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps1061 == nil then
				arg_69_1.var_.actorSpriteComps1061 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps1061 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								iter_72_6.color = Color.New(Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_6.color.r, 1, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_6.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps1061 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_72_8 then
						iter_72_8.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1061 = nil
			end

			local var_72_8 = 0
			local var_72_9 = 0.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(410241017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 15 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 15)

				if (15 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 15)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241017", "story_v_out_410241.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241017", "story_v_out_410241.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_410241", "410241017", "story_v_out_410241.awb")

						arg_69_1:RecordAudio("410241017", var_72_15)
						arg_69_1:RecordAudio("410241017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410241", "410241017", "story_v_out_410241.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410241", "410241017", "story_v_out_410241.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play410241018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410241018
		arg_73_1.duration_ = 19.7

		local var_73_0 = {
			ja = 19.7,
			CriLanguages = 11.666,
			zh = 11.666
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play410241019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.125

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(410241018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 45 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 45)

				if (45 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 45)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241018", "story_v_out_410241.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241018", "story_v_out_410241.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_410241", "410241018", "story_v_out_410241.awb")

						arg_73_1:RecordAudio("410241018", var_76_6)
						arg_73_1:RecordAudio("410241018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410241", "410241018", "story_v_out_410241.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410241", "410241018", "story_v_out_410241.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410241019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410241019
		arg_77_1.duration_ = 5.23

		local var_77_0 = {
			ja = 5.233,
			CriLanguages = 3.433,
			zh = 3.433
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
				arg_77_0:Play410241020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10060 = arg_77_1.actors_["10060"].transform.localPosition
				arg_77_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10060", 4)

				for iter_80_0 = 0, arg_77_1.actors_["10060"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10060"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_3" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_80_2 = arg_77_1.actors_["10060"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10060 == nil then
				arg_77_1.var_.actorSpriteComps10060 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10060 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10060 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10060 = nil
			end

			local var_80_5 = arg_77_1.actors_["1061"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps1061 == nil then
				arg_77_1.var_.actorSpriteComps1061 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps1061 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								iter_80_6.color = Color.New(Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_6), Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_6), (Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_6)))
							else
								local var_80_7 = Mathf.Lerp(iter_80_6.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_6)

								iter_80_6.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps1061 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_80_8 then
						iter_80_8.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1061 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(410241019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 16 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 16)

				if (16 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 16)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241019", "story_v_out_410241.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241019", "story_v_out_410241.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_410241", "410241019", "story_v_out_410241.awb")

						arg_77_1:RecordAudio("410241019", var_80_15)
						arg_77_1:RecordAudio("410241019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410241", "410241019", "story_v_out_410241.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410241", "410241019", "story_v_out_410241.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play410241020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410241020
		arg_81_1.duration_ = 11.33

		local var_81_0 = {
			ja = 11.333,
			CriLanguages = 8.466,
			zh = 8.466
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
				arg_81_0:Play410241021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.975

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(410241020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 39 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 39)

				if (39 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 39)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241020", "story_v_out_410241.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241020", "story_v_out_410241.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_410241", "410241020", "story_v_out_410241.awb")

						arg_81_1:RecordAudio("410241020", var_84_6)
						arg_81_1:RecordAudio("410241020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410241", "410241020", "story_v_out_410241.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410241", "410241020", "story_v_out_410241.awb")
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
	Play410241021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410241021
		arg_85_1.duration_ = 8.13

		local var_85_0 = {
			ja = 8.133,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_85_0:Play410241022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1061 = arg_85_1.actors_["1061"].transform.localPosition
				arg_85_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1061", 2)

				for iter_88_0 = 0, arg_85_1.actors_["1061"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1061"].transform:GetChild(iter_88_0)

					if var_88_0.name == "" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_88_2 = arg_85_1.actors_["10060"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10060 == nil then
				arg_85_1.var_.actorSpriteComps10060 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10060 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								iter_88_2.color = Color.New(Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_2.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_2.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10060 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10060 = nil
			end

			local var_88_5 = arg_85_1.actors_["1061"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps1061 == nil then
				arg_85_1.var_.actorSpriteComps1061 = var_88_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.actorSpriteComps1061 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								iter_88_6.color = Color.New(Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_6), Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_6), (Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_6)))
							else
								local var_88_7 = Mathf.Lerp(iter_88_6.color.r, 1, (arg_85_1.time_ - 0) / var_88_6)

								iter_88_6.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps1061 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_88_8 then
						iter_88_8.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1061 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.525

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(410241021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 21 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 21)

				if (21 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 21)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241021", "story_v_out_410241.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241021", "story_v_out_410241.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_410241", "410241021", "story_v_out_410241.awb")

						arg_85_1:RecordAudio("410241021", var_88_15)
						arg_85_1:RecordAudio("410241021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410241", "410241021", "story_v_out_410241.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410241", "410241021", "story_v_out_410241.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play410241022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410241022
		arg_89_1.duration_ = 11.8

		local var_89_0 = {
			ja = 11.8,
			CriLanguages = 10.733,
			zh = 10.733
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
				arg_89_0:Play410241023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10060 = arg_89_1.actors_["10060"].transform.localPosition
				arg_89_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10060", 4)

				for iter_92_0 = 0, arg_89_1.actors_["10060"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10060"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_92_2 = arg_89_1.actors_["10060"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10060 == nil then
				arg_89_1.var_.actorSpriteComps10060 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10060 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								iter_92_2.color = Color.New(Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_2.color.r, 1, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_2.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10060 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10060 = nil
			end

			local var_92_5 = arg_89_1.actors_["1061"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1061 == nil then
				arg_89_1.var_.actorSpriteComps1061 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps1061 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								iter_92_6.color = Color.New(Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_6.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_6.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1061 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_92_8 then
						iter_92_8.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps1061 = nil
			end

			local var_92_8 = 0
			local var_92_9 = 1.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(410241022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 47 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 47)

				if (47 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 47)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241022", "story_v_out_410241.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241022", "story_v_out_410241.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_410241", "410241022", "story_v_out_410241.awb")

						arg_89_1:RecordAudio("410241022", var_92_15)
						arg_89_1:RecordAudio("410241022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410241", "410241022", "story_v_out_410241.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410241", "410241022", "story_v_out_410241.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play410241023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410241023
		arg_93_1.duration_ = 7.37

		local var_93_0 = {
			ja = 7.366,
			CriLanguages = 4.8,
			zh = 4.8
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
				arg_93_0:Play410241024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1061 = arg_93_1.actors_["1061"].transform.localPosition
				arg_93_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1061", 2)

				for iter_96_0 = 0, arg_93_1.actors_["1061"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["1061"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_96_2 = arg_93_1.actors_["10060"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10060 == nil then
				arg_93_1.var_.actorSpriteComps10060 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps10060 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10060 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10060 = nil
			end

			local var_96_5 = arg_93_1.actors_["1061"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps1061 == nil then
				arg_93_1.var_.actorSpriteComps1061 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps1061 then
					for iter_96_5, iter_96_6 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_96_6 then
							if arg_93_1.isInRecall_ then
								iter_96_6.color = Color.New(Mathf.Lerp(iter_96_6.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_6.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_6.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_6.color.r, 1, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_6.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps1061 then
				for iter_96_7, iter_96_8 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_96_8 then
						iter_96_8.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1061 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 0.525

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(410241023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 21 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 21)

				if (21 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 21)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241023", "story_v_out_410241.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241023", "story_v_out_410241.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_410241", "410241023", "story_v_out_410241.awb")

						arg_93_1:RecordAudio("410241023", var_96_15)
						arg_93_1:RecordAudio("410241023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410241", "410241023", "story_v_out_410241.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410241", "410241023", "story_v_out_410241.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play410241024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410241024
		arg_97_1.duration_ = 5.17

		local var_97_0 = {
			ja = 5.166,
			CriLanguages = 2.933,
			zh = 2.933
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
				arg_97_0:Play410241025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10060 = arg_97_1.actors_["10060"].transform.localPosition
				arg_97_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10060", 4)

				for iter_100_0 = 0, arg_97_1.actors_["10060"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10060"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_100_2 = arg_97_1.actors_["10060"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10060 == nil then
				arg_97_1.var_.actorSpriteComps10060 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10060 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								iter_100_2.color = Color.New(Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_2.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_2.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10060 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_100_4 then
						iter_100_4.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10060 = nil
			end

			local var_100_5 = arg_97_1.actors_["1061"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps1061 == nil then
				arg_97_1.var_.actorSpriteComps1061 = var_100_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_6 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.actorSpriteComps1061 then
					for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_100_6 then
							if arg_97_1.isInRecall_ then
								iter_100_6.color = Color.New(Mathf.Lerp(iter_100_6.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_6), Mathf.Lerp(iter_100_6.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_6), (Mathf.Lerp(iter_100_6.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_6)))
							else
								local var_100_7 = Mathf.Lerp(iter_100_6.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_6)

								iter_100_6.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps1061 then
				for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_100_8 then
						iter_100_8.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1061 = nil
			end

			local var_100_8 = 0
			local var_100_9 = 0.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(410241024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 5 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 5)

				if (5 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 5)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241024", "story_v_out_410241.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241024", "story_v_out_410241.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_410241", "410241024", "story_v_out_410241.awb")

						arg_97_1:RecordAudio("410241024", var_100_15)
						arg_97_1:RecordAudio("410241024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410241", "410241024", "story_v_out_410241.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410241", "410241024", "story_v_out_410241.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play410241025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410241025
		arg_101_1.duration_ = 10.73

		local var_101_0 = {
			ja = 10.733,
			CriLanguages = 5.566,
			zh = 5.566
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
				arg_101_0:Play410241026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1061 = arg_101_1.actors_["1061"].transform.localPosition
				arg_101_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1061", 2)

				for iter_104_0 = 0, arg_101_1.actors_["1061"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["1061"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_104_2 = arg_101_1.actors_["10060"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10060 == nil then
				arg_101_1.var_.actorSpriteComps10060 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10060 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10060 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10060 = nil
			end

			local var_104_5 = arg_101_1.actors_["1061"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps1061 == nil then
				arg_101_1.var_.actorSpriteComps1061 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps1061 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								iter_104_6.color = Color.New(Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_6.color.r, 1, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_6.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps1061 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_104_8 then
						iter_104_8.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1061 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(410241025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 18 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 18)

				if (18 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 18)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241025", "story_v_out_410241.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241025", "story_v_out_410241.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_410241", "410241025", "story_v_out_410241.awb")

						arg_101_1:RecordAudio("410241025", var_104_15)
						arg_101_1:RecordAudio("410241025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410241", "410241025", "story_v_out_410241.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410241", "410241025", "story_v_out_410241.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play410241026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410241026
		arg_105_1.duration_ = 4.43

		local var_105_0 = {
			ja = 4.3,
			CriLanguages = 4.433,
			zh = 4.433
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
				arg_105_0:Play410241027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10060 = arg_105_1.actors_["10060"].transform.localPosition
				arg_105_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10060", 4)

				for iter_108_0 = 0, arg_105_1.actors_["10060"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10060"].transform:GetChild(iter_108_0)

					if var_108_0.name == "" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_108_2 = arg_105_1.actors_["10060"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10060 == nil then
				arg_105_1.var_.actorSpriteComps10060 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10060 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								iter_108_2.color = Color.New(Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_3), Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_3), (Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_3)))
							else
								local var_108_4 = Mathf.Lerp(iter_108_2.color.r, 1, (arg_105_1.time_ - 0) / var_108_3)

								iter_108_2.color = Color.New(var_108_4, var_108_4, var_108_4)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10060 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10060 = nil
			end

			local var_108_5 = arg_105_1.actors_["1061"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps1061 == nil then
				arg_105_1.var_.actorSpriteComps1061 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_6 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.actorSpriteComps1061 then
					for iter_108_5, iter_108_6 in pairs(arg_105_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_108_6 then
							if arg_105_1.isInRecall_ then
								iter_108_6.color = Color.New(Mathf.Lerp(iter_108_6.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_6), Mathf.Lerp(iter_108_6.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_6), (Mathf.Lerp(iter_108_6.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_6)))
							else
								local var_108_7 = Mathf.Lerp(iter_108_6.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_6)

								iter_108_6.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps1061 then
				for iter_108_7, iter_108_8 in pairs(arg_105_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_108_8 then
						iter_108_8.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps1061 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(410241026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 27 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 27)

				if (27 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 27)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241026", "story_v_out_410241.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241026", "story_v_out_410241.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_410241", "410241026", "story_v_out_410241.awb")

						arg_105_1:RecordAudio("410241026", var_108_15)
						arg_105_1:RecordAudio("410241026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410241", "410241026", "story_v_out_410241.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410241", "410241026", "story_v_out_410241.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play410241027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410241027
		arg_109_1.duration_ = 16.6

		local var_109_0 = {
			ja = 16.6,
			CriLanguages = 10.1,
			zh = 10.1
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
				arg_109_0:Play410241028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061 = arg_109_1.actors_["1061"].transform.localPosition
				arg_109_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1061", 2)

				for iter_112_0 = 0, arg_109_1.actors_["1061"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["1061"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_112_2 = arg_109_1.actors_["10060"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10060 == nil then
				arg_109_1.var_.actorSpriteComps10060 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps10060 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								iter_112_2.color = Color.New(Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_2.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_2.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10060 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps10060 = nil
			end

			local var_112_5 = arg_109_1.actors_["1061"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1061 == nil then
				arg_109_1.var_.actorSpriteComps1061 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps1061 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								iter_112_6.color = Color.New(Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_6), Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_6), (Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_6.color.r, 1, (arg_109_1.time_ - 0) / var_112_6)

								iter_112_6.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1061 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_112_8 then
						iter_112_8.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1061 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 1.05

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(410241027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 42 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 42)

				if (42 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 42)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241027", "story_v_out_410241.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241027", "story_v_out_410241.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_410241", "410241027", "story_v_out_410241.awb")

						arg_109_1:RecordAudio("410241027", var_112_15)
						arg_109_1:RecordAudio("410241027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410241", "410241027", "story_v_out_410241.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410241", "410241027", "story_v_out_410241.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play410241028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410241028
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			ja = 7.4,
			CriLanguages = 5.033,
			zh = 5.033
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play410241029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(410241028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 18)

				if (18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 18)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241028", "story_v_out_410241.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241028", "story_v_out_410241.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_410241", "410241028", "story_v_out_410241.awb")

						arg_113_1:RecordAudio("410241028", var_116_6)
						arg_113_1:RecordAudio("410241028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410241", "410241028", "story_v_out_410241.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410241", "410241028", "story_v_out_410241.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play410241029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410241029
		arg_117_1.duration_ = 6.37

		local var_117_0 = {
			ja = 6.366,
			CriLanguages = 6.3,
			zh = 6.3
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play410241030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10060 = arg_117_1.actors_["10060"].transform.localPosition
				arg_117_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10060", 4)

				for iter_120_0 = 0, arg_117_1.actors_["10060"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10060"].transform:GetChild(iter_120_0)

					if var_120_0.name == "split_3" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_120_2 = arg_117_1.actors_["10060"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10060 == nil then
				arg_117_1.var_.actorSpriteComps10060 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10060 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10060 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10060 = nil
			end

			local var_120_5 = arg_117_1.actors_["1061"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps1061 == nil then
				arg_117_1.var_.actorSpriteComps1061 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps1061 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								iter_120_6.color = Color.New(Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_6.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_6.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps1061 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_120_8 then
						iter_120_8.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps1061 = nil
			end

			local var_120_8 = 0
			local var_120_9 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(410241029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 23 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 23)

				if (23 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 23)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241029", "story_v_out_410241.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241029", "story_v_out_410241.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_410241", "410241029", "story_v_out_410241.awb")

						arg_117_1:RecordAudio("410241029", var_120_15)
						arg_117_1:RecordAudio("410241029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410241", "410241029", "story_v_out_410241.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410241", "410241029", "story_v_out_410241.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play410241030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410241030
		arg_121_1.duration_ = 6.2

		local var_121_0 = {
			ja = 6.2,
			CriLanguages = 3.3,
			zh = 3.3
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play410241031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1061 = arg_121_1.actors_["1061"].transform.localPosition
				arg_121_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1061", 2)

				for iter_124_0 = 0, arg_121_1.actors_["1061"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["1061"].transform:GetChild(iter_124_0)

					if var_124_0.name == "" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_124_2 = arg_121_1.actors_["10060"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10060 == nil then
				arg_121_1.var_.actorSpriteComps10060 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10060 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								iter_124_2.color = Color.New(Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_2.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_2.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10060 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_124_4 then
						iter_124_4.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10060 = nil
			end

			local var_124_5 = arg_121_1.actors_["1061"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1061 == nil then
				arg_121_1.var_.actorSpriteComps1061 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps1061 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								iter_124_6.color = Color.New(Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_6.color.r, 1, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_6.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1061 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_124_8 then
						iter_124_8.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps1061 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(410241030)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 8 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 8)

				if (8 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 8)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241030", "story_v_out_410241.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241030", "story_v_out_410241.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_410241", "410241030", "story_v_out_410241.awb")

						arg_121_1:RecordAudio("410241030", var_124_15)
						arg_121_1:RecordAudio("410241030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410241", "410241030", "story_v_out_410241.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410241", "410241030", "story_v_out_410241.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play410241031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410241031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play410241032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061 = arg_125_1.actors_["1061"].transform.localPosition
				arg_125_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1061", 7)

				for iter_128_0 = 0, arg_125_1.actors_["1061"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["1061"].transform:GetChild(iter_128_0)

					if var_128_0.name == "" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_128_2 = arg_125_1.actors_["10060"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10060 = var_128_2.localPosition
				var_128_2.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10060", 7)

				for iter_128_1 = 0, var_128_2.childCount - 1 do
					local var_128_3 = var_128_2:GetChild(iter_128_1)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_2.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_125_1.time_ - 0) / var_128_4)
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_5 = arg_125_1.actors_["1061"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps1061 == nil then
				arg_125_1.var_.actorSpriteComps1061 = var_128_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_6 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.actorSpriteComps1061 then
					for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_128_3 then
							if arg_125_1.isInRecall_ then
								iter_128_3.color = Color.New(Mathf.Lerp(iter_128_3.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_6), Mathf.Lerp(iter_128_3.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_6), (Mathf.Lerp(iter_128_3.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_6)))
							else
								local var_128_7 = Mathf.Lerp(iter_128_3.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_6)

								iter_128_3.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps1061 then
				for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_128_5 then
						iter_128_5.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps1061 = nil
			end

			local var_128_8 = arg_125_1.actors_["10060"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10060 == nil then
				arg_125_1.var_.actorSpriteComps10060 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.actorSpriteComps10060 then
					for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_128_7 then
							if arg_125_1.isInRecall_ then
								iter_128_7.color = Color.New(Mathf.Lerp(iter_128_7.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_9), Mathf.Lerp(iter_128_7.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_9), (Mathf.Lerp(iter_128_7.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_9)))
							else
								local var_128_10 = Mathf.Lerp(iter_128_7.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_9)

								iter_128_7.color = Color.New(var_128_10, var_128_10, var_128_10)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10060 then
				for iter_128_8, iter_128_9 in pairs(arg_125_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_128_9 then
						iter_128_9.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10060 = nil
			end

			local var_128_11 = 0
			local var_128_12 = 0.7

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_13 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(410241031).content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 28 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_13) / 28)

				if (28 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_13) / 28)) > 0 and var_128_12 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_16 and arg_125_1.time_ < var_128_11 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play410241032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410241032
		arg_129_1.duration_ = 23.3

		local var_129_0 = {
			ja = 23.3,
			CriLanguages = 20.3,
			zh = 20.3
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play410241033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1061 = arg_129_1.actors_["1061"].transform.localPosition
				arg_129_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1061", 3)

				for iter_132_0 = 0, arg_129_1.actors_["1061"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["1061"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_7" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_132_2 = arg_129_1.actors_["1061"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps1061 == nil then
				arg_129_1.var_.actorSpriteComps1061 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps1061 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								iter_132_2.color = Color.New(Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_2.color.r, 1, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_2.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps1061 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps1061 = nil
			end

			local var_132_5 = 0
			local var_132_6 = 1.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(410241032)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 61 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 61)

				if (61 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 61)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241032", "story_v_out_410241.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241032", "story_v_out_410241.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_410241", "410241032", "story_v_out_410241.awb")

						arg_129_1:RecordAudio("410241032", var_132_12)
						arg_129_1:RecordAudio("410241032", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410241", "410241032", "story_v_out_410241.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410241", "410241032", "story_v_out_410241.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410241033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410241033
		arg_133_1.duration_ = 14.97

		local var_133_0 = {
			ja = 14.966,
			CriLanguages = 9.466,
			zh = 9.466
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play410241034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1061 = arg_133_1.actors_["1061"].transform.localPosition
				arg_133_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1061", 3)

				for iter_136_0 = 0, arg_133_1.actors_["1061"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["1061"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_7" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_136_2 = arg_133_1.actors_["1061"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps1061 == nil then
				arg_133_1.var_.actorSpriteComps1061 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps1061 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps1061 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps1061 = nil
			end

			local var_136_5 = 0
			local var_136_6 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(410241033)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 39 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 39)

				if (39 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 39)) > 0 and var_136_6 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241033", "story_v_out_410241.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241033", "story_v_out_410241.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_410241", "410241033", "story_v_out_410241.awb")

						arg_133_1:RecordAudio("410241033", var_136_12)
						arg_133_1:RecordAudio("410241033", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410241", "410241033", "story_v_out_410241.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410241", "410241033", "story_v_out_410241.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_13 and arg_133_1.time_ < var_136_5 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play410241034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410241034
		arg_137_1.duration_ = 18.37

		local var_137_0 = {
			ja = 18.366,
			CriLanguages = 17.066,
			zh = 17.066
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play410241035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1061 = arg_137_1.actors_["1061"].transform.localPosition
				arg_137_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1061", 3)

				for iter_140_0 = 0, arg_137_1.actors_["1061"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1061"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_7" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_140_2 = arg_137_1.actors_["1061"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1061 == nil then
				arg_137_1.var_.actorSpriteComps1061 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps1061 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 1, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1061 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps1061 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 1.525

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(410241034)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 61 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 61)

				if (61 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 61)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241034", "story_v_out_410241.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241034", "story_v_out_410241.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_410241", "410241034", "story_v_out_410241.awb")

						arg_137_1:RecordAudio("410241034", var_140_12)
						arg_137_1:RecordAudio("410241034", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410241", "410241034", "story_v_out_410241.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410241", "410241034", "story_v_out_410241.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_13 and arg_137_1.time_ < var_140_5 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play410241035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410241035
		arg_141_1.duration_ = 18.1

		local var_141_0 = {
			ja = 16.533,
			CriLanguages = 18.1,
			zh = 18.1
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410241036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1061 = arg_141_1.actors_["1061"].transform.localPosition
				arg_141_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1061", 3)

				for iter_144_0 = 0, arg_141_1.actors_["1061"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["1061"].transform:GetChild(iter_144_0)

					if var_144_0.name == "split_7" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_144_2 = arg_141_1.actors_["1061"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1061 == nil then
				arg_141_1.var_.actorSpriteComps1061 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps1061 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 1, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1061 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps1061 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 1.225

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(410241035)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 48 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 48)

				if (48 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 48)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241035", "story_v_out_410241.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241035", "story_v_out_410241.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_410241", "410241035", "story_v_out_410241.awb")

						arg_141_1:RecordAudio("410241035", var_144_12)
						arg_141_1:RecordAudio("410241035", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410241", "410241035", "story_v_out_410241.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410241", "410241035", "story_v_out_410241.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play410241036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410241036
		arg_145_1.duration_ = 7.1

		local var_145_0 = {
			ja = 7.1,
			CriLanguages = 5.666,
			zh = 5.666
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410241037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1061 = arg_145_1.actors_["1061"].transform.localPosition
				arg_145_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1061", 3)

				for iter_148_0 = 0, arg_145_1.actors_["1061"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1061"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_7" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_148_2 = arg_145_1.actors_["1061"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1061 == nil then
				arg_145_1.var_.actorSpriteComps1061 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.034

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1061 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1061 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1061 = nil
			end

			local var_148_5 = 0
			local var_148_6 = 0.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:GetWordFromCfg(410241036)
				local var_148_8 = arg_145_1:FormatText(var_148_7.content)

				arg_145_1.text_.text = var_148_8

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 16 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 16)

				if (16 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 16)) > 0 and var_148_6 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_8
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241036", "story_v_out_410241.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241036", "story_v_out_410241.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_410241", "410241036", "story_v_out_410241.awb")

						arg_145_1:RecordAudio("410241036", var_148_12)
						arg_145_1:RecordAudio("410241036", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410241", "410241036", "story_v_out_410241.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410241", "410241036", "story_v_out_410241.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_13 and arg_145_1.time_ < var_148_5 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play410241037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410241037
		arg_149_1.duration_ = 8.9

		local var_149_0 = {
			ja = 8.9,
			CriLanguages = 8.4,
			zh = 8.4
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410241038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10060 = arg_149_1.actors_["10060"].transform.localPosition
				arg_149_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10060", 3)

				for iter_152_0 = 0, arg_149_1.actors_["10060"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["10060"].transform:GetChild(iter_152_0)

					if var_152_0.name == "split_3" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10060"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_152_2 = arg_149_1.actors_["10060"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10060 == nil then
				arg_149_1.var_.actorSpriteComps10060 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps10060 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								iter_152_2.color = Color.New(Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_2.color.r, 1, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_2.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10060 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10060 = nil
			end

			local var_152_5 = arg_149_1.actors_["1061"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1061 = var_152_5.localPosition
				var_152_5.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1061", 7)

				for iter_152_5 = 0, var_152_5.childCount - 1 do
					local var_152_6 = var_152_5:GetChild(iter_152_5)

					if var_152_6.name == "" or not string.find(var_152_6.name, "split") then
						var_152_6.gameObject:SetActive(true)
					else
						var_152_6.gameObject:SetActive(false)
					end
				end
			end

			local var_152_7 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				var_152_5.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_149_1.time_ - 0) / var_152_7)
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				var_152_5.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_152_8 = arg_149_1.actors_["1061"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps1061 == nil then
				arg_149_1.var_.actorSpriteComps1061 = var_152_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_9 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_9 and not isNil(var_152_8) then
				if arg_149_1.var_.actorSpriteComps1061 then
					for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_152_7 then
							if arg_149_1.isInRecall_ then
								iter_152_7.color = Color.New(Mathf.Lerp(iter_152_7.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_9), Mathf.Lerp(iter_152_7.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_9), (Mathf.Lerp(iter_152_7.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_9)))
							else
								local var_152_10 = Mathf.Lerp(iter_152_7.color.r, 1, (arg_149_1.time_ - 0) / var_152_9)

								iter_152_7.color = Color.New(var_152_10, var_152_10, var_152_10)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_9 and arg_149_1.time_ < 0 + var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps1061 then
				for iter_152_8, iter_152_9 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_152_9 then
						iter_152_9.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps1061 = nil
			end

			local var_152_11 = 0
			local var_152_12 = 0.825

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(410241037)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 33 <= 0 and var_152_12 or var_152_12 * (utf8.len(var_152_14) / 33)

				if (33 <= 0 and var_152_12 or var_152_12 * (utf8.len(var_152_14) / 33)) > 0 and var_152_12 < var_152_16 then
					arg_149_1.talkMaxDuration = var_152_16

					if var_152_16 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241037", "story_v_out_410241.awb") ~= 0 then
					local var_152_17 = manager.audio:GetVoiceLength("story_v_out_410241", "410241037", "story_v_out_410241.awb") / 1000

					if var_152_17 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_11
					end

					if var_152_13.prefab_name ~= "" and arg_149_1.actors_[var_152_13.prefab_name] ~= nil then
						local var_152_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_13.prefab_name].transform, "story_v_out_410241", "410241037", "story_v_out_410241.awb")

						arg_149_1:RecordAudio("410241037", var_152_18)
						arg_149_1:RecordAudio("410241037", var_152_18)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410241", "410241037", "story_v_out_410241.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410241", "410241037", "story_v_out_410241.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_19 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_19 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_19

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_19 and arg_149_1.time_ < var_152_11 + var_152_19 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play410241038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410241038
		arg_153_1.duration_ = 7.83

		local var_153_0 = {
			ja = 5.4,
			CriLanguages = 7.833,
			zh = 7.833
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play410241039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.7

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(410241038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 28 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 28)

				if (28 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 28)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241038", "story_v_out_410241.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241038", "story_v_out_410241.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_410241", "410241038", "story_v_out_410241.awb")

						arg_153_1:RecordAudio("410241038", var_156_6)
						arg_153_1:RecordAudio("410241038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410241", "410241038", "story_v_out_410241.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410241", "410241038", "story_v_out_410241.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play410241039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410241039
		arg_157_1.duration_ = 8.77

		local var_157_0 = {
			ja = 7.033,
			CriLanguages = 8.766,
			zh = 8.766
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
				arg_157_0:Play410241040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1061 = arg_157_1.actors_["1061"].transform.localPosition
				arg_157_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1061", 3)

				for iter_160_0 = 0, arg_157_1.actors_["1061"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["1061"].transform:GetChild(iter_160_0)

					if var_160_0.name == "" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_160_2 = arg_157_1.actors_["1061"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			local var_160_5 = arg_157_1.actors_["10060"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10060 = var_160_5.localPosition
				var_160_5.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10060", 7)

				for iter_160_5 = 0, var_160_5.childCount - 1 do
					local var_160_6 = var_160_5:GetChild(iter_160_5)

					if var_160_6.name == "split_3" or not string.find(var_160_6.name, "split") then
						var_160_6.gameObject:SetActive(true)
					else
						var_160_6.gameObject:SetActive(false)
					end
				end
			end

			local var_160_7 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 0) / var_160_7)
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_8 = 0
			local var_160_9 = 1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(410241039)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 40 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 40)

				if (40 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 40)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241039", "story_v_out_410241.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241039", "story_v_out_410241.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_410241", "410241039", "story_v_out_410241.awb")

						arg_157_1:RecordAudio("410241039", var_160_15)
						arg_157_1:RecordAudio("410241039", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410241", "410241039", "story_v_out_410241.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410241", "410241039", "story_v_out_410241.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play410241040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410241040
		arg_161_1.duration_ = 8.93

		local var_161_0 = {
			ja = 8.933,
			CriLanguages = 5.633,
			zh = 5.633
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
				arg_161_0:Play410241041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1061 = arg_161_1.actors_["1061"].transform.localPosition
				arg_161_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1061", 3)

				for iter_164_0 = 0, arg_161_1.actors_["1061"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["1061"].transform:GetChild(iter_164_0)

					if var_164_0.name == "" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_164_2 = arg_161_1.actors_["1061"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1061 == nil then
				arg_161_1.var_.actorSpriteComps1061 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps1061 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								iter_164_2.color = Color.New(Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_2.color.r, 1, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_2.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1061 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_164_4 then
						iter_164_4.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps1061 = nil
			end

			local var_164_5 = 0
			local var_164_6 = 0.6

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(410241040)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 24 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 24)

				if (24 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 24)) > 0 and var_164_6 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241040", "story_v_out_410241.awb") ~= 0 then
					local var_164_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241040", "story_v_out_410241.awb") / 1000

					if var_164_11 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_5
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_410241", "410241040", "story_v_out_410241.awb")

						arg_161_1:RecordAudio("410241040", var_164_12)
						arg_161_1:RecordAudio("410241040", var_164_12)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410241", "410241040", "story_v_out_410241.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410241", "410241040", "story_v_out_410241.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_13 and arg_161_1.time_ < var_164_5 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play410241041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410241041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410241042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1061 = arg_165_1.actors_["1061"].transform.localPosition
				arg_165_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1061", 7)

				for iter_168_0 = 0, arg_165_1.actors_["1061"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1061"].transform:GetChild(iter_168_0)

					if var_168_0.name == "" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_168_2 = arg_165_1.actors_["10060"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10060 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10060", 7)

				for iter_168_1 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_1)

					if var_168_3.name == "" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_168_5 = arg_165_1.actors_["1061"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps1061 == nil then
				arg_165_1.var_.actorSpriteComps1061 = var_168_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_6 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.actorSpriteComps1061 then
					for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_168_3 then
							if arg_165_1.isInRecall_ then
								iter_168_3.color = Color.New(Mathf.Lerp(iter_168_3.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_6), Mathf.Lerp(iter_168_3.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_6), (Mathf.Lerp(iter_168_3.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_6)))
							else
								local var_168_7 = Mathf.Lerp(iter_168_3.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_6)

								iter_168_3.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps1061 then
				for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_168_5 then
						iter_168_5.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1061 = nil
			end

			local var_168_8 = arg_165_1.actors_["10060"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.actorSpriteComps10060 == nil then
				arg_165_1.var_.actorSpriteComps10060 = var_168_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 and not isNil(var_168_8) then
				if arg_165_1.var_.actorSpriteComps10060 then
					for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_168_7 then
							if arg_165_1.isInRecall_ then
								iter_168_7.color = Color.New(Mathf.Lerp(iter_168_7.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_9), Mathf.Lerp(iter_168_7.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_9), (Mathf.Lerp(iter_168_7.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_9)))
							else
								local var_168_10 = Mathf.Lerp(iter_168_7.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_9)

								iter_168_7.color = Color.New(var_168_10, var_168_10, var_168_10)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.actorSpriteComps10060 then
				for iter_168_8, iter_168_9 in pairs(arg_165_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_168_9 then
						iter_168_9.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps10060 = nil
			end

			local var_168_11 = 0
			local var_168_12 = 0.775

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_13 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(410241041).content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 31 <= 0 and var_168_12 or var_168_12 * (utf8.len(var_168_13) / 31)

				if (31 <= 0 and var_168_12 or var_168_12 * (utf8.len(var_168_13) / 31)) > 0 and var_168_12 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_11
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_12, arg_165_1.talkMaxDuration)

			if var_168_11 <= arg_165_1.time_ and arg_165_1.time_ < var_168_11 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_11) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_11 + var_168_16 and arg_165_1.time_ < var_168_11 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play410241042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410241042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410241043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.95

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(410241042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 38 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 38)

				if (38 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 38)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play410241043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410241043
		arg_173_1.duration_ = 10.3

		local var_173_0 = {
			ja = 1.566,
			CriLanguages = 10.3,
			zh = 10.3
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
				arg_173_0:Play410241044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1061 = arg_173_1.actors_["1061"].transform.localPosition
				arg_173_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1061", 3)

				for iter_176_0 = 0, arg_173_1.actors_["1061"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["1061"].transform:GetChild(iter_176_0)

					if var_176_0.name == "" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_176_2 = arg_173_1.actors_["1061"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1061 == nil then
				arg_173_1.var_.actorSpriteComps1061 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps1061 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								iter_176_2.color = Color.New(Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_2.color.r, 1, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_2.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1061 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps1061 = nil
			end

			local var_176_5 = 0
			local var_176_6 = 0.05

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_7 = arg_173_1:GetWordFromCfg(410241043)
				local var_176_8 = arg_173_1:FormatText(var_176_7.content)

				arg_173_1.text_.text = var_176_8

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_10 = 2 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 2)

				if (2 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 2)) > 0 and var_176_6 < var_176_10 then
					arg_173_1.talkMaxDuration = var_176_10

					if var_176_10 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_8
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241043", "story_v_out_410241.awb") ~= 0 then
					local var_176_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241043", "story_v_out_410241.awb") / 1000

					if var_176_11 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_5
					end

					if var_176_7.prefab_name ~= "" and arg_173_1.actors_[var_176_7.prefab_name] ~= nil then
						local var_176_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_7.prefab_name].transform, "story_v_out_410241", "410241043", "story_v_out_410241.awb")

						arg_173_1:RecordAudio("410241043", var_176_12)
						arg_173_1:RecordAudio("410241043", var_176_12)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410241", "410241043", "story_v_out_410241.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410241", "410241043", "story_v_out_410241.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_13 and arg_173_1.time_ < var_176_5 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play410241044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410241044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play410241045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1061"]) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = arg_177_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1061"]) then
				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1061"]) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_2 = 0
			local var_180_3 = 1.175

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(410241044).content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 47 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 47)

				if (47 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 47)) > 0 and var_180_3 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_7 and arg_177_1.time_ < var_180_2 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play410241045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410241045
		arg_181_1.duration_ = 8.13

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410241046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1061 = arg_181_1.actors_["1061"].transform.localPosition
				arg_181_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1061", 3)

				for iter_184_0 = 0, arg_181_1.actors_["1061"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["1061"].transform:GetChild(iter_184_0)

					if var_184_0.name == "split_7" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_184_2 = arg_181_1.actors_["1061"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1061 == nil then
				arg_181_1.var_.actorSpriteComps1061 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1061 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								iter_184_2.color = Color.New(Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_2.color.r, 1, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_2.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1061 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1061 = nil
			end

			local var_184_5 = 0
			local var_184_6 = 0.675

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_7 = arg_181_1:GetWordFromCfg(410241045)
				local var_184_8 = arg_181_1:FormatText(var_184_7.content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 27 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 27)

				if (27 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 27)) > 0 and var_184_6 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241045", "story_v_out_410241.awb") ~= 0 then
					local var_184_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241045", "story_v_out_410241.awb") / 1000

					if var_184_11 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_5
					end

					if var_184_7.prefab_name ~= "" and arg_181_1.actors_[var_184_7.prefab_name] ~= nil then
						local var_184_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_7.prefab_name].transform, "story_v_out_410241", "410241045", "story_v_out_410241.awb")

						arg_181_1:RecordAudio("410241045", var_184_12)
						arg_181_1:RecordAudio("410241045", var_184_12)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410241", "410241045", "story_v_out_410241.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410241", "410241045", "story_v_out_410241.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_13 and arg_181_1.time_ < var_184_5 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play410241046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410241046
		arg_185_1.duration_ = 13.67

		local var_185_0 = {
			ja = 8.533,
			CriLanguages = 13.666,
			zh = 13.666
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410241047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1061 = arg_185_1.actors_["1061"].transform.localPosition
				arg_185_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1061", 3)

				for iter_188_0 = 0, arg_185_1.actors_["1061"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["1061"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_7" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_188_2 = arg_185_1.actors_["1061"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps1061 == nil then
				arg_185_1.var_.actorSpriteComps1061 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps1061 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 1, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps1061 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps1061 = nil
			end

			local var_188_5 = 0
			local var_188_6 = 0.75

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:GetWordFromCfg(410241046)
				local var_188_8 = arg_185_1:FormatText(var_188_7.content)

				arg_185_1.text_.text = var_188_8

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 30 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_8) / 30)

				if (30 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_8) / 30)) > 0 and var_188_6 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_8
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241046", "story_v_out_410241.awb") ~= 0 then
					local var_188_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241046", "story_v_out_410241.awb") / 1000

					if var_188_11 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_5
					end

					if var_188_7.prefab_name ~= "" and arg_185_1.actors_[var_188_7.prefab_name] ~= nil then
						local var_188_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_7.prefab_name].transform, "story_v_out_410241", "410241046", "story_v_out_410241.awb")

						arg_185_1:RecordAudio("410241046", var_188_12)
						arg_185_1:RecordAudio("410241046", var_188_12)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410241", "410241046", "story_v_out_410241.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410241", "410241046", "story_v_out_410241.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_13 and arg_185_1.time_ < var_188_5 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410241047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410241047
		arg_189_1.duration_ = 5.7

		local var_189_0 = {
			ja = 5.7,
			CriLanguages = 2.4,
			zh = 2.4
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410241048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1061 = arg_189_1.actors_["1061"].transform.localPosition
				arg_189_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1061", 3)

				for iter_192_0 = 0, arg_189_1.actors_["1061"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1061"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_9" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_192_2 = arg_189_1.actors_["1061"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps1061 == nil then
				arg_189_1.var_.actorSpriteComps1061 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps1061 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								iter_192_2.color = Color.New(Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_2.color.r, 1, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_2.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps1061 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1061 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.325

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(410241047)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 13 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 13)

				if (13 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 13)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241047", "story_v_out_410241.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241047", "story_v_out_410241.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_410241", "410241047", "story_v_out_410241.awb")

						arg_189_1:RecordAudio("410241047", var_192_12)
						arg_189_1:RecordAudio("410241047", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410241", "410241047", "story_v_out_410241.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410241", "410241047", "story_v_out_410241.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play410241048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410241048
		arg_193_1.duration_ = 9

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play410241049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				local var_196_0 = arg_193_1.bgs_.ST67

				arg_193_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_1 = var_196_0:GetComponent("SpriteRenderer")

				if var_196_1 and var_196_1.sprite then
					local var_196_2 = 2 * (var_196_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_0.transform.localScale = Vector3.New(var_196_2 / var_196_1.sprite.bounds.size.y < var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x and var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x or var_196_2 / var_196_1.sprite.bounds.size.y, var_196_2 / var_196_1.sprite.bounds.size.y < var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x and var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x or var_196_2 / var_196_1.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST67" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_3 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_4 = 2

			if var_196_3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_3 + var_196_4 then
				local var_196_5 = Color.New(0, 0, 0)

				var_196_5.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_3) / var_196_4)
				arg_193_1.mask_.color = var_196_5
			end

			if arg_193_1.time_ >= var_196_3 + var_196_4 and arg_193_1.time_ < var_196_3 + var_196_4 + arg_196_0 then
				local var_196_6 = Color.New(0, 0, 0)

				var_196_6.a = 1
				arg_193_1.mask_.color = var_196_6
			end

			local var_196_7 = 2

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_8 = 2

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 then
				local var_196_9 = Color.New(0, 0, 0)

				var_196_9.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_7) / var_196_8)
				arg_193_1.mask_.color = var_196_9
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 then
				local var_196_10 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_10.a = 0
				arg_193_1.mask_.color = var_196_10
			end

			local var_196_11 = arg_193_1.actors_["1061"].transform

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				arg_193_1.var_.moveOldPos1061 = var_196_11.localPosition
				var_196_11.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1061", 7)

				for iter_196_2 = 0, var_196_11.childCount - 1 do
					local var_196_12 = var_196_11:GetChild(iter_196_2)

					if var_196_12.name == "" or not string.find(var_196_12.name, "split") then
						var_196_12.gameObject:SetActive(true)
					else
						var_196_12.gameObject:SetActive(false)
					end
				end
			end

			local var_196_13 = 0.001

			if 2 <= arg_193_1.time_ and arg_193_1.time_ < 2 + var_196_13 then
				var_196_11.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_193_1.time_ - 2) / var_196_13)
			end

			if arg_193_1.time_ >= 2 + var_196_13 and arg_193_1.time_ < 2 + var_196_13 + arg_196_0 then
				var_196_11.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_196_14 = arg_193_1.actors_["1061"]

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.actorSpriteComps1061 == nil then
				arg_193_1.var_.actorSpriteComps1061 = var_196_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_15 = 0.034

			if 2 <= arg_193_1.time_ and arg_193_1.time_ < 2 + var_196_15 and not isNil(var_196_14) then
				if arg_193_1.var_.actorSpriteComps1061 then
					for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_196_4 then
							if arg_193_1.isInRecall_ then
								iter_196_4.color = Color.New(Mathf.Lerp(iter_196_4.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 2) / var_196_15), Mathf.Lerp(iter_196_4.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 2) / var_196_15), (Mathf.Lerp(iter_196_4.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 2) / var_196_15)))
							else
								local var_196_16 = Mathf.Lerp(iter_196_4.color.r, 0.5, (arg_193_1.time_ - 2) / var_196_15)

								iter_196_4.color = Color.New(var_196_16, var_196_16, var_196_16)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 2 + var_196_15 and arg_193_1.time_ < 2 + var_196_15 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.actorSpriteComps1061 then
				for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_196_6 then
						iter_196_6.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1061 = nil
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_17 = 4
			local var_196_18 = 1.35

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_17 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_19 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_19:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_20 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(410241048).content)

				arg_193_1.text_.text = var_196_20

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_22 = 54 <= 0 and var_196_18 or var_196_18 * (utf8.len(var_196_20) / 54)

				if (54 <= 0 and var_196_18 or var_196_18 * (utf8.len(var_196_20) / 54)) > 0 and var_196_18 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22
					var_196_17 = var_196_17 + 0.3

					if var_196_22 + var_196_17 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_17
					end
				end

				arg_193_1.text_.text = var_196_20
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_23 = var_196_17 + 0.3
			local var_196_24 = math.max(var_196_18, arg_193_1.talkMaxDuration)

			if var_196_17 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_24 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_23) / var_196_24

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_23 + var_196_24 and arg_193_1.time_ < var_196_23 + var_196_24 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play410241049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410241049
		arg_199_1.duration_ = 2.7

		local var_199_0 = {
			ja = 2.7,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_199_0:Play410241050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1061 = arg_199_1.actors_["1061"].transform.localPosition
				arg_199_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1061", 3)

				for iter_202_0 = 0, arg_199_1.actors_["1061"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["1061"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_202_2 = arg_199_1.actors_["1061"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1061 == nil then
				arg_199_1.var_.actorSpriteComps1061 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.034

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps1061 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								iter_202_2.color = Color.New(Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_2.color.r, 1, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_2.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1061 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps1061 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 0.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(410241049)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 6 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 6)

				if (6 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 6)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241049", "story_v_out_410241.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241049", "story_v_out_410241.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_410241", "410241049", "story_v_out_410241.awb")

						arg_199_1:RecordAudio("410241049", var_202_12)
						arg_199_1:RecordAudio("410241049", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410241", "410241049", "story_v_out_410241.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410241", "410241049", "story_v_out_410241.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_13 and arg_199_1.time_ < var_202_5 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play410241050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410241050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play410241051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1061"]) and arg_203_1.var_.actorSpriteComps1061 == nil then
				arg_203_1.var_.actorSpriteComps1061 = arg_203_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.034

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1061"]) then
				if arg_203_1.var_.actorSpriteComps1061 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1061"]) and arg_203_1.var_.actorSpriteComps1061 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps1061 = nil
			end

			local var_206_2 = 0
			local var_206_3 = 1.15

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(410241050).content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 46 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 46)

				if (46 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 46)) > 0 and var_206_3 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_7 and arg_203_1.time_ < var_206_2 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play410241051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 410241051
		arg_207_1.duration_ = 20.23

		local var_207_0 = {
			ja = 20.233,
			CriLanguages = 14.033,
			zh = 14.033
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
				arg_207_0:Play410241052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1061 = arg_207_1.actors_["1061"].transform.localPosition
				arg_207_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1061", 3)

				for iter_210_0 = 0, arg_207_1.actors_["1061"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["1061"].transform:GetChild(iter_210_0)

					if var_210_0.name == "" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_210_2 = arg_207_1.actors_["1061"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps1061 == nil then
				arg_207_1.var_.actorSpriteComps1061 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 0.034

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps1061 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								iter_210_2.color = Color.New(Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_2.color.r, 1, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_2.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps1061 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_210_4 then
						iter_210_4.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps1061 = nil
			end

			local var_210_5 = 0
			local var_210_6 = 1.2

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(410241051)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 48 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 48)

				if (48 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 48)) > 0 and var_210_6 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241051", "story_v_out_410241.awb") ~= 0 then
					local var_210_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241051", "story_v_out_410241.awb") / 1000

					if var_210_11 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_5
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_410241", "410241051", "story_v_out_410241.awb")

						arg_207_1:RecordAudio("410241051", var_210_12)
						arg_207_1:RecordAudio("410241051", var_210_12)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_410241", "410241051", "story_v_out_410241.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_410241", "410241051", "story_v_out_410241.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_13 and arg_207_1.time_ < var_210_5 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play410241052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 410241052
		arg_211_1.duration_ = 6.37

		local var_211_0 = {
			ja = 6.2,
			CriLanguages = 6.366,
			zh = 6.366
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
				arg_211_0:Play410241053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061 = arg_211_1.actors_["1061"].transform.localPosition
				arg_211_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1061", 3)

				for iter_214_0 = 0, arg_211_1.actors_["1061"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["1061"].transform:GetChild(iter_214_0)

					if var_214_0.name == "" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_211_1.time_ - 0) / var_214_1)
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_214_2 = arg_211_1.actors_["1061"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1061 == nil then
				arg_211_1.var_.actorSpriteComps1061 = var_214_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_3 = 0.034

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.actorSpriteComps1061 then
					for iter_214_1, iter_214_2 in pairs(arg_211_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_214_2 then
							if arg_211_1.isInRecall_ then
								iter_214_2.color = Color.New(Mathf.Lerp(iter_214_2.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_3), Mathf.Lerp(iter_214_2.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_3), (Mathf.Lerp(iter_214_2.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_3)))
							else
								local var_214_4 = Mathf.Lerp(iter_214_2.color.r, 1, (arg_211_1.time_ - 0) / var_214_3)

								iter_214_2.color = Color.New(var_214_4, var_214_4, var_214_4)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1061 then
				for iter_214_3, iter_214_4 in pairs(arg_211_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_214_4 then
						iter_214_4.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps1061 = nil
			end

			local var_214_5 = 0
			local var_214_6 = 0.55

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:GetWordFromCfg(410241052)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 22 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 22)

				if (22 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 22)) > 0 and var_214_6 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241052", "story_v_out_410241.awb") ~= 0 then
					local var_214_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241052", "story_v_out_410241.awb") / 1000

					if var_214_11 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_5
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_410241", "410241052", "story_v_out_410241.awb")

						arg_211_1:RecordAudio("410241052", var_214_12)
						arg_211_1:RecordAudio("410241052", var_214_12)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_410241", "410241052", "story_v_out_410241.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_410241", "410241052", "story_v_out_410241.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_13 and arg_211_1.time_ < var_214_5 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play410241053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410241053
		arg_215_1.duration_ = 5.23

		local var_215_0 = {
			ja = 5.233,
			CriLanguages = 3.766,
			zh = 3.766
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
				arg_215_0:Play410241054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1061 = arg_215_1.actors_["1061"].transform.localPosition
				arg_215_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1061", 3)

				for iter_218_0 = 0, arg_215_1.actors_["1061"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["1061"].transform:GetChild(iter_218_0)

					if var_218_0.name == "split_5" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_215_1.time_ - 0) / var_218_1)
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_218_2 = arg_215_1.actors_["1061"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1061 == nil then
				arg_215_1.var_.actorSpriteComps1061 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 0.034

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps1061 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_218_2 then
							if arg_215_1.isInRecall_ then
								iter_218_2.color = Color.New(Mathf.Lerp(iter_218_2.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_3), Mathf.Lerp(iter_218_2.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_3), (Mathf.Lerp(iter_218_2.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_3)))
							else
								local var_218_4 = Mathf.Lerp(iter_218_2.color.r, 1, (arg_215_1.time_ - 0) / var_218_3)

								iter_218_2.color = Color.New(var_218_4, var_218_4, var_218_4)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1061 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_218_4 then
						iter_218_4.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1061 = nil
			end

			local var_218_5 = 0
			local var_218_6 = 0.25

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:GetWordFromCfg(410241053)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 10 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 10)

				if (10 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 10)) > 0 and var_218_6 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241053", "story_v_out_410241.awb") ~= 0 then
					local var_218_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241053", "story_v_out_410241.awb") / 1000

					if var_218_11 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_5
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_410241", "410241053", "story_v_out_410241.awb")

						arg_215_1:RecordAudio("410241053", var_218_12)
						arg_215_1:RecordAudio("410241053", var_218_12)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_410241", "410241053", "story_v_out_410241.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_410241", "410241053", "story_v_out_410241.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_13 and arg_215_1.time_ < var_218_5 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play410241054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410241054
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play410241055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.bgs_.LZ0206 == nil then
				local var_222_0 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LZ0206")
				var_222_0.name = "LZ0206"
				var_222_0.transform.parent = arg_219_1.stage_.transform
				var_222_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_.LZ0206 = var_222_0
			end

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_1 = arg_219_1.bgs_.LZ0206

				arg_219_1.bgs_.LZ0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_2 = var_222_1:GetComponent("SpriteRenderer")

				if var_222_2 and var_222_2.sprite then
					local var_222_3 = 2 * (var_222_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_1.transform.localScale = Vector3.New(var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "LZ0206" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_4 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_5 = 2

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_5 then
				local var_222_6 = Color.New(0, 0, 0)

				var_222_6.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_4) / var_222_5)
				arg_219_1.mask_.color = var_222_6
			end

			if arg_219_1.time_ >= var_222_4 + var_222_5 and arg_219_1.time_ < var_222_4 + var_222_5 + arg_222_0 then
				local var_222_7 = Color.New(0, 0, 0)

				var_222_7.a = 1
				arg_219_1.mask_.color = var_222_7
			end

			local var_222_8 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_9 = 2

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_9 then
				local var_222_10 = Color.New(0, 0, 0)

				var_222_10.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_8) / var_222_9)
				arg_219_1.mask_.color = var_222_10
			end

			if arg_219_1.time_ >= var_222_8 + var_222_9 and arg_219_1.time_ < var_222_8 + var_222_9 + arg_222_0 then
				local var_222_11 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_11.a = 0
				arg_219_1.mask_.color = var_222_11
			end

			local var_222_12 = arg_219_1.actors_["1061"].transform

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				arg_219_1.var_.moveOldPos1061 = var_222_12.localPosition
				var_222_12.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1061", 7)

				for iter_222_2 = 0, var_222_12.childCount - 1 do
					local var_222_13 = var_222_12:GetChild(iter_222_2)

					if var_222_13.name == "" or not string.find(var_222_13.name, "split") then
						var_222_13.gameObject:SetActive(true)
					else
						var_222_13.gameObject:SetActive(false)
					end
				end
			end

			local var_222_14 = 0.001

			if 2 <= arg_219_1.time_ and arg_219_1.time_ < 2 + var_222_14 then
				var_222_12.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_219_1.time_ - 2) / var_222_14)
			end

			if arg_219_1.time_ >= 2 + var_222_14 and arg_219_1.time_ < 2 + var_222_14 + arg_222_0 then
				var_222_12.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_222_15 = arg_219_1.actors_["1061"]

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 and not isNil(var_222_15) and arg_219_1.var_.actorSpriteComps1061 == nil then
				arg_219_1.var_.actorSpriteComps1061 = var_222_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_16 = 0.034

			if 2 <= arg_219_1.time_ and arg_219_1.time_ < 2 + var_222_16 and not isNil(var_222_15) then
				if arg_219_1.var_.actorSpriteComps1061 then
					for iter_222_3, iter_222_4 in pairs(arg_219_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_222_4 then
							if arg_219_1.isInRecall_ then
								iter_222_4.color = Color.New(Mathf.Lerp(iter_222_4.color.r, arg_219_1.hightColor2.r, (arg_219_1.time_ - 2) / var_222_16), Mathf.Lerp(iter_222_4.color.g, arg_219_1.hightColor2.g, (arg_219_1.time_ - 2) / var_222_16), (Mathf.Lerp(iter_222_4.color.b, arg_219_1.hightColor2.b, (arg_219_1.time_ - 2) / var_222_16)))
							else
								local var_222_17 = Mathf.Lerp(iter_222_4.color.r, 0.5, (arg_219_1.time_ - 2) / var_222_16)

								iter_222_4.color = Color.New(var_222_17, var_222_17, var_222_17)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 2 + var_222_16 and arg_219_1.time_ < 2 + var_222_16 + arg_222_0 and not isNil(var_222_15) and arg_219_1.var_.actorSpriteComps1061 then
				for iter_222_5, iter_222_6 in pairs(arg_219_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_222_6 then
						iter_222_6.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps1061 = nil
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story_129", "se_story_129_information_magic", "")
			end

			local var_222_19 = arg_219_1.bgs_.LZ0206.transform

			if 2.034 < arg_219_1.time_ and arg_219_1.time_ <= 2.034 + arg_222_0 then
				arg_219_1.var_.moveOldPosLZ0206 = var_222_19.localPosition
			end

			local var_222_20 = 0.001

			if 2.034 <= arg_219_1.time_ and arg_219_1.time_ < 2.034 + var_222_20 then
				var_222_19.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosLZ0206, Vector3.New(0, 1, 10), (arg_219_1.time_ - 2.034) / var_222_20)
			end

			if arg_219_1.time_ >= 2.034 + var_222_20 and arg_219_1.time_ < 2.034 + var_222_20 + arg_222_0 then
				var_222_19.localPosition = Vector3.New(0, 1, 10)
			end

			local var_222_21 = arg_219_1.bgs_.LZ0206.transform

			if 2.068 < arg_219_1.time_ and arg_219_1.time_ <= 2.068 + arg_222_0 then
				arg_219_1.var_.moveOldPosLZ0206 = var_222_21.localPosition
			end

			local var_222_22 = 5

			if 2.068 <= arg_219_1.time_ and arg_219_1.time_ < 2.068 + var_222_22 then
				var_222_21.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosLZ0206, Vector3.New(0, 1, 9), (arg_219_1.time_ - 2.068) / var_222_22)
			end

			if arg_219_1.time_ >= 2.068 + var_222_22 and arg_219_1.time_ < 2.068 + var_222_22 + arg_222_0 then
				var_222_21.localPosition = Vector3.New(0, 1, 9)
			end

			local var_222_23 = 4

			if 4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_23 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= var_222_23 + 3.068 and arg_219_1.time_ < var_222_23 + 3.068 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_24 = 4
			local var_222_25 = 1.7

			if 4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_24 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_26 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_26:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_27 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(410241054).content)

				arg_219_1.text_.text = var_222_27

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_29 = 68 <= 0 and var_222_25 or var_222_25 * (utf8.len(var_222_27) / 68)

				if (68 <= 0 and var_222_25 or var_222_25 * (utf8.len(var_222_27) / 68)) > 0 and var_222_25 < var_222_29 then
					arg_219_1.talkMaxDuration = var_222_29
					var_222_24 = var_222_24 + 0.3

					if var_222_29 + var_222_24 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_29 + var_222_24
					end
				end

				arg_219_1.text_.text = var_222_27
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_30 = var_222_24 + 0.3
			local var_222_31 = math.max(var_222_25, arg_219_1.talkMaxDuration)

			if var_222_24 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_30 + var_222_31 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_30) / var_222_31

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_30 + var_222_31 and arg_219_1.time_ < var_222_30 + var_222_31 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "LZ0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LZ0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.068,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play410241055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410241055
		arg_225_1.duration_ = 14.3

		local var_225_0 = {
			ja = 14.3,
			CriLanguages = 11.7,
			zh = 11.7
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
				arg_225_0:Play410241056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.875

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

				local var_228_1 = arg_225_1:GetWordFromCfg(410241055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 35 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 35)

				if (35 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 35)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241055", "story_v_out_410241.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241055", "story_v_out_410241.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_410241", "410241055", "story_v_out_410241.awb")

						arg_225_1:RecordAudio("410241055", var_228_6)
						arg_225_1:RecordAudio("410241055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410241", "410241055", "story_v_out_410241.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410241", "410241055", "story_v_out_410241.awb")
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
	Play410241056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410241056
		arg_229_1.duration_ = 6.8

		local var_229_0 = {
			ja = 6.8,
			CriLanguages = 6.5,
			zh = 6.5
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
				arg_229_0:Play410241057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.575

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(410241056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 23 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 23)

				if (23 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 23)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241056", "story_v_out_410241.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241056", "story_v_out_410241.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_410241", "410241056", "story_v_out_410241.awb")

						arg_229_1:RecordAudio("410241056", var_232_6)
						arg_229_1:RecordAudio("410241056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410241", "410241056", "story_v_out_410241.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410241", "410241056", "story_v_out_410241.awb")
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
	Play410241057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410241057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410241058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.625

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(410241057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 65 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 65)

				if (65 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 65)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play410241058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410241058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410241059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.45

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

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(410241058).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 58 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 58)

				if (58 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 58)) > 0 and var_240_0 < var_240_3 then
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
	Play410241059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410241059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play410241060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1.125

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(410241059).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 45 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 45)

				if (45 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 45)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play410241060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410241060
		arg_245_1.duration_ = 2.63

		local var_245_0 = {
			ja = 2.266,
			CriLanguages = 2.633,
			zh = 2.633
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410241061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(410241060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 5 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 5)

				if (5 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 5)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241060", "story_v_out_410241.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_410241", "410241060", "story_v_out_410241.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_410241", "410241060", "story_v_out_410241.awb")

						arg_245_1:RecordAudio("410241060", var_248_6)
						arg_245_1:RecordAudio("410241060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410241", "410241060", "story_v_out_410241.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410241", "410241060", "story_v_out_410241.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410241061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410241061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play410241062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.925

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(410241061).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 37 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 37)

				if (37 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 37)) > 0 and var_252_0 < var_252_3 then
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
	Play410241062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410241062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410241063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.375

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(410241062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 55 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 55)

				if (55 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 55)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410241063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410241063
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410241064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if arg_257_1.bgs_.L04h == nil then
				local var_260_0 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L04h")
				var_260_0.name = "L04h"
				var_260_0.transform.parent = arg_257_1.stage_.transform
				var_260_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_.L04h = var_260_0
			end

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				local var_260_1 = arg_257_1.bgs_.L04h

				arg_257_1.bgs_.L04h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_2 = var_260_1:GetComponent("SpriteRenderer")

				if var_260_2 and var_260_2.sprite then
					local var_260_3 = 2 * (var_260_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_1.transform.localScale = Vector3.New(var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "L04h" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_4 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_5 = 2

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_5 then
				local var_260_6 = Color.New(0, 0, 0)

				var_260_6.a = Mathf.Lerp(0, 1, (arg_257_1.time_ - var_260_4) / var_260_5)
				arg_257_1.mask_.color = var_260_6
			end

			if arg_257_1.time_ >= var_260_4 + var_260_5 and arg_257_1.time_ < var_260_4 + var_260_5 + arg_260_0 then
				local var_260_7 = Color.New(0, 0, 0)

				var_260_7.a = 1
				arg_257_1.mask_.color = var_260_7
			end

			local var_260_8 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_9 = 2

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 then
				local var_260_10 = Color.New(0, 0, 0)

				var_260_10.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_8) / var_260_9)
				arg_257_1.mask_.color = var_260_10
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 then
				local var_260_11 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_11.a = 0
				arg_257_1.mask_.color = var_260_11
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_12 = 4
			local var_260_13 = 1.425

			if 4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_14 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_14:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_15 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(410241063).content)

				arg_257_1.text_.text = var_260_15

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 57 <= 0 and var_260_13 or var_260_13 * (utf8.len(var_260_15) / 57)

				if (57 <= 0 and var_260_13 or var_260_13 * (utf8.len(var_260_15) / 57)) > 0 and var_260_13 < var_260_17 then
					arg_257_1.talkMaxDuration = var_260_17
					var_260_12 = var_260_12 + 0.3

					if var_260_17 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_17 + var_260_12
					end
				end

				arg_257_1.text_.text = var_260_15
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_18 = var_260_12 + 0.3
			local var_260_19 = math.max(var_260_13, arg_257_1.talkMaxDuration)

			if var_260_12 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_18 + var_260_19 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_18) / var_260_19

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_18 + var_260_19 and arg_257_1.time_ < var_260_18 + var_260_19 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play410241064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 410241064
		arg_263_1.duration_ = 2.37

		local var_263_0 = {
			ja = 2.366,
			CriLanguages = 1.6,
			zh = 1.6
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
				arg_263_0:Play410241065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1061 = arg_263_1.actors_["1061"].transform.localPosition
				arg_263_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1061", 3)

				for iter_266_0 = 0, arg_263_1.actors_["1061"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["1061"].transform:GetChild(iter_266_0)

					if var_266_0.name == "" or not string.find(var_266_0.name, "split") then
						var_266_0.gameObject:SetActive(true)
					else
						var_266_0.gameObject:SetActive(false)
					end
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_263_1.time_ - 0) / var_266_1)
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_266_2 = arg_263_1.actors_["1061"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps1061 == nil then
				arg_263_1.var_.actorSpriteComps1061 = var_266_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_3 = 0.034

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_3 and not isNil(var_266_2) then
				if arg_263_1.var_.actorSpriteComps1061 then
					for iter_266_1, iter_266_2 in pairs(arg_263_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_266_2 then
							if arg_263_1.isInRecall_ then
								iter_266_2.color = Color.New(Mathf.Lerp(iter_266_2.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_3), Mathf.Lerp(iter_266_2.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_3), (Mathf.Lerp(iter_266_2.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_3)))
							else
								local var_266_4 = Mathf.Lerp(iter_266_2.color.r, 1, (arg_263_1.time_ - 0) / var_266_3)

								iter_266_2.color = Color.New(var_266_4, var_266_4, var_266_4)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_3 and arg_263_1.time_ < 0 + var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps1061 then
				for iter_266_3, iter_266_4 in pairs(arg_263_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_266_4 then
						iter_266_4.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps1061 = nil
			end

			local var_266_5 = 0
			local var_266_6 = 0.2

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(410241064)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 8 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 8)

				if (8 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 8)) > 0 and var_266_6 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241064", "story_v_out_410241.awb") ~= 0 then
					local var_266_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241064", "story_v_out_410241.awb") / 1000

					if var_266_11 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_5
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_410241", "410241064", "story_v_out_410241.awb")

						arg_263_1:RecordAudio("410241064", var_266_12)
						arg_263_1:RecordAudio("410241064", var_266_12)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_410241", "410241064", "story_v_out_410241.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_410241", "410241064", "story_v_out_410241.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_6, arg_263_1.talkMaxDuration)

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_5) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_5 + var_266_13 and arg_263_1.time_ < var_266_5 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play410241065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 410241065
		arg_267_1.duration_ = 5.63

		local var_267_0 = {
			ja = 5.633,
			CriLanguages = 5.4,
			zh = 5.4
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
				arg_267_0:Play410241066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1061 = arg_267_1.actors_["1061"].transform.localPosition
				arg_267_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1061", 3)

				for iter_270_0 = 0, arg_267_1.actors_["1061"].transform.childCount - 1 do
					local var_270_0 = arg_267_1.actors_["1061"].transform:GetChild(iter_270_0)

					if var_270_0.name == "" or not string.find(var_270_0.name, "split") then
						var_270_0.gameObject:SetActive(true)
					else
						var_270_0.gameObject:SetActive(false)
					end
				end
			end

			local var_270_1 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 then
				arg_267_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_267_1.time_ - 0) / var_270_1)
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 then
				arg_267_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_270_2 = arg_267_1.actors_["1061"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1061 == nil then
				arg_267_1.var_.actorSpriteComps1061 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 0.034

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps1061 then
					for iter_270_1, iter_270_2 in pairs(arg_267_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_270_2 then
							if arg_267_1.isInRecall_ then
								iter_270_2.color = Color.New(Mathf.Lerp(iter_270_2.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_2.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_2.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_2.color.r, 1, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_2.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1061 then
				for iter_270_3, iter_270_4 in pairs(arg_267_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_270_4 then
						iter_270_4.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps1061 = nil
			end

			local var_270_5 = 0
			local var_270_6 = 0.55

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(410241065)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 22 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 22)

				if (22 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 22)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241065", "story_v_out_410241.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241065", "story_v_out_410241.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_410241", "410241065", "story_v_out_410241.awb")

						arg_267_1:RecordAudio("410241065", var_270_12)
						arg_267_1:RecordAudio("410241065", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_410241", "410241065", "story_v_out_410241.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_410241", "410241065", "story_v_out_410241.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_13 and arg_267_1.time_ < var_270_5 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play410241066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 410241066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play410241067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1061 = arg_271_1.actors_["1061"].transform.localPosition
				arg_271_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1061", 7)

				for iter_274_0 = 0, arg_271_1.actors_["1061"].transform.childCount - 1 do
					local var_274_0 = arg_271_1.actors_["1061"].transform:GetChild(iter_274_0)

					if var_274_0.name == "" or not string.find(var_274_0.name, "split") then
						var_274_0.gameObject:SetActive(true)
					else
						var_274_0.gameObject:SetActive(false)
					end
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_271_1.time_ - 0) / var_274_1)
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_274_2 = arg_271_1.actors_["1061"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1061 == nil then
				arg_271_1.var_.actorSpriteComps1061 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.034

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps1061 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								iter_274_2.color = Color.New(Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_3), Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_3), (Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_3)))
							else
								local var_274_4 = Mathf.Lerp(iter_274_2.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_3)

								iter_274_2.color = Color.New(var_274_4, var_274_4, var_274_4)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1061 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_274_4 then
						iter_274_4.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps1061 = nil
			end

			local var_274_5 = 0
			local var_274_6 = 0.825

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(410241066).content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 33 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_7) / 33)

				if (33 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_7) / 33)) > 0 and var_274_6 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_10 and arg_271_1.time_ < var_274_5 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play410241067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 410241067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play410241068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_278_0 = 1

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				local var_278_1, var_278_2 = math.modf((arg_275_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_278_2 * 0.13, var_278_2 * 0.13, var_278_2 * 0.13) + arg_275_1.var_.shakeOldPos
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				manager.ui.mainCamera.transform.localPosition = arg_275_1.var_.shakeOldPos
			end

			local var_278_3 = 0

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			if arg_275_1.time_ >= var_278_3 + 1 and arg_275_1.time_ < var_278_3 + 1 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			local var_278_4 = 0
			local var_278_5 = 1.175

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(410241067).content)

				arg_275_1.text_.text = var_278_6

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_8 = 47 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_6) / 47)

				if (47 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_6) / 47)) > 0 and var_278_5 < var_278_8 then
					arg_275_1.talkMaxDuration = var_278_8

					if var_278_8 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_6
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_9 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_9 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_9

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_9 and arg_275_1.time_ < var_278_4 + var_278_9 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play410241068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 410241068
		arg_279_1.duration_ = 5.8

		local var_279_0 = {
			ja = 5.8,
			CriLanguages = 3.733,
			zh = 3.733
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
				arg_279_0:Play410241069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if arg_279_1.actors_["10062"] == nil then
				local var_282_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_282_0) then
					local var_282_1 = Object.Instantiate(var_282_0, arg_279_1.canvasGo_.transform)

					var_282_1.transform:SetSiblingIndex(1)

					var_282_1.name = "10062"
					var_282_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_279_1.actors_["10062"] = var_282_1

					if arg_279_1.isInRecall_ then
						for iter_282_0, iter_282_1 in ipairs((var_282_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_282_1.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_282_2 = arg_279_1.actors_["10062"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10062 = var_282_2.localPosition
				var_282_2.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10062", 3)

				for iter_282_2 = 0, var_282_2.childCount - 1 do
					local var_282_3 = var_282_2:GetChild(iter_282_2)

					if var_282_3.name == "split_5" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_2.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_279_1.time_ - 0) / var_282_4)
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_2.localPosition = Vector3.New(0, -390, -290)
			end

			local var_282_5 = arg_279_1.actors_["10062"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.actorSpriteComps10062 == nil then
				arg_279_1.var_.actorSpriteComps10062 = var_282_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_6 = 0.034

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_6 and not isNil(var_282_5) then
				if arg_279_1.var_.actorSpriteComps10062 then
					for iter_282_3, iter_282_4 in pairs(arg_279_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_282_4 then
							if arg_279_1.isInRecall_ then
								iter_282_4.color = Color.New(Mathf.Lerp(iter_282_4.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_6), Mathf.Lerp(iter_282_4.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_6), (Mathf.Lerp(iter_282_4.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_6)))
							else
								local var_282_7 = Mathf.Lerp(iter_282_4.color.r, 1, (arg_279_1.time_ - 0) / var_282_6)

								iter_282_4.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_6 and arg_279_1.time_ < 0 + var_282_6 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.actorSpriteComps10062 then
				for iter_282_5, iter_282_6 in pairs(arg_279_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_282_6 then
						iter_282_6.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10062 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 0.275

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(410241068)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 11 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 11)

				if (11 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 11)) > 0 and var_282_9 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241068", "story_v_out_410241.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_410241", "410241068", "story_v_out_410241.awb") / 1000

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end

					if var_282_10.prefab_name ~= "" and arg_279_1.actors_[var_282_10.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_10.prefab_name].transform, "story_v_out_410241", "410241068", "story_v_out_410241.awb")

						arg_279_1:RecordAudio("410241068", var_282_15)
						arg_279_1:RecordAudio("410241068", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_410241", "410241068", "story_v_out_410241.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_410241", "410241068", "story_v_out_410241.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play410241069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 410241069
		arg_283_1.duration_ = 9.03

		local var_283_0 = {
			ja = 9.033,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_283_0:Play410241070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10062 = arg_283_1.actors_["10062"].transform.localPosition
				arg_283_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10062", 7)

				for iter_286_0 = 0, arg_283_1.actors_["10062"].transform.childCount - 1 do
					local var_286_0 = arg_283_1.actors_["10062"].transform:GetChild(iter_286_0)

					if var_286_0.name == "" or not string.find(var_286_0.name, "split") then
						var_286_0.gameObject:SetActive(true)
					else
						var_286_0.gameObject:SetActive(false)
					end
				end
			end

			local var_286_1 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 then
				arg_283_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_283_1.time_ - 0) / var_286_1)
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 then
				arg_283_1.actors_["10062"].transform.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_286_2 = arg_283_1.actors_["1061"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1061 = var_286_2.localPosition
				var_286_2.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("1061", 3)

				for iter_286_1 = 0, var_286_2.childCount - 1 do
					local var_286_3 = var_286_2:GetChild(iter_286_1)

					if var_286_3.name == "split_2" or not string.find(var_286_3.name, "split") then
						var_286_3.gameObject:SetActive(true)
					else
						var_286_3.gameObject:SetActive(false)
					end
				end
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_2.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_283_1.time_ - 0) / var_286_4)
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_286_5 = arg_283_1.actors_["10062"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.actorSpriteComps10062 == nil then
				arg_283_1.var_.actorSpriteComps10062 = var_286_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_6 = 0.034

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_6 and not isNil(var_286_5) then
				if arg_283_1.var_.actorSpriteComps10062 then
					for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_286_3 then
							if arg_283_1.isInRecall_ then
								iter_286_3.color = Color.New(Mathf.Lerp(iter_286_3.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_6), Mathf.Lerp(iter_286_3.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_6), (Mathf.Lerp(iter_286_3.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_6)))
							else
								local var_286_7 = Mathf.Lerp(iter_286_3.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_6)

								iter_286_3.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_6 and arg_283_1.time_ < 0 + var_286_6 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.actorSpriteComps10062 then
				for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_286_5 then
						iter_286_5.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps10062 = nil
			end

			local var_286_8 = arg_283_1.actors_["1061"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps1061 == nil then
				arg_283_1.var_.actorSpriteComps1061 = var_286_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_9 = 0.034

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_9 and not isNil(var_286_8) then
				if arg_283_1.var_.actorSpriteComps1061 then
					for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_286_7 then
							if arg_283_1.isInRecall_ then
								iter_286_7.color = Color.New(Mathf.Lerp(iter_286_7.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_9), Mathf.Lerp(iter_286_7.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_9), (Mathf.Lerp(iter_286_7.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_9)))
							else
								local var_286_10 = Mathf.Lerp(iter_286_7.color.r, 1, (arg_283_1.time_ - 0) / var_286_9)

								iter_286_7.color = Color.New(var_286_10, var_286_10, var_286_10)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_9 and arg_283_1.time_ < 0 + var_286_9 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps1061 then
				for iter_286_8, iter_286_9 in pairs(arg_283_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_286_9 then
						iter_286_9.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps1061 = nil
			end

			local var_286_11 = 0
			local var_286_12 = 0.225

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_11 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_13 = arg_283_1:GetWordFromCfg(410241069)
				local var_286_14 = arg_283_1:FormatText(var_286_13.content)

				arg_283_1.text_.text = var_286_14

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_16 = 9 <= 0 and var_286_12 or var_286_12 * (utf8.len(var_286_14) / 9)

				if (9 <= 0 and var_286_12 or var_286_12 * (utf8.len(var_286_14) / 9)) > 0 and var_286_12 < var_286_16 then
					arg_283_1.talkMaxDuration = var_286_16

					if var_286_16 + var_286_11 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_11
					end
				end

				arg_283_1.text_.text = var_286_14
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241069", "story_v_out_410241.awb") ~= 0 then
					local var_286_17 = manager.audio:GetVoiceLength("story_v_out_410241", "410241069", "story_v_out_410241.awb") / 1000

					if var_286_17 + var_286_11 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_17 + var_286_11
					end

					if var_286_13.prefab_name ~= "" and arg_283_1.actors_[var_286_13.prefab_name] ~= nil then
						local var_286_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_13.prefab_name].transform, "story_v_out_410241", "410241069", "story_v_out_410241.awb")

						arg_283_1:RecordAudio("410241069", var_286_18)
						arg_283_1:RecordAudio("410241069", var_286_18)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_410241", "410241069", "story_v_out_410241.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_410241", "410241069", "story_v_out_410241.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_19 = math.max(var_286_12, arg_283_1.talkMaxDuration)

			if var_286_11 <= arg_283_1.time_ and arg_283_1.time_ < var_286_11 + var_286_19 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_11) / var_286_19

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_11 + var_286_19 and arg_283_1.time_ < var_286_11 + var_286_19 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play410241070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 410241070
		arg_287_1.duration_ = 8.2

		local var_287_0 = {
			ja = 8.2,
			CriLanguages = 4.533,
			zh = 4.533
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
				arg_287_0:Play410241071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10062 = arg_287_1.actors_["10062"].transform.localPosition
				arg_287_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10062", 3)

				for iter_290_0 = 0, arg_287_1.actors_["10062"].transform.childCount - 1 do
					local var_290_0 = arg_287_1.actors_["10062"].transform:GetChild(iter_290_0)

					if var_290_0.name == "split_5" or not string.find(var_290_0.name, "split") then
						var_290_0.gameObject:SetActive(true)
					else
						var_290_0.gameObject:SetActive(false)
					end
				end
			end

			local var_290_1 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 then
				arg_287_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_287_1.time_ - 0) / var_290_1)
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 then
				arg_287_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_290_2 = arg_287_1.actors_["1061"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1061 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1061", 7)

				for iter_290_1 = 0, var_290_2.childCount - 1 do
					local var_290_3 = var_290_2:GetChild(iter_290_1)

					if var_290_3.name == "" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_287_1.time_ - 0) / var_290_4)
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_290_5 = arg_287_1.actors_["10062"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.actorSpriteComps10062 == nil then
				arg_287_1.var_.actorSpriteComps10062 = var_290_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_6 = 0.034

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_6 and not isNil(var_290_5) then
				if arg_287_1.var_.actorSpriteComps10062 then
					for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_290_3 then
							if arg_287_1.isInRecall_ then
								iter_290_3.color = Color.New(Mathf.Lerp(iter_290_3.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_6), Mathf.Lerp(iter_290_3.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_6), (Mathf.Lerp(iter_290_3.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_6)))
							else
								local var_290_7 = Mathf.Lerp(iter_290_3.color.r, 1, (arg_287_1.time_ - 0) / var_290_6)

								iter_290_3.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_6 and arg_287_1.time_ < 0 + var_290_6 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.actorSpriteComps10062 then
				for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_290_5 then
						iter_290_5.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps10062 = nil
			end

			local var_290_8 = arg_287_1.actors_["1061"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps1061 == nil then
				arg_287_1.var_.actorSpriteComps1061 = var_290_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_9 = 0.034

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_9 and not isNil(var_290_8) then
				if arg_287_1.var_.actorSpriteComps1061 then
					for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_290_7 then
							if arg_287_1.isInRecall_ then
								iter_290_7.color = Color.New(Mathf.Lerp(iter_290_7.color.r, arg_287_1.hightColor2.r, (arg_287_1.time_ - 0) / var_290_9), Mathf.Lerp(iter_290_7.color.g, arg_287_1.hightColor2.g, (arg_287_1.time_ - 0) / var_290_9), (Mathf.Lerp(iter_290_7.color.b, arg_287_1.hightColor2.b, (arg_287_1.time_ - 0) / var_290_9)))
							else
								local var_290_10 = Mathf.Lerp(iter_290_7.color.r, 0.5, (arg_287_1.time_ - 0) / var_290_9)

								iter_290_7.color = Color.New(var_290_10, var_290_10, var_290_10)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_9 and arg_287_1.time_ < 0 + var_290_9 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps1061 then
				for iter_290_8, iter_290_9 in pairs(arg_287_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_290_9 then
						iter_290_9.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_287_1.var_.actorSpriteComps1061 = nil
			end

			local var_290_11 = 0
			local var_290_12 = 0.425

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_13 = arg_287_1:GetWordFromCfg(410241070)
				local var_290_14 = arg_287_1:FormatText(var_290_13.content)

				arg_287_1.text_.text = var_290_14

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_16 = 17 <= 0 and var_290_12 or var_290_12 * (utf8.len(var_290_14) / 17)

				if (17 <= 0 and var_290_12 or var_290_12 * (utf8.len(var_290_14) / 17)) > 0 and var_290_12 < var_290_16 then
					arg_287_1.talkMaxDuration = var_290_16

					if var_290_16 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_16 + var_290_11
					end
				end

				arg_287_1.text_.text = var_290_14
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241070", "story_v_out_410241.awb") ~= 0 then
					local var_290_17 = manager.audio:GetVoiceLength("story_v_out_410241", "410241070", "story_v_out_410241.awb") / 1000

					if var_290_17 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_17 + var_290_11
					end

					if var_290_13.prefab_name ~= "" and arg_287_1.actors_[var_290_13.prefab_name] ~= nil then
						local var_290_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_13.prefab_name].transform, "story_v_out_410241", "410241070", "story_v_out_410241.awb")

						arg_287_1:RecordAudio("410241070", var_290_18)
						arg_287_1:RecordAudio("410241070", var_290_18)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_410241", "410241070", "story_v_out_410241.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_410241", "410241070", "story_v_out_410241.awb")
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

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play410241071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 410241071
		arg_291_1.duration_ = 11.1

		local var_291_0 = {
			ja = 11.1,
			CriLanguages = 4.5,
			zh = 4.5
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play410241072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10062 = arg_291_1.actors_["10062"].transform.localPosition
				arg_291_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10062", 3)

				for iter_294_0 = 0, arg_291_1.actors_["10062"].transform.childCount - 1 do
					local var_294_0 = arg_291_1.actors_["10062"].transform:GetChild(iter_294_0)

					if var_294_0.name == "split_2" or not string.find(var_294_0.name, "split") then
						var_294_0.gameObject:SetActive(true)
					else
						var_294_0.gameObject:SetActive(false)
					end
				end
			end

			local var_294_1 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_1 then
				arg_291_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_291_1.time_ - 0) / var_294_1)
			end

			if arg_291_1.time_ >= 0 + var_294_1 and arg_291_1.time_ < 0 + var_294_1 + arg_294_0 then
				arg_291_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_294_2 = arg_291_1.actors_["10062"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10062 == nil then
				arg_291_1.var_.actorSpriteComps10062 = var_294_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_3 = 0.034

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.actorSpriteComps10062 then
					for iter_294_1, iter_294_2 in pairs(arg_291_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_294_2 then
							if arg_291_1.isInRecall_ then
								iter_294_2.color = Color.New(Mathf.Lerp(iter_294_2.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_3), Mathf.Lerp(iter_294_2.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_3), (Mathf.Lerp(iter_294_2.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_3)))
							else
								local var_294_4 = Mathf.Lerp(iter_294_2.color.r, 1, (arg_291_1.time_ - 0) / var_294_3)

								iter_294_2.color = Color.New(var_294_4, var_294_4, var_294_4)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10062 then
				for iter_294_3, iter_294_4 in pairs(arg_291_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_294_4 then
						iter_294_4.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps10062 = nil
			end

			local var_294_5 = 0
			local var_294_6 = 0.5

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_7 = arg_291_1:GetWordFromCfg(410241071)
				local var_294_8 = arg_291_1:FormatText(var_294_7.content)

				arg_291_1.text_.text = var_294_8

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_10 = 20 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 20)

				if (20 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 20)) > 0 and var_294_6 < var_294_10 then
					arg_291_1.talkMaxDuration = var_294_10

					if var_294_10 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_5
					end
				end

				arg_291_1.text_.text = var_294_8
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241071", "story_v_out_410241.awb") ~= 0 then
					local var_294_11 = manager.audio:GetVoiceLength("story_v_out_410241", "410241071", "story_v_out_410241.awb") / 1000

					if var_294_11 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_5
					end

					if var_294_7.prefab_name ~= "" and arg_291_1.actors_[var_294_7.prefab_name] ~= nil then
						local var_294_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_7.prefab_name].transform, "story_v_out_410241", "410241071", "story_v_out_410241.awb")

						arg_291_1:RecordAudio("410241071", var_294_12)
						arg_291_1:RecordAudio("410241071", var_294_12)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_410241", "410241071", "story_v_out_410241.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_410241", "410241071", "story_v_out_410241.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_13 = math.max(var_294_6, arg_291_1.talkMaxDuration)

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_13 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_5) / var_294_13

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_5 + var_294_13 and arg_291_1.time_ < var_294_5 + var_294_13 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play410241072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 410241072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
			arg_295_1.auto_ = false
		end

		function arg_295_1.playNext_(arg_297_0)
			arg_295_1.onStoryFinished_()
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10062"]) and arg_295_1.var_.actorSpriteComps10062 == nil then
				arg_295_1.var_.actorSpriteComps10062 = arg_295_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.034

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10062"]) then
				if arg_295_1.var_.actorSpriteComps10062 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10062"]) and arg_295_1.var_.actorSpriteComps10062 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps10062 = nil
			end

			local var_298_2 = 0
			local var_298_3 = 1.125

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_4 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(410241072).content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_6 = 45 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_4) / 45)

				if (45 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_4) / 45)) > 0 and var_298_3 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_7 and arg_295_1.time_ < var_298_2 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/LZ0206",
		"TextureConfig/Background/L04h"
	},
	voices = {
		"story_v_out_410241.awb"
	}
}
