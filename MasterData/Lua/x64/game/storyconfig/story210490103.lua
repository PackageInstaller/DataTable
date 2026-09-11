return {
	Play1104903001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104903001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104903002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_knock", "")
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.125

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104903001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 5 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 5)

				if (5 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 5)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104903002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104903002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104903003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.8

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1104903002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 32 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 32)

				if (32 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 32)) > 0 and var_11_0 < var_11_3 then
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
	Play1104903003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104903003
		arg_12_1.duration_ = 1.77

		local var_12_0 = {
			zh = 1.5,
			ja = 1.766
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
				arg_12_0:Play1104903004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.05

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1008].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(1104903003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 2 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 2)

				if (2 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 2)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903003", "story_v_side_new_1104903.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903003", "story_v_side_new_1104903.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_side_new_1104903", "1104903003", "story_v_side_new_1104903.awb")

						arg_12_1:RecordAudio("1104903003", var_15_6)
						arg_12_1:RecordAudio("1104903003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903003", "story_v_side_new_1104903.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903003", "story_v_side_new_1104903.awb")
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
	Play1104903004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104903004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104903005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_19_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_2 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_2

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_2
						arg_16_1.bgmTxt2_.text = var_19_2
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.5 < arg_16_1.time_ and arg_16_1.time_ <= 1.5 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_19_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_5 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_5

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_5
						arg_16_1.bgmTxt2_.text = var_19_5
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_6 = 0
			local var_19_7 = 0.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_8 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(1104903004).content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 5 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_8) / 5)

				if (5 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_8) / 5)) > 0 and var_19_7 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10

					if var_19_10 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_11 and arg_16_1.time_ < var_19_6 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1104903005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 1104903005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play1104903006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.875

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(1104903005).content)

				arg_22_1.text_.text = var_25_1

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_3 = 35 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 35)

				if (35 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 35)) > 0 and var_25_0 < var_25_3 then
					arg_22_1.talkMaxDuration = var_25_3

					if var_25_3 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_3 + 0
					end
				end

				arg_22_1.text_.text = var_25_1
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_4 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_4

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play1104903006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 1104903006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play1104903007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.825

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(1104903006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 33 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 33)

				if (33 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 33)) > 0 and var_29_0 < var_29_3 then
					arg_26_1.talkMaxDuration = var_29_3

					if var_29_3 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_3 + 0
					end
				end

				arg_26_1.text_.text = var_29_1
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_4 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_4

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play1104903007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 1104903007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play1104903008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.625

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(1104903007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 25 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 25)

				if (25 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 25)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play1104903008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 1104903008
		arg_34_1.duration_ = 5.52

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play1104903009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.bgs_.YA0105 == nil then
				local var_37_0 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0105")
				var_37_0.name = "YA0105"
				var_37_0.transform.parent = arg_34_1.stage_.transform
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_.YA0105 = var_37_0
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_1 = arg_34_1.bgs_.YA0105

				arg_34_1.bgs_.YA0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_2 = var_37_1:GetComponent("SpriteRenderer")

				if var_37_2 and var_37_2.sprite then
					local var_37_3 = 2 * (var_37_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_1.transform.localScale = Vector3.New(var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "YA0105" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_4 = 1

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_4 + 0.3 and arg_34_1.time_ < var_37_4 + 0.3 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_5 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_6 = 1

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 then
				local var_37_7 = Color.New(0, 0, 0)

				var_37_7.a = Mathf.Lerp(1, 0, (arg_34_1.time_ - var_37_5) / var_37_6)
				arg_34_1.mask_.color = var_37_7
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 then
				local var_37_8 = Color.New(0, 0, 0)

				arg_34_1.mask_.enabled = false
				var_37_8.a = 0
				arg_34_1.mask_.color = var_37_8
			end

			local var_37_9 = arg_34_1.bgs_.YA0105.transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPosYA0105 = var_37_9.localPosition
			end

			local var_37_10 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_10 then
				var_37_9.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosYA0105, Vector3.New(-1.5, 0.2, 5), (arg_34_1.time_ - 0) / var_37_10)
			end

			if arg_34_1.time_ >= 0 + var_37_10 and arg_34_1.time_ < 0 + var_37_10 + arg_37_0 then
				var_37_9.localPosition = Vector3.New(-1.5, 0.2, 5)
			end

			local var_37_11 = arg_34_1.bgs_.YA0105.transform

			if 0.0166666666666666 < arg_34_1.time_ and arg_34_1.time_ <= 0.0166666666666666 + arg_37_0 then
				arg_34_1.var_.moveOldPosYA0105 = var_37_11.localPosition
			end

			local var_37_12 = 4.5

			if 0.0166666666666666 <= arg_34_1.time_ and arg_34_1.time_ < 0.0166666666666666 + var_37_12 then
				var_37_11.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosYA0105, Vector3.New(-1.5, 0.2, 4.5), (arg_34_1.time_ - 0.0166666666666666) / var_37_12)
			end

			if arg_34_1.time_ >= 0.0166666666666666 + var_37_12 and arg_34_1.time_ < 0.0166666666666666 + var_37_12 + arg_37_0 then
				var_37_11.localPosition = Vector3.New(-1.5, 0.2, 4.5)
			end

			local var_37_13 = 1

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_13 + 3.51666666666667 and arg_34_1.time_ < var_37_13 + 3.51666666666667 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_14 = 1
			local var_37_15 = 0.2

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_16 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_16:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_17 = arg_34_1:GetWordFromCfg(1104903008)
				local var_37_18 = arg_34_1:FormatText(var_37_17.content)

				arg_34_1.text_.text = var_37_18

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 8 <= 0 and var_37_15 or var_37_15 * (utf8.len(var_37_18) / 8)

				if (8 <= 0 and var_37_15 or var_37_15 * (utf8.len(var_37_18) / 8)) > 0 and var_37_15 < var_37_20 then
					arg_34_1.talkMaxDuration = var_37_20
					var_37_14 = var_37_14 + 0.3

					if var_37_20 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_20 + var_37_14
					end
				end

				arg_34_1.text_.text = var_37_18
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903008", "story_v_side_new_1104903.awb") ~= 0 then
					local var_37_21 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903008", "story_v_side_new_1104903.awb") / 1000

					if var_37_21 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_21 + var_37_14
					end

					if var_37_17.prefab_name ~= "" and arg_34_1.actors_[var_37_17.prefab_name] ~= nil then
						local var_37_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_17.prefab_name].transform, "story_v_side_new_1104903", "1104903008", "story_v_side_new_1104903.awb")

						arg_34_1:RecordAudio("1104903008", var_37_22)
						arg_34_1:RecordAudio("1104903008", var_37_22)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903008", "story_v_side_new_1104903.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903008", "story_v_side_new_1104903.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_23 = var_37_14 + 0.3
			local var_37_24 = math.max(var_37_15, arg_34_1.talkMaxDuration)

			if var_37_14 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_23 + var_37_24 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_23) / var_37_24

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_23 + var_37_24 and arg_34_1.time_ < var_37_23 + var_37_24 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YA0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play1104903009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104903009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104903010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.85

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1104903009).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 34 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 34)

				if (34 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 34)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104903010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104903010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104903011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.625

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1104903010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 25 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 25)

				if (25 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 25)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1104903011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104903011
		arg_48_1.duration_ = 9.13

		local var_48_0 = {
			zh = 4.333,
			ja = 9.133
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
				arg_48_0:Play1104903012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(1104903011)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903011", "story_v_side_new_1104903.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903011", "story_v_side_new_1104903.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_side_new_1104903", "1104903011", "story_v_side_new_1104903.awb")

						arg_48_1:RecordAudio("1104903011", var_51_6)
						arg_48_1:RecordAudio("1104903011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903011", "story_v_side_new_1104903.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903011", "story_v_side_new_1104903.awb")
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
	Play1104903012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104903012
		arg_52_1.duration_ = 4.93

		local var_52_0 = {
			zh = 3.133,
			ja = 4.933
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
				arg_52_0:Play1104903013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.4

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(1104903012)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 16 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 16)

				if (16 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 16)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903012", "story_v_side_new_1104903.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903012", "story_v_side_new_1104903.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_side_new_1104903", "1104903012", "story_v_side_new_1104903.awb")

						arg_52_1:RecordAudio("1104903012", var_55_6)
						arg_52_1:RecordAudio("1104903012", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903012", "story_v_side_new_1104903.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903012", "story_v_side_new_1104903.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1104903013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104903013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104903014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.8

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(1104903013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 32 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 32)

				if (32 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 32)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104903014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104903014
		arg_60_1.duration_ = 9.2

		local var_60_0 = {
			zh = 3.4,
			ja = 9.2
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
				arg_60_0:Play1104903015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.35

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(1104903014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 14 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 14)

				if (14 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 14)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903014", "story_v_side_new_1104903.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903014", "story_v_side_new_1104903.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_side_new_1104903", "1104903014", "story_v_side_new_1104903.awb")

						arg_60_1:RecordAudio("1104903014", var_63_6)
						arg_60_1:RecordAudio("1104903014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903014", "story_v_side_new_1104903.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903014", "story_v_side_new_1104903.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1104903015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104903015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104903016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(1104903015).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 10 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 10)

				if (10 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 10)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104903016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104903016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104903017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.75

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(1104903016).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 30 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 30)

				if (30 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 30)) > 0 and var_71_0 < var_71_3 then
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
	Play1104903017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104903017
		arg_72_1.duration_ = 8.8

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104903018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.bgs_.ST06 == nil then
				local var_75_0 = Object.Instantiate(arg_72_1.paintGo_)

				var_75_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06")
				var_75_0.name = "ST06"
				var_75_0.transform.parent = arg_72_1.stage_.transform
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.bgs_.ST06 = var_75_0
			end

			if 1.999999999999 < arg_72_1.time_ and arg_72_1.time_ <= 1.999999999999 + arg_75_0 then
				local var_75_1 = arg_72_1.bgs_.ST06

				arg_72_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_2 = var_75_1:GetComponent("SpriteRenderer")

				if var_75_2 and var_75_2.sprite then
					local var_75_3 = 2 * (var_75_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_1.transform.localScale = Vector3.New(var_75_3 / var_75_2.sprite.bounds.size.y < var_75_3 * manager.ui.mainCameraCom_.aspect / var_75_2.sprite.bounds.size.x and var_75_3 * manager.ui.mainCameraCom_.aspect / var_75_2.sprite.bounds.size.x or var_75_3 / var_75_2.sprite.bounds.size.y, var_75_3 / var_75_2.sprite.bounds.size.y < var_75_3 * manager.ui.mainCameraCom_.aspect / var_75_2.sprite.bounds.size.x and var_75_3 * manager.ui.mainCameraCom_.aspect / var_75_2.sprite.bounds.size.x or var_75_3 / var_75_2.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "ST06" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_4 = 3.999999999999

			if 3.999999999999 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_4 + 0.3 and arg_72_1.time_ < var_75_4 + 0.3 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_5 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_6 = 2

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 then
				local var_75_7 = Color.New(0, 0, 0)

				var_75_7.a = Mathf.Lerp(0, 1, (arg_72_1.time_ - var_75_5) / var_75_6)
				arg_72_1.mask_.color = var_75_7
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 then
				local var_75_8 = Color.New(0, 0, 0)

				var_75_8.a = 1
				arg_72_1.mask_.color = var_75_8
			end

			local var_75_9 = 2

			if 2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_10 = 2

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 then
				local var_75_11 = Color.New(0, 0, 0)

				var_75_11.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_9) / var_75_10)
				arg_72_1.mask_.color = var_75_11
			end

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 then
				local var_75_12 = Color.New(0, 0, 0)

				arg_72_1.mask_.enabled = false
				var_75_12.a = 0
				arg_72_1.mask_.color = var_75_12
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_13 = 3.8
			local var_75_14 = 1.175

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_15 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_15:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_16 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1104903017).content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_18 = 47 <= 0 and var_75_14 or var_75_14 * (utf8.len(var_75_16) / 47)

				if (47 <= 0 and var_75_14 or var_75_14 * (utf8.len(var_75_16) / 47)) > 0 and var_75_14 < var_75_18 then
					arg_72_1.talkMaxDuration = var_75_18
					var_75_13 = var_75_13 + 0.3

					if var_75_18 + var_75_13 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_18 + var_75_13
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_19 = var_75_13 + 0.3
			local var_75_20 = math.max(var_75_14, arg_72_1.talkMaxDuration)

			if var_75_13 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_19 + var_75_20 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_19) / var_75_20

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_19 + var_75_20 and arg_72_1.time_ < var_75_19 + var_75_20 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104903018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1104903018
		arg_78_1.duration_ = 4.73

		local var_78_0 = {
			zh = 4.733,
			ja = 3.033
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1104903019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if arg_78_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_81_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_78_1.stage_.transform)

				var_81_0.name = "10066ui_story"
				var_81_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["10066ui_story"] = var_81_0

				local var_81_1 = var_81_0:GetComponentInChildren(typeof(CharacterEffect))

				var_81_1.enabled = true

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end

				arg_78_1:ShowWeapon(var_81_1.transform, false)

				arg_78_1.var_["10066ui_story" .. "Animator"] = var_81_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_78_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_78_1.var_["10066ui_story" .. "LipSync"] = var_81_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_81_3 = arg_78_1.actors_["10066ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10066ui_story = var_81_3.localPosition
			end

			local var_81_4 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_3.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_78_1.time_ - 0) / var_81_4)
				var_81_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_3.position).x, (manager.ui.mainCamera.transform.position - var_81_3.position).y, (manager.ui.mainCamera.transform.position - var_81_3.position).z)
				var_81_3.localEulerAngles.z = 0
				var_81_3.localEulerAngles.x = 0
				var_81_3.localEulerAngles = var_81_3.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_81_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_3.position).x, (manager.ui.mainCamera.transform.position - var_81_3.position).y, (manager.ui.mainCamera.transform.position - var_81_3.position).z)
				var_81_3.localEulerAngles.z = 0
				var_81_3.localEulerAngles.x = 0
				var_81_3.localEulerAngles = var_81_3.localEulerAngles
			end

			local var_81_5 = arg_78_1.actors_["10066ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect10066ui_story == nil then
				arg_78_1.var_.characterEffect10066ui_story = var_81_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_6 and not isNil(var_81_5) then
				if arg_78_1.var_.characterEffect10066ui_story and not isNil(var_81_5) then
					arg_78_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_6 and arg_78_1.time_ < 0 + var_81_6 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect10066ui_story then
				arg_78_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				if arg_78_1.var_.characterEffect10066ui_story == nil then
					arg_78_1.var_.characterEffect10066ui_story = arg_78_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_81_8 = arg_78_1.var_.characterEffect10066ui_story

				arg_78_1.var_.characterEffect10066ui_story.imageEffect:turnOff()

				var_81_8.interferenceEffect.enabled = true
				var_81_8.interferenceEffect.noise = 0.001
				var_81_8.interferenceEffect.simTimeScale = 1
				var_81_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				if arg_78_1.var_.characterEffect10066ui_story == nil then
					arg_78_1.var_.characterEffect10066ui_story = arg_78_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_78_1.var_.characterEffect10066ui_story.imageEffect:turnOn(false)
			end

			local var_81_10 = 0
			local var_81_11 = 0.375

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_12 = arg_78_1:GetWordFromCfg(1104903018)
				local var_81_13 = arg_78_1:FormatText(var_81_12.content)

				arg_78_1.text_.text = var_81_13

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 15 <= 0 and var_81_11 or var_81_11 * (utf8.len(var_81_13) / 15)

				if (15 <= 0 and var_81_11 or var_81_11 * (utf8.len(var_81_13) / 15)) > 0 and var_81_11 < var_81_15 then
					arg_78_1.talkMaxDuration = var_81_15

					if var_81_15 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_15 + var_81_10
					end
				end

				arg_78_1.text_.text = var_81_13
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903018", "story_v_side_new_1104903.awb") ~= 0 then
					local var_81_16 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903018", "story_v_side_new_1104903.awb") / 1000

					if var_81_16 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_16 + var_81_10
					end

					if var_81_12.prefab_name ~= "" and arg_78_1.actors_[var_81_12.prefab_name] ~= nil then
						local var_81_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_12.prefab_name].transform, "story_v_side_new_1104903", "1104903018", "story_v_side_new_1104903.awb")

						arg_78_1:RecordAudio("1104903018", var_81_17)
						arg_78_1:RecordAudio("1104903018", var_81_17)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903018", "story_v_side_new_1104903.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903018", "story_v_side_new_1104903.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_18 = math.max(var_81_11, arg_78_1.talkMaxDuration)

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_18 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_10) / var_81_18

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_10 + var_81_18 and arg_78_1.time_ < var_81_10 + var_81_18 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1104903019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1104903019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1104903020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10066ui_story"]) and arg_82_1.var_.characterEffect10066ui_story == nil then
				arg_82_1.var_.characterEffect10066ui_story = arg_82_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10066ui_story"]) then
				if arg_82_1.var_.characterEffect10066ui_story and not isNil(arg_82_1.actors_["10066ui_story"]) then
					arg_82_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_82_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10066ui_story"]) and arg_82_1.var_.characterEffect10066ui_story then
				arg_82_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_82_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 0.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(1104903019).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 12 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 12)

				if (12 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 12)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_6 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_6

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_6 and arg_82_1.time_ < var_85_1 + var_85_6 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1104903020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1104903020
		arg_86_1.duration_ = 9.67

		local var_86_0 = {
			zh = 9.666,
			ja = 5.9
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
				arg_86_0:Play1104903021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10066ui_story = arg_86_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10066ui_story"].transform.position).z)
				arg_86_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10066ui_story"].transform.localEulerAngles = arg_86_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_86_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10066ui_story"].transform.position).z)
				arg_86_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10066ui_story"].transform.localEulerAngles = arg_86_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["10066ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect10066ui_story == nil then
				arg_86_1.var_.characterEffect10066ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect10066ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect10066ui_story then
				arg_86_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_89_4 = 0
			local var_89_5 = 0.925

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(1104903020)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 37 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 37)

				if (37 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 37)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903020", "story_v_side_new_1104903.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903020", "story_v_side_new_1104903.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_side_new_1104903", "1104903020", "story_v_side_new_1104903.awb")

						arg_86_1:RecordAudio("1104903020", var_89_11)
						arg_86_1:RecordAudio("1104903020", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903020", "story_v_side_new_1104903.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903020", "story_v_side_new_1104903.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1104903021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1104903021
		arg_90_1.duration_ = 4.33

		local var_90_0 = {
			zh = 4.333,
			ja = 4.2
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
				arg_90_0:Play1104903022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10066ui_story = arg_90_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_93_0 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				arg_90_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10066ui_story"].transform.position).z)
				arg_90_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10066ui_story"].transform.localEulerAngles = arg_90_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				arg_90_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_90_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10066ui_story"].transform.position).z)
				arg_90_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10066ui_story"].transform.localEulerAngles = arg_90_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_93_1 = arg_90_1.actors_["10066ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect10066ui_story == nil then
				arg_90_1.var_.characterEffect10066ui_story = var_93_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_2 and not isNil(var_93_1) then
				if arg_90_1.var_.characterEffect10066ui_story and not isNil(var_93_1) then
					arg_90_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_2 and arg_90_1.time_ < 0 + var_93_2 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect10066ui_story then
				arg_90_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_93_4 = 0
			local var_93_5 = 0.55

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(1104903021)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 22 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 22)

				if (22 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 22)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903021", "story_v_side_new_1104903.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903021", "story_v_side_new_1104903.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_side_new_1104903", "1104903021", "story_v_side_new_1104903.awb")

						arg_90_1:RecordAudio("1104903021", var_93_11)
						arg_90_1:RecordAudio("1104903021", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903021", "story_v_side_new_1104903.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903021", "story_v_side_new_1104903.awb")
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

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play1104903022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1104903022
		arg_94_1.duration_ = 3.93

		local var_94_0 = {
			zh = 2.233,
			ja = 3.933
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
				arg_94_0:Play1104903023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos10066ui_story = arg_94_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["10066ui_story"].transform.position).z)
				arg_94_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["10066ui_story"].transform.localEulerAngles = arg_94_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_94_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["10066ui_story"].transform.position).z)
				arg_94_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["10066ui_story"].transform.localEulerAngles = arg_94_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_97_1 = arg_94_1.actors_["10066ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect10066ui_story == nil then
				arg_94_1.var_.characterEffect10066ui_story = var_97_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 and not isNil(var_97_1) then
				if arg_94_1.var_.characterEffect10066ui_story and not isNil(var_97_1) then
					arg_94_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_2)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect10066ui_story then
				arg_94_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_97_3 = "1049ui_story"

			if arg_94_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_97_4 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_94_1.stage_.transform)

				var_97_4.name = var_97_3
				var_97_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_[var_97_3] = var_97_4

				local var_97_5 = var_97_4:GetComponentInChildren(typeof(CharacterEffect))

				var_97_5.enabled = true

				local var_97_6 = GameObjectTools.GetOrAddComponent(var_97_4, typeof(DynamicBoneHelper))

				if var_97_6 then
					var_97_6:EnableDynamicBone(false)
				end

				arg_94_1:ShowWeapon(var_97_5.transform, false)

				arg_94_1.var_[var_97_3 .. "Animator"] = var_97_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_94_1.var_[var_97_3 .. "Animator"].applyRootMotion = true
				arg_94_1.var_[var_97_3 .. "LipSync"] = var_97_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_97_7 = arg_94_1.actors_["1049ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1049ui_story = var_97_7.localPosition
			end

			local var_97_8 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_8 then
				var_97_7.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1049ui_story, Vector3.New(0.7, -1.2, -6), (arg_94_1.time_ - 0) / var_97_8)
				var_97_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_7.position).x, (manager.ui.mainCamera.transform.position - var_97_7.position).y, (manager.ui.mainCamera.transform.position - var_97_7.position).z)
				var_97_7.localEulerAngles.z = 0
				var_97_7.localEulerAngles.x = 0
				var_97_7.localEulerAngles = var_97_7.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_8 and arg_94_1.time_ < 0 + var_97_8 + arg_97_0 then
				var_97_7.localPosition = Vector3.New(0.7, -1.2, -6)
				var_97_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_7.position).x, (manager.ui.mainCamera.transform.position - var_97_7.position).y, (manager.ui.mainCamera.transform.position - var_97_7.position).z)
				var_97_7.localEulerAngles.z = 0
				var_97_7.localEulerAngles.x = 0
				var_97_7.localEulerAngles = var_97_7.localEulerAngles
			end

			local var_97_9 = arg_94_1.actors_["1049ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect1049ui_story == nil then
				arg_94_1.var_.characterEffect1049ui_story = var_97_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_10 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_10 and not isNil(var_97_9) then
				if arg_94_1.var_.characterEffect1049ui_story and not isNil(var_97_9) then
					arg_94_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_10 and arg_94_1.time_ < 0 + var_97_10 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect1049ui_story then
				arg_94_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_97_12 = 0
			local var_97_13 = 0.25

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_14 = arg_94_1:GetWordFromCfg(1104903022)
				local var_97_15 = arg_94_1:FormatText(var_97_14.content)

				arg_94_1.text_.text = var_97_15

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 10 <= 0 and var_97_13 or var_97_13 * (utf8.len(var_97_15) / 10)

				if (10 <= 0 and var_97_13 or var_97_13 * (utf8.len(var_97_15) / 10)) > 0 and var_97_13 < var_97_17 then
					arg_94_1.talkMaxDuration = var_97_17

					if var_97_17 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_17 + var_97_12
					end
				end

				arg_94_1.text_.text = var_97_15
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903022", "story_v_side_new_1104903.awb") ~= 0 then
					local var_97_18 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903022", "story_v_side_new_1104903.awb") / 1000

					if var_97_18 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_18 + var_97_12
					end

					if var_97_14.prefab_name ~= "" and arg_94_1.actors_[var_97_14.prefab_name] ~= nil then
						local var_97_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_14.prefab_name].transform, "story_v_side_new_1104903", "1104903022", "story_v_side_new_1104903.awb")

						arg_94_1:RecordAudio("1104903022", var_97_19)
						arg_94_1:RecordAudio("1104903022", var_97_19)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903022", "story_v_side_new_1104903.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903022", "story_v_side_new_1104903.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_20 = math.max(var_97_13, arg_94_1.talkMaxDuration)

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_20 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_12) / var_97_20

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_12 + var_97_20 and arg_94_1.time_ < var_97_12 + var_97_20 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104903023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1104903023
		arg_98_1.duration_ = 10.37

		local var_98_0 = {
			zh = 6.4,
			ja = 10.366
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
				arg_98_0:Play1104903024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10066ui_story = arg_98_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10066ui_story"].transform.position).z)
				arg_98_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10066ui_story"].transform.localEulerAngles = arg_98_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_98_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10066ui_story"].transform.position).z)
				arg_98_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10066ui_story"].transform.localEulerAngles = arg_98_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["10066ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect10066ui_story == nil then
				arg_98_1.var_.characterEffect10066ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect10066ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect10066ui_story then
				arg_98_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_101_4 = arg_98_1.actors_["1049ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1049ui_story == nil then
				arg_98_1.var_.characterEffect1049ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_5 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_5 and not isNil(var_101_4) then
				if arg_98_1.var_.characterEffect1049ui_story and not isNil(var_101_4) then
					arg_98_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_5)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_5 and arg_98_1.time_ < 0 + var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1049ui_story then
				arg_98_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_101_6 = 0
			local var_101_7 = 0.55

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(1104903023)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 22 <= 0 and var_101_7 or var_101_7 * (utf8.len(var_101_9) / 22)

				if (22 <= 0 and var_101_7 or var_101_7 * (utf8.len(var_101_9) / 22)) > 0 and var_101_7 < var_101_11 then
					arg_98_1.talkMaxDuration = var_101_11

					if var_101_11 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_11 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903023", "story_v_side_new_1104903.awb") ~= 0 then
					local var_101_12 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903023", "story_v_side_new_1104903.awb") / 1000

					if var_101_12 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_6
					end

					if var_101_8.prefab_name ~= "" and arg_98_1.actors_[var_101_8.prefab_name] ~= nil then
						local var_101_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_8.prefab_name].transform, "story_v_side_new_1104903", "1104903023", "story_v_side_new_1104903.awb")

						arg_98_1:RecordAudio("1104903023", var_101_13)
						arg_98_1:RecordAudio("1104903023", var_101_13)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903023", "story_v_side_new_1104903.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903023", "story_v_side_new_1104903.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_14 and arg_98_1.time_ < var_101_6 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play1104903024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1104903024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1104903025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10066ui_story"]) and arg_102_1.var_.characterEffect10066ui_story == nil then
				arg_102_1.var_.characterEffect10066ui_story = arg_102_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10066ui_story"]) then
				if arg_102_1.var_.characterEffect10066ui_story and not isNil(arg_102_1.actors_["10066ui_story"]) then
					arg_102_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10066ui_story"]) and arg_102_1.var_.characterEffect10066ui_story then
				arg_102_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 0.575

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(1104903024).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 23 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 23)

				if (23 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 23)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play1104903025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1104903025
		arg_106_1.duration_ = 9.4

		local var_106_0 = {
			zh = 9.4,
			ja = 8.5
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
				arg_106_0:Play1104903026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10066ui_story = arg_106_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10066ui_story"].transform.position).z)
				arg_106_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["10066ui_story"].transform.localEulerAngles = arg_106_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_106_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10066ui_story"].transform.position).z)
				arg_106_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["10066ui_story"].transform.localEulerAngles = arg_106_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["10066ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect10066ui_story == nil then
				arg_106_1.var_.characterEffect10066ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect10066ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect10066ui_story then
				arg_106_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_109_4 = 0
			local var_109_5 = 1.05

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(1104903025)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 42 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 42)

				if (42 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 42)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903025", "story_v_side_new_1104903.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903025", "story_v_side_new_1104903.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_side_new_1104903", "1104903025", "story_v_side_new_1104903.awb")

						arg_106_1:RecordAudio("1104903025", var_109_11)
						arg_106_1:RecordAudio("1104903025", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903025", "story_v_side_new_1104903.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903025", "story_v_side_new_1104903.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1104903026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1104903026
		arg_110_1.duration_ = 12.2

		local var_110_0 = {
			zh = 9.3,
			ja = 12.2
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1104903027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10066ui_story = arg_110_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10066ui_story"].transform.position).z)
				arg_110_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10066ui_story"].transform.localEulerAngles = arg_110_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_110_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10066ui_story"].transform.position).z)
				arg_110_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10066ui_story"].transform.localEulerAngles = arg_110_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["10066ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect10066ui_story == nil then
				arg_110_1.var_.characterEffect10066ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect10066ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect10066ui_story then
				arg_110_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_113_4 = 0
			local var_113_5 = 0.925

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(1104903026)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 37 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 37)

				if (37 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 37)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903026", "story_v_side_new_1104903.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903026", "story_v_side_new_1104903.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_side_new_1104903", "1104903026", "story_v_side_new_1104903.awb")

						arg_110_1:RecordAudio("1104903026", var_113_11)
						arg_110_1:RecordAudio("1104903026", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903026", "story_v_side_new_1104903.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903026", "story_v_side_new_1104903.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play1104903027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1104903027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1104903028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10066ui_story"]) and arg_114_1.var_.characterEffect10066ui_story == nil then
				arg_114_1.var_.characterEffect10066ui_story = arg_114_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10066ui_story"]) then
				if arg_114_1.var_.characterEffect10066ui_story and not isNil(arg_114_1.actors_["10066ui_story"]) then
					arg_114_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10066ui_story"]) and arg_114_1.var_.characterEffect10066ui_story then
				arg_114_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_117_1 = 0
			local var_117_2 = 0.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(1104903027).content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 13 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 13)

				if (13 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 13)) > 0 and var_117_2 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_6 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_6 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_6

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_6 and arg_114_1.time_ < var_117_1 + var_117_6 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1104903028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1104903028
		arg_118_1.duration_ = 5.4

		local var_118_0 = {
			zh = 5,
			ja = 5.4
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
				arg_118_0:Play1104903029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1049ui_story = arg_118_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1049ui_story, Vector3.New(0.7, -1.2, -6), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).z)
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles = arg_118_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0.7, -1.2, -6)
				arg_118_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).z)
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles = arg_118_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1049ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1049ui_story == nil then
				arg_118_1.var_.characterEffect1049ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1049ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1049ui_story then
				arg_118_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.475

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(1104903028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 19 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 19)

				if (19 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 19)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903028", "story_v_side_new_1104903.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903028", "story_v_side_new_1104903.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_side_new_1104903", "1104903028", "story_v_side_new_1104903.awb")

						arg_118_1:RecordAudio("1104903028", var_121_11)
						arg_118_1:RecordAudio("1104903028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903028", "story_v_side_new_1104903.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903028", "story_v_side_new_1104903.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104903029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1104903029
		arg_122_1.duration_ = 5.5

		local var_122_0 = {
			zh = 5.5,
			ja = 2.466
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
				arg_122_0:Play1104903030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1049ui_story"]) and arg_122_1.var_.characterEffect1049ui_story == nil then
				arg_122_1.var_.characterEffect1049ui_story = arg_122_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1049ui_story"]) then
				if arg_122_1.var_.characterEffect1049ui_story and not isNil(arg_122_1.actors_["1049ui_story"]) then
					arg_122_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1049ui_story"]) and arg_122_1.var_.characterEffect1049ui_story then
				arg_122_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_125_1 = arg_122_1.actors_["10066ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect10066ui_story == nil then
				arg_122_1.var_.characterEffect10066ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect10066ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect10066ui_story then
				arg_122_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_125_4 = 0
			local var_125_5 = 0.55

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(1104903029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 22 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 22)

				if (22 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 22)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903029", "story_v_side_new_1104903.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903029", "story_v_side_new_1104903.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_side_new_1104903", "1104903029", "story_v_side_new_1104903.awb")

						arg_122_1:RecordAudio("1104903029", var_125_11)
						arg_122_1:RecordAudio("1104903029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903029", "story_v_side_new_1104903.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903029", "story_v_side_new_1104903.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1104903030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1104903030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1104903031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["10066ui_story"]) and arg_126_1.var_.characterEffect10066ui_story == nil then
				arg_126_1.var_.characterEffect10066ui_story = arg_126_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["10066ui_story"]) then
				if arg_126_1.var_.characterEffect10066ui_story and not isNil(arg_126_1.actors_["10066ui_story"]) then
					arg_126_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["10066ui_story"]) and arg_126_1.var_.characterEffect10066ui_story then
				arg_126_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.125

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1104903030).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 5 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 5)

				if (5 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 5)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1104903031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1104903031
		arg_130_1.duration_ = 3.1

		local var_130_0 = {
			zh = 2.966,
			ja = 3.1
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1104903032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10066ui_story = arg_130_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10066ui_story"].transform.position).z)
				arg_130_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10066ui_story"].transform.localEulerAngles = arg_130_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_130_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10066ui_story"].transform.position).z)
				arg_130_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10066ui_story"].transform.localEulerAngles = arg_130_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["10066ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect10066ui_story == nil then
				arg_130_1.var_.characterEffect10066ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect10066ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect10066ui_story then
				arg_130_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_133_4 = 0
			local var_133_5 = 0.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(1104903031)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 10 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 10)

				if (10 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 10)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903031", "story_v_side_new_1104903.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903031", "story_v_side_new_1104903.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_side_new_1104903", "1104903031", "story_v_side_new_1104903.awb")

						arg_130_1:RecordAudio("1104903031", var_133_11)
						arg_130_1:RecordAudio("1104903031", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903031", "story_v_side_new_1104903.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903031", "story_v_side_new_1104903.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1104903032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1104903032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1104903033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10066ui_story"]) and arg_134_1.var_.characterEffect10066ui_story == nil then
				arg_134_1.var_.characterEffect10066ui_story = arg_134_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10066ui_story"]) then
				if arg_134_1.var_.characterEffect10066ui_story and not isNil(arg_134_1.actors_["10066ui_story"]) then
					arg_134_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10066ui_story"]) and arg_134_1.var_.characterEffect10066ui_story then
				arg_134_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.75

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(1104903032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 30 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 30)

				if (30 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 30)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1104903033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1104903033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1104903034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.35

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

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(1104903033).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 14 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 14)

				if (14 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 14)) > 0 and var_141_0 < var_141_3 then
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
	Play1104903034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1104903034
		arg_142_1.duration_ = 10.33

		local var_142_0 = {
			zh = 10.333,
			ja = 9.166
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
				arg_142_0:Play1104903035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10066ui_story = arg_142_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_145_0 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 then
				arg_142_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_142_1.time_ - 0) / var_145_0)
				arg_142_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10066ui_story"].transform.position).z)
				arg_142_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10066ui_story"].transform.localEulerAngles = arg_142_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 then
				arg_142_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_142_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10066ui_story"].transform.position).z)
				arg_142_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10066ui_story"].transform.localEulerAngles = arg_142_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_145_1 = arg_142_1.actors_["10066ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_1) and arg_142_1.var_.characterEffect10066ui_story == nil then
				arg_142_1.var_.characterEffect10066ui_story = var_145_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_2 and not isNil(var_145_1) then
				if arg_142_1.var_.characterEffect10066ui_story and not isNil(var_145_1) then
					arg_142_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_2 and arg_142_1.time_ < 0 + var_145_2 + arg_145_0 and not isNil(var_145_1) and arg_142_1.var_.characterEffect10066ui_story then
				arg_142_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action453")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_145_4 = 0
			local var_145_5 = 1.125

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(1104903034)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 45 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 45)

				if (45 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 45)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903034", "story_v_side_new_1104903.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903034", "story_v_side_new_1104903.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_side_new_1104903", "1104903034", "story_v_side_new_1104903.awb")

						arg_142_1:RecordAudio("1104903034", var_145_11)
						arg_142_1:RecordAudio("1104903034", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903034", "story_v_side_new_1104903.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903034", "story_v_side_new_1104903.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play1104903035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1104903035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1104903036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["10066ui_story"]) and arg_146_1.var_.characterEffect10066ui_story == nil then
				arg_146_1.var_.characterEffect10066ui_story = arg_146_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["10066ui_story"]) then
				if arg_146_1.var_.characterEffect10066ui_story and not isNil(arg_146_1.actors_["10066ui_story"]) then
					arg_146_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_0)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["10066ui_story"]) and arg_146_1.var_.characterEffect10066ui_story then
				arg_146_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_149_1 = 0
			local var_149_2 = 0.325

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(1104903035).content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 13 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 13)

				if (13 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 13)) > 0 and var_149_2 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_6 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_6 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_6

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_6 and arg_146_1.time_ < var_149_1 + var_149_6 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1104903036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1104903036
		arg_150_1.duration_ = 2

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1104903037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1049ui_story = arg_150_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1049ui_story, Vector3.New(0.7, -1.2, -6), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1049ui_story"].transform.position).z)
				arg_150_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1049ui_story"].transform.localEulerAngles = arg_150_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0.7, -1.2, -6)
				arg_150_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1049ui_story"].transform.position).z)
				arg_150_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1049ui_story"].transform.localEulerAngles = arg_150_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["1049ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1049ui_story == nil then
				arg_150_1.var_.characterEffect1049ui_story = var_153_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 and not isNil(var_153_1) then
				if arg_150_1.var_.characterEffect1049ui_story and not isNil(var_153_1) then
					arg_150_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1049ui_story then
				arg_150_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_153_4 = 0
			local var_153_5 = 0.0329999998211861

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1010].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_6 = arg_150_1:GetWordFromCfg(1104903036)
				local var_153_7 = arg_150_1:FormatText(var_153_6.content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 1 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 1)

				if (1 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 1)) > 0 and var_153_5 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903036", "story_v_side_new_1104903.awb") ~= 0 then
					local var_153_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903036", "story_v_side_new_1104903.awb") / 1000

					if var_153_10 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_4
					end

					if var_153_6.prefab_name ~= "" and arg_150_1.actors_[var_153_6.prefab_name] ~= nil then
						local var_153_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_6.prefab_name].transform, "story_v_side_new_1104903", "1104903036", "story_v_side_new_1104903.awb")

						arg_150_1:RecordAudio("1104903036", var_153_11)
						arg_150_1:RecordAudio("1104903036", var_153_11)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903036", "story_v_side_new_1104903.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903036", "story_v_side_new_1104903.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_12 and arg_150_1.time_ < var_153_4 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104903037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1104903037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1104903038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1049ui_story"]) and arg_154_1.var_.characterEffect1049ui_story == nil then
				arg_154_1.var_.characterEffect1049ui_story = arg_154_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1049ui_story"]) then
				if arg_154_1.var_.characterEffect1049ui_story and not isNil(arg_154_1.actors_["1049ui_story"]) then
					arg_154_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_0)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1049ui_story"]) and arg_154_1.var_.characterEffect1049ui_story then
				arg_154_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_157_1 = 0
			local var_157_2 = 0.95

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(1104903037).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 38 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 38)

				if (38 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 38)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1104903038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1104903038
		arg_158_1.duration_ = 7.3

		local var_158_0 = {
			zh = 7.3,
			ja = 5.6
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1104903039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos10066ui_story = arg_158_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10066ui_story"].transform.position).z)
				arg_158_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["10066ui_story"].transform.localEulerAngles = arg_158_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_158_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10066ui_story"].transform.position).z)
				arg_158_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["10066ui_story"].transform.localEulerAngles = arg_158_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["10066ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect10066ui_story == nil then
				arg_158_1.var_.characterEffect10066ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect10066ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect10066ui_story then
				arg_158_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action434")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_161_4 = 0
			local var_161_5 = 1.15

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(1104903038)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 46 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 46)

				if (46 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 46)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903038", "story_v_side_new_1104903.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903038", "story_v_side_new_1104903.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_side_new_1104903", "1104903038", "story_v_side_new_1104903.awb")

						arg_158_1:RecordAudio("1104903038", var_161_11)
						arg_158_1:RecordAudio("1104903038", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903038", "story_v_side_new_1104903.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903038", "story_v_side_new_1104903.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play1104903039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1104903039
		arg_162_1.duration_ = 8

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1104903040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 1.5 < arg_162_1.time_ and arg_162_1.time_ <= 1.5 + arg_165_0 then
				local var_165_0 = arg_162_1.bgs_.STblack

				arg_162_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_165_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_165_1 = var_165_0:GetComponent("SpriteRenderer")

				if var_165_1 and var_165_1.sprite then
					local var_165_2 = 2 * (var_165_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_165_0.transform.localScale = Vector3.New(var_165_2 / var_165_1.sprite.bounds.size.y < var_165_2 * manager.ui.mainCameraCom_.aspect / var_165_1.sprite.bounds.size.x and var_165_2 * manager.ui.mainCameraCom_.aspect / var_165_1.sprite.bounds.size.x or var_165_2 / var_165_1.sprite.bounds.size.y, var_165_2 / var_165_1.sprite.bounds.size.y < var_165_2 * manager.ui.mainCameraCom_.aspect / var_165_1.sprite.bounds.size.x and var_165_2 * manager.ui.mainCameraCom_.aspect / var_165_1.sprite.bounds.size.x or var_165_2 / var_165_1.sprite.bounds.size.y, 0)
				end

				for iter_165_0, iter_165_1 in pairs(arg_162_1.bgs_) do
					if iter_165_0 ~= "STblack" then
						iter_165_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_165_3 = 3

			if 3 < arg_162_1.time_ and arg_162_1.time_ <= var_165_3 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			if arg_162_1.time_ >= var_165_3 + 0.3 and arg_162_1.time_ < var_165_3 + 0.3 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_4 = 0

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_5 = 1.5

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_5 then
				local var_165_6 = Color.New(0, 0, 0)

				var_165_6.a = Mathf.Lerp(0, 1, (arg_162_1.time_ - var_165_4) / var_165_5)
				arg_162_1.mask_.color = var_165_6
			end

			if arg_162_1.time_ >= var_165_4 + var_165_5 and arg_162_1.time_ < var_165_4 + var_165_5 + arg_165_0 then
				local var_165_7 = Color.New(0, 0, 0)

				var_165_7.a = 1
				arg_162_1.mask_.color = var_165_7
			end

			local var_165_8 = 1.5

			if 1.5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_9 = 1.5

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_9 then
				local var_165_10 = Color.New(0, 0, 0)

				var_165_10.a = Mathf.Lerp(1, 0, (arg_162_1.time_ - var_165_8) / var_165_9)
				arg_162_1.mask_.color = var_165_10
			end

			if arg_162_1.time_ >= var_165_8 + var_165_9 and arg_162_1.time_ < var_165_8 + var_165_9 + arg_165_0 then
				local var_165_11 = Color.New(0, 0, 0)

				arg_162_1.mask_.enabled = false
				var_165_11.a = 0
				arg_162_1.mask_.color = var_165_11
			end

			local var_165_12 = arg_162_1.actors_["10066ui_story"].transform

			if 1.46599999815226 < arg_162_1.time_ and arg_162_1.time_ <= 1.46599999815226 + arg_165_0 then
				arg_162_1.var_.moveOldPos10066ui_story = var_165_12.localPosition
			end

			local var_165_13 = 0.001

			if 1.46599999815226 <= arg_162_1.time_ and arg_162_1.time_ < 1.46599999815226 + var_165_13 then
				var_165_12.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 1.46599999815226) / var_165_13)
				var_165_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_12.position).x, (manager.ui.mainCamera.transform.position - var_165_12.position).y, (manager.ui.mainCamera.transform.position - var_165_12.position).z)
				var_165_12.localEulerAngles.z = 0
				var_165_12.localEulerAngles.x = 0
				var_165_12.localEulerAngles = var_165_12.localEulerAngles
			end

			if arg_162_1.time_ >= 1.46599999815226 + var_165_13 and arg_162_1.time_ < 1.46599999815226 + var_165_13 + arg_165_0 then
				var_165_12.localPosition = Vector3.New(0, 100, 0)
				var_165_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_12.position).x, (manager.ui.mainCamera.transform.position - var_165_12.position).y, (manager.ui.mainCamera.transform.position - var_165_12.position).z)
				var_165_12.localEulerAngles.z = 0
				var_165_12.localEulerAngles.x = 0
				var_165_12.localEulerAngles = var_165_12.localEulerAngles
			end

			local var_165_14 = arg_162_1.actors_["10066ui_story"]

			if 1.46599999815226 < arg_162_1.time_ and arg_162_1.time_ <= 1.46599999815226 + arg_165_0 and not isNil(var_165_14) and arg_162_1.var_.characterEffect10066ui_story == nil then
				arg_162_1.var_.characterEffect10066ui_story = var_165_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_15 = 0.034000001847744

			if 1.46599999815226 <= arg_162_1.time_ and arg_162_1.time_ < 1.46599999815226 + var_165_15 and not isNil(var_165_14) then
				if arg_162_1.var_.characterEffect10066ui_story and not isNil(var_165_14) then
					arg_162_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 1.46599999815226) / var_165_15)
				end
			end

			if arg_162_1.time_ >= 1.46599999815226 + var_165_15 and arg_162_1.time_ < 1.46599999815226 + var_165_15 + arg_165_0 and not isNil(var_165_14) and arg_162_1.var_.characterEffect10066ui_story then
				arg_162_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_165_16 = arg_162_1.actors_["1049ui_story"].transform

			if 1.46599999815226 < arg_162_1.time_ and arg_162_1.time_ <= 1.46599999815226 + arg_165_0 then
				arg_162_1.var_.moveOldPos1049ui_story = var_165_16.localPosition
			end

			local var_165_17 = 0.001

			if 1.46599999815226 <= arg_162_1.time_ and arg_162_1.time_ < 1.46599999815226 + var_165_17 then
				var_165_16.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 1.46599999815226) / var_165_17)
				var_165_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_16.position).x, (manager.ui.mainCamera.transform.position - var_165_16.position).y, (manager.ui.mainCamera.transform.position - var_165_16.position).z)
				var_165_16.localEulerAngles.z = 0
				var_165_16.localEulerAngles.x = 0
				var_165_16.localEulerAngles = var_165_16.localEulerAngles
			end

			if arg_162_1.time_ >= 1.46599999815226 + var_165_17 and arg_162_1.time_ < 1.46599999815226 + var_165_17 + arg_165_0 then
				var_165_16.localPosition = Vector3.New(0, 100, 0)
				var_165_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_16.position).x, (manager.ui.mainCamera.transform.position - var_165_16.position).y, (manager.ui.mainCamera.transform.position - var_165_16.position).z)
				var_165_16.localEulerAngles.z = 0
				var_165_16.localEulerAngles.x = 0
				var_165_16.localEulerAngles = var_165_16.localEulerAngles
			end

			local var_165_18 = arg_162_1.actors_["1049ui_story"]

			if 1.46599999815226 < arg_162_1.time_ and arg_162_1.time_ <= 1.46599999815226 + arg_165_0 and not isNil(var_165_18) and arg_162_1.var_.characterEffect1049ui_story == nil then
				arg_162_1.var_.characterEffect1049ui_story = var_165_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_19 = 0.034000001847744

			if 1.46599999815226 <= arg_162_1.time_ and arg_162_1.time_ < 1.46599999815226 + var_165_19 and not isNil(var_165_18) then
				if arg_162_1.var_.characterEffect1049ui_story and not isNil(var_165_18) then
					arg_162_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 1.46599999815226) / var_165_19)
				end
			end

			if arg_162_1.time_ >= 1.46599999815226 + var_165_19 and arg_162_1.time_ < 1.46599999815226 + var_165_19 + arg_165_0 and not isNil(var_165_18) and arg_162_1.var_.characterEffect1049ui_story then
				arg_162_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_20 = 3
			local var_165_21 = 0.575

			if 3 < arg_162_1.time_ and arg_162_1.time_ <= var_165_20 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_22 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_22:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_23 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1104903039).content)

				arg_162_1.text_.text = var_165_23

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_25 = 23 <= 0 and var_165_21 or var_165_21 * (utf8.len(var_165_23) / 23)

				if (23 <= 0 and var_165_21 or var_165_21 * (utf8.len(var_165_23) / 23)) > 0 and var_165_21 < var_165_25 then
					arg_162_1.talkMaxDuration = var_165_25
					var_165_20 = var_165_20 + 0.3

					if var_165_25 + var_165_20 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_25 + var_165_20
					end
				end

				arg_162_1.text_.text = var_165_23
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_26 = var_165_20 + 0.3
			local var_165_27 = math.max(var_165_21, arg_162_1.talkMaxDuration)

			if var_165_20 + 0.3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_26 + var_165_27 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_26) / var_165_27

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_26 + var_165_27 and arg_162_1.time_ < var_165_26 + var_165_27 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play1104903040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104903040
		arg_168_1.duration_ = 11.1

		local var_168_0 = {
			zh = 11.1,
			ja = 7.733
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
				arg_168_0:Play1104903041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.225

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(1104903040)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 49 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 49)

				if (49 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 49)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903040", "story_v_side_new_1104903.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903040", "story_v_side_new_1104903.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_side_new_1104903", "1104903040", "story_v_side_new_1104903.awb")

						arg_168_1:RecordAudio("1104903040", var_171_6)
						arg_168_1:RecordAudio("1104903040", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903040", "story_v_side_new_1104903.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903040", "story_v_side_new_1104903.awb")
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
	Play1104903041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104903041
		arg_172_1.duration_ = 12.33

		local var_172_0 = {
			zh = 7.833,
			ja = 12.333
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104903042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.925

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(1104903041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 37 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 37)

				if (37 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 37)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903041", "story_v_side_new_1104903.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903041", "story_v_side_new_1104903.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_side_new_1104903", "1104903041", "story_v_side_new_1104903.awb")

						arg_172_1:RecordAudio("1104903041", var_175_6)
						arg_172_1:RecordAudio("1104903041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903041", "story_v_side_new_1104903.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903041", "story_v_side_new_1104903.awb")
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
	Play1104903042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1104903042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1104903043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.225

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(1104903042).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 9 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 9)

				if (9 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 9)) > 0 and var_179_0 < var_179_3 then
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
	Play1104903043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1104903043
		arg_180_1.duration_ = 7.83

		local var_180_0 = {
			zh = 6.5,
			ja = 7.833
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
				arg_180_0:Play1104903044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if arg_180_1.bgs_.K11f == nil then
				local var_183_0 = Object.Instantiate(arg_180_1.paintGo_)

				var_183_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_183_0.name = "K11f"
				var_183_0.transform.parent = arg_180_1.stage_.transform
				var_183_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.bgs_.K11f = var_183_0
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				local var_183_1 = arg_180_1.bgs_.K11f

				arg_180_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_183_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_183_2 = var_183_1:GetComponent("SpriteRenderer")

				if var_183_2 and var_183_2.sprite then
					local var_183_3 = 2 * (var_183_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_183_1.transform.localScale = Vector3.New(var_183_3 / var_183_2.sprite.bounds.size.y < var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x and var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x or var_183_3 / var_183_2.sprite.bounds.size.y, var_183_3 / var_183_2.sprite.bounds.size.y < var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x and var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x or var_183_3 / var_183_2.sprite.bounds.size.y, 0)
				end

				for iter_183_0, iter_183_1 in pairs(arg_180_1.bgs_) do
					if iter_183_0 ~= "K11f" then
						iter_183_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_183_4 = 2

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			if arg_180_1.time_ >= var_183_4 + 0.3 and arg_180_1.time_ < var_183_4 + 0.3 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			local var_183_5 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_6 = 2

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 then
				local var_183_7 = Color.New(0, 0, 0)

				var_183_7.a = Mathf.Lerp(1, 0, (arg_180_1.time_ - var_183_5) / var_183_6)
				arg_180_1.mask_.color = var_183_7
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 then
				local var_183_8 = Color.New(0, 0, 0)

				arg_180_1.mask_.enabled = false
				var_183_8.a = 0
				arg_180_1.mask_.color = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1049ui_story"].transform

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				arg_180_1.var_.moveOldPos1049ui_story = var_183_9.localPosition
			end

			local var_183_10 = 0.001

			if 2 <= arg_180_1.time_ and arg_180_1.time_ < 2 + var_183_10 then
				var_183_9.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_180_1.time_ - 2) / var_183_10)
				var_183_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_9.position).x, (manager.ui.mainCamera.transform.position - var_183_9.position).y, (manager.ui.mainCamera.transform.position - var_183_9.position).z)
				var_183_9.localEulerAngles.z = 0
				var_183_9.localEulerAngles.x = 0
				var_183_9.localEulerAngles = var_183_9.localEulerAngles
			end

			if arg_180_1.time_ >= 2 + var_183_10 and arg_180_1.time_ < 2 + var_183_10 + arg_183_0 then
				var_183_9.localPosition = Vector3.New(0, -1.2, -6)
				var_183_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_9.position).x, (manager.ui.mainCamera.transform.position - var_183_9.position).y, (manager.ui.mainCamera.transform.position - var_183_9.position).z)
				var_183_9.localEulerAngles.z = 0
				var_183_9.localEulerAngles.x = 0
				var_183_9.localEulerAngles = var_183_9.localEulerAngles
			end

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				arg_180_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				arg_180_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_183_11 = arg_180_1.actors_["1049ui_story"]

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect1049ui_story == nil then
				arg_180_1.var_.characterEffect1049ui_story = var_183_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_12 = 0.2

			if 2 <= arg_180_1.time_ and arg_180_1.time_ < 2 + var_183_12 and not isNil(var_183_11) then
				if arg_180_1.var_.characterEffect1049ui_story and not isNil(var_183_11) then
					arg_180_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 2 + var_183_12 and arg_180_1.time_ < 2 + var_183_12 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect1049ui_story then
				arg_180_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_14 = 2
			local var_183_15 = 0.475

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_16 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_16:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_17 = arg_180_1:GetWordFromCfg(1104903043)
				local var_183_18 = arg_180_1:FormatText(var_183_17.content)

				arg_180_1.text_.text = var_183_18

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_20 = 19 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_18) / 19)

				if (19 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_18) / 19)) > 0 and var_183_15 < var_183_20 then
					arg_180_1.talkMaxDuration = var_183_20
					var_183_14 = var_183_14 + 0.3

					if var_183_20 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_14
					end
				end

				arg_180_1.text_.text = var_183_18
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903043", "story_v_side_new_1104903.awb") ~= 0 then
					local var_183_21 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903043", "story_v_side_new_1104903.awb") / 1000

					if var_183_21 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_21 + var_183_14
					end

					if var_183_17.prefab_name ~= "" and arg_180_1.actors_[var_183_17.prefab_name] ~= nil then
						local var_183_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_17.prefab_name].transform, "story_v_side_new_1104903", "1104903043", "story_v_side_new_1104903.awb")

						arg_180_1:RecordAudio("1104903043", var_183_22)
						arg_180_1:RecordAudio("1104903043", var_183_22)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903043", "story_v_side_new_1104903.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903043", "story_v_side_new_1104903.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_23 = var_183_14 + 0.3
			local var_183_24 = math.max(var_183_15, arg_180_1.talkMaxDuration)

			if var_183_14 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_23 + var_183_24 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_23) / var_183_24

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_23 + var_183_24 and arg_180_1.time_ < var_183_23 + var_183_24 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play1104903044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1104903044
		arg_186_1.duration_ = 5.63

		local var_186_0 = {
			zh = 4.1,
			ja = 5.633
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
				arg_186_0:Play1104903045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1049ui_story"]) and arg_186_1.var_.characterEffect1049ui_story == nil then
				arg_186_1.var_.characterEffect1049ui_story = arg_186_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1049ui_story"]) then
				if arg_186_1.var_.characterEffect1049ui_story and not isNil(arg_186_1.actors_["1049ui_story"]) then
					arg_186_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1049ui_story"]) and arg_186_1.var_.characterEffect1049ui_story then
				arg_186_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.4

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1006].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(1104903044)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 16 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 16)

				if (16 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 16)) > 0 and var_189_2 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903044", "story_v_side_new_1104903.awb") ~= 0 then
					local var_189_7 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903044", "story_v_side_new_1104903.awb") / 1000

					if var_189_7 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_1
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_side_new_1104903", "1104903044", "story_v_side_new_1104903.awb")

						arg_186_1:RecordAudio("1104903044", var_189_8)
						arg_186_1:RecordAudio("1104903044", var_189_8)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903044", "story_v_side_new_1104903.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903044", "story_v_side_new_1104903.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_9 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_9 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_9

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_9 and arg_186_1.time_ < var_189_1 + var_189_9 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1104903045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1104903045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1104903046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.525

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1104903045).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 21 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 21)

				if (21 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 21)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1104903046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1104903046
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1104903047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.6

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

				local var_197_1 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(1104903046).content)

				arg_194_1.text_.text = var_197_1

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_3 = 24 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 24)

				if (24 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 24)) > 0 and var_197_0 < var_197_3 then
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
	Play1104903047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1104903047
		arg_198_1.duration_ = 9

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1104903048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if arg_198_1.bgs_.K01i == nil then
				local var_201_0 = Object.Instantiate(arg_198_1.paintGo_)

				var_201_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K01i")
				var_201_0.name = "K01i"
				var_201_0.transform.parent = arg_198_1.stage_.transform
				var_201_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_.K01i = var_201_0
			end

			if 1.999999999999 < arg_198_1.time_ and arg_198_1.time_ <= 1.999999999999 + arg_201_0 then
				local var_201_1 = arg_198_1.bgs_.K01i

				arg_198_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_201_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_2 = var_201_1:GetComponent("SpriteRenderer")

				if var_201_2 and var_201_2.sprite then
					local var_201_3 = 2 * (var_201_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_201_1.transform.localScale = Vector3.New(var_201_3 / var_201_2.sprite.bounds.size.y < var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x and var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x or var_201_3 / var_201_2.sprite.bounds.size.y, var_201_3 / var_201_2.sprite.bounds.size.y < var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x and var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x or var_201_3 / var_201_2.sprite.bounds.size.y, 0)
				end

				for iter_201_0, iter_201_1 in pairs(arg_198_1.bgs_) do
					if iter_201_0 ~= "K01i" then
						iter_201_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_201_4 = 3.999999999999

			if 3.999999999999 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.allBtn_.enabled = false
			end

			if arg_198_1.time_ >= var_201_4 + 0.3 and arg_198_1.time_ < var_201_4 + 0.3 + arg_201_0 then
				arg_198_1.allBtn_.enabled = true
			end

			local var_201_5 = 0

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_6 = 2

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 then
				local var_201_7 = Color.New(0, 0, 0)

				var_201_7.a = Mathf.Lerp(0, 1, (arg_198_1.time_ - var_201_5) / var_201_6)
				arg_198_1.mask_.color = var_201_7
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				local var_201_8 = Color.New(0, 0, 0)

				var_201_8.a = 1
				arg_198_1.mask_.color = var_201_8
			end

			local var_201_9 = 2

			if 2 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_10 = 2

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 then
				local var_201_11 = Color.New(0, 0, 0)

				var_201_11.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_9) / var_201_10)
				arg_198_1.mask_.color = var_201_11
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 then
				local var_201_12 = Color.New(0, 0, 0)

				arg_198_1.mask_.enabled = false
				var_201_12.a = 0
				arg_198_1.mask_.color = var_201_12
			end

			local var_201_13 = arg_198_1.actors_["1049ui_story"].transform

			if 1.966 < arg_198_1.time_ and arg_198_1.time_ <= 1.966 + arg_201_0 then
				arg_198_1.var_.moveOldPos1049ui_story = var_201_13.localPosition
			end

			local var_201_14 = 0.001

			if 1.966 <= arg_198_1.time_ and arg_198_1.time_ < 1.966 + var_201_14 then
				var_201_13.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 1.966) / var_201_14)
				var_201_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_13.position).x, (manager.ui.mainCamera.transform.position - var_201_13.position).y, (manager.ui.mainCamera.transform.position - var_201_13.position).z)
				var_201_13.localEulerAngles.z = 0
				var_201_13.localEulerAngles.x = 0
				var_201_13.localEulerAngles = var_201_13.localEulerAngles
			end

			if arg_198_1.time_ >= 1.966 + var_201_14 and arg_198_1.time_ < 1.966 + var_201_14 + arg_201_0 then
				var_201_13.localPosition = Vector3.New(0, 100, 0)
				var_201_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_13.position).x, (manager.ui.mainCamera.transform.position - var_201_13.position).y, (manager.ui.mainCamera.transform.position - var_201_13.position).z)
				var_201_13.localEulerAngles.z = 0
				var_201_13.localEulerAngles.x = 0
				var_201_13.localEulerAngles = var_201_13.localEulerAngles
			end

			if arg_198_1.frameCnt_ <= 1 then
				arg_198_1.dialog_:SetActive(false)
			end

			local var_201_15 = 4
			local var_201_16 = 0.65

			if 4 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_17 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_17:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_18 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(1104903047).content)

				arg_198_1.text_.text = var_201_18

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_20 = 26 <= 0 and var_201_16 or var_201_16 * (utf8.len(var_201_18) / 26)

				if (26 <= 0 and var_201_16 or var_201_16 * (utf8.len(var_201_18) / 26)) > 0 and var_201_16 < var_201_20 then
					arg_198_1.talkMaxDuration = var_201_20
					var_201_15 = var_201_15 + 0.3

					if var_201_20 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_20 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_18
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_21 = var_201_15 + 0.3
			local var_201_22 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 + 0.3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_21 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_21) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_21 + var_201_22 and arg_198_1.time_ < var_201_21 + var_201_22 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1104903048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1104903048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1104903049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.7

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(1104903048).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 28 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 28)

				if (28 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 28)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1104903049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1104903049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1104903050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1.125

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(1104903049).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 45 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 45)

				if (45 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 45)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1104903050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1104903050
		arg_212_1.duration_ = 4.6

		local var_212_0 = {
			zh = 4.6,
			ja = 3.866
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1104903051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1049ui_story = arg_212_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1049ui_story"].transform.position).z)
				arg_212_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1049ui_story"].transform.localEulerAngles = arg_212_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_212_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1049ui_story"].transform.position).z)
				arg_212_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1049ui_story"].transform.localEulerAngles = arg_212_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["1049ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect1049ui_story == nil then
				arg_212_1.var_.characterEffect1049ui_story = var_215_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 and not isNil(var_215_1) then
				if arg_212_1.var_.characterEffect1049ui_story and not isNil(var_215_1) then
					arg_212_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect1049ui_story then
				arg_212_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_215_4 = 0
			local var_215_5 = 0.325

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(1104903050)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 13 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 13)

				if (13 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 13)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903050", "story_v_side_new_1104903.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903050", "story_v_side_new_1104903.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_side_new_1104903", "1104903050", "story_v_side_new_1104903.awb")

						arg_212_1:RecordAudio("1104903050", var_215_11)
						arg_212_1:RecordAudio("1104903050", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903050", "story_v_side_new_1104903.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903050", "story_v_side_new_1104903.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play1104903051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1104903051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1104903052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1049ui_story"]) and arg_216_1.var_.characterEffect1049ui_story == nil then
				arg_216_1.var_.characterEffect1049ui_story = arg_216_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1049ui_story"]) then
				if arg_216_1.var_.characterEffect1049ui_story and not isNil(arg_216_1.actors_["1049ui_story"]) then
					arg_216_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1049ui_story"]) and arg_216_1.var_.characterEffect1049ui_story then
				arg_216_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.875

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(1104903051).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 35 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 35)

				if (35 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 35)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1104903052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1104903052
		arg_220_1.duration_ = 9.9

		local var_220_0 = {
			zh = 8.3,
			ja = 9.9
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1104903053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1049ui_story = arg_220_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1049ui_story"].transform.position).z)
				arg_220_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1049ui_story"].transform.localEulerAngles = arg_220_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_220_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1049ui_story"].transform.position).z)
				arg_220_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1049ui_story"].transform.localEulerAngles = arg_220_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["1049ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1049ui_story == nil then
				arg_220_1.var_.characterEffect1049ui_story = var_223_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 and not isNil(var_223_1) then
				if arg_220_1.var_.characterEffect1049ui_story and not isNil(var_223_1) then
					arg_220_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1049ui_story then
				arg_220_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_223_4 = 0
			local var_223_5 = 0.65

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(1104903052)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 26 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 26)

				if (26 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 26)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903052", "story_v_side_new_1104903.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903052", "story_v_side_new_1104903.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_side_new_1104903", "1104903052", "story_v_side_new_1104903.awb")

						arg_220_1:RecordAudio("1104903052", var_223_11)
						arg_220_1:RecordAudio("1104903052", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903052", "story_v_side_new_1104903.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903052", "story_v_side_new_1104903.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play1104903053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1104903053
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1104903054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1049ui_story"]) and arg_224_1.var_.characterEffect1049ui_story == nil then
				arg_224_1.var_.characterEffect1049ui_story = arg_224_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1049ui_story"]) then
				if arg_224_1.var_.characterEffect1049ui_story and not isNil(arg_224_1.actors_["1049ui_story"]) then
					arg_224_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1049ui_story"]) and arg_224_1.var_.characterEffect1049ui_story then
				arg_224_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_227_1 = 0
			local var_227_2 = 0.1

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(1104903053).content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 4 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 4)

				if (4 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 4)) > 0 and var_227_2 < var_227_5 then
					arg_224_1.talkMaxDuration = var_227_5

					if var_227_5 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + var_227_1
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_6 = math.max(var_227_2, arg_224_1.talkMaxDuration)

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_6 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_1) / var_227_6

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_1 + var_227_6 and arg_224_1.time_ < var_227_1 + var_227_6 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1104903054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1104903054
		arg_228_1.duration_ = 9.73

		local var_228_0 = {
			zh = 7.133,
			ja = 9.733
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
				arg_228_0:Play1104903055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1049ui_story = arg_228_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1049ui_story"].transform.position).z)
				arg_228_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1049ui_story"].transform.localEulerAngles = arg_228_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_228_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1049ui_story"].transform.position).z)
				arg_228_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1049ui_story"].transform.localEulerAngles = arg_228_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["1049ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1049ui_story == nil then
				arg_228_1.var_.characterEffect1049ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect1049ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1049ui_story then
				arg_228_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_4 = 0
			local var_231_5 = 0.8

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(1104903054)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 32 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 32)

				if (32 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 32)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903054", "story_v_side_new_1104903.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903054", "story_v_side_new_1104903.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_side_new_1104903", "1104903054", "story_v_side_new_1104903.awb")

						arg_228_1:RecordAudio("1104903054", var_231_11)
						arg_228_1:RecordAudio("1104903054", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903054", "story_v_side_new_1104903.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903054", "story_v_side_new_1104903.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play1104903055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1104903055
		arg_232_1.duration_ = 7

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1104903056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 1.01666666666667 < arg_232_1.time_ and arg_232_1.time_ <= 1.01666666666667 + arg_235_0 then
				local var_235_0 = arg_232_1.bgs_.K01i

				arg_232_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_235_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_235_1 = var_235_0:GetComponent("SpriteRenderer")

				if var_235_1 and var_235_1.sprite then
					local var_235_2 = 2 * (var_235_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_235_0.transform.localScale = Vector3.New(var_235_2 / var_235_1.sprite.bounds.size.y < var_235_2 * manager.ui.mainCameraCom_.aspect / var_235_1.sprite.bounds.size.x and var_235_2 * manager.ui.mainCameraCom_.aspect / var_235_1.sprite.bounds.size.x or var_235_2 / var_235_1.sprite.bounds.size.y, var_235_2 / var_235_1.sprite.bounds.size.y < var_235_2 * manager.ui.mainCameraCom_.aspect / var_235_1.sprite.bounds.size.x and var_235_2 * manager.ui.mainCameraCom_.aspect / var_235_1.sprite.bounds.size.x or var_235_2 / var_235_1.sprite.bounds.size.y, 0)
				end

				for iter_235_0, iter_235_1 in pairs(arg_232_1.bgs_) do
					if iter_235_0 ~= "K01i" then
						iter_235_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_235_3 = 2

			if 2 < arg_232_1.time_ and arg_232_1.time_ <= var_235_3 + arg_235_0 then
				arg_232_1.allBtn_.enabled = false
			end

			if arg_232_1.time_ >= var_235_3 + 0.3 and arg_232_1.time_ < var_235_3 + 0.3 + arg_235_0 then
				arg_232_1.allBtn_.enabled = true
			end

			local var_235_4 = 0

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.mask_.enabled = true
				arg_232_1.mask_.raycastTarget = true

				arg_232_1:SetGaussion(false)
			end

			local var_235_5 = 1

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_5 then
				local var_235_6 = Color.New(0, 0, 0)

				var_235_6.a = Mathf.Lerp(0, 1, (arg_232_1.time_ - var_235_4) / var_235_5)
				arg_232_1.mask_.color = var_235_6
			end

			if arg_232_1.time_ >= var_235_4 + var_235_5 and arg_232_1.time_ < var_235_4 + var_235_5 + arg_235_0 then
				local var_235_7 = Color.New(0, 0, 0)

				var_235_7.a = 1
				arg_232_1.mask_.color = var_235_7
			end

			local var_235_8 = 1

			if 1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_8 + arg_235_0 then
				arg_232_1.mask_.enabled = true
				arg_232_1.mask_.raycastTarget = true

				arg_232_1:SetGaussion(false)
			end

			local var_235_9 = 2

			if var_235_8 <= arg_232_1.time_ and arg_232_1.time_ < var_235_8 + var_235_9 then
				local var_235_10 = Color.New(0, 0, 0)

				var_235_10.a = Mathf.Lerp(1, 0, (arg_232_1.time_ - var_235_8) / var_235_9)
				arg_232_1.mask_.color = var_235_10
			end

			if arg_232_1.time_ >= var_235_8 + var_235_9 and arg_232_1.time_ < var_235_8 + var_235_9 + arg_235_0 then
				local var_235_11 = Color.New(0, 0, 0)

				arg_232_1.mask_.enabled = false
				var_235_11.a = 0
				arg_232_1.mask_.color = var_235_11
			end

			local var_235_12 = arg_232_1.actors_["1049ui_story"]

			if 0.983333333333333 < arg_232_1.time_ and arg_232_1.time_ <= 0.983333333333333 + arg_235_0 and not isNil(var_235_12) and arg_232_1.var_.characterEffect1049ui_story == nil then
				arg_232_1.var_.characterEffect1049ui_story = var_235_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_13 = 0.0166666666666667

			if 0.983333333333333 <= arg_232_1.time_ and arg_232_1.time_ < 0.983333333333333 + var_235_13 and not isNil(var_235_12) then
				if arg_232_1.var_.characterEffect1049ui_story and not isNil(var_235_12) then
					arg_232_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0.983333333333333) / var_235_13)
				end
			end

			if arg_232_1.time_ >= 0.983333333333333 + var_235_13 and arg_232_1.time_ < 0.983333333333333 + var_235_13 + arg_235_0 and not isNil(var_235_12) and arg_232_1.var_.characterEffect1049ui_story then
				arg_232_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_235_14 = arg_232_1.bgs_.K01i.transform

			if 1 < arg_232_1.time_ and arg_232_1.time_ <= 1 + arg_235_0 then
				arg_232_1.var_.moveOldPosK01i = var_235_14.localPosition
			end

			local var_235_15 = 0.001

			if 1 <= arg_232_1.time_ and arg_232_1.time_ < 1 + var_235_15 then
				var_235_14.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPosK01i, Vector3.New(0, 1.5, 6.5), (arg_232_1.time_ - 1) / var_235_15)
			end

			if arg_232_1.time_ >= 1 + var_235_15 and arg_232_1.time_ < 1 + var_235_15 + arg_235_0 then
				var_235_14.localPosition = Vector3.New(0, 1.5, 6.5)
			end

			local var_235_16 = arg_232_1.bgs_.K01i.transform

			if 1.01666666666667 < arg_232_1.time_ and arg_232_1.time_ <= 1.01666666666667 + arg_235_0 then
				arg_232_1.var_.moveOldPosK01i = var_235_16.localPosition
			end

			local var_235_17 = 5.5

			if 1.01666666666667 <= arg_232_1.time_ and arg_232_1.time_ < 1.01666666666667 + var_235_17 then
				var_235_16.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPosK01i, Vector3.New(0, 1, 6), (arg_232_1.time_ - 1.01666666666667) / var_235_17)
			end

			if arg_232_1.time_ >= 1.01666666666667 + var_235_17 and arg_232_1.time_ < 1.01666666666667 + var_235_17 + arg_235_0 then
				var_235_16.localPosition = Vector3.New(0, 1, 6)
			end

			local var_235_18 = arg_232_1.actors_["1049ui_story"].transform

			if 0.966 < arg_232_1.time_ and arg_232_1.time_ <= 0.966 + arg_235_0 then
				arg_232_1.var_.moveOldPos1049ui_story = var_235_18.localPosition
			end

			local var_235_19 = 0.001

			if 0.966 <= arg_232_1.time_ and arg_232_1.time_ < 0.966 + var_235_19 then
				var_235_18.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0.966) / var_235_19)
				var_235_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_18.position).x, (manager.ui.mainCamera.transform.position - var_235_18.position).y, (manager.ui.mainCamera.transform.position - var_235_18.position).z)
				var_235_18.localEulerAngles.z = 0
				var_235_18.localEulerAngles.x = 0
				var_235_18.localEulerAngles = var_235_18.localEulerAngles
			end

			if arg_232_1.time_ >= 0.966 + var_235_19 and arg_232_1.time_ < 0.966 + var_235_19 + arg_235_0 then
				var_235_18.localPosition = Vector3.New(0, 100, 0)
				var_235_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_18.position).x, (manager.ui.mainCamera.transform.position - var_235_18.position).y, (manager.ui.mainCamera.transform.position - var_235_18.position).z)
				var_235_18.localEulerAngles.z = 0
				var_235_18.localEulerAngles.x = 0
				var_235_18.localEulerAngles = var_235_18.localEulerAngles
			end

			if arg_232_1.frameCnt_ <= 1 then
				arg_232_1.dialog_:SetActive(false)
			end

			local var_235_20 = 2
			local var_235_21 = 0.7

			if 2 < arg_232_1.time_ and arg_232_1.time_ <= var_235_20 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0

				arg_232_1.dialog_:SetActive(true)

				arg_232_1.dialogCg_.alpha = 0

				local var_235_22 = LeanTween.value(arg_232_1.dialog_, 0, 1, 0.3)

				var_235_22:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_232_1.dialogCg_.alpha = arg_236_0
				end))
				var_235_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_232_1.dialog_)
					var_235_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_232_1.duration_ = arg_232_1.duration_ + 0.3

				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_23 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1104903055).content)

				arg_232_1.text_.text = var_235_23

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_25 = 28 <= 0 and var_235_21 or var_235_21 * (utf8.len(var_235_23) / 28)

				if (28 <= 0 and var_235_21 or var_235_21 * (utf8.len(var_235_23) / 28)) > 0 and var_235_21 < var_235_25 then
					arg_232_1.talkMaxDuration = var_235_25
					var_235_20 = var_235_20 + 0.3

					if var_235_25 + var_235_20 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_25 + var_235_20
					end
				end

				arg_232_1.text_.text = var_235_23
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_26 = var_235_20 + 0.3
			local var_235_27 = math.max(var_235_21, arg_232_1.talkMaxDuration)

			if var_235_20 + 0.3 <= arg_232_1.time_ and arg_232_1.time_ < var_235_26 + var_235_27 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_26) / var_235_27

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_26 + var_235_27 and arg_232_1.time_ < var_235_26 + var_235_27 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "K01i",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "K01i",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play1104903056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104903056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104903057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.3

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1104903056).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 12 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 12)

				if (12 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 12)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1104903057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104903057
		arg_242_1.duration_ = 11.23

		local var_242_0 = {
			zh = 11.166,
			ja = 11.233
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104903058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 2.6 < arg_242_1.time_ and arg_242_1.time_ <= 2.6 + arg_245_0 then
				arg_242_1.var_.moveOldPos1049ui_story = arg_242_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 2.6 <= arg_242_1.time_ and arg_242_1.time_ < 2.6 + var_245_0 then
				arg_242_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_242_1.time_ - 2.6) / var_245_0)
				arg_242_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1049ui_story"].transform.position).z)
				arg_242_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1049ui_story"].transform.localEulerAngles = arg_242_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 2.6 + var_245_0 and arg_242_1.time_ < 2.6 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_242_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1049ui_story"].transform.position).z)
				arg_242_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1049ui_story"].transform.localEulerAngles = arg_242_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1049ui_story"]

			if 2.6 < arg_242_1.time_ and arg_242_1.time_ <= 2.6 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1049ui_story == nil then
				arg_242_1.var_.characterEffect1049ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 2.6 <= arg_242_1.time_ and arg_242_1.time_ < 2.6 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1049ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 2.6 + var_245_2 and arg_242_1.time_ < 2.6 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1049ui_story then
				arg_242_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 2.6 < arg_242_1.time_ and arg_242_1.time_ <= 2.6 + arg_245_0 then
				arg_242_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 2.6 < arg_242_1.time_ and arg_242_1.time_ <= 2.6 + arg_245_0 then
				arg_242_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_245_4 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_5 = 1

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_5 then
				local var_245_6 = Color.New(0, 0, 0)

				var_245_6.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_4) / var_245_5)
				arg_242_1.mask_.color = var_245_6
			end

			if arg_242_1.time_ >= var_245_4 + var_245_5 and arg_242_1.time_ < var_245_4 + var_245_5 + arg_245_0 then
				local var_245_7 = Color.New(0, 0, 0)

				var_245_7.a = 1
				arg_242_1.mask_.color = var_245_7
			end

			local var_245_8 = 1

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_9 = 2

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_9 then
				local var_245_10 = Color.New(0, 0, 0)

				var_245_10.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_8) / var_245_9)
				arg_242_1.mask_.color = var_245_10
			end

			if arg_242_1.time_ >= var_245_8 + var_245_9 and arg_242_1.time_ < var_245_8 + var_245_9 + arg_245_0 then
				local var_245_11 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_11.a = 0
				arg_242_1.mask_.color = var_245_11
			end

			if 1.01666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 1.01666666666667 + arg_245_0 then
				local var_245_12 = arg_242_1.bgs_.K01i

				arg_242_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_13 = var_245_12:GetComponent("SpriteRenderer")

				if var_245_13 and var_245_13.sprite then
					local var_245_14 = 2 * (var_245_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_12.transform.localScale = Vector3.New(var_245_14 / var_245_13.sprite.bounds.size.y < var_245_14 * manager.ui.mainCameraCom_.aspect / var_245_13.sprite.bounds.size.x and var_245_14 * manager.ui.mainCameraCom_.aspect / var_245_13.sprite.bounds.size.x or var_245_14 / var_245_13.sprite.bounds.size.y, var_245_14 / var_245_13.sprite.bounds.size.y < var_245_14 * manager.ui.mainCameraCom_.aspect / var_245_13.sprite.bounds.size.x and var_245_14 * manager.ui.mainCameraCom_.aspect / var_245_13.sprite.bounds.size.x or var_245_14 / var_245_13.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "K01i" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_15 = 2.6
			local var_245_16 = 0.6

			if 2.6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_17 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_17:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_242_1.dialogCg_.alpha = arg_246_0
				end))
				var_245_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(1104903057)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_21 = 24 <= 0 and var_245_16 or var_245_16 * (utf8.len(var_245_19) / 24)

				if (24 <= 0 and var_245_16 or var_245_16 * (utf8.len(var_245_19) / 24)) > 0 and var_245_16 < var_245_21 then
					arg_242_1.talkMaxDuration = var_245_21
					var_245_15 = var_245_15 + 0.3

					if var_245_21 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_21 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903057", "story_v_side_new_1104903.awb") ~= 0 then
					local var_245_22 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903057", "story_v_side_new_1104903.awb") / 1000

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end

					if var_245_18.prefab_name ~= "" and arg_242_1.actors_[var_245_18.prefab_name] ~= nil then
						local var_245_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_18.prefab_name].transform, "story_v_side_new_1104903", "1104903057", "story_v_side_new_1104903.awb")

						arg_242_1:RecordAudio("1104903057", var_245_23)
						arg_242_1:RecordAudio("1104903057", var_245_23)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903057", "story_v_side_new_1104903.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903057", "story_v_side_new_1104903.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_24 = var_245_15 + 0.3
			local var_245_25 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_24 + var_245_25 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_24) / var_245_25

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_24 + var_245_25 and arg_242_1.time_ < var_245_24 + var_245_25 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1104903058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1104903058
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1104903059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1049ui_story = arg_248_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1049ui_story"].transform.position).z)
				arg_248_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1049ui_story"].transform.localEulerAngles = arg_248_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1049ui_story"].transform.position).z)
				arg_248_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1049ui_story"].transform.localEulerAngles = arg_248_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1049ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1049ui_story == nil then
				arg_248_1.var_.characterEffect1049ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1049ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_2)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1049ui_story then
				arg_248_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_251_3 = 0
			local var_251_4 = 0.775

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_3 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_5 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(1104903058).content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 31 <= 0 and var_251_4 or var_251_4 * (utf8.len(var_251_5) / 31)

				if (31 <= 0 and var_251_4 or var_251_4 * (utf8.len(var_251_5) / 31)) > 0 and var_251_4 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_3 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_3
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_4, arg_248_1.talkMaxDuration)

			if var_251_3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_3 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_3) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_3 + var_251_8 and arg_248_1.time_ < var_251_3 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play1104903059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1104903059
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1104903060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 1.025

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1104903059).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 41 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 41)

				if (41 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 41)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1104903060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1104903060
		arg_256_1.duration_ = 7.83

		local var_256_0 = {
			zh = 7.833,
			ja = 5.466
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1104903061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1049ui_story = arg_256_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1049ui_story"].transform.position).z)
				arg_256_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1049ui_story"].transform.localEulerAngles = arg_256_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_256_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1049ui_story"].transform.position).z)
				arg_256_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1049ui_story"].transform.localEulerAngles = arg_256_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_259_1 = arg_256_1.actors_["1049ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1049ui_story == nil then
				arg_256_1.var_.characterEffect1049ui_story = var_259_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_2 and not isNil(var_259_1) then
				if arg_256_1.var_.characterEffect1049ui_story and not isNil(var_259_1) then
					arg_256_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_2 and arg_256_1.time_ < 0 + var_259_2 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1049ui_story then
				arg_256_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_259_4 = 0
			local var_259_5 = 0.7

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(1104903060)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 28 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 28)

				if (28 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 28)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903060", "story_v_side_new_1104903.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903060", "story_v_side_new_1104903.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_side_new_1104903", "1104903060", "story_v_side_new_1104903.awb")

						arg_256_1:RecordAudio("1104903060", var_259_11)
						arg_256_1:RecordAudio("1104903060", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903060", "story_v_side_new_1104903.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903060", "story_v_side_new_1104903.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play1104903061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1104903061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1104903062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1049ui_story"]) and arg_260_1.var_.characterEffect1049ui_story == nil then
				arg_260_1.var_.characterEffect1049ui_story = arg_260_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1049ui_story"]) then
				if arg_260_1.var_.characterEffect1049ui_story and not isNil(arg_260_1.actors_["1049ui_story"]) then
					arg_260_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_0)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1049ui_story"]) and arg_260_1.var_.characterEffect1049ui_story then
				arg_260_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_263_1 = 0
			local var_263_2 = 0.9

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1104903061).content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 36 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 36)

				if (36 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 36)) > 0 and var_263_2 < var_263_5 then
					arg_260_1.talkMaxDuration = var_263_5

					if var_263_5 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + var_263_1
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_6 = math.max(var_263_2, arg_260_1.talkMaxDuration)

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_6 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_1) / var_263_6

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_1 + var_263_6 and arg_260_1.time_ < var_263_1 + var_263_6 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1104903062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1104903062
		arg_264_1.duration_ = 5.9

		local var_264_0 = {
			zh = 5.9,
			ja = 4.666
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
				arg_264_0:Play1104903063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1049ui_story"]) and arg_264_1.var_.characterEffect1049ui_story == nil then
				arg_264_1.var_.characterEffect1049ui_story = arg_264_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1049ui_story"]) then
				if arg_264_1.var_.characterEffect1049ui_story and not isNil(arg_264_1.actors_["1049ui_story"]) then
					arg_264_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1049ui_story"]) and arg_264_1.var_.characterEffect1049ui_story then
				arg_264_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_267_2 = 0
			local var_267_3 = 0.55

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_4 = arg_264_1:GetWordFromCfg(1104903062)
				local var_267_5 = arg_264_1:FormatText(var_267_4.content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 22 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 22)

				if (22 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 22)) > 0 and var_267_3 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903062", "story_v_side_new_1104903.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903062", "story_v_side_new_1104903.awb") / 1000

					if var_267_8 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_2
					end

					if var_267_4.prefab_name ~= "" and arg_264_1.actors_[var_267_4.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_4.prefab_name].transform, "story_v_side_new_1104903", "1104903062", "story_v_side_new_1104903.awb")

						arg_264_1:RecordAudio("1104903062", var_267_9)
						arg_264_1:RecordAudio("1104903062", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903062", "story_v_side_new_1104903.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903062", "story_v_side_new_1104903.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_10 and arg_264_1.time_ < var_267_2 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1104903063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1104903063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1104903064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1049ui_story"]) and arg_268_1.var_.characterEffect1049ui_story == nil then
				arg_268_1.var_.characterEffect1049ui_story = arg_268_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1049ui_story"]) then
				if arg_268_1.var_.characterEffect1049ui_story and not isNil(arg_268_1.actors_["1049ui_story"]) then
					arg_268_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1049ui_story"]) and arg_268_1.var_.characterEffect1049ui_story then
				arg_268_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.7

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
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

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(1104903063).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 28 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 28)

				if (28 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 28)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1104903064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1104903064
		arg_272_1.duration_ = 6.7

		local var_272_0 = {
			zh = 3.6,
			ja = 6.7
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1104903065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1049ui_story"]) and arg_272_1.var_.characterEffect1049ui_story == nil then
				arg_272_1.var_.characterEffect1049ui_story = arg_272_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1049ui_story"]) then
				if arg_272_1.var_.characterEffect1049ui_story and not isNil(arg_272_1.actors_["1049ui_story"]) then
					arg_272_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1049ui_story"]) and arg_272_1.var_.characterEffect1049ui_story then
				arg_272_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_275_2 = 0
			local var_275_3 = 0.325

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_4 = arg_272_1:GetWordFromCfg(1104903064)
				local var_275_5 = arg_272_1:FormatText(var_275_4.content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 13 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 13)

				if (13 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 13)) > 0 and var_275_3 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_2
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903064", "story_v_side_new_1104903.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903064", "story_v_side_new_1104903.awb") / 1000

					if var_275_8 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_2
					end

					if var_275_4.prefab_name ~= "" and arg_272_1.actors_[var_275_4.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_4.prefab_name].transform, "story_v_side_new_1104903", "1104903064", "story_v_side_new_1104903.awb")

						arg_272_1:RecordAudio("1104903064", var_275_9)
						arg_272_1:RecordAudio("1104903064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903064", "story_v_side_new_1104903.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903064", "story_v_side_new_1104903.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_3, arg_272_1.talkMaxDuration)

			if var_275_2 <= arg_272_1.time_ and arg_272_1.time_ < var_275_2 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_2) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_2 + var_275_10 and arg_272_1.time_ < var_275_2 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1104903065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1104903065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1104903066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1049ui_story"]) and arg_276_1.var_.characterEffect1049ui_story == nil then
				arg_276_1.var_.characterEffect1049ui_story = arg_276_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1049ui_story"]) then
				if arg_276_1.var_.characterEffect1049ui_story and not isNil(arg_276_1.actors_["1049ui_story"]) then
					arg_276_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1049ui_story"]) and arg_276_1.var_.characterEffect1049ui_story then
				arg_276_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.75

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1104903065).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 30 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 30)

				if (30 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 30)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1104903066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1104903066
		arg_280_1.duration_ = 7.7

		local var_280_0 = {
			zh = 7.7,
			ja = 7.3
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1104903067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1049ui_story"]) and arg_280_1.var_.characterEffect1049ui_story == nil then
				arg_280_1.var_.characterEffect1049ui_story = arg_280_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1049ui_story"]) then
				if arg_280_1.var_.characterEffect1049ui_story and not isNil(arg_280_1.actors_["1049ui_story"]) then
					arg_280_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1049ui_story"]) and arg_280_1.var_.characterEffect1049ui_story then
				arg_280_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_283_2 = 0
			local var_283_3 = 0.875

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_4 = arg_280_1:GetWordFromCfg(1104903066)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 35 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 35)

				if (35 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 35)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903066", "story_v_side_new_1104903.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903066", "story_v_side_new_1104903.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_side_new_1104903", "1104903066", "story_v_side_new_1104903.awb")

						arg_280_1:RecordAudio("1104903066", var_283_9)
						arg_280_1:RecordAudio("1104903066", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903066", "story_v_side_new_1104903.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903066", "story_v_side_new_1104903.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1104903067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1104903067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1104903068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1049ui_story"]) and arg_284_1.var_.characterEffect1049ui_story == nil then
				arg_284_1.var_.characterEffect1049ui_story = arg_284_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1049ui_story"]) then
				if arg_284_1.var_.characterEffect1049ui_story and not isNil(arg_284_1.actors_["1049ui_story"]) then
					arg_284_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1049ui_story"]) and arg_284_1.var_.characterEffect1049ui_story then
				arg_284_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.325

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(1104903067).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 13 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 13)

				if (13 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 13)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1104903068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1104903068
		arg_288_1.duration_ = 6.2

		local var_288_0 = {
			zh = 6.2,
			ja = 4.733
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1104903069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1049ui_story"]) and arg_288_1.var_.characterEffect1049ui_story == nil then
				arg_288_1.var_.characterEffect1049ui_story = arg_288_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1049ui_story"]) then
				if arg_288_1.var_.characterEffect1049ui_story and not isNil(arg_288_1.actors_["1049ui_story"]) then
					arg_288_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1049ui_story"]) and arg_288_1.var_.characterEffect1049ui_story then
				arg_288_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_291_2 = 0
			local var_291_3 = 0.5

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:GetWordFromCfg(1104903068)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 20 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 20)

				if (20 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 20)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903068", "story_v_side_new_1104903.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903068", "story_v_side_new_1104903.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_side_new_1104903", "1104903068", "story_v_side_new_1104903.awb")

						arg_288_1:RecordAudio("1104903068", var_291_9)
						arg_288_1:RecordAudio("1104903068", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903068", "story_v_side_new_1104903.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903068", "story_v_side_new_1104903.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1104903069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1104903069
		arg_292_1.duration_ = 8.7

		local var_292_0 = {
			zh = 8.7,
			ja = 6.6
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
				arg_292_0:Play1104903070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_295_0 = 0
			local var_295_1 = 0.9

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_2 = arg_292_1:GetWordFromCfg(1104903069)
				local var_295_3 = arg_292_1:FormatText(var_295_2.content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 36 <= 0 and var_295_1 or var_295_1 * (utf8.len(var_295_3) / 36)

				if (36 <= 0 and var_295_1 or var_295_1 * (utf8.len(var_295_3) / 36)) > 0 and var_295_1 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903069", "story_v_side_new_1104903.awb") ~= 0 then
					local var_295_6 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903069", "story_v_side_new_1104903.awb") / 1000

					if var_295_6 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_0
					end

					if var_295_2.prefab_name ~= "" and arg_292_1.actors_[var_295_2.prefab_name] ~= nil then
						local var_295_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_2.prefab_name].transform, "story_v_side_new_1104903", "1104903069", "story_v_side_new_1104903.awb")

						arg_292_1:RecordAudio("1104903069", var_295_7)
						arg_292_1:RecordAudio("1104903069", var_295_7)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903069", "story_v_side_new_1104903.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903069", "story_v_side_new_1104903.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_8 and arg_292_1.time_ < var_295_0 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1104903070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1104903070
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1104903071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1049ui_story"]) and arg_296_1.var_.characterEffect1049ui_story == nil then
				arg_296_1.var_.characterEffect1049ui_story = arg_296_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1049ui_story"]) then
				if arg_296_1.var_.characterEffect1049ui_story and not isNil(arg_296_1.actors_["1049ui_story"]) then
					arg_296_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_0)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1049ui_story"]) and arg_296_1.var_.characterEffect1049ui_story then
				arg_296_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_299_1 = 0
			local var_299_2 = 0.475

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1104903070).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 19 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 19)

				if (19 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 19)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play1104903071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1104903071
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1104903072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.2

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(1104903071).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 8 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 8)

				if (8 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 8)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1104903072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1104903072
		arg_304_1.duration_ = 4.73

		local var_304_0 = {
			zh = 3.066,
			ja = 4.733
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
				arg_304_0:Play1104903073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1049ui_story"]) and arg_304_1.var_.characterEffect1049ui_story == nil then
				arg_304_1.var_.characterEffect1049ui_story = arg_304_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1049ui_story"]) then
				if arg_304_1.var_.characterEffect1049ui_story and not isNil(arg_304_1.actors_["1049ui_story"]) then
					arg_304_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1049ui_story"]) and arg_304_1.var_.characterEffect1049ui_story then
				arg_304_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_307_2 = 0
			local var_307_3 = 0.175

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_2 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_4 = arg_304_1:GetWordFromCfg(1104903072)
				local var_307_5 = arg_304_1:FormatText(var_307_4.content)

				arg_304_1.text_.text = var_307_5

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_7 = 7 <= 0 and var_307_3 or var_307_3 * (utf8.len(var_307_5) / 7)

				if (7 <= 0 and var_307_3 or var_307_3 * (utf8.len(var_307_5) / 7)) > 0 and var_307_3 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_2
					end
				end

				arg_304_1.text_.text = var_307_5
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903072", "story_v_side_new_1104903.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903072", "story_v_side_new_1104903.awb") / 1000

					if var_307_8 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_2
					end

					if var_307_4.prefab_name ~= "" and arg_304_1.actors_[var_307_4.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_4.prefab_name].transform, "story_v_side_new_1104903", "1104903072", "story_v_side_new_1104903.awb")

						arg_304_1:RecordAudio("1104903072", var_307_9)
						arg_304_1:RecordAudio("1104903072", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903072", "story_v_side_new_1104903.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903072", "story_v_side_new_1104903.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_3, arg_304_1.talkMaxDuration)

			if var_307_2 <= arg_304_1.time_ and arg_304_1.time_ < var_307_2 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_2) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_2 + var_307_10 and arg_304_1.time_ < var_307_2 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1104903073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1104903073
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1104903074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1049ui_story"]) and arg_308_1.var_.characterEffect1049ui_story == nil then
				arg_308_1.var_.characterEffect1049ui_story = arg_308_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1049ui_story"]) then
				if arg_308_1.var_.characterEffect1049ui_story and not isNil(arg_308_1.actors_["1049ui_story"]) then
					arg_308_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1049ui_story"]) and arg_308_1.var_.characterEffect1049ui_story then
				arg_308_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_311_1 = 0
			local var_311_2 = 0.575

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1104903073).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 23 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 23)

				if (23 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 23)) > 0 and var_311_2 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_6 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_6 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_6

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_6 and arg_308_1.time_ < var_311_1 + var_311_6 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1104903074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1104903074
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1104903075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.675

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(1104903074).content)

				arg_312_1.text_.text = var_315_1

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_3 = 27 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 27)

				if (27 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 27)) > 0 and var_315_0 < var_315_3 then
					arg_312_1.talkMaxDuration = var_315_3

					if var_315_3 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_3 + 0
					end
				end

				arg_312_1.text_.text = var_315_1
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_4 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_4

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1104903075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1104903075
		arg_316_1.duration_ = 10.77

		local var_316_0 = {
			zh = 10.7660000029802,
			ja = 7.46600000298023
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
				arg_316_0:Play1104903076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 2 < arg_316_1.time_ and arg_316_1.time_ <= 2 + arg_319_0 then
				local var_319_0 = arg_316_1.bgs_.K01i

				arg_316_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_319_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_1 = var_319_0:GetComponent("SpriteRenderer")

				if var_319_1 and var_319_1.sprite then
					local var_319_2 = 2 * (var_319_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_319_0.transform.localScale = Vector3.New(var_319_2 / var_319_1.sprite.bounds.size.y < var_319_2 * manager.ui.mainCameraCom_.aspect / var_319_1.sprite.bounds.size.x and var_319_2 * manager.ui.mainCameraCom_.aspect / var_319_1.sprite.bounds.size.x or var_319_2 / var_319_1.sprite.bounds.size.y, var_319_2 / var_319_1.sprite.bounds.size.y < var_319_2 * manager.ui.mainCameraCom_.aspect / var_319_1.sprite.bounds.size.x and var_319_2 * manager.ui.mainCameraCom_.aspect / var_319_1.sprite.bounds.size.x or var_319_2 / var_319_1.sprite.bounds.size.y, 0)
				end

				for iter_319_0, iter_319_1 in pairs(arg_316_1.bgs_) do
					if iter_319_0 ~= "K01i" then
						iter_319_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_319_3 = 4.00000000298023

			if 4.00000000298023 < arg_316_1.time_ and arg_316_1.time_ <= var_319_3 + arg_319_0 then
				arg_316_1.allBtn_.enabled = false
			end

			if arg_316_1.time_ >= var_319_3 + 0.3 and arg_316_1.time_ < var_319_3 + 0.3 + arg_319_0 then
				arg_316_1.allBtn_.enabled = true
			end

			local var_319_4 = 0

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_5 = 2

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_5 then
				local var_319_6 = Color.New(0, 0, 0)

				var_319_6.a = Mathf.Lerp(0, 1, (arg_316_1.time_ - var_319_4) / var_319_5)
				arg_316_1.mask_.color = var_319_6
			end

			if arg_316_1.time_ >= var_319_4 + var_319_5 and arg_316_1.time_ < var_319_4 + var_319_5 + arg_319_0 then
				local var_319_7 = Color.New(0, 0, 0)

				var_319_7.a = 1
				arg_316_1.mask_.color = var_319_7
			end

			local var_319_8 = 2

			if 2 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_9 = 2

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_9 then
				local var_319_10 = Color.New(0, 0, 0)

				var_319_10.a = Mathf.Lerp(1, 0, (arg_316_1.time_ - var_319_8) / var_319_9)
				arg_316_1.mask_.color = var_319_10
			end

			if arg_316_1.time_ >= var_319_8 + var_319_9 and arg_316_1.time_ < var_319_8 + var_319_9 + arg_319_0 then
				local var_319_11 = Color.New(0, 0, 0)

				arg_316_1.mask_.enabled = false
				var_319_11.a = 0
				arg_316_1.mask_.color = var_319_11
			end

			local var_319_12 = arg_316_1.actors_["1049ui_story"].transform

			if 3.8 < arg_316_1.time_ and arg_316_1.time_ <= 3.8 + arg_319_0 then
				arg_316_1.var_.moveOldPos1049ui_story = var_319_12.localPosition
			end

			local var_319_13 = 0.001

			if 3.8 <= arg_316_1.time_ and arg_316_1.time_ < 3.8 + var_319_13 then
				var_319_12.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_316_1.time_ - 3.8) / var_319_13)
				var_319_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_12.position).x, (manager.ui.mainCamera.transform.position - var_319_12.position).y, (manager.ui.mainCamera.transform.position - var_319_12.position).z)
				var_319_12.localEulerAngles.z = 0
				var_319_12.localEulerAngles.x = 0
				var_319_12.localEulerAngles = var_319_12.localEulerAngles
			end

			if arg_316_1.time_ >= 3.8 + var_319_13 and arg_316_1.time_ < 3.8 + var_319_13 + arg_319_0 then
				var_319_12.localPosition = Vector3.New(0, -1.2, -6)
				var_319_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_12.position).x, (manager.ui.mainCamera.transform.position - var_319_12.position).y, (manager.ui.mainCamera.transform.position - var_319_12.position).z)
				var_319_12.localEulerAngles.z = 0
				var_319_12.localEulerAngles.x = 0
				var_319_12.localEulerAngles = var_319_12.localEulerAngles
			end

			local var_319_14 = arg_316_1.actors_["1049ui_story"]

			if 3.8 < arg_316_1.time_ and arg_316_1.time_ <= 3.8 + arg_319_0 and not isNil(var_319_14) and arg_316_1.var_.characterEffect1049ui_story == nil then
				arg_316_1.var_.characterEffect1049ui_story = var_319_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_15 = 0.200000002980232

			if 3.8 <= arg_316_1.time_ and arg_316_1.time_ < 3.8 + var_319_15 and not isNil(var_319_14) then
				if arg_316_1.var_.characterEffect1049ui_story and not isNil(var_319_14) then
					arg_316_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 3.8 + var_319_15 and arg_316_1.time_ < 3.8 + var_319_15 + arg_319_0 and not isNil(var_319_14) and arg_316_1.var_.characterEffect1049ui_story then
				arg_316_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 3.8 < arg_316_1.time_ and arg_316_1.time_ <= 3.8 + arg_319_0 then
				arg_316_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 3.8 < arg_316_1.time_ and arg_316_1.time_ <= 3.8 + arg_319_0 then
				arg_316_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_319_17 = arg_316_1.actors_["1049ui_story"].transform

			if 1.96599999815226 < arg_316_1.time_ and arg_316_1.time_ <= 1.96599999815226 + arg_319_0 then
				arg_316_1.var_.moveOldPos1049ui_story = var_319_17.localPosition
			end

			local var_319_18 = 0.001

			if 1.96599999815226 <= arg_316_1.time_ and arg_316_1.time_ < 1.96599999815226 + var_319_18 then
				var_319_17.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_316_1.time_ - 1.96599999815226) / var_319_18)
				var_319_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_17.position).x, (manager.ui.mainCamera.transform.position - var_319_17.position).y, (manager.ui.mainCamera.transform.position - var_319_17.position).z)
				var_319_17.localEulerAngles.z = 0
				var_319_17.localEulerAngles.x = 0
				var_319_17.localEulerAngles = var_319_17.localEulerAngles
			end

			if arg_316_1.time_ >= 1.96599999815226 + var_319_18 and arg_316_1.time_ < 1.96599999815226 + var_319_18 + arg_319_0 then
				var_319_17.localPosition = Vector3.New(0, 100, 0)
				var_319_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_17.position).x, (manager.ui.mainCamera.transform.position - var_319_17.position).y, (manager.ui.mainCamera.transform.position - var_319_17.position).z)
				var_319_17.localEulerAngles.z = 0
				var_319_17.localEulerAngles.x = 0
				var_319_17.localEulerAngles = var_319_17.localEulerAngles
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_19 = 4.00000000298023
			local var_319_20 = 0.4

			if 4.00000000298023 < arg_316_1.time_ and arg_316_1.time_ <= var_319_19 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_21 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_21:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_22 = arg_316_1:GetWordFromCfg(1104903075)
				local var_319_23 = arg_316_1:FormatText(var_319_22.content)

				arg_316_1.text_.text = var_319_23

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_25 = 16 <= 0 and var_319_20 or var_319_20 * (utf8.len(var_319_23) / 16)

				if (16 <= 0 and var_319_20 or var_319_20 * (utf8.len(var_319_23) / 16)) > 0 and var_319_20 < var_319_25 then
					arg_316_1.talkMaxDuration = var_319_25
					var_319_19 = var_319_19 + 0.3

					if var_319_25 + var_319_19 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_25 + var_319_19
					end
				end

				arg_316_1.text_.text = var_319_23
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903075", "story_v_side_new_1104903.awb") ~= 0 then
					local var_319_26 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903075", "story_v_side_new_1104903.awb") / 1000

					if var_319_26 + var_319_19 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_26 + var_319_19
					end

					if var_319_22.prefab_name ~= "" and arg_316_1.actors_[var_319_22.prefab_name] ~= nil then
						local var_319_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_22.prefab_name].transform, "story_v_side_new_1104903", "1104903075", "story_v_side_new_1104903.awb")

						arg_316_1:RecordAudio("1104903075", var_319_27)
						arg_316_1:RecordAudio("1104903075", var_319_27)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903075", "story_v_side_new_1104903.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903075", "story_v_side_new_1104903.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_28 = var_319_19 + 0.3
			local var_319_29 = math.max(var_319_20, arg_316_1.talkMaxDuration)

			if var_319_19 + 0.3 <= arg_316_1.time_ and arg_316_1.time_ < var_319_28 + var_319_29 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_28) / var_319_29

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_28 + var_319_29 and arg_316_1.time_ < var_319_28 + var_319_29 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play1104903076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1104903076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1104903077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1049ui_story = arg_322_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_325_0 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 then
				arg_322_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_322_1.time_ - 0) / var_325_0)
				arg_322_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1049ui_story"].transform.position).z)
				arg_322_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1049ui_story"].transform.localEulerAngles = arg_322_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 then
				arg_322_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1049ui_story"].transform.position).z)
				arg_322_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1049ui_story"].transform.localEulerAngles = arg_322_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_325_1 = arg_322_1.actors_["1049ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1049ui_story == nil then
				arg_322_1.var_.characterEffect1049ui_story = var_325_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_2 and not isNil(var_325_1) then
				if arg_322_1.var_.characterEffect1049ui_story and not isNil(var_325_1) then
					arg_322_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_2)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_2 and arg_322_1.time_ < 0 + var_325_2 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1049ui_story then
				arg_322_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_325_3 = 0
			local var_325_4 = 1.025

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_3 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_5 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(1104903076).content)

				arg_322_1.text_.text = var_325_5

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 41 <= 0 and var_325_4 or var_325_4 * (utf8.len(var_325_5) / 41)

				if (41 <= 0 and var_325_4 or var_325_4 * (utf8.len(var_325_5) / 41)) > 0 and var_325_4 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_3 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_3
					end
				end

				arg_322_1.text_.text = var_325_5
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_4, arg_322_1.talkMaxDuration)

			if var_325_3 <= arg_322_1.time_ and arg_322_1.time_ < var_325_3 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_3) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_3 + var_325_8 and arg_322_1.time_ < var_325_3 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play1104903077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1104903077
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1104903078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.175

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(1104903077).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 7 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 7)

				if (7 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 7)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1104903078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1104903078
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1104903079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 1.075

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1104903078).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 43 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 43)

				if (43 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 43)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1104903079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1104903079
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1104903080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.625

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

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(1104903079).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 25 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 25)

				if (25 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 25)) > 0 and var_337_0 < var_337_3 then
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
	Play1104903080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1104903080
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1104903081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.8

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(1104903080).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 32 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 32)

				if (32 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 32)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1104903081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1104903081
		arg_342_1.duration_ = 6.47

		local var_342_0 = {
			zh = 4.633,
			ja = 6.466
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1104903082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1049ui_story = arg_342_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_345_0 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 then
				arg_342_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_342_1.time_ - 0) / var_345_0)
				arg_342_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1049ui_story"].transform.position).z)
				arg_342_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1049ui_story"].transform.localEulerAngles = arg_342_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 then
				arg_342_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_342_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1049ui_story"].transform.position).z)
				arg_342_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1049ui_story"].transform.localEulerAngles = arg_342_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_345_1 = arg_342_1.actors_["1049ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect1049ui_story == nil then
				arg_342_1.var_.characterEffect1049ui_story = var_345_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_2 and not isNil(var_345_1) then
				if arg_342_1.var_.characterEffect1049ui_story and not isNil(var_345_1) then
					arg_342_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_2 and arg_342_1.time_ < 0 + var_345_2 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect1049ui_story then
				arg_342_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_345_4 = 0
			local var_345_5 = 0.475

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_6 = arg_342_1:GetWordFromCfg(1104903081)
				local var_345_7 = arg_342_1:FormatText(var_345_6.content)

				arg_342_1.text_.text = var_345_7

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 19 <= 0 and var_345_5 or var_345_5 * (utf8.len(var_345_7) / 19)

				if (19 <= 0 and var_345_5 or var_345_5 * (utf8.len(var_345_7) / 19)) > 0 and var_345_5 < var_345_9 then
					arg_342_1.talkMaxDuration = var_345_9

					if var_345_9 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_4
					end
				end

				arg_342_1.text_.text = var_345_7
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903081", "story_v_side_new_1104903.awb") ~= 0 then
					local var_345_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903081", "story_v_side_new_1104903.awb") / 1000

					if var_345_10 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_10 + var_345_4
					end

					if var_345_6.prefab_name ~= "" and arg_342_1.actors_[var_345_6.prefab_name] ~= nil then
						local var_345_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_6.prefab_name].transform, "story_v_side_new_1104903", "1104903081", "story_v_side_new_1104903.awb")

						arg_342_1:RecordAudio("1104903081", var_345_11)
						arg_342_1:RecordAudio("1104903081", var_345_11)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903081", "story_v_side_new_1104903.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903081", "story_v_side_new_1104903.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_12 = math.max(var_345_5, arg_342_1.talkMaxDuration)

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_12 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_4) / var_345_12

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_4 + var_345_12 and arg_342_1.time_ < var_345_4 + var_345_12 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play1104903082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1104903082
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1104903083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1049ui_story"]) and arg_346_1.var_.characterEffect1049ui_story == nil then
				arg_346_1.var_.characterEffect1049ui_story = arg_346_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1049ui_story"]) then
				if arg_346_1.var_.characterEffect1049ui_story and not isNil(arg_346_1.actors_["1049ui_story"]) then
					arg_346_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1049ui_story"]) and arg_346_1.var_.characterEffect1049ui_story then
				arg_346_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_349_1 = 0
			local var_349_2 = 1.15

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(1104903082).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 46 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 46)

				if (46 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 46)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1104903083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1104903083
		arg_350_1.duration_ = 5

		local var_350_0 = {
			zh = 4.633,
			ja = 5
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
				arg_350_0:Play1104903084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1049ui_story = arg_350_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1049ui_story"].transform.position).z)
				arg_350_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1049ui_story"].transform.localEulerAngles = arg_350_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_350_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1049ui_story"].transform.position).z)
				arg_350_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1049ui_story"].transform.localEulerAngles = arg_350_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_353_1 = arg_350_1.actors_["1049ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect1049ui_story == nil then
				arg_350_1.var_.characterEffect1049ui_story = var_353_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 and not isNil(var_353_1) then
				if arg_350_1.var_.characterEffect1049ui_story and not isNil(var_353_1) then
					arg_350_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect1049ui_story then
				arg_350_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_353_4 = 0
			local var_353_5 = 0.425

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:GetWordFromCfg(1104903083)
				local var_353_7 = arg_350_1:FormatText(var_353_6.content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 17 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 17)

				if (17 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 17)) > 0 and var_353_5 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903083", "story_v_side_new_1104903.awb") ~= 0 then
					local var_353_10 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903083", "story_v_side_new_1104903.awb") / 1000

					if var_353_10 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_4
					end

					if var_353_6.prefab_name ~= "" and arg_350_1.actors_[var_353_6.prefab_name] ~= nil then
						local var_353_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_6.prefab_name].transform, "story_v_side_new_1104903", "1104903083", "story_v_side_new_1104903.awb")

						arg_350_1:RecordAudio("1104903083", var_353_11)
						arg_350_1:RecordAudio("1104903083", var_353_11)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903083", "story_v_side_new_1104903.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903083", "story_v_side_new_1104903.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_12 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_12 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_12

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_12 and arg_350_1.time_ < var_353_4 + var_353_12 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1104903084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1104903084
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1104903085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1049ui_story"]) and arg_354_1.var_.characterEffect1049ui_story == nil then
				arg_354_1.var_.characterEffect1049ui_story = arg_354_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1049ui_story"]) then
				if arg_354_1.var_.characterEffect1049ui_story and not isNil(arg_354_1.actors_["1049ui_story"]) then
					arg_354_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_0)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1049ui_story"]) and arg_354_1.var_.characterEffect1049ui_story then
				arg_354_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_357_1 = 0
			local var_357_2 = 0.25

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
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

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(1104903084).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 10 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 10)

				if (10 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 10)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1104903085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1104903085
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1104903086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1049ui_story = arg_358_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1049ui_story"].transform.position).z)
				arg_358_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1049ui_story"].transform.localEulerAngles = arg_358_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1049ui_story"].transform.position).z)
				arg_358_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1049ui_story"].transform.localEulerAngles = arg_358_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["1049ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1049ui_story == nil then
				arg_358_1.var_.characterEffect1049ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect1049ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_2)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1049ui_story then
				arg_358_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_361_3 = 0
			local var_361_4 = 1.35

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

				local var_361_5 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(1104903085).content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 54 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 54)

				if (54 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 54)) > 0 and var_361_4 < var_361_7 then
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play1104903086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1104903086
		arg_362_1.duration_ = 2.17

		local var_362_0 = {
			zh = 2.133,
			ja = 2.166
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
				arg_362_0:Play1104903087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.2

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_1 = arg_362_1:GetWordFromCfg(1104903086)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 8 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 8)

				if (8 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 8)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903086", "story_v_side_new_1104903.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903086", "story_v_side_new_1104903.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_side_new_1104903", "1104903086", "story_v_side_new_1104903.awb")

						arg_362_1:RecordAudio("1104903086", var_365_6)
						arg_362_1:RecordAudio("1104903086", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903086", "story_v_side_new_1104903.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903086", "story_v_side_new_1104903.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1104903087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1104903087
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1104903088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.875

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1104903087).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 35 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 35)

				if (35 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 35)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1104903088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1104903088
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1104903089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.8

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1104903088).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 32 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 32)

				if (32 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 32)) > 0 and var_373_0 < var_373_3 then
					arg_370_1.talkMaxDuration = var_373_3

					if var_373_3 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_3 + 0
					end
				end

				arg_370_1.text_.text = var_373_1
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_4 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_4

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1104903089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1104903089
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1104903090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 1.175

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(1104903089).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 47 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 47)

				if (47 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 47)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1104903090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1104903090
		arg_378_1.duration_ = 4.67

		local var_378_0 = {
			zh = 4.233,
			ja = 4.666
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1104903091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.35

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_1 = arg_378_1:GetWordFromCfg(1104903090)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 14 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 14)

				if (14 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 14)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903090", "story_v_side_new_1104903.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903090", "story_v_side_new_1104903.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_side_new_1104903", "1104903090", "story_v_side_new_1104903.awb")

						arg_378_1:RecordAudio("1104903090", var_381_6)
						arg_378_1:RecordAudio("1104903090", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903090", "story_v_side_new_1104903.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903090", "story_v_side_new_1104903.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1104903091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1104903091
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1104903092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.725

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1104903091).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 29 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 29)

				if (29 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 29)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1104903092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1104903092
		arg_386_1.duration_ = 5.57

		local var_386_0 = {
			zh = 3.9,
			ja = 5.566
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1104903093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.325

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:GetWordFromCfg(1104903092)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 13 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 13)

				if (13 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 13)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903092", "story_v_side_new_1104903.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903092", "story_v_side_new_1104903.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_side_new_1104903", "1104903092", "story_v_side_new_1104903.awb")

						arg_386_1:RecordAudio("1104903092", var_389_6)
						arg_386_1:RecordAudio("1104903092", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903092", "story_v_side_new_1104903.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903092", "story_v_side_new_1104903.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1104903093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1104903093
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1104903094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.425

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(1104903093).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 17 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 17)

				if (17 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 17)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1104903094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1104903094
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1104903095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.5

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1104903094).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 20 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 20)

				if (20 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 20)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1104903095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1104903095
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1104903096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(1104903095).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 40 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 40)

				if (40 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 40)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1104903096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1104903096
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1104903097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.65

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(1104903096).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 26 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 26)

				if (26 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 26)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1104903097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1104903097
		arg_406_1.duration_ = 5.57

		local var_406_0 = {
			zh = 5.266,
			ja = 5.566
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1104903098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.5

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(1104903097)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 20 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 20)

				if (20 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 20)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903097", "story_v_side_new_1104903.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903097", "story_v_side_new_1104903.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_side_new_1104903", "1104903097", "story_v_side_new_1104903.awb")

						arg_406_1:RecordAudio("1104903097", var_409_6)
						arg_406_1:RecordAudio("1104903097", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903097", "story_v_side_new_1104903.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903097", "story_v_side_new_1104903.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1104903098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1104903098
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1104903099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.9

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1104903098).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 36 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 36)

				if (36 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 36)) > 0 and var_413_0 < var_413_3 then
					arg_410_1.talkMaxDuration = var_413_3

					if var_413_3 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_3 + 0
					end
				end

				arg_410_1.text_.text = var_413_1
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_4 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_4

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1104903099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1104903099
		arg_414_1.duration_ = 4.2

		local var_414_0 = {
			zh = 2.9,
			ja = 4.2
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
				arg_414_0:Play1104903100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.2

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:GetWordFromCfg(1104903099)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 8 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 8)

				if (8 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 8)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903099", "story_v_side_new_1104903.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903099", "story_v_side_new_1104903.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_side_new_1104903", "1104903099", "story_v_side_new_1104903.awb")

						arg_414_1:RecordAudio("1104903099", var_417_6)
						arg_414_1:RecordAudio("1104903099", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903099", "story_v_side_new_1104903.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903099", "story_v_side_new_1104903.awb")
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
	Play1104903100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1104903100
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1104903101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.65

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(1104903100).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 26 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 26)

				if (26 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 26)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1104903101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1104903101
		arg_422_1.duration_ = 6.33

		local var_422_0 = {
			zh = 5.533,
			ja = 6.333
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
				arg_422_0:Play1104903102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.35

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_1 = arg_422_1:GetWordFromCfg(1104903101)
				local var_425_2 = arg_422_1:FormatText(var_425_1.content)

				arg_422_1.text_.text = var_425_2

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 14 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 14)

				if (14 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 14)) > 0 and var_425_0 < var_425_4 then
					arg_422_1.talkMaxDuration = var_425_4

					if var_425_4 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_4 + 0
					end
				end

				arg_422_1.text_.text = var_425_2
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903101", "story_v_side_new_1104903.awb") ~= 0 then
					local var_425_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903101", "story_v_side_new_1104903.awb") / 1000

					if var_425_5 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + 0
					end

					if var_425_1.prefab_name ~= "" and arg_422_1.actors_[var_425_1.prefab_name] ~= nil then
						local var_425_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_1.prefab_name].transform, "story_v_side_new_1104903", "1104903101", "story_v_side_new_1104903.awb")

						arg_422_1:RecordAudio("1104903101", var_425_6)
						arg_422_1:RecordAudio("1104903101", var_425_6)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903101", "story_v_side_new_1104903.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903101", "story_v_side_new_1104903.awb")
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
	Play1104903102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1104903102
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1104903103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.375

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1104903102).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 15 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 15)

				if (15 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 15)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1104903103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1104903103
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1104903104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.675

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(1104903103).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 27 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 27)

				if (27 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 27)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1104903104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1104903104
		arg_434_1.duration_ = 16.27

		local var_434_0 = {
			zh = 16.266,
			ja = 11.4
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1104903105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.475

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:GetWordFromCfg(1104903104)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 19 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 19)

				if (19 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 19)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903104", "story_v_side_new_1104903.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903104", "story_v_side_new_1104903.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_side_new_1104903", "1104903104", "story_v_side_new_1104903.awb")

						arg_434_1:RecordAudio("1104903104", var_437_6)
						arg_434_1:RecordAudio("1104903104", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903104", "story_v_side_new_1104903.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903104", "story_v_side_new_1104903.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1104903105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1104903105
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1104903106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.65

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(1104903105).content)

				arg_438_1.text_.text = var_441_1

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_3 = 26 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 26)

				if (26 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 26)) > 0 and var_441_0 < var_441_3 then
					arg_438_1.talkMaxDuration = var_441_3

					if var_441_3 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_3 + 0
					end
				end

				arg_438_1.text_.text = var_441_1
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_4 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_4

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1104903106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1104903106
		arg_442_1.duration_ = 6.73

		local var_442_0 = {
			zh = 3.166,
			ja = 6.733
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1104903107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.3

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_1 = arg_442_1:GetWordFromCfg(1104903106)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 12 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 12)

				if (12 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 12)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903106", "story_v_side_new_1104903.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903106", "story_v_side_new_1104903.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_side_new_1104903", "1104903106", "story_v_side_new_1104903.awb")

						arg_442_1:RecordAudio("1104903106", var_445_6)
						arg_442_1:RecordAudio("1104903106", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903106", "story_v_side_new_1104903.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903106", "story_v_side_new_1104903.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1104903107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1104903107
		arg_446_1.duration_ = 1

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"

			SetActive(arg_446_1.choicesGo_, true)

			for iter_447_0, iter_447_1 in ipairs(arg_446_1.choices_) do
				SetActive(iter_447_1.go, iter_447_0 <= 2)
			end

			arg_446_1.choices_[1].txt.text = arg_446_1:FormatText(StoryChoiceCfg[875].name)
			arg_446_1.choices_[2].txt.text = arg_446_1:FormatText(StoryChoiceCfg[876].name)
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1104903108(arg_446_1)
			end

			if arg_448_0 == 2 then
				arg_446_0:Play1104903108(arg_446_1)
			end

			arg_446_1:RecordChoiceLog(1104903107, 875, 876)
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			if arg_446_1.time_ >= 0 + 0.6 and arg_446_1.time_ < 0 + 0.6 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1104903108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1104903108
		arg_450_1.duration_ = 10.93

		local var_450_0 = {
			zh = 10.933,
			ja = 5.566
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1104903109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.45

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:GetWordFromCfg(1104903108)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 18 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 18)

				if (18 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 18)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903108", "story_v_side_new_1104903.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_side_new_1104903", "1104903108", "story_v_side_new_1104903.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_side_new_1104903", "1104903108", "story_v_side_new_1104903.awb")

						arg_450_1:RecordAudio("1104903108", var_453_6)
						arg_450_1:RecordAudio("1104903108", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_new_1104903", "1104903108", "story_v_side_new_1104903.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_new_1104903", "1104903108", "story_v_side_new_1104903.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1104903109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1104903109
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
			arg_454_1.auto_ = false
		end

		function arg_454_1.playNext_(arg_456_0)
			arg_454_1.onStoryFinished_()
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 1.15

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(1104903109).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 46 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 46)

				if (46 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 46)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/YA0105",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/K01i"
	},
	voices = {
		"story_v_side_new_1104903.awb"
	}
}
