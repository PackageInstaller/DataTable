return {
	Play121561001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121561001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121561002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XH0310 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0310")
				var_4_0.name = "XH0310"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XH0310 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XH0310

				arg_1_1.bgs_.XH0310.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XH0310" then
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_1_story_afterbattle", "bgm_activity_2_1_story_afterbattle", "bgm_activity_2_1_story_afterbattle.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_1_story_afterbattle", "bgm_activity_2_1_story_afterbattle")

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
				arg_1_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_final_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.525

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(121561001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 21 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 21)

				if (21 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 21)) > 0 and var_4_16 < var_4_20 then
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
	Play121561002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121561002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121561003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.275

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(121561002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 51 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 51)

				if (51 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 51)) > 0 and var_12_0 < var_12_3 then
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
	Play121561003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121561003
		arg_13_1.duration_ = 9.1

		local var_13_0 = {
			ja = 5.433,
			ko = 9.1,
			zh = 9.1
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
				arg_13_0:Play121561004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(121561003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 31)

				if (31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 31)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561003", "story_v_out_121561.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561003", "story_v_out_121561.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_121561", "121561003", "story_v_out_121561.awb")

						arg_13_1:RecordAudio("121561003", var_16_6)
						arg_13_1:RecordAudio("121561003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121561", "121561003", "story_v_out_121561.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121561", "121561003", "story_v_out_121561.awb")
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
	Play121561004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121561004
		arg_17_1.duration_ = 6.07

		local var_17_0 = {
			ja = 6.066,
			ko = 4.833,
			zh = 4.833
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
				arg_17_0:Play121561005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(121561004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 23 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 23)

				if (23 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 23)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561004", "story_v_out_121561.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561004", "story_v_out_121561.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_121561", "121561004", "story_v_out_121561.awb")

						arg_17_1:RecordAudio("121561004", var_20_6)
						arg_17_1:RecordAudio("121561004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121561", "121561004", "story_v_out_121561.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121561", "121561004", "story_v_out_121561.awb")
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
	Play121561005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121561005
		arg_21_1.duration_ = 6.4

		local var_21_0 = {
			ja = 6.4,
			ko = 4.733,
			zh = 4.733
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
				arg_21_0:Play121561006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(121561005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 22 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 22)

				if (22 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 22)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561005", "story_v_out_121561.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561005", "story_v_out_121561.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_121561", "121561005", "story_v_out_121561.awb")

						arg_21_1:RecordAudio("121561005", var_24_6)
						arg_21_1:RecordAudio("121561005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121561", "121561005", "story_v_out_121561.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121561", "121561005", "story_v_out_121561.awb")
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
	Play121561006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121561006
		arg_25_1.duration_ = 5.7

		local var_25_0 = {
			ja = 5.7,
			ko = 4.266,
			zh = 4.266
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
				arg_25_0:Play121561007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.5

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(121561006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 20 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 20)

				if (20 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 20)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561006", "story_v_out_121561.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561006", "story_v_out_121561.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_121561", "121561006", "story_v_out_121561.awb")

						arg_25_1:RecordAudio("121561006", var_28_6)
						arg_25_1:RecordAudio("121561006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121561", "121561006", "story_v_out_121561.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121561", "121561006", "story_v_out_121561.awb")
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
	Play121561007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121561007
		arg_29_1.duration_ = 9.97

		local var_29_0 = {
			ja = 7.533,
			ko = 9.966,
			zh = 9.966
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
				arg_29_0:Play121561008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(121561007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 52 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 52)

				if (52 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 52)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561007", "story_v_out_121561.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561007", "story_v_out_121561.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_121561", "121561007", "story_v_out_121561.awb")

						arg_29_1:RecordAudio("121561007", var_32_6)
						arg_29_1:RecordAudio("121561007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121561", "121561007", "story_v_out_121561.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121561", "121561007", "story_v_out_121561.awb")
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
	Play121561008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121561008
		arg_33_1.duration_ = 10.5

		local var_33_0 = {
			ja = 10.2,
			ko = 10.5,
			zh = 10.5
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
				arg_33_0:Play121561009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.15

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(121561008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 46 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 46)

				if (46 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 46)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561008", "story_v_out_121561.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561008", "story_v_out_121561.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_121561", "121561008", "story_v_out_121561.awb")

						arg_33_1:RecordAudio("121561008", var_36_6)
						arg_33_1:RecordAudio("121561008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121561", "121561008", "story_v_out_121561.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121561", "121561008", "story_v_out_121561.awb")
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
	Play121561009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121561009
		arg_37_1.duration_ = 9.2

		local var_37_0 = {
			ja = 9.2,
			ko = 4.2,
			zh = 4.2
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
				arg_37_0:Play121561010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(121561009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 16 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 16)

				if (16 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 16)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561009", "story_v_out_121561.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561009", "story_v_out_121561.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_121561", "121561009", "story_v_out_121561.awb")

						arg_37_1:RecordAudio("121561009", var_40_6)
						arg_37_1:RecordAudio("121561009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121561", "121561009", "story_v_out_121561.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121561", "121561009", "story_v_out_121561.awb")
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
	Play121561010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121561010
		arg_41_1.duration_ = 3.77

		local var_41_0 = {
			ja = 3.766,
			ko = 2.7,
			zh = 2.7
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
				arg_41_0:Play121561011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(121561010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 5 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 5)

				if (5 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 5)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561010", "story_v_out_121561.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561010", "story_v_out_121561.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_121561", "121561010", "story_v_out_121561.awb")

						arg_41_1:RecordAudio("121561010", var_44_6)
						arg_41_1:RecordAudio("121561010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121561", "121561010", "story_v_out_121561.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121561", "121561010", "story_v_out_121561.awb")
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
	Play121561011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121561011
		arg_45_1.duration_ = 12.9

		local var_45_0 = {
			ja = 7.466,
			ko = 12.9,
			zh = 12.9
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
				arg_45_0:Play121561012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.425

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(121561011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 57 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 57)

				if (57 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 57)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561011", "story_v_out_121561.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561011", "story_v_out_121561.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_121561", "121561011", "story_v_out_121561.awb")

						arg_45_1:RecordAudio("121561011", var_48_6)
						arg_45_1:RecordAudio("121561011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121561", "121561011", "story_v_out_121561.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121561", "121561011", "story_v_out_121561.awb")
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
	Play121561012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121561012
		arg_49_1.duration_ = 9.97

		local var_49_0 = {
			ja = 9.966,
			ko = 8.433,
			zh = 8.433
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
				arg_49_0:Play121561013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.75

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(121561012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 30)

				if (30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 30)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561012", "story_v_out_121561.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561012", "story_v_out_121561.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_121561", "121561012", "story_v_out_121561.awb")

						arg_49_1:RecordAudio("121561012", var_52_6)
						arg_49_1:RecordAudio("121561012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121561", "121561012", "story_v_out_121561.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121561", "121561012", "story_v_out_121561.awb")
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
	Play121561013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121561013
		arg_53_1.duration_ = 9.03

		local var_53_0 = {
			ja = 9.033,
			ko = 4,
			zh = 4
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
				arg_53_0:Play121561014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.525

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(121561013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 21 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 21)

				if (21 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 21)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561013", "story_v_out_121561.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561013", "story_v_out_121561.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_121561", "121561013", "story_v_out_121561.awb")

						arg_53_1:RecordAudio("121561013", var_56_6)
						arg_53_1:RecordAudio("121561013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121561", "121561013", "story_v_out_121561.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121561", "121561013", "story_v_out_121561.awb")
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
	Play121561014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121561014
		arg_57_1.duration_ = 5.8

		local var_57_0 = {
			ja = 3.766,
			ko = 5.8,
			zh = 5.8
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
				arg_57_0:Play121561015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(121561014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 16 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 16)

				if (16 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 16)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561014", "story_v_out_121561.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561014", "story_v_out_121561.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_121561", "121561014", "story_v_out_121561.awb")

						arg_57_1:RecordAudio("121561014", var_60_6)
						arg_57_1:RecordAudio("121561014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121561", "121561014", "story_v_out_121561.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121561", "121561014", "story_v_out_121561.awb")
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
	Play121561015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121561015
		arg_61_1.duration_ = 11.33

		local var_61_0 = {
			ja = 4.633,
			ko = 11.333,
			zh = 11.333
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
				arg_61_0:Play121561016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.125

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(121561015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 45 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 45)

				if (45 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 45)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561015", "story_v_out_121561.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561015", "story_v_out_121561.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_121561", "121561015", "story_v_out_121561.awb")

						arg_61_1:RecordAudio("121561015", var_64_6)
						arg_61_1:RecordAudio("121561015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121561", "121561015", "story_v_out_121561.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121561", "121561015", "story_v_out_121561.awb")
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
	Play121561016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121561016
		arg_65_1.duration_ = 5.5

		local var_65_0 = {
			ja = 5.5,
			ko = 4.633,
			zh = 4.633
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
				arg_65_0:Play121561017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.575

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(121561016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 23 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 23)

				if (23 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 23)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561016", "story_v_out_121561.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561016", "story_v_out_121561.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_121561", "121561016", "story_v_out_121561.awb")

						arg_65_1:RecordAudio("121561016", var_68_6)
						arg_65_1:RecordAudio("121561016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121561", "121561016", "story_v_out_121561.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121561", "121561016", "story_v_out_121561.awb")
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
	Play121561017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121561017
		arg_69_1.duration_ = 8.47

		local var_69_0 = {
			ja = 8.466,
			ko = 6.366,
			zh = 6.366
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
				arg_69_0:Play121561018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.725

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(121561017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 29 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 29)

				if (29 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 29)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561017", "story_v_out_121561.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561017", "story_v_out_121561.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_121561", "121561017", "story_v_out_121561.awb")

						arg_69_1:RecordAudio("121561017", var_72_6)
						arg_69_1:RecordAudio("121561017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121561", "121561017", "story_v_out_121561.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121561", "121561017", "story_v_out_121561.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121561018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121561018
		arg_73_1.duration_ = 7.5

		local var_73_0 = {
			ja = 4.8,
			ko = 7.5,
			zh = 7.5
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
				arg_73_0:Play121561019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(121561018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 27 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 27)

				if (27 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 27)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561018", "story_v_out_121561.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561018", "story_v_out_121561.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_121561", "121561018", "story_v_out_121561.awb")

						arg_73_1:RecordAudio("121561018", var_76_6)
						arg_73_1:RecordAudio("121561018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121561", "121561018", "story_v_out_121561.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121561", "121561018", "story_v_out_121561.awb")
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
	Play121561019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121561019
		arg_77_1.duration_ = 8.7

		local var_77_0 = {
			ja = 8.7,
			ko = 7.5,
			zh = 7.5
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
				arg_77_0:Play121561020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.75

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(121561019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 30 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 30)

				if (30 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 30)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561019", "story_v_out_121561.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561019", "story_v_out_121561.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_121561", "121561019", "story_v_out_121561.awb")

						arg_77_1:RecordAudio("121561019", var_80_6)
						arg_77_1:RecordAudio("121561019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121561", "121561019", "story_v_out_121561.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121561", "121561019", "story_v_out_121561.awb")
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
	Play121561020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121561020
		arg_81_1.duration_ = 8.03

		local var_81_0 = {
			ja = 7.1,
			ko = 8.033,
			zh = 8.033
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
				arg_81_0:Play121561021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.975

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(121561020)
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561020", "story_v_out_121561.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561020", "story_v_out_121561.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_121561", "121561020", "story_v_out_121561.awb")

						arg_81_1:RecordAudio("121561020", var_84_6)
						arg_81_1:RecordAudio("121561020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121561", "121561020", "story_v_out_121561.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121561", "121561020", "story_v_out_121561.awb")
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
	Play121561021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121561021
		arg_85_1.duration_ = 6.13

		local var_85_0 = {
			ja = 6.133,
			ko = 4.1,
			zh = 4.1
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
				arg_85_0:Play121561022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(121561021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 17 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 17)

				if (17 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 17)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561021", "story_v_out_121561.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561021", "story_v_out_121561.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_121561", "121561021", "story_v_out_121561.awb")

						arg_85_1:RecordAudio("121561021", var_88_6)
						arg_85_1:RecordAudio("121561021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121561", "121561021", "story_v_out_121561.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121561", "121561021", "story_v_out_121561.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121561022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121561022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121561023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.125

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(121561022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 45 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 45)

				if (45 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 45)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121561023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121561023
		arg_93_1.duration_ = 6.73

		local var_93_0 = {
			ja = 6.733,
			ko = 2.266,
			zh = 2.266
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
				arg_93_0:Play121561024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.375

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(121561023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 15 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 15)

				if (15 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 15)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561023", "story_v_out_121561.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561023", "story_v_out_121561.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_121561", "121561023", "story_v_out_121561.awb")

						arg_93_1:RecordAudio("121561023", var_96_6)
						arg_93_1:RecordAudio("121561023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121561", "121561023", "story_v_out_121561.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121561", "121561023", "story_v_out_121561.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121561024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121561024
		arg_97_1.duration_ = 11.2

		local var_97_0 = {
			ja = 11.2,
			ko = 5.433,
			zh = 5.433
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
				arg_97_0:Play121561025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.725

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(121561024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 29 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 29)

				if (29 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 29)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561024", "story_v_out_121561.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561024", "story_v_out_121561.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_121561", "121561024", "story_v_out_121561.awb")

						arg_97_1:RecordAudio("121561024", var_100_6)
						arg_97_1:RecordAudio("121561024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121561", "121561024", "story_v_out_121561.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121561", "121561024", "story_v_out_121561.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121561025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121561025
		arg_101_1.duration_ = 6.6

		local var_101_0 = {
			ja = 6.6,
			ko = 5.666,
			zh = 5.666
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
				arg_101_0:Play121561026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.525

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(121561025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 21 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 21)

				if (21 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 21)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561025", "story_v_out_121561.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561025", "story_v_out_121561.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_121561", "121561025", "story_v_out_121561.awb")

						arg_101_1:RecordAudio("121561025", var_104_6)
						arg_101_1:RecordAudio("121561025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_121561", "121561025", "story_v_out_121561.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_121561", "121561025", "story_v_out_121561.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play121561026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121561026
		arg_105_1.duration_ = 5.67

		local var_105_0 = {
			ja = 1.2,
			ko = 5.666,
			zh = 5.666
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
				arg_105_0:Play121561027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.525

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(121561026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 21 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 21)

				if (21 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 21)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561026", "story_v_out_121561.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561026", "story_v_out_121561.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_121561", "121561026", "story_v_out_121561.awb")

						arg_105_1:RecordAudio("121561026", var_108_6)
						arg_105_1:RecordAudio("121561026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_121561", "121561026", "story_v_out_121561.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_121561", "121561026", "story_v_out_121561.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play121561027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121561027
		arg_109_1.duration_ = 12.6

		local var_109_0 = {
			ja = 12.6,
			ko = 7.266,
			zh = 7.266
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
				arg_109_0:Play121561028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.8

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(121561027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 32 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 32)

				if (32 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 32)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561027", "story_v_out_121561.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561027", "story_v_out_121561.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_121561", "121561027", "story_v_out_121561.awb")

						arg_109_1:RecordAudio("121561027", var_112_6)
						arg_109_1:RecordAudio("121561027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121561", "121561027", "story_v_out_121561.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121561", "121561027", "story_v_out_121561.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play121561028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121561028
		arg_113_1.duration_ = 4.3

		local var_113_0 = {
			ja = 4.3,
			ko = 1.6,
			zh = 1.6
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
				arg_113_0:Play121561029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.125

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(121561028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 5 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 5)

				if (5 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 5)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561028", "story_v_out_121561.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561028", "story_v_out_121561.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_121561", "121561028", "story_v_out_121561.awb")

						arg_113_1:RecordAudio("121561028", var_116_6)
						arg_113_1:RecordAudio("121561028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_121561", "121561028", "story_v_out_121561.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_121561", "121561028", "story_v_out_121561.awb")
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
	Play121561029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121561029
		arg_117_1.duration_ = 4.8

		local var_117_0 = {
			ja = 4.8,
			ko = 4,
			zh = 4
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
				arg_117_0:Play121561030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(121561029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 16 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 16)

				if (16 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 16)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561029", "story_v_out_121561.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561029", "story_v_out_121561.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_121561", "121561029", "story_v_out_121561.awb")

						arg_117_1:RecordAudio("121561029", var_120_6)
						arg_117_1:RecordAudio("121561029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_121561", "121561029", "story_v_out_121561.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_121561", "121561029", "story_v_out_121561.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play121561030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 121561030
		arg_121_1.duration_ = 5.2

		local var_121_0 = {
			ja = 5.2,
			ko = 4.133,
			zh = 4.133
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
				arg_121_0:Play121561031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.3

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(121561030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 12 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 12)

				if (12 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 12)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561030", "story_v_out_121561.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561030", "story_v_out_121561.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_121561", "121561030", "story_v_out_121561.awb")

						arg_121_1:RecordAudio("121561030", var_124_6)
						arg_121_1:RecordAudio("121561030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_121561", "121561030", "story_v_out_121561.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_121561", "121561030", "story_v_out_121561.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play121561031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 121561031
		arg_125_1.duration_ = 8.1

		local var_125_0 = {
			ja = 8.1,
			ko = 4.566,
			zh = 4.566
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play121561032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(121561031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 18 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 18)

				if (18 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 18)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561031", "story_v_out_121561.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561031", "story_v_out_121561.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_121561", "121561031", "story_v_out_121561.awb")

						arg_125_1:RecordAudio("121561031", var_128_6)
						arg_125_1:RecordAudio("121561031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_121561", "121561031", "story_v_out_121561.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_121561", "121561031", "story_v_out_121561.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play121561032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121561032
		arg_129_1.duration_ = 2.1

		local var_129_0 = {
			ja = 2.1,
			ko = 1.233,
			zh = 1.233
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
				arg_129_0:Play121561033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.15

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(121561032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 6 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 6)

				if (6 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 6)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561032", "story_v_out_121561.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561032", "story_v_out_121561.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_121561", "121561032", "story_v_out_121561.awb")

						arg_129_1:RecordAudio("121561032", var_132_6)
						arg_129_1:RecordAudio("121561032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_121561", "121561032", "story_v_out_121561.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_121561", "121561032", "story_v_out_121561.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play121561033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121561033
		arg_133_1.duration_ = 6.8

		local var_133_0 = {
			ja = 5.566,
			ko = 6.8,
			zh = 6.8
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
				arg_133_0:Play121561034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(121561033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 14 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 14)

				if (14 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 14)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561033", "story_v_out_121561.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561033", "story_v_out_121561.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_121561", "121561033", "story_v_out_121561.awb")

						arg_133_1:RecordAudio("121561033", var_136_6)
						arg_133_1:RecordAudio("121561033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_121561", "121561033", "story_v_out_121561.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_121561", "121561033", "story_v_out_121561.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play121561034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121561034
		arg_137_1.duration_ = 3.6

		local var_137_0 = {
			ja = 3.6,
			ko = 3.366,
			zh = 3.366
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
				arg_137_0:Play121561035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(121561034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 15 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 15)

				if (15 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 15)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561034", "story_v_out_121561.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561034", "story_v_out_121561.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_121561", "121561034", "story_v_out_121561.awb")

						arg_137_1:RecordAudio("121561034", var_140_6)
						arg_137_1:RecordAudio("121561034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_121561", "121561034", "story_v_out_121561.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_121561", "121561034", "story_v_out_121561.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play121561035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121561035
		arg_141_1.duration_ = 4.73

		local var_141_0 = {
			ja = 4.733,
			ko = 2.8,
			zh = 2.8
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
				arg_141_0:Play121561036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.3

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(121561035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 12 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 12)

				if (12 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 12)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561035", "story_v_out_121561.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561035", "story_v_out_121561.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_121561", "121561035", "story_v_out_121561.awb")

						arg_141_1:RecordAudio("121561035", var_144_6)
						arg_141_1:RecordAudio("121561035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121561", "121561035", "story_v_out_121561.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121561", "121561035", "story_v_out_121561.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play121561036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121561036
		arg_145_1.duration_ = 7.97

		local var_145_0 = {
			ja = 7.666,
			ko = 7.966,
			zh = 7.966
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
				arg_145_0:Play121561037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.bgs_.J12g == nil then
				local var_148_0 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J12g")
				var_148_0.name = "J12g"
				var_148_0.transform.parent = arg_145_1.stage_.transform
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_.J12g = var_148_0
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				local var_148_1 = arg_145_1.bgs_.J12g

				arg_145_1.bgs_.J12g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_2 = var_148_1:GetComponent("SpriteRenderer")

				if var_148_2 and var_148_2.sprite then
					local var_148_3 = 2 * (var_148_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_1.transform.localScale = Vector3.New(var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "J12g" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_4 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_5 = 2

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_5 then
				local var_148_6 = Color.New(0, 0, 0)

				var_148_6.a = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_4) / var_148_5)
				arg_145_1.mask_.color = var_148_6
			end

			if arg_145_1.time_ >= var_148_4 + var_148_5 and arg_145_1.time_ < var_148_4 + var_148_5 + arg_148_0 then
				local var_148_7 = Color.New(0, 0, 0)

				var_148_7.a = 1
				arg_145_1.mask_.color = var_148_7
			end

			local var_148_8 = 2

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_9 = 2

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 then
				local var_148_10 = Color.New(0, 0, 0)

				var_148_10.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_8) / var_148_9)
				arg_145_1.mask_.color = var_148_10
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 then
				local var_148_11 = Color.New(0, 0, 0)

				arg_145_1.mask_.enabled = false
				var_148_11.a = 0
				arg_145_1.mask_.color = var_148_11
			end

			local var_148_12 = "1076ui_story"

			if arg_145_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_148_13 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_145_1.stage_.transform)

				var_148_13.name = var_148_12
				var_148_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_[var_148_12] = var_148_13

				local var_148_14 = var_148_13:GetComponentInChildren(typeof(CharacterEffect))

				var_148_14.enabled = true

				local var_148_15 = GameObjectTools.GetOrAddComponent(var_148_13, typeof(DynamicBoneHelper))

				if var_148_15 then
					var_148_15:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_14.transform, false)

				arg_145_1.var_[var_148_12 .. "Animator"] = var_148_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_[var_148_12 .. "Animator"].applyRootMotion = true
				arg_145_1.var_[var_148_12 .. "LipSync"] = var_148_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_16 = arg_145_1.actors_["1076ui_story"].transform

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 then
				arg_145_1.var_.moveOldPos1076ui_story = var_148_16.localPosition
			end

			local var_148_17 = 0.001

			if 3.96666666666667 <= arg_145_1.time_ and arg_145_1.time_ < 3.96666666666667 + var_148_17 then
				var_148_16.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_145_1.time_ - 3.96666666666667) / var_148_17)
				var_148_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_16.position).x, (manager.ui.mainCamera.transform.position - var_148_16.position).y, (manager.ui.mainCamera.transform.position - var_148_16.position).z)
				var_148_16.localEulerAngles.z = 0
				var_148_16.localEulerAngles.x = 0
				var_148_16.localEulerAngles = var_148_16.localEulerAngles
			end

			if arg_145_1.time_ >= 3.96666666666667 + var_148_17 and arg_145_1.time_ < 3.96666666666667 + var_148_17 + arg_148_0 then
				var_148_16.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_148_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_16.position).x, (manager.ui.mainCamera.transform.position - var_148_16.position).y, (manager.ui.mainCamera.transform.position - var_148_16.position).z)
				var_148_16.localEulerAngles.z = 0
				var_148_16.localEulerAngles.x = 0
				var_148_16.localEulerAngles = var_148_16.localEulerAngles
			end

			local var_148_18 = "1029ui_story"

			if arg_145_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_148_19 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_145_1.stage_.transform)

				var_148_19.name = var_148_18
				var_148_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_[var_148_18] = var_148_19

				local var_148_20 = var_148_19:GetComponentInChildren(typeof(CharacterEffect))

				var_148_20.enabled = true

				local var_148_21 = GameObjectTools.GetOrAddComponent(var_148_19, typeof(DynamicBoneHelper))

				if var_148_21 then
					var_148_21:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_20.transform, false)

				arg_145_1.var_[var_148_18 .. "Animator"] = var_148_20.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_[var_148_18 .. "Animator"].applyRootMotion = true
				arg_145_1.var_[var_148_18 .. "LipSync"] = var_148_20.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_22 = arg_145_1.actors_["1029ui_story"].transform

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 then
				arg_145_1.var_.moveOldPos1029ui_story = var_148_22.localPosition
			end

			local var_148_23 = 0.001

			if 3.96666666666667 <= arg_145_1.time_ and arg_145_1.time_ < 3.96666666666667 + var_148_23 then
				var_148_22.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_145_1.time_ - 3.96666666666667) / var_148_23)
				var_148_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_22.position).x, (manager.ui.mainCamera.transform.position - var_148_22.position).y, (manager.ui.mainCamera.transform.position - var_148_22.position).z)
				var_148_22.localEulerAngles.z = 0
				var_148_22.localEulerAngles.x = 0
				var_148_22.localEulerAngles = var_148_22.localEulerAngles
			end

			if arg_145_1.time_ >= 3.96666666666667 + var_148_23 and arg_145_1.time_ < 3.96666666666667 + var_148_23 + arg_148_0 then
				var_148_22.localPosition = Vector3.New(0.7, -1.09, -6.2)
				var_148_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_22.position).x, (manager.ui.mainCamera.transform.position - var_148_22.position).y, (manager.ui.mainCamera.transform.position - var_148_22.position).z)
				var_148_22.localEulerAngles.z = 0
				var_148_22.localEulerAngles.x = 0
				var_148_22.localEulerAngles = var_148_22.localEulerAngles
			end

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 then
				arg_145_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 then
				arg_145_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 then
				arg_145_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_148_24 = arg_145_1.actors_["1076ui_story"]

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 and not isNil(var_148_24) and arg_145_1.var_.characterEffect1076ui_story == nil then
				arg_145_1.var_.characterEffect1076ui_story = var_148_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_25 = 0.2

			if 3.96666666666667 <= arg_145_1.time_ and arg_145_1.time_ < 3.96666666666667 + var_148_25 and not isNil(var_148_24) then
				if arg_145_1.var_.characterEffect1076ui_story and not isNil(var_148_24) then
					arg_145_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 3.96666666666667 + var_148_25 and arg_145_1.time_ < 3.96666666666667 + var_148_25 + arg_148_0 and not isNil(var_148_24) and arg_145_1.var_.characterEffect1076ui_story then
				arg_145_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_148_27 = arg_145_1.actors_["1029ui_story"]

			if 3.96666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 3.96666666666667 + arg_148_0 and not isNil(var_148_27) and arg_145_1.var_.characterEffect1029ui_story == nil then
				arg_145_1.var_.characterEffect1029ui_story = var_148_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_28 = 0.0339999999999998

			if 3.96666666666667 <= arg_145_1.time_ and arg_145_1.time_ < 3.96666666666667 + var_148_28 and not isNil(var_148_27) then
				if arg_145_1.var_.characterEffect1029ui_story and not isNil(var_148_27) then
					arg_145_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 3.96666666666667) / var_148_28)
				end
			end

			if arg_145_1.time_ >= 3.96666666666667 + var_148_28 and arg_145_1.time_ < 3.96666666666667 + var_148_28 + arg_148_0 and not isNil(var_148_27) and arg_145_1.var_.characterEffect1029ui_story then
				arg_145_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_29 = 4
			local var_148_30 = 0.275

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_29 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_31 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_31:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_32 = arg_145_1:GetWordFromCfg(121561036)
				local var_148_33 = arg_145_1:FormatText(var_148_32.content)

				arg_145_1.text_.text = var_148_33

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_35 = 11 <= 0 and var_148_30 or var_148_30 * (utf8.len(var_148_33) / 11)

				if (11 <= 0 and var_148_30 or var_148_30 * (utf8.len(var_148_33) / 11)) > 0 and var_148_30 < var_148_35 then
					arg_145_1.talkMaxDuration = var_148_35
					var_148_29 = var_148_29 + 0.3

					if var_148_35 + var_148_29 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_35 + var_148_29
					end
				end

				arg_145_1.text_.text = var_148_33
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561036", "story_v_out_121561.awb") ~= 0 then
					local var_148_36 = manager.audio:GetVoiceLength("story_v_out_121561", "121561036", "story_v_out_121561.awb") / 1000

					if var_148_36 + var_148_29 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_36 + var_148_29
					end

					if var_148_32.prefab_name ~= "" and arg_145_1.actors_[var_148_32.prefab_name] ~= nil then
						local var_148_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_32.prefab_name].transform, "story_v_out_121561", "121561036", "story_v_out_121561.awb")

						arg_145_1:RecordAudio("121561036", var_148_37)
						arg_145_1:RecordAudio("121561036", var_148_37)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121561", "121561036", "story_v_out_121561.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121561", "121561036", "story_v_out_121561.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_38 = var_148_29 + 0.3
			local var_148_39 = math.max(var_148_30, arg_145_1.talkMaxDuration)

			if var_148_29 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_38 + var_148_39 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_38) / var_148_39

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_38 + var_148_39 and arg_145_1.time_ < var_148_38 + var_148_39 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play121561037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121561037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121561038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1076ui_story"]) and arg_151_1.var_.characterEffect1076ui_story == nil then
				arg_151_1.var_.characterEffect1076ui_story = arg_151_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1076ui_story"]) then
				if arg_151_1.var_.characterEffect1076ui_story and not isNil(arg_151_1.actors_["1076ui_story"]) then
					arg_151_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1076ui_story"]) and arg_151_1.var_.characterEffect1076ui_story then
				arg_151_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 1.125

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(121561037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 45 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 45)

				if (45 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 45)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121561038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121561038
		arg_155_1.duration_ = 4.17

		local var_155_0 = {
			ja = 4.166,
			ko = 3.1,
			zh = 3.1
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
				arg_155_0:Play121561039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1029ui_story"]) and arg_155_1.var_.characterEffect1029ui_story == nil then
				arg_155_1.var_.characterEffect1029ui_story = arg_155_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1029ui_story"]) then
				if arg_155_1.var_.characterEffect1029ui_story and not isNil(arg_155_1.actors_["1029ui_story"]) then
					arg_155_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1029ui_story"]) and arg_155_1.var_.characterEffect1029ui_story then
				arg_155_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_158_2 = 0
			local var_158_3 = 0.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(121561038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 13 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 13)

				if (13 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 13)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561038", "story_v_out_121561.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561038", "story_v_out_121561.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_121561", "121561038", "story_v_out_121561.awb")

						arg_155_1:RecordAudio("121561038", var_158_9)
						arg_155_1:RecordAudio("121561038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121561", "121561038", "story_v_out_121561.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121561", "121561038", "story_v_out_121561.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121561039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121561039
		arg_159_1.duration_ = 17.7

		local var_159_0 = {
			ja = 17.7,
			ko = 8.6,
			zh = 8.6
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
				arg_159_0:Play121561040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1076ui_story"]) and arg_159_1.var_.characterEffect1076ui_story == nil then
				arg_159_1.var_.characterEffect1076ui_story = arg_159_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1076ui_story"]) then
				if arg_159_1.var_.characterEffect1076ui_story and not isNil(arg_159_1.actors_["1076ui_story"]) then
					arg_159_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1076ui_story"]) and arg_159_1.var_.characterEffect1076ui_story then
				arg_159_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_162_2 = arg_159_1.actors_["1029ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect1029ui_story == nil then
				arg_159_1.var_.characterEffect1029ui_story = var_162_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_3 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.characterEffect1029ui_story and not isNil(var_162_2) then
					arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_3)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect1029ui_story then
				arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_162_4 = 0
			local var_162_5 = 0.75

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(121561039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 30 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 30)

				if (30 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 30)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561039", "story_v_out_121561.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561039", "story_v_out_121561.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_121561", "121561039", "story_v_out_121561.awb")

						arg_159_1:RecordAudio("121561039", var_162_11)
						arg_159_1:RecordAudio("121561039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121561", "121561039", "story_v_out_121561.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121561", "121561039", "story_v_out_121561.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121561040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121561040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121561041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1076ui_story"]) and arg_163_1.var_.characterEffect1076ui_story == nil then
				arg_163_1.var_.characterEffect1076ui_story = arg_163_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1076ui_story"]) then
				if arg_163_1.var_.characterEffect1076ui_story and not isNil(arg_163_1.actors_["1076ui_story"]) then
					arg_163_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1076ui_story"]) and arg_163_1.var_.characterEffect1076ui_story then
				arg_163_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(121561040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 29 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 29)

				if (29 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 29)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121561041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121561041
		arg_167_1.duration_ = 3

		local var_167_0 = {
			ja = 3,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_167_0:Play121561042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1076ui_story"]) and arg_167_1.var_.characterEffect1076ui_story == nil then
				arg_167_1.var_.characterEffect1076ui_story = arg_167_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1076ui_story"]) then
				if arg_167_1.var_.characterEffect1076ui_story and not isNil(arg_167_1.actors_["1076ui_story"]) then
					arg_167_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1076ui_story"]) and arg_167_1.var_.characterEffect1076ui_story then
				arg_167_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_170_2 = 0
			local var_170_3 = 0.125

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(121561041)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 5 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 5)

				if (5 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 5)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561041", "story_v_out_121561.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561041", "story_v_out_121561.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_121561", "121561041", "story_v_out_121561.awb")

						arg_167_1:RecordAudio("121561041", var_170_9)
						arg_167_1:RecordAudio("121561041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121561", "121561041", "story_v_out_121561.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121561", "121561041", "story_v_out_121561.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121561042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121561042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121561043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1029ui_story = arg_171_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1029ui_story"].transform.position).z)
				arg_171_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1029ui_story"].transform.localEulerAngles = arg_171_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1029ui_story"].transform.position).z)
				arg_171_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1029ui_story"].transform.localEulerAngles = arg_171_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1076ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1076ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, 100, 0)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = 0
			local var_174_4 = 1.425

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(121561042).content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 57 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 57)

				if (57 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 57)) > 0 and var_174_4 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_8 and arg_171_1.time_ < var_174_3 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play121561043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121561043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121561044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.975

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(121561043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 39 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 39)

				if (39 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 39)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121561044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121561044
		arg_179_1.duration_ = 4.23

		local var_179_0 = {
			ja = 3.1,
			ko = 4.233,
			zh = 4.233
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play121561045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1029ui_story = arg_179_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1029ui_story"].transform.position).z)
				arg_179_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1029ui_story"].transform.localEulerAngles = arg_179_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_179_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1029ui_story"].transform.position).z)
				arg_179_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1029ui_story"].transform.localEulerAngles = arg_179_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1029ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1029ui_story == nil then
				arg_179_1.var_.characterEffect1029ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1029ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1029ui_story then
				arg_179_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.125

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(121561044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 5 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 5)

				if (5 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 5)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561044", "story_v_out_121561.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561044", "story_v_out_121561.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_121561", "121561044", "story_v_out_121561.awb")

						arg_179_1:RecordAudio("121561044", var_182_11)
						arg_179_1:RecordAudio("121561044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_121561", "121561044", "story_v_out_121561.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_121561", "121561044", "story_v_out_121561.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play121561045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121561045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121561046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1029ui_story = arg_183_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1029ui_story"].transform.position).z)
				arg_183_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1029ui_story"].transform.localEulerAngles = arg_183_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1029ui_story"].transform.position).z)
				arg_183_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1029ui_story"].transform.localEulerAngles = arg_183_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1029ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1029ui_story == nil then
				arg_183_1.var_.characterEffect1029ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1029ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_2)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1029ui_story then
				arg_183_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_186_3 = 0
			local var_186_4 = 1.575

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(121561045).content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 63 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 63)

				if (63 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 63)) > 0 and var_186_4 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_8 and arg_183_1.time_ < var_186_3 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play121561046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121561046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121561047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.3

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

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(121561046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 52 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 52)

				if (52 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 52)) > 0 and var_190_0 < var_190_3 then
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
	Play121561047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121561047
		arg_191_1.duration_ = 4.7

		local var_191_0 = {
			ja = 4.7,
			ko = 4.2,
			zh = 4.2
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
				arg_191_0:Play121561048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1029ui_story = arg_191_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1029ui_story"].transform.position).z)
				arg_191_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1029ui_story"].transform.localEulerAngles = arg_191_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_191_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1029ui_story"].transform.position).z)
				arg_191_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1029ui_story"].transform.localEulerAngles = arg_191_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1029ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1029ui_story == nil then
				arg_191_1.var_.characterEffect1029ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1029ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1029ui_story then
				arg_191_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.35

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(121561047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 14 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 14)

				if (14 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 14)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561047", "story_v_out_121561.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561047", "story_v_out_121561.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_121561", "121561047", "story_v_out_121561.awb")

						arg_191_1:RecordAudio("121561047", var_194_11)
						arg_191_1:RecordAudio("121561047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121561", "121561047", "story_v_out_121561.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121561", "121561047", "story_v_out_121561.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play121561048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121561048
		arg_195_1.duration_ = 5.1

		local var_195_0 = {
			ja = 4.133,
			ko = 5.1,
			zh = 5.1
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
				arg_195_0:Play121561049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_198_0 = 0
			local var_198_1 = 0.3

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(121561048)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 12 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 12)

				if (12 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 12)) > 0 and var_198_1 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561048", "story_v_out_121561.awb") ~= 0 then
					local var_198_6 = manager.audio:GetVoiceLength("story_v_out_121561", "121561048", "story_v_out_121561.awb") / 1000

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end

					if var_198_2.prefab_name ~= "" and arg_195_1.actors_[var_198_2.prefab_name] ~= nil then
						local var_198_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_2.prefab_name].transform, "story_v_out_121561", "121561048", "story_v_out_121561.awb")

						arg_195_1:RecordAudio("121561048", var_198_7)
						arg_195_1:RecordAudio("121561048", var_198_7)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121561", "121561048", "story_v_out_121561.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121561", "121561048", "story_v_out_121561.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121561049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121561049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play121561050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1029ui_story"]) and arg_199_1.var_.characterEffect1029ui_story == nil then
				arg_199_1.var_.characterEffect1029ui_story = arg_199_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1029ui_story"]) then
				if arg_199_1.var_.characterEffect1029ui_story and not isNil(arg_199_1.actors_["1029ui_story"]) then
					arg_199_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1029ui_story"]) and arg_199_1.var_.characterEffect1029ui_story then
				arg_199_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.95

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

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(121561049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 38 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 38)

				if (38 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 38)) > 0 and var_202_2 < var_202_5 then
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
	Play121561050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121561050
		arg_203_1.duration_ = 7.33

		local var_203_0 = {
			ja = 7.333,
			ko = 6.966,
			zh = 6.966
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
				arg_203_0:Play121561051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1029ui_story"]) and arg_203_1.var_.characterEffect1029ui_story == nil then
				arg_203_1.var_.characterEffect1029ui_story = arg_203_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1029ui_story"]) then
				if arg_203_1.var_.characterEffect1029ui_story and not isNil(arg_203_1.actors_["1029ui_story"]) then
					arg_203_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1029ui_story"]) and arg_203_1.var_.characterEffect1029ui_story then
				arg_203_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_2 = 0
			local var_206_3 = 0.6

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(121561050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 24 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 24)

				if (24 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 24)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561050", "story_v_out_121561.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561050", "story_v_out_121561.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_121561", "121561050", "story_v_out_121561.awb")

						arg_203_1:RecordAudio("121561050", var_206_9)
						arg_203_1:RecordAudio("121561050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121561", "121561050", "story_v_out_121561.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121561", "121561050", "story_v_out_121561.awb")
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
	Play121561051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121561051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121561052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1029ui_story = arg_207_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1029ui_story"].transform.position).z)
				arg_207_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1029ui_story"].transform.localEulerAngles = arg_207_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1029ui_story"].transform.position).z)
				arg_207_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1029ui_story"].transform.localEulerAngles = arg_207_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1029ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1029ui_story == nil then
				arg_207_1.var_.characterEffect1029ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1029ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1029ui_story then
				arg_207_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_spacein", "")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_210_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_6 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_6

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_6
						arg_207_1.bgmTxt2_.text = var_210_6
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_final_loop", "")
			end

			local var_210_8 = 0
			local var_210_9 = 1.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(121561051).content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_12 = 59 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_10) / 59)

				if (59 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_10) / 59)) > 0 and var_210_9 < var_210_12 then
					arg_207_1.talkMaxDuration = var_210_12

					if var_210_12 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_13 and arg_207_1.time_ < var_210_8 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play121561052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 121561052
		arg_212_1.duration_ = 9

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play121561053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if arg_212_1.bgs_.J10i == nil then
				local var_215_0 = Object.Instantiate(arg_212_1.paintGo_)

				var_215_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J10i")
				var_215_0.name = "J10i"
				var_215_0.transform.parent = arg_212_1.stage_.transform
				var_215_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.bgs_.J10i = var_215_0
			end

			if 2 < arg_212_1.time_ and arg_212_1.time_ <= 2 + arg_215_0 then
				local var_215_1 = arg_212_1.bgs_.J10i

				arg_212_1.bgs_.J10i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_215_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_215_2 = var_215_1:GetComponent("SpriteRenderer")

				if var_215_2 and var_215_2.sprite then
					local var_215_3 = 2 * (var_215_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_215_1.transform.localScale = Vector3.New(var_215_3 / var_215_2.sprite.bounds.size.y < var_215_3 * manager.ui.mainCameraCom_.aspect / var_215_2.sprite.bounds.size.x and var_215_3 * manager.ui.mainCameraCom_.aspect / var_215_2.sprite.bounds.size.x or var_215_3 / var_215_2.sprite.bounds.size.y, var_215_3 / var_215_2.sprite.bounds.size.y < var_215_3 * manager.ui.mainCameraCom_.aspect / var_215_2.sprite.bounds.size.x and var_215_3 * manager.ui.mainCameraCom_.aspect / var_215_2.sprite.bounds.size.x or var_215_3 / var_215_2.sprite.bounds.size.y, 0)
				end

				for iter_215_0, iter_215_1 in pairs(arg_212_1.bgs_) do
					if iter_215_0 ~= "J10i" then
						iter_215_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_215_4 = 0

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.mask_.enabled = true
				arg_212_1.mask_.raycastTarget = true

				arg_212_1:SetGaussion(false)
			end

			local var_215_5 = 2

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_5 then
				local var_215_6 = Color.New(0, 0, 0)

				var_215_6.a = Mathf.Lerp(0, 1, (arg_212_1.time_ - var_215_4) / var_215_5)
				arg_212_1.mask_.color = var_215_6
			end

			if arg_212_1.time_ >= var_215_4 + var_215_5 and arg_212_1.time_ < var_215_4 + var_215_5 + arg_215_0 then
				local var_215_7 = Color.New(0, 0, 0)

				var_215_7.a = 1
				arg_212_1.mask_.color = var_215_7
			end

			local var_215_8 = 2

			if 2 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.mask_.enabled = true
				arg_212_1.mask_.raycastTarget = true

				arg_212_1:SetGaussion(false)
			end

			local var_215_9 = 2

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_9 then
				local var_215_10 = Color.New(0, 0, 0)

				var_215_10.a = Mathf.Lerp(1, 0, (arg_212_1.time_ - var_215_8) / var_215_9)
				arg_212_1.mask_.color = var_215_10
			end

			if arg_212_1.time_ >= var_215_8 + var_215_9 and arg_212_1.time_ < var_215_8 + var_215_9 + arg_215_0 then
				local var_215_11 = Color.New(0, 0, 0)

				arg_212_1.mask_.enabled = false
				var_215_11.a = 0
				arg_212_1.mask_.color = var_215_11
			end

			if 2 < arg_212_1.time_ and arg_212_1.time_ <= 2 + arg_215_0 then
				arg_212_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_harbor_loop", "")
			end

			if arg_212_1.frameCnt_ <= 1 then
				arg_212_1.dialog_:SetActive(false)
			end

			local var_215_13 = 4
			local var_215_14 = 0.25

			if 4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_13 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0

				arg_212_1.dialog_:SetActive(true)

				arg_212_1.dialogCg_.alpha = 0

				local var_215_15 = LeanTween.value(arg_212_1.dialog_, 0, 1, 0.3)

				var_215_15:setOnUpdate(LuaHelper.FloatAction(function(arg_216_0)
					arg_212_1.dialogCg_.alpha = arg_216_0
				end))
				var_215_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_212_1.dialog_)
					var_215_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_212_1.duration_ = arg_212_1.duration_ + 0.3

				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_16 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(121561052).content)

				arg_212_1.text_.text = var_215_16

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_18 = 10 <= 0 and var_215_14 or var_215_14 * (utf8.len(var_215_16) / 10)

				if (10 <= 0 and var_215_14 or var_215_14 * (utf8.len(var_215_16) / 10)) > 0 and var_215_14 < var_215_18 then
					arg_212_1.talkMaxDuration = var_215_18
					var_215_13 = var_215_13 + 0.3

					if var_215_18 + var_215_13 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_18 + var_215_13
					end
				end

				arg_212_1.text_.text = var_215_16
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_19 = var_215_13 + 0.3
			local var_215_20 = math.max(var_215_14, arg_212_1.talkMaxDuration)

			if var_215_13 + 0.3 <= arg_212_1.time_ and arg_212_1.time_ < var_215_19 + var_215_20 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_19) / var_215_20

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_19 + var_215_20 and arg_212_1.time_ < var_215_19 + var_215_20 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play121561053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 121561053
		arg_218_1.duration_ = 3.83

		local var_218_0 = {
			ja = 3.833,
			ko = 2.566,
			zh = 2.566
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
				arg_218_0:Play121561054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if arg_218_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_221_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_218_1.stage_.transform)

				var_221_0.name = "1184ui_story"
				var_221_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1184ui_story"] = var_221_0

				local var_221_1 = var_221_0:GetComponentInChildren(typeof(CharacterEffect))

				var_221_1.enabled = true

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end

				arg_218_1:ShowWeapon(var_221_1.transform, false)

				arg_218_1.var_["1184ui_story" .. "Animator"] = var_221_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_218_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_218_1.var_["1184ui_story" .. "LipSync"] = var_221_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_221_3 = arg_218_1.actors_["1184ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1184ui_story = var_221_3.localPosition
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_3.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_218_1.time_ - 0) / var_221_4)
				var_221_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_3.position).x, (manager.ui.mainCamera.transform.position - var_221_3.position).y, (manager.ui.mainCamera.transform.position - var_221_3.position).z)
				var_221_3.localEulerAngles.z = 0
				var_221_3.localEulerAngles.x = 0
				var_221_3.localEulerAngles = var_221_3.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_3.localPosition = Vector3.New(0, -0.97, -6)
				var_221_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_3.position).x, (manager.ui.mainCamera.transform.position - var_221_3.position).y, (manager.ui.mainCamera.transform.position - var_221_3.position).z)
				var_221_3.localEulerAngles.z = 0
				var_221_3.localEulerAngles.x = 0
				var_221_3.localEulerAngles = var_221_3.localEulerAngles
			end

			local var_221_5 = arg_218_1.actors_["1184ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1184ui_story == nil then
				arg_218_1.var_.characterEffect1184ui_story = var_221_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_6 and not isNil(var_221_5) then
				if arg_218_1.var_.characterEffect1184ui_story and not isNil(var_221_5) then
					arg_218_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_6 and arg_218_1.time_ < 0 + var_221_6 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1184ui_story then
				arg_218_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:AudioAction("play", "music", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_221_10 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if "" ~= "" then
					if arg_218_1.bgmTxt_.text ~= var_221_10 and arg_218_1.bgmTxt_.text ~= "" then
						if arg_218_1.bgmTxt2_.text ~= "" then
							arg_218_1.bgmTxt_.text = arg_218_1.bgmTxt2_.text
						end

						arg_218_1.bgmTxt2_.text = var_221_10

						arg_218_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_218_1.bgmTxt_.text = var_221_10
						arg_218_1.bgmTxt2_.text = var_221_10
					end

					if arg_218_1.bgmTimer then
						arg_218_1.bgmTimer:Stop()

						arg_218_1.bgmTimer = nil
					end

					if arg_218_1.settingData.show_music_name == 1 then
						arg_218_1.musicController:SetSelectedState("show")
						arg_218_1.musicAnimator_:Play("open", 0, 0)

						if arg_218_1.settingData.music_time ~= 0 then
							arg_218_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_218_1.settingData.music_time), function()
								if arg_218_1 == nil or isNil(arg_218_1.bgmTxt_) then
									return
								end

								arg_218_1.musicController:SetSelectedState("hide")
								arg_218_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_221_11 = 0
			local var_221_12 = 0.325

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_13 = arg_218_1:GetWordFromCfg(121561053)
				local var_221_14 = arg_218_1:FormatText(var_221_13.content)

				arg_218_1.text_.text = var_221_14

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_16 = 13 <= 0 and var_221_12 or var_221_12 * (utf8.len(var_221_14) / 13)

				if (13 <= 0 and var_221_12 or var_221_12 * (utf8.len(var_221_14) / 13)) > 0 and var_221_12 < var_221_16 then
					arg_218_1.talkMaxDuration = var_221_16

					if var_221_16 + var_221_11 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_16 + var_221_11
					end
				end

				arg_218_1.text_.text = var_221_14
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561053", "story_v_out_121561.awb") ~= 0 then
					local var_221_17 = manager.audio:GetVoiceLength("story_v_out_121561", "121561053", "story_v_out_121561.awb") / 1000

					if var_221_17 + var_221_11 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_17 + var_221_11
					end

					if var_221_13.prefab_name ~= "" and arg_218_1.actors_[var_221_13.prefab_name] ~= nil then
						local var_221_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_13.prefab_name].transform, "story_v_out_121561", "121561053", "story_v_out_121561.awb")

						arg_218_1:RecordAudio("121561053", var_221_18)
						arg_218_1:RecordAudio("121561053", var_221_18)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_121561", "121561053", "story_v_out_121561.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_121561", "121561053", "story_v_out_121561.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_19 = math.max(var_221_12, arg_218_1.talkMaxDuration)

			if var_221_11 <= arg_218_1.time_ and arg_218_1.time_ < var_221_11 + var_221_19 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_11) / var_221_19

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_11 + var_221_19 and arg_218_1.time_ < var_221_11 + var_221_19 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play121561054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121561054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play121561055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1184ui_story"]) and arg_223_1.var_.characterEffect1184ui_story == nil then
				arg_223_1.var_.characterEffect1184ui_story = arg_223_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1184ui_story"]) then
				if arg_223_1.var_.characterEffect1184ui_story and not isNil(arg_223_1.actors_["1184ui_story"]) then
					arg_223_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1184ui_story"]) and arg_223_1.var_.characterEffect1184ui_story then
				arg_223_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.375

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
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

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(121561054).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 15 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 15)

				if (15 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 15)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play121561055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121561055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play121561056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1184ui_story = arg_227_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1184ui_story"].transform.position).z)
				arg_227_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1184ui_story"].transform.localEulerAngles = arg_227_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1184ui_story"].transform.position).z)
				arg_227_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1184ui_story"].transform.localEulerAngles = arg_227_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1184ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1184ui_story == nil then
				arg_227_1.var_.characterEffect1184ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1184ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_2)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1184ui_story then
				arg_227_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_230_3 = 0
			local var_230_4 = 0.625

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

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(121561055).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 25 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 25)

				if (25 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 25)) > 0 and var_230_4 < var_230_7 then
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
				actorName = "1184ui_story",
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
	Play121561056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121561056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play121561057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 1.75

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(121561056).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 70 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 70)

				if (70 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 70)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play121561057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121561057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play121561058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.075

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(121561057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 43 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 43)

				if (43 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 43)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play121561058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 121561058
		arg_239_1.duration_ = 5.03

		local var_239_0 = {
			ja = 5.033,
			ko = 5,
			zh = 5
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
				arg_239_0:Play121561059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1184ui_story = arg_239_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1184ui_story"].transform.position).z)
				arg_239_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1184ui_story"].transform.localEulerAngles = arg_239_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_239_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1184ui_story"].transform.position).z)
				arg_239_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1184ui_story"].transform.localEulerAngles = arg_239_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1184ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1184ui_story == nil then
				arg_239_1.var_.characterEffect1184ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1184ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1184ui_story then
				arg_239_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_4 = 0
			local var_242_5 = 0.4

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(121561058)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 16 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 16)

				if (16 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 16)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561058", "story_v_out_121561.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561058", "story_v_out_121561.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_121561", "121561058", "story_v_out_121561.awb")

						arg_239_1:RecordAudio("121561058", var_242_11)
						arg_239_1:RecordAudio("121561058", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_121561", "121561058", "story_v_out_121561.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_121561", "121561058", "story_v_out_121561.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play121561059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 121561059
		arg_243_1.duration_ = 4.43

		local var_243_0 = {
			ja = 4.433,
			ko = 2.8,
			zh = 2.8
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
				arg_243_0:Play121561060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_0 = 0
			local var_246_1 = 0.375

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(121561059)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 15 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 15)

				if (15 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 15)) > 0 and var_246_1 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561059", "story_v_out_121561.awb") ~= 0 then
					local var_246_6 = manager.audio:GetVoiceLength("story_v_out_121561", "121561059", "story_v_out_121561.awb") / 1000

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end

					if var_246_2.prefab_name ~= "" and arg_243_1.actors_[var_246_2.prefab_name] ~= nil then
						local var_246_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_2.prefab_name].transform, "story_v_out_121561", "121561059", "story_v_out_121561.awb")

						arg_243_1:RecordAudio("121561059", var_246_7)
						arg_243_1:RecordAudio("121561059", var_246_7)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_121561", "121561059", "story_v_out_121561.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_121561", "121561059", "story_v_out_121561.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play121561060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 121561060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play121561061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1184ui_story"]) and arg_247_1.var_.characterEffect1184ui_story == nil then
				arg_247_1.var_.characterEffect1184ui_story = arg_247_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1184ui_story"]) then
				if arg_247_1.var_.characterEffect1184ui_story and not isNil(arg_247_1.actors_["1184ui_story"]) then
					arg_247_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1184ui_story"]) and arg_247_1.var_.characterEffect1184ui_story then
				arg_247_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.975

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(121561060).content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 39 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 39)

				if (39 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 39)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_6 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_6 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_6

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_6 and arg_247_1.time_ < var_250_1 + var_250_6 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play121561061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 121561061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play121561062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.125

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(121561061).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 45 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 45)

				if (45 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 45)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play121561062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 121561062
		arg_255_1.duration_ = 3.63

		local var_255_0 = {
			ja = 2.166,
			ko = 3.633,
			zh = 3.633
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
				arg_255_0:Play121561063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.375

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(121561062)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 15 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 15)

				if (15 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 15)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561062", "story_v_out_121561.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561062", "story_v_out_121561.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_121561", "121561062", "story_v_out_121561.awb")

						arg_255_1:RecordAudio("121561062", var_258_6)
						arg_255_1:RecordAudio("121561062", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_121561", "121561062", "story_v_out_121561.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_121561", "121561062", "story_v_out_121561.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play121561063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 121561063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play121561064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1184ui_story = arg_259_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1184ui_story"].transform.position).z)
				arg_259_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1184ui_story"].transform.localEulerAngles = arg_259_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1184ui_story"].transform.position).z)
				arg_259_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1184ui_story"].transform.localEulerAngles = arg_259_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1184ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1184ui_story == nil then
				arg_259_1.var_.characterEffect1184ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1184ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_2)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1184ui_story then
				arg_259_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_262_3 = "1071ui_story"

			if arg_259_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_262_4 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_259_1.stage_.transform)

				var_262_4.name = var_262_3
				var_262_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_[var_262_3] = var_262_4

				local var_262_5 = var_262_4:GetComponentInChildren(typeof(CharacterEffect))

				var_262_5.enabled = true

				local var_262_6 = GameObjectTools.GetOrAddComponent(var_262_4, typeof(DynamicBoneHelper))

				if var_262_6 then
					var_262_6:EnableDynamicBone(false)
				end

				arg_259_1:ShowWeapon(var_262_5.transform, false)

				arg_259_1.var_[var_262_3 .. "Animator"] = var_262_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_259_1.var_[var_262_3 .. "Animator"].applyRootMotion = true
				arg_259_1.var_[var_262_3 .. "LipSync"] = var_262_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_262_7 = 0
			local var_262_8 = 1.1

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_7 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_9 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(121561063).content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 44 <= 0 and var_262_8 or var_262_8 * (utf8.len(var_262_9) / 44)

				if (44 <= 0 and var_262_8 or var_262_8 * (utf8.len(var_262_9) / 44)) > 0 and var_262_8 < var_262_11 then
					arg_259_1.talkMaxDuration = var_262_11

					if var_262_11 + var_262_7 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_7
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_8, arg_259_1.talkMaxDuration)

			if var_262_7 <= arg_259_1.time_ and arg_259_1.time_ < var_262_7 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_7) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_7 + var_262_12 and arg_259_1.time_ < var_262_7 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play121561064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 121561064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play121561065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1071ui_story = arg_263_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1071ui_story"].transform.position).z)
				arg_263_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1071ui_story"].transform.localEulerAngles = arg_263_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_263_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1071ui_story"].transform.position).z)
				arg_263_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1071ui_story"].transform.localEulerAngles = arg_263_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1071ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1071ui_story == nil then
				arg_263_1.var_.characterEffect1071ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1071ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_2)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1071ui_story then
				arg_263_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_266_3 = 0
			local var_266_4 = 0.875

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_5 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(121561064).content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 35 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 35)

				if (35 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 35)) > 0 and var_266_4 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_3
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_4, arg_263_1.talkMaxDuration)

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_3) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_3 + var_266_8 and arg_263_1.time_ < var_266_3 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play121561065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 121561065
		arg_267_1.duration_ = 12.97

		local var_267_0 = {
			ja = 12.966,
			ko = 9.933,
			zh = 9.933
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
				arg_267_0:Play121561066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1071ui_story"]) and arg_267_1.var_.characterEffect1071ui_story == nil then
				arg_267_1.var_.characterEffect1071ui_story = arg_267_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1071ui_story"]) then
				if arg_267_1.var_.characterEffect1071ui_story and not isNil(arg_267_1.actors_["1071ui_story"]) then
					arg_267_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1071ui_story"]) and arg_267_1.var_.characterEffect1071ui_story then
				arg_267_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_270_2 = 0
			local var_270_3 = 1.3

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_4 = arg_267_1:GetWordFromCfg(121561065)
				local var_270_5 = arg_267_1:FormatText(var_270_4.content)

				arg_267_1.text_.text = var_270_5

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 52 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_5) / 52)

				if (52 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_5) / 52)) > 0 and var_270_3 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_5
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561065", "story_v_out_121561.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561065", "story_v_out_121561.awb") / 1000

					if var_270_8 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_2
					end

					if var_270_4.prefab_name ~= "" and arg_267_1.actors_[var_270_4.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_4.prefab_name].transform, "story_v_out_121561", "121561065", "story_v_out_121561.awb")

						arg_267_1:RecordAudio("121561065", var_270_9)
						arg_267_1:RecordAudio("121561065", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_121561", "121561065", "story_v_out_121561.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_121561", "121561065", "story_v_out_121561.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_10 and arg_267_1.time_ < var_270_2 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play121561066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 121561066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play121561067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1071ui_story"]) and arg_271_1.var_.characterEffect1071ui_story == nil then
				arg_271_1.var_.characterEffect1071ui_story = arg_271_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1071ui_story"]) then
				if arg_271_1.var_.characterEffect1071ui_story and not isNil(arg_271_1.actors_["1071ui_story"]) then
					arg_271_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1071ui_story"]) and arg_271_1.var_.characterEffect1071ui_story then
				arg_271_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_274_1 = 0
			local var_274_2 = 0.225

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(121561066).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 9 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 9)

				if (9 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 9)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play121561067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 121561067
		arg_275_1.duration_ = 10.73

		local var_275_0 = {
			ja = 10.733,
			ko = 7.6,
			zh = 7.6
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
				arg_275_0:Play121561068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1071ui_story"]) and arg_275_1.var_.characterEffect1071ui_story == nil then
				arg_275_1.var_.characterEffect1071ui_story = arg_275_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1071ui_story"]) then
				if arg_275_1.var_.characterEffect1071ui_story and not isNil(arg_275_1.actors_["1071ui_story"]) then
					arg_275_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1071ui_story"]) and arg_275_1.var_.characterEffect1071ui_story then
				arg_275_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_278_2 = 0
			local var_278_3 = 0.925

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(121561067)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 37 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 37)

				if (37 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 37)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561067", "story_v_out_121561.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561067", "story_v_out_121561.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_out_121561", "121561067", "story_v_out_121561.awb")

						arg_275_1:RecordAudio("121561067", var_278_9)
						arg_275_1:RecordAudio("121561067", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_121561", "121561067", "story_v_out_121561.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_121561", "121561067", "story_v_out_121561.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play121561068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 121561068
		arg_279_1.duration_ = 6.23

		local var_279_0 = {
			ja = 6.233,
			ko = 5.1,
			zh = 5.1
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
				arg_279_0:Play121561069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_282_0 = 0
			local var_282_1 = 0.65

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(121561068)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 26 <= 0 and var_282_1 or var_282_1 * (utf8.len(var_282_3) / 26)

				if (26 <= 0 and var_282_1 or var_282_1 * (utf8.len(var_282_3) / 26)) > 0 and var_282_1 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561068", "story_v_out_121561.awb") ~= 0 then
					local var_282_6 = manager.audio:GetVoiceLength("story_v_out_121561", "121561068", "story_v_out_121561.awb") / 1000

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end

					if var_282_2.prefab_name ~= "" and arg_279_1.actors_[var_282_2.prefab_name] ~= nil then
						local var_282_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_2.prefab_name].transform, "story_v_out_121561", "121561068", "story_v_out_121561.awb")

						arg_279_1:RecordAudio("121561068", var_282_7)
						arg_279_1:RecordAudio("121561068", var_282_7)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_121561", "121561068", "story_v_out_121561.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_121561", "121561068", "story_v_out_121561.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_8 and arg_279_1.time_ < var_282_0 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play121561069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 121561069
		arg_283_1.duration_ = 9.67

		local var_283_0 = {
			ja = 9.666,
			ko = 6.166,
			zh = 6.166
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
				arg_283_0:Play121561070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1071ui_story = arg_283_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).z)
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles = arg_283_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_283_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1071ui_story"].transform.position).z)
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1071ui_story"].transform.localEulerAngles = arg_283_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1071ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1071ui_story == nil then
				arg_283_1.var_.characterEffect1071ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1071ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_2)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1071ui_story then
				arg_283_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_286_3 = arg_283_1.actors_["1184ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1184ui_story = var_286_3.localPosition
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_3.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_283_1.time_ - 0) / var_286_4)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			local var_286_5 = arg_283_1.actors_["1184ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect1184ui_story == nil then
				arg_283_1.var_.characterEffect1184ui_story = var_286_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_6 and not isNil(var_286_5) then
				if arg_283_1.var_.characterEffect1184ui_story and not isNil(var_286_5) then
					arg_283_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_6 and arg_283_1.time_ < 0 + var_286_6 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect1184ui_story then
				arg_283_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_8 = 0
			local var_286_9 = 0.95

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(121561069)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 38 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 38)

				if (38 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 38)) > 0 and var_286_9 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561069", "story_v_out_121561.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_121561", "121561069", "story_v_out_121561.awb") / 1000

					if var_286_14 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_8
					end

					if var_286_10.prefab_name ~= "" and arg_283_1.actors_[var_286_10.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_10.prefab_name].transform, "story_v_out_121561", "121561069", "story_v_out_121561.awb")

						arg_283_1:RecordAudio("121561069", var_286_15)
						arg_283_1:RecordAudio("121561069", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_121561", "121561069", "story_v_out_121561.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_121561", "121561069", "story_v_out_121561.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play121561070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 121561070
		arg_287_1.duration_ = 7.3

		local var_287_0 = {
			ja = 6.066,
			ko = 7.3,
			zh = 7.3
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
				arg_287_0:Play121561071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1071ui_story"]) and arg_287_1.var_.characterEffect1071ui_story == nil then
				arg_287_1.var_.characterEffect1071ui_story = arg_287_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1071ui_story"]) then
				if arg_287_1.var_.characterEffect1071ui_story and not isNil(arg_287_1.actors_["1071ui_story"]) then
					arg_287_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1071ui_story"]) and arg_287_1.var_.characterEffect1071ui_story then
				arg_287_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_290_2 = arg_287_1.actors_["1184ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.characterEffect1184ui_story == nil then
				arg_287_1.var_.characterEffect1184ui_story = var_290_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_3 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.characterEffect1184ui_story and not isNil(var_290_2) then
					arg_287_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_3)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.characterEffect1184ui_story then
				arg_287_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_290_4 = 0
			local var_290_5 = 0.475

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(121561070)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 19 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 19)

				if (19 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 19)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561070", "story_v_out_121561.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561070", "story_v_out_121561.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_121561", "121561070", "story_v_out_121561.awb")

						arg_287_1:RecordAudio("121561070", var_290_11)
						arg_287_1:RecordAudio("121561070", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_121561", "121561070", "story_v_out_121561.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_121561", "121561070", "story_v_out_121561.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play121561071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 121561071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play121561072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1071ui_story = arg_291_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1071ui_story"].transform.position).z)
				arg_291_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1071ui_story"].transform.localEulerAngles = arg_291_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1071ui_story"].transform.position).z)
				arg_291_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1071ui_story"].transform.localEulerAngles = arg_291_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1184ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1184ui_story = var_294_1.localPosition
			end

			local var_294_2 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 then
				var_294_1.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_2)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 then
				var_294_1.localPosition = Vector3.New(0, 100, 0)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			local var_294_3 = 0
			local var_294_4 = 0.975

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_3 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_5 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(121561071).content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 39 <= 0 and var_294_4 or var_294_4 * (utf8.len(var_294_5) / 39)

				if (39 <= 0 and var_294_4 or var_294_4 * (utf8.len(var_294_5) / 39)) > 0 and var_294_4 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_3 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_3
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_4, arg_291_1.talkMaxDuration)

			if var_294_3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_3 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_3) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_3 + var_294_8 and arg_291_1.time_ < var_294_3 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play121561072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 121561072
		arg_295_1.duration_ = 3.63

		local var_295_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play121561073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1184ui_story = arg_295_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1184ui_story"].transform.position).z)
				arg_295_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1184ui_story"].transform.localEulerAngles = arg_295_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_295_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1184ui_story"].transform.position).z)
				arg_295_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1184ui_story"].transform.localEulerAngles = arg_295_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1184ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1184ui_story == nil then
				arg_295_1.var_.characterEffect1184ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1184ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1184ui_story then
				arg_295_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.225

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(121561072)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 9 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 9)

				if (9 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 9)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561072", "story_v_out_121561.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561072", "story_v_out_121561.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_121561", "121561072", "story_v_out_121561.awb")

						arg_295_1:RecordAudio("121561072", var_298_11)
						arg_295_1:RecordAudio("121561072", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_121561", "121561072", "story_v_out_121561.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_121561", "121561072", "story_v_out_121561.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play121561073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 121561073
		arg_299_1.duration_ = 10.1

		local var_299_0 = {
			ja = 7.333,
			ko = 10.1,
			zh = 10.1
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
				arg_299_0:Play121561074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1071ui_story = arg_299_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1071ui_story"].transform.position).z)
				arg_299_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1071ui_story"].transform.localEulerAngles = arg_299_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_299_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1071ui_story"].transform.position).z)
				arg_299_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1071ui_story"].transform.localEulerAngles = arg_299_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1071ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1071ui_story == nil then
				arg_299_1.var_.characterEffect1071ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1071ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1071ui_story then
				arg_299_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_302_4 = arg_299_1.actors_["1184ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect1184ui_story == nil then
				arg_299_1.var_.characterEffect1184ui_story = var_302_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_5 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_5 and not isNil(var_302_4) then
				if arg_299_1.var_.characterEffect1184ui_story and not isNil(var_302_4) then
					arg_299_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_5)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_5 and arg_299_1.time_ < 0 + var_302_5 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect1184ui_story then
				arg_299_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_302_6 = 0
			local var_302_7 = 1.15

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_8 = arg_299_1:GetWordFromCfg(121561073)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 46 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 46)

				if (46 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 46)) > 0 and var_302_7 < var_302_11 then
					arg_299_1.talkMaxDuration = var_302_11

					if var_302_11 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_9
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561073", "story_v_out_121561.awb") ~= 0 then
					local var_302_12 = manager.audio:GetVoiceLength("story_v_out_121561", "121561073", "story_v_out_121561.awb") / 1000

					if var_302_12 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_6
					end

					if var_302_8.prefab_name ~= "" and arg_299_1.actors_[var_302_8.prefab_name] ~= nil then
						local var_302_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_8.prefab_name].transform, "story_v_out_121561", "121561073", "story_v_out_121561.awb")

						arg_299_1:RecordAudio("121561073", var_302_13)
						arg_299_1:RecordAudio("121561073", var_302_13)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_121561", "121561073", "story_v_out_121561.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_121561", "121561073", "story_v_out_121561.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play121561074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 121561074
		arg_303_1.duration_ = 9.33

		local var_303_0 = {
			ja = 9.333,
			ko = 8.5,
			zh = 8.5
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play121561075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.125

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(121561074)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 45 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 45)

				if (45 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 45)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561074", "story_v_out_121561.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_121561", "121561074", "story_v_out_121561.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_121561", "121561074", "story_v_out_121561.awb")

						arg_303_1:RecordAudio("121561074", var_306_6)
						arg_303_1:RecordAudio("121561074", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_121561", "121561074", "story_v_out_121561.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_121561", "121561074", "story_v_out_121561.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play121561075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 121561075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play121561076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1071ui_story"]) and arg_307_1.var_.characterEffect1071ui_story == nil then
				arg_307_1.var_.characterEffect1071ui_story = arg_307_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1071ui_story"]) then
				if arg_307_1.var_.characterEffect1071ui_story and not isNil(arg_307_1.actors_["1071ui_story"]) then
					arg_307_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1071ui_story"]) and arg_307_1.var_.characterEffect1071ui_story then
				arg_307_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.5

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(121561075).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 20 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 20)

				if (20 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 20)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play121561076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 121561076
		arg_311_1.duration_ = 11.5

		local var_311_0 = {
			ja = 11.5,
			ko = 8.833,
			zh = 8.833
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play121561077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1071ui_story"]) and arg_311_1.var_.characterEffect1071ui_story == nil then
				arg_311_1.var_.characterEffect1071ui_story = arg_311_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1071ui_story"]) then
				if arg_311_1.var_.characterEffect1071ui_story and not isNil(arg_311_1.actors_["1071ui_story"]) then
					arg_311_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1071ui_story"]) and arg_311_1.var_.characterEffect1071ui_story then
				arg_311_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_2 = 0
			local var_314_3 = 1.125

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_4 = arg_311_1:GetWordFromCfg(121561076)
				local var_314_5 = arg_311_1:FormatText(var_314_4.content)

				arg_311_1.text_.text = var_314_5

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_7 = 45 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 45)

				if (45 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 45)) > 0 and var_314_3 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_5
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561076", "story_v_out_121561.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561076", "story_v_out_121561.awb") / 1000

					if var_314_8 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_2
					end

					if var_314_4.prefab_name ~= "" and arg_311_1.actors_[var_314_4.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_4.prefab_name].transform, "story_v_out_121561", "121561076", "story_v_out_121561.awb")

						arg_311_1:RecordAudio("121561076", var_314_9)
						arg_311_1:RecordAudio("121561076", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_121561", "121561076", "story_v_out_121561.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_121561", "121561076", "story_v_out_121561.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_3, arg_311_1.talkMaxDuration)

			if var_314_2 <= arg_311_1.time_ and arg_311_1.time_ < var_314_2 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_2) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_2 + var_314_10 and arg_311_1.time_ < var_314_2 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play121561077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 121561077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play121561078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1071ui_story = arg_315_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1071ui_story"].transform.position).z)
				arg_315_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1071ui_story"].transform.localEulerAngles = arg_315_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_315_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1071ui_story"].transform.position).z)
				arg_315_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1071ui_story"].transform.localEulerAngles = arg_315_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1071ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1071ui_story == nil then
				arg_315_1.var_.characterEffect1071ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1071ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_2)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1071ui_story then
				arg_315_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_318_3 = arg_315_1.actors_["1184ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1184ui_story = var_318_3.localPosition
			end

			local var_318_4 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				var_318_3.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_4)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				var_318_3.localPosition = Vector3.New(0, 100, 0)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles
			end

			local var_318_5 = arg_315_1.actors_["1184ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.characterEffect1184ui_story == nil then
				arg_315_1.var_.characterEffect1184ui_story = var_318_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_6 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_6 and not isNil(var_318_5) then
				if arg_315_1.var_.characterEffect1184ui_story and not isNil(var_318_5) then
					arg_315_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_6)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_6 and arg_315_1.time_ < 0 + var_318_6 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.characterEffect1184ui_story then
				arg_315_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_318_7 = 0
			local var_318_8 = 0.575

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_7 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_9 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(121561077).content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 23 <= 0 and var_318_8 or var_318_8 * (utf8.len(var_318_9) / 23)

				if (23 <= 0 and var_318_8 or var_318_8 * (utf8.len(var_318_9) / 23)) > 0 and var_318_8 < var_318_11 then
					arg_315_1.talkMaxDuration = var_318_11

					if var_318_11 + var_318_7 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_7
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_8, arg_315_1.talkMaxDuration)

			if var_318_7 <= arg_315_1.time_ and arg_315_1.time_ < var_318_7 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_7) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_7 + var_318_12 and arg_315_1.time_ < var_318_7 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play121561078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 121561078
		arg_319_1.duration_ = 11.3

		local var_319_0 = {
			ja = 11.3,
			ko = 7.333,
			zh = 7.333
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
				arg_319_0:Play121561079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1071ui_story = arg_319_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1071ui_story"].transform.position).z)
				arg_319_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1071ui_story"].transform.localEulerAngles = arg_319_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_319_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1071ui_story"].transform.position).z)
				arg_319_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1071ui_story"].transform.localEulerAngles = arg_319_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1071ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1071ui_story == nil then
				arg_319_1.var_.characterEffect1071ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1071ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1071ui_story then
				arg_319_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_4 = arg_319_1.actors_["1184ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1184ui_story = var_322_4.localPosition
			end

			local var_322_5 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_5 then
				var_322_4.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_319_1.time_ - 0) / var_322_5)
				var_322_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_4.position).x, (manager.ui.mainCamera.transform.position - var_322_4.position).y, (manager.ui.mainCamera.transform.position - var_322_4.position).z)
				var_322_4.localEulerAngles.z = 0
				var_322_4.localEulerAngles.x = 0
				var_322_4.localEulerAngles = var_322_4.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_5 and arg_319_1.time_ < 0 + var_322_5 + arg_322_0 then
				var_322_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_322_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_4.position).x, (manager.ui.mainCamera.transform.position - var_322_4.position).y, (manager.ui.mainCamera.transform.position - var_322_4.position).z)
				var_322_4.localEulerAngles.z = 0
				var_322_4.localEulerAngles.x = 0
				var_322_4.localEulerAngles = var_322_4.localEulerAngles
			end

			local var_322_6 = arg_319_1.actors_["1184ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_6) and arg_319_1.var_.characterEffect1184ui_story == nil then
				arg_319_1.var_.characterEffect1184ui_story = var_322_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_7 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 and not isNil(var_322_6) then
				if arg_319_1.var_.characterEffect1184ui_story and not isNil(var_322_6) then
					arg_319_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_7)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 and not isNil(var_322_6) and arg_319_1.var_.characterEffect1184ui_story then
				arg_319_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_322_8 = 0
			local var_322_9 = 0.925

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(121561078)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 37 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 37)

				if (37 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 37)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561078", "story_v_out_121561.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_121561", "121561078", "story_v_out_121561.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_121561", "121561078", "story_v_out_121561.awb")

						arg_319_1:RecordAudio("121561078", var_322_15)
						arg_319_1:RecordAudio("121561078", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_121561", "121561078", "story_v_out_121561.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_121561", "121561078", "story_v_out_121561.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play121561079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 121561079
		arg_323_1.duration_ = 4.63

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play121561080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1184ui_story"]) and arg_323_1.var_.characterEffect1184ui_story == nil then
				arg_323_1.var_.characterEffect1184ui_story = arg_323_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1184ui_story"]) then
				if arg_323_1.var_.characterEffect1184ui_story and not isNil(arg_323_1.actors_["1184ui_story"]) then
					arg_323_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1184ui_story"]) and arg_323_1.var_.characterEffect1184ui_story then
				arg_323_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_2 = arg_323_1.actors_["1071ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.characterEffect1071ui_story == nil then
				arg_323_1.var_.characterEffect1071ui_story = var_326_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_3 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.characterEffect1071ui_story and not isNil(var_326_2) then
					arg_323_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_3)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.characterEffect1071ui_story then
				arg_323_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_326_4 = 0
			local var_326_5 = 0.5

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(121561079)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 20 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 20)

				if (20 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 20)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561079", "story_v_out_121561.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561079", "story_v_out_121561.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_out_121561", "121561079", "story_v_out_121561.awb")

						arg_323_1:RecordAudio("121561079", var_326_11)
						arg_323_1:RecordAudio("121561079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_121561", "121561079", "story_v_out_121561.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_121561", "121561079", "story_v_out_121561.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play121561080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 121561080
		arg_327_1.duration_ = 7.03

		local var_327_0 = {
			ja = 7.033,
			ko = 4.533,
			zh = 4.533
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
				arg_327_0:Play121561081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1071ui_story"]) and arg_327_1.var_.characterEffect1071ui_story == nil then
				arg_327_1.var_.characterEffect1071ui_story = arg_327_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1071ui_story"]) then
				if arg_327_1.var_.characterEffect1071ui_story and not isNil(arg_327_1.actors_["1071ui_story"]) then
					arg_327_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1071ui_story"]) and arg_327_1.var_.characterEffect1071ui_story then
				arg_327_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_330_2 = arg_327_1.actors_["1184ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1184ui_story == nil then
				arg_327_1.var_.characterEffect1184ui_story = var_330_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_3 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.characterEffect1184ui_story and not isNil(var_330_2) then
					arg_327_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_3)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1184ui_story then
				arg_327_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_330_4 = 0
			local var_330_5 = 0.35

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(121561080)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 14 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 14)

				if (14 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 14)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561080", "story_v_out_121561.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561080", "story_v_out_121561.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_121561", "121561080", "story_v_out_121561.awb")

						arg_327_1:RecordAudio("121561080", var_330_11)
						arg_327_1:RecordAudio("121561080", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_121561", "121561080", "story_v_out_121561.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_121561", "121561080", "story_v_out_121561.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play121561081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 121561081
		arg_331_1.duration_ = 4

		local var_331_0 = {
			ja = 3.433,
			ko = 4,
			zh = 4
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
				arg_331_0:Play121561082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1071ui_story = arg_331_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1071ui_story"].transform.position).z)
				arg_331_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1071ui_story"].transform.localEulerAngles = arg_331_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_331_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1071ui_story"].transform.position).z)
				arg_331_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1071ui_story"].transform.localEulerAngles = arg_331_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1071ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1071ui_story == nil then
				arg_331_1.var_.characterEffect1071ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1071ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1071ui_story then
				arg_331_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_334_4 = 0
			local var_334_5 = 0.425

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(121561081)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 17 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 17)

				if (17 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 17)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561081", "story_v_out_121561.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561081", "story_v_out_121561.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_out_121561", "121561081", "story_v_out_121561.awb")

						arg_331_1:RecordAudio("121561081", var_334_11)
						arg_331_1:RecordAudio("121561081", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_121561", "121561081", "story_v_out_121561.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_121561", "121561081", "story_v_out_121561.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play121561082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 121561082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play121561083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1071ui_story = arg_335_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1071ui_story"].transform.position).z)
				arg_335_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1071ui_story"].transform.localEulerAngles = arg_335_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_335_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1071ui_story"].transform.position).z)
				arg_335_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1071ui_story"].transform.localEulerAngles = arg_335_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1071ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1071ui_story == nil then
				arg_335_1.var_.characterEffect1071ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1071ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_2)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1071ui_story then
				arg_335_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_338_3 = arg_335_1.actors_["1184ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1184ui_story = var_338_3.localPosition
			end

			local var_338_4 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				var_338_3.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 0) / var_338_4)
				var_338_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_3.position).x, (manager.ui.mainCamera.transform.position - var_338_3.position).y, (manager.ui.mainCamera.transform.position - var_338_3.position).z)
				var_338_3.localEulerAngles.z = 0
				var_338_3.localEulerAngles.x = 0
				var_338_3.localEulerAngles = var_338_3.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				var_338_3.localPosition = Vector3.New(0, 100, 0)
				var_338_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_3.position).x, (manager.ui.mainCamera.transform.position - var_338_3.position).y, (manager.ui.mainCamera.transform.position - var_338_3.position).z)
				var_338_3.localEulerAngles.z = 0
				var_338_3.localEulerAngles.x = 0
				var_338_3.localEulerAngles = var_338_3.localEulerAngles
			end

			local var_338_5 = arg_335_1.actors_["1184ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.characterEffect1184ui_story == nil then
				arg_335_1.var_.characterEffect1184ui_story = var_338_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_6 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_6 and not isNil(var_338_5) then
				if arg_335_1.var_.characterEffect1184ui_story and not isNil(var_338_5) then
					arg_335_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_6)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_6 and arg_335_1.time_ < 0 + var_338_6 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.characterEffect1184ui_story then
				arg_335_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_338_7 = 0
			local var_338_8 = 0.6

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_9 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(121561082).content)

				arg_335_1.text_.text = var_338_9

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_11 = 24 <= 0 and var_338_8 or var_338_8 * (utf8.len(var_338_9) / 24)

				if (24 <= 0 and var_338_8 or var_338_8 * (utf8.len(var_338_9) / 24)) > 0 and var_338_8 < var_338_11 then
					arg_335_1.talkMaxDuration = var_338_11

					if var_338_11 + var_338_7 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_7
					end
				end

				arg_335_1.text_.text = var_338_9
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_8, arg_335_1.talkMaxDuration)

			if var_338_7 <= arg_335_1.time_ and arg_335_1.time_ < var_338_7 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_7) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_7 + var_338_12 and arg_335_1.time_ < var_338_7 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play121561083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 121561083
		arg_339_1.duration_ = 7

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play121561084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_342_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_339_1.bgmTxt_.text ~= var_342_2 and arg_339_1.bgmTxt_.text ~= "" then
						if arg_339_1.bgmTxt2_.text ~= "" then
							arg_339_1.bgmTxt_.text = arg_339_1.bgmTxt2_.text
						end

						arg_339_1.bgmTxt2_.text = var_342_2

						arg_339_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_339_1.bgmTxt_.text = var_342_2
						arg_339_1.bgmTxt2_.text = var_342_2
					end

					if arg_339_1.bgmTimer then
						arg_339_1.bgmTimer:Stop()

						arg_339_1.bgmTimer = nil
					end

					if arg_339_1.settingData.show_music_name == 1 then
						arg_339_1.musicController:SetSelectedState("show")
						arg_339_1.musicAnimator_:Play("open", 0, 0)

						if arg_339_1.settingData.music_time ~= 0 then
							arg_339_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_339_1.settingData.music_time), function()
								if arg_339_1 == nil or isNil(arg_339_1.bgmTxt_) then
									return
								end

								arg_339_1.musicController:SetSelectedState("hide")
								arg_339_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_339_1.time_ and arg_339_1.time_ <= 0.133333333333333 + arg_342_0 then
				arg_339_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_dizzle", "")
			end

			local var_342_4 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_5 = 2

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_5 then
				local var_342_6 = Color.New(1, 1, 1)

				var_342_6.a = Mathf.Lerp(1, 0, (arg_339_1.time_ - var_342_4) / var_342_5)
				arg_339_1.mask_.color = var_342_6
			end

			if arg_339_1.time_ >= var_342_4 + var_342_5 and arg_339_1.time_ < var_342_4 + var_342_5 + arg_342_0 then
				local var_342_7 = Color.New(1, 1, 1)

				arg_339_1.mask_.enabled = false
				var_342_7.a = 0
				arg_339_1.mask_.color = var_342_7
			end

			local var_342_8 = manager.ui.mainCamera.transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.shakeOldPos = var_342_8.localPosition
			end

			local var_342_9 = 2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_9 then
				local var_342_10, var_342_11 = math.modf((arg_339_1.time_ - 0) / 0)

				var_342_8.localPosition = Vector3.New(var_342_11 * 0, var_342_11 * 0, var_342_11 * 0) + arg_339_1.var_.shakeOldPos
			end

			if arg_339_1.time_ >= 0 + var_342_9 and arg_339_1.time_ < 0 + var_342_9 + arg_342_0 then
				var_342_8.localPosition = arg_339_1.var_.shakeOldPos
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_12 = 2
			local var_342_13 = 1.65

			if 2 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_14 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_14:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_339_1.dialogCg_.alpha = arg_344_0
				end))
				var_342_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_15 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(121561083).content)

				arg_339_1.text_.text = var_342_15

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_17 = 66 <= 0 and var_342_13 or var_342_13 * (utf8.len(var_342_15) / 66)

				if (66 <= 0 and var_342_13 or var_342_13 * (utf8.len(var_342_15) / 66)) > 0 and var_342_13 < var_342_17 then
					arg_339_1.talkMaxDuration = var_342_17
					var_342_12 = var_342_12 + 0.3

					if var_342_17 + var_342_12 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_17 + var_342_12
					end
				end

				arg_339_1.text_.text = var_342_15
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_18 = var_342_12 + 0.3
			local var_342_19 = math.max(var_342_13, arg_339_1.talkMaxDuration)

			if var_342_12 + 0.3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_18 + var_342_19 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_18) / var_342_19

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_18 + var_342_19 and arg_339_1.time_ < var_342_18 + var_342_19 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play121561084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 121561084
		arg_346_1.duration_ = 7

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play121561085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_349_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_346_1.bgmTxt_.text ~= var_349_2 and arg_346_1.bgmTxt_.text ~= "" then
						if arg_346_1.bgmTxt2_.text ~= "" then
							arg_346_1.bgmTxt_.text = arg_346_1.bgmTxt2_.text
						end

						arg_346_1.bgmTxt2_.text = var_349_2

						arg_346_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_346_1.bgmTxt_.text = var_349_2
						arg_346_1.bgmTxt2_.text = var_349_2
					end

					if arg_346_1.bgmTimer then
						arg_346_1.bgmTimer:Stop()

						arg_346_1.bgmTimer = nil
					end

					if arg_346_1.settingData.show_music_name == 1 then
						arg_346_1.musicController:SetSelectedState("show")
						arg_346_1.musicAnimator_:Play("open", 0, 0)

						if arg_346_1.settingData.music_time ~= 0 then
							arg_346_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_346_1.settingData.music_time), function()
								if arg_346_1 == nil or isNil(arg_346_1.bgmTxt_) then
									return
								end

								arg_346_1.musicController:SetSelectedState("hide")
								arg_346_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.766666666666667 < arg_346_1.time_ and arg_346_1.time_ <= 0.766666666666667 + arg_349_0 then
				arg_346_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_dizzle", "")
			end

			local var_349_4 = "J10i_blur"

			if arg_346_1.bgs_.J10i_blur == nil then
				local var_349_5 = Object.Instantiate(arg_346_1.blurPaintGo_)

				var_349_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_349_4)
				var_349_5.name = var_349_4
				var_349_5.transform.parent = arg_346_1.stage_.transform
				var_349_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.bgs_[var_349_4] = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = arg_346_1.bgs_[var_349_4]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				var_349_7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_349_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_349_8 = var_349_7:GetComponent("SpriteRenderer")

				if var_349_8 and var_349_8.sprite then
					local var_349_9 = 2 * (var_349_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_349_7.transform.localScale = Vector3.New(var_349_9 / var_349_8.sprite.bounds.size.y < var_349_9 * manager.ui.mainCameraCom_.aspect / var_349_8.sprite.bounds.size.x and var_349_9 * manager.ui.mainCameraCom_.aspect / var_349_8.sprite.bounds.size.x or var_349_9 / var_349_8.sprite.bounds.size.y, var_349_9 / var_349_8.sprite.bounds.size.y < var_349_9 * manager.ui.mainCameraCom_.aspect / var_349_8.sprite.bounds.size.x and var_349_9 * manager.ui.mainCameraCom_.aspect / var_349_8.sprite.bounds.size.x or var_349_9 / var_349_8.sprite.bounds.size.y, 0)
				end
			end

			local var_349_10 = 2

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_10 then
				local var_349_11 = Color.New(1, 1, 1)

				var_349_11.a = Mathf.Lerp(0, 1, (arg_346_1.time_ - var_349_6) / var_349_10)

				var_349_7:GetComponent("SpriteRenderer").material:SetColor("_Color", var_349_11)
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_12 = 2
			local var_349_13 = 1.2

			if 2 < arg_346_1.time_ and arg_346_1.time_ <= var_349_12 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_14 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_14:setOnUpdate(LuaHelper.FloatAction(function(arg_351_0)
					arg_346_1.dialogCg_.alpha = arg_351_0
				end))
				var_349_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_15 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(121561084).content)

				arg_346_1.text_.text = var_349_15

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_17 = 48 <= 0 and var_349_13 or var_349_13 * (utf8.len(var_349_15) / 48)

				if (48 <= 0 and var_349_13 or var_349_13 * (utf8.len(var_349_15) / 48)) > 0 and var_349_13 < var_349_17 then
					arg_346_1.talkMaxDuration = var_349_17
					var_349_12 = var_349_12 + 0.3

					if var_349_17 + var_349_12 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_17 + var_349_12
					end
				end

				arg_346_1.text_.text = var_349_15
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_18 = var_349_12 + 0.3
			local var_349_19 = math.max(var_349_13, arg_346_1.talkMaxDuration)

			if var_349_12 + 0.3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_18 + var_349_19 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_18) / var_349_19

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_18 + var_349_19 and arg_346_1.time_ < var_349_18 + var_349_19 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play121561085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 121561085
		arg_353_1.duration_ = 7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if arg_353_1.bgs_.STblack == nil then
				local var_356_0 = Object.Instantiate(arg_353_1.paintGo_)

				var_356_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_356_0.name = "STblack"
				var_356_0.transform.parent = arg_353_1.stage_.transform
				var_356_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.bgs_.STblack = var_356_0
			end

			if 2 < arg_353_1.time_ and arg_353_1.time_ <= 2 + arg_356_0 then
				local var_356_1 = arg_353_1.bgs_.STblack

				arg_353_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_356_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_356_2 = var_356_1:GetComponent("SpriteRenderer")

				if var_356_2 and var_356_2.sprite then
					local var_356_3 = 2 * (var_356_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_356_1.transform.localScale = Vector3.New(var_356_3 / var_356_2.sprite.bounds.size.y < var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x and var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x or var_356_3 / var_356_2.sprite.bounds.size.y, var_356_3 / var_356_2.sprite.bounds.size.y < var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x and var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x or var_356_3 / var_356_2.sprite.bounds.size.y, 0)
				end

				for iter_356_0, iter_356_1 in pairs(arg_353_1.bgs_) do
					if iter_356_0 ~= "STblack" then
						iter_356_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_356_4 = 0

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_5 = 2

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_5 then
				local var_356_6 = Color.New(0, 0, 0)

				var_356_6.a = Mathf.Lerp(0, 1, (arg_353_1.time_ - var_356_4) / var_356_5)
				arg_353_1.mask_.color = var_356_6
			end

			if arg_353_1.time_ >= var_356_4 + var_356_5 and arg_353_1.time_ < var_356_4 + var_356_5 + arg_356_0 then
				local var_356_7 = Color.New(0, 0, 0)

				var_356_7.a = 1
				arg_353_1.mask_.color = var_356_7
			end

			local var_356_8 = 2

			if 2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_9 = 0.5

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_9 then
				local var_356_10 = Color.New(0, 0, 0)

				var_356_10.a = Mathf.Lerp(1, 0, (arg_353_1.time_ - var_356_8) / var_356_9)
				arg_353_1.mask_.color = var_356_10
			end

			if arg_353_1.time_ >= var_356_8 + var_356_9 and arg_353_1.time_ < var_356_8 + var_356_9 + arg_356_0 then
				local var_356_11 = Color.New(0, 0, 0)

				arg_353_1.mask_.enabled = false
				var_356_11.a = 0
				arg_353_1.mask_.color = var_356_11
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_12 = 2
			local var_356_13 = 0.925

			if 2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_12 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_14 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_14:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_353_1.dialogCg_.alpha = arg_357_0
				end))
				var_356_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_15 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(121561085).content)

				arg_353_1.text_.text = var_356_15

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_17 = 37 <= 0 and var_356_13 or var_356_13 * (utf8.len(var_356_15) / 37)

				if (37 <= 0 and var_356_13 or var_356_13 * (utf8.len(var_356_15) / 37)) > 0 and var_356_13 < var_356_17 then
					arg_353_1.talkMaxDuration = var_356_17
					var_356_12 = var_356_12 + 0.3

					if var_356_17 + var_356_12 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_17 + var_356_12
					end
				end

				arg_353_1.text_.text = var_356_15
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_18 = var_356_12 + 0.3
			local var_356_19 = math.max(var_356_13, arg_353_1.talkMaxDuration)

			if var_356_12 + 0.3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_18 + var_356_19 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_18) / var_356_19

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_18 + var_356_19 and arg_353_1.time_ < var_356_18 + var_356_19 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0310",
		"TextureConfig/Background/J12g",
		"TextureConfig/Background/J10i",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_121561.awb"
	}
}
