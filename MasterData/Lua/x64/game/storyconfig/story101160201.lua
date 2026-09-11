return {
	Play116021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I02")
				var_4_0.name = "I02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I02

				arg_1_1.bgs_.I02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I02" then
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

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot", "")
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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
			local var_4_16 = 0.225

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[326].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116021001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 9 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 9)

				if (9 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 9)) > 0 and var_4_16 < var_4_20 then
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
	Play116021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116021002
		arg_9_1.duration_ = 1.6

		local var_9_0 = {
			zh = 1.2,
			ja = 1.6
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
				arg_9_0:Play116021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.125

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(116021002)
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021002", "story_v_out_116021.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021002", "story_v_out_116021.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_116021", "116021002", "story_v_out_116021.awb")

						arg_9_1:RecordAudio("116021002", var_12_6)
						arg_9_1:RecordAudio("116021002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116021", "116021002", "story_v_out_116021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116021", "116021002", "story_v_out_116021.awb")
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
	Play116021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116021003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.775

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(116021003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 31)

				if (31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 31)) > 0 and var_16_0 < var_16_3 then
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
	Play116021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116021004
		arg_17_1.duration_ = 10.83

		local var_17_0 = {
			zh = 10.533,
			ja = 10.833
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
				arg_17_0:Play116021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[52].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(116021004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 45)

				if (45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 45)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021004", "story_v_out_116021.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021004", "story_v_out_116021.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_116021", "116021004", "story_v_out_116021.awb")

						arg_17_1:RecordAudio("116021004", var_20_6)
						arg_17_1:RecordAudio("116021004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116021", "116021004", "story_v_out_116021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116021", "116021004", "story_v_out_116021.awb")
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
	Play116021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116021005
		arg_21_1.duration_ = 1.33

		local var_21_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_21_0:Play116021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(116021005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 3 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 3)

				if (3 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 3)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021005", "story_v_out_116021.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021005", "story_v_out_116021.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_116021", "116021005", "story_v_out_116021.awb")

						arg_21_1:RecordAudio("116021005", var_24_6)
						arg_21_1:RecordAudio("116021005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116021", "116021005", "story_v_out_116021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116021", "116021005", "story_v_out_116021.awb")
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
	Play116021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116021006
		arg_25_1.duration_ = 8

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.ST07b == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_28_0.name = "ST07b"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.ST07b = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				if arg_25_0.sceneSettingEffect_ then
					arg_25_1.sceneSettingEffect_.enabled = false
				end

				arg_25_1.sceneSettingGo_:SetActive(true)

				local var_28_1 = arg_25_1.bgs_.ST07b

				arg_25_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST07b" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			local var_28_12 = "ST07b_blur"

			if arg_25_1.bgs_.ST07b_blur == nil then
				local var_28_13 = Object.Instantiate(arg_25_1.blurPaintGo_)

				var_28_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_12)
				var_28_13.name = var_28_12
				var_28_13.transform.parent = arg_25_1.stage_.transform
				var_28_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_12] = var_28_13
			end

			local var_28_14 = 2
			local var_28_15 = arg_25_1.bgs_[var_28_12]

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				var_28_15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_16 = var_28_15:GetComponent("SpriteRenderer")

				if var_28_16 and var_28_16.sprite then
					local var_28_17 = 2 * (var_28_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_15.transform.localScale = Vector3.New(var_28_17 / var_28_16.sprite.bounds.size.y < var_28_17 * manager.ui.mainCameraCom_.aspect / var_28_16.sprite.bounds.size.x and var_28_17 * manager.ui.mainCameraCom_.aspect / var_28_16.sprite.bounds.size.x or var_28_17 / var_28_16.sprite.bounds.size.y, var_28_17 / var_28_16.sprite.bounds.size.y < var_28_17 * manager.ui.mainCameraCom_.aspect / var_28_16.sprite.bounds.size.x and var_28_17 * manager.ui.mainCameraCom_.aspect / var_28_16.sprite.bounds.size.x or var_28_17 / var_28_16.sprite.bounds.size.y, 0)
				end
			end

			local var_28_18 = 1

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_18 then
				local var_28_19 = Color.New(1, 1, 1)

				var_28_19.a = Mathf.Lerp(0, 0.6, (arg_25_1.time_ - var_28_14) / var_28_18)

				var_28_15:GetComponent("SpriteRenderer").material:SetColor("_Color", var_28_19)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_20 = 3
			local var_28_21 = 0.25

			if 3 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_22 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_22:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(116021006).content)

				arg_25_1.text_.text = var_28_23

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 10 <= 0 and var_28_21 or var_28_21 * (utf8.len(var_28_23) / 10)

				if (10 <= 0 and var_28_21 or var_28_21 * (utf8.len(var_28_23) / 10)) > 0 and var_28_21 < var_28_25 then
					arg_25_1.talkMaxDuration = var_28_25
					var_28_20 = var_28_20 + 0.3

					if var_28_25 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_25 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_23
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_26 = var_28_20 + 0.3
			local var_28_27 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_26 + var_28_27 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_26) / var_28_27

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_26 + var_28_27 and arg_25_1.time_ < var_28_26 + var_28_27 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116021007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116021007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116021008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1.425

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(116021007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 57 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 57)

				if (57 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 57)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116021008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116021008
		arg_35_1.duration_ = 2

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116021009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if arg_35_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_38_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_35_1.stage_.transform)

				var_38_0.name = "1019ui_story"
				var_38_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1019ui_story"] = var_38_0

				local var_38_1 = var_38_0:GetComponentInChildren(typeof(CharacterEffect))

				var_38_1.enabled = true

				local var_38_2 = GameObjectTools.GetOrAddComponent(var_38_0, typeof(DynamicBoneHelper))

				if var_38_2 then
					var_38_2:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_1.transform, false)

				arg_35_1.var_["1019ui_story" .. "Animator"] = var_38_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_35_1.var_["1019ui_story" .. "LipSync"] = var_38_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_3 = arg_35_1.actors_["1019ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1019ui_story = var_38_3.localPosition
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_3.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_35_1.time_ - 0) / var_38_4)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_38_5 = arg_35_1.actors_["1019ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1019ui_story == nil then
				arg_35_1.var_.characterEffect1019ui_story = var_38_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_6 and not isNil(var_38_5) then
				if arg_35_1.var_.characterEffect1019ui_story and not isNil(var_38_5) then
					arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_6 and arg_35_1.time_ < 0 + var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1019ui_story then
				arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_38_8 = 0
			local var_38_9 = 0.125

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_10 = arg_35_1:GetWordFromCfg(116021008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 5 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 5)

				if (5 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 5)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021008", "story_v_out_116021.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021008", "story_v_out_116021.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_116021", "116021008", "story_v_out_116021.awb")

						arg_35_1:RecordAudio("116021008", var_38_15)
						arg_35_1:RecordAudio("116021008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116021", "116021008", "story_v_out_116021.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116021", "116021008", "story_v_out_116021.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play116021009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116021009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116021010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) and arg_39_1.var_.characterEffect1019ui_story == nil then
				arg_39_1.var_.characterEffect1019ui_story = arg_39_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) then
				if arg_39_1.var_.characterEffect1019ui_story and not isNil(arg_39_1.actors_["1019ui_story"]) then
					arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) and arg_39_1.var_.characterEffect1019ui_story then
				arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 1.075

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(116021009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 43 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 43)

				if (43 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 43)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116021010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116021010
		arg_43_1.duration_ = 5.83

		local var_43_0 = {
			zh = 3.133,
			ja = 5.833
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play116021011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:GetWordFromCfg(116021010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 13 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 13)

				if (13 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 13)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021010", "story_v_out_116021.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021010", "story_v_out_116021.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_116021", "116021010", "story_v_out_116021.awb")

						arg_43_1:RecordAudio("116021010", var_46_6)
						arg_43_1:RecordAudio("116021010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116021", "116021010", "story_v_out_116021.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116021", "116021010", "story_v_out_116021.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play116021011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116021011
		arg_47_1.duration_ = 0.02

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"

			SetActive(arg_47_1.choicesGo_, true)

			for iter_48_0, iter_48_1 in ipairs(arg_47_1.choices_) do
				SetActive(iter_48_1.go, iter_48_0 <= 1)
			end

			arg_47_1.choices_[1].txt.text = arg_47_1:FormatText(StoryChoiceCfg[224].name)
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116021012(arg_47_1)
			end

			arg_47_1:RecordChoiceLog(116021011, 224)
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			return
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play116021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116021012
		arg_51_1.duration_ = 5.9

		local var_51_0 = {
			zh = 5.9,
			ja = 5.866
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.525

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_2 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_2:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(116021012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 21 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_4) / 21)

				if (21 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_4) / 21)) > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6
					var_54_0 = var_54_0 + 0.3

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021012", "story_v_out_116021.awb") ~= 0 then
					local var_54_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021012", "story_v_out_116021.awb") / 1000

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_116021", "116021012", "story_v_out_116021.awb")

						arg_51_1:RecordAudio("116021012", var_54_8)
						arg_51_1:RecordAudio("116021012", var_54_8)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_116021", "116021012", "story_v_out_116021.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_116021", "116021012", "story_v_out_116021.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = var_54_0 + 0.3
			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_9) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_9 + var_54_10 and arg_51_1.time_ < var_54_9 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116021013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116021013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play116021014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.4

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

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(116021013).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 56 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 56)

				if (56 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 56)) > 0 and var_60_0 < var_60_3 then
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
	Play116021014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116021014
		arg_61_1.duration_ = 4.2

		local var_61_0 = {
			zh = 4.2,
			ja = 3
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
				arg_61_0:Play116021015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(116021014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 13 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 13)

				if (13 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 13)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021014", "story_v_out_116021.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021014", "story_v_out_116021.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_116021", "116021014", "story_v_out_116021.awb")

						arg_61_1:RecordAudio("116021014", var_64_6)
						arg_61_1:RecordAudio("116021014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116021", "116021014", "story_v_out_116021.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116021", "116021014", "story_v_out_116021.awb")
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
	Play116021015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116021015
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116021016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.bgs_.SK0104 == nil then
				local var_68_0 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0104")
				var_68_0.name = "SK0104"
				var_68_0.transform.parent = arg_65_1.stage_.transform
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_.SK0104 = var_68_0
			end

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				local var_68_1 = arg_65_1.bgs_.SK0104

				arg_65_1.bgs_.SK0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_2 = var_68_1:GetComponent("SpriteRenderer")

				if var_68_2 and var_68_2.sprite then
					local var_68_3 = 2 * (var_68_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_1.transform.localScale = Vector3.New(var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "SK0104" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_4 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_5 = 2

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_5 then
				local var_68_6 = Color.New(0, 0, 0)

				var_68_6.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_4) / var_68_5)
				arg_65_1.mask_.color = var_68_6
			end

			if arg_65_1.time_ >= var_68_4 + var_68_5 and arg_65_1.time_ < var_68_4 + var_68_5 + arg_68_0 then
				local var_68_7 = Color.New(0, 0, 0)

				var_68_7.a = 1
				arg_65_1.mask_.color = var_68_7
			end

			local var_68_8 = 2

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_9 = 2

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 then
				local var_68_10 = Color.New(0, 0, 0)

				var_68_10.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_8) / var_68_9)
				arg_65_1.mask_.color = var_68_10
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 then
				local var_68_11 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_11.a = 0
				arg_65_1.mask_.color = var_68_11
			end

			local var_68_12 = arg_65_1.bgs_.SK0104.transform

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				arg_65_1.var_.moveOldPosSK0104 = var_68_12.localPosition
			end

			local var_68_13 = 2.5

			if 2 <= arg_65_1.time_ and arg_65_1.time_ < 2 + var_68_13 then
				var_68_12.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPosSK0104, Vector3.New(0, 1, 9.5), (arg_65_1.time_ - 2) / var_68_13)
			end

			if arg_65_1.time_ >= 2 + var_68_13 and arg_65_1.time_ < 2 + var_68_13 + arg_68_0 then
				var_68_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_68_14 = arg_65_1.actors_["1019ui_story"].transform

			if 1.966 < arg_65_1.time_ and arg_65_1.time_ <= 1.966 + arg_68_0 then
				arg_65_1.var_.moveOldPos1019ui_story = var_68_14.localPosition
			end

			local var_68_15 = 0.001

			if 1.966 <= arg_65_1.time_ and arg_65_1.time_ < 1.966 + var_68_15 then
				var_68_14.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 1.966) / var_68_15)
				var_68_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_14.position).x, (manager.ui.mainCamera.transform.position - var_68_14.position).y, (manager.ui.mainCamera.transform.position - var_68_14.position).z)
				var_68_14.localEulerAngles.z = 0
				var_68_14.localEulerAngles.x = 0
				var_68_14.localEulerAngles = var_68_14.localEulerAngles
			end

			if arg_65_1.time_ >= 1.966 + var_68_15 and arg_65_1.time_ < 1.966 + var_68_15 + arg_68_0 then
				var_68_14.localPosition = Vector3.New(0, 100, 0)
				var_68_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_14.position).x, (manager.ui.mainCamera.transform.position - var_68_14.position).y, (manager.ui.mainCamera.transform.position - var_68_14.position).z)
				var_68_14.localEulerAngles.z = 0
				var_68_14.localEulerAngles.x = 0
				var_68_14.localEulerAngles = var_68_14.localEulerAngles
			end

			local var_68_16 = 4

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_16 + 0.5 and arg_65_1.time_ < var_68_16 + 0.5 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_17 = 4
			local var_68_18 = 1.5

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_19 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_19:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_20 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(116021015).content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_22 = 61 <= 0 and var_68_18 or var_68_18 * (utf8.len(var_68_20) / 61)

				if (61 <= 0 and var_68_18 or var_68_18 * (utf8.len(var_68_20) / 61)) > 0 and var_68_18 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22
					var_68_17 = var_68_17 + 0.3

					if var_68_22 + var_68_17 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_17
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_23 = var_68_17 + 0.3
			local var_68_24 = math.max(var_68_18, arg_65_1.talkMaxDuration)

			if var_68_17 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play116021016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116021016
		arg_71_1.duration_ = 8.17

		local var_71_0 = {
			zh = 7.433,
			ja = 8.166
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
				arg_71_0:Play116021017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.55

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(116021016)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 22 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 22)

				if (22 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 22)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021016", "story_v_out_116021.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021016", "story_v_out_116021.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_116021", "116021016", "story_v_out_116021.awb")

						arg_71_1:RecordAudio("116021016", var_74_6)
						arg_71_1:RecordAudio("116021016", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116021", "116021016", "story_v_out_116021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116021", "116021016", "story_v_out_116021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116021017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116021017
		arg_75_1.duration_ = 9.8

		local var_75_0 = {
			zh = 5.433,
			ja = 9.8
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
				arg_75_0:Play116021018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.4

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(116021017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 16 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 16)

				if (16 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 16)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021017", "story_v_out_116021.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021017", "story_v_out_116021.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_116021", "116021017", "story_v_out_116021.awb")

						arg_75_1:RecordAudio("116021017", var_78_6)
						arg_75_1:RecordAudio("116021017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116021", "116021017", "story_v_out_116021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116021", "116021017", "story_v_out_116021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play116021018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116021018
		arg_79_1.duration_ = 7.1

		local var_79_0 = {
			zh = 7.1,
			ja = 5.6
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
				arg_79_0:Play116021019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.7

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(116021018)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 29 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 29)

				if (29 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 29)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021018", "story_v_out_116021.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021018", "story_v_out_116021.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_116021", "116021018", "story_v_out_116021.awb")

						arg_79_1:RecordAudio("116021018", var_82_6)
						arg_79_1:RecordAudio("116021018", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116021", "116021018", "story_v_out_116021.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116021", "116021018", "story_v_out_116021.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116021019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116021019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116021020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1019ui_story"]) and arg_83_1.var_.characterEffect1019ui_story == nil then
				arg_83_1.var_.characterEffect1019ui_story = arg_83_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1019ui_story"]) then
				if arg_83_1.var_.characterEffect1019ui_story and not isNil(arg_83_1.actors_["1019ui_story"]) then
					arg_83_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1019ui_story"]) and arg_83_1.var_.characterEffect1019ui_story then
				arg_83_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_86_1 = 0
			local var_86_2 = 0.35

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(116021019).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 14 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 14)

				if (14 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 14)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116021020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116021020
		arg_87_1.duration_ = 12.1

		local var_87_0 = {
			zh = 8.9,
			ja = 12.1
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116021021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:GetWordFromCfg(116021020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 44 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 44)

				if (44 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 44)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021020", "story_v_out_116021.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021020", "story_v_out_116021.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_116021", "116021020", "story_v_out_116021.awb")

						arg_87_1:RecordAudio("116021020", var_90_6)
						arg_87_1:RecordAudio("116021020", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116021", "116021020", "story_v_out_116021.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116021", "116021020", "story_v_out_116021.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116021021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116021021
		arg_91_1.duration_ = 3.4

		local var_91_0 = {
			zh = 1.766,
			ja = 3.4
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
				arg_91_0:Play116021022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.25

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(116021021)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 10 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 10)

				if (10 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 10)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021021", "story_v_out_116021.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021021", "story_v_out_116021.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_116021", "116021021", "story_v_out_116021.awb")

						arg_91_1:RecordAudio("116021021", var_94_6)
						arg_91_1:RecordAudio("116021021", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116021", "116021021", "story_v_out_116021.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116021", "116021021", "story_v_out_116021.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play116021022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116021022
		arg_95_1.duration_ = 7.37

		local var_95_0 = {
			zh = 7.066,
			ja = 7.366
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
				arg_95_0:Play116021023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1019ui_story"]) and arg_95_1.var_.characterEffect1019ui_story == nil then
				arg_95_1.var_.characterEffect1019ui_story = arg_95_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1019ui_story"]) then
				if arg_95_1.var_.characterEffect1019ui_story and not isNil(arg_95_1.actors_["1019ui_story"]) then
					arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1019ui_story"]) and arg_95_1.var_.characterEffect1019ui_story then
				arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.675

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(116021022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 27 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_4) / 27)

				if (27 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_4) / 27)) > 0 and var_98_2 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021022", "story_v_out_116021.awb") ~= 0 then
					local var_98_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021022", "story_v_out_116021.awb") / 1000

					if var_98_7 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_1
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_116021", "116021022", "story_v_out_116021.awb")

						arg_95_1:RecordAudio("116021022", var_98_8)
						arg_95_1:RecordAudio("116021022", var_98_8)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116021", "116021022", "story_v_out_116021.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116021", "116021022", "story_v_out_116021.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_9 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_9 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_9

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_9 and arg_95_1.time_ < var_98_1 + var_98_9 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116021023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116021023
		arg_99_1.duration_ = 7.17

		local var_99_0 = {
			zh = 7.166,
			ja = 6.366
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
				arg_99_0:Play116021024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.65

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(116021023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 26 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 26)

				if (26 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 26)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021023", "story_v_out_116021.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021023", "story_v_out_116021.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_116021", "116021023", "story_v_out_116021.awb")

						arg_99_1:RecordAudio("116021023", var_102_6)
						arg_99_1:RecordAudio("116021023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116021", "116021023", "story_v_out_116021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116021", "116021023", "story_v_out_116021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play116021024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116021024
		arg_103_1.duration_ = 6.4

		local var_103_0 = {
			zh = 6.399999999999,
			ja = 6.266666666666
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
				arg_103_0:Play116021025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 1.999999999999 < arg_103_1.time_ and arg_103_1.time_ <= 1.999999999999 + arg_106_0 then
				local var_106_0 = arg_103_1.bgs_.ST07b

				arg_103_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_1 = var_106_0:GetComponent("SpriteRenderer")

				if var_106_1 and var_106_1.sprite then
					local var_106_2 = 2 * (var_106_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_0.transform.localScale = Vector3.New(var_106_2 / var_106_1.sprite.bounds.size.y < var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x and var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x or var_106_2 / var_106_1.sprite.bounds.size.y, var_106_2 / var_106_1.sprite.bounds.size.y < var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x and var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x or var_106_2 / var_106_1.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "ST07b" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_3 = "1037ui_story"

			if arg_103_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_106_4 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_103_1.stage_.transform)

				var_106_4.name = var_106_3
				var_106_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_[var_106_3] = var_106_4

				local var_106_5 = var_106_4:GetComponentInChildren(typeof(CharacterEffect))

				var_106_5.enabled = true

				local var_106_6 = GameObjectTools.GetOrAddComponent(var_106_4, typeof(DynamicBoneHelper))

				if var_106_6 then
					var_106_6:EnableDynamicBone(false)
				end

				arg_103_1:ShowWeapon(var_106_5.transform, false)

				arg_103_1.var_[var_106_3 .. "Animator"] = var_106_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_103_1.var_[var_106_3 .. "Animator"].applyRootMotion = true
				arg_103_1.var_[var_106_3 .. "LipSync"] = var_106_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_106_7 = arg_103_1.actors_["1037ui_story"].transform

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1.var_.moveOldPos1037ui_story = var_106_7.localPosition
			end

			local var_106_8 = 0.001

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_8 then
				var_106_7.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_103_1.time_ - 3.8) / var_106_8)
				var_106_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_7.position).x, (manager.ui.mainCamera.transform.position - var_106_7.position).y, (manager.ui.mainCamera.transform.position - var_106_7.position).z)
				var_106_7.localEulerAngles.z = 0
				var_106_7.localEulerAngles.x = 0
				var_106_7.localEulerAngles = var_106_7.localEulerAngles
			end

			if arg_103_1.time_ >= 3.8 + var_106_8 and arg_103_1.time_ < 3.8 + var_106_8 + arg_106_0 then
				var_106_7.localPosition = Vector3.New(0, -1.09, -5.81)
				var_106_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_7.position).x, (manager.ui.mainCamera.transform.position - var_106_7.position).y, (manager.ui.mainCamera.transform.position - var_106_7.position).z)
				var_106_7.localEulerAngles.z = 0
				var_106_7.localEulerAngles.x = 0
				var_106_7.localEulerAngles = var_106_7.localEulerAngles
			end

			local var_106_9 = arg_103_1.actors_["1037ui_story"]

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1037ui_story == nil then
				arg_103_1.var_.characterEffect1037ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_10 = 0.2

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_10 and not isNil(var_106_9) then
				if arg_103_1.var_.characterEffect1037ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 3.8 + var_106_10 and arg_103_1.time_ < 3.8 + var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1037ui_story then
				arg_103_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_106_12 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_13 = 2

			if var_106_12 <= arg_103_1.time_ and arg_103_1.time_ < var_106_12 + var_106_13 then
				local var_106_14 = Color.New(0, 0, 0)

				var_106_14.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_12) / var_106_13)
				arg_103_1.mask_.color = var_106_14
			end

			if arg_103_1.time_ >= var_106_12 + var_106_13 and arg_103_1.time_ < var_106_12 + var_106_13 + arg_106_0 then
				local var_106_15 = Color.New(0, 0, 0)

				var_106_15.a = 1
				arg_103_1.mask_.color = var_106_15
			end

			local var_106_16 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_17 = 2

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_17 then
				local var_106_18 = Color.New(0, 0, 0)

				var_106_18.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_16) / var_106_17)
				arg_103_1.mask_.color = var_106_18
			end

			if arg_103_1.time_ >= var_106_16 + var_106_17 and arg_103_1.time_ < var_106_16 + var_106_17 + arg_106_0 then
				local var_106_19 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_19.a = 0
				arg_103_1.mask_.color = var_106_19
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_20 = 3.999999999999
			local var_106_21 = 0.25

			if 3.999999999999 < arg_103_1.time_ and arg_103_1.time_ <= var_106_20 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_22 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_22:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_23 = arg_103_1:GetWordFromCfg(116021024)
				local var_106_24 = arg_103_1:FormatText(var_106_23.content)

				arg_103_1.text_.text = var_106_24

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_26 = 10 <= 0 and var_106_21 or var_106_21 * (utf8.len(var_106_24) / 10)

				if (10 <= 0 and var_106_21 or var_106_21 * (utf8.len(var_106_24) / 10)) > 0 and var_106_21 < var_106_26 then
					arg_103_1.talkMaxDuration = var_106_26
					var_106_20 = var_106_20 + 0.3

					if var_106_26 + var_106_20 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_26 + var_106_20
					end
				end

				arg_103_1.text_.text = var_106_24
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021024", "story_v_out_116021.awb") ~= 0 then
					local var_106_27 = manager.audio:GetVoiceLength("story_v_out_116021", "116021024", "story_v_out_116021.awb") / 1000

					if var_106_27 + var_106_20 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_27 + var_106_20
					end

					if var_106_23.prefab_name ~= "" and arg_103_1.actors_[var_106_23.prefab_name] ~= nil then
						local var_106_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_23.prefab_name].transform, "story_v_out_116021", "116021024", "story_v_out_116021.awb")

						arg_103_1:RecordAudio("116021024", var_106_28)
						arg_103_1:RecordAudio("116021024", var_106_28)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116021", "116021024", "story_v_out_116021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116021", "116021024", "story_v_out_116021.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_29 = var_106_20 + 0.3
			local var_106_30 = math.max(var_106_21, arg_103_1.talkMaxDuration)

			if var_106_20 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_29 + var_106_30 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_29) / var_106_30

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_29 + var_106_30 and arg_103_1.time_ < var_106_29 + var_106_30 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play116021025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116021025
		arg_109_1.duration_ = 5.37

		local var_109_0 = {
			zh = 5.366,
			ja = 4.966
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
				arg_109_0:Play116021026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_0 = 0
			local var_112_1 = 0.6

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(116021025)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 24 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 24)

				if (24 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 24)) > 0 and var_112_1 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021025", "story_v_out_116021.awb") ~= 0 then
					local var_112_6 = manager.audio:GetVoiceLength("story_v_out_116021", "116021025", "story_v_out_116021.awb") / 1000

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end

					if var_112_2.prefab_name ~= "" and arg_109_1.actors_[var_112_2.prefab_name] ~= nil then
						local var_112_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_2.prefab_name].transform, "story_v_out_116021", "116021025", "story_v_out_116021.awb")

						arg_109_1:RecordAudio("116021025", var_112_7)
						arg_109_1:RecordAudio("116021025", var_112_7)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_116021", "116021025", "story_v_out_116021.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_116021", "116021025", "story_v_out_116021.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116021026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116021026
		arg_113_1.duration_ = 6.83

		local var_113_0 = {
			zh = 5.9,
			ja = 6.833
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
				arg_113_0:Play116021027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1037ui_story"]) and arg_113_1.var_.characterEffect1037ui_story == nil then
				arg_113_1.var_.characterEffect1037ui_story = arg_113_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1037ui_story"]) then
				if arg_113_1.var_.characterEffect1037ui_story and not isNil(arg_113_1.actors_["1037ui_story"]) then
					arg_113_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1037ui_story"]) and arg_113_1.var_.characterEffect1037ui_story then
				arg_113_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(116021026)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 27 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 27)

				if (27 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 27)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021026", "story_v_out_116021.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021026", "story_v_out_116021.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_116021", "116021026", "story_v_out_116021.awb")

						arg_113_1:RecordAudio("116021026", var_116_8)
						arg_113_1:RecordAudio("116021026", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_116021", "116021026", "story_v_out_116021.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_116021", "116021026", "story_v_out_116021.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play116021027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116021027
		arg_117_1.duration_ = 0.02

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"

			SetActive(arg_117_1.choicesGo_, true)

			for iter_118_0, iter_118_1 in ipairs(arg_117_1.choices_) do
				SetActive(iter_118_1.go, iter_118_0 <= 2)
			end

			arg_117_1.choices_[1].txt.text = arg_117_1:FormatText(StoryChoiceCfg[225].name)
			arg_117_1.choices_[2].txt.text = arg_117_1:FormatText(StoryChoiceCfg[226].name)
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116021028(arg_117_1)
			end

			if arg_119_0 == 2 then
				arg_117_0:Play116021028(arg_117_1)
			end

			arg_117_1:RecordChoiceLog(116021027, 225, 226)
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			return
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play116021028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116021028
		arg_121_1.duration_ = 3.27

		local var_121_0 = {
			zh = 3.266,
			ja = 2.633
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
				arg_121_0:Play116021029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_2 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_2:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(116021028)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 8 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_4) / 8)

				if (8 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_4) / 8)) > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6
					var_124_0 = var_124_0 + 0.3

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021028", "story_v_out_116021.awb") ~= 0 then
					local var_124_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021028", "story_v_out_116021.awb") / 1000

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_116021", "116021028", "story_v_out_116021.awb")

						arg_121_1:RecordAudio("116021028", var_124_8)
						arg_121_1:RecordAudio("116021028", var_124_8)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116021", "116021028", "story_v_out_116021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116021", "116021028", "story_v_out_116021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = var_124_0 + 0.3
			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_9) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play116021029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116021029
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116021030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 1.966 < arg_127_1.time_ and arg_127_1.time_ <= 1.966 + arg_130_0 then
				arg_127_1.var_.moveOldPos1037ui_story = arg_127_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 1.966 <= arg_127_1.time_ and arg_127_1.time_ < 1.966 + var_130_0 then
				arg_127_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 1.966) / var_130_0)
				arg_127_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1037ui_story"].transform.position).z)
				arg_127_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1037ui_story"].transform.localEulerAngles = arg_127_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 1.966 + var_130_0 and arg_127_1.time_ < 1.966 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1037ui_story"].transform.position).z)
				arg_127_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1037ui_story"].transform.localEulerAngles = arg_127_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_130_1 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_2 = 2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = Color.New(0, 0, 0)

				var_130_3.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_1) / var_130_2)
				arg_127_1.mask_.color = var_130_3
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				local var_130_4 = Color.New(0, 0, 0)

				var_130_4.a = 1
				arg_127_1.mask_.color = var_130_4
			end

			local var_130_5 = 2

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_6 = 2

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_5) / var_130_6)
				arg_127_1.mask_.color = var_130_7
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				local var_130_8 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_8.a = 0
				arg_127_1.mask_.color = var_130_8
			end

			local var_130_9 = "B13"

			if arg_127_1.bgs_.B13 == nil then
				local var_130_10 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_9)
				var_130_10.name = var_130_9
				var_130_10.transform.parent = arg_127_1.stage_.transform
				var_130_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_9] = var_130_10
			end

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= 2 + arg_130_0 then
				local var_130_11 = arg_127_1.bgs_.B13

				arg_127_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_12 = var_130_11:GetComponent("SpriteRenderer")

				if var_130_12 and var_130_12.sprite then
					local var_130_13 = 2 * (var_130_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_11.transform.localScale = Vector3.New(var_130_13 / var_130_12.sprite.bounds.size.y < var_130_13 * manager.ui.mainCameraCom_.aspect / var_130_12.sprite.bounds.size.x and var_130_13 * manager.ui.mainCameraCom_.aspect / var_130_12.sprite.bounds.size.x or var_130_13 / var_130_12.sprite.bounds.size.y, var_130_13 / var_130_12.sprite.bounds.size.y < var_130_13 * manager.ui.mainCameraCom_.aspect / var_130_12.sprite.bounds.size.x and var_130_13 * manager.ui.mainCameraCom_.aspect / var_130_12.sprite.bounds.size.x or var_130_13 / var_130_12.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "B13" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_14 = 4
			local var_130_15 = 0.425

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_16 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_16:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_17 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(116021029).content)

				arg_127_1.text_.text = var_130_17

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_19 = 17 <= 0 and var_130_15 or var_130_15 * (utf8.len(var_130_17) / 17)

				if (17 <= 0 and var_130_15 or var_130_15 * (utf8.len(var_130_17) / 17)) > 0 and var_130_15 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19
					var_130_14 = var_130_14 + 0.3

					if var_130_19 + var_130_14 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_14
					end
				end

				arg_127_1.text_.text = var_130_17
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_20 = var_130_14 + 0.3
			local var_130_21 = math.max(var_130_15, arg_127_1.talkMaxDuration)

			if var_130_14 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_20 + var_130_21 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_20) / var_130_21

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_20 + var_130_21 and arg_127_1.time_ < var_130_20 + var_130_21 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play116021030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116021030
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play116021031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(116021030).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 59 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 59)

				if (59 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 59)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116021031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116021031
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116021032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.bgs_.SK0105 == nil then
				local var_140_0 = Object.Instantiate(arg_137_1.paintGo_)

				var_140_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0105")
				var_140_0.name = "SK0105"
				var_140_0.transform.parent = arg_137_1.stage_.transform
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.bgs_.SK0105 = var_140_0
			end

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				local var_140_1 = arg_137_1.bgs_.SK0105

				arg_137_1.bgs_.SK0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_2 = var_140_1:GetComponent("SpriteRenderer")

				if var_140_2 and var_140_2.sprite then
					local var_140_3 = 2 * (var_140_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_1.transform.localScale = Vector3.New(var_140_3 / var_140_2.sprite.bounds.size.y < var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x and var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x or var_140_3 / var_140_2.sprite.bounds.size.y, var_140_3 / var_140_2.sprite.bounds.size.y < var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x and var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x or var_140_3 / var_140_2.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "SK0105" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_4 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_5 = 2

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_5 then
				local var_140_6 = Color.New(0, 0, 0)

				var_140_6.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_4) / var_140_5)
				arg_137_1.mask_.color = var_140_6
			end

			if arg_137_1.time_ >= var_140_4 + var_140_5 and arg_137_1.time_ < var_140_4 + var_140_5 + arg_140_0 then
				local var_140_7 = Color.New(0, 0, 0)

				var_140_7.a = 1
				arg_137_1.mask_.color = var_140_7
			end

			local var_140_8 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_9 = 2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 then
				local var_140_10 = Color.New(0, 0, 0)

				var_140_10.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_8) / var_140_9)
				arg_137_1.mask_.color = var_140_10
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 then
				local var_140_11 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_11.a = 0
				arg_137_1.mask_.color = var_140_11
			end

			local var_140_12 = arg_137_1.bgs_.SK0105.transform

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				arg_137_1.var_.moveOldPosSK0105 = var_140_12.localPosition
			end

			local var_140_13 = 0.001

			if 2 <= arg_137_1.time_ and arg_137_1.time_ < 2 + var_140_13 then
				var_140_12.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPosSK0105, Vector3.New(0.5, 2, 1.5), (arg_137_1.time_ - 2) / var_140_13)
			end

			if arg_137_1.time_ >= 2 + var_140_13 and arg_137_1.time_ < 2 + var_140_13 + arg_140_0 then
				var_140_12.localPosition = Vector3.New(0.5, 2, 1.5)
			end

			local var_140_14 = arg_137_1.bgs_.SK0105.transform

			if 2.034 < arg_137_1.time_ and arg_137_1.time_ <= 2.034 + arg_140_0 then
				arg_137_1.var_.moveOldPosSK0105 = var_140_14.localPosition
			end

			local var_140_15 = 6.5

			if 2.034 <= arg_137_1.time_ and arg_137_1.time_ < 2.034 + var_140_15 then
				var_140_14.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPosSK0105, Vector3.New(0.5, 1, 1.5), (arg_137_1.time_ - 2.034) / var_140_15)
			end

			if arg_137_1.time_ >= 2.034 + var_140_15 and arg_137_1.time_ < 2.034 + var_140_15 + arg_140_0 then
				var_140_14.localPosition = Vector3.New(0.5, 1, 1.5)
			end

			local var_140_16 = 4

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= var_140_16 + 4.534 and arg_137_1.time_ < var_140_16 + 4.534 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_17 = 4
			local var_140_18 = 0.6

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_17 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_19 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_19:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_20 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(116021031).content)

				arg_137_1.text_.text = var_140_20

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_22 = 44 <= 0 and var_140_18 or var_140_18 * (utf8.len(var_140_20) / 44)

				if (44 <= 0 and var_140_18 or var_140_18 * (utf8.len(var_140_20) / 44)) > 0 and var_140_18 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22
					var_140_17 = var_140_17 + 0.3

					if var_140_22 + var_140_17 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_17
					end
				end

				arg_137_1.text_.text = var_140_20
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_23 = var_140_17 + 0.3
			local var_140_24 = math.max(var_140_18, arg_137_1.talkMaxDuration)

			if var_140_17 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_24 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_23) / var_140_24

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_23 + var_140_24 and arg_137_1.time_ < var_140_23 + var_140_24 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play116021032 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116021032
		arg_143_1.duration_ = 1

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play116021033(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door06", "")
			end

			local var_146_1 = 0
			local var_146_2 = 0.05

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(116021032)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 2 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 2)

				if (2 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 2)) > 0 and var_146_2 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021032", "story_v_out_116021.awb") ~= 0 then
					local var_146_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021032", "story_v_out_116021.awb") / 1000

					if var_146_7 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_1
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_116021", "116021032", "story_v_out_116021.awb")

						arg_143_1:RecordAudio("116021032", var_146_8)
						arg_143_1:RecordAudio("116021032", var_146_8)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116021", "116021032", "story_v_out_116021.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116021", "116021032", "story_v_out_116021.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_9 and arg_143_1.time_ < var_146_1 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116021033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116021033
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116021034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.675

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(116021033).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 67 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 67)

				if (67 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 67)) > 0 and var_150_0 < var_150_3 then
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
	Play116021034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116021034
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116021035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1.55

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(116021034).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 62 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 62)

				if (62 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 62)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116021035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116021035
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play116021036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.4

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(116021035).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 56 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 56)

				if (56 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 56)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play116021036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116021036
		arg_159_1.duration_ = 5.5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play116021037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPosSK0105 = arg_159_1.bgs_.SK0105.transform.localPosition
			end

			local var_162_0 = 5

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.bgs_.SK0105.transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPosSK0105, Vector3.New(0.5, -0.5, 1.5), (arg_159_1.time_ - 0) / var_162_0)
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.bgs_.SK0105.transform.localPosition = Vector3.New(0.5, -0.5, 1.5)
			end

			local var_162_1 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_1 + 5 and arg_159_1.time_ < var_162_1 + 5 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_2 = 0
			local var_162_3 = 1.75

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(116021036).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 70 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 70)

				if (70 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 70)) > 0 and var_162_3 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_7 and arg_159_1.time_ < var_162_2 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play116021037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116021037
		arg_163_1.duration_ = 7.9

		local var_163_0 = {
			zh = 6.934,
			ja = 7.9
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
				arg_163_0:Play116021038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 1.966 < arg_163_1.time_ and arg_163_1.time_ <= 1.966 + arg_166_0 then
				arg_163_1.var_.moveOldPosSK0105 = arg_163_1.bgs_.SK0105.transform.localPosition
			end

			local var_166_0 = 0.001

			if 1.966 <= arg_163_1.time_ and arg_163_1.time_ < 1.966 + var_166_0 then
				arg_163_1.bgs_.SK0105.transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPosSK0105, Vector3.New(-3, 0.3, 3.2), (arg_163_1.time_ - 1.966) / var_166_0)
			end

			if arg_163_1.time_ >= 1.966 + var_166_0 and arg_163_1.time_ < 1.966 + var_166_0 + arg_166_0 then
				arg_163_1.bgs_.SK0105.transform.localPosition = Vector3.New(-3, 0.3, 3.2)
			end

			local var_166_1 = arg_163_1.bgs_.SK0105.transform

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				arg_163_1.var_.moveOldPosSK0105 = var_166_1.localPosition
			end

			local var_166_2 = 4

			if 2 <= arg_163_1.time_ and arg_163_1.time_ < 2 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPosSK0105, Vector3.New(-3, 0, 3.2), (arg_163_1.time_ - 2) / var_166_2)
			end

			if arg_163_1.time_ >= 2 + var_166_2 and arg_163_1.time_ < 2 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(-3, 0, 3.2)
			end

			local var_166_3 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_4 = 2

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_4 then
				local var_166_5 = Color.New(0, 0, 0)

				var_166_5.a = Mathf.Lerp(0, 1, (arg_163_1.time_ - var_166_3) / var_166_4)
				arg_163_1.mask_.color = var_166_5
			end

			if arg_163_1.time_ >= var_166_3 + var_166_4 and arg_163_1.time_ < var_166_3 + var_166_4 + arg_166_0 then
				local var_166_6 = Color.New(0, 0, 0)

				var_166_6.a = 1
				arg_163_1.mask_.color = var_166_6
			end

			local var_166_7 = 2

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_8 = 2

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 then
				local var_166_9 = Color.New(0, 0, 0)

				var_166_9.a = Mathf.Lerp(1, 0, (arg_163_1.time_ - var_166_7) / var_166_8)
				arg_163_1.mask_.color = var_166_9
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 then
				local var_166_10 = Color.New(0, 0, 0)

				arg_163_1.mask_.enabled = false
				var_166_10.a = 0
				arg_163_1.mask_.color = var_166_10
			end

			local var_166_11 = 4

			if 4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_11 + 2 and arg_163_1.time_ < var_166_11 + 2 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_12 = 2.034
			local var_166_13 = 0.6

			if 2.034 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_14 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_14:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_15 = arg_163_1:GetWordFromCfg(116021037)
				local var_166_16 = arg_163_1:FormatText(var_166_15.content)

				arg_163_1.text_.text = var_166_16

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_18 = 24 <= 0 and var_166_13 or var_166_13 * (utf8.len(var_166_16) / 24)

				if (24 <= 0 and var_166_13 or var_166_13 * (utf8.len(var_166_16) / 24)) > 0 and var_166_13 < var_166_18 then
					arg_163_1.talkMaxDuration = var_166_18
					var_166_12 = var_166_12 + 0.3

					if var_166_18 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_16
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021037", "story_v_out_116021.awb") ~= 0 then
					local var_166_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021037", "story_v_out_116021.awb") / 1000

					if var_166_19 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_19 + var_166_12
					end

					if var_166_15.prefab_name ~= "" and arg_163_1.actors_[var_166_15.prefab_name] ~= nil then
						local var_166_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_15.prefab_name].transform, "story_v_out_116021", "116021037", "story_v_out_116021.awb")

						arg_163_1:RecordAudio("116021037", var_166_20)
						arg_163_1:RecordAudio("116021037", var_166_20)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_116021", "116021037", "story_v_out_116021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_116021", "116021037", "story_v_out_116021.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_21 = var_166_12 + 0.3
			local var_166_22 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 + 0.3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_21 + var_166_22 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_21) / var_166_22

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_21 + var_166_22 and arg_163_1.time_ < var_166_21 + var_166_22 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play116021038 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116021038
		arg_169_1.duration_ = 10.9

		local var_169_0 = {
			zh = 6.9,
			ja = 10.9
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116021039(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 then
				arg_169_1.var_.moveOldPosSK0105 = arg_169_1.bgs_.SK0105.transform.localPosition
			end

			local var_172_0 = 0.001

			if 2 <= arg_169_1.time_ and arg_169_1.time_ < 2 + var_172_0 then
				arg_169_1.bgs_.SK0105.transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosSK0105, Vector3.New(3.4, 0, 2.5), (arg_169_1.time_ - 2) / var_172_0)
			end

			if arg_169_1.time_ >= 2 + var_172_0 and arg_169_1.time_ < 2 + var_172_0 + arg_172_0 then
				arg_169_1.bgs_.SK0105.transform.localPosition = Vector3.New(3.4, 0, 2.5)
			end

			local var_172_1 = arg_169_1.bgs_.SK0105.transform

			if 2.034 < arg_169_1.time_ and arg_169_1.time_ <= 2.034 + arg_172_0 then
				arg_169_1.var_.moveOldPosSK0105 = var_172_1.localPosition
			end

			local var_172_2 = 2

			if 2.034 <= arg_169_1.time_ and arg_169_1.time_ < 2.034 + var_172_2 then
				var_172_1.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosSK0105, Vector3.New(3.4, -0.5, 2.5), (arg_169_1.time_ - 2.034) / var_172_2)
			end

			if arg_169_1.time_ >= 2.034 + var_172_2 and arg_169_1.time_ < 2.034 + var_172_2 + arg_172_0 then
				var_172_1.localPosition = Vector3.New(3.4, -0.5, 2.5)
			end

			local var_172_3 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_4 = 2

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_4 then
				local var_172_5 = Color.New(0, 0, 0)

				var_172_5.a = Mathf.Lerp(0, 1, (arg_169_1.time_ - var_172_3) / var_172_4)
				arg_169_1.mask_.color = var_172_5
			end

			if arg_169_1.time_ >= var_172_3 + var_172_4 and arg_169_1.time_ < var_172_3 + var_172_4 + arg_172_0 then
				local var_172_6 = Color.New(0, 0, 0)

				var_172_6.a = 1
				arg_169_1.mask_.color = var_172_6
			end

			local var_172_7 = 2

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_8 = 2

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_8 then
				local var_172_9 = Color.New(0, 0, 0)

				var_172_9.a = Mathf.Lerp(1, 0, (arg_169_1.time_ - var_172_7) / var_172_8)
				arg_169_1.mask_.color = var_172_9
			end

			if arg_169_1.time_ >= var_172_7 + var_172_8 and arg_169_1.time_ < var_172_7 + var_172_8 + arg_172_0 then
				local var_172_10 = Color.New(0, 0, 0)

				arg_169_1.mask_.enabled = false
				var_172_10.a = 0
				arg_169_1.mask_.color = var_172_10
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_11 = 2
			local var_172_12 = 0.65

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_13 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_13:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_14 = arg_169_1:GetWordFromCfg(116021038)
				local var_172_15 = arg_169_1:FormatText(var_172_14.content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 26 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_15) / 26)

				if (26 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_15) / 26)) > 0 and var_172_12 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17
					var_172_11 = var_172_11 + 0.3

					if var_172_17 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_11
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021038", "story_v_out_116021.awb") ~= 0 then
					local var_172_18 = manager.audio:GetVoiceLength("story_v_out_116021", "116021038", "story_v_out_116021.awb") / 1000

					if var_172_18 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_11
					end

					if var_172_14.prefab_name ~= "" and arg_169_1.actors_[var_172_14.prefab_name] ~= nil then
						local var_172_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_14.prefab_name].transform, "story_v_out_116021", "116021038", "story_v_out_116021.awb")

						arg_169_1:RecordAudio("116021038", var_172_19)
						arg_169_1:RecordAudio("116021038", var_172_19)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_116021", "116021038", "story_v_out_116021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_116021", "116021038", "story_v_out_116021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_20 = var_172_11 + 0.3
			local var_172_21 = math.max(var_172_12, arg_169_1.talkMaxDuration)

			if var_172_11 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_20 + var_172_21 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_20) / var_172_21

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_20 + var_172_21 and arg_169_1.time_ < var_172_20 + var_172_21 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play116021039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 116021039
		arg_175_1.duration_ = 9

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play116021040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 2 < arg_175_1.time_ and arg_175_1.time_ <= 2 + arg_178_0 then
				arg_175_1.var_.moveOldPosSK0105 = arg_175_1.bgs_.SK0105.transform.localPosition
			end

			local var_178_0 = 0.001

			if 2 <= arg_175_1.time_ and arg_175_1.time_ < 2 + var_178_0 then
				arg_175_1.bgs_.SK0105.transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPosSK0105, Vector3.New(0, 1, 10), (arg_175_1.time_ - 2) / var_178_0)
			end

			if arg_175_1.time_ >= 2 + var_178_0 and arg_175_1.time_ < 2 + var_178_0 + arg_178_0 then
				arg_175_1.bgs_.SK0105.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_178_1 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_2 = 2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = Color.New(0, 0, 0)

				var_178_3.a = Mathf.Lerp(0, 1, (arg_175_1.time_ - var_178_1) / var_178_2)
				arg_175_1.mask_.color = var_178_3
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				local var_178_4 = Color.New(0, 0, 0)

				var_178_4.a = 1
				arg_175_1.mask_.color = var_178_4
			end

			local var_178_5 = 2

			if 2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_6 = 2

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 then
				local var_178_7 = Color.New(0, 0, 0)

				var_178_7.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_5) / var_178_6)
				arg_175_1.mask_.color = var_178_7
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 then
				local var_178_8 = Color.New(0, 0, 0)

				arg_175_1.mask_.enabled = false
				var_178_8.a = 0
				arg_175_1.mask_.color = var_178_8
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_9 = 4
			local var_178_10 = 0.275

			if 4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_11 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_11:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_12 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(116021039).content)

				arg_175_1.text_.text = var_178_12

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_14 = 19 <= 0 and var_178_10 or var_178_10 * (utf8.len(var_178_12) / 19)

				if (19 <= 0 and var_178_10 or var_178_10 * (utf8.len(var_178_12) / 19)) > 0 and var_178_10 < var_178_14 then
					arg_175_1.talkMaxDuration = var_178_14
					var_178_9 = var_178_9 + 0.3

					if var_178_14 + var_178_9 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_9
					end
				end

				arg_175_1.text_.text = var_178_12
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_15 = var_178_9 + 0.3
			local var_178_16 = math.max(var_178_10, arg_175_1.talkMaxDuration)

			if var_178_9 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_16 and arg_175_1.time_ < var_178_15 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play116021040 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116021040
		arg_181_1.duration_ = 11.77

		local var_181_0 = {
			zh = 9.833,
			ja = 11.766
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116021041(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.05

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(116021040)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 42 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 42)

				if (42 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 42)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021040", "story_v_out_116021.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021040", "story_v_out_116021.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_116021", "116021040", "story_v_out_116021.awb")

						arg_181_1:RecordAudio("116021040", var_184_6)
						arg_181_1:RecordAudio("116021040", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_116021", "116021040", "story_v_out_116021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_116021", "116021040", "story_v_out_116021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116021041 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116021041
		arg_185_1.duration_ = 0.02

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"

			SetActive(arg_185_1.choicesGo_, true)

			for iter_186_0, iter_186_1 in ipairs(arg_185_1.choices_) do
				SetActive(iter_186_1.go, iter_186_0 <= 2)
			end

			arg_185_1.choices_[1].txt.text = arg_185_1:FormatText(StoryChoiceCfg[227].name)
			arg_185_1.choices_[2].txt.text = arg_185_1:FormatText(StoryChoiceCfg[228].name)
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116021042(arg_185_1)
			end

			if arg_187_0 == 2 then
				arg_185_0:Play116021044(arg_185_1)
			end

			arg_185_1:RecordChoiceLog(116021041, 227, 228)
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			return
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116021042 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116021042
		arg_189_1.duration_ = 9.03

		local var_189_0 = {
			zh = 8.133,
			ja = 9.033
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
				arg_189_0:Play116021043(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.9

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(116021042)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 36 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 36)

				if (36 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 36)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021042", "story_v_out_116021.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021042", "story_v_out_116021.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_116021", "116021042", "story_v_out_116021.awb")

						arg_189_1:RecordAudio("116021042", var_192_6)
						arg_189_1:RecordAudio("116021042", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116021", "116021042", "story_v_out_116021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116021", "116021042", "story_v_out_116021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116021043 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116021043
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116021045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.15

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(116021043).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 6 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 6)

				if (6 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 6)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116021045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116021045
		arg_197_1.duration_ = 12

		local var_197_0 = {
			zh = 12,
			ja = 9.833
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116021046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if arg_197_1.bgs_.A00 == nil then
				local var_200_0 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_200_0.name = "A00"
				var_200_0.transform.parent = arg_197_1.stage_.transform
				var_200_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_.A00 = var_200_0
			end

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= 2 + arg_200_0 then
				local var_200_1 = arg_197_1.bgs_.A00

				arg_197_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_2 = var_200_1:GetComponent("SpriteRenderer")

				if var_200_2 and var_200_2.sprite then
					local var_200_3 = 2 * (var_200_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_1.transform.localScale = Vector3.New(var_200_3 / var_200_2.sprite.bounds.size.y < var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x and var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x or var_200_3 / var_200_2.sprite.bounds.size.y, var_200_3 / var_200_2.sprite.bounds.size.y < var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x and var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x or var_200_3 / var_200_2.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "A00" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_4 = "1029ui_story"

			if arg_197_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_200_5 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_197_1.stage_.transform)

				var_200_5.name = var_200_4
				var_200_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.actors_[var_200_4] = var_200_5

				local var_200_6 = var_200_5:GetComponentInChildren(typeof(CharacterEffect))

				var_200_6.enabled = true

				local var_200_7 = GameObjectTools.GetOrAddComponent(var_200_5, typeof(DynamicBoneHelper))

				if var_200_7 then
					var_200_7:EnableDynamicBone(false)
				end

				arg_197_1:ShowWeapon(var_200_6.transform, false)

				arg_197_1.var_[var_200_4 .. "Animator"] = var_200_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_197_1.var_[var_200_4 .. "Animator"].applyRootMotion = true
				arg_197_1.var_[var_200_4 .. "LipSync"] = var_200_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_200_8 = arg_197_1.actors_["1029ui_story"].transform

			if 3.8 < arg_197_1.time_ and arg_197_1.time_ <= 3.8 + arg_200_0 then
				arg_197_1.var_.moveOldPos1029ui_story = var_200_8.localPosition
			end

			local var_200_9 = 0.001

			if 3.8 <= arg_197_1.time_ and arg_197_1.time_ < 3.8 + var_200_9 then
				var_200_8.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_197_1.time_ - 3.8) / var_200_9)
				var_200_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_8.position).x, (manager.ui.mainCamera.transform.position - var_200_8.position).y, (manager.ui.mainCamera.transform.position - var_200_8.position).z)
				var_200_8.localEulerAngles.z = 0
				var_200_8.localEulerAngles.x = 0
				var_200_8.localEulerAngles = var_200_8.localEulerAngles
			end

			if arg_197_1.time_ >= 3.8 + var_200_9 and arg_197_1.time_ < 3.8 + var_200_9 + arg_200_0 then
				var_200_8.localPosition = Vector3.New(0, -1.09, -6.2)
				var_200_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_8.position).x, (manager.ui.mainCamera.transform.position - var_200_8.position).y, (manager.ui.mainCamera.transform.position - var_200_8.position).z)
				var_200_8.localEulerAngles.z = 0
				var_200_8.localEulerAngles.x = 0
				var_200_8.localEulerAngles = var_200_8.localEulerAngles
			end

			if 3.8 < arg_197_1.time_ and arg_197_1.time_ <= 3.8 + arg_200_0 then
				arg_197_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 3.8 < arg_197_1.time_ and arg_197_1.time_ <= 3.8 + arg_200_0 then
				arg_197_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_200_10 = arg_197_1.actors_["1029ui_story"]

			if 3.8 < arg_197_1.time_ and arg_197_1.time_ <= 3.8 + arg_200_0 and not isNil(var_200_10) and arg_197_1.var_.characterEffect1029ui_story == nil then
				arg_197_1.var_.characterEffect1029ui_story = var_200_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.2

			if 3.8 <= arg_197_1.time_ and arg_197_1.time_ < 3.8 + var_200_11 and not isNil(var_200_10) then
				if arg_197_1.var_.characterEffect1029ui_story and not isNil(var_200_10) then
					arg_197_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 3.8 + var_200_11 and arg_197_1.time_ < 3.8 + var_200_11 + arg_200_0 and not isNil(var_200_10) and arg_197_1.var_.characterEffect1029ui_story then
				arg_197_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_14 = 2

			if var_200_13 <= arg_197_1.time_ and arg_197_1.time_ < var_200_13 + var_200_14 then
				local var_200_15 = Color.New(0, 0, 0)

				var_200_15.a = Mathf.Lerp(0, 1, (arg_197_1.time_ - var_200_13) / var_200_14)
				arg_197_1.mask_.color = var_200_15
			end

			if arg_197_1.time_ >= var_200_13 + var_200_14 and arg_197_1.time_ < var_200_13 + var_200_14 + arg_200_0 then
				local var_200_16 = Color.New(0, 0, 0)

				var_200_16.a = 1
				arg_197_1.mask_.color = var_200_16
			end

			local var_200_17 = 2

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_17 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_18 = 2

			if var_200_17 <= arg_197_1.time_ and arg_197_1.time_ < var_200_17 + var_200_18 then
				local var_200_19 = Color.New(0, 0, 0)

				var_200_19.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - var_200_17) / var_200_18)
				arg_197_1.mask_.color = var_200_19
			end

			if arg_197_1.time_ >= var_200_17 + var_200_18 and arg_197_1.time_ < var_200_17 + var_200_18 + arg_200_0 then
				local var_200_20 = Color.New(0, 0, 0)

				arg_197_1.mask_.enabled = false
				var_200_20.a = 0
				arg_197_1.mask_.color = var_200_20
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_21 = 4
			local var_200_22 = 0.75

			if 4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_21 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_23 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_23:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_24 = arg_197_1:GetWordFromCfg(116021045)
				local var_200_25 = arg_197_1:FormatText(var_200_24.content)

				arg_197_1.text_.text = var_200_25

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_27 = 38 <= 0 and var_200_22 or var_200_22 * (utf8.len(var_200_25) / 38)

				if (38 <= 0 and var_200_22 or var_200_22 * (utf8.len(var_200_25) / 38)) > 0 and var_200_22 < var_200_27 then
					arg_197_1.talkMaxDuration = var_200_27
					var_200_21 = var_200_21 + 0.3

					if var_200_27 + var_200_21 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_27 + var_200_21
					end
				end

				arg_197_1.text_.text = var_200_25
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021045", "story_v_out_116021.awb") ~= 0 then
					local var_200_28 = manager.audio:GetVoiceLength("story_v_out_116021", "116021045", "story_v_out_116021.awb") / 1000

					if var_200_28 + var_200_21 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_21
					end

					if var_200_24.prefab_name ~= "" and arg_197_1.actors_[var_200_24.prefab_name] ~= nil then
						local var_200_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_24.prefab_name].transform, "story_v_out_116021", "116021045", "story_v_out_116021.awb")

						arg_197_1:RecordAudio("116021045", var_200_29)
						arg_197_1:RecordAudio("116021045", var_200_29)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116021", "116021045", "story_v_out_116021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116021", "116021045", "story_v_out_116021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_30 = var_200_21 + 0.3
			local var_200_31 = math.max(var_200_22, arg_197_1.talkMaxDuration)

			if var_200_21 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_31 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_30) / var_200_31

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_30 + var_200_31 and arg_197_1.time_ < var_200_30 + var_200_31 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play116021046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116021046
		arg_203_1.duration_ = 0.2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"

			SetActive(arg_203_1.choicesGo_, true)

			for iter_204_0, iter_204_1 in ipairs(arg_203_1.choices_) do
				SetActive(iter_204_1.go, iter_204_0 <= 2)
			end

			arg_203_1.choices_[1].txt.text = arg_203_1:FormatText(StoryChoiceCfg[229].name)
			arg_203_1.choices_[2].txt.text = arg_203_1:FormatText(StoryChoiceCfg[230].name)
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play116021047(arg_203_1)
			end

			if arg_205_0 == 2 then
				arg_203_0:Play116021047(arg_203_1)
			end

			arg_203_1:RecordChoiceLog(116021046, 229, 230)
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1029ui_story"]) and arg_203_1.var_.characterEffect1029ui_story == nil then
				arg_203_1.var_.characterEffect1029ui_story = arg_203_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1029ui_story"]) then
				if arg_203_1.var_.characterEffect1029ui_story and not isNil(arg_203_1.actors_["1029ui_story"]) then
					arg_203_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1029ui_story"]) and arg_203_1.var_.characterEffect1029ui_story then
				arg_203_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play116021047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116021047
		arg_207_1.duration_ = 5.93

		local var_207_0 = {
			zh = 5.933,
			ja = 5.633
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
				arg_207_0:Play116021048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_210_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_207_1.stage_.transform)

				var_210_0.name = "1029ui_story"
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1029ui_story"] = var_210_0

				local var_210_1 = var_210_0:GetComponentInChildren(typeof(CharacterEffect))

				var_210_1.enabled = true

				local var_210_2 = GameObjectTools.GetOrAddComponent(var_210_0, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(false)
				end

				arg_207_1:ShowWeapon(var_210_1.transform, false)

				arg_207_1.var_["1029ui_story" .. "Animator"] = var_210_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_207_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_207_1.var_["1029ui_story" .. "LipSync"] = var_210_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_210_3 = arg_207_1.actors_["1029ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1029ui_story == nil then
				arg_207_1.var_.characterEffect1029ui_story = var_210_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_4 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 and not isNil(var_210_3) then
				if arg_207_1.var_.characterEffect1029ui_story and not isNil(var_210_3) then
					arg_207_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1029ui_story then
				arg_207_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_210_6 = 0
			local var_210_7 = 0.525

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(116021047)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 21 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 21)

				if (21 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 21)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021047", "story_v_out_116021.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_116021", "116021047", "story_v_out_116021.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_116021", "116021047", "story_v_out_116021.awb")

						arg_207_1:RecordAudio("116021047", var_210_13)
						arg_207_1:RecordAudio("116021047", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116021", "116021047", "story_v_out_116021.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116021", "116021047", "story_v_out_116021.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116021048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116021048
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play116021049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1029ui_story = arg_211_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1029ui_story"].transform.position).z)
				arg_211_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1029ui_story"].transform.localEulerAngles = arg_211_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1029ui_story"].transform.position).z)
				arg_211_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1029ui_story"].transform.localEulerAngles = arg_211_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_214_1 = 0
			local var_214_2 = 0.9

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(116021048).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 36 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 36)

				if (36 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 36)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play116021049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116021049
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116021050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.675

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(116021049).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 67 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 67)

				if (67 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 67)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play116021050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116021050
		arg_219_1.duration_ = 5.2

		local var_219_0 = {
			zh = 3.633,
			ja = 5.2
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
				arg_219_0:Play116021051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = arg_219_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).z)
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles = arg_219_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_219_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1019ui_story"].transform.position).z)
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1019ui_story"].transform.localEulerAngles = arg_219_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_222_1 = arg_219_1.actors_["1019ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1019ui_story == nil then
				arg_219_1.var_.characterEffect1019ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1019ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1019ui_story then
				arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_222_4 = 0
			local var_222_5 = 0.4

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(116021050)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 16 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 16)

				if (16 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 16)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021050", "story_v_out_116021.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_116021", "116021050", "story_v_out_116021.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_116021", "116021050", "story_v_out_116021.awb")

						arg_219_1:RecordAudio("116021050", var_222_11)
						arg_219_1:RecordAudio("116021050", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_116021", "116021050", "story_v_out_116021.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_116021", "116021050", "story_v_out_116021.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play116021051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116021051
		arg_223_1.duration_ = 9.5

		local var_223_0 = {
			zh = 7.3,
			ja = 9.5
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
				arg_223_0:Play116021052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1029ui_story = arg_223_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1029ui_story"].transform.position).z)
				arg_223_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1029ui_story"].transform.localEulerAngles = arg_223_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_223_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1029ui_story"].transform.position).z)
				arg_223_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1029ui_story"].transform.localEulerAngles = arg_223_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_226_1 = arg_223_1.actors_["1029ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1029ui_story == nil then
				arg_223_1.var_.characterEffect1029ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1029ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1029ui_story then
				arg_223_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_226_4 = arg_223_1.actors_["1019ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect1019ui_story == nil then
				arg_223_1.var_.characterEffect1019ui_story = var_226_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_5 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 and not isNil(var_226_4) then
				if arg_223_1.var_.characterEffect1019ui_story and not isNil(var_226_4) then
					arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_5)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect1019ui_story then
				arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_226_6 = 0
			local var_226_7 = 0.65

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(116021051)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 26 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 26)

				if (26 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 26)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021051", "story_v_out_116021.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_out_116021", "116021051", "story_v_out_116021.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_out_116021", "116021051", "story_v_out_116021.awb")

						arg_223_1:RecordAudio("116021051", var_226_13)
						arg_223_1:RecordAudio("116021051", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116021", "116021051", "story_v_out_116021.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116021", "116021051", "story_v_out_116021.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play116021052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116021052
		arg_227_1.duration_ = 9.7

		local var_227_0 = {
			zh = 6.966,
			ja = 9.7
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
				arg_227_0:Play116021053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1019ui_story = arg_227_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).z)
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles = arg_227_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_227_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).z)
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles = arg_227_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_230_1 = arg_227_1.actors_["1019ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1019ui_story == nil then
				arg_227_1.var_.characterEffect1019ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1019ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1019ui_story then
				arg_227_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["1029ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1029ui_story == nil then
				arg_227_1.var_.characterEffect1029ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_5 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 and not isNil(var_230_4) then
				if arg_227_1.var_.characterEffect1029ui_story and not isNil(var_230_4) then
					arg_227_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_5)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1029ui_story then
				arg_227_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_230_6 = 0
			local var_230_7 = 0.75

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_8 = arg_227_1:GetWordFromCfg(116021052)
				local var_230_9 = arg_227_1:FormatText(var_230_8.content)

				arg_227_1.text_.text = var_230_9

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 30 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 30)

				if (30 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 30)) > 0 and var_230_7 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_9
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021052", "story_v_out_116021.awb") ~= 0 then
					local var_230_12 = manager.audio:GetVoiceLength("story_v_out_116021", "116021052", "story_v_out_116021.awb") / 1000

					if var_230_12 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_12 + var_230_6
					end

					if var_230_8.prefab_name ~= "" and arg_227_1.actors_[var_230_8.prefab_name] ~= nil then
						local var_230_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_8.prefab_name].transform, "story_v_out_116021", "116021052", "story_v_out_116021.awb")

						arg_227_1:RecordAudio("116021052", var_230_13)
						arg_227_1:RecordAudio("116021052", var_230_13)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_116021", "116021052", "story_v_out_116021.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_116021", "116021052", "story_v_out_116021.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play116021053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116021053
		arg_231_1.duration_ = 4

		local var_231_0 = {
			zh = 3.7,
			ja = 4
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
				arg_231_0:Play116021054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_234_0 = arg_231_1.actors_["1029ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1029ui_story == nil then
				arg_231_1.var_.characterEffect1029ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_1 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 and not isNil(var_234_0) then
				if arg_231_1.var_.characterEffect1029ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1029ui_story then
				arg_231_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_234_3 = arg_231_1.actors_["1019ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1019ui_story == nil then
				arg_231_1.var_.characterEffect1019ui_story = var_234_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_4 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 and not isNil(var_234_3) then
				if arg_231_1.var_.characterEffect1019ui_story and not isNil(var_234_3) then
					arg_231_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_4)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1019ui_story then
				arg_231_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_234_5 = 0
			local var_234_6 = 0.45

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(116021053)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 18 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 18)

				if (18 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 18)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021053", "story_v_out_116021.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021053", "story_v_out_116021.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_116021", "116021053", "story_v_out_116021.awb")

						arg_231_1:RecordAudio("116021053", var_234_12)
						arg_231_1:RecordAudio("116021053", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116021", "116021053", "story_v_out_116021.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116021", "116021053", "story_v_out_116021.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_13 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_13

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_13 and arg_231_1.time_ < var_234_5 + var_234_13 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play116021054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116021054
		arg_235_1.duration_ = 14.53

		local var_235_0 = {
			zh = 9.1,
			ja = 14.533
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
				arg_235_0:Play116021055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_238_0 = arg_235_1.actors_["1019ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1019ui_story == nil then
				arg_235_1.var_.characterEffect1019ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_1 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 and not isNil(var_238_0) then
				if arg_235_1.var_.characterEffect1019ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1019ui_story then
				arg_235_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_238_3 = arg_235_1.actors_["1029ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect1029ui_story == nil then
				arg_235_1.var_.characterEffect1029ui_story = var_238_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_4 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 and not isNil(var_238_3) then
				if arg_235_1.var_.characterEffect1029ui_story and not isNil(var_238_3) then
					arg_235_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_4)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect1029ui_story then
				arg_235_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_238_5 = 0
			local var_238_6 = 1.025

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(116021054)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 41 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 41)

				if (41 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 41)) > 0 and var_238_6 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021054", "story_v_out_116021.awb") ~= 0 then
					local var_238_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021054", "story_v_out_116021.awb") / 1000

					if var_238_11 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_5
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_116021", "116021054", "story_v_out_116021.awb")

						arg_235_1:RecordAudio("116021054", var_238_12)
						arg_235_1:RecordAudio("116021054", var_238_12)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116021", "116021054", "story_v_out_116021.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116021", "116021054", "story_v_out_116021.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_13 = math.max(var_238_6, arg_235_1.talkMaxDuration)

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_13 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_5) / var_238_13

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_5 + var_238_13 and arg_235_1.time_ < var_238_5 + var_238_13 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116021055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116021055
		arg_239_1.duration_ = 8.8

		local var_239_0 = {
			zh = 7.066,
			ja = 8.8
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
				arg_239_0:Play116021056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_242_0 = 0
			local var_242_1 = 0.975

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(116021055)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 39 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 39)

				if (39 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 39)) > 0 and var_242_1 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021055", "story_v_out_116021.awb") ~= 0 then
					local var_242_6 = manager.audio:GetVoiceLength("story_v_out_116021", "116021055", "story_v_out_116021.awb") / 1000

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end

					if var_242_2.prefab_name ~= "" and arg_239_1.actors_[var_242_2.prefab_name] ~= nil then
						local var_242_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_2.prefab_name].transform, "story_v_out_116021", "116021055", "story_v_out_116021.awb")

						arg_239_1:RecordAudio("116021055", var_242_7)
						arg_239_1:RecordAudio("116021055", var_242_7)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_116021", "116021055", "story_v_out_116021.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_116021", "116021055", "story_v_out_116021.awb")
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
	Play116021056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116021056
		arg_243_1.duration_ = 5.17

		local var_243_0 = {
			zh = 1.999999999999,
			ja = 5.166
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
				arg_243_0:Play116021057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_0 = arg_243_1.actors_["1019ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1019ui_story == nil then
				arg_243_1.var_.characterEffect1019ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_1 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 and not isNil(var_246_0) then
				if arg_243_1.var_.characterEffect1019ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_1)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1019ui_story then
				arg_243_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_246_2 = arg_243_1.actors_["1029ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.characterEffect1029ui_story == nil then
				arg_243_1.var_.characterEffect1029ui_story = var_246_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_3 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.characterEffect1029ui_story and not isNil(var_246_2) then
					arg_243_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.characterEffect1029ui_story then
				arg_243_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_246_5 = 0
			local var_246_6 = 0.075

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:GetWordFromCfg(116021056)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 3 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 3)

				if (3 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 3)) > 0 and var_246_6 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021056", "story_v_out_116021.awb") ~= 0 then
					local var_246_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021056", "story_v_out_116021.awb") / 1000

					if var_246_11 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_5
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_116021", "116021056", "story_v_out_116021.awb")

						arg_243_1:RecordAudio("116021056", var_246_12)
						arg_243_1:RecordAudio("116021056", var_246_12)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_116021", "116021056", "story_v_out_116021.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_116021", "116021056", "story_v_out_116021.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_13 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_13 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_13

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_13 and arg_243_1.time_ < var_246_5 + var_246_13 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play116021057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 116021057
		arg_247_1.duration_ = 6.9

		local var_247_0 = {
			zh = 3.466,
			ja = 6.9
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
				arg_247_0:Play116021058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_250_0 = arg_247_1.actors_["1019ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1019ui_story == nil then
				arg_247_1.var_.characterEffect1019ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_1 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 and not isNil(var_250_0) then
				if arg_247_1.var_.characterEffect1019ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1019ui_story then
				arg_247_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_250_3 = arg_247_1.actors_["1029ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_3) and arg_247_1.var_.characterEffect1029ui_story == nil then
				arg_247_1.var_.characterEffect1029ui_story = var_250_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_4 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 and not isNil(var_250_3) then
				if arg_247_1.var_.characterEffect1029ui_story and not isNil(var_250_3) then
					arg_247_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_4)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 and not isNil(var_250_3) and arg_247_1.var_.characterEffect1029ui_story then
				arg_247_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_250_5 = 0
			local var_250_6 = 0.45

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(116021057)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 18 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 18)

				if (18 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 18)) > 0 and var_250_6 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021057", "story_v_out_116021.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021057", "story_v_out_116021.awb") / 1000

					if var_250_11 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_5
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_116021", "116021057", "story_v_out_116021.awb")

						arg_247_1:RecordAudio("116021057", var_250_12)
						arg_247_1:RecordAudio("116021057", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_116021", "116021057", "story_v_out_116021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_116021", "116021057", "story_v_out_116021.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_13 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_13 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_13

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_13 and arg_247_1.time_ < var_250_5 + var_250_13 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play116021058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 116021058
		arg_251_1.duration_ = 5.5

		local var_251_0 = {
			zh = 4.933,
			ja = 5.5
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
				arg_251_0:Play116021059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_0 = arg_251_1.actors_["1019ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1019ui_story == nil then
				arg_251_1.var_.characterEffect1019ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_1 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 and not isNil(var_254_0) then
				if arg_251_1.var_.characterEffect1019ui_story and not isNil(var_254_0) then
					arg_251_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_1)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1019ui_story then
				arg_251_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_254_2 = arg_251_1.actors_["1029ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.characterEffect1029ui_story == nil then
				arg_251_1.var_.characterEffect1029ui_story = var_254_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_3 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.characterEffect1029ui_story and not isNil(var_254_2) then
					arg_251_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.characterEffect1029ui_story then
				arg_251_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_254_5 = 0
			local var_254_6 = 0.4

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(116021058)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 16 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 16)

				if (16 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 16)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021058", "story_v_out_116021.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021058", "story_v_out_116021.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_116021", "116021058", "story_v_out_116021.awb")

						arg_251_1:RecordAudio("116021058", var_254_12)
						arg_251_1:RecordAudio("116021058", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_116021", "116021058", "story_v_out_116021.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_116021", "116021058", "story_v_out_116021.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_13 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_13 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_5) / var_254_13

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_5 + var_254_13 and arg_251_1.time_ < var_254_5 + var_254_13 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play116021059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 116021059
		arg_255_1.duration_ = 6.37

		local var_255_0 = {
			zh = 4.566,
			ja = 6.366
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
				arg_255_0:Play116021060(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_258_0 = arg_255_1.actors_["1019ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1019ui_story == nil then
				arg_255_1.var_.characterEffect1019ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_1 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 and not isNil(var_258_0) then
				if arg_255_1.var_.characterEffect1019ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1019ui_story then
				arg_255_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_258_3 = arg_255_1.actors_["1029ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect1029ui_story == nil then
				arg_255_1.var_.characterEffect1029ui_story = var_258_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_4 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 and not isNil(var_258_3) then
				if arg_255_1.var_.characterEffect1029ui_story and not isNil(var_258_3) then
					arg_255_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_4)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect1029ui_story then
				arg_255_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_258_5 = 0
			local var_258_6 = 0.475

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(116021059)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 19 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 19)

				if (19 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 19)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021059", "story_v_out_116021.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021059", "story_v_out_116021.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_116021", "116021059", "story_v_out_116021.awb")

						arg_255_1:RecordAudio("116021059", var_258_12)
						arg_255_1:RecordAudio("116021059", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_116021", "116021059", "story_v_out_116021.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_116021", "116021059", "story_v_out_116021.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play116021060 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116021060
		arg_259_1.duration_ = 17.3

		local var_259_0 = {
			zh = 17.3,
			ja = 12.433
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
				arg_259_0:Play116021061(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action462")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_262_0 = arg_259_1.actors_["1019ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1019ui_story == nil then
				arg_259_1.var_.characterEffect1019ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_1 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 and not isNil(var_262_0) then
				if arg_259_1.var_.characterEffect1019ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_1)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1019ui_story then
				arg_259_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_262_2 = arg_259_1.actors_["1029ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1029ui_story == nil then
				arg_259_1.var_.characterEffect1029ui_story = var_262_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_3 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.characterEffect1029ui_story and not isNil(var_262_2) then
					arg_259_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1029ui_story then
				arg_259_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_262_5 = 0
			local var_262_6 = 2.075

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(116021060)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 83 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 83)

				if (83 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 83)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021060", "story_v_out_116021.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021060", "story_v_out_116021.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_116021", "116021060", "story_v_out_116021.awb")

						arg_259_1:RecordAudio("116021060", var_262_12)
						arg_259_1:RecordAudio("116021060", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_116021", "116021060", "story_v_out_116021.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_116021", "116021060", "story_v_out_116021.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_13 and arg_259_1.time_ < var_262_5 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play116021061 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116021061
		arg_263_1.duration_ = 2.4

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play116021062(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_266_0 = arg_263_1.actors_["1019ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1019ui_story == nil then
				arg_263_1.var_.characterEffect1019ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_1 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 and not isNil(var_266_0) then
				if arg_263_1.var_.characterEffect1019ui_story and not isNil(var_266_0) then
					arg_263_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1019ui_story then
				arg_263_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_266_3 = arg_263_1.actors_["1029ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_3) and arg_263_1.var_.characterEffect1029ui_story == nil then
				arg_263_1.var_.characterEffect1029ui_story = var_266_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_4 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 and not isNil(var_266_3) then
				if arg_263_1.var_.characterEffect1029ui_story and not isNil(var_266_3) then
					arg_263_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_4)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 and not isNil(var_266_3) and arg_263_1.var_.characterEffect1029ui_story then
				arg_263_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_266_5 = 0
			local var_266_6 = 0.05

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(116021061)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 2 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 2)

				if (2 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 2)) > 0 and var_266_6 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021061", "story_v_out_116021.awb") ~= 0 then
					local var_266_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021061", "story_v_out_116021.awb") / 1000

					if var_266_11 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_5
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_116021", "116021061", "story_v_out_116021.awb")

						arg_263_1:RecordAudio("116021061", var_266_12)
						arg_263_1:RecordAudio("116021061", var_266_12)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_116021", "116021061", "story_v_out_116021.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_116021", "116021061", "story_v_out_116021.awb")
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

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play116021062 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116021062
		arg_267_1.duration_ = 12.63

		local var_267_0 = {
			zh = 9.966,
			ja = 12.633
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
				arg_267_0:Play116021063(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_270_0 = arg_267_1.actors_["1019ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1019ui_story == nil then
				arg_267_1.var_.characterEffect1019ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_1 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 and not isNil(var_270_0) then
				if arg_267_1.var_.characterEffect1019ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_1)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1019ui_story then
				arg_267_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_270_2 = arg_267_1.actors_["1029ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1029ui_story == nil then
				arg_267_1.var_.characterEffect1029ui_story = var_270_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_3 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.characterEffect1029ui_story and not isNil(var_270_2) then
					arg_267_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1029ui_story then
				arg_267_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_270_5 = 0
			local var_270_6 = 1.025

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(116021062)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 42 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 42)

				if (42 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 42)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021062", "story_v_out_116021.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021062", "story_v_out_116021.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_116021", "116021062", "story_v_out_116021.awb")

						arg_267_1:RecordAudio("116021062", var_270_12)
						arg_267_1:RecordAudio("116021062", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_116021", "116021062", "story_v_out_116021.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_116021", "116021062", "story_v_out_116021.awb")
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

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play116021063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116021063
		arg_271_1.duration_ = 3.97

		local var_271_0 = {
			zh = 3.666,
			ja = 3.966
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
				arg_271_0:Play116021064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_274_0 = arg_271_1.actors_["1019ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1019ui_story == nil then
				arg_271_1.var_.characterEffect1019ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_1 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 and not isNil(var_274_0) then
				if arg_271_1.var_.characterEffect1019ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1019ui_story then
				arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_274_3 = arg_271_1.actors_["1029ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect1029ui_story == nil then
				arg_271_1.var_.characterEffect1029ui_story = var_274_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_4 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 and not isNil(var_274_3) then
				if arg_271_1.var_.characterEffect1029ui_story and not isNil(var_274_3) then
					arg_271_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_4)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect1029ui_story then
				arg_271_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_274_5 = 0
			local var_274_6 = 0.25

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
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

				local var_274_7 = arg_271_1:GetWordFromCfg(116021063)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 10 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 10)

				if (10 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 10)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021063", "story_v_out_116021.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021063", "story_v_out_116021.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_116021", "116021063", "story_v_out_116021.awb")

						arg_271_1:RecordAudio("116021063", var_274_12)
						arg_271_1:RecordAudio("116021063", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116021", "116021063", "story_v_out_116021.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116021", "116021063", "story_v_out_116021.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play116021064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116021064
		arg_275_1.duration_ = 10

		local var_275_0 = {
			zh = 10,
			ja = 7.533
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
				arg_275_0:Play116021065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_278_0 = arg_275_1.actors_["1019ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1019ui_story == nil then
				arg_275_1.var_.characterEffect1019ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_1 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 and not isNil(var_278_0) then
				if arg_275_1.var_.characterEffect1019ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_1)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1019ui_story then
				arg_275_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_278_2 = arg_275_1.actors_["1029ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1029ui_story == nil then
				arg_275_1.var_.characterEffect1029ui_story = var_278_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_3 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.characterEffect1029ui_story and not isNil(var_278_2) then
					arg_275_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1029ui_story then
				arg_275_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_278_5 = 0
			local var_278_6 = 1.125

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_7 = arg_275_1:GetWordFromCfg(116021064)
				local var_278_8 = arg_275_1:FormatText(var_278_7.content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 45 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 45)

				if (45 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 45)) > 0 and var_278_6 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_5
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021064", "story_v_out_116021.awb") ~= 0 then
					local var_278_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021064", "story_v_out_116021.awb") / 1000

					if var_278_11 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_5
					end

					if var_278_7.prefab_name ~= "" and arg_275_1.actors_[var_278_7.prefab_name] ~= nil then
						local var_278_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_7.prefab_name].transform, "story_v_out_116021", "116021064", "story_v_out_116021.awb")

						arg_275_1:RecordAudio("116021064", var_278_12)
						arg_275_1:RecordAudio("116021064", var_278_12)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_116021", "116021064", "story_v_out_116021.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_116021", "116021064", "story_v_out_116021.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_6, arg_275_1.talkMaxDuration)

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_5) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_5 + var_278_13 and arg_275_1.time_ < var_278_5 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play116021065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116021065
		arg_279_1.duration_ = 4.73

		local var_279_0 = {
			zh = 4.166,
			ja = 4.733
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
				arg_279_0:Play116021066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_282_0 = arg_279_1.actors_["1019ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1019ui_story == nil then
				arg_279_1.var_.characterEffect1019ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_1 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 and not isNil(var_282_0) then
				if arg_279_1.var_.characterEffect1019ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1019ui_story then
				arg_279_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_282_3 = arg_279_1.actors_["1029ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect1029ui_story == nil then
				arg_279_1.var_.characterEffect1029ui_story = var_282_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_4 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 and not isNil(var_282_3) then
				if arg_279_1.var_.characterEffect1029ui_story and not isNil(var_282_3) then
					arg_279_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_4)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect1029ui_story then
				arg_279_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_282_5 = 0
			local var_282_6 = 0.55

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(116021065)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 22 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 22)

				if (22 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 22)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021065", "story_v_out_116021.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021065", "story_v_out_116021.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_116021", "116021065", "story_v_out_116021.awb")

						arg_279_1:RecordAudio("116021065", var_282_12)
						arg_279_1:RecordAudio("116021065", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_116021", "116021065", "story_v_out_116021.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_116021", "116021065", "story_v_out_116021.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_13 and arg_279_1.time_ < var_282_5 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play116021066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116021066
		arg_283_1.duration_ = 9.57

		local var_283_0 = {
			zh = 5.8,
			ja = 9.566
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
				arg_283_0:Play116021067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_286_0 = arg_283_1.actors_["1019ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1019ui_story == nil then
				arg_283_1.var_.characterEffect1019ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_1 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 and not isNil(var_286_0) then
				if arg_283_1.var_.characterEffect1019ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_1)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1019ui_story then
				arg_283_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_286_2 = arg_283_1.actors_["1029ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1029ui_story == nil then
				arg_283_1.var_.characterEffect1029ui_story = var_286_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_3 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.characterEffect1029ui_story and not isNil(var_286_2) then
					arg_283_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1029ui_story then
				arg_283_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_286_5 = 0
			local var_286_6 = 0.5

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_7 = arg_283_1:GetWordFromCfg(116021066)
				local var_286_8 = arg_283_1:FormatText(var_286_7.content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 20 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 20)

				if (20 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 20)) > 0 and var_286_6 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_5
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021066", "story_v_out_116021.awb") ~= 0 then
					local var_286_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021066", "story_v_out_116021.awb") / 1000

					if var_286_11 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_5
					end

					if var_286_7.prefab_name ~= "" and arg_283_1.actors_[var_286_7.prefab_name] ~= nil then
						local var_286_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_7.prefab_name].transform, "story_v_out_116021", "116021066", "story_v_out_116021.awb")

						arg_283_1:RecordAudio("116021066", var_286_12)
						arg_283_1:RecordAudio("116021066", var_286_12)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_116021", "116021066", "story_v_out_116021.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_116021", "116021066", "story_v_out_116021.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_6, arg_283_1.talkMaxDuration)

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_5) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_5 + var_286_13 and arg_283_1.time_ < var_286_5 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play116021067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116021067
		arg_287_1.duration_ = 15.23

		local var_287_0 = {
			zh = 15.233,
			ja = 12.266
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
				arg_287_0:Play116021068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_290_0 = arg_287_1.actors_["1019ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1019ui_story == nil then
				arg_287_1.var_.characterEffect1019ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_1 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 and not isNil(var_290_0) then
				if arg_287_1.var_.characterEffect1019ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1019ui_story then
				arg_287_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_290_3 = arg_287_1.actors_["1029ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect1029ui_story == nil then
				arg_287_1.var_.characterEffect1029ui_story = var_290_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_4 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 and not isNil(var_290_3) then
				if arg_287_1.var_.characterEffect1029ui_story and not isNil(var_290_3) then
					arg_287_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_4)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect1029ui_story then
				arg_287_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_290_5 = 0
			local var_290_6 = 1.375

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(116021067)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 54 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 54)

				if (54 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 54)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021067", "story_v_out_116021.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021067", "story_v_out_116021.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_116021", "116021067", "story_v_out_116021.awb")

						arg_287_1:RecordAudio("116021067", var_290_12)
						arg_287_1:RecordAudio("116021067", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_116021", "116021067", "story_v_out_116021.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_116021", "116021067", "story_v_out_116021.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_13 and arg_287_1.time_ < var_290_5 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play116021068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116021068
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play116021069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1019ui_story"]) and arg_291_1.var_.characterEffect1019ui_story == nil then
				arg_291_1.var_.characterEffect1019ui_story = arg_291_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1019ui_story"]) then
				if arg_291_1.var_.characterEffect1019ui_story and not isNil(arg_291_1.actors_["1019ui_story"]) then
					arg_291_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1019ui_story"]) and arg_291_1.var_.characterEffect1019ui_story then
				arg_291_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.9

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(116021068).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 36 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 36)

				if (36 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 36)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play116021069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 116021069
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play116021070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.175

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(116021069).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 7 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 7)

				if (7 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 7)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play116021070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 116021070
		arg_299_1.duration_ = 3.97

		local var_299_0 = {
			zh = 2.166,
			ja = 3.966
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
				arg_299_0:Play116021071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_302_0 = arg_299_1.actors_["1019ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1019ui_story == nil then
				arg_299_1.var_.characterEffect1019ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_1 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 and not isNil(var_302_0) then
				if arg_299_1.var_.characterEffect1019ui_story and not isNil(var_302_0) then
					arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1019ui_story then
				arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_302_3 = 0
			local var_302_4 = 0.225

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_3 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_5 = arg_299_1:GetWordFromCfg(116021070)
				local var_302_6 = arg_299_1:FormatText(var_302_5.content)

				arg_299_1.text_.text = var_302_6

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_8 = 9 <= 0 and var_302_4 or var_302_4 * (utf8.len(var_302_6) / 9)

				if (9 <= 0 and var_302_4 or var_302_4 * (utf8.len(var_302_6) / 9)) > 0 and var_302_4 < var_302_8 then
					arg_299_1.talkMaxDuration = var_302_8

					if var_302_8 + var_302_3 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_3
					end
				end

				arg_299_1.text_.text = var_302_6
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021070", "story_v_out_116021.awb") ~= 0 then
					local var_302_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021070", "story_v_out_116021.awb") / 1000

					if var_302_9 + var_302_3 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_3
					end

					if var_302_5.prefab_name ~= "" and arg_299_1.actors_[var_302_5.prefab_name] ~= nil then
						local var_302_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_5.prefab_name].transform, "story_v_out_116021", "116021070", "story_v_out_116021.awb")

						arg_299_1:RecordAudio("116021070", var_302_10)
						arg_299_1:RecordAudio("116021070", var_302_10)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_116021", "116021070", "story_v_out_116021.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_116021", "116021070", "story_v_out_116021.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_11 = math.max(var_302_4, arg_299_1.talkMaxDuration)

			if var_302_3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_3 + var_302_11 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_3) / var_302_11

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_3 + var_302_11 and arg_299_1.time_ < var_302_3 + var_302_11 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play116021071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 116021071
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play116021072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1019ui_story"]) and arg_303_1.var_.characterEffect1019ui_story == nil then
				arg_303_1.var_.characterEffect1019ui_story = arg_303_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1019ui_story"]) then
				if arg_303_1.var_.characterEffect1019ui_story and not isNil(arg_303_1.actors_["1019ui_story"]) then
					arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1019ui_story"]) and arg_303_1.var_.characterEffect1019ui_story then
				arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.425

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(116021071).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 17 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 17)

				if (17 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 17)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play116021072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 116021072
		arg_307_1.duration_ = 2.73

		local var_307_0 = {
			zh = 2.733,
			ja = 1.999999999999
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play116021073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_0 = arg_307_1.actors_["1029ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1029ui_story == nil then
				arg_307_1.var_.characterEffect1029ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_1 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 and not isNil(var_310_0) then
				if arg_307_1.var_.characterEffect1029ui_story and not isNil(var_310_0) then
					arg_307_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1029ui_story then
				arg_307_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_310_3 = 0
			local var_310_4 = 0.125

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_5 = arg_307_1:GetWordFromCfg(116021072)
				local var_310_6 = arg_307_1:FormatText(var_310_5.content)

				arg_307_1.text_.text = var_310_6

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_8 = 5 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_6) / 5)

				if (5 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_6) / 5)) > 0 and var_310_4 < var_310_8 then
					arg_307_1.talkMaxDuration = var_310_8

					if var_310_8 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_3
					end
				end

				arg_307_1.text_.text = var_310_6
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021072", "story_v_out_116021.awb") ~= 0 then
					local var_310_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021072", "story_v_out_116021.awb") / 1000

					if var_310_9 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_3
					end

					if var_310_5.prefab_name ~= "" and arg_307_1.actors_[var_310_5.prefab_name] ~= nil then
						local var_310_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_5.prefab_name].transform, "story_v_out_116021", "116021072", "story_v_out_116021.awb")

						arg_307_1:RecordAudio("116021072", var_310_10)
						arg_307_1:RecordAudio("116021072", var_310_10)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_116021", "116021072", "story_v_out_116021.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_116021", "116021072", "story_v_out_116021.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_11 = math.max(var_310_4, arg_307_1.talkMaxDuration)

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_11 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_3) / var_310_11

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_3 + var_310_11 and arg_307_1.time_ < var_310_3 + var_310_11 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play116021073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 116021073
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play116021074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1029ui_story"]) and arg_311_1.var_.characterEffect1029ui_story == nil then
				arg_311_1.var_.characterEffect1029ui_story = arg_311_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1029ui_story"]) then
				if arg_311_1.var_.characterEffect1029ui_story and not isNil(arg_311_1.actors_["1029ui_story"]) then
					arg_311_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1029ui_story"]) and arg_311_1.var_.characterEffect1029ui_story then
				arg_311_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.325

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(116021073).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 13 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 13)

				if (13 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 13)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play116021074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 116021074
		arg_315_1.duration_ = 4.2

		local var_315_0 = {
			zh = 3.966,
			ja = 4.2
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play116021075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_318_0 = arg_315_1.actors_["1019ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1019ui_story == nil then
				arg_315_1.var_.characterEffect1019ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_1 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 and not isNil(var_318_0) then
				if arg_315_1.var_.characterEffect1019ui_story and not isNil(var_318_0) then
					arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1019ui_story then
				arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_318_3 = 0
			local var_318_4 = 0.55

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_5 = arg_315_1:GetWordFromCfg(116021074)
				local var_318_6 = arg_315_1:FormatText(var_318_5.content)

				arg_315_1.text_.text = var_318_6

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_8 = 30 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_6) / 30)

				if (30 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_6) / 30)) > 0 and var_318_4 < var_318_8 then
					arg_315_1.talkMaxDuration = var_318_8

					if var_318_8 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_3
					end
				end

				arg_315_1.text_.text = var_318_6
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021074", "story_v_out_116021.awb") ~= 0 then
					local var_318_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021074", "story_v_out_116021.awb") / 1000

					if var_318_9 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_3
					end

					if var_318_5.prefab_name ~= "" and arg_315_1.actors_[var_318_5.prefab_name] ~= nil then
						local var_318_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_5.prefab_name].transform, "story_v_out_116021", "116021074", "story_v_out_116021.awb")

						arg_315_1:RecordAudio("116021074", var_318_10)
						arg_315_1:RecordAudio("116021074", var_318_10)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_116021", "116021074", "story_v_out_116021.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_116021", "116021074", "story_v_out_116021.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_11 = math.max(var_318_4, arg_315_1.talkMaxDuration)

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_11 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_3) / var_318_11

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_3 + var_318_11 and arg_315_1.time_ < var_318_3 + var_318_11 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play116021075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 116021075
		arg_319_1.duration_ = 4.3

		local var_319_0 = {
			zh = 4.3,
			ja = 4.266
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play116021076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_0 = arg_319_1.actors_["1029ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1029ui_story == nil then
				arg_319_1.var_.characterEffect1029ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_1 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 and not isNil(var_322_0) then
				if arg_319_1.var_.characterEffect1029ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1029ui_story then
				arg_319_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_322_3 = arg_319_1.actors_["1019ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_3) and arg_319_1.var_.characterEffect1019ui_story == nil then
				arg_319_1.var_.characterEffect1019ui_story = var_322_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_4 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 and not isNil(var_322_3) then
				if arg_319_1.var_.characterEffect1019ui_story and not isNil(var_322_3) then
					arg_319_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_4)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 and not isNil(var_322_3) and arg_319_1.var_.characterEffect1019ui_story then
				arg_319_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_322_5 = 0
			local var_322_6 = 0.225

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_7 = arg_319_1:GetWordFromCfg(116021075)
				local var_322_8 = arg_319_1:FormatText(var_322_7.content)

				arg_319_1.text_.text = var_322_8

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_10 = 9 <= 0 and var_322_6 or var_322_6 * (utf8.len(var_322_8) / 9)

				if (9 <= 0 and var_322_6 or var_322_6 * (utf8.len(var_322_8) / 9)) > 0 and var_322_6 < var_322_10 then
					arg_319_1.talkMaxDuration = var_322_10

					if var_322_10 + var_322_5 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_5
					end
				end

				arg_319_1.text_.text = var_322_8
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021075", "story_v_out_116021.awb") ~= 0 then
					local var_322_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021075", "story_v_out_116021.awb") / 1000

					if var_322_11 + var_322_5 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_11 + var_322_5
					end

					if var_322_7.prefab_name ~= "" and arg_319_1.actors_[var_322_7.prefab_name] ~= nil then
						local var_322_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_7.prefab_name].transform, "story_v_out_116021", "116021075", "story_v_out_116021.awb")

						arg_319_1:RecordAudio("116021075", var_322_12)
						arg_319_1:RecordAudio("116021075", var_322_12)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_116021", "116021075", "story_v_out_116021.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_116021", "116021075", "story_v_out_116021.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_13 = math.max(var_322_6, arg_319_1.talkMaxDuration)

			if var_322_5 <= arg_319_1.time_ and arg_319_1.time_ < var_322_5 + var_322_13 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_5) / var_322_13

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_5 + var_322_13 and arg_319_1.time_ < var_322_5 + var_322_13 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play116021076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 116021076
		arg_323_1.duration_ = 9.13

		local var_323_0 = {
			zh = 9.133,
			ja = 6.166
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play116021077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if arg_323_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_326_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_323_1.stage_.transform)

				var_326_0.name = "1028ui_story"
				var_326_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_["1028ui_story"] = var_326_0

				local var_326_1 = var_326_0:GetComponentInChildren(typeof(CharacterEffect))

				var_326_1.enabled = true

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end

				arg_323_1:ShowWeapon(var_326_1.transform, false)

				arg_323_1.var_["1028ui_story" .. "Animator"] = var_326_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_323_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_323_1.var_["1028ui_story" .. "LipSync"] = var_326_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_326_3 = arg_323_1.actors_["1028ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1028ui_story = var_326_3.localPosition
			end

			local var_326_4 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_3.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1028ui_story, Vector3.New(-0.7, -0.9, -5.9), (arg_323_1.time_ - 0) / var_326_4)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_3.localPosition = Vector3.New(-0.7, -0.9, -5.9)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			local var_326_5 = arg_323_1.actors_["1019ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1019ui_story = var_326_5.localPosition
			end

			local var_326_6 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 then
				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_6)
				var_326_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_5.position).x, (manager.ui.mainCamera.transform.position - var_326_5.position).y, (manager.ui.mainCamera.transform.position - var_326_5.position).z)
				var_326_5.localEulerAngles.z = 0
				var_326_5.localEulerAngles.x = 0
				var_326_5.localEulerAngles = var_326_5.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(0, 100, 0)
				var_326_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_5.position).x, (manager.ui.mainCamera.transform.position - var_326_5.position).y, (manager.ui.mainCamera.transform.position - var_326_5.position).z)
				var_326_5.localEulerAngles.z = 0
				var_326_5.localEulerAngles.x = 0
				var_326_5.localEulerAngles = var_326_5.localEulerAngles
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_326_7 = arg_323_1.actors_["1028ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.characterEffect1028ui_story == nil then
				arg_323_1.var_.characterEffect1028ui_story = var_326_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_8 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_8 and not isNil(var_326_7) then
				if arg_323_1.var_.characterEffect1028ui_story and not isNil(var_326_7) then
					arg_323_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_8 and arg_323_1.time_ < 0 + var_326_8 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.characterEffect1028ui_story then
				arg_323_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_326_10 = arg_323_1.actors_["1029ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_10) and arg_323_1.var_.characterEffect1029ui_story == nil then
				arg_323_1.var_.characterEffect1029ui_story = var_326_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_11 and not isNil(var_326_10) then
				if arg_323_1.var_.characterEffect1029ui_story and not isNil(var_326_10) then
					arg_323_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_11)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_11 and arg_323_1.time_ < 0 + var_326_11 + arg_326_0 and not isNil(var_326_10) and arg_323_1.var_.characterEffect1029ui_story then
				arg_323_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_326_12 = 0
			local var_326_13 = 1.2

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_14 = arg_323_1:GetWordFromCfg(116021076)
				local var_326_15 = arg_323_1:FormatText(var_326_14.content)

				arg_323_1.text_.text = var_326_15

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_17 = 48 <= 0 and var_326_13 or var_326_13 * (utf8.len(var_326_15) / 48)

				if (48 <= 0 and var_326_13 or var_326_13 * (utf8.len(var_326_15) / 48)) > 0 and var_326_13 < var_326_17 then
					arg_323_1.talkMaxDuration = var_326_17

					if var_326_17 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_17 + var_326_12
					end
				end

				arg_323_1.text_.text = var_326_15
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021076", "story_v_out_116021.awb") ~= 0 then
					local var_326_18 = manager.audio:GetVoiceLength("story_v_out_116021", "116021076", "story_v_out_116021.awb") / 1000

					if var_326_18 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_18 + var_326_12
					end

					if var_326_14.prefab_name ~= "" and arg_323_1.actors_[var_326_14.prefab_name] ~= nil then
						local var_326_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_14.prefab_name].transform, "story_v_out_116021", "116021076", "story_v_out_116021.awb")

						arg_323_1:RecordAudio("116021076", var_326_19)
						arg_323_1:RecordAudio("116021076", var_326_19)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_116021", "116021076", "story_v_out_116021.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_116021", "116021076", "story_v_out_116021.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_20 = math.max(var_326_13, arg_323_1.talkMaxDuration)

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_20 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_12) / var_326_20

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_12 + var_326_20 and arg_323_1.time_ < var_326_12 + var_326_20 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play116021077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 116021077
		arg_327_1.duration_ = 5.3

		local var_327_0 = {
			zh = 3.466,
			ja = 5.3
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play116021078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_0 = arg_327_1.actors_["1029ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1029ui_story == nil then
				arg_327_1.var_.characterEffect1029ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_1 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 and not isNil(var_330_0) then
				if arg_327_1.var_.characterEffect1029ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1029ui_story then
				arg_327_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_330_3 = arg_327_1.actors_["1028ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_3) and arg_327_1.var_.characterEffect1028ui_story == nil then
				arg_327_1.var_.characterEffect1028ui_story = var_330_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_4 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 and not isNil(var_330_3) then
				if arg_327_1.var_.characterEffect1028ui_story and not isNil(var_330_3) then
					arg_327_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_4)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 and not isNil(var_330_3) and arg_327_1.var_.characterEffect1028ui_story then
				arg_327_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_330_5 = 0
			local var_330_6 = 0.3

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_7 = arg_327_1:GetWordFromCfg(116021077)
				local var_330_8 = arg_327_1:FormatText(var_330_7.content)

				arg_327_1.text_.text = var_330_8

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_10 = 12 <= 0 and var_330_6 or var_330_6 * (utf8.len(var_330_8) / 12)

				if (12 <= 0 and var_330_6 or var_330_6 * (utf8.len(var_330_8) / 12)) > 0 and var_330_6 < var_330_10 then
					arg_327_1.talkMaxDuration = var_330_10

					if var_330_10 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_5
					end
				end

				arg_327_1.text_.text = var_330_8
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021077", "story_v_out_116021.awb") ~= 0 then
					local var_330_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021077", "story_v_out_116021.awb") / 1000

					if var_330_11 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_5
					end

					if var_330_7.prefab_name ~= "" and arg_327_1.actors_[var_330_7.prefab_name] ~= nil then
						local var_330_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_7.prefab_name].transform, "story_v_out_116021", "116021077", "story_v_out_116021.awb")

						arg_327_1:RecordAudio("116021077", var_330_12)
						arg_327_1:RecordAudio("116021077", var_330_12)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_116021", "116021077", "story_v_out_116021.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_116021", "116021077", "story_v_out_116021.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_13 = math.max(var_330_6, arg_327_1.talkMaxDuration)

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_13 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_5) / var_330_13

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_5 + var_330_13 and arg_327_1.time_ < var_330_5 + var_330_13 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play116021078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 116021078
		arg_331_1.duration_ = 5.27

		local var_331_0 = {
			zh = 5.266,
			ja = 3.633
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
				arg_331_0:Play116021079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1029ui_story"]) and arg_331_1.var_.characterEffect1029ui_story == nil then
				arg_331_1.var_.characterEffect1029ui_story = arg_331_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1029ui_story"]) then
				if arg_331_1.var_.characterEffect1029ui_story and not isNil(arg_331_1.actors_["1029ui_story"]) then
					arg_331_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1029ui_story"]) and arg_331_1.var_.characterEffect1029ui_story then
				arg_331_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.6

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(116021078)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_6 = 24 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_4) / 24)

				if (24 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_4) / 24)) > 0 and var_334_2 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021078", "story_v_out_116021.awb") ~= 0 then
					local var_334_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021078", "story_v_out_116021.awb") / 1000

					if var_334_7 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_1
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_out_116021", "116021078", "story_v_out_116021.awb")

						arg_331_1:RecordAudio("116021078", var_334_8)
						arg_331_1:RecordAudio("116021078", var_334_8)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_116021", "116021078", "story_v_out_116021.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_116021", "116021078", "story_v_out_116021.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_9 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_9 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_9

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_9 and arg_331_1.time_ < var_334_1 + var_334_9 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play116021079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 116021079
		arg_335_1.duration_ = 12

		local var_335_0 = {
			zh = 10,
			ja = 12
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
				arg_335_0:Play116021080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1.1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:GetWordFromCfg(116021079)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 44 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 44)

				if (44 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 44)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021079", "story_v_out_116021.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021079", "story_v_out_116021.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_116021", "116021079", "story_v_out_116021.awb")

						arg_335_1:RecordAudio("116021079", var_338_6)
						arg_335_1:RecordAudio("116021079", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_116021", "116021079", "story_v_out_116021.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_116021", "116021079", "story_v_out_116021.awb")
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
	Play116021080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 116021080
		arg_339_1.duration_ = 6.03

		local var_339_0 = {
			zh = 5.133,
			ja = 6.033
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
				arg_339_0:Play116021081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1028ui_story"]) and arg_339_1.var_.characterEffect1028ui_story == nil then
				arg_339_1.var_.characterEffect1028ui_story = arg_339_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1028ui_story"]) then
				if arg_339_1.var_.characterEffect1028ui_story and not isNil(arg_339_1.actors_["1028ui_story"]) then
					arg_339_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1028ui_story"]) and arg_339_1.var_.characterEffect1028ui_story then
				arg_339_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_2 = 0
			local var_342_3 = 0.6

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_4 = arg_339_1:GetWordFromCfg(116021080)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 24 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 24)

				if (24 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 24)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021080", "story_v_out_116021.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021080", "story_v_out_116021.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_out_116021", "116021080", "story_v_out_116021.awb")

						arg_339_1:RecordAudio("116021080", var_342_9)
						arg_339_1:RecordAudio("116021080", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_116021", "116021080", "story_v_out_116021.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_116021", "116021080", "story_v_out_116021.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play116021081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 116021081
		arg_343_1.duration_ = 4.83

		local var_343_0 = {
			zh = 1.566,
			ja = 4.833
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play116021082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1028ui_story"]) and arg_343_1.var_.characterEffect1028ui_story == nil then
				arg_343_1.var_.characterEffect1028ui_story = arg_343_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1028ui_story"]) then
				if arg_343_1.var_.characterEffect1028ui_story and not isNil(arg_343_1.actors_["1028ui_story"]) then
					arg_343_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1028ui_story"]) and arg_343_1.var_.characterEffect1028ui_story then
				arg_343_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.15

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(116021081)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 6 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 6)

				if (6 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 6)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021081", "story_v_out_116021.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021081", "story_v_out_116021.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_116021", "116021081", "story_v_out_116021.awb")

						arg_343_1:RecordAudio("116021081", var_346_8)
						arg_343_1:RecordAudio("116021081", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_116021", "116021081", "story_v_out_116021.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_116021", "116021081", "story_v_out_116021.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play116021082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 116021082
		arg_347_1.duration_ = 5.23

		local var_347_0 = {
			zh = 4.4,
			ja = 5.233
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play116021083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_350_0 = arg_347_1.actors_["1029ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1029ui_story == nil then
				arg_347_1.var_.characterEffect1029ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_1 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 and not isNil(var_350_0) then
				if arg_347_1.var_.characterEffect1029ui_story and not isNil(var_350_0) then
					arg_347_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1029ui_story then
				arg_347_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_350_3 = arg_347_1.actors_["1028ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_3) and arg_347_1.var_.characterEffect1028ui_story == nil then
				arg_347_1.var_.characterEffect1028ui_story = var_350_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_4 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 and not isNil(var_350_3) then
				if arg_347_1.var_.characterEffect1028ui_story and not isNil(var_350_3) then
					arg_347_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_4)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 and not isNil(var_350_3) and arg_347_1.var_.characterEffect1028ui_story then
				arg_347_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_350_5 = 0
			local var_350_6 = 0.425

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(116021082)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 17 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 17)

				if (17 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 17)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021082", "story_v_out_116021.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021082", "story_v_out_116021.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_116021", "116021082", "story_v_out_116021.awb")

						arg_347_1:RecordAudio("116021082", var_350_12)
						arg_347_1:RecordAudio("116021082", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_116021", "116021082", "story_v_out_116021.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_116021", "116021082", "story_v_out_116021.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play116021083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 116021083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play116021084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1029ui_story"]) and arg_351_1.var_.characterEffect1029ui_story == nil then
				arg_351_1.var_.characterEffect1029ui_story = arg_351_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1029ui_story"]) then
				if arg_351_1.var_.characterEffect1029ui_story and not isNil(arg_351_1.actors_["1029ui_story"]) then
					arg_351_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1029ui_story"]) and arg_351_1.var_.characterEffect1029ui_story then
				arg_351_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_354_1 = arg_351_1.actors_["1029ui_story"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1029ui_story = var_354_1.localPosition
			end

			local var_354_2 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 then
				var_354_1.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_2)
				var_354_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_1.position).x, (manager.ui.mainCamera.transform.position - var_354_1.position).y, (manager.ui.mainCamera.transform.position - var_354_1.position).z)
				var_354_1.localEulerAngles.z = 0
				var_354_1.localEulerAngles.x = 0
				var_354_1.localEulerAngles = var_354_1.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 then
				var_354_1.localPosition = Vector3.New(0, 100, 0)
				var_354_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_1.position).x, (manager.ui.mainCamera.transform.position - var_354_1.position).y, (manager.ui.mainCamera.transform.position - var_354_1.position).z)
				var_354_1.localEulerAngles.z = 0
				var_354_1.localEulerAngles.x = 0
				var_354_1.localEulerAngles = var_354_1.localEulerAngles
			end

			local var_354_3 = arg_351_1.actors_["1028ui_story"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1028ui_story = var_354_3.localPosition
			end

			local var_354_4 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				var_354_3.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_4)
				var_354_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_3.position).x, (manager.ui.mainCamera.transform.position - var_354_3.position).y, (manager.ui.mainCamera.transform.position - var_354_3.position).z)
				var_354_3.localEulerAngles.z = 0
				var_354_3.localEulerAngles.x = 0
				var_354_3.localEulerAngles = var_354_3.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				var_354_3.localPosition = Vector3.New(0, 100, 0)
				var_354_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_3.position).x, (manager.ui.mainCamera.transform.position - var_354_3.position).y, (manager.ui.mainCamera.transform.position - var_354_3.position).z)
				var_354_3.localEulerAngles.z = 0
				var_354_3.localEulerAngles.x = 0
				var_354_3.localEulerAngles = var_354_3.localEulerAngles
			end

			local var_354_5 = 0
			local var_354_6 = 1.1

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(116021083).content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 44 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_7) / 44)

				if (44 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_7) / 44)) > 0 and var_354_6 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_10 and arg_351_1.time_ < var_354_5 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play116021084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 116021084
		arg_355_1.duration_ = 9.07

		local var_355_0 = {
			zh = 9.066,
			ja = 5.233
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play116021085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_358_0 = arg_355_1.actors_["1029ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1029ui_story == nil then
				arg_355_1.var_.characterEffect1029ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_1 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 and not isNil(var_358_0) then
				if arg_355_1.var_.characterEffect1029ui_story and not isNil(var_358_0) then
					arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1029ui_story then
				arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_358_3 = arg_355_1.actors_["1029ui_story"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1029ui_story = var_358_3.localPosition
			end

			local var_358_4 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				var_358_3.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_355_1.time_ - 0) / var_358_4)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				var_358_3.localPosition = Vector3.New(0, -1.09, -6.2)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			local var_358_5 = 0
			local var_358_6 = 0.775

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_7 = arg_355_1:GetWordFromCfg(116021084)
				local var_358_8 = arg_355_1:FormatText(var_358_7.content)

				arg_355_1.text_.text = var_358_8

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_10 = 31 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 31)

				if (31 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 31)) > 0 and var_358_6 < var_358_10 then
					arg_355_1.talkMaxDuration = var_358_10

					if var_358_10 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_5
					end
				end

				arg_355_1.text_.text = var_358_8
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021084", "story_v_out_116021.awb") ~= 0 then
					local var_358_11 = manager.audio:GetVoiceLength("story_v_out_116021", "116021084", "story_v_out_116021.awb") / 1000

					if var_358_11 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_5
					end

					if var_358_7.prefab_name ~= "" and arg_355_1.actors_[var_358_7.prefab_name] ~= nil then
						local var_358_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_7.prefab_name].transform, "story_v_out_116021", "116021084", "story_v_out_116021.awb")

						arg_355_1:RecordAudio("116021084", var_358_12)
						arg_355_1:RecordAudio("116021084", var_358_12)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_116021", "116021084", "story_v_out_116021.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_116021", "116021084", "story_v_out_116021.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_13 = math.max(var_358_6, arg_355_1.talkMaxDuration)

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_13 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_5) / var_358_13

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_5 + var_358_13 and arg_355_1.time_ < var_358_5 + var_358_13 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play116021085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 116021085
		arg_359_1.duration_ = 0.02

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"

			SetActive(arg_359_1.choicesGo_, true)

			for iter_360_0, iter_360_1 in ipairs(arg_359_1.choices_) do
				SetActive(iter_360_1.go, iter_360_0 <= 2)
			end

			arg_359_1.choices_[1].txt.text = arg_359_1:FormatText(StoryChoiceCfg[231].name)
			arg_359_1.choices_[2].txt.text = arg_359_1:FormatText(StoryChoiceCfg[232].name)
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play116021086(arg_359_1)
			end

			if arg_361_0 == 2 then
				arg_359_0:Play116021086(arg_359_1)
			end

			arg_359_1:RecordChoiceLog(116021085, 231, 232)
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			return
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play116021086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 116021086
		arg_363_1.duration_ = 5.93

		local var_363_0 = {
			zh = 5.933,
			ja = 1.999999999999
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play116021087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if arg_363_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_366_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_363_1.stage_.transform)

				var_366_0.name = "1029ui_story"
				var_366_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.actors_["1029ui_story"] = var_366_0

				local var_366_1 = var_366_0:GetComponentInChildren(typeof(CharacterEffect))

				var_366_1.enabled = true

				local var_366_2 = GameObjectTools.GetOrAddComponent(var_366_0, typeof(DynamicBoneHelper))

				if var_366_2 then
					var_366_2:EnableDynamicBone(false)
				end

				arg_363_1:ShowWeapon(var_366_1.transform, false)

				arg_363_1.var_["1029ui_story" .. "Animator"] = var_366_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_363_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_363_1.var_["1029ui_story" .. "LipSync"] = var_366_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			local var_366_3 = "1029ui_story"

			if arg_363_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_366_4 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_363_1.stage_.transform)

				var_366_4.name = var_366_3
				var_366_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.actors_[var_366_3] = var_366_4

				local var_366_5 = var_366_4:GetComponentInChildren(typeof(CharacterEffect))

				var_366_5.enabled = true

				local var_366_6 = GameObjectTools.GetOrAddComponent(var_366_4, typeof(DynamicBoneHelper))

				if var_366_6 then
					var_366_6:EnableDynamicBone(false)
				end

				arg_363_1:ShowWeapon(var_366_5.transform, false)

				arg_363_1.var_[var_366_3 .. "Animator"] = var_366_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_363_1.var_[var_366_3 .. "Animator"].applyRootMotion = true
				arg_363_1.var_[var_366_3 .. "LipSync"] = var_366_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_366_7 = 0
			local var_366_8 = 0.475

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_7 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_9 = arg_363_1:GetWordFromCfg(116021086)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_12 = 19 <= 0 and var_366_8 or var_366_8 * (utf8.len(var_366_10) / 19)

				if (19 <= 0 and var_366_8 or var_366_8 * (utf8.len(var_366_10) / 19)) > 0 and var_366_8 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_7 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_7
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021086", "story_v_out_116021.awb") ~= 0 then
					local var_366_13 = manager.audio:GetVoiceLength("story_v_out_116021", "116021086", "story_v_out_116021.awb") / 1000

					if var_366_13 + var_366_7 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_7
					end

					if var_366_9.prefab_name ~= "" and arg_363_1.actors_[var_366_9.prefab_name] ~= nil then
						local var_366_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_9.prefab_name].transform, "story_v_out_116021", "116021086", "story_v_out_116021.awb")

						arg_363_1:RecordAudio("116021086", var_366_14)
						arg_363_1:RecordAudio("116021086", var_366_14)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_116021", "116021086", "story_v_out_116021.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_116021", "116021086", "story_v_out_116021.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_15 = math.max(var_366_8, arg_363_1.talkMaxDuration)

			if var_366_7 <= arg_363_1.time_ and arg_363_1.time_ < var_366_7 + var_366_15 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_7) / var_366_15

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_7 + var_366_15 and arg_363_1.time_ < var_366_7 + var_366_15 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play116021087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 116021087
		arg_367_1.duration_ = 3.27

		local var_367_0 = {
			zh = 3.266,
			ja = 2.9
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play116021088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1029ui_story"]) and arg_367_1.var_.characterEffect1029ui_story == nil then
				arg_367_1.var_.characterEffect1029ui_story = arg_367_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1029ui_story"]) then
				if arg_367_1.var_.characterEffect1029ui_story and not isNil(arg_367_1.actors_["1029ui_story"]) then
					arg_367_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1029ui_story"]) and arg_367_1.var_.characterEffect1029ui_story then
				arg_367_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.375

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(116021087)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_6 = 15 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 15)

				if (15 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 15)) > 0 and var_370_2 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021087", "story_v_out_116021.awb") ~= 0 then
					local var_370_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021087", "story_v_out_116021.awb") / 1000

					if var_370_7 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_1
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_out_116021", "116021087", "story_v_out_116021.awb")

						arg_367_1:RecordAudio("116021087", var_370_8)
						arg_367_1:RecordAudio("116021087", var_370_8)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_116021", "116021087", "story_v_out_116021.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_116021", "116021087", "story_v_out_116021.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_9 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_9 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_9

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_9 and arg_367_1.time_ < var_370_1 + var_370_9 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play116021088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 116021088
		arg_371_1.duration_ = 10.5

		local var_371_0 = {
			zh = 9.933,
			ja = 10.5
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play116021089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_374_0 = arg_371_1.actors_["1029ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1029ui_story == nil then
				arg_371_1.var_.characterEffect1029ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_1 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_1 and not isNil(var_374_0) then
				if arg_371_1.var_.characterEffect1029ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_1 and arg_371_1.time_ < 0 + var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1029ui_story then
				arg_371_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_374_3 = 0
			local var_374_4 = 1.1

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_5 = arg_371_1:GetWordFromCfg(116021088)
				local var_374_6 = arg_371_1:FormatText(var_374_5.content)

				arg_371_1.text_.text = var_374_6

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_8 = 44 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_6) / 44)

				if (44 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_6) / 44)) > 0 and var_374_4 < var_374_8 then
					arg_371_1.talkMaxDuration = var_374_8

					if var_374_8 + var_374_3 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_3
					end
				end

				arg_371_1.text_.text = var_374_6
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021088", "story_v_out_116021.awb") ~= 0 then
					local var_374_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021088", "story_v_out_116021.awb") / 1000

					if var_374_9 + var_374_3 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_3
					end

					if var_374_5.prefab_name ~= "" and arg_371_1.actors_[var_374_5.prefab_name] ~= nil then
						local var_374_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_5.prefab_name].transform, "story_v_out_116021", "116021088", "story_v_out_116021.awb")

						arg_371_1:RecordAudio("116021088", var_374_10)
						arg_371_1:RecordAudio("116021088", var_374_10)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_116021", "116021088", "story_v_out_116021.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_116021", "116021088", "story_v_out_116021.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_11 = math.max(var_374_4, arg_371_1.talkMaxDuration)

			if var_374_3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_3 + var_374_11 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_3) / var_374_11

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_3 + var_374_11 and arg_371_1.time_ < var_374_3 + var_374_11 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play116021089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 116021089
		arg_375_1.duration_ = 4.9

		local var_375_0 = {
			zh = 1.999999999999,
			ja = 4.9
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play116021090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_378_0 = 0
			local var_378_1 = 0.15

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_2 = arg_375_1:GetWordFromCfg(116021089)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 6 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 6)

				if (6 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 6)) > 0 and var_378_1 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021089", "story_v_out_116021.awb") ~= 0 then
					local var_378_6 = manager.audio:GetVoiceLength("story_v_out_116021", "116021089", "story_v_out_116021.awb") / 1000

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end

					if var_378_2.prefab_name ~= "" and arg_375_1.actors_[var_378_2.prefab_name] ~= nil then
						local var_378_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_2.prefab_name].transform, "story_v_out_116021", "116021089", "story_v_out_116021.awb")

						arg_375_1:RecordAudio("116021089", var_378_7)
						arg_375_1:RecordAudio("116021089", var_378_7)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_116021", "116021089", "story_v_out_116021.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_116021", "116021089", "story_v_out_116021.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play116021090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 116021090
		arg_379_1.duration_ = 3.9

		local var_379_0 = {
			zh = 3.9,
			ja = 2
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
			arg_379_1.auto_ = false
		end

		function arg_379_1.playNext_(arg_381_0)
			arg_379_1.onStoryFinished_()
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1029ui_story"]) and arg_379_1.var_.characterEffect1029ui_story == nil then
				arg_379_1.var_.characterEffect1029ui_story = arg_379_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1029ui_story"]) then
				if arg_379_1.var_.characterEffect1029ui_story and not isNil(arg_379_1.actors_["1029ui_story"]) then
					arg_379_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1029ui_story"]) and arg_379_1.var_.characterEffect1029ui_story then
				arg_379_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.175

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(116021090)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 7 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 7)

				if (7 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 7)) > 0 and var_382_2 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021090", "story_v_out_116021.awb") ~= 0 then
					local var_382_7 = manager.audio:GetVoiceLength("story_v_out_116021", "116021090", "story_v_out_116021.awb") / 1000

					if var_382_7 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_1
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_116021", "116021090", "story_v_out_116021.awb")

						arg_379_1:RecordAudio("116021090", var_382_8)
						arg_379_1:RecordAudio("116021090", var_382_8)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_116021", "116021090", "story_v_out_116021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_116021", "116021090", "story_v_out_116021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_9 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_9 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_9

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_9 and arg_379_1.time_ < var_382_1 + var_382_9 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play116021044 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 116021044
		arg_383_1.duration_ = 7.83

		local var_383_0 = {
			zh = 7.5,
			ja = 7.833
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play116021045(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.925

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:GetWordFromCfg(116021044)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 37 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 37)

				if (37 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 37)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021044", "story_v_out_116021.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_116021", "116021044", "story_v_out_116021.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_116021", "116021044", "story_v_out_116021.awb")

						arg_383_1:RecordAudio("116021044", var_386_6)
						arg_383_1:RecordAudio("116021044", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_116021", "116021044", "story_v_out_116021.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_116021", "116021044", "story_v_out_116021.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I02",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/SK0104",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/SK0105",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_116021.awb"
	}
}
