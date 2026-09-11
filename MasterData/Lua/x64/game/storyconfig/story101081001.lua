return {
	Play108101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108101001
		arg_1_1.duration_ = 8.13

		local var_1_0 = {
			ja = 4.633,
			ko = 5.8,
			zh = 4.5,
			en = 8.133
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
				arg_1_0:Play108101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0806 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0806")
				var_4_0.name = "S0806"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0806 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.S0806

				arg_1_1.bgs_.S0806.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0806" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.S0806:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueS0806 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueS0806 = var_4_4
				end

				arg_1_1.var_.alphaOldValueS0806 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueS0806 then
					arg_1_1.var_.alphaMatValueS0806.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0806, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueS0806.color = arg_1_1.var_.alphaMatValueS0806.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueS0806 then
				arg_1_1.var_.alphaMatValueS0806.color.a = 1
				arg_1_1.var_.alphaMatValueS0806.color = arg_1_1.var_.alphaMatValueS0806.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			if 0.100000001490116 < arg_1_1.time_ and arg_1_1.time_ <= 0.100000001490116 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_battle_yujing_02", "bgm_battle_yujing_02", "bgm_battle_yujing_02.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_battle_yujing_02", "bgm_battle_yujing_02")

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
			local var_4_14 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(108101001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 9 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 9)

				if (9 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 9)) > 0 and var_4_14 < var_4_19 then
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

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101001", "story_v_out_108101.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_108101", "108101001", "story_v_out_108101.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_108101", "108101001", "story_v_out_108101.awb")

						arg_1_1:RecordAudio("108101001", var_4_21)
						arg_1_1:RecordAudio("108101001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_108101", "108101001", "story_v_out_108101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_108101", "108101001", "story_v_out_108101.awb")
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
	Play108101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 108101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play108101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_8", "se_story_8_skill", "")
			end

			local var_12_1 = 0
			local var_12_2 = 0.9

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(108101002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)

				if (36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)) > 0 and var_12_2 < var_12_5 then
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
	Play108101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 108101003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play108101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.85

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(108101003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)) > 0 and var_16_0 < var_16_3 then
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
	Play108101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 108101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play108101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire_loop", "")
			end

			local var_20_1 = 0
			local var_20_2 = 0.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(108101004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 20 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 20)

				if (20 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 20)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play108101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 108101005
		arg_21_1.duration_ = 14.47

		local var_21_0 = {
			ja = 14.466,
			ko = 10.033,
			zh = 8.433,
			en = 12.266
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
				arg_21_0:Play108101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(108101005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 35 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 35)

				if (35 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 35)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101005", "story_v_out_108101.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_108101", "108101005", "story_v_out_108101.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_108101", "108101005", "story_v_out_108101.awb")

						arg_21_1:RecordAudio("108101005", var_24_6)
						arg_21_1:RecordAudio("108101005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_108101", "108101005", "story_v_out_108101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_108101", "108101005", "story_v_out_108101.awb")
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
	Play108101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 108101006
		arg_25_1.duration_ = 5.27

		local var_25_0 = {
			ja = 2.5,
			ko = 4.566,
			zh = 5.266,
			en = 4.8
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
				arg_25_0:Play108101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.45

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(108101006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 18 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 18)

				if (18 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 18)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101006", "story_v_out_108101.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_108101", "108101006", "story_v_out_108101.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_108101", "108101006", "story_v_out_108101.awb")

						arg_25_1:RecordAudio("108101006", var_28_6)
						arg_25_1:RecordAudio("108101006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_108101", "108101006", "story_v_out_108101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_108101", "108101006", "story_v_out_108101.awb")
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
	Play108101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 108101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play108101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("stop", "music", "se_story_8", "se_story_8_fire_loop", "")

				local var_32_2 = manager.audio:GetAudioName("se_story_8", "se_story_8_fire_loop")

				if "" ~= "" then
					if arg_29_1.bgmTxt_.text ~= var_32_2 and arg_29_1.bgmTxt_.text ~= "" then
						if arg_29_1.bgmTxt2_.text ~= "" then
							arg_29_1.bgmTxt_.text = arg_29_1.bgmTxt2_.text
						end

						arg_29_1.bgmTxt2_.text = var_32_2

						arg_29_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_29_1.bgmTxt_.text = var_32_2
						arg_29_1.bgmTxt2_.text = var_32_2
					end

					if arg_29_1.bgmTimer then
						arg_29_1.bgmTimer:Stop()

						arg_29_1.bgmTimer = nil
					end

					if arg_29_1.settingData.show_music_name == 1 then
						arg_29_1.musicController:SetSelectedState("show")
						arg_29_1.musicAnimator_:Play("open", 0, 0)

						if arg_29_1.settingData.music_time ~= 0 then
							arg_29_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_29_1.settingData.music_time), function()
								if arg_29_1 == nil or isNil(arg_29_1.bgmTxt_) then
									return
								end

								arg_29_1.musicController:SetSelectedState("hide")
								arg_29_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.25 < arg_29_1.time_ and arg_29_1.time_ <= 0.25 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire05", "")
			end

			local var_32_4 = 0
			local var_32_5 = 1.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(108101007).content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 50 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 50)

				if (50 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 50)) > 0 and var_32_5 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_9 and arg_29_1.time_ < var_32_4 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play108101008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 108101008
		arg_34_1.duration_ = 6.37

		local var_34_0 = {
			ja = 6.333,
			ko = 6.366,
			zh = 5.166,
			en = 6.033
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
				arg_34_0:Play108101009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.bgs_.C05b == nil then
				local var_37_0 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C05b")
				var_37_0.name = "C05b"
				var_37_0.transform.parent = arg_34_1.stage_.transform
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_.C05b = var_37_0
			end

			if 1.5 < arg_34_1.time_ and arg_34_1.time_ <= 1.5 + arg_37_0 then
				local var_37_1 = arg_34_1.bgs_.C05b

				arg_34_1.bgs_.C05b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_2 = var_37_1:GetComponent("SpriteRenderer")

				if var_37_2 and var_37_2.sprite then
					local var_37_3 = 2 * (var_37_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_1.transform.localScale = Vector3.New(var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "C05b" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_4 = arg_34_1.bgs_.S0806:GetComponent("SpriteRenderer")

				if var_37_4 then
					arg_34_1.var_.alphaOldValueS0806 = var_37_4.color.a
					arg_34_1.var_.alphaMatValueS0806 = var_37_4
				end

				arg_34_1.var_.alphaOldValueS0806 = 1
			end

			local var_37_5 = 1.5

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_5 then
				if arg_34_1.var_.alphaMatValueS0806 then
					arg_34_1.var_.alphaMatValueS0806.color.a = Mathf.Lerp(arg_34_1.var_.alphaOldValueS0806, 0, (arg_34_1.time_ - 0) / var_37_5)
					arg_34_1.var_.alphaMatValueS0806.color = arg_34_1.var_.alphaMatValueS0806.color
				end
			end

			if arg_34_1.time_ >= 0 + var_37_5 and arg_34_1.time_ < 0 + var_37_5 + arg_37_0 and arg_34_1.var_.alphaMatValueS0806 then
				arg_34_1.var_.alphaMatValueS0806.color.a = 0
				arg_34_1.var_.alphaMatValueS0806.color = arg_34_1.var_.alphaMatValueS0806.color
			end

			if 1.5 < arg_34_1.time_ and arg_34_1.time_ <= 1.5 + arg_37_0 then
				local var_37_6 = arg_34_1.bgs_.C05b:GetComponent("SpriteRenderer")

				if var_37_6 then
					arg_34_1.var_.alphaOldValueC05b = var_37_6.color.a
					arg_34_1.var_.alphaMatValueC05b = var_37_6
				end

				arg_34_1.var_.alphaOldValueC05b = 0
			end

			local var_37_7 = 1.5

			if 1.5 <= arg_34_1.time_ and arg_34_1.time_ < 1.5 + var_37_7 then
				if arg_34_1.var_.alphaMatValueC05b then
					arg_34_1.var_.alphaMatValueC05b.color.a = Mathf.Lerp(arg_34_1.var_.alphaOldValueC05b, 1, (arg_34_1.time_ - 1.5) / var_37_7)
					arg_34_1.var_.alphaMatValueC05b.color = arg_34_1.var_.alphaMatValueC05b.color
				end
			end

			if arg_34_1.time_ >= 1.5 + var_37_7 and arg_34_1.time_ < 1.5 + var_37_7 + arg_37_0 and arg_34_1.var_.alphaMatValueC05b then
				arg_34_1.var_.alphaMatValueC05b.color.a = 1
				arg_34_1.var_.alphaMatValueC05b.color = arg_34_1.var_.alphaMatValueC05b.color
			end

			local var_37_8 = "1084ui_story"

			if arg_34_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_37_9 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_34_1.stage_.transform)

				var_37_9.name = var_37_8
				var_37_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_[var_37_8] = var_37_9

				local var_37_10 = var_37_9:GetComponentInChildren(typeof(CharacterEffect))

				var_37_10.enabled = true

				local var_37_11 = GameObjectTools.GetOrAddComponent(var_37_9, typeof(DynamicBoneHelper))

				if var_37_11 then
					var_37_11:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_10.transform, false)

				arg_34_1.var_[var_37_8 .. "Animator"] = var_37_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_[var_37_8 .. "Animator"].applyRootMotion = true
				arg_34_1.var_[var_37_8 .. "LipSync"] = var_37_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_37_12 = arg_34_1.actors_["1084ui_story"].transform

			if 1.8 < arg_34_1.time_ and arg_34_1.time_ <= 1.8 + arg_37_0 then
				arg_34_1.var_.moveOldPos1084ui_story = var_37_12.localPosition
			end

			local var_37_13 = 0.001

			if 1.8 <= arg_34_1.time_ and arg_34_1.time_ < 1.8 + var_37_13 then
				var_37_12.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_34_1.time_ - 1.8) / var_37_13)
				var_37_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_12.position).x, (manager.ui.mainCamera.transform.position - var_37_12.position).y, (manager.ui.mainCamera.transform.position - var_37_12.position).z)
				var_37_12.localEulerAngles.z = 0
				var_37_12.localEulerAngles.x = 0
				var_37_12.localEulerAngles = var_37_12.localEulerAngles
			end

			if arg_34_1.time_ >= 1.8 + var_37_13 and arg_34_1.time_ < 1.8 + var_37_13 + arg_37_0 then
				var_37_12.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_37_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_12.position).x, (manager.ui.mainCamera.transform.position - var_37_12.position).y, (manager.ui.mainCamera.transform.position - var_37_12.position).z)
				var_37_12.localEulerAngles.z = 0
				var_37_12.localEulerAngles.x = 0
				var_37_12.localEulerAngles = var_37_12.localEulerAngles
			end

			local var_37_14 = arg_34_1.actors_["1084ui_story"]

			if 1.8 < arg_34_1.time_ and arg_34_1.time_ <= 1.8 + arg_37_0 and not isNil(var_37_14) and arg_34_1.var_.characterEffect1084ui_story == nil then
				arg_34_1.var_.characterEffect1084ui_story = var_37_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_15 = 0.2

			if 1.8 <= arg_34_1.time_ and arg_34_1.time_ < 1.8 + var_37_15 and not isNil(var_37_14) then
				if arg_34_1.var_.characterEffect1084ui_story and not isNil(var_37_14) then
					arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 1.8 + var_37_15 and arg_34_1.time_ < 1.8 + var_37_15 + arg_37_0 and not isNil(var_37_14) and arg_34_1.var_.characterEffect1084ui_story then
				arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.8 < arg_34_1.time_ and arg_34_1.time_ <= 1.8 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 1.8 < arg_34_1.time_ and arg_34_1.time_ <= 1.8 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_37_17 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_17 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_17 + 2 and arg_34_1.time_ < var_37_17 + 2 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_18 = 2
			local var_37_19 = 0.425

			if 2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_18 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_20 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_20:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_21 = arg_34_1:GetWordFromCfg(108101008)
				local var_37_22 = arg_34_1:FormatText(var_37_21.content)

				arg_34_1.text_.text = var_37_22

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_24 = 15 <= 0 and var_37_19 or var_37_19 * (utf8.len(var_37_22) / 15)

				if (15 <= 0 and var_37_19 or var_37_19 * (utf8.len(var_37_22) / 15)) > 0 and var_37_19 < var_37_24 then
					arg_34_1.talkMaxDuration = var_37_24
					var_37_18 = var_37_18 + 0.3

					if var_37_24 + var_37_18 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_24 + var_37_18
					end
				end

				arg_34_1.text_.text = var_37_22
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101008", "story_v_out_108101.awb") ~= 0 then
					local var_37_25 = manager.audio:GetVoiceLength("story_v_out_108101", "108101008", "story_v_out_108101.awb") / 1000

					if var_37_25 + var_37_18 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_25 + var_37_18
					end

					if var_37_21.prefab_name ~= "" and arg_34_1.actors_[var_37_21.prefab_name] ~= nil then
						local var_37_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_21.prefab_name].transform, "story_v_out_108101", "108101008", "story_v_out_108101.awb")

						arg_34_1:RecordAudio("108101008", var_37_26)
						arg_34_1:RecordAudio("108101008", var_37_26)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_108101", "108101008", "story_v_out_108101.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_108101", "108101008", "story_v_out_108101.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_27 = var_37_18 + 0.3
			local var_37_28 = math.max(var_37_19, arg_34_1.talkMaxDuration)

			if var_37_18 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_27 + var_37_28 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_27) / var_37_28

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_27 + var_37_28 and arg_34_1.time_ < var_37_27 + var_37_28 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play108101009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108101009
		arg_40_1.duration_ = 6.53

		local var_40_0 = {
			ja = 6.533,
			ko = 4.966,
			zh = 3.7,
			en = 4.933
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
				arg_40_0:Play108101010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1038ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1038ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1038ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1038ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1038ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1038ui_story = var_43_3.localPosition
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_40_1.time_ - 0) / var_43_4)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			local var_43_5 = arg_40_1.actors_["1084ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.3

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 and not isNil(var_43_5) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_6)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_43_7 = arg_40_1.actors_["1038ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1038ui_story == nil then
				arg_40_1.var_.characterEffect1038ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.3

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1038ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1038ui_story then
				arg_40_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_43_10 = 0
			local var_43_11 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_12 = arg_40_1:GetWordFromCfg(108101009)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 16 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 16)

				if (16 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 16)) > 0 and var_43_11 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101009", "story_v_out_108101.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_out_108101", "108101009", "story_v_out_108101.awb") / 1000

					if var_43_16 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_10
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_out_108101", "108101009", "story_v_out_108101.awb")

						arg_40_1:RecordAudio("108101009", var_43_17)
						arg_40_1:RecordAudio("108101009", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_108101", "108101009", "story_v_out_108101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_108101", "108101009", "story_v_out_108101.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_18 and arg_40_1.time_ < var_43_10 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play108101010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108101010
		arg_44_1.duration_ = 9.27

		local var_44_0 = {
			ja = 8.133,
			ko = 7,
			zh = 6.566,
			en = 9.266
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play108101011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = arg_44_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(arg_44_1.actors_["1084ui_story"]) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1038ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1038ui_story == nil then
				arg_44_1.var_.characterEffect1038ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1038ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1038ui_story then
				arg_44_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0.6 < arg_44_1.time_ and arg_44_1.time_ <= 0.6 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4124")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_4 = 0
			local var_47_5 = 0.6

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(108101010)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 24 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 24)

				if (24 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 24)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101010", "story_v_out_108101.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_108101", "108101010", "story_v_out_108101.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_108101", "108101010", "story_v_out_108101.awb")

						arg_44_1:RecordAudio("108101010", var_47_11)
						arg_44_1:RecordAudio("108101010", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_108101", "108101010", "story_v_out_108101.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_108101", "108101010", "story_v_out_108101.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play108101011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108101011
		arg_48_1.duration_ = 4.4

		local var_48_0 = {
			ja = 4.4,
			ko = 3.966,
			zh = 4.133,
			en = 3.833
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
				arg_48_0:Play108101012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_0 = 0
			local var_51_1 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(108101011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 19 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 19)

				if (19 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 19)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101011", "story_v_out_108101.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_108101", "108101011", "story_v_out_108101.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_108101", "108101011", "story_v_out_108101.awb")

						arg_48_1:RecordAudio("108101011", var_51_7)
						arg_48_1:RecordAudio("108101011", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_108101", "108101011", "story_v_out_108101.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_108101", "108101011", "story_v_out_108101.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play108101012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108101012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play108101013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = arg_52_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1084ui_story"].transform.position).z)
				arg_52_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1084ui_story"].transform.localEulerAngles = arg_52_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1084ui_story"].transform.position).z)
				arg_52_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1084ui_story"].transform.localEulerAngles = arg_52_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1038ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1038ui_story = var_55_1.localPosition
			end

			local var_55_2 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 then
				var_55_1.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_2)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 then
				var_55_1.localPosition = Vector3.New(0, 100, 0)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_8", "se_story_8_water02_loop", "")
			end

			local var_55_4 = 0
			local var_55_5 = 0.475

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_6 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(108101012).content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_6) / 19)

				if (19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_6) / 19)) > 0 and var_55_5 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_9 and arg_52_1.time_ < var_55_4 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play108101013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 108101013
		arg_56_1.duration_ = 4.8

		local var_56_0 = {
			ja = 4.8,
			ko = 3.133,
			zh = 3.4,
			en = 4.1
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
				arg_56_0:Play108101014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1038ui_story = arg_56_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1038ui_story"].transform.position).z)
				arg_56_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1038ui_story"].transform.localEulerAngles = arg_56_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_56_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1038ui_story"].transform.position).z)
				arg_56_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1038ui_story"].transform.localEulerAngles = arg_56_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1038ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1038ui_story == nil then
				arg_56_1.var_.characterEffect1038ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1038ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1038ui_story then
				arg_56_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_59_4 = 0
			local var_59_5 = 0.475

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(108101013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 19 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 19)

				if (19 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 19)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101013", "story_v_out_108101.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_108101", "108101013", "story_v_out_108101.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_108101", "108101013", "story_v_out_108101.awb")

						arg_56_1:RecordAudio("108101013", var_59_11)
						arg_56_1:RecordAudio("108101013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_108101", "108101013", "story_v_out_108101.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_108101", "108101013", "story_v_out_108101.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play108101014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 108101014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play108101015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1038ui_story = arg_60_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1038ui_story"].transform.position).z)
				arg_60_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1038ui_story"].transform.localEulerAngles = arg_60_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1038ui_story"].transform.position).z)
				arg_60_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1038ui_story"].transform.localEulerAngles = arg_60_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_63_1 = 0
			local var_63_2 = 0.1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(108101014).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 4 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 4)

				if (4 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 4)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play108101015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 108101015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play108101016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:AudioAction("stop", "music", "se_story_8", "se_story_8_water02_loop", "")

				local var_67_2 = manager.audio:GetAudioName("se_story_8", "se_story_8_water02_loop")

				if "" ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_2 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_2

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_2
						arg_64_1.bgmTxt2_.text = var_67_2
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.474999999999 < arg_64_1.time_ and arg_64_1.time_ <= 0.474999999999 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_8", "se_story_8_water03", "")
			end

			local var_67_4 = 0
			local var_67_5 = 0.975

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(108101015).content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 39 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_6) / 39)

				if (39 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_6) / 39)) > 0 and var_67_5 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_9 and arg_64_1.time_ < var_67_4 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play108101016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 108101016
		arg_69_1.duration_ = 4.57

		local var_69_0 = {
			ja = 3.2,
			ko = 4.466,
			zh = 4.566,
			en = 3.3
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
				arg_69_0:Play108101017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["4015_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4015_tpose"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "4015_tpose"), arg_69_1.stage_.transform)

				var_72_0.name = "4015_tpose"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["4015_tpose"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["4015_tpose" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["4015_tpose" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["4015_tpose" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["4015_tpose"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos4015_tpose = var_72_3.localPosition

				local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_3.gameObject, typeof(DynamicBoneHelper))

				if var_72_4 then
					var_72_4:EnableDynamicBone(false)
				end
			end

			local var_72_5 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos4015_tpose, Vector3.New(0, -2.65, -2), (arg_69_1.time_ - 0) / var_72_5)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -2.65, -2)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles

				local var_72_6 = GameObjectTools.GetOrAddComponent(var_72_3.gameObject, typeof(DynamicBoneHelper))

				if var_72_6 then
					var_72_6:EnableDynamicBone(true)
				end
			end

			local var_72_7 = arg_69_1.actors_["4015_tpose"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.characterEffect4015_tpose == nil then
				arg_69_1.var_.characterEffect4015_tpose = var_72_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_8 and not isNil(var_72_7) then
				if arg_69_1.var_.characterEffect4015_tpose and not isNil(var_72_7) then
					arg_69_1.var_.characterEffect4015_tpose.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_8 and arg_69_1.time_ < 0 + var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.characterEffect4015_tpose then
				arg_69_1.var_.characterEffect4015_tpose.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("4015_tpose", "StoryTimeline/CharAction/story4015/story4015action/4015action1_1")
			end

			local var_72_10 = 0
			local var_72_11 = 0.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_12 = arg_69_1:GetWordFromCfg(108101016)
				local var_72_13 = arg_69_1:FormatText(var_72_12.content)

				arg_69_1.text_.text = var_72_13

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_15 = 11 <= 0 and var_72_11 or var_72_11 * (utf8.len(var_72_13) / 11)

				if (11 <= 0 and var_72_11 or var_72_11 * (utf8.len(var_72_13) / 11)) > 0 and var_72_11 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_10
					end
				end

				arg_69_1.text_.text = var_72_13
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101016", "story_v_out_108101.awb") ~= 0 then
					local var_72_16 = manager.audio:GetVoiceLength("story_v_out_108101", "108101016", "story_v_out_108101.awb") / 1000

					if var_72_16 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_10
					end

					if var_72_12.prefab_name ~= "" and arg_69_1.actors_[var_72_12.prefab_name] ~= nil then
						local var_72_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_12.prefab_name].transform, "story_v_out_108101", "108101016", "story_v_out_108101.awb")

						arg_69_1:RecordAudio("108101016", var_72_17)
						arg_69_1:RecordAudio("108101016", var_72_17)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_108101", "108101016", "story_v_out_108101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_108101", "108101016", "story_v_out_108101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_10) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_10 + var_72_18 and arg_69_1.time_ < var_72_10 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4015_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play108101017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 108101017
		arg_73_1.duration_ = 8.57

		local var_73_0 = {
			ja = 8.566,
			ko = 8.466,
			zh = 5.9,
			en = 5.866
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
				arg_73_0:Play108101018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(108101017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 26 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 26)

				if (26 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 26)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101017", "story_v_out_108101.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_108101", "108101017", "story_v_out_108101.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_108101", "108101017", "story_v_out_108101.awb")

						arg_73_1:RecordAudio("108101017", var_76_6)
						arg_73_1:RecordAudio("108101017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_108101", "108101017", "story_v_out_108101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_108101", "108101017", "story_v_out_108101.awb")
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
	Play108101018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 108101018
		arg_77_1.duration_ = 6.43

		local var_77_0 = {
			ja = 4.666,
			ko = 6.366,
			zh = 5.666,
			en = 6.433
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
				arg_77_0:Play108101019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(108101018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 16 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 16)

				if (16 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 16)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108101", "108101018", "story_v_out_108101.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_108101", "108101018", "story_v_out_108101.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_108101", "108101018", "story_v_out_108101.awb")

						arg_77_1:RecordAudio("108101018", var_80_6)
						arg_77_1:RecordAudio("108101018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_108101", "108101018", "story_v_out_108101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_108101", "108101018", "story_v_out_108101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play108101019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 108101019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
			arg_81_1.auto_ = false
		end

		function arg_81_1.playNext_(arg_83_0)
			arg_81_1.onStoryFinished_()
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["4015_tpose"]) and arg_81_1.var_.characterEffect4015_tpose == nil then
				arg_81_1.var_.characterEffect4015_tpose = arg_81_1.actors_["4015_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["4015_tpose"]) then
				if arg_81_1.var_.characterEffect4015_tpose and not isNil(arg_81_1.actors_["4015_tpose"]) then
					arg_81_1.var_.characterEffect4015_tpose.fillFlat = true
					arg_81_1.var_.characterEffect4015_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["4015_tpose"]) and arg_81_1.var_.characterEffect4015_tpose then
				arg_81_1.var_.characterEffect4015_tpose.fillFlat = true
				arg_81_1.var_.characterEffect4015_tpose.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.2

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(108101019).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 8 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 8)

				if (8 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 8)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0806",
		"TextureConfig/Background/C05b"
	},
	voices = {
		"story_v_out_108101.awb"
	}
}
