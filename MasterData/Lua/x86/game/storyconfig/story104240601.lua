return {
	Play424061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0116c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116c")
				var_4_0.name = "ST0116c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0116c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0116c

				arg_1_1.bgs_.ST0116c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0116c" then
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

			if 0.034 < arg_1_1.time_ and arg_1_1.time_ <= 0.034 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense")

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

			if 0.034 < arg_1_1.time_ and arg_1_1.time_ <= 0.034 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone", "")
			end

			local var_4_16 = 1.999999999999
			local var_4_17 = 0.675

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(424061001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 27 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_18) / 27)

				if (27 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_18) / 27)) > 0 and var_4_17 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20

					if var_4_20 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_21 and arg_1_1.time_ < var_4_16 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424061002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 424061002
		arg_7_1.duration_ = 4.83

		local var_7_0 = {
			zh = 4.833,
			ja = 4.2
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play424061003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.45

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[1398].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_1 = arg_7_1:GetWordFromCfg(424061002)
				local var_10_2 = arg_7_1:FormatText(var_10_1.content)

				arg_7_1.text_.text = var_10_2

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 18 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 18)

				if (18 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 18)) > 0 and var_10_0 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + 0
					end
				end

				arg_7_1.text_.text = var_10_2
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061002", "story_v_out_424061.awb") ~= 0 then
					local var_10_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061002", "story_v_out_424061.awb") / 1000

					if var_10_5 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + 0
					end

					if var_10_1.prefab_name ~= "" and arg_7_1.actors_[var_10_1.prefab_name] ~= nil then
						local var_10_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_1.prefab_name].transform, "story_v_out_424061", "424061002", "story_v_out_424061.awb")

						arg_7_1:RecordAudio("424061002", var_10_6)
						arg_7_1:RecordAudio("424061002", var_10_6)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_424061", "424061002", "story_v_out_424061.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_424061", "424061002", "story_v_out_424061.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_7 and arg_7_1.time_ < 0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play424061003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 424061003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play424061004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.025

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(424061003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 41 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 41)

				if (41 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 41)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play424061004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 424061004
		arg_15_1.duration_ = 5.2

		local var_15_0 = {
			zh = 4.566,
			ja = 5.2
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play424061005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.3

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[1399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10055_c")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:GetWordFromCfg(424061004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 12 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 12)

				if (12 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 12)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061004", "story_v_out_424061.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061004", "story_v_out_424061.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_424061", "424061004", "story_v_out_424061.awb")

						arg_15_1:RecordAudio("424061004", var_18_6)
						arg_15_1:RecordAudio("424061004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_424061", "424061004", "story_v_out_424061.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_424061", "424061004", "story_v_out_424061.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play424061005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 424061005
		arg_19_1.duration_ = 4.3

		local var_19_0 = {
			zh = 4.3,
			ja = 3.833
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play424061006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["10154"] == nil then
				local var_22_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_22_0) then
					local var_22_1 = Object.Instantiate(var_22_0, arg_19_1.canvasGo_.transform)

					var_22_1.transform:SetSiblingIndex(1)

					var_22_1.name = "10154"
					var_22_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_["10154"] = var_22_1

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs((var_22_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_2 = arg_19_1.actors_["10154"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps10154 == nil then
				arg_19_1.var_.actorSpriteComps10154 = var_22_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_3 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_3 and not isNil(var_22_2) then
				if arg_19_1.var_.actorSpriteComps10154 then
					for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_22_3 then
							if arg_19_1.isInRecall_ then
								iter_22_3.color = Color.New(Mathf.Lerp(iter_22_3.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_3), Mathf.Lerp(iter_22_3.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_3), (Mathf.Lerp(iter_22_3.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_3)))
							else
								local var_22_4 = Mathf.Lerp(iter_22_3.color.r, 1, (arg_19_1.time_ - 0) / var_22_3)

								iter_22_3.color = Color.New(var_22_4, var_22_4, var_22_4)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_3 and arg_19_1.time_ < 0 + var_22_3 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps10154 then
				for iter_22_4, iter_22_5 in pairs(arg_19_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_22_5 then
						iter_22_5.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps10154 = nil
			end

			local var_22_5 = arg_19_1.actors_["10154"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos10154 = var_22_5.localPosition
				var_22_5.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("10154", 3)

				for iter_22_6 = 0, var_22_5.childCount - 1 do
					local var_22_6 = var_22_5:GetChild(iter_22_6)

					if var_22_6.name == "split_3" or not string.find(var_22_6.name, "split") then
						var_22_6.gameObject:SetActive(true)
					else
						var_22_6.gameObject:SetActive(false)
					end
				end
			end

			local var_22_7 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 then
				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_19_1.time_ - 0) / var_22_7)
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_22_8 = 0
			local var_22_9 = 0.375

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(424061005)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 15 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 15)

				if (15 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 15)) > 0 and var_22_9 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061005", "story_v_out_424061.awb") ~= 0 then
					local var_22_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061005", "story_v_out_424061.awb") / 1000

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end

					if var_22_10.prefab_name ~= "" and arg_19_1.actors_[var_22_10.prefab_name] ~= nil then
						local var_22_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_10.prefab_name].transform, "story_v_out_424061", "424061005", "story_v_out_424061.awb")

						arg_19_1:RecordAudio("424061005", var_22_15)
						arg_19_1:RecordAudio("424061005", var_22_15)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_424061", "424061005", "story_v_out_424061.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_424061", "424061005", "story_v_out_424061.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_16 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_16 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_16

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_16 and arg_19_1.time_ < var_22_8 + var_22_16 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play424061006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 424061006
		arg_23_1.duration_ = 3.97

		local var_23_0 = {
			zh = 3.966,
			ja = 3.8
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play424061007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["10154"]) and arg_23_1.var_.actorSpriteComps10154 == nil then
				arg_23_1.var_.actorSpriteComps10154 = arg_23_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["10154"]) then
				if arg_23_1.var_.actorSpriteComps10154 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								iter_26_1.color = Color.New(Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor2.r, (arg_23_1.time_ - 0) / var_26_0), Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor2.g, (arg_23_1.time_ - 0) / var_26_0), (Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor2.b, (arg_23_1.time_ - 0) / var_26_0)))
							else
								local var_26_1 = Mathf.Lerp(iter_26_1.color.r, 0.5, (arg_23_1.time_ - 0) / var_26_0)

								iter_26_1.color = Color.New(var_26_1, var_26_1, var_26_1)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["10154"]) and arg_23_1.var_.actorSpriteComps10154 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps10154 = nil
			end

			local var_26_2 = 0
			local var_26_3 = 0.15

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10055_c")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_4 = arg_23_1:GetWordFromCfg(424061006)
				local var_26_5 = arg_23_1:FormatText(var_26_4.content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 6 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 6)

				if (6 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 6)) > 0 and var_26_3 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061006", "story_v_out_424061.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061006", "story_v_out_424061.awb") / 1000

					if var_26_8 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_2
					end

					if var_26_4.prefab_name ~= "" and arg_23_1.actors_[var_26_4.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_4.prefab_name].transform, "story_v_out_424061", "424061006", "story_v_out_424061.awb")

						arg_23_1:RecordAudio("424061006", var_26_9)
						arg_23_1:RecordAudio("424061006", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_424061", "424061006", "story_v_out_424061.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_424061", "424061006", "story_v_out_424061.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play424061007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 424061007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play424061008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10154 = arg_27_1.actors_["10154"].transform.localPosition
				arg_27_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10154", 7)

				for iter_30_0 = 0, arg_27_1.actors_["10154"].transform.childCount - 1 do
					local var_30_0 = arg_27_1.actors_["10154"].transform:GetChild(iter_30_0)

					if var_30_0.name == "" or not string.find(var_30_0.name, "split") then
						var_30_0.gameObject:SetActive(true)
					else
						var_30_0.gameObject:SetActive(false)
					end
				end
			end

			local var_30_1 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 then
				arg_27_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_27_1.time_ - 0) / var_30_1)
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 then
				arg_27_1.actors_["10154"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_30_2 = 0
			local var_30_3 = 0.85

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(424061007).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 34 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 34)

				if (34 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 34)) > 0 and var_30_3 < var_30_6 then
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

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play424061008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 424061008
		arg_31_1.duration_ = 6.6

		local var_31_0 = {
			zh = 5,
			ja = 6.6
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
				arg_31_0:Play424061009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.55

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1398].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(424061008)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 22 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 22)

				if (22 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 22)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061008", "story_v_out_424061.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061008", "story_v_out_424061.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_424061", "424061008", "story_v_out_424061.awb")

						arg_31_1:RecordAudio("424061008", var_34_6)
						arg_31_1:RecordAudio("424061008", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_424061", "424061008", "story_v_out_424061.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_424061", "424061008", "story_v_out_424061.awb")
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
	Play424061009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 424061009
		arg_35_1.duration_ = 3.6

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play424061010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[1400].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(424061009)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 18 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 18)

				if (18 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 18)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061009", "story_v_out_424061.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061009", "story_v_out_424061.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_424061", "424061009", "story_v_out_424061.awb")

						arg_35_1:RecordAudio("424061009", var_38_6)
						arg_35_1:RecordAudio("424061009", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_424061", "424061009", "story_v_out_424061.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_424061", "424061009", "story_v_out_424061.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play424061010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 424061010
		arg_39_1.duration_ = 1.4

		local var_39_0 = {
			zh = 1.4,
			ja = 1.233
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play424061011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["10153"] == nil then
				local var_42_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_42_0) then
					local var_42_1 = Object.Instantiate(var_42_0, arg_39_1.canvasGo_.transform)

					var_42_1.transform:SetSiblingIndex(1)

					var_42_1.name = "10153"
					var_42_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_["10153"] = var_42_1

					if arg_39_1.isInRecall_ then
						for iter_42_0, iter_42_1 in ipairs((var_42_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_42_1.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_2 = arg_39_1.actors_["10153"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10153 == nil then
				arg_39_1.var_.actorSpriteComps10153 = var_42_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_3 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.actorSpriteComps10153 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_3), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_3), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_3)))
							else
								local var_42_4 = Mathf.Lerp(iter_42_3.color.r, 1, (arg_39_1.time_ - 0) / var_42_3)

								iter_42_3.color = Color.New(var_42_4, var_42_4, var_42_4)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10153 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps10153 = nil
			end

			local var_42_5 = arg_39_1.actors_["10153"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10153 = var_42_5.localPosition
				var_42_5.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10153", 3)

				for iter_42_6 = 0, var_42_5.childCount - 1 do
					local var_42_6 = var_42_5:GetChild(iter_42_6)

					if var_42_6.name == "split_3" or not string.find(var_42_6.name, "split") then
						var_42_6.gameObject:SetActive(true)
					else
						var_42_6.gameObject:SetActive(false)
					end
				end
			end

			local var_42_7 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				var_42_5.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_39_1.time_ - 0) / var_42_7)
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				var_42_5.localPosition = Vector3.New(-60, -395, -330)
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_8 = arg_39_1.actors_["10153"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_8 then
					arg_39_1.var_.alphaOldValue10153 = var_42_8.alpha
					arg_39_1.var_.characterEffect10153 = var_42_8
				end

				arg_39_1.var_.alphaOldValue10153 = 0
			end

			local var_42_9 = 0.5

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 then
				if arg_39_1.var_.characterEffect10153 then
					arg_39_1.var_.characterEffect10153.alpha = Mathf.Lerp(arg_39_1.var_.alphaOldValue10153, 1, (arg_39_1.time_ - 0) / var_42_9)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 and arg_39_1.var_.characterEffect10153 then
				arg_39_1.var_.characterEffect10153.alpha = 1
			end

			local var_42_10 = 0
			local var_42_11 = 0.125

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_12 = arg_39_1:GetWordFromCfg(424061010)
				local var_42_13 = arg_39_1:FormatText(var_42_12.content)

				arg_39_1.text_.text = var_42_13

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_15 = 5 <= 0 and var_42_11 or var_42_11 * (utf8.len(var_42_13) / 5)

				if (5 <= 0 and var_42_11 or var_42_11 * (utf8.len(var_42_13) / 5)) > 0 and var_42_11 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_10
					end
				end

				arg_39_1.text_.text = var_42_13
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061010", "story_v_out_424061.awb") ~= 0 then
					local var_42_16 = manager.audio:GetVoiceLength("story_v_out_424061", "424061010", "story_v_out_424061.awb") / 1000

					if var_42_16 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_10
					end

					if var_42_12.prefab_name ~= "" and arg_39_1.actors_[var_42_12.prefab_name] ~= nil then
						local var_42_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_12.prefab_name].transform, "story_v_out_424061", "424061010", "story_v_out_424061.awb")

						arg_39_1:RecordAudio("424061010", var_42_17)
						arg_39_1:RecordAudio("424061010", var_42_17)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_424061", "424061010", "story_v_out_424061.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_424061", "424061010", "story_v_out_424061.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_18 = math.max(var_42_11, arg_39_1.talkMaxDuration)

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_18 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_10) / var_42_18

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_10 + var_42_18 and arg_39_1.time_ < var_42_10 + var_42_18 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play424061011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 424061011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play424061012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_9000

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10153"]) and arg_43_1.var_.actorSpriteComps10153 == nil then
				arg_43_1.var_.actorSpriteComps10153 = arg_43_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10153"]) then
				if arg_43_1.var_.actorSpriteComps10153 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								iter_46_1.color = Color.New(Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_0), Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_0), (Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_0)))
							else
								local var_46_1 = Mathf.Lerp(iter_46_1.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_0)

								iter_46_1.color = Color.New(var_46_1, var_46_1, var_46_1)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10153"]) and arg_43_1.var_.actorSpriteComps10153 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps10153 = nil
			end

			local var_46_2 = arg_43_1.actors_["10153"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10153 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10153", 7)

				for iter_46_4 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_4)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_5 = arg_43_1.var_.effectlingshe1

				if not arg_43_1.var_.effectlingshe1 then
					var_46_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_46_5.name = "lingshe1"
					arg_43_1.var_.effectlingshe1 = var_46_5
				else
					var_46_5.transform:SetParent(var_46_9000)
				end

				var_46_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_46_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_46_5.transform.localScale = Vector3.New(var_46_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_46_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_46_5.transform.localScale.z)
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_146", "se_story_146_bell", "")
			end

			local var_46_8 = 0
			local var_46_9 = 1.15

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_10 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_10:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_11 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(424061011).content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 46 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 46)

				if (46 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 46)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13
					var_46_8 = var_46_8 + 0.3

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = var_46_8 + 0.3
			local var_46_15 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_14 + var_46_15 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_14) / var_46_15

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_14 + var_46_15 and arg_43_1.time_ < var_46_14 + var_46_15 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play424061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424061012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play424061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0.034 < arg_49_1.time_ and arg_49_1.time_ <= 0.034 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_140", "se_story_140_dark", "")
			end

			local var_52_1 = 0
			local var_52_2 = 0.975

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(424061012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 39 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 39)

				if (39 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 39)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play424061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424061013
		arg_53_1.duration_ = 2.03

		local var_53_0 = {
			zh = 2.033,
			ja = 1.333
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
				arg_53_0:Play424061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10154"]) and arg_53_1.var_.actorSpriteComps10154 == nil then
				arg_53_1.var_.actorSpriteComps10154 = arg_53_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10154"]) then
				if arg_53_1.var_.actorSpriteComps10154 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 1, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10154"]) and arg_53_1.var_.actorSpriteComps10154 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10154 = nil
			end

			local var_56_2 = arg_53_1.actors_["10154"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10154 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10154", 2)

				for iter_56_4 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_4)

					if var_56_3.name == "split_3" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_56_5 = 0
			local var_56_6 = 0.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(424061013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 7 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 7)

				if (7 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 7)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061013", "story_v_out_424061.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061013", "story_v_out_424061.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_424061", "424061013", "story_v_out_424061.awb")

						arg_53_1:RecordAudio("424061013", var_56_12)
						arg_53_1:RecordAudio("424061013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_424061", "424061013", "story_v_out_424061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_424061", "424061013", "story_v_out_424061.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				frequency = 15,
				className = "StoryShakeNode",
				duration = 0.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(2, 2, 2)
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play424061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424061014
		arg_57_1.duration_ = 4.13

		local var_57_0 = {
			zh = 4.033,
			ja = 4.133
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
				arg_57_0:Play424061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10153"]) and arg_57_1.var_.actorSpriteComps10153 == nil then
				arg_57_1.var_.actorSpriteComps10153 = arg_57_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10153"]) then
				if arg_57_1.var_.actorSpriteComps10153 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 1, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10153"]) and arg_57_1.var_.actorSpriteComps10153 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10153 = nil
			end

			local var_60_2 = arg_57_1.actors_["10154"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10154 == nil then
				arg_57_1.var_.actorSpriteComps10154 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10154 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								iter_60_5.color = Color.New(Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_5.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_5.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10154 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10154 = nil
			end

			local var_60_5 = arg_57_1.actors_["10153"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10153 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10153", 4)

				for iter_60_8 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_8)

					if var_60_6.name == "split_1" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_60_8 = 0
			local var_60_9 = 0.375

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(424061014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 15 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 15)

				if (15 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 15)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061014", "story_v_out_424061.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061014", "story_v_out_424061.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_424061", "424061014", "story_v_out_424061.awb")

						arg_57_1:RecordAudio("424061014", var_60_15)
						arg_57_1:RecordAudio("424061014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_424061", "424061014", "story_v_out_424061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_424061", "424061014", "story_v_out_424061.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play424061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424061015
		arg_61_1.duration_ = 6.57

		local var_61_0 = {
			zh = 6.566,
			ja = 5.933
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
				arg_61_0:Play424061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10154"]) and arg_61_1.var_.actorSpriteComps10154 == nil then
				arg_61_1.var_.actorSpriteComps10154 = arg_61_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10154"]) then
				if arg_61_1.var_.actorSpriteComps10154 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10154"]) and arg_61_1.var_.actorSpriteComps10154 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10154 = nil
			end

			local var_64_2 = arg_61_1.actors_["10153"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10153 == nil then
				arg_61_1.var_.actorSpriteComps10153 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10153 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10153 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10153 = nil
			end

			local var_64_5 = arg_61_1.actors_["10154"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10154 = var_64_5.localPosition
				var_64_5.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10154", 2)

				for iter_64_8 = 0, var_64_5.childCount - 1 do
					local var_64_6 = var_64_5:GetChild(iter_64_8)

					if var_64_6.name == "split_5" then
						var_64_6:SetAsLastSibling()
						var_64_6.gameObject:SetActive(true)

						arg_61_1.var_.actorSpriteSplit10154 = var_64_6.gameObject:GetComponent(typeof(Image))

						arg_61_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_64_7 = 0.5

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_61_1.time_ - 0) / var_64_7)

				if arg_61_1.var_.actorSpriteSplit10154 ~= nil then
					arg_61_1.var_.actorSpriteSplit10154:SetAlpha((arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(-375, -338, -538)

				if arg_61_1.var_.actorSpriteSplit10154 ~= nil then
					arg_61_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_64_8 = 0
			local var_64_9 = 0.675

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(424061015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 27 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 27)

				if (27 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 27)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061015", "story_v_out_424061.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061015", "story_v_out_424061.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_424061", "424061015", "story_v_out_424061.awb")

						arg_61_1:RecordAudio("424061015", var_64_15)
						arg_61_1:RecordAudio("424061015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_424061", "424061015", "story_v_out_424061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_424061", "424061015", "story_v_out_424061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play424061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424061016
		arg_65_1.duration_ = 7.07

		local var_65_0 = {
			zh = 6.066,
			ja = 7.066
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
				arg_65_0:Play424061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10153"]) and arg_65_1.var_.actorSpriteComps10153 == nil then
				arg_65_1.var_.actorSpriteComps10153 = arg_65_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10153"]) then
				if arg_65_1.var_.actorSpriteComps10153 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10153"]) and arg_65_1.var_.actorSpriteComps10153 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10153 = nil
			end

			local var_68_2 = arg_65_1.actors_["10154"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10154 == nil then
				arg_65_1.var_.actorSpriteComps10154 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10154 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10154 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10154 = nil
			end

			local var_68_5 = arg_65_1.actors_["10153"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10153 = var_68_5.localPosition
				var_68_5.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10153", 4)

				for iter_68_8 = 0, var_68_5.childCount - 1 do
					local var_68_6 = var_68_5:GetChild(iter_68_8)

					if var_68_6.name == "" or not string.find(var_68_6.name, "split") then
						var_68_6.gameObject:SetActive(true)
					else
						var_68_6.gameObject:SetActive(false)
					end
				end
			end

			local var_68_7 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_65_1.time_ - 0) / var_68_7)
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_68_8 = 0
			local var_68_9 = 0.675

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(424061016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 27 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 27)

				if (27 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 27)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061016", "story_v_out_424061.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061016", "story_v_out_424061.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_424061", "424061016", "story_v_out_424061.awb")

						arg_65_1:RecordAudio("424061016", var_68_15)
						arg_65_1:RecordAudio("424061016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_424061", "424061016", "story_v_out_424061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_424061", "424061016", "story_v_out_424061.awb")
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
				actorName = "10153",
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
	Play424061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424061017
		arg_69_1.duration_ = 13.27

		local var_69_0 = {
			zh = 11.8,
			ja = 13.266
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
				arg_69_0:Play424061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(424061017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 51 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 51)

				if (51 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 51)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061017", "story_v_out_424061.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061017", "story_v_out_424061.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_424061", "424061017", "story_v_out_424061.awb")

						arg_69_1:RecordAudio("424061017", var_72_6)
						arg_69_1:RecordAudio("424061017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_424061", "424061017", "story_v_out_424061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_424061", "424061017", "story_v_out_424061.awb")
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
	Play424061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424061018
		arg_73_1.duration_ = 14.87

		local var_73_0 = {
			zh = 11.1,
			ja = 14.866
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
				arg_73_0:Play424061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10153 = arg_73_1.actors_["10153"].transform.localPosition
				arg_73_1.actors_["10153"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10153", 4)

				for iter_76_0 = 0, arg_73_1.actors_["10153"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10153"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10153"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10153"].transform.localPosition = Vector3.New(400, -395, -330)
			end

			local var_76_2 = 0
			local var_76_3 = 1.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(424061018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 47 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 47)

				if (47 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 47)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061018", "story_v_out_424061.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061018", "story_v_out_424061.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_424061", "424061018", "story_v_out_424061.awb")

						arg_73_1:RecordAudio("424061018", var_76_9)
						arg_73_1:RecordAudio("424061018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_424061", "424061018", "story_v_out_424061.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_424061", "424061018", "story_v_out_424061.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play424061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424061019
		arg_77_1.duration_ = 4.93

		local var_77_0 = {
			zh = 4.933,
			ja = 1.333
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
				arg_77_0:Play424061020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10154"]) and arg_77_1.var_.actorSpriteComps10154 == nil then
				arg_77_1.var_.actorSpriteComps10154 = arg_77_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10154"]) then
				if arg_77_1.var_.actorSpriteComps10154 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 1, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10154"]) and arg_77_1.var_.actorSpriteComps10154 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10154 = nil
			end

			local var_80_2 = arg_77_1.actors_["10153"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10153 == nil then
				arg_77_1.var_.actorSpriteComps10153 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10153 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_5.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_5.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10153 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10153 = nil
			end

			local var_80_5 = arg_77_1.actors_["10154"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10154 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10154", 2)

				for iter_80_8 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_8)

					if var_80_6.name == "split_1" then
						var_80_6:SetAsLastSibling()
						var_80_6.gameObject:SetActive(true)

						arg_77_1.var_.actorSpriteSplit10154 = var_80_6.gameObject:GetComponent(typeof(Image))

						arg_77_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_80_7 = 0.5

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_77_1.time_ - 0) / var_80_7)

				if arg_77_1.var_.actorSpriteSplit10154 ~= nil then
					arg_77_1.var_.actorSpriteSplit10154:SetAlpha((arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(-375, -338, -538)

				if arg_77_1.var_.actorSpriteSplit10154 ~= nil then
					arg_77_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_80_8 = 0
			local var_80_9 = 0.15

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(424061019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 6 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 6)

				if (6 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 6)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061019", "story_v_out_424061.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061019", "story_v_out_424061.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_424061", "424061019", "story_v_out_424061.awb")

						arg_77_1:RecordAudio("424061019", var_80_15)
						arg_77_1:RecordAudio("424061019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_424061", "424061019", "story_v_out_424061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_424061", "424061019", "story_v_out_424061.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play424061020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424061020
		arg_81_1.duration_ = 1.9

		local var_81_0 = {
			zh = 1.766,
			ja = 1.9
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
				arg_81_0:Play424061021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10153"]) and arg_81_1.var_.actorSpriteComps10153 == nil then
				arg_81_1.var_.actorSpriteComps10153 = arg_81_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10153"]) then
				if arg_81_1.var_.actorSpriteComps10153 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 1, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10153"]) and arg_81_1.var_.actorSpriteComps10153 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10153 = nil
			end

			local var_84_2 = arg_81_1.actors_["10154"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10154 == nil then
				arg_81_1.var_.actorSpriteComps10154 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10154 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10154 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10154 = nil
			end

			local var_84_5 = arg_81_1.actors_["10153"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10153 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10153", 4)

				for iter_84_8 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_8)

					if var_84_6.name == "split_2" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_84_8 = 0
			local var_84_9 = 0.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(424061020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 6 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 6)

				if (6 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 6)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061020", "story_v_out_424061.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061020", "story_v_out_424061.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_424061", "424061020", "story_v_out_424061.awb")

						arg_81_1:RecordAudio("424061020", var_84_15)
						arg_81_1:RecordAudio("424061020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_424061", "424061020", "story_v_out_424061.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_424061", "424061020", "story_v_out_424061.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play424061021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424061021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play424061022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10153"]) and arg_85_1.var_.actorSpriteComps10153 == nil then
				arg_85_1.var_.actorSpriteComps10153 = arg_85_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10153"]) then
				if arg_85_1.var_.actorSpriteComps10153 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10153"]) and arg_85_1.var_.actorSpriteComps10153 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10153 = nil
			end

			local var_88_2 = arg_85_1.actors_["10153"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10153 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10153", 7)

				for iter_88_4 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_4)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_85_1.time_ - 0) / var_88_4)
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_88_5 = arg_85_1.actors_["10154"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10154 = var_88_5.localPosition
				var_88_5.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10154", 7)

				for iter_88_5 = 0, var_88_5.childCount - 1 do
					local var_88_6 = var_88_5:GetChild(iter_88_5)

					if var_88_6.name == "" or not string.find(var_88_6.name, "split") then
						var_88_6.gameObject:SetActive(true)
					else
						var_88_6.gameObject:SetActive(false)
					end
				end
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_85_1.time_ - 0) / var_88_7)
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.633333333333333 < arg_85_1.time_ and arg_85_1.time_ <= 0.633333333333333 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_146", "se_story_146_dark_sizzle", "")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_146", "se_story_146_bell", "")
			end

			local var_88_10 = 0
			local var_88_11 = 1.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_12 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(424061021).content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_14 = 45 <= 0 and var_88_11 or var_88_11 * (utf8.len(var_88_12) / 45)

				if (45 <= 0 and var_88_11 or var_88_11 * (utf8.len(var_88_12) / 45)) > 0 and var_88_11 < var_88_14 then
					arg_85_1.talkMaxDuration = var_88_14

					if var_88_14 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_15 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_15 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_15

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_15 and arg_85_1.time_ < var_88_10 + var_88_15 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_85_1:InitPlayNodeList()
	end,
	Play424061022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424061022
		arg_89_1.duration_ = 1.23

		local var_89_0 = {
			zh = 1.166,
			ja = 1.233
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
				arg_89_0:Play424061023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10153"]) and arg_89_1.var_.actorSpriteComps10153 == nil then
				arg_89_1.var_.actorSpriteComps10153 = arg_89_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10153"]) then
				if arg_89_1.var_.actorSpriteComps10153 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 1, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10153"]) and arg_89_1.var_.actorSpriteComps10153 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10153 = nil
			end

			local var_92_2 = arg_89_1.actors_["10153"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10153 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10153", 3)

				for iter_92_4 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_4)

					if var_92_3.name == "split_1" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_92_5 = 0
			local var_92_6 = 0.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(424061022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 3 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 3)

				if (3 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 3)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061022", "story_v_out_424061.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061022", "story_v_out_424061.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_424061", "424061022", "story_v_out_424061.awb")

						arg_89_1:RecordAudio("424061022", var_92_12)
						arg_89_1:RecordAudio("424061022", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424061", "424061022", "story_v_out_424061.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424061", "424061022", "story_v_out_424061.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424061023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424061023
		arg_93_1.duration_ = 7

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play424061024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0.966 < arg_93_1.time_ and arg_93_1.time_ <= 0.966 + arg_96_0 and not isNil(arg_93_1.actors_["10153"]) and arg_93_1.var_.actorSpriteComps10153 == nil then
				arg_93_1.var_.actorSpriteComps10153 = arg_93_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.034

			if 0.966 <= arg_93_1.time_ and arg_93_1.time_ < 0.966 + var_96_0 and not isNil(arg_93_1.actors_["10153"]) then
				if arg_93_1.var_.actorSpriteComps10153 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0.966) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0.966) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0.966) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 0.5, (arg_93_1.time_ - 0.966) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0.966 + var_96_0 and arg_93_1.time_ < 0.966 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10153"]) and arg_93_1.var_.actorSpriteComps10153 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10153 = nil
			end

			local var_96_2 = arg_93_1.actors_["10153"].transform

			if 0.966 < arg_93_1.time_ and arg_93_1.time_ <= 0.966 + arg_96_0 then
				arg_93_1.var_.moveOldPos10153 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10153", 7)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0.966 <= arg_93_1.time_ and arg_93_1.time_ < 0.966 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_93_1.time_ - 0.966) / var_96_4)
			end

			if arg_93_1.time_ >= 0.966 + var_96_4 and arg_93_1.time_ < 0.966 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.999999999999 < arg_93_1.time_ and arg_93_1.time_ <= 0.999999999999 + arg_96_0 then
				if arg_93_1.var_.effectlingshe1 then
					Object.Destroy(arg_93_1.var_.effectlingshe1)

					arg_93_1.var_.effectlingshe1 = nil
				end
			end

			local var_96_6 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_7 = 1

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 then
				local var_96_8 = Color.New(0, 0, 0)

				var_96_8.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_6) / var_96_7)
				arg_93_1.mask_.color = var_96_8
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 then
				local var_96_9 = Color.New(0, 0, 0)

				var_96_9.a = 1
				arg_93_1.mask_.color = var_96_9
			end

			local var_96_10 = 1

			if 1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_11 = 1

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 then
				local var_96_12 = Color.New(0, 0, 0)

				var_96_12.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_10) / var_96_11)
				arg_93_1.mask_.color = var_96_12
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 then
				local var_96_13 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_13.a = 0
				arg_93_1.mask_.color = var_96_13
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_14 = 2
			local var_96_15 = 1.175

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_16 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_16:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(424061023).content)

				arg_93_1.text_.text = var_96_17

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 47 <= 0 and var_96_15 or var_96_15 * (utf8.len(var_96_17) / 47)

				if (47 <= 0 and var_96_15 or var_96_15 * (utf8.len(var_96_17) / 47)) > 0 and var_96_15 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19
					var_96_14 = var_96_14 + 0.3

					if var_96_19 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_14
					end
				end

				arg_93_1.text_.text = var_96_17
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = var_96_14 + 0.3
			local var_96_21 = math.max(var_96_15, arg_93_1.talkMaxDuration)

			if var_96_14 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_20 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_20) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_20 + var_96_21 and arg_93_1.time_ < var_96_20 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play424061024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 424061024
		arg_99_1.duration_ = 3.4

		local var_99_0 = {
			zh = 2.5,
			ja = 3.4
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
				arg_99_0:Play424061025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_102_0 = 0.6

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				local var_102_1, var_102_2 = math.modf((arg_99_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_102_2 * 0.13, var_102_2 * 0.13, var_102_2 * 0.13) + arg_99_1.var_.shakeOldPos
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				manager.ui.mainCamera.transform.localPosition = arg_99_1.var_.shakeOldPos
			end

			local var_102_3 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_3 + 0.6 and arg_99_1.time_ < var_102_3 + 0.6 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_4 = 0
			local var_102_5 = 0.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1400].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_6 = arg_99_1:GetWordFromCfg(424061024)
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

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061024", "story_v_out_424061.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_424061", "424061024", "story_v_out_424061.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_424061", "424061024", "story_v_out_424061.awb")

						arg_99_1:RecordAudio("424061024", var_102_11)
						arg_99_1:RecordAudio("424061024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_424061", "424061024", "story_v_out_424061.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_424061", "424061024", "story_v_out_424061.awb")
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

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play424061025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 424061025
		arg_103_1.duration_ = 3.33

		local var_103_0 = {
			zh = 1.966,
			ja = 3.333
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
				arg_103_0:Play424061026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.275

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1398].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(424061025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 11 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 11)

				if (11 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 11)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061025", "story_v_out_424061.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061025", "story_v_out_424061.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_424061", "424061025", "story_v_out_424061.awb")

						arg_103_1:RecordAudio("424061025", var_106_6)
						arg_103_1:RecordAudio("424061025", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_424061", "424061025", "story_v_out_424061.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_424061", "424061025", "story_v_out_424061.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play424061026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424061026
		arg_107_1.duration_ = 10.37

		local var_107_0 = {
			zh = 8.2,
			ja = 10.366
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
				arg_107_0:Play424061027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10153"]) and arg_107_1.var_.actorSpriteComps10153 == nil then
				arg_107_1.var_.actorSpriteComps10153 = arg_107_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10153"]) then
				if arg_107_1.var_.actorSpriteComps10153 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 1, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10153"]) and arg_107_1.var_.actorSpriteComps10153 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10153 = nil
			end

			local var_110_2 = arg_107_1.actors_["10153"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10153 = var_110_2.localPosition
				var_110_2.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10153", 3)

				for iter_110_4 = 0, var_110_2.childCount - 1 do
					local var_110_3 = var_110_2:GetChild(iter_110_4)

					if var_110_3.name == "split_1" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_107_1.time_ - 0) / var_110_4)
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_110_5 = 0
			local var_110_6 = 0.85

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:GetWordFromCfg(424061026)
				local var_110_8 = arg_107_1:FormatText(var_110_7.content)

				arg_107_1.text_.text = var_110_8

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 34 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 34)

				if (34 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 34)) > 0 and var_110_6 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_8
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061026", "story_v_out_424061.awb") ~= 0 then
					local var_110_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061026", "story_v_out_424061.awb") / 1000

					if var_110_11 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_5
					end

					if var_110_7.prefab_name ~= "" and arg_107_1.actors_[var_110_7.prefab_name] ~= nil then
						local var_110_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_7.prefab_name].transform, "story_v_out_424061", "424061026", "story_v_out_424061.awb")

						arg_107_1:RecordAudio("424061026", var_110_12)
						arg_107_1:RecordAudio("424061026", var_110_12)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_424061", "424061026", "story_v_out_424061.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_424061", "424061026", "story_v_out_424061.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_13 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_13 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_13

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_13 and arg_107_1.time_ < var_110_5 + var_110_13 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play424061027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424061027
		arg_111_1.duration_ = 7

		local var_111_0 = {
			zh = 7,
			ja = 5.433
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
				arg_111_0:Play424061028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.775

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(424061027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 31 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 31)

				if (31 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 31)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061027", "story_v_out_424061.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061027", "story_v_out_424061.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_424061", "424061027", "story_v_out_424061.awb")

						arg_111_1:RecordAudio("424061027", var_114_6)
						arg_111_1:RecordAudio("424061027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_424061", "424061027", "story_v_out_424061.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_424061", "424061027", "story_v_out_424061.awb")
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
	Play424061028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424061028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play424061029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10153"]) and arg_115_1.var_.actorSpriteComps10153 == nil then
				arg_115_1.var_.actorSpriteComps10153 = arg_115_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10153"]) then
				if arg_115_1.var_.actorSpriteComps10153 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								iter_118_1.color = Color.New(Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_0), Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_0), (Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_0)))
							else
								local var_118_1 = Mathf.Lerp(iter_118_1.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_0)

								iter_118_1.color = Color.New(var_118_1, var_118_1, var_118_1)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10153"]) and arg_115_1.var_.actorSpriteComps10153 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10153 = nil
			end

			local var_118_2 = arg_115_1.actors_["10153"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10153 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10153", 7)

				for iter_118_4 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_4)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_115_1.time_ and arg_115_1.time_ <= 0.2 + arg_118_0 then
				arg_115_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_footstep", "")
			end

			local var_118_6 = 0
			local var_118_7 = 1.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(424061028).content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 43 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 43)

				if (43 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 43)) > 0 and var_118_7 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_11 and arg_115_1.time_ < var_118_6 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play424061029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424061029
		arg_119_1.duration_ = 1.93

		local var_119_0 = {
			zh = 1.933,
			ja = 1.7
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
				arg_119_0:Play424061030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1398].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(424061029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 8 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 8)

				if (8 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 8)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061029", "story_v_out_424061.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061029", "story_v_out_424061.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_424061", "424061029", "story_v_out_424061.awb")

						arg_119_1:RecordAudio("424061029", var_122_6)
						arg_119_1:RecordAudio("424061029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_424061", "424061029", "story_v_out_424061.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_424061", "424061029", "story_v_out_424061.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play424061030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424061030
		arg_123_1.duration_ = 5.87

		local var_123_0 = {
			zh = 5.333,
			ja = 5.866
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
				arg_123_0:Play424061031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10154"]) and arg_123_1.var_.actorSpriteComps10154 == nil then
				arg_123_1.var_.actorSpriteComps10154 = arg_123_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10154"]) then
				if arg_123_1.var_.actorSpriteComps10154 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 1, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10154"]) and arg_123_1.var_.actorSpriteComps10154 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10154 = nil
			end

			local var_126_2 = arg_123_1.actors_["10154"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10154 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10154", 3)

				for iter_126_4 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_4)

					if var_126_3.name == "split_1" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_126_5 = 0
			local var_126_6 = 0.525

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(424061030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 21 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 21)

				if (21 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 21)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061030", "story_v_out_424061.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061030", "story_v_out_424061.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_424061", "424061030", "story_v_out_424061.awb")

						arg_123_1:RecordAudio("424061030", var_126_12)
						arg_123_1:RecordAudio("424061030", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_424061", "424061030", "story_v_out_424061.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_424061", "424061030", "story_v_out_424061.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_13 and arg_123_1.time_ < var_126_5 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play424061031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424061031
		arg_127_1.duration_ = 2.37

		local var_127_0 = {
			zh = 1.566,
			ja = 2.366
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
				arg_127_0:Play424061032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10154"]) and arg_127_1.var_.actorSpriteComps10154 == nil then
				arg_127_1.var_.actorSpriteComps10154 = arg_127_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10154"]) then
				if arg_127_1.var_.actorSpriteComps10154 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10154"]) and arg_127_1.var_.actorSpriteComps10154 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10154 = nil
			end

			local var_130_2 = 0
			local var_130_3 = 0.075

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1401].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_4 = arg_127_1:GetWordFromCfg(424061031)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 3 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 3)

				if (3 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 3)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061031", "story_v_out_424061.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061031", "story_v_out_424061.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_out_424061", "424061031", "story_v_out_424061.awb")

						arg_127_1:RecordAudio("424061031", var_130_9)
						arg_127_1:RecordAudio("424061031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_424061", "424061031", "story_v_out_424061.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_424061", "424061031", "story_v_out_424061.awb")
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
	Play424061032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424061032
		arg_131_1.duration_ = 3.3

		local var_131_0 = {
			zh = 2.733,
			ja = 3.3
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
				arg_131_0:Play424061033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10154"]) and arg_131_1.var_.actorSpriteComps10154 == nil then
				arg_131_1.var_.actorSpriteComps10154 = arg_131_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10154"]) then
				if arg_131_1.var_.actorSpriteComps10154 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 1, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10154"]) and arg_131_1.var_.actorSpriteComps10154 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10154 = nil
			end

			local var_134_2 = 0
			local var_134_3 = 0.35

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(424061032)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 14 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 14)

				if (14 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 14)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061032", "story_v_out_424061.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061032", "story_v_out_424061.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_424061", "424061032", "story_v_out_424061.awb")

						arg_131_1:RecordAudio("424061032", var_134_9)
						arg_131_1:RecordAudio("424061032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424061", "424061032", "story_v_out_424061.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424061", "424061032", "story_v_out_424061.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play424061033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424061033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play424061034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10154"]) and arg_135_1.var_.actorSpriteComps10154 == nil then
				arg_135_1.var_.actorSpriteComps10154 = arg_135_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10154"]) then
				if arg_135_1.var_.actorSpriteComps10154 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10154"]) and arg_135_1.var_.actorSpriteComps10154 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10154 = nil
			end

			local var_138_2 = arg_135_1.actors_["10154"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10154 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10154", 7)

				for iter_138_4 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_4)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_135_1.time_ and arg_135_1.time_ <= 0.3 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_walk", "")
			end

			local var_138_6 = 0
			local var_138_7 = 1.3

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(424061033).content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 52 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_8) / 52)

				if (52 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_8) / 52)) > 0 and var_138_7 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_11 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_11 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_11

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_11 and arg_135_1.time_ < var_138_6 + var_138_11 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play424061034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424061034
		arg_139_1.duration_ = 6.13

		local var_139_0 = {
			zh = 3.8,
			ja = 6.133
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
				arg_139_0:Play424061035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10154"]) and arg_139_1.var_.actorSpriteComps10154 == nil then
				arg_139_1.var_.actorSpriteComps10154 = arg_139_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10154"]) then
				if arg_139_1.var_.actorSpriteComps10154 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10154"]) and arg_139_1.var_.actorSpriteComps10154 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10154 = nil
			end

			local var_142_2 = arg_139_1.actors_["10154"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10154 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10154", 3)

				for iter_142_4 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_4)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_142_5 = 0
			local var_142_6 = 0.55

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(424061034)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 22 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 22)

				if (22 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 22)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061034", "story_v_out_424061.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061034", "story_v_out_424061.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_424061", "424061034", "story_v_out_424061.awb")

						arg_139_1:RecordAudio("424061034", var_142_12)
						arg_139_1:RecordAudio("424061034", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_424061", "424061034", "story_v_out_424061.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_424061", "424061034", "story_v_out_424061.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_13 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_13 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_13

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_13 and arg_139_1.time_ < var_142_5 + var_142_13 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play424061035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424061035
		arg_143_1.duration_ = 11.13

		local var_143_0 = {
			zh = 6.766,
			ja = 11.133
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
				arg_143_0:Play424061036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10154"]) and arg_143_1.var_.actorSpriteComps10154 == nil then
				arg_143_1.var_.actorSpriteComps10154 = arg_143_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10154"]) then
				if arg_143_1.var_.actorSpriteComps10154 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10154"]) and arg_143_1.var_.actorSpriteComps10154 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10154 = nil
			end

			local var_146_2 = 0
			local var_146_3 = 0.975

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_4 = arg_143_1:GetWordFromCfg(424061035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 39 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 39)

				if (39 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 39)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061035", "story_v_out_424061.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061035", "story_v_out_424061.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_424061", "424061035", "story_v_out_424061.awb")

						arg_143_1:RecordAudio("424061035", var_146_9)
						arg_143_1:RecordAudio("424061035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_424061", "424061035", "story_v_out_424061.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_424061", "424061035", "story_v_out_424061.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424061036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424061036
		arg_147_1.duration_ = 8.7

		local var_147_0 = {
			zh = 7.4,
			ja = 8.7
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
				arg_147_0:Play424061037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.925

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:GetWordFromCfg(424061036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 37 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 37)

				if (37 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 37)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061036", "story_v_out_424061.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061036", "story_v_out_424061.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_424061", "424061036", "story_v_out_424061.awb")

						arg_147_1:RecordAudio("424061036", var_150_6)
						arg_147_1:RecordAudio("424061036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_424061", "424061036", "story_v_out_424061.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_424061", "424061036", "story_v_out_424061.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play424061037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424061037
		arg_151_1.duration_ = 4.53

		local var_151_0 = {
			zh = 3.766,
			ja = 4.533
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
				arg_151_0:Play424061038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10153"]) and arg_151_1.var_.actorSpriteComps10153 == nil then
				arg_151_1.var_.actorSpriteComps10153 = arg_151_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10153"]) then
				if arg_151_1.var_.actorSpriteComps10153 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10153"]) and arg_151_1.var_.actorSpriteComps10153 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10153 = nil
			end

			local var_154_2 = arg_151_1.actors_["10153"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10153 = var_154_2.localPosition
				var_154_2.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10153", 4)

				for iter_154_4 = 0, var_154_2.childCount - 1 do
					local var_154_3 = var_154_2:GetChild(iter_154_4)

					if var_154_3.name == "" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_2.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_151_1.time_ - 0) / var_154_4)
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_2.localPosition = Vector3.New(400, -395, -330)
			end

			local var_154_5 = arg_151_1.actors_["10154"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10154 = var_154_5.localPosition
				var_154_5.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10154", 2)

				for iter_154_5 = 0, var_154_5.childCount - 1 do
					local var_154_6 = var_154_5:GetChild(iter_154_5)

					if var_154_6.name == "" or not string.find(var_154_6.name, "split") then
						var_154_6.gameObject:SetActive(true)
					else
						var_154_6.gameObject:SetActive(false)
					end
				end
			end

			local var_154_7 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				var_154_5.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_151_1.time_ - 0) / var_154_7)
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				var_154_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_154_8 = 0
			local var_154_9 = 0.45

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(424061037)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 18 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 18)

				if (18 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 18)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061037", "story_v_out_424061.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061037", "story_v_out_424061.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_424061", "424061037", "story_v_out_424061.awb")

						arg_151_1:RecordAudio("424061037", var_154_15)
						arg_151_1:RecordAudio("424061037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424061", "424061037", "story_v_out_424061.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424061", "424061037", "story_v_out_424061.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_16 and arg_151_1.time_ < var_154_8 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_151_1:InitPlayNodeList()
	end,
	Play424061038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424061038
		arg_155_1.duration_ = 7.73

		local var_155_0 = {
			zh = 6.733,
			ja = 7.733
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
				arg_155_0:Play424061039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10153"]) and arg_155_1.var_.actorSpriteComps10153 == nil then
				arg_155_1.var_.actorSpriteComps10153 = arg_155_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10153"]) then
				if arg_155_1.var_.actorSpriteComps10153 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10153"]) and arg_155_1.var_.actorSpriteComps10153 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10153 = nil
			end

			local var_158_2 = 0
			local var_158_3 = 0.775

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_4 = arg_155_1:GetWordFromCfg(424061038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 31 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 31)

				if (31 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 31)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061038", "story_v_out_424061.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061038", "story_v_out_424061.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_424061", "424061038", "story_v_out_424061.awb")

						arg_155_1:RecordAudio("424061038", var_158_9)
						arg_155_1:RecordAudio("424061038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424061", "424061038", "story_v_out_424061.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424061", "424061038", "story_v_out_424061.awb")
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
	Play424061039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424061039
		arg_159_1.duration_ = 4.6

		local var_159_0 = {
			zh = 2.433,
			ja = 4.6
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
				arg_159_0:Play424061040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10153"]) and arg_159_1.var_.actorSpriteComps10153 == nil then
				arg_159_1.var_.actorSpriteComps10153 = arg_159_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10153"]) then
				if arg_159_1.var_.actorSpriteComps10153 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 1, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10153"]) and arg_159_1.var_.actorSpriteComps10153 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10153 = nil
			end

			local var_162_2 = arg_159_1.actors_["10153"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10153 = var_162_2.localPosition
				var_162_2.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10153", 4)

				for iter_162_4 = 0, var_162_2.childCount - 1 do
					local var_162_3 = var_162_2:GetChild(iter_162_4)

					if var_162_3.name == "" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_2.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_159_1.time_ - 0) / var_162_4)
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_2.localPosition = Vector3.New(400, -395, -330)
			end

			local var_162_5 = 0
			local var_162_6 = 0.325

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(424061039)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 13 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 13)

				if (13 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 13)) > 0 and var_162_6 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061039", "story_v_out_424061.awb") ~= 0 then
					local var_162_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061039", "story_v_out_424061.awb") / 1000

					if var_162_11 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_5
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_424061", "424061039", "story_v_out_424061.awb")

						arg_159_1:RecordAudio("424061039", var_162_12)
						arg_159_1:RecordAudio("424061039", var_162_12)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_424061", "424061039", "story_v_out_424061.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_424061", "424061039", "story_v_out_424061.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_13 and arg_159_1.time_ < var_162_5 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play424061040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424061040
		arg_163_1.duration_ = 8.67

		local var_163_0 = {
			zh = 8.666,
			ja = 3.866
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
				arg_163_0:Play424061041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10153"]) and arg_163_1.var_.actorSpriteComps10153 == nil then
				arg_163_1.var_.actorSpriteComps10153 = arg_163_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10153"]) then
				if arg_163_1.var_.actorSpriteComps10153 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10153"]) and arg_163_1.var_.actorSpriteComps10153 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10153 = nil
			end

			local var_166_2 = 0
			local var_166_3 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_4 = arg_163_1:GetWordFromCfg(424061040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 29 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 29)

				if (29 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 29)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061040", "story_v_out_424061.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061040", "story_v_out_424061.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_424061", "424061040", "story_v_out_424061.awb")

						arg_163_1:RecordAudio("424061040", var_166_9)
						arg_163_1:RecordAudio("424061040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_424061", "424061040", "story_v_out_424061.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_424061", "424061040", "story_v_out_424061.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play424061041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424061041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play424061042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(424061041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 44 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 44)

				if (44 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 44)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play424061042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424061042
		arg_171_1.duration_ = 3.63

		local var_171_0 = {
			zh = 3.133,
			ja = 3.633
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
				arg_171_0:Play424061043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10153"]) and arg_171_1.var_.actorSpriteComps10153 == nil then
				arg_171_1.var_.actorSpriteComps10153 = arg_171_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10153"]) then
				if arg_171_1.var_.actorSpriteComps10153 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10153"]) and arg_171_1.var_.actorSpriteComps10153 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10153 = nil
			end

			local var_174_2 = arg_171_1.actors_["10153"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10153 = var_174_2.localPosition
				var_174_2.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10153", 4)

				for iter_174_4 = 0, var_174_2.childCount - 1 do
					local var_174_3 = var_174_2:GetChild(iter_174_4)

					if var_174_3.name == "split_3" then
						var_174_3:SetAsLastSibling()
						var_174_3.gameObject:SetActive(true)

						arg_171_1.var_.actorSpriteSplit10153 = var_174_3.gameObject:GetComponent(typeof(Image))

						arg_171_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_174_4 = 0.5

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_2.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_171_1.time_ - 0) / var_174_4)

				if arg_171_1.var_.actorSpriteSplit10153 ~= nil then
					arg_171_1.var_.actorSpriteSplit10153:SetAlpha((arg_171_1.time_ - 0) / var_174_4)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_2.localPosition = Vector3.New(400, -395, -330)

				if arg_171_1.var_.actorSpriteSplit10153 ~= nil then
					arg_171_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_174_5 = 0
			local var_174_6 = 0.3

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(424061042)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 12 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 12)

				if (12 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 12)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061042", "story_v_out_424061.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061042", "story_v_out_424061.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_424061", "424061042", "story_v_out_424061.awb")

						arg_171_1:RecordAudio("424061042", var_174_12)
						arg_171_1:RecordAudio("424061042", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_424061", "424061042", "story_v_out_424061.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_424061", "424061042", "story_v_out_424061.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play424061043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424061043
		arg_175_1.duration_ = 8.37

		local var_175_0 = {
			zh = 7.266,
			ja = 8.366
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
				arg_175_0:Play424061044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10154"]) and arg_175_1.var_.actorSpriteComps10154 == nil then
				arg_175_1.var_.actorSpriteComps10154 = arg_175_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10154"]) then
				if arg_175_1.var_.actorSpriteComps10154 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 1, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10154"]) and arg_175_1.var_.actorSpriteComps10154 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10154 = nil
			end

			local var_178_2 = arg_175_1.actors_["10153"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10153 == nil then
				arg_175_1.var_.actorSpriteComps10153 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps10153 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								iter_178_5.color = Color.New(Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_5.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_5.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10153 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10153 = nil
			end

			local var_178_5 = arg_175_1.actors_["10154"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10154 = var_178_5.localPosition
				var_178_5.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10154", 2)

				for iter_178_8 = 0, var_178_5.childCount - 1 do
					local var_178_6 = var_178_5:GetChild(iter_178_8)

					if var_178_6.name == "split_1" or not string.find(var_178_6.name, "split") then
						var_178_6.gameObject:SetActive(true)
					else
						var_178_6.gameObject:SetActive(false)
					end
				end
			end

			local var_178_7 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_175_1.time_ - 0) / var_178_7)
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_178_8 = 0
			local var_178_9 = 0.875

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(424061043)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 35 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 35)

				if (35 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 35)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061043", "story_v_out_424061.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061043", "story_v_out_424061.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_424061", "424061043", "story_v_out_424061.awb")

						arg_175_1:RecordAudio("424061043", var_178_15)
						arg_175_1:RecordAudio("424061043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_424061", "424061043", "story_v_out_424061.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_424061", "424061043", "story_v_out_424061.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play424061044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424061044
		arg_179_1.duration_ = 6.3

		local var_179_0 = {
			zh = 5.433,
			ja = 6.3
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
				arg_179_0:Play424061045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10154"]) and arg_179_1.var_.actorSpriteComps10154 == nil then
				arg_179_1.var_.actorSpriteComps10154 = arg_179_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10154"]) then
				if arg_179_1.var_.actorSpriteComps10154 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10154"]) and arg_179_1.var_.actorSpriteComps10154 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10154 = nil
			end

			local var_182_2 = 0
			local var_182_3 = 0.6

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_4 = arg_179_1:GetWordFromCfg(424061044)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 24 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 24)

				if (24 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 24)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061044", "story_v_out_424061.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061044", "story_v_out_424061.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_out_424061", "424061044", "story_v_out_424061.awb")

						arg_179_1:RecordAudio("424061044", var_182_9)
						arg_179_1:RecordAudio("424061044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_424061", "424061044", "story_v_out_424061.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_424061", "424061044", "story_v_out_424061.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play424061045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424061045
		arg_183_1.duration_ = 2.93

		local var_183_0 = {
			zh = 2.933,
			ja = 2.066
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
				arg_183_0:Play424061046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10154"]) and arg_183_1.var_.actorSpriteComps10154 == nil then
				arg_183_1.var_.actorSpriteComps10154 = arg_183_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10154"]) then
				if arg_183_1.var_.actorSpriteComps10154 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10154"]) and arg_183_1.var_.actorSpriteComps10154 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10154 = nil
			end

			local var_186_2 = arg_183_1.actors_["10154"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10154 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10154", 2)

				for iter_186_4 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_4)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_186_5 = 0
			local var_186_6 = 0.375

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_7 = arg_183_1:GetWordFromCfg(424061045)
				local var_186_8 = arg_183_1:FormatText(var_186_7.content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 15 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 15)

				if (15 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 15)) > 0 and var_186_6 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_5
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061045", "story_v_out_424061.awb") ~= 0 then
					local var_186_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061045", "story_v_out_424061.awb") / 1000

					if var_186_11 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_5
					end

					if var_186_7.prefab_name ~= "" and arg_183_1.actors_[var_186_7.prefab_name] ~= nil then
						local var_186_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_7.prefab_name].transform, "story_v_out_424061", "424061045", "story_v_out_424061.awb")

						arg_183_1:RecordAudio("424061045", var_186_12)
						arg_183_1:RecordAudio("424061045", var_186_12)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_424061", "424061045", "story_v_out_424061.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_424061", "424061045", "story_v_out_424061.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_6, arg_183_1.talkMaxDuration)

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_5) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_5 + var_186_13 and arg_183_1.time_ < var_186_5 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play424061046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424061046
		arg_187_1.duration_ = 6.2

		local var_187_0 = {
			zh = 4.833,
			ja = 6.2
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
				arg_187_0:Play424061047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10154"]) and arg_187_1.var_.actorSpriteComps10154 == nil then
				arg_187_1.var_.actorSpriteComps10154 = arg_187_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10154"]) then
				if arg_187_1.var_.actorSpriteComps10154 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								iter_190_1.color = Color.New(Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_0), Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_0), (Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_0)))
							else
								local var_190_1 = Mathf.Lerp(iter_190_1.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_0)

								iter_190_1.color = Color.New(var_190_1, var_190_1, var_190_1)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10154"]) and arg_187_1.var_.actorSpriteComps10154 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_190_3 then
						iter_190_3.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10154 = nil
			end

			local var_190_2 = 0
			local var_190_3 = 0.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_4 = arg_187_1:GetWordFromCfg(424061046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 22 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 22)

				if (22 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 22)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061046", "story_v_out_424061.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061046", "story_v_out_424061.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_424061", "424061046", "story_v_out_424061.awb")

						arg_187_1:RecordAudio("424061046", var_190_9)
						arg_187_1:RecordAudio("424061046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_424061", "424061046", "story_v_out_424061.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_424061", "424061046", "story_v_out_424061.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play424061047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424061047
		arg_191_1.duration_ = 4.8

		local var_191_0 = {
			zh = 3.866,
			ja = 4.8
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
				arg_191_0:Play424061048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10154"]) and arg_191_1.var_.actorSpriteComps10154 == nil then
				arg_191_1.var_.actorSpriteComps10154 = arg_191_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10154"]) then
				if arg_191_1.var_.actorSpriteComps10154 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 1, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10154"]) and arg_191_1.var_.actorSpriteComps10154 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10154 = nil
			end

			local var_194_2 = arg_191_1.actors_["10154"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10154 = var_194_2.localPosition
				var_194_2.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10154", 2)

				for iter_194_4 = 0, var_194_2.childCount - 1 do
					local var_194_3 = var_194_2:GetChild(iter_194_4)

					if var_194_3.name == "split_3" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_2.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_191_1.time_ - 0) / var_194_4)
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_194_5 = 0
			local var_194_6 = 0.625

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(424061047)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 25 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 25)

				if (25 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 25)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061047", "story_v_out_424061.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061047", "story_v_out_424061.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_424061", "424061047", "story_v_out_424061.awb")

						arg_191_1:RecordAudio("424061047", var_194_12)
						arg_191_1:RecordAudio("424061047", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_424061", "424061047", "story_v_out_424061.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_424061", "424061047", "story_v_out_424061.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_13 and arg_191_1.time_ < var_194_5 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play424061048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424061048
		arg_195_1.duration_ = 2.47

		local var_195_0 = {
			zh = 1.866,
			ja = 2.466
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
				arg_195_0:Play424061049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10154"]) and arg_195_1.var_.actorSpriteComps10154 == nil then
				arg_195_1.var_.actorSpriteComps10154 = arg_195_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10154"]) then
				if arg_195_1.var_.actorSpriteComps10154 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10154"]) and arg_195_1.var_.actorSpriteComps10154 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10154 = nil
			end

			local var_198_2 = 0
			local var_198_3 = 0.25

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_4 = arg_195_1:GetWordFromCfg(424061048)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 10 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 10)

				if (10 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 10)) > 0 and var_198_3 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061048", "story_v_out_424061.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061048", "story_v_out_424061.awb") / 1000

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_out_424061", "424061048", "story_v_out_424061.awb")

						arg_195_1:RecordAudio("424061048", var_198_9)
						arg_195_1:RecordAudio("424061048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424061", "424061048", "story_v_out_424061.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424061", "424061048", "story_v_out_424061.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_10 and arg_195_1.time_ < var_198_2 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play424061049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424061049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play424061050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(424061049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 27 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 27)

				if (27 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 27)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play424061050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 424061050
		arg_203_1.duration_ = 2.17

		local var_203_0 = {
			zh = 1.4,
			ja = 2.166
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
				arg_203_0:Play424061051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10154"]) and arg_203_1.var_.actorSpriteComps10154 == nil then
				arg_203_1.var_.actorSpriteComps10154 = arg_203_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10154"]) then
				if arg_203_1.var_.actorSpriteComps10154 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 1, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10154"]) and arg_203_1.var_.actorSpriteComps10154 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps10154 = nil
			end

			local var_206_2 = arg_203_1.actors_["10154"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10154 = var_206_2.localPosition
				var_206_2.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10154", 2)

				for iter_206_4 = 0, var_206_2.childCount - 1 do
					local var_206_3 = var_206_2:GetChild(iter_206_4)

					if var_206_3.name == "split_1" then
						var_206_3:SetAsLastSibling()
						var_206_3.gameObject:SetActive(true)

						arg_203_1.var_.actorSpriteSplit10154 = var_206_3.gameObject:GetComponent(typeof(Image))

						arg_203_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_206_4 = 0.5

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_2.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_203_1.time_ - 0) / var_206_4)

				if arg_203_1.var_.actorSpriteSplit10154 ~= nil then
					arg_203_1.var_.actorSpriteSplit10154:SetAlpha((arg_203_1.time_ - 0) / var_206_4)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_2.localPosition = Vector3.New(-375, -338, -538)

				if arg_203_1.var_.actorSpriteSplit10154 ~= nil then
					arg_203_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_206_5 = 0
			local var_206_6 = 0.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(424061050)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 7 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 7)

				if (7 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 7)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061050", "story_v_out_424061.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061050", "story_v_out_424061.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_424061", "424061050", "story_v_out_424061.awb")

						arg_203_1:RecordAudio("424061050", var_206_12)
						arg_203_1:RecordAudio("424061050", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_424061", "424061050", "story_v_out_424061.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_424061", "424061050", "story_v_out_424061.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play424061051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424061051
		arg_207_1.duration_ = 6.2

		local var_207_0 = {
			zh = 6.2,
			ja = 5.066
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
				arg_207_0:Play424061052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10154 = arg_207_1.actors_["10154"].transform.localPosition
				arg_207_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10154", 2)

				for iter_210_0 = 0, arg_207_1.actors_["10154"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["10154"].transform:GetChild(iter_210_0)

					if var_210_0.name == "" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["10154"].transform.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_210_2 = 0
			local var_210_3 = 0.625

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(424061051)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 25 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 25)

				if (25 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 25)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061051", "story_v_out_424061.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061051", "story_v_out_424061.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_424061", "424061051", "story_v_out_424061.awb")

						arg_207_1:RecordAudio("424061051", var_210_9)
						arg_207_1:RecordAudio("424061051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_424061", "424061051", "story_v_out_424061.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_424061", "424061051", "story_v_out_424061.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play424061052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424061052
		arg_211_1.duration_ = 1.73

		local var_211_0 = {
			zh = 1.566,
			ja = 1.733
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
				arg_211_0:Play424061053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10154"]) and arg_211_1.var_.actorSpriteComps10154 == nil then
				arg_211_1.var_.actorSpriteComps10154 = arg_211_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10154"]) then
				if arg_211_1.var_.actorSpriteComps10154 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10154"]) and arg_211_1.var_.actorSpriteComps10154 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10154 = nil
			end

			local var_214_2 = 0
			local var_214_3 = 0.15

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1402].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_4 = arg_211_1:GetWordFromCfg(424061052)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 6 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 6)

				if (6 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 6)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061052", "story_v_out_424061.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061052", "story_v_out_424061.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_424061", "424061052", "story_v_out_424061.awb")

						arg_211_1:RecordAudio("424061052", var_214_9)
						arg_211_1:RecordAudio("424061052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_424061", "424061052", "story_v_out_424061.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_424061", "424061052", "story_v_out_424061.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play424061053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424061053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play424061054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10154 = arg_215_1.actors_["10154"].transform.localPosition
				arg_215_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10154", 7)

				for iter_218_0 = 0, arg_215_1.actors_["10154"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["10154"].transform:GetChild(iter_218_0)

					if var_218_0.name == "" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_215_1.time_ - 0) / var_218_1)
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["10154"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_2 = arg_215_1.actors_["10153"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10153 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10153", 7)

				for iter_218_1 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_1)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_215_1.time_ and arg_215_1.time_ <= 0.034 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_146", "se_story_146_walk", "")
			end

			local var_218_6 = 0
			local var_218_7 = 0.725

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(424061053).content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 29 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_8) / 29)

				if (29 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_8) / 29)) > 0 and var_218_7 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_11 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_11 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_11

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_11 and arg_215_1.time_ < var_218_6 + var_218_11 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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
				actorName = "10153",
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
	Play424061054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424061054
		arg_219_1.duration_ = 1.73

		local var_219_0 = {
			zh = 1.3,
			ja = 1.733
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
				arg_219_0:Play424061055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10153"]) and arg_219_1.var_.actorSpriteComps10153 == nil then
				arg_219_1.var_.actorSpriteComps10153 = arg_219_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["10153"]) then
				if arg_219_1.var_.actorSpriteComps10153 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								iter_222_1.color = Color.New(Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_0), Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_0), (Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_0)))
							else
								local var_222_1 = Mathf.Lerp(iter_222_1.color.r, 1, (arg_219_1.time_ - 0) / var_222_0)

								iter_222_1.color = Color.New(var_222_1, var_222_1, var_222_1)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["10153"]) and arg_219_1.var_.actorSpriteComps10153 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps10153 = nil
			end

			local var_222_2 = arg_219_1.actors_["10153"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10153 = var_222_2.localPosition
				var_222_2.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10153", 3)

				for iter_222_4 = 0, var_222_2.childCount - 1 do
					local var_222_3 = var_222_2:GetChild(iter_222_4)

					if var_222_3.name == "split_3" or not string.find(var_222_3.name, "split") then
						var_222_3.gameObject:SetActive(true)
					else
						var_222_3.gameObject:SetActive(false)
					end
				end
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_2.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_219_1.time_ - 0) / var_222_4)
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_222_5 = 0
			local var_222_6 = 0.1

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_7 = arg_219_1:GetWordFromCfg(424061054)
				local var_222_8 = arg_219_1:FormatText(var_222_7.content)

				arg_219_1.text_.text = var_222_8

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_10 = 4 <= 0 and var_222_6 or var_222_6 * (utf8.len(var_222_8) / 4)

				if (4 <= 0 and var_222_6 or var_222_6 * (utf8.len(var_222_8) / 4)) > 0 and var_222_6 < var_222_10 then
					arg_219_1.talkMaxDuration = var_222_10

					if var_222_10 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_5
					end
				end

				arg_219_1.text_.text = var_222_8
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061054", "story_v_out_424061.awb") ~= 0 then
					local var_222_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061054", "story_v_out_424061.awb") / 1000

					if var_222_11 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_5
					end

					if var_222_7.prefab_name ~= "" and arg_219_1.actors_[var_222_7.prefab_name] ~= nil then
						local var_222_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_7.prefab_name].transform, "story_v_out_424061", "424061054", "story_v_out_424061.awb")

						arg_219_1:RecordAudio("424061054", var_222_12)
						arg_219_1:RecordAudio("424061054", var_222_12)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_424061", "424061054", "story_v_out_424061.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_424061", "424061054", "story_v_out_424061.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = math.max(var_222_6, arg_219_1.talkMaxDuration)

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_13 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_5) / var_222_13

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_5 + var_222_13 and arg_219_1.time_ < var_222_5 + var_222_13 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play424061055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424061055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play424061056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10153"]) and arg_223_1.var_.actorSpriteComps10153 == nil then
				arg_223_1.var_.actorSpriteComps10153 = arg_223_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10153"]) then
				if arg_223_1.var_.actorSpriteComps10153 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10153"]) and arg_223_1.var_.actorSpriteComps10153 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps10153 = nil
			end

			local var_226_2 = arg_223_1.actors_["10153"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10153 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10153", 7)

				for iter_226_4 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_4)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_226_5 = 0
			local var_226_6 = 1.1

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(424061055).content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 44 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_7) / 44)

				if (44 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_7) / 44)) > 0 and var_226_6 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_10 and arg_223_1.time_ < var_226_5 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play424061056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 424061056
		arg_227_1.duration_ = 1.2

		local var_227_0 = {
			zh = 1.2,
			ja = 1.166
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
				arg_227_0:Play424061057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["10154"]) and arg_227_1.var_.actorSpriteComps10154 == nil then
				arg_227_1.var_.actorSpriteComps10154 = arg_227_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["10154"]) then
				if arg_227_1.var_.actorSpriteComps10154 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 1, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["10154"]) and arg_227_1.var_.actorSpriteComps10154 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps10154 = nil
			end

			local var_230_2 = arg_227_1.actors_["10154"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10154 = var_230_2.localPosition
				var_230_2.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10154", 2)

				for iter_230_4 = 0, var_230_2.childCount - 1 do
					local var_230_3 = var_230_2:GetChild(iter_230_4)

					if var_230_3.name == "" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_2.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_227_1.time_ - 0) / var_230_4)
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_230_5 = 0
			local var_230_6 = 0.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_7 = arg_227_1:GetWordFromCfg(424061056)
				local var_230_8 = arg_227_1:FormatText(var_230_7.content)

				arg_227_1.text_.text = var_230_8

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_10 = 5 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_8) / 5)

				if (5 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_8) / 5)) > 0 and var_230_6 < var_230_10 then
					arg_227_1.talkMaxDuration = var_230_10

					if var_230_10 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_5
					end
				end

				arg_227_1.text_.text = var_230_8
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061056", "story_v_out_424061.awb") ~= 0 then
					local var_230_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061056", "story_v_out_424061.awb") / 1000

					if var_230_11 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_5
					end

					if var_230_7.prefab_name ~= "" and arg_227_1.actors_[var_230_7.prefab_name] ~= nil then
						local var_230_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_7.prefab_name].transform, "story_v_out_424061", "424061056", "story_v_out_424061.awb")

						arg_227_1:RecordAudio("424061056", var_230_12)
						arg_227_1:RecordAudio("424061056", var_230_12)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_424061", "424061056", "story_v_out_424061.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_424061", "424061056", "story_v_out_424061.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_13 = math.max(var_230_6, arg_227_1.talkMaxDuration)

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_13 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_5) / var_230_13

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_5 + var_230_13 and arg_227_1.time_ < var_230_5 + var_230_13 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play424061057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 424061057
		arg_231_1.duration_ = 9

		local var_231_0 = {
			zh = 6,
			ja = 9
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
				arg_231_0:Play424061058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10153"]) and arg_231_1.var_.actorSpriteComps10153 == nil then
				arg_231_1.var_.actorSpriteComps10153 = arg_231_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10153"]) then
				if arg_231_1.var_.actorSpriteComps10153 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10153"]) and arg_231_1.var_.actorSpriteComps10153 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps10153 = nil
			end

			local var_234_2 = arg_231_1.actors_["10154"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10154 == nil then
				arg_231_1.var_.actorSpriteComps10154 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps10154 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								iter_234_5.color = Color.New(Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_5.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_5.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10154 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_234_7 then
						iter_234_7.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps10154 = nil
			end

			local var_234_5 = arg_231_1.actors_["10153"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10153 = var_234_5.localPosition
				var_234_5.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10153", 4)

				for iter_234_8 = 0, var_234_5.childCount - 1 do
					local var_234_6 = var_234_5:GetChild(iter_234_8)

					if var_234_6.name == "split_1" or not string.find(var_234_6.name, "split") then
						var_234_6.gameObject:SetActive(true)
					else
						var_234_6.gameObject:SetActive(false)
					end
				end
			end

			local var_234_7 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				var_234_5.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_231_1.time_ - 0) / var_234_7)
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				var_234_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_234_8 = 0
			local var_234_9 = 0.675

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(424061057)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 27 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 27)

				if (27 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 27)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061057", "story_v_out_424061.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061057", "story_v_out_424061.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_424061", "424061057", "story_v_out_424061.awb")

						arg_231_1:RecordAudio("424061057", var_234_15)
						arg_231_1:RecordAudio("424061057", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_424061", "424061057", "story_v_out_424061.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_424061", "424061057", "story_v_out_424061.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_16 and arg_231_1.time_ < var_234_8 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play424061058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 424061058
		arg_235_1.duration_ = 4.77

		local var_235_0 = {
			zh = 4.233,
			ja = 4.766
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
				arg_235_0:Play424061059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10154"]) and arg_235_1.var_.actorSpriteComps10154 == nil then
				arg_235_1.var_.actorSpriteComps10154 = arg_235_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10154"]) then
				if arg_235_1.var_.actorSpriteComps10154 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 1, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10154"]) and arg_235_1.var_.actorSpriteComps10154 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10154 = nil
			end

			local var_238_2 = arg_235_1.actors_["10153"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps10153 == nil then
				arg_235_1.var_.actorSpriteComps10153 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps10153 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								iter_238_5.color = Color.New(Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_5.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_5.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps10153 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_238_7 then
						iter_238_7.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps10153 = nil
			end

			local var_238_5 = arg_235_1.actors_["10154"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10154 = var_238_5.localPosition
				var_238_5.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10154", 2)

				for iter_238_8 = 0, var_238_5.childCount - 1 do
					local var_238_6 = var_238_5:GetChild(iter_238_8)

					if var_238_6.name == "" or not string.find(var_238_6.name, "split") then
						var_238_6.gameObject:SetActive(true)
					else
						var_238_6.gameObject:SetActive(false)
					end
				end
			end

			local var_238_7 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				var_238_5.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_235_1.time_ - 0) / var_238_7)
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				var_238_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_238_8 = 0
			local var_238_9 = 0.525

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(424061058)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 21 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 21)

				if (21 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 21)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061058", "story_v_out_424061.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061058", "story_v_out_424061.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_424061", "424061058", "story_v_out_424061.awb")

						arg_235_1:RecordAudio("424061058", var_238_15)
						arg_235_1:RecordAudio("424061058", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_424061", "424061058", "story_v_out_424061.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_424061", "424061058", "story_v_out_424061.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play424061059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 424061059
		arg_239_1.duration_ = 10.37

		local var_239_0 = {
			zh = 8.933,
			ja = 10.366
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
				arg_239_0:Play424061060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10153"]) and arg_239_1.var_.actorSpriteComps10153 == nil then
				arg_239_1.var_.actorSpriteComps10153 = arg_239_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10153"]) then
				if arg_239_1.var_.actorSpriteComps10153 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 1, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10153"]) and arg_239_1.var_.actorSpriteComps10153 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps10153 = nil
			end

			local var_242_2 = arg_239_1.actors_["10154"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10154 == nil then
				arg_239_1.var_.actorSpriteComps10154 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps10154 then
					for iter_242_4, iter_242_5 in pairs(arg_239_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_242_5 then
							if arg_239_1.isInRecall_ then
								iter_242_5.color = Color.New(Mathf.Lerp(iter_242_5.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_5.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_5.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_5.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_5.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10154 then
				for iter_242_6, iter_242_7 in pairs(arg_239_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_242_7 then
						iter_242_7.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10154 = nil
			end

			local var_242_5 = arg_239_1.actors_["10153"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10153 = var_242_5.localPosition
				var_242_5.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10153", 4)

				for iter_242_8 = 0, var_242_5.childCount - 1 do
					local var_242_6 = var_242_5:GetChild(iter_242_8)

					if var_242_6.name == "" or not string.find(var_242_6.name, "split") then
						var_242_6.gameObject:SetActive(true)
					else
						var_242_6.gameObject:SetActive(false)
					end
				end
			end

			local var_242_7 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				var_242_5.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_239_1.time_ - 0) / var_242_7)
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				var_242_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_242_8 = 0
			local var_242_9 = 1

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_10 = arg_239_1:GetWordFromCfg(424061059)
				local var_242_11 = arg_239_1:FormatText(var_242_10.content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 40 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 40)

				if (40 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 40)) > 0 and var_242_9 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061059", "story_v_out_424061.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061059", "story_v_out_424061.awb") / 1000

					if var_242_14 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_8
					end

					if var_242_10.prefab_name ~= "" and arg_239_1.actors_[var_242_10.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_10.prefab_name].transform, "story_v_out_424061", "424061059", "story_v_out_424061.awb")

						arg_239_1:RecordAudio("424061059", var_242_15)
						arg_239_1:RecordAudio("424061059", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_424061", "424061059", "story_v_out_424061.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_424061", "424061059", "story_v_out_424061.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_16 and arg_239_1.time_ < var_242_8 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play424061060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424061060
		arg_243_1.duration_ = 8.87

		local var_243_0 = {
			zh = 5.8,
			ja = 8.866
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
				arg_243_0:Play424061061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10153 = arg_243_1.actors_["10153"].transform.localPosition
				arg_243_1.actors_["10153"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10153", 4)

				for iter_246_0 = 0, arg_243_1.actors_["10153"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["10153"].transform:GetChild(iter_246_0)

					if var_246_0.name == "" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["10153"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["10153"].transform.localPosition = Vector3.New(400, -395, -330)
			end

			local var_246_2 = 0
			local var_246_3 = 0.775

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(424061060)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 31 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 31)

				if (31 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 31)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061060", "story_v_out_424061.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061060", "story_v_out_424061.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_out_424061", "424061060", "story_v_out_424061.awb")

						arg_243_1:RecordAudio("424061060", var_246_9)
						arg_243_1:RecordAudio("424061060", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_424061", "424061060", "story_v_out_424061.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_424061", "424061060", "story_v_out_424061.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play424061061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424061061
		arg_247_1.duration_ = 4.63

		local var_247_0 = {
			zh = 4.633,
			ja = 3.3
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
				arg_247_0:Play424061062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10154"]) and arg_247_1.var_.actorSpriteComps10154 == nil then
				arg_247_1.var_.actorSpriteComps10154 = arg_247_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10154"]) then
				if arg_247_1.var_.actorSpriteComps10154 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 1, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10154"]) and arg_247_1.var_.actorSpriteComps10154 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10154 = nil
			end

			local var_250_2 = arg_247_1.actors_["10153"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10153 == nil then
				arg_247_1.var_.actorSpriteComps10153 = var_250_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_3 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.actorSpriteComps10153 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								iter_250_5.color = Color.New(Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 0) / var_250_3), Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 0) / var_250_3), (Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 0) / var_250_3)))
							else
								local var_250_4 = Mathf.Lerp(iter_250_5.color.r, 0.5, (arg_247_1.time_ - 0) / var_250_3)

								iter_250_5.color = Color.New(var_250_4, var_250_4, var_250_4)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10153 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_250_7 then
						iter_250_7.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps10153 = nil
			end

			local var_250_5 = arg_247_1.actors_["10154"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10154 = var_250_5.localPosition
				var_250_5.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10154", 2)

				for iter_250_8 = 0, var_250_5.childCount - 1 do
					local var_250_6 = var_250_5:GetChild(iter_250_8)

					if var_250_6.name == "split_3" then
						var_250_6:SetAsLastSibling()
						var_250_6.gameObject:SetActive(true)

						arg_247_1.var_.actorSpriteSplit10154 = var_250_6.gameObject:GetComponent(typeof(Image))

						arg_247_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_250_7 = 0.5

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				var_250_5.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_247_1.time_ - 0) / var_250_7)

				if arg_247_1.var_.actorSpriteSplit10154 ~= nil then
					arg_247_1.var_.actorSpriteSplit10154:SetAlpha((arg_247_1.time_ - 0) / var_250_7)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				var_250_5.localPosition = Vector3.New(-375, -338, -538)

				if arg_247_1.var_.actorSpriteSplit10154 ~= nil then
					arg_247_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_250_8 = 0
			local var_250_9 = 0.425

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_10 = arg_247_1:GetWordFromCfg(424061061)
				local var_250_11 = arg_247_1:FormatText(var_250_10.content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 17 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 17)

				if (17 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 17)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061061", "story_v_out_424061.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061061", "story_v_out_424061.awb") / 1000

					if var_250_14 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_8
					end

					if var_250_10.prefab_name ~= "" and arg_247_1.actors_[var_250_10.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_10.prefab_name].transform, "story_v_out_424061", "424061061", "story_v_out_424061.awb")

						arg_247_1:RecordAudio("424061061", var_250_15)
						arg_247_1:RecordAudio("424061061", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_424061", "424061061", "story_v_out_424061.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_424061", "424061061", "story_v_out_424061.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play424061062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424061062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play424061063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10154"]) and arg_251_1.var_.actorSpriteComps10154 == nil then
				arg_251_1.var_.actorSpriteComps10154 = arg_251_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10154"]) then
				if arg_251_1.var_.actorSpriteComps10154 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10154"]) and arg_251_1.var_.actorSpriteComps10154 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10154 = nil
			end

			if 0.133333333333333 < arg_251_1.time_ and arg_251_1.time_ <= 0.133333333333333 + arg_254_0 then
				arg_251_1:AudioAction("play", "effect", "se_story_146", "se_story_146_gun_foley", "")
			end

			local var_254_3 = 0
			local var_254_4 = 0.8

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_5 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(424061062).content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 32 <= 0 and var_254_4 or var_254_4 * (utf8.len(var_254_5) / 32)

				if (32 <= 0 and var_254_4 or var_254_4 * (utf8.len(var_254_5) / 32)) > 0 and var_254_4 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_3 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_3
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_4, arg_251_1.talkMaxDuration)

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_3) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_3 + var_254_8 and arg_251_1.time_ < var_254_3 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play424061063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424061063
		arg_255_1.duration_ = 6.83

		local var_255_0 = {
			zh = 6.266,
			ja = 6.833
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
				arg_255_0:Play424061064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10153"]) and arg_255_1.var_.actorSpriteComps10153 == nil then
				arg_255_1.var_.actorSpriteComps10153 = arg_255_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10153"]) then
				if arg_255_1.var_.actorSpriteComps10153 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10153"]) and arg_255_1.var_.actorSpriteComps10153 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10153 = nil
			end

			local var_258_2 = arg_255_1.actors_["10153"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10153 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10153", 4)

				for iter_258_4 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_4)

					if var_258_3.name == "" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(400, -395, -330)
			end

			local var_258_5 = 0
			local var_258_6 = 0.725

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(424061063)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 29 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 29)

				if (29 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 29)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061063", "story_v_out_424061.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061063", "story_v_out_424061.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_424061", "424061063", "story_v_out_424061.awb")

						arg_255_1:RecordAudio("424061063", var_258_12)
						arg_255_1:RecordAudio("424061063", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_424061", "424061063", "story_v_out_424061.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_424061", "424061063", "story_v_out_424061.awb")
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

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play424061064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424061064
		arg_259_1.duration_ = 5.8

		local var_259_0 = {
			zh = 5.066,
			ja = 5.8
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
				arg_259_0:Play424061065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10154"]) and arg_259_1.var_.actorSpriteComps10154 == nil then
				arg_259_1.var_.actorSpriteComps10154 = arg_259_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10154"]) then
				if arg_259_1.var_.actorSpriteComps10154 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 1, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10154"]) and arg_259_1.var_.actorSpriteComps10154 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10154 = nil
			end

			local var_262_2 = arg_259_1.actors_["10153"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10153 == nil then
				arg_259_1.var_.actorSpriteComps10153 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps10153 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								iter_262_5.color = Color.New(Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_5.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_5.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10153 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_262_7 then
						iter_262_7.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps10153 = nil
			end

			local var_262_5 = arg_259_1.actors_["10154"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10154 = var_262_5.localPosition
				var_262_5.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10154", 2)

				for iter_262_8 = 0, var_262_5.childCount - 1 do
					local var_262_6 = var_262_5:GetChild(iter_262_8)

					if var_262_6.name == "split_1" then
						var_262_6:SetAsLastSibling()
						var_262_6.gameObject:SetActive(true)

						arg_259_1.var_.actorSpriteSplit10154 = var_262_6.gameObject:GetComponent(typeof(Image))

						arg_259_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_262_7 = 0.5

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				var_262_5.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_259_1.time_ - 0) / var_262_7)

				if arg_259_1.var_.actorSpriteSplit10154 ~= nil then
					arg_259_1.var_.actorSpriteSplit10154:SetAlpha((arg_259_1.time_ - 0) / var_262_7)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				var_262_5.localPosition = Vector3.New(-375, -338, -538)

				if arg_259_1.var_.actorSpriteSplit10154 ~= nil then
					arg_259_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_262_8 = 0
			local var_262_9 = 0.6

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_10 = arg_259_1:GetWordFromCfg(424061064)
				local var_262_11 = arg_259_1:FormatText(var_262_10.content)

				arg_259_1.text_.text = var_262_11

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 24 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 24)

				if (24 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 24)) > 0 and var_262_9 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_11
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061064", "story_v_out_424061.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061064", "story_v_out_424061.awb") / 1000

					if var_262_14 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_8
					end

					if var_262_10.prefab_name ~= "" and arg_259_1.actors_[var_262_10.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_10.prefab_name].transform, "story_v_out_424061", "424061064", "story_v_out_424061.awb")

						arg_259_1:RecordAudio("424061064", var_262_15)
						arg_259_1:RecordAudio("424061064", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_424061", "424061064", "story_v_out_424061.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_424061", "424061064", "story_v_out_424061.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_16 and arg_259_1.time_ < var_262_8 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play424061065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424061065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play424061066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10154"]) and arg_263_1.var_.actorSpriteComps10154 == nil then
				arg_263_1.var_.actorSpriteComps10154 = arg_263_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10154"]) then
				if arg_263_1.var_.actorSpriteComps10154 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10154"]) and arg_263_1.var_.actorSpriteComps10154 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10154 = nil
			end

			local var_266_2 = 0
			local var_266_3 = 0.55

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(424061065).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 22 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 22)

				if (22 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 22)) > 0 and var_266_3 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_7 and arg_263_1.time_ < var_266_2 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play424061066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424061066
		arg_267_1.duration_ = 9

		local var_267_0 = {
			zh = 7.366,
			ja = 9
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
				arg_267_0:Play424061067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10153"]) and arg_267_1.var_.actorSpriteComps10153 == nil then
				arg_267_1.var_.actorSpriteComps10153 = arg_267_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10153"]) then
				if arg_267_1.var_.actorSpriteComps10153 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10153"]) and arg_267_1.var_.actorSpriteComps10153 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps10153 = nil
			end

			local var_270_2 = arg_267_1.actors_["10153"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10153 = var_270_2.localPosition
				var_270_2.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10153", 4)

				for iter_270_4 = 0, var_270_2.childCount - 1 do
					local var_270_3 = var_270_2:GetChild(iter_270_4)

					if var_270_3.name == "split_5" then
						var_270_3:SetAsLastSibling()
						var_270_3.gameObject:SetActive(true)

						arg_267_1.var_.actorSpriteSplit10153 = var_270_3.gameObject:GetComponent(typeof(Image))

						arg_267_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_270_4 = 0.5

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_2.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_267_1.time_ - 0) / var_270_4)

				if arg_267_1.var_.actorSpriteSplit10153 ~= nil then
					arg_267_1.var_.actorSpriteSplit10153:SetAlpha((arg_267_1.time_ - 0) / var_270_4)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_2.localPosition = Vector3.New(400, -395, -330)

				if arg_267_1.var_.actorSpriteSplit10153 ~= nil then
					arg_267_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_270_5 = 0
			local var_270_6 = 0.575

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(424061066)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 23 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 23)

				if (23 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 23)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061066", "story_v_out_424061.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061066", "story_v_out_424061.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_424061", "424061066", "story_v_out_424061.awb")

						arg_267_1:RecordAudio("424061066", var_270_12)
						arg_267_1:RecordAudio("424061066", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_424061", "424061066", "story_v_out_424061.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_424061", "424061066", "story_v_out_424061.awb")
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play424061067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424061067
		arg_271_1.duration_ = 9

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424061068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 2 < arg_271_1.time_ and arg_271_1.time_ <= 2 + arg_274_0 then
				local var_274_0 = arg_271_1.bgs_.ST0116c

				arg_271_1.bgs_.ST0116c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_1 = var_274_0:GetComponent("SpriteRenderer")

				if var_274_1 and var_274_1.sprite then
					local var_274_2 = 2 * (var_274_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_0.transform.localScale = Vector3.New(var_274_2 / var_274_1.sprite.bounds.size.y < var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x and var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x or var_274_2 / var_274_1.sprite.bounds.size.y, var_274_2 / var_274_1.sprite.bounds.size.y < var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x and var_274_2 * manager.ui.mainCameraCom_.aspect / var_274_1.sprite.bounds.size.x or var_274_2 / var_274_1.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "ST0116c" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_3 = 4

			if 4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= var_274_3 + 0.3 and arg_271_1.time_ < var_274_3 + 0.3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_4 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_5 = 2

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_5 then
				local var_274_6 = Color.New(0, 0, 0)

				var_274_6.a = Mathf.Lerp(0, 1, (arg_271_1.time_ - var_274_4) / var_274_5)
				arg_271_1.mask_.color = var_274_6
			end

			if arg_271_1.time_ >= var_274_4 + var_274_5 and arg_271_1.time_ < var_274_4 + var_274_5 + arg_274_0 then
				local var_274_7 = Color.New(0, 0, 0)

				var_274_7.a = 1
				arg_271_1.mask_.color = var_274_7
			end

			local var_274_8 = 2

			if 2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_9 = 2

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 then
				local var_274_10 = Color.New(0, 0, 0)

				var_274_10.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_8) / var_274_9)
				arg_271_1.mask_.color = var_274_10
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 then
				local var_274_11 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_11.a = 0
				arg_271_1.mask_.color = var_274_11
			end

			local var_274_12 = arg_271_1.actors_["10153"]

			if 1.966 < arg_271_1.time_ and arg_271_1.time_ <= 1.966 + arg_274_0 and not isNil(var_274_12) and arg_271_1.var_.actorSpriteComps10153 == nil then
				arg_271_1.var_.actorSpriteComps10153 = var_274_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_13 = 0.034

			if 1.966 <= arg_271_1.time_ and arg_271_1.time_ < 1.966 + var_274_13 and not isNil(var_274_12) then
				if arg_271_1.var_.actorSpriteComps10153 then
					for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_274_3 then
							if arg_271_1.isInRecall_ then
								iter_274_3.color = Color.New(Mathf.Lerp(iter_274_3.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 1.966) / var_274_13), Mathf.Lerp(iter_274_3.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 1.966) / var_274_13), (Mathf.Lerp(iter_274_3.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 1.966) / var_274_13)))
							else
								local var_274_14 = Mathf.Lerp(iter_274_3.color.r, 0.5, (arg_271_1.time_ - 1.966) / var_274_13)

								iter_274_3.color = Color.New(var_274_14, var_274_14, var_274_14)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 1.966 + var_274_13 and arg_271_1.time_ < 1.966 + var_274_13 + arg_274_0 and not isNil(var_274_12) and arg_271_1.var_.actorSpriteComps10153 then
				for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_274_5 then
						iter_274_5.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps10153 = nil
			end

			local var_274_15 = arg_271_1.actors_["10153"].transform

			if 1.966 < arg_271_1.time_ and arg_271_1.time_ <= 1.966 + arg_274_0 then
				arg_271_1.var_.moveOldPos10153 = var_274_15.localPosition
				var_274_15.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10153", 7)

				for iter_274_6 = 0, var_274_15.childCount - 1 do
					local var_274_16 = var_274_15:GetChild(iter_274_6)

					if var_274_16.name == "" or not string.find(var_274_16.name, "split") then
						var_274_16.gameObject:SetActive(true)
					else
						var_274_16.gameObject:SetActive(false)
					end
				end
			end

			local var_274_17 = 0.001

			if 1.966 <= arg_271_1.time_ and arg_271_1.time_ < 1.966 + var_274_17 then
				var_274_15.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 1.966) / var_274_17)
			end

			if arg_271_1.time_ >= 1.966 + var_274_17 and arg_271_1.time_ < 1.966 + var_274_17 + arg_274_0 then
				var_274_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_18 = arg_271_1.actors_["10154"].transform

			if 1.966 < arg_271_1.time_ and arg_271_1.time_ <= 1.966 + arg_274_0 then
				arg_271_1.var_.moveOldPos10154 = var_274_18.localPosition
				var_274_18.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10154", 7)

				for iter_274_7 = 0, var_274_18.childCount - 1 do
					local var_274_19 = var_274_18:GetChild(iter_274_7)

					if var_274_19.name == "" or not string.find(var_274_19.name, "split") then
						var_274_19.gameObject:SetActive(true)
					else
						var_274_19.gameObject:SetActive(false)
					end
				end
			end

			local var_274_20 = 0.001

			if 1.966 <= arg_271_1.time_ and arg_271_1.time_ < 1.966 + var_274_20 then
				var_274_18.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 1.966) / var_274_20)
			end

			if arg_271_1.time_ >= 1.966 + var_274_20 and arg_271_1.time_ < 1.966 + var_274_20 + arg_274_0 then
				var_274_18.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_21 = 4
			local var_274_22 = 0.425

			if 4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_23 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_23:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_24 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(424061067).content)

				arg_271_1.text_.text = var_274_24

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_26 = 17 <= 0 and var_274_22 or var_274_22 * (utf8.len(var_274_24) / 17)

				if (17 <= 0 and var_274_22 or var_274_22 * (utf8.len(var_274_24) / 17)) > 0 and var_274_22 < var_274_26 then
					arg_271_1.talkMaxDuration = var_274_26
					var_274_21 = var_274_21 + 0.3

					if var_274_26 + var_274_21 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_26 + var_274_21
					end
				end

				arg_271_1.text_.text = var_274_24
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_27 = var_274_21 + 0.3
			local var_274_28 = math.max(var_274_22, arg_271_1.talkMaxDuration)

			if var_274_21 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_27 + var_274_28 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_27) / var_274_28

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_27 + var_274_28 and arg_271_1.time_ < var_274_27 + var_274_28 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play424061068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 424061068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play424061069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0.034 < arg_277_1.time_ and arg_277_1.time_ <= 0.034 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_145", "se_story_145_ui01", "")
			end

			local var_280_1 = 0
			local var_280_2 = 0.675

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(424061068).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 27 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 27)

				if (27 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 27)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play424061069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 424061069
		arg_281_1.duration_ = 4.33

		local var_281_0 = {
			zh = 3.966,
			ja = 4.333
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play424061070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if arg_281_1.actors_["1094"] == nil then
				local var_284_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_284_0) then
					local var_284_1 = Object.Instantiate(var_284_0, arg_281_1.canvasGo_.transform)

					var_284_1.transform:SetSiblingIndex(1)

					var_284_1.name = "1094"
					var_284_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_281_1.actors_["1094"] = var_284_1

					if arg_281_1.isInRecall_ then
						for iter_284_0, iter_284_1 in ipairs((var_284_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_284_1.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_284_2 = arg_281_1.actors_["1094"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1094 == nil then
				arg_281_1.var_.actorSpriteComps1094 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps1094 then
					for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_284_3 then
							if arg_281_1.isInRecall_ then
								iter_284_3.color = Color.New(Mathf.Lerp(iter_284_3.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_3.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_3.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_3.color.r, 1, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_3.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1094 then
				for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_284_5 then
						iter_284_5.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps1094 = nil
			end

			local var_284_5 = arg_281_1.actors_["1094"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1094 = var_284_5.localPosition
				var_284_5.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1094", 3)

				for iter_284_6 = 0, var_284_5.childCount - 1 do
					local var_284_6 = var_284_5:GetChild(iter_284_6)

					if var_284_6.name == "split_4" or not string.find(var_284_6.name, "split") then
						var_284_6.gameObject:SetActive(true)
					else
						var_284_6.gameObject:SetActive(false)
					end
				end
			end

			local var_284_7 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				var_284_5.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_281_1.time_ - 0) / var_284_7)
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				var_284_5.localPosition = Vector3.New(0, -335, -230)
			end

			local var_284_8 = 0
			local var_284_9 = 0.375

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(424061069)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 15 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 15)

				if (15 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 15)) > 0 and var_284_9 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061069", "story_v_out_424061.awb") ~= 0 then
					local var_284_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061069", "story_v_out_424061.awb") / 1000

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end

					if var_284_10.prefab_name ~= "" and arg_281_1.actors_[var_284_10.prefab_name] ~= nil then
						local var_284_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_10.prefab_name].transform, "story_v_out_424061", "424061069", "story_v_out_424061.awb")

						arg_281_1:RecordAudio("424061069", var_284_15)
						arg_281_1:RecordAudio("424061069", var_284_15)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_424061", "424061069", "story_v_out_424061.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_424061", "424061069", "story_v_out_424061.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_16 and arg_281_1.time_ < var_284_8 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play424061070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 424061070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play424061071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1094"]) and arg_285_1.var_.actorSpriteComps1094 == nil then
				arg_285_1.var_.actorSpriteComps1094 = arg_285_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1094"]) then
				if arg_285_1.var_.actorSpriteComps1094 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1094"]) and arg_285_1.var_.actorSpriteComps1094 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1094 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 0.575

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_4 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(424061070).content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 23 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 23)

				if (23 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 23)) > 0 and var_288_3 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_7 and arg_285_1.time_ < var_288_2 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play424061071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 424061071
		arg_289_1.duration_ = 4.73

		local var_289_0 = {
			zh = 4.133,
			ja = 4.733
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play424061072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1094"]) and arg_289_1.var_.actorSpriteComps1094 == nil then
				arg_289_1.var_.actorSpriteComps1094 = arg_289_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1094"]) then
				if arg_289_1.var_.actorSpriteComps1094 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 1, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1094"]) and arg_289_1.var_.actorSpriteComps1094 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps1094 = nil
			end

			local var_292_2 = arg_289_1.actors_["1094"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1094 = var_292_2.localPosition
				var_292_2.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1094", 3)

				for iter_292_4 = 0, var_292_2.childCount - 1 do
					local var_292_3 = var_292_2:GetChild(iter_292_4)

					if var_292_3.name == "split_2" then
						var_292_3:SetAsLastSibling()
						var_292_3.gameObject:SetActive(true)

						arg_289_1.var_.actorSpriteSplit1094 = var_292_3.gameObject:GetComponent(typeof(Image))

						arg_289_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_292_4 = 0.5

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				var_292_2.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_289_1.time_ - 0) / var_292_4)

				if arg_289_1.var_.actorSpriteSplit1094 ~= nil then
					arg_289_1.var_.actorSpriteSplit1094:SetAlpha((arg_289_1.time_ - 0) / var_292_4)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				var_292_2.localPosition = Vector3.New(0, -335, -230)

				if arg_289_1.var_.actorSpriteSplit1094 ~= nil then
					arg_289_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_292_5 = 0
			local var_292_6 = 0.425

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_7 = arg_289_1:GetWordFromCfg(424061071)
				local var_292_8 = arg_289_1:FormatText(var_292_7.content)

				arg_289_1.text_.text = var_292_8

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 17 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 17)

				if (17 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 17)) > 0 and var_292_6 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_8
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061071", "story_v_out_424061.awb") ~= 0 then
					local var_292_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061071", "story_v_out_424061.awb") / 1000

					if var_292_11 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_5
					end

					if var_292_7.prefab_name ~= "" and arg_289_1.actors_[var_292_7.prefab_name] ~= nil then
						local var_292_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_7.prefab_name].transform, "story_v_out_424061", "424061071", "story_v_out_424061.awb")

						arg_289_1:RecordAudio("424061071", var_292_12)
						arg_289_1:RecordAudio("424061071", var_292_12)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_424061", "424061071", "story_v_out_424061.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_424061", "424061071", "story_v_out_424061.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_13 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_13 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_13

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_13 and arg_289_1.time_ < var_292_5 + var_292_13 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play424061072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 424061072
		arg_293_1.duration_ = 14.3

		local var_293_0 = {
			zh = 8.666,
			ja = 14.3
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play424061073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1094"]) and arg_293_1.var_.actorSpriteComps1094 == nil then
				arg_293_1.var_.actorSpriteComps1094 = arg_293_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1094"]) then
				if arg_293_1.var_.actorSpriteComps1094 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								iter_296_1.color = Color.New(Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_0), Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_0), (Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_0)))
							else
								local var_296_1 = Mathf.Lerp(iter_296_1.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_0)

								iter_296_1.color = Color.New(var_296_1, var_296_1, var_296_1)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1094"]) and arg_293_1.var_.actorSpriteComps1094 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps1094 = nil
			end

			local var_296_2 = 0
			local var_296_3 = 1.1

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_4 = arg_293_1:GetWordFromCfg(424061072)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 44 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 44)

				if (44 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 44)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061072", "story_v_out_424061.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061072", "story_v_out_424061.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_424061", "424061072", "story_v_out_424061.awb")

						arg_293_1:RecordAudio("424061072", var_296_9)
						arg_293_1:RecordAudio("424061072", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_424061", "424061072", "story_v_out_424061.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_424061", "424061072", "story_v_out_424061.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play424061073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 424061073
		arg_297_1.duration_ = 3.7

		local var_297_0 = {
			zh = 2.766,
			ja = 3.7
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play424061074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1094"]) and arg_297_1.var_.actorSpriteComps1094 == nil then
				arg_297_1.var_.actorSpriteComps1094 = arg_297_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1094"]) then
				if arg_297_1.var_.actorSpriteComps1094 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 1, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1094"]) and arg_297_1.var_.actorSpriteComps1094 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps1094 = nil
			end

			local var_300_2 = arg_297_1.actors_["1094"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1094 = var_300_2.localPosition
				var_300_2.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1094", 3)

				for iter_300_4 = 0, var_300_2.childCount - 1 do
					local var_300_3 = var_300_2:GetChild(iter_300_4)

					if var_300_3.name == "split_1" then
						var_300_3:SetAsLastSibling()
						var_300_3.gameObject:SetActive(true)

						arg_297_1.var_.actorSpriteSplit1094 = var_300_3.gameObject:GetComponent(typeof(Image))

						arg_297_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_300_4 = 0.5

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				var_300_2.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_297_1.time_ - 0) / var_300_4)

				if arg_297_1.var_.actorSpriteSplit1094 ~= nil then
					arg_297_1.var_.actorSpriteSplit1094:SetAlpha((arg_297_1.time_ - 0) / var_300_4)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				var_300_2.localPosition = Vector3.New(0, -335, -230)

				if arg_297_1.var_.actorSpriteSplit1094 ~= nil then
					arg_297_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_300_5 = 0
			local var_300_6 = 0.25

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_7 = arg_297_1:GetWordFromCfg(424061073)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 10 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 10)

				if (10 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 10)) > 0 and var_300_6 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061073", "story_v_out_424061.awb") ~= 0 then
					local var_300_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061073", "story_v_out_424061.awb") / 1000

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_424061", "424061073", "story_v_out_424061.awb")

						arg_297_1:RecordAudio("424061073", var_300_12)
						arg_297_1:RecordAudio("424061073", var_300_12)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_424061", "424061073", "story_v_out_424061.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_424061", "424061073", "story_v_out_424061.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_13 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_13 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_13

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_13 and arg_297_1.time_ < var_300_5 + var_300_13 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play424061074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 424061074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play424061075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1094"]) and arg_301_1.var_.actorSpriteComps1094 == nil then
				arg_301_1.var_.actorSpriteComps1094 = arg_301_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1094"]) then
				if arg_301_1.var_.actorSpriteComps1094 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1094"]) and arg_301_1.var_.actorSpriteComps1094 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps1094 = nil
			end

			local var_304_2 = 0
			local var_304_3 = 0.825

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_4 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(424061074).content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_6 = 33 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_4) / 33)

				if (33 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_4) / 33)) > 0 and var_304_3 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_7 and arg_301_1.time_ < var_304_2 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play424061075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 424061075
		arg_305_1.duration_ = 8.47

		local var_305_0 = {
			zh = 5.466,
			ja = 8.466
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play424061076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.725

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(424061075)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 29 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 29)

				if (29 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 29)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061075", "story_v_out_424061.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061075", "story_v_out_424061.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_424061", "424061075", "story_v_out_424061.awb")

						arg_305_1:RecordAudio("424061075", var_308_6)
						arg_305_1:RecordAudio("424061075", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_424061", "424061075", "story_v_out_424061.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_424061", "424061075", "story_v_out_424061.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play424061076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 424061076
		arg_309_1.duration_ = 1.43

		local var_309_0 = {
			zh = 1.3,
			ja = 1.433
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play424061077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1094"]) and arg_309_1.var_.actorSpriteComps1094 == nil then
				arg_309_1.var_.actorSpriteComps1094 = arg_309_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1094"]) then
				if arg_309_1.var_.actorSpriteComps1094 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 1, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1094"]) and arg_309_1.var_.actorSpriteComps1094 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps1094 = nil
			end

			local var_312_2 = arg_309_1.actors_["1094"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1094 = var_312_2.localPosition
				var_312_2.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1094", 3)

				for iter_312_4 = 0, var_312_2.childCount - 1 do
					local var_312_3 = var_312_2:GetChild(iter_312_4)

					if var_312_3.name == "split_5" then
						var_312_3:SetAsLastSibling()
						var_312_3.gameObject:SetActive(true)

						arg_309_1.var_.actorSpriteSplit1094 = var_312_3.gameObject:GetComponent(typeof(Image))

						arg_309_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_312_4 = 0.5

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				var_312_2.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_309_1.time_ - 0) / var_312_4)

				if arg_309_1.var_.actorSpriteSplit1094 ~= nil then
					arg_309_1.var_.actorSpriteSplit1094:SetAlpha((arg_309_1.time_ - 0) / var_312_4)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				var_312_2.localPosition = Vector3.New(0, -335, -230)

				if arg_309_1.var_.actorSpriteSplit1094 ~= nil then
					arg_309_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_312_5 = 0
			local var_312_6 = 0.1

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(424061076)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 4 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 4)

				if (4 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 4)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061076", "story_v_out_424061.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061076", "story_v_out_424061.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_424061", "424061076", "story_v_out_424061.awb")

						arg_309_1:RecordAudio("424061076", var_312_12)
						arg_309_1:RecordAudio("424061076", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_424061", "424061076", "story_v_out_424061.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_424061", "424061076", "story_v_out_424061.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_13 and arg_309_1.time_ < var_312_5 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play424061077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 424061077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play424061078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1094"]) and arg_313_1.var_.actorSpriteComps1094 == nil then
				arg_313_1.var_.actorSpriteComps1094 = arg_313_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1094"]) then
				if arg_313_1.var_.actorSpriteComps1094 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1094"]) and arg_313_1.var_.actorSpriteComps1094 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1094 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 1.5

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_4 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(424061077).content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 60 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 60)

				if (60 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 60)) > 0 and var_316_3 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_7 and arg_313_1.time_ < var_316_2 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play424061078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 424061078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play424061079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.775

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(424061078).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 31 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 31)

				if (31 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 31)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play424061079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 424061079
		arg_321_1.duration_ = 1.3

		local var_321_0 = {
			zh = 1.3,
			ja = 1.233
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play424061080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1094"]) and arg_321_1.var_.actorSpriteComps1094 == nil then
				arg_321_1.var_.actorSpriteComps1094 = arg_321_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1094"]) then
				if arg_321_1.var_.actorSpriteComps1094 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 1, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1094"]) and arg_321_1.var_.actorSpriteComps1094 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps1094 = nil
			end

			local var_324_2 = arg_321_1.actors_["1094"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1094 = var_324_2.localPosition
				var_324_2.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1094", 3)

				for iter_324_4 = 0, var_324_2.childCount - 1 do
					local var_324_3 = var_324_2:GetChild(iter_324_4)

					if var_324_3.name == "split_1" then
						var_324_3:SetAsLastSibling()
						var_324_3.gameObject:SetActive(true)

						arg_321_1.var_.actorSpriteSplit1094 = var_324_3.gameObject:GetComponent(typeof(Image))

						arg_321_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_324_4 = 0.5

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_2.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_321_1.time_ - 0) / var_324_4)

				if arg_321_1.var_.actorSpriteSplit1094 ~= nil then
					arg_321_1.var_.actorSpriteSplit1094:SetAlpha((arg_321_1.time_ - 0) / var_324_4)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_2.localPosition = Vector3.New(0, -335, -230)

				if arg_321_1.var_.actorSpriteSplit1094 ~= nil then
					arg_321_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_324_5 = 0
			local var_324_6 = 0.15

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(424061079)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 6 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 6)

				if (6 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 6)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061079", "story_v_out_424061.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061079", "story_v_out_424061.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_424061", "424061079", "story_v_out_424061.awb")

						arg_321_1:RecordAudio("424061079", var_324_12)
						arg_321_1:RecordAudio("424061079", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_424061", "424061079", "story_v_out_424061.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_424061", "424061079", "story_v_out_424061.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_13 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_13

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_13 and arg_321_1.time_ < var_324_5 + var_324_13 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play424061080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 424061080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play424061081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1094"]) and arg_325_1.var_.actorSpriteComps1094 == nil then
				arg_325_1.var_.actorSpriteComps1094 = arg_325_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1094"]) then
				if arg_325_1.var_.actorSpriteComps1094 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1094"]) and arg_325_1.var_.actorSpriteComps1094 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps1094 = nil
			end

			local var_328_2 = 0
			local var_328_3 = 0.975

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_4 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(424061080).content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 39 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 39)

				if (39 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 39)) > 0 and var_328_3 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_7 and arg_325_1.time_ < var_328_2 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play424061081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 424061081
		arg_329_1.duration_ = 8.12

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play424061082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_9008
			local var_332_9007
			local var_332_9006
			local var_332_9005
			local var_332_9004
			local var_332_9003
			local var_332_9002
			local var_332_9001
			local var_332_9000

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1094 = arg_329_1.actors_["1094"].transform.localPosition
				arg_329_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1094", 7)

				for iter_332_0 = 0, arg_329_1.actors_["1094"].transform.childCount - 1 do
					local var_332_0 = arg_329_1.actors_["1094"].transform:GetChild(iter_332_0)

					if var_332_0.name == "split_1" then
						var_332_0:SetAsLastSibling()
						var_332_0.gameObject:SetActive(true)

						arg_329_1.var_.actorSpriteSplit1094 = var_332_0.gameObject:GetComponent(typeof(Image))

						arg_329_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_332_1 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_1 then
				arg_329_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_329_1.time_ - 0) / var_332_1)

				if arg_329_1.var_.actorSpriteSplit1094 ~= nil then
					arg_329_1.var_.actorSpriteSplit1094:SetAlpha((arg_329_1.time_ - 0) / var_332_1)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_1 and arg_329_1.time_ < 0 + var_332_1 + arg_332_0 then
				arg_329_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)

				if arg_329_1.var_.actorSpriteSplit1094 ~= nil then
					arg_329_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				local var_332_2 = arg_329_1.var_.effectsaomiaoshangu1

				if not arg_329_1.var_.effectsaomiaoshangu1 then
					var_332_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_332_2.name = "saomiaoshangu1"
					arg_329_1.var_.effectsaomiaoshangu1 = var_332_2
				else
					var_332_2.transform:SetParent(var_332_9008)
				end

				var_332_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_332_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_332_2.transform.localScale = Vector3.New(var_332_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_332_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_332_2.transform.localScale.z)
			end

			if 5 < arg_329_1.time_ and arg_329_1.time_ <= 5 + arg_332_0 then
				if arg_329_1.var_.effectsaomiaoshangu1 then
					Object.Destroy(arg_329_1.var_.effectsaomiaoshangu1)

					arg_329_1.var_.effectsaomiaoshangu1 = nil
				end
			end

			if 2.99166666666667 < arg_329_1.time_ and arg_329_1.time_ <= 2.99166666666667 + arg_332_0 then
				local var_332_5 = arg_329_1.var_.effectsaomiaoshangu2

				if not arg_329_1.var_.effectsaomiaoshangu2 then
					var_332_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_5.name = "saomiaoshangu2"
					arg_329_1.var_.effectsaomiaoshangu2 = var_332_5
				else
					var_332_5.transform:SetParent(var_332_9007)
				end

				var_332_5.transform.localPosition = Vector3.New(-5.25, 0, 0)
				var_332_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.125 < arg_329_1.time_ and arg_329_1.time_ <= 3.125 + arg_332_0 then
				local var_332_7 = arg_329_1.var_.effectsaomiaoshangu3

				if not arg_329_1.var_.effectsaomiaoshangu3 then
					var_332_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_7.name = "saomiaoshangu3"
					arg_329_1.var_.effectsaomiaoshangu3 = var_332_7
				else
					var_332_7.transform:SetParent(var_332_9006)
				end

				var_332_7.transform.localPosition = Vector3.New(3.07, 0, 0)
				var_332_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.29166666666667 < arg_329_1.time_ and arg_329_1.time_ <= 3.29166666666667 + arg_332_0 then
				local var_332_9 = arg_329_1.var_.effectsaomiaoshangu4

				if not arg_329_1.var_.effectsaomiaoshangu4 then
					var_332_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_9.name = "saomiaoshangu4"
					arg_329_1.var_.effectsaomiaoshangu4 = var_332_9
				else
					var_332_9.transform:SetParent(var_332_9005)
				end

				var_332_9.transform.localPosition = Vector3.New(6.49, 0.96, 0)
				var_332_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.5 < arg_329_1.time_ and arg_329_1.time_ <= 3.5 + arg_332_0 then
				local var_332_11 = arg_329_1.var_.effectsaomiaoshangu5

				if not arg_329_1.var_.effectsaomiaoshangu5 then
					var_332_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_11.name = "saomiaoshangu5"
					arg_329_1.var_.effectsaomiaoshangu5 = var_332_11
				else
					var_332_11.transform:SetParent(var_332_9004)
				end

				var_332_11.transform.localPosition = Vector3.New(-2.09, 1.63, 0)
				var_332_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_332_13 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_13 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_13 + 3.5 and arg_329_1.time_ < var_332_13 + 3.5 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			if 4.75833333333333 < arg_329_1.time_ and arg_329_1.time_ <= 4.75833333333333 + arg_332_0 then
				local var_332_14 = arg_329_1.var_.effectsaomiaoshangu3

				if not arg_329_1.var_.effectsaomiaoshangu3 then
					var_332_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_14.name = "saomiaoshangu3"
					arg_329_1.var_.effectsaomiaoshangu3 = var_332_14
				else
					var_332_14.transform:SetParent(var_332_9003)
				end

				var_332_14.transform.localPosition = Vector3.New(3.07, 0, 0)
				var_332_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.925 < arg_329_1.time_ and arg_329_1.time_ <= 4.925 + arg_332_0 then
				local var_332_16 = arg_329_1.var_.effectsaomiaoshangu4

				if not arg_329_1.var_.effectsaomiaoshangu4 then
					var_332_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_16.name = "saomiaoshangu4"
					arg_329_1.var_.effectsaomiaoshangu4 = var_332_16
				else
					var_332_16.transform:SetParent(var_332_9002)
				end

				var_332_16.transform.localPosition = Vector3.New(6.49, 0.96, 0)
				var_332_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.13333333333333 < arg_329_1.time_ and arg_329_1.time_ <= 5.13333333333333 + arg_332_0 then
				local var_332_18 = arg_329_1.var_.effectsaomiaoshangu5

				if not arg_329_1.var_.effectsaomiaoshangu5 then
					var_332_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_18.name = "saomiaoshangu5"
					arg_329_1.var_.effectsaomiaoshangu5 = var_332_18
				else
					var_332_18.transform:SetParent(var_332_9001)
				end

				var_332_18.transform.localPosition = Vector3.New(-2.09, 1.63, 0)
				var_332_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.625 < arg_329_1.time_ and arg_329_1.time_ <= 4.625 + arg_332_0 then
				local var_332_20 = arg_329_1.var_.effectsaomiaoshangu2

				if not arg_329_1.var_.effectsaomiaoshangu2 then
					var_332_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_in"), manager.ui.mainCamera.transform)
					var_332_20.name = "saomiaoshangu2"
					arg_329_1.var_.effectsaomiaoshangu2 = var_332_20
				else
					var_332_20.transform:SetParent(var_332_9000)
				end

				var_332_20.transform.localPosition = Vector3.New(-5.25, 0, 0)
				var_332_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_128", "se_story_128_projection", "")
			end

			if 1.9 < arg_329_1.time_ and arg_329_1.time_ <= 1.9 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_128", "se_story_128_projection", "")
			end

			if 4.625 < arg_329_1.time_ and arg_329_1.time_ <= 4.625 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_map", "")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data02", "")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_26 = 3.11666666666667
			local var_332_27 = 1.375

			if 3.11666666666667 < arg_329_1.time_ and arg_329_1.time_ <= var_332_26 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_28 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_28:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_29 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(424061081).content)

				arg_329_1.text_.text = var_332_29

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_31 = 55 <= 0 and var_332_27 or var_332_27 * (utf8.len(var_332_29) / 55)

				if (55 <= 0 and var_332_27 or var_332_27 * (utf8.len(var_332_29) / 55)) > 0 and var_332_27 < var_332_31 then
					arg_329_1.talkMaxDuration = var_332_31
					var_332_26 = var_332_26 + 0.3

					if var_332_31 + var_332_26 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_31 + var_332_26
					end
				end

				arg_329_1.text_.text = var_332_29
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_32 = var_332_26 + 0.3
			local var_332_33 = math.max(var_332_27, arg_329_1.talkMaxDuration)

			if var_332_26 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_32 + var_332_33 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_32) / var_332_33

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_32 + var_332_33 and arg_329_1.time_ < var_332_32 + var_332_33 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play424061082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 424061082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play424061083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_9002
			local var_338_9001
			local var_338_9000

			if 0.133333333333333 < arg_335_1.time_ and arg_335_1.time_ <= 0.133333333333333 + arg_338_0 then
				local var_338_0 = arg_335_1.var_.effectsaomiaoshangu8

				if not arg_335_1.var_.effectsaomiaoshangu8 then
					var_338_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_out"), manager.ui.mainCamera.transform)
					var_338_0.name = "saomiaoshangu8"
					arg_335_1.var_.effectsaomiaoshangu8 = var_338_0
				else
					var_338_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_338_0.transform.localPosition = Vector3.New(3.07, 0, 0)
				var_338_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.299999999999999 < arg_335_1.time_ and arg_335_1.time_ <= 0.299999999999999 + arg_338_0 then
				local var_338_2 = arg_335_1.var_.effectsaomiaoshangu9

				if not arg_335_1.var_.effectsaomiaoshangu9 then
					var_338_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_out"), manager.ui.mainCamera.transform)
					var_338_2.name = "saomiaoshangu9"
					arg_335_1.var_.effectsaomiaoshangu9 = var_338_2
				else
					var_338_2.transform:SetParent(var_338_9002)
				end

				var_338_2.transform.localPosition = Vector3.New(6.49, 0.96, 0)
				var_338_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.508333333333332 < arg_335_1.time_ and arg_335_1.time_ <= 0.508333333333332 + arg_338_0 then
				local var_338_4 = arg_335_1.var_.effectsaomiaoshangu10

				if not arg_335_1.var_.effectsaomiaoshangu10 then
					var_338_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_out"), manager.ui.mainCamera.transform)
					var_338_4.name = "saomiaoshangu10"
					arg_335_1.var_.effectsaomiaoshangu10 = var_338_4
				else
					var_338_4.transform:SetParent(var_338_9001)
				end

				var_338_4.transform.localPosition = Vector3.New(-2.09, 1.63, 0)
				var_338_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.133333333333333 < arg_335_1.time_ and arg_335_1.time_ <= 0.133333333333333 + arg_338_0 then
				local var_338_6 = arg_335_1.var_.effectsaomiaoshangu11

				if not arg_335_1.var_.effectsaomiaoshangu11 then
					var_338_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_wenhao_out"), manager.ui.mainCamera.transform)
					var_338_6.name = "saomiaoshangu11"
					arg_335_1.var_.effectsaomiaoshangu11 = var_338_6
				else
					var_338_6.transform:SetParent(var_338_9000)
				end

				var_338_6.transform.localPosition = Vector3.New(-5.25, 0, 0)
				var_338_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.266666666666666 < arg_335_1.time_ and arg_335_1.time_ <= 0.266666666666666 + arg_338_0 then
				if arg_335_1.var_.effectsaomiaoshangu3 then
					Object.Destroy(arg_335_1.var_.effectsaomiaoshangu3)

					arg_335_1.var_.effectsaomiaoshangu3 = nil
				end
			end

			if 0.433333333333332 < arg_335_1.time_ and arg_335_1.time_ <= 0.433333333333332 + arg_338_0 then
				if arg_335_1.var_.effectsaomiaoshangu4 then
					Object.Destroy(arg_335_1.var_.effectsaomiaoshangu4)

					arg_335_1.var_.effectsaomiaoshangu4 = nil
				end
			end

			if 0.641666666666666 < arg_335_1.time_ and arg_335_1.time_ <= 0.641666666666666 + arg_338_0 then
				if arg_335_1.var_.effectsaomiaoshangu5 then
					Object.Destroy(arg_335_1.var_.effectsaomiaoshangu5)

					arg_335_1.var_.effectsaomiaoshangu5 = nil
				end
			end

			if 0.133333333333333 < arg_335_1.time_ and arg_335_1.time_ <= 0.133333333333333 + arg_338_0 then
				if arg_335_1.var_.effectsaomiaoshangu2 then
					Object.Destroy(arg_335_1.var_.effectsaomiaoshangu2)

					arg_335_1.var_.effectsaomiaoshangu2 = nil
				end
			end

			local var_338_12 = 0
			local var_338_13 = 1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_14 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(424061082).content)

				arg_335_1.text_.text = var_338_14

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_16 = 40 <= 0 and var_338_13 or var_338_13 * (utf8.len(var_338_14) / 40)

				if (40 <= 0 and var_338_13 or var_338_13 * (utf8.len(var_338_14) / 40)) > 0 and var_338_13 < var_338_16 then
					arg_335_1.talkMaxDuration = var_338_16

					if var_338_16 + var_338_12 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_16 + var_338_12
					end
				end

				arg_335_1.text_.text = var_338_14
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_17 = math.max(var_338_13, arg_335_1.talkMaxDuration)

			if var_338_12 <= arg_335_1.time_ and arg_335_1.time_ < var_338_12 + var_338_17 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_12) / var_338_17

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_12 + var_338_17 and arg_335_1.time_ < var_338_12 + var_338_17 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play424061083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 424061083
		arg_339_1.duration_ = 4.7

		local var_339_0 = {
			zh = 3.033,
			ja = 4.7
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
				arg_339_0:Play424061084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1094"]) and arg_339_1.var_.actorSpriteComps1094 == nil then
				arg_339_1.var_.actorSpriteComps1094 = arg_339_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1094"]) then
				if arg_339_1.var_.actorSpriteComps1094 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 1, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1094"]) and arg_339_1.var_.actorSpriteComps1094 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps1094 = nil
			end

			local var_342_2 = arg_339_1.actors_["1094"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1094 = var_342_2.localPosition
				var_342_2.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1094", 3)

				for iter_342_4 = 0, var_342_2.childCount - 1 do
					local var_342_3 = var_342_2:GetChild(iter_342_4)

					if var_342_3.name == "" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				var_342_2.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_339_1.time_ - 0) / var_342_4)
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				var_342_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_342_5 = 0
			local var_342_6 = 0.325

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(424061083)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 13 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 13)

				if (13 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 13)) > 0 and var_342_6 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061083", "story_v_out_424061.awb") ~= 0 then
					local var_342_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061083", "story_v_out_424061.awb") / 1000

					if var_342_11 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_5
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_424061", "424061083", "story_v_out_424061.awb")

						arg_339_1:RecordAudio("424061083", var_342_12)
						arg_339_1:RecordAudio("424061083", var_342_12)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_424061", "424061083", "story_v_out_424061.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_424061", "424061083", "story_v_out_424061.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_13 and arg_339_1.time_ < var_342_5 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play424061084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 424061084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play424061085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1094"]) and arg_343_1.var_.actorSpriteComps1094 == nil then
				arg_343_1.var_.actorSpriteComps1094 = arg_343_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1094"]) then
				if arg_343_1.var_.actorSpriteComps1094 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1094"]) and arg_343_1.var_.actorSpriteComps1094 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps1094 = nil
			end

			local var_346_2 = 0
			local var_346_3 = 0.625

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_4 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(424061084).content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 25 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 25)

				if (25 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 25)) > 0 and var_346_3 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_7 and arg_343_1.time_ < var_346_2 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play424061085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 424061085
		arg_347_1.duration_ = 6.77

		local var_347_0 = {
			zh = 3.466,
			ja = 6.766
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
				arg_347_0:Play424061086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.4

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(424061085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 16 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 16)

				if (16 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 16)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061085", "story_v_out_424061.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061085", "story_v_out_424061.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_424061", "424061085", "story_v_out_424061.awb")

						arg_347_1:RecordAudio("424061085", var_350_6)
						arg_347_1:RecordAudio("424061085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_424061", "424061085", "story_v_out_424061.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_424061", "424061085", "story_v_out_424061.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play424061086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 424061086
		arg_351_1.duration_ = 3.2

		local var_351_0 = {
			zh = 2.033,
			ja = 3.2
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play424061087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1094"]) and arg_351_1.var_.actorSpriteComps1094 == nil then
				arg_351_1.var_.actorSpriteComps1094 = arg_351_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1094"]) then
				if arg_351_1.var_.actorSpriteComps1094 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 1, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1094"]) and arg_351_1.var_.actorSpriteComps1094 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps1094 = nil
			end

			local var_354_2 = arg_351_1.actors_["1094"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1094 = var_354_2.localPosition
				var_354_2.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1094", 3)

				for iter_354_4 = 0, var_354_2.childCount - 1 do
					local var_354_3 = var_354_2:GetChild(iter_354_4)

					if var_354_3.name == "split_2" then
						var_354_3:SetAsLastSibling()
						var_354_3.gameObject:SetActive(true)

						arg_351_1.var_.actorSpriteSplit1094 = var_354_3.gameObject:GetComponent(typeof(Image))

						arg_351_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_354_4 = 0.5

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				var_354_2.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_351_1.time_ - 0) / var_354_4)

				if arg_351_1.var_.actorSpriteSplit1094 ~= nil then
					arg_351_1.var_.actorSpriteSplit1094:SetAlpha((arg_351_1.time_ - 0) / var_354_4)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				var_354_2.localPosition = Vector3.New(0, -335, -230)

				if arg_351_1.var_.actorSpriteSplit1094 ~= nil then
					arg_351_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_354_5 = 0
			local var_354_6 = 0.25

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:GetWordFromCfg(424061086)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 10 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 10)

				if (10 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 10)) > 0 and var_354_6 < var_354_10 then
					arg_351_1.talkMaxDuration = var_354_10

					if var_354_10 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061086", "story_v_out_424061.awb") ~= 0 then
					local var_354_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061086", "story_v_out_424061.awb") / 1000

					if var_354_11 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_5
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_out_424061", "424061086", "story_v_out_424061.awb")

						arg_351_1:RecordAudio("424061086", var_354_12)
						arg_351_1:RecordAudio("424061086", var_354_12)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_424061", "424061086", "story_v_out_424061.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_424061", "424061086", "story_v_out_424061.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_13 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_13 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_13

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_13 and arg_351_1.time_ < var_354_5 + var_354_13 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play424061087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 424061087
		arg_355_1.duration_ = 5.63

		local var_355_0 = {
			zh = 3.9,
			ja = 5.633
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
				arg_355_0:Play424061088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1094"]) and arg_355_1.var_.actorSpriteComps1094 == nil then
				arg_355_1.var_.actorSpriteComps1094 = arg_355_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1094"]) then
				if arg_355_1.var_.actorSpriteComps1094 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								iter_358_1.color = Color.New(Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_0), Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_0), (Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_0)))
							else
								local var_358_1 = Mathf.Lerp(iter_358_1.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_0)

								iter_358_1.color = Color.New(var_358_1, var_358_1, var_358_1)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1094"]) and arg_355_1.var_.actorSpriteComps1094 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_358_3 then
						iter_358_3.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps1094 = nil
			end

			local var_358_2 = 0
			local var_358_3 = 0.425

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_4 = arg_355_1:GetWordFromCfg(424061087)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_7 = 17 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_5) / 17)

				if (17 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_5) / 17)) > 0 and var_358_3 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_2
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061087", "story_v_out_424061.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061087", "story_v_out_424061.awb") / 1000

					if var_358_8 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_2
					end

					if var_358_4.prefab_name ~= "" and arg_355_1.actors_[var_358_4.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_4.prefab_name].transform, "story_v_out_424061", "424061087", "story_v_out_424061.awb")

						arg_355_1:RecordAudio("424061087", var_358_9)
						arg_355_1:RecordAudio("424061087", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_424061", "424061087", "story_v_out_424061.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_424061", "424061087", "story_v_out_424061.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_3, arg_355_1.talkMaxDuration)

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_2) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_2 + var_358_10 and arg_355_1.time_ < var_358_2 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play424061088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 424061088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play424061089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(424061088).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 40 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 40)

				if (40 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 40)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play424061089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 424061089
		arg_363_1.duration_ = 9

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play424061090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_9000

			if 1.966 < arg_363_1.time_ and arg_363_1.time_ <= 1.966 + arg_366_0 then
				arg_363_1.var_.moveOldPos1094 = arg_363_1.actors_["1094"].transform.localPosition
				arg_363_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1094", 7)

				for iter_366_0 = 0, arg_363_1.actors_["1094"].transform.childCount - 1 do
					local var_366_0 = arg_363_1.actors_["1094"].transform:GetChild(iter_366_0)

					if var_366_0.name == "" or not string.find(var_366_0.name, "split") then
						var_366_0.gameObject:SetActive(true)
					else
						var_366_0.gameObject:SetActive(false)
					end
				end
			end

			local var_366_1 = 0.001

			if 1.966 <= arg_363_1.time_ and arg_363_1.time_ < 1.966 + var_366_1 then
				arg_363_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_363_1.time_ - 1.966) / var_366_1)
			end

			if arg_363_1.time_ >= 1.966 + var_366_1 and arg_363_1.time_ < 1.966 + var_366_1 + arg_366_0 then
				arg_363_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_366_2 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_3 = 2

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_3 then
				local var_366_4 = Color.New(0, 0, 0)

				var_366_4.a = Mathf.Lerp(0, 1, (arg_363_1.time_ - var_366_2) / var_366_3)
				arg_363_1.mask_.color = var_366_4
			end

			if arg_363_1.time_ >= var_366_2 + var_366_3 and arg_363_1.time_ < var_366_2 + var_366_3 + arg_366_0 then
				local var_366_5 = Color.New(0, 0, 0)

				var_366_5.a = 1
				arg_363_1.mask_.color = var_366_5
			end

			local var_366_6 = 2

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_7 = 2

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_7 then
				local var_366_8 = Color.New(0, 0, 0)

				var_366_8.a = Mathf.Lerp(1, 0, (arg_363_1.time_ - var_366_6) / var_366_7)
				arg_363_1.mask_.color = var_366_8
			end

			if arg_363_1.time_ >= var_366_6 + var_366_7 and arg_363_1.time_ < var_366_6 + var_366_7 + arg_366_0 then
				local var_366_9 = Color.New(0, 0, 0)

				arg_363_1.mask_.enabled = false
				var_366_9.a = 0
				arg_363_1.mask_.color = var_366_9
			end

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= 2 + arg_366_0 then
				local var_366_10 = arg_363_1.var_.effectnongwu461

				if not arg_363_1.var_.effectnongwu461 then
					var_366_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_in"), manager.ui.mainCamera.transform)
					var_366_10.name = "nongwu461"
					arg_363_1.var_.effectnongwu461 = var_366_10
				else
					var_366_10.transform:SetParent(var_366_9000)
				end

				var_366_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_366_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.233333333333333 < arg_363_1.time_ and arg_363_1.time_ <= 0.233333333333333 + arg_366_0 then
				arg_363_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_366_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_363_1.bgmTxt_.text ~= var_366_14 and arg_363_1.bgmTxt_.text ~= "" then
						if arg_363_1.bgmTxt2_.text ~= "" then
							arg_363_1.bgmTxt_.text = arg_363_1.bgmTxt2_.text
						end

						arg_363_1.bgmTxt2_.text = var_366_14

						arg_363_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_363_1.bgmTxt_.text = var_366_14
						arg_363_1.bgmTxt2_.text = var_366_14
					end

					if arg_363_1.bgmTimer then
						arg_363_1.bgmTimer:Stop()

						arg_363_1.bgmTimer = nil
					end

					if arg_363_1.settingData.show_music_name == 1 then
						arg_363_1.musicController:SetSelectedState("show")
						arg_363_1.musicAnimator_:Play("open", 0, 0)

						if arg_363_1.settingData.music_time ~= 0 then
							arg_363_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_363_1.settingData.music_time), function()
								if arg_363_1 == nil or isNil(arg_363_1.bgmTxt_) then
									return
								end

								arg_363_1.musicController:SetSelectedState("hide")
								arg_363_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.76666666666667 < arg_363_1.time_ and arg_363_1.time_ <= 1.76666666666667 + arg_366_0 then
				arg_363_1:AudioAction("play", "music", "bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle.awb")

				local var_366_17 = manager.audio:GetAudioName("bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle")

				if "" ~= "" then
					if arg_363_1.bgmTxt_.text ~= var_366_17 and arg_363_1.bgmTxt_.text ~= "" then
						if arg_363_1.bgmTxt2_.text ~= "" then
							arg_363_1.bgmTxt_.text = arg_363_1.bgmTxt2_.text
						end

						arg_363_1.bgmTxt2_.text = var_366_17

						arg_363_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_363_1.bgmTxt_.text = var_366_17
						arg_363_1.bgmTxt2_.text = var_366_17
					end

					if arg_363_1.bgmTimer then
						arg_363_1.bgmTimer:Stop()

						arg_363_1.bgmTimer = nil
					end

					if arg_363_1.settingData.show_music_name == 1 then
						arg_363_1.musicController:SetSelectedState("show")
						arg_363_1.musicAnimator_:Play("open", 0, 0)

						if arg_363_1.settingData.music_time ~= 0 then
							arg_363_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_363_1.settingData.music_time), function()
								if arg_363_1 == nil or isNil(arg_363_1.bgmTxt_) then
									return
								end

								arg_363_1.musicController:SetSelectedState("hide")
								arg_363_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_363_1.frameCnt_ <= 1 then
				arg_363_1.dialog_:SetActive(false)
			end

			local var_366_18 = 4
			local var_366_19 = 0.85

			if 4 < arg_363_1.time_ and arg_363_1.time_ <= var_366_18 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				arg_363_1.dialog_:SetActive(true)

				arg_363_1.dialogCg_.alpha = 0

				local var_366_20 = LeanTween.value(arg_363_1.dialog_, 0, 1, 0.3)

				var_366_20:setOnUpdate(LuaHelper.FloatAction(function(arg_369_0)
					arg_363_1.dialogCg_.alpha = arg_369_0
				end))
				var_366_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_363_1.dialog_)
					var_366_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_363_1.duration_ = arg_363_1.duration_ + 0.3

				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_21 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(424061089).content)

				arg_363_1.text_.text = var_366_21

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_23 = 34 <= 0 and var_366_19 or var_366_19 * (utf8.len(var_366_21) / 34)

				if (34 <= 0 and var_366_19 or var_366_19 * (utf8.len(var_366_21) / 34)) > 0 and var_366_19 < var_366_23 then
					arg_363_1.talkMaxDuration = var_366_23
					var_366_18 = var_366_18 + 0.3

					if var_366_23 + var_366_18 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_18
					end
				end

				arg_363_1.text_.text = var_366_21
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_24 = var_366_18 + 0.3
			local var_366_25 = math.max(var_366_19, arg_363_1.talkMaxDuration)

			if var_366_18 + 0.3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_24 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_24) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_24 + var_366_25 and arg_363_1.time_ < var_366_24 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play424061090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 424061090
		arg_371_1.duration_ = 3.9

		local var_371_0 = {
			zh = 3.833,
			ja = 3.9
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
				arg_371_0:Play424061091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.45

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:GetWordFromCfg(424061090)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 18 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 18)

				if (18 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 18)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061090", "story_v_out_424061.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061090", "story_v_out_424061.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_424061", "424061090", "story_v_out_424061.awb")

						arg_371_1:RecordAudio("424061090", var_374_6)
						arg_371_1:RecordAudio("424061090", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_424061", "424061090", "story_v_out_424061.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_424061", "424061090", "story_v_out_424061.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play424061091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 424061091
		arg_375_1.duration_ = 1.8

		local var_375_0 = {
			zh = 1.533,
			ja = 1.8
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
				arg_375_0:Play424061092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1094"]) and arg_375_1.var_.actorSpriteComps1094 == nil then
				arg_375_1.var_.actorSpriteComps1094 = arg_375_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_0 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1094"]) then
				if arg_375_1.var_.actorSpriteComps1094 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								iter_378_1.color = Color.New(Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_0), Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_0), (Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_0)))
							else
								local var_378_1 = Mathf.Lerp(iter_378_1.color.r, 1, (arg_375_1.time_ - 0) / var_378_0)

								iter_378_1.color = Color.New(var_378_1, var_378_1, var_378_1)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1094"]) and arg_375_1.var_.actorSpriteComps1094 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_378_3 then
						iter_378_3.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps1094 = nil
			end

			local var_378_2 = arg_375_1.actors_["1094"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1094 = var_378_2.localPosition
				var_378_2.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1094", 3)

				for iter_378_4 = 0, var_378_2.childCount - 1 do
					local var_378_3 = var_378_2:GetChild(iter_378_4)

					if var_378_3.name == "split_4" or not string.find(var_378_3.name, "split") then
						var_378_3.gameObject:SetActive(true)
					else
						var_378_3.gameObject:SetActive(false)
					end
				end
			end

			local var_378_4 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_2.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_375_1.time_ - 0) / var_378_4)
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_378_5 = 0
			local var_378_6 = 0.125

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(424061091)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 5 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 5)

				if (5 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 5)) > 0 and var_378_6 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10

					if var_378_10 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061091", "story_v_out_424061.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061091", "story_v_out_424061.awb") / 1000

					if var_378_11 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_5
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_424061", "424061091", "story_v_out_424061.awb")

						arg_375_1:RecordAudio("424061091", var_378_12)
						arg_375_1:RecordAudio("424061091", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_424061", "424061091", "story_v_out_424061.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_424061", "424061091", "story_v_out_424061.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_13 and arg_375_1.time_ < var_378_5 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play424061092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 424061092
		arg_379_1.duration_ = 2.77

		local var_379_0 = {
			zh = 1.6,
			ja = 2.766
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
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play424061093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1094"]) and arg_379_1.var_.actorSpriteComps1094 == nil then
				arg_379_1.var_.actorSpriteComps1094 = arg_379_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1094"]) then
				if arg_379_1.var_.actorSpriteComps1094 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								iter_382_1.color = Color.New(Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor2.r, (arg_379_1.time_ - 0) / var_382_0), Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor2.g, (arg_379_1.time_ - 0) / var_382_0), (Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor2.b, (arg_379_1.time_ - 0) / var_382_0)))
							else
								local var_382_1 = Mathf.Lerp(iter_382_1.color.r, 0.5, (arg_379_1.time_ - 0) / var_382_0)

								iter_382_1.color = Color.New(var_382_1, var_382_1, var_382_1)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1094"]) and arg_379_1.var_.actorSpriteComps1094 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_382_3 then
						iter_382_3.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_379_1.var_.actorSpriteComps1094 = nil
			end

			local var_382_2 = 0
			local var_382_3 = 0.225

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_4 = arg_379_1:GetWordFromCfg(424061092)
				local var_382_5 = arg_379_1:FormatText(var_382_4.content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 9 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 9)

				if (9 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 9)) > 0 and var_382_3 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061092", "story_v_out_424061.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061092", "story_v_out_424061.awb") / 1000

					if var_382_8 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_2
					end

					if var_382_4.prefab_name ~= "" and arg_379_1.actors_[var_382_4.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_4.prefab_name].transform, "story_v_out_424061", "424061092", "story_v_out_424061.awb")

						arg_379_1:RecordAudio("424061092", var_382_9)
						arg_379_1:RecordAudio("424061092", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_424061", "424061092", "story_v_out_424061.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_424061", "424061092", "story_v_out_424061.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_10 and arg_379_1.time_ < var_382_2 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play424061093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 424061093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play424061094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.475

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(424061093).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 19 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 19)

				if (19 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 19)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play424061094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 424061094
		arg_387_1.duration_ = 1.37

		local var_387_0 = {
			zh = 1.2,
			ja = 1.366
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play424061095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.075

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:GetWordFromCfg(424061094)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 3 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 3)

				if (3 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 3)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061094", "story_v_out_424061.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061094", "story_v_out_424061.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_out_424061", "424061094", "story_v_out_424061.awb")

						arg_387_1:RecordAudio("424061094", var_390_6)
						arg_387_1:RecordAudio("424061094", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_424061", "424061094", "story_v_out_424061.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_424061", "424061094", "story_v_out_424061.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play424061095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 424061095
		arg_391_1.duration_ = 2.53

		local var_391_0 = {
			zh = 1.833,
			ja = 2.533
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play424061096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1094"]) and arg_391_1.var_.actorSpriteComps1094 == nil then
				arg_391_1.var_.actorSpriteComps1094 = arg_391_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1094"]) then
				if arg_391_1.var_.actorSpriteComps1094 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								iter_394_1.color = Color.New(Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor1.r, (arg_391_1.time_ - 0) / var_394_0), Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor1.g, (arg_391_1.time_ - 0) / var_394_0), (Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor1.b, (arg_391_1.time_ - 0) / var_394_0)))
							else
								local var_394_1 = Mathf.Lerp(iter_394_1.color.r, 1, (arg_391_1.time_ - 0) / var_394_0)

								iter_394_1.color = Color.New(var_394_1, var_394_1, var_394_1)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1094"]) and arg_391_1.var_.actorSpriteComps1094 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_394_3 then
						iter_394_3.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_391_1.var_.actorSpriteComps1094 = nil
			end

			local var_394_2 = arg_391_1.actors_["1094"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1094 = var_394_2.localPosition
				var_394_2.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("1094", 3)

				for iter_394_4 = 0, var_394_2.childCount - 1 do
					local var_394_3 = var_394_2:GetChild(iter_394_4)

					if var_394_3.name == "split_1" then
						var_394_3:SetAsLastSibling()
						var_394_3.gameObject:SetActive(true)

						arg_391_1.var_.actorSpriteSplit1094 = var_394_3.gameObject:GetComponent(typeof(Image))

						arg_391_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_394_4 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				var_394_2.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_391_1.time_ - 0) / var_394_4)

				if arg_391_1.var_.actorSpriteSplit1094 ~= nil then
					arg_391_1.var_.actorSpriteSplit1094:SetAlpha((arg_391_1.time_ - 0) / var_394_4)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				var_394_2.localPosition = Vector3.New(0, -335, -230)

				if arg_391_1.var_.actorSpriteSplit1094 ~= nil then
					arg_391_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_394_5 = 0
			local var_394_6 = 0.175

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_7 = arg_391_1:GetWordFromCfg(424061095)
				local var_394_8 = arg_391_1:FormatText(var_394_7.content)

				arg_391_1.text_.text = var_394_8

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_10 = 7 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 7)

				if (7 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 7)) > 0 and var_394_6 < var_394_10 then
					arg_391_1.talkMaxDuration = var_394_10

					if var_394_10 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_5
					end
				end

				arg_391_1.text_.text = var_394_8
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061095", "story_v_out_424061.awb") ~= 0 then
					local var_394_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061095", "story_v_out_424061.awb") / 1000

					if var_394_11 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_11 + var_394_5
					end

					if var_394_7.prefab_name ~= "" and arg_391_1.actors_[var_394_7.prefab_name] ~= nil then
						local var_394_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_7.prefab_name].transform, "story_v_out_424061", "424061095", "story_v_out_424061.awb")

						arg_391_1:RecordAudio("424061095", var_394_12)
						arg_391_1:RecordAudio("424061095", var_394_12)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_424061", "424061095", "story_v_out_424061.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_424061", "424061095", "story_v_out_424061.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_13 = math.max(var_394_6, arg_391_1.talkMaxDuration)

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_13 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_5) / var_394_13

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_5 + var_394_13 and arg_391_1.time_ < var_394_5 + var_394_13 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play424061096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 424061096
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play424061097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1094"]) and arg_395_1.var_.actorSpriteComps1094 == nil then
				arg_395_1.var_.actorSpriteComps1094 = arg_395_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1094"]) then
				if arg_395_1.var_.actorSpriteComps1094 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								iter_398_1.color = Color.New(Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, (arg_395_1.time_ - 0) / var_398_0), Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, (arg_395_1.time_ - 0) / var_398_0), (Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, (arg_395_1.time_ - 0) / var_398_0)))
							else
								local var_398_1 = Mathf.Lerp(iter_398_1.color.r, 0.5, (arg_395_1.time_ - 0) / var_398_0)

								iter_398_1.color = Color.New(var_398_1, var_398_1, var_398_1)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1094"]) and arg_395_1.var_.actorSpriteComps1094 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_398_3 then
						iter_398_3.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_395_1.var_.actorSpriteComps1094 = nil
			end

			local var_398_2 = arg_395_1.actors_["1094"].transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1094 = var_398_2.localPosition
				var_398_2.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("1094", 7)

				for iter_398_4 = 0, var_398_2.childCount - 1 do
					local var_398_3 = var_398_2:GetChild(iter_398_4)

					if var_398_3.name == "" or not string.find(var_398_3.name, "split") then
						var_398_3.gameObject:SetActive(true)
					else
						var_398_3.gameObject:SetActive(false)
					end
				end
			end

			local var_398_4 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				var_398_2.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_395_1.time_ - 0) / var_398_4)
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				var_398_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_398_5 = 0
			local var_398_6 = 1.825

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_5 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_7 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(424061096).content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 73 <= 0 and var_398_6 or var_398_6 * (utf8.len(var_398_7) / 73)

				if (73 <= 0 and var_398_6 or var_398_6 * (utf8.len(var_398_7) / 73)) > 0 and var_398_6 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_5 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_5
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_6, arg_395_1.talkMaxDuration)

			if var_398_5 <= arg_395_1.time_ and arg_395_1.time_ < var_398_5 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_5) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_5 + var_398_10 and arg_395_1.time_ < var_398_5 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
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

		arg_395_1:InitPlayNodeList()
	end,
	Play424061097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 424061097
		arg_399_1.duration_ = 2.53

		local var_399_0 = {
			zh = 1.4,
			ja = 2.533
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play424061160(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1094"]) and arg_399_1.var_.actorSpriteComps1094 == nil then
				arg_399_1.var_.actorSpriteComps1094 = arg_399_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_0 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1094"]) then
				if arg_399_1.var_.actorSpriteComps1094 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								iter_402_1.color = Color.New(Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor1.r, (arg_399_1.time_ - 0) / var_402_0), Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor1.g, (arg_399_1.time_ - 0) / var_402_0), (Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor1.b, (arg_399_1.time_ - 0) / var_402_0)))
							else
								local var_402_1 = Mathf.Lerp(iter_402_1.color.r, 1, (arg_399_1.time_ - 0) / var_402_0)

								iter_402_1.color = Color.New(var_402_1, var_402_1, var_402_1)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1094"]) and arg_399_1.var_.actorSpriteComps1094 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_402_3 then
						iter_402_3.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_399_1.var_.actorSpriteComps1094 = nil
			end

			local var_402_2 = arg_399_1.actors_["1094"].transform

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1094 = var_402_2.localPosition
				var_402_2.localScale = Vector3.New(1, 1, 1)

				arg_399_1:CheckSpriteTmpPos("1094", 3)

				for iter_402_4 = 0, var_402_2.childCount - 1 do
					local var_402_3 = var_402_2:GetChild(iter_402_4)

					if var_402_3.name == "split_3" or not string.find(var_402_3.name, "split") then
						var_402_3.gameObject:SetActive(true)
					else
						var_402_3.gameObject:SetActive(false)
					end
				end
			end

			local var_402_4 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				var_402_2.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_399_1.time_ - 0) / var_402_4)
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				var_402_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_402_5 = 0
			local var_402_6 = 0.15

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_7 = arg_399_1:GetWordFromCfg(424061097)
				local var_402_8 = arg_399_1:FormatText(var_402_7.content)

				arg_399_1.text_.text = var_402_8

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 6 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 6)

				if (6 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 6)) > 0 and var_402_6 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_5
					end
				end

				arg_399_1.text_.text = var_402_8
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061097", "story_v_out_424061.awb") ~= 0 then
					local var_402_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061097", "story_v_out_424061.awb") / 1000

					if var_402_11 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_11 + var_402_5
					end

					if var_402_7.prefab_name ~= "" and arg_399_1.actors_[var_402_7.prefab_name] ~= nil then
						local var_402_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_7.prefab_name].transform, "story_v_out_424061", "424061097", "story_v_out_424061.awb")

						arg_399_1:RecordAudio("424061097", var_402_12)
						arg_399_1:RecordAudio("424061097", var_402_12)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_424061", "424061097", "story_v_out_424061.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_424061", "424061097", "story_v_out_424061.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_13 = math.max(var_402_6, arg_399_1.talkMaxDuration)

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_13 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_5) / var_402_13

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_5 + var_402_13 and arg_399_1.time_ < var_402_5 + var_402_13 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
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

		arg_399_1:InitPlayNodeList()
	end,
	Play424061160 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 424061160
		arg_403_1.duration_ = 1

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play424061098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1094 = arg_403_1.actors_["1094"].transform.localPosition
				arg_403_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("1094", 7)

				for iter_406_0 = 0, arg_403_1.actors_["1094"].transform.childCount - 1 do
					local var_406_0 = arg_403_1.actors_["1094"].transform:GetChild(iter_406_0)

					if var_406_0.name == "" or not string.find(var_406_0.name, "split") then
						var_406_0.gameObject:SetActive(true)
					else
						var_406_0.gameObject:SetActive(false)
					end
				end
			end

			local var_406_1 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_1 then
				arg_403_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_403_1.time_ - 0) / var_406_1)
			end

			if arg_403_1.time_ >= 0 + var_406_1 and arg_403_1.time_ < 0 + var_406_1 + arg_406_0 then
				arg_403_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.actionList["00"] = not arg_403_1.actionList["00"] and StoryInteractionSingleClickGame.New(arg_403_1, "Widget/System/Story/ActionPrefab/UX_4_6_StoryActionUI") or StoryInteractionSingleClickGame.NewWithGameObject(arg_403_1, arg_403_1.actionList["00"].gameObject_)

				arg_403_1.actionList["00"]:SetData({
					hideOnEndGame = false,
					enterClipName = "StoryAction_Test_Panel_enter",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "step_1_btn_",
					enterHideStoryUI = true,
					completeClipName = "StoryAction_Test_Panel_step1_complete",
					enterController = {
						{
							"ux_4_6_story_controller_",
							"tips",
							1
						},
						{
							"ux_4_6_story_controller_",
							"slider",
							1
						}
					},
					completeController = {}
				})
			end
		end

		arg_403_1.nodeConfigList_ = {
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

		arg_403_1:InitPlayNodeList()
	end,
	Play424061098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 424061098
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play424061099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.825

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(424061098).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 33 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 33)

				if (33 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 33)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play424061099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 424061099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play424061161(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.925

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(424061099).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 16 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 16)

				if (16 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 16)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play424061161 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 424061161
		arg_415_1.duration_ = 1

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play424061162(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.actionList["00"] = not arg_415_1.actionList["00"] and StoryInteractionDragGame.New(arg_415_1, "Widget/System/Story/ActionPrefab/UX_4_6_StoryActionUI") or StoryInteractionDragGame.NewWithGameObject(arg_415_1, arg_415_1.actionList["00"].gameObject_)

				arg_415_1.actionList["00"]:SetData({
					uiSliderName = "step_3_slider_",
					hideOnEndGame = false,
					enterClipName = "empty",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					enterHideStoryUI = true,
					completeClipName = "StoryAction_Test_Panel_step2_01_complete",
					enterController = {
						{
							"ux_4_6_story_controller_",
							"tips",
							0
						},
						{
							"ux_4_6_story_controller_",
							"slider",
							0
						}
					},
					completeController = {
						{
							"ux_4_6_story_controller_",
							"slider",
							1
						}
					},
					completeVoice = {
						"effect",
						"se_story_10",
						"se_story_10_sword02",
						""
					}
				})
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play424061162 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 424061162
		arg_419_1.duration_ = 1

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play424061163(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.actionList["00"] = not arg_419_1.actionList["00"] and StoryInteractionDragGame.New(arg_419_1, "Widget/System/Story/ActionPrefab/UX_4_6_StoryActionUI") or StoryInteractionDragGame.NewWithGameObject(arg_419_1, arg_419_1.actionList["00"].gameObject_)

				arg_419_1.actionList["00"]:SetData({
					uiSliderName = "step_3_slider_",
					hideOnEndGame = false,
					enterClipName = "empty",
					completeShowStoryUI = false,
					isNeedInteraction = true,
					enterHideStoryUI = true,
					completeClipName = "StoryAction_Test_Panel_step2_02_complete",
					enterController = {
						{
							"ux_4_6_story_controller_",
							"slider",
							0
						}
					},
					completeController = {
						{
							"ux_4_6_story_controller_",
							"slider",
							1
						}
					},
					completeVoice = {
						"effect",
						"se_story_10",
						"se_story_10_sword02",
						""
					}
				})
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play424061163 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 424061163
		arg_423_1.duration_ = 1

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play424061100(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.actionList["00"] = not arg_423_1.actionList["00"] and StoryInteractionDragGame.New(arg_423_1, "Widget/System/Story/ActionPrefab/UX_4_6_StoryActionUI") or StoryInteractionDragGame.NewWithGameObject(arg_423_1, arg_423_1.actionList["00"].gameObject_)

				arg_423_1.actionList["00"]:SetData({
					uiSliderName = "step_3_slider_",
					hideOnEndGame = false,
					enterClipName = "empty",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					enterHideStoryUI = true,
					completeClipName = "StoryAction_Test_Panel_step2_03_complete",
					enterController = {
						{
							"ux_4_6_story_controller_",
							"slider",
							0
						}
					},
					completeController = {
						{
							"ux_4_6_story_controller_",
							"tips",
							1
						},
						{
							"ux_4_6_story_controller_",
							"slider",
							1
						},
						{
							"nameplate_controller_",
							"default0",
							1
						}
					},
					completeVoice = {
						"effect",
						"se_story_10",
						"se_story_10_sword02",
						""
					}
				})
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play424061100 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 424061100
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play424061101(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.375

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(424061100).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 15 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 15)

				if (15 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 15)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play424061101 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 424061101
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play424061102(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.275

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(424061101).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 51 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 51)

				if (51 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 51)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play424061102 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 424061102
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play424061103(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 1.075

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(424061102).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 43 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 43)

				if (43 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 43)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play424061103 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 424061103
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play424061104(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 1.075

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(424061103).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 43 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 43)

				if (43 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 43)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play424061104 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 424061104
		arg_443_1.duration_ = 3.53

		local var_443_0 = {
			zh = 3.533,
			ja = 2.766
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play424061105(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.3

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094_split_1")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:GetWordFromCfg(424061104)
				local var_446_2 = arg_443_1:FormatText(var_446_1.content)

				arg_443_1.text_.text = var_446_2

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_4 = 12 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 12)

				if (12 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 12)) > 0 and var_446_0 < var_446_4 then
					arg_443_1.talkMaxDuration = var_446_4

					if var_446_4 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_4 + 0
					end
				end

				arg_443_1.text_.text = var_446_2
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061104", "story_v_out_424061.awb") ~= 0 then
					local var_446_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061104", "story_v_out_424061.awb") / 1000

					if var_446_5 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + 0
					end

					if var_446_1.prefab_name ~= "" and arg_443_1.actors_[var_446_1.prefab_name] ~= nil then
						local var_446_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_1.prefab_name].transform, "story_v_out_424061", "424061104", "story_v_out_424061.awb")

						arg_443_1:RecordAudio("424061104", var_446_6)
						arg_443_1:RecordAudio("424061104", var_446_6)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_424061", "424061104", "story_v_out_424061.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_424061", "424061104", "story_v_out_424061.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_7 and arg_443_1.time_ < 0 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play424061105 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 424061105
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play424061106(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["1094"]) and arg_447_1.var_.actorSpriteComps1094 == nil then
				arg_447_1.var_.actorSpriteComps1094 = arg_447_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_0 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["1094"]) then
				if arg_447_1.var_.actorSpriteComps1094 then
					for iter_450_0, iter_450_1 in pairs(arg_447_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_450_1 then
							if arg_447_1.isInRecall_ then
								iter_450_1.color = Color.New(Mathf.Lerp(iter_450_1.color.r, arg_447_1.hightColor2.r, (arg_447_1.time_ - 0) / var_450_0), Mathf.Lerp(iter_450_1.color.g, arg_447_1.hightColor2.g, (arg_447_1.time_ - 0) / var_450_0), (Mathf.Lerp(iter_450_1.color.b, arg_447_1.hightColor2.b, (arg_447_1.time_ - 0) / var_450_0)))
							else
								local var_450_1 = Mathf.Lerp(iter_450_1.color.r, 0.5, (arg_447_1.time_ - 0) / var_450_0)

								iter_450_1.color = Color.New(var_450_1, var_450_1, var_450_1)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["1094"]) and arg_447_1.var_.actorSpriteComps1094 then
				for iter_450_2, iter_450_3 in pairs(arg_447_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_450_3 then
						iter_450_3.color = arg_447_1.isInRecall_ and (arg_447_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_447_1.var_.actorSpriteComps1094 = nil
			end

			local var_450_2 = 0
			local var_450_3 = 0.375

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_4 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(424061105).content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_6 = 15 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_4) / 15)

				if (15 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_4) / 15)) > 0 and var_450_3 < var_450_6 then
					arg_447_1.talkMaxDuration = var_450_6

					if var_450_6 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_6 + var_450_2
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_3, arg_447_1.talkMaxDuration)

			if var_450_2 <= arg_447_1.time_ and arg_447_1.time_ < var_450_2 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_2) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_2 + var_450_7 and arg_447_1.time_ < var_450_2 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play424061106 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 424061106
		arg_451_1.duration_ = 5.53

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play424061107(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.actionList["00"] = not arg_451_1.actionList["00"] and StoryInteractionDragGame.New(arg_451_1, "Widget/System/Story/ActionPrefab/UX_4_6_StoryActionUI") or StoryInteractionDragGame.NewWithGameObject(arg_451_1, arg_451_1.actionList["00"].gameObject_)

				arg_451_1.actionList["00"]:SetData({
					hideOnEndGame = true,
					enterClipName = "empty",
					completeShowStoryUI = true,
					isNeedInteraction = false,
					uiSliderName = "step_3_slider_",
					enterHideStoryUI = true,
					completeClipName = "StoryAction_Test_Panel_step3_complete",
					enterController = {},
					completeController = {}
				})
			end

			if arg_451_1.frameCnt_ <= 1 then
				arg_451_1.dialog_:SetActive(false)
			end

			local var_454_2 = 0.533333333333333
			local var_454_3 = 1.55

			if 0.533333333333333 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0

				arg_451_1.dialog_:SetActive(true)

				arg_451_1.dialogCg_.alpha = 0

				local var_454_4 = LeanTween.value(arg_451_1.dialog_, 0, 1, 0.3)

				var_454_4:setOnUpdate(LuaHelper.FloatAction(function(arg_455_0)
					arg_451_1.dialogCg_.alpha = arg_455_0
				end))
				var_454_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_451_1.dialog_)
					var_454_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_451_1.duration_ = arg_451_1.duration_ + 0.3

				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_5 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(424061106).content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_7 = 62 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 62)

				if (62 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 62)) > 0 and var_454_3 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7
					var_454_2 = var_454_2 + 0.3

					if var_454_7 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_8 = var_454_2 + 0.3
			local var_454_9 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 + 0.3 <= arg_451_1.time_ and arg_451_1.time_ < var_454_8 + var_454_9 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_8) / var_454_9

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_8 + var_454_9 and arg_451_1.time_ < var_454_8 + var_454_9 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play424061107 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424061107
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play424061108(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.275

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(424061107).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 11 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 11)

				if (11 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 11)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play424061108 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 424061108
		arg_461_1.duration_ = 2.27

		local var_461_0 = {
			zh = 1.5,
			ja = 2.266
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play424061109(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1094"]) and arg_461_1.var_.actorSpriteComps1094 == nil then
				arg_461_1.var_.actorSpriteComps1094 = arg_461_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_0 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1094"]) then
				if arg_461_1.var_.actorSpriteComps1094 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								iter_464_1.color = Color.New(Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, (arg_461_1.time_ - 0) / var_464_0), Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, (arg_461_1.time_ - 0) / var_464_0), (Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, (arg_461_1.time_ - 0) / var_464_0)))
							else
								local var_464_1 = Mathf.Lerp(iter_464_1.color.r, 1, (arg_461_1.time_ - 0) / var_464_0)

								iter_464_1.color = Color.New(var_464_1, var_464_1, var_464_1)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1094"]) and arg_461_1.var_.actorSpriteComps1094 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps1094 = nil
			end

			local var_464_2 = arg_461_1.actors_["1094"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1094 = var_464_2.localPosition
				var_464_2.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("1094", 3)

				for iter_464_4 = 0, var_464_2.childCount - 1 do
					local var_464_3 = var_464_2:GetChild(iter_464_4)

					if var_464_3.name == "split_5" then
						var_464_3:SetAsLastSibling()
						var_464_3.gameObject:SetActive(true)

						arg_461_1.var_.actorSpriteSplit1094 = var_464_3.gameObject:GetComponent(typeof(Image))

						arg_461_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_464_4 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				var_464_2.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_461_1.time_ - 0) / var_464_4)

				if arg_461_1.var_.actorSpriteSplit1094 ~= nil then
					arg_461_1.var_.actorSpriteSplit1094:SetAlpha((arg_461_1.time_ - 0) / var_464_4)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				var_464_2.localPosition = Vector3.New(0, -335, -230)

				if arg_461_1.var_.actorSpriteSplit1094 ~= nil then
					arg_461_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_464_5 = 0
			local var_464_6 = 0.175

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_7 = arg_461_1:GetWordFromCfg(424061108)
				local var_464_8 = arg_461_1:FormatText(var_464_7.content)

				arg_461_1.text_.text = var_464_8

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_10 = 7 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 7)

				if (7 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 7)) > 0 and var_464_6 < var_464_10 then
					arg_461_1.talkMaxDuration = var_464_10

					if var_464_10 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_5
					end
				end

				arg_461_1.text_.text = var_464_8
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061108", "story_v_out_424061.awb") ~= 0 then
					local var_464_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061108", "story_v_out_424061.awb") / 1000

					if var_464_11 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_11 + var_464_5
					end

					if var_464_7.prefab_name ~= "" and arg_461_1.actors_[var_464_7.prefab_name] ~= nil then
						local var_464_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_7.prefab_name].transform, "story_v_out_424061", "424061108", "story_v_out_424061.awb")

						arg_461_1:RecordAudio("424061108", var_464_12)
						arg_461_1:RecordAudio("424061108", var_464_12)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_424061", "424061108", "story_v_out_424061.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_424061", "424061108", "story_v_out_424061.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_13 = math.max(var_464_6, arg_461_1.talkMaxDuration)

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_13 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_5) / var_464_13

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_5 + var_464_13 and arg_461_1.time_ < var_464_5 + var_464_13 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play424061109 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 424061109
		arg_465_1.duration_ = 6

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play424061110(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_9003
			local var_468_9002
			local var_468_9001
			local var_468_9000

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1094"]) and arg_465_1.var_.actorSpriteComps1094 == nil then
				arg_465_1.var_.actorSpriteComps1094 = arg_465_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_0 = 0.034

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1094"]) then
				if arg_465_1.var_.actorSpriteComps1094 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_468_1 then
							if arg_465_1.isInRecall_ then
								iter_468_1.color = Color.New(Mathf.Lerp(iter_468_1.color.r, arg_465_1.hightColor2.r, (arg_465_1.time_ - 0) / var_468_0), Mathf.Lerp(iter_468_1.color.g, arg_465_1.hightColor2.g, (arg_465_1.time_ - 0) / var_468_0), (Mathf.Lerp(iter_468_1.color.b, arg_465_1.hightColor2.b, (arg_465_1.time_ - 0) / var_468_0)))
							else
								local var_468_1 = Mathf.Lerp(iter_468_1.color.r, 0.5, (arg_465_1.time_ - 0) / var_468_0)

								iter_468_1.color = Color.New(var_468_1, var_468_1, var_468_1)
							end
						end
					end
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1094"]) and arg_465_1.var_.actorSpriteComps1094 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_468_3 then
						iter_468_3.color = arg_465_1.isInRecall_ and (arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_465_1.var_.actorSpriteComps1094 = nil
			end

			local var_468_2 = arg_465_1.actors_["1094"].transform

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1094 = var_468_2.localPosition
				var_468_2.localScale = Vector3.New(1, 1, 1)

				arg_465_1:CheckSpriteTmpPos("1094", 7)

				for iter_468_4 = 0, var_468_2.childCount - 1 do
					local var_468_3 = var_468_2:GetChild(iter_468_4)

					if var_468_3.name == "" or not string.find(var_468_3.name, "split") then
						var_468_3.gameObject:SetActive(true)
					else
						var_468_3.gameObject:SetActive(false)
					end
				end
			end

			local var_468_4 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				var_468_2.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_465_1.time_ - 0) / var_468_4)
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				var_468_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				local var_468_5 = arg_465_1.var_.effecthongsemiwu1

				if not arg_465_1.var_.effecthongsemiwu1 then
					var_468_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_red_in"), manager.ui.mainCamera.transform)
					var_468_5.name = "hongsemiwu1"
					arg_465_1.var_.effecthongsemiwu1 = var_468_5
				else
					var_468_5.transform:SetParent(var_468_9003)
				end

				var_468_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_468_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				local var_468_7 = arg_465_1.var_.effectguanliyuankaiqiang1

				if not arg_465_1.var_.effectguanliyuankaiqiang1 then
					var_468_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_468_7.name = "guanliyuankaiqiang1"
					arg_465_1.var_.effectguanliyuankaiqiang1 = var_468_7
				else
					var_468_7.transform:SetParent(var_468_9002)
				end

				var_468_7.transform.localPosition = Vector3.New(-1, 0, 0)
				var_468_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.166666666666667 < arg_465_1.time_ and arg_465_1.time_ <= 0.166666666666667 + arg_468_0 then
				local var_468_9 = arg_465_1.var_.effectguanliyuankaiqiang2

				if not arg_465_1.var_.effectguanliyuankaiqiang2 then
					var_468_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_468_9.name = "guanliyuankaiqiang2"
					arg_465_1.var_.effectguanliyuankaiqiang2 = var_468_9
				else
					var_468_9.transform:SetParent(var_468_9001)
				end

				var_468_9.transform.localPosition = Vector3.New(-2, 0, 0)
				var_468_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.333333333333333 < arg_465_1.time_ and arg_465_1.time_ <= 0.333333333333333 + arg_468_0 then
				local var_468_11 = arg_465_1.var_.effectguanliyuankaiqiang3

				if not arg_465_1.var_.effectguanliyuankaiqiang3 then
					var_468_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_468_11.name = "guanliyuankaiqiang3"
					arg_465_1.var_.effectguanliyuankaiqiang3 = var_468_11
				else
					var_468_11.transform:SetParent(var_468_9000)
				end

				var_468_11.transform.localPosition = Vector3.New(2, -1, 0)
				var_468_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_468_13 = 0

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_13 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			if arg_465_1.time_ >= var_468_13 + 1 and arg_465_1.time_ < var_468_13 + 1 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			local var_468_14 = manager.ui.mainCamera.transform

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.shakeOldPos = var_468_14.localPosition
			end

			local var_468_15 = 0.6

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_15 then
				local var_468_16, var_468_17 = math.modf((arg_465_1.time_ - 0) / 0.066)

				var_468_14.localPosition = Vector3.New(var_468_17 * 0.13, var_468_17 * 0.13, var_468_17 * 0.13) + arg_465_1.var_.shakeOldPos
			end

			if arg_465_1.time_ >= 0 + var_468_15 and arg_465_1.time_ < 0 + var_468_15 + arg_468_0 then
				var_468_14.localPosition = arg_465_1.var_.shakeOldPos
			end

			if 0.333333333333333 < arg_465_1.time_ and arg_465_1.time_ <= 0.333333333333333 + arg_468_0 then
				if arg_465_1.var_.effectnongwu461 then
					Object.Destroy(arg_465_1.var_.effectnongwu461)

					arg_465_1.var_.effectnongwu461 = nil
				end
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun05", "")
			end

			if arg_465_1.frameCnt_ <= 1 then
				arg_465_1.dialog_:SetActive(false)
			end

			local var_468_20 = 1
			local var_468_21 = 1.35

			if 1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_20 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				arg_465_1.dialog_:SetActive(true)

				arg_465_1.dialogCg_.alpha = 0

				local var_468_22 = LeanTween.value(arg_465_1.dialog_, 0, 1, 0.3)

				var_468_22:setOnUpdate(LuaHelper.FloatAction(function(arg_469_0)
					arg_465_1.dialogCg_.alpha = arg_469_0
				end))
				var_468_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_465_1.dialog_)
					var_468_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_465_1.duration_ = arg_465_1.duration_ + 0.3

				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_23 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(424061109).content)

				arg_465_1.text_.text = var_468_23

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_25 = 54 <= 0 and var_468_21 or var_468_21 * (utf8.len(var_468_23) / 54)

				if (54 <= 0 and var_468_21 or var_468_21 * (utf8.len(var_468_23) / 54)) > 0 and var_468_21 < var_468_25 then
					arg_465_1.talkMaxDuration = var_468_25
					var_468_20 = var_468_20 + 0.3

					if var_468_25 + var_468_20 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_25 + var_468_20
					end
				end

				arg_465_1.text_.text = var_468_23
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_26 = var_468_20 + 0.3
			local var_468_27 = math.max(var_468_21, arg_465_1.talkMaxDuration)

			if var_468_20 + 0.3 <= arg_465_1.time_ and arg_465_1.time_ < var_468_26 + var_468_27 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_26) / var_468_27

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_26 + var_468_27 and arg_465_1.time_ < var_468_26 + var_468_27 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
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

		arg_465_1:InitPlayNodeList()
	end,
	Play424061110 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 424061110
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play424061111(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0.034 < arg_471_1.time_ and arg_471_1.time_ <= 0.034 + arg_474_0 then
				arg_471_1:AudioAction("play", "effect", "se_story_128", "se_story_128_bullet", "")
			end

			local var_474_1 = 0
			local var_474_2 = 1.625

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(424061110).content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 65 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 65)

				if (65 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 65)) > 0 and var_474_2 < var_474_5 then
					arg_471_1.talkMaxDuration = var_474_5

					if var_474_5 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_6 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_6 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_6

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_6 and arg_471_1.time_ < var_474_1 + var_474_6 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play424061111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 424061111
		arg_475_1.duration_ = 2.73

		local var_475_0 = {
			zh = 1.966,
			ja = 2.733
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play424061112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1094"]) and arg_475_1.var_.actorSpriteComps1094 == nil then
				arg_475_1.var_.actorSpriteComps1094 = arg_475_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_0 = 0.2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1094"]) then
				if arg_475_1.var_.actorSpriteComps1094 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								iter_478_1.color = Color.New(Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, (arg_475_1.time_ - 0) / var_478_0), Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, (arg_475_1.time_ - 0) / var_478_0), (Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, (arg_475_1.time_ - 0) / var_478_0)))
							else
								local var_478_1 = Mathf.Lerp(iter_478_1.color.r, 1, (arg_475_1.time_ - 0) / var_478_0)

								iter_478_1.color = Color.New(var_478_1, var_478_1, var_478_1)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1094"]) and arg_475_1.var_.actorSpriteComps1094 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_478_3 then
						iter_478_3.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps1094 = nil
			end

			local var_478_2 = arg_475_1.actors_["1094"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1094 = var_478_2.localPosition
				var_478_2.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("1094", 3)

				for iter_478_4 = 0, var_478_2.childCount - 1 do
					local var_478_3 = var_478_2:GetChild(iter_478_4)

					if var_478_3.name == "split_3" or not string.find(var_478_3.name, "split") then
						var_478_3.gameObject:SetActive(true)
					else
						var_478_3.gameObject:SetActive(false)
					end
				end
			end

			local var_478_4 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				var_478_2.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_475_1.time_ - 0) / var_478_4)
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				var_478_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_478_5 = "1194"

			if arg_475_1.actors_["1194"] == nil then
				local var_478_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1194")

				if not isNil(var_478_6) then
					local var_478_7 = Object.Instantiate(var_478_6, arg_475_1.canvasGo_.transform)

					var_478_7.transform:SetSiblingIndex(1)

					var_478_7.name = var_478_5
					var_478_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_475_1.actors_[var_478_5] = var_478_7

					if arg_475_1.isInRecall_ then
						for iter_478_5, iter_478_6 in ipairs((var_478_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_478_6.color = arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				local var_478_8 = arg_475_1.actors_["1194"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_478_8 then
					arg_475_1.var_.alphaOldValue1194 = var_478_8.alpha
					arg_475_1.var_.characterEffect1194 = var_478_8
				end

				arg_475_1.var_.alphaOldValue1194 = 0
			end

			local var_478_9 = 0.5

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_9 then
				if arg_475_1.var_.characterEffect1194 then
					arg_475_1.var_.characterEffect1194.alpha = Mathf.Lerp(arg_475_1.var_.alphaOldValue1194, 1, (arg_475_1.time_ - 0) / var_478_9)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_9 and arg_475_1.time_ < 0 + var_478_9 + arg_478_0 and arg_475_1.var_.characterEffect1194 then
				arg_475_1.var_.characterEffect1194.alpha = 1
			end

			local var_478_10 = 0
			local var_478_11 = 0.2

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_10 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_12 = arg_475_1:GetWordFromCfg(424061111)
				local var_478_13 = arg_475_1:FormatText(var_478_12.content)

				arg_475_1.text_.text = var_478_13

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_15 = 8 <= 0 and var_478_11 or var_478_11 * (utf8.len(var_478_13) / 8)

				if (8 <= 0 and var_478_11 or var_478_11 * (utf8.len(var_478_13) / 8)) > 0 and var_478_11 < var_478_15 then
					arg_475_1.talkMaxDuration = var_478_15

					if var_478_15 + var_478_10 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_15 + var_478_10
					end
				end

				arg_475_1.text_.text = var_478_13
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061111", "story_v_out_424061.awb") ~= 0 then
					local var_478_16 = manager.audio:GetVoiceLength("story_v_out_424061", "424061111", "story_v_out_424061.awb") / 1000

					if var_478_16 + var_478_10 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_16 + var_478_10
					end

					if var_478_12.prefab_name ~= "" and arg_475_1.actors_[var_478_12.prefab_name] ~= nil then
						local var_478_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_12.prefab_name].transform, "story_v_out_424061", "424061111", "story_v_out_424061.awb")

						arg_475_1:RecordAudio("424061111", var_478_17)
						arg_475_1:RecordAudio("424061111", var_478_17)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_424061", "424061111", "story_v_out_424061.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_424061", "424061111", "story_v_out_424061.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_18 = math.max(var_478_11, arg_475_1.talkMaxDuration)

			if var_478_10 <= arg_475_1.time_ and arg_475_1.time_ < var_478_10 + var_478_18 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_10) / var_478_18

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_10 + var_478_18 and arg_475_1.time_ < var_478_10 + var_478_18 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
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

		arg_475_1:InitPlayNodeList()
	end,
	Play424061112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 424061112
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play424061113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_9002
			local var_482_9001
			local var_482_9000

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1094"]) and arg_479_1.var_.actorSpriteComps1094 == nil then
				arg_479_1.var_.actorSpriteComps1094 = arg_479_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_0 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1094"]) then
				if arg_479_1.var_.actorSpriteComps1094 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								iter_482_1.color = Color.New(Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor2.r, (arg_479_1.time_ - 0) / var_482_0), Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor2.g, (arg_479_1.time_ - 0) / var_482_0), (Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor2.b, (arg_479_1.time_ - 0) / var_482_0)))
							else
								local var_482_1 = Mathf.Lerp(iter_482_1.color.r, 0.5, (arg_479_1.time_ - 0) / var_482_0)

								iter_482_1.color = Color.New(var_482_1, var_482_1, var_482_1)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1094"]) and arg_479_1.var_.actorSpriteComps1094 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_482_3 then
						iter_482_3.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_479_1.var_.actorSpriteComps1094 = nil
			end

			local var_482_2 = arg_479_1.actors_["1094"].transform

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1094 = var_482_2.localPosition
				var_482_2.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("1094", 7)

				for iter_482_4 = 0, var_482_2.childCount - 1 do
					local var_482_3 = var_482_2:GetChild(iter_482_4)

					if var_482_3.name == "" or not string.find(var_482_3.name, "split") then
						var_482_3.gameObject:SetActive(true)
					else
						var_482_3.gameObject:SetActive(false)
					end
				end
			end

			local var_482_4 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 then
				var_482_2.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_479_1.time_ - 0) / var_482_4)
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 then
				var_482_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				local var_482_5 = arg_479_1.var_.effectzisehuoyan1

				if not arg_479_1.var_.effectzisehuoyan1 then
					var_482_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_482_5.name = "zisehuoyan1"
					arg_479_1.var_.effectzisehuoyan1 = var_482_5
				else
					var_482_5.transform:SetParent(var_482_9002)
				end

				var_482_5.transform.localPosition = Vector3.New(-0.56, -0.48, -0.8)
				var_482_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_479_1.time_ and arg_479_1.time_ <= 0.2 + arg_482_0 then
				local var_482_7 = arg_479_1.var_.effectzisehuoyan2

				if not arg_479_1.var_.effectzisehuoyan2 then
					var_482_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_482_7.name = "zisehuoyan2"
					arg_479_1.var_.effectzisehuoyan2 = var_482_7
				else
					var_482_7.transform:SetParent(var_482_9001)
				end

				var_482_7.transform.localPosition = Vector3.New(0.37, 1.21, -1)
				var_482_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.5 < arg_479_1.time_ and arg_479_1.time_ <= 0.5 + arg_482_0 then
				local var_482_9 = arg_479_1.var_.effectzisehuoyan3

				if not arg_479_1.var_.effectzisehuoyan3 then
					var_482_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_482_9.name = "zisehuoyan3"
					arg_479_1.var_.effectzisehuoyan3 = var_482_9
				else
					var_482_9.transform:SetParent(var_482_9000)
				end

				var_482_9.transform.localPosition = Vector3.New(1.09, 1, -1.5)
				var_482_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_482_11 = manager.ui.mainCamera.transform

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.shakeOldPos = var_482_11.localPosition
			end

			local var_482_12 = 1

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_12 then
				local var_482_13, var_482_14 = math.modf((arg_479_1.time_ - 0) / 0.066)

				var_482_11.localPosition = Vector3.New(var_482_14 * 0.13, var_482_14 * 0.13, var_482_14 * 0.13) + arg_479_1.var_.shakeOldPos
			end

			if arg_479_1.time_ >= 0 + var_482_12 and arg_479_1.time_ < 0 + var_482_12 + arg_482_0 then
				var_482_11.localPosition = arg_479_1.var_.shakeOldPos
			end

			local var_482_15 = 0

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_15 + arg_482_0 then
				arg_479_1.allBtn_.enabled = false
			end

			if arg_479_1.time_ >= var_482_15 + 1.46666666666667 and arg_479_1.time_ < var_482_15 + 1.46666666666667 + arg_482_0 then
				arg_479_1.allBtn_.enabled = true
			end

			if 2.66666666666667 < arg_479_1.time_ and arg_479_1.time_ <= 2.66666666666667 + arg_482_0 then
				if arg_479_1.var_.effectzisehuoyan2 then
					Object.Destroy(arg_479_1.var_.effectzisehuoyan2)

					arg_479_1.var_.effectzisehuoyan2 = nil
				end
			end

			if 2.66666666666667 < arg_479_1.time_ and arg_479_1.time_ <= 2.66666666666667 + arg_482_0 then
				if arg_479_1.var_.effectzisehuoyan3 then
					Object.Destroy(arg_479_1.var_.effectzisehuoyan3)

					arg_479_1.var_.effectzisehuoyan3 = nil
				end
			end

			if 2.66666666666667 < arg_479_1.time_ and arg_479_1.time_ <= 2.66666666666667 + arg_482_0 then
				if arg_479_1.var_.effectzisehuoyan1 then
					Object.Destroy(arg_479_1.var_.effectzisehuoyan1)

					arg_479_1.var_.effectzisehuoyan1 = nil
				end
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle02", "")
			end

			local var_482_20 = 0
			local var_482_21 = 0.75

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_20 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0

				arg_479_1.dialog_:SetActive(true)

				arg_479_1.dialogCg_.alpha = 0

				local var_482_22 = LeanTween.value(arg_479_1.dialog_, 0, 1, 0.3)

				var_482_22:setOnUpdate(LuaHelper.FloatAction(function(arg_483_0)
					arg_479_1.dialogCg_.alpha = arg_483_0
				end))
				var_482_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_479_1.dialog_)
					var_482_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_479_1.duration_ = arg_479_1.duration_ + 0.3

				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_23 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(424061112).content)

				arg_479_1.text_.text = var_482_23

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_25 = 30 <= 0 and var_482_21 or var_482_21 * (utf8.len(var_482_23) / 30)

				if (30 <= 0 and var_482_21 or var_482_21 * (utf8.len(var_482_23) / 30)) > 0 and var_482_21 < var_482_25 then
					arg_479_1.talkMaxDuration = var_482_25
					var_482_20 = var_482_20 + 0.3

					if var_482_25 + var_482_20 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_25 + var_482_20
					end
				end

				arg_479_1.text_.text = var_482_23
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_26 = var_482_20 + 0.3
			local var_482_27 = math.max(var_482_21, arg_479_1.talkMaxDuration)

			if var_482_20 + 0.3 <= arg_479_1.time_ and arg_479_1.time_ < var_482_26 + var_482_27 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_26) / var_482_27

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_26 + var_482_27 and arg_479_1.time_ < var_482_26 + var_482_27 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
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

		arg_479_1:InitPlayNodeList()
	end,
	Play424061113 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 424061113
		arg_485_1.duration_ = 1

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play424061114(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.075

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:GetWordFromCfg(424061113)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 3 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 3)

				if (3 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 3)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061113", "story_v_out_424061.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061113", "story_v_out_424061.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_out_424061", "424061113", "story_v_out_424061.awb")

						arg_485_1:RecordAudio("424061113", var_488_6)
						arg_485_1:RecordAudio("424061113", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_424061", "424061113", "story_v_out_424061.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_424061", "424061113", "story_v_out_424061.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play424061114 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 424061114
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play424061115(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle", "")
			end

			local var_492_1 = 0
			local var_492_2 = 1.3

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(424061114).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 52 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 52)

				if (52 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 52)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play424061115 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 424061115
		arg_493_1.duration_ = 1.57

		local var_493_0 = {
			zh = 1.333,
			ja = 1.566
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play424061116(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.1

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:GetWordFromCfg(424061115)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 4 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 4)

				if (4 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 4)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061115", "story_v_out_424061.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061115", "story_v_out_424061.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_out_424061", "424061115", "story_v_out_424061.awb")

						arg_493_1:RecordAudio("424061115", var_496_6)
						arg_493_1:RecordAudio("424061115", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_424061", "424061115", "story_v_out_424061.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_424061", "424061115", "story_v_out_424061.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play424061116 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 424061116
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play424061117(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:AudioAction("play", "effect", "se_story_7", "se_story_7_monster", "")
			end

			local var_500_1 = 0
			local var_500_2 = 0.175

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[57].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(424061116).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 7 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 7)

				if (7 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 7)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play424061117 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 424061117
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play424061118(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				local var_504_0 = arg_501_1.var_.effectheipaojiejin1

				if not arg_501_1.var_.effectheipaojiejin1 then
					var_504_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_504_0.name = "heipaojiejin1"
					arg_501_1.var_.effectheipaojiejin1 = var_504_0
				else
					var_504_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_504_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_504_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_504_2 = arg_501_1.bgs_.ST0116c.transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPosST0116c = var_504_2.localPosition
			end

			local var_504_3 = 0.6

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_3 then
				var_504_2.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPosST0116c, Vector3.New(0, 1, 9.5), (arg_501_1.time_ - 0) / var_504_3)
			end

			if arg_501_1.time_ >= 0 + var_504_3 and arg_501_1.time_ < 0 + var_504_3 + arg_504_0 then
				var_504_2.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_504_4 = 0
			local var_504_5 = 1.4

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_6 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(424061117).content)

				arg_501_1.text_.text = var_504_6

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_8 = 56 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_6) / 56)

				if (56 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_6) / 56)) > 0 and var_504_5 < var_504_8 then
					arg_501_1.talkMaxDuration = var_504_8

					if var_504_8 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_4
					end
				end

				arg_501_1.text_.text = var_504_6
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_9 = math.max(var_504_5, arg_501_1.talkMaxDuration)

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_9 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_4) / var_504_9

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_4 + var_504_9 and arg_501_1.time_ < var_504_4 + var_504_9 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0116c",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play424061118 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 424061118
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play424061119(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.4

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(424061118).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 16 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 16)

				if (16 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 16)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play424061119 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 424061119
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play424061120(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0.034 < arg_509_1.time_ and arg_509_1.time_ <= 0.034 + arg_512_0 then
				arg_509_1:AudioAction("play", "effect", "se_story_6", "se_story_6_sweep_leaves", "")
			end

			local var_512_1 = 0
			local var_512_2 = 1.425

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(424061119).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 57 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 57)

				if (57 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 57)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play424061120 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 424061120
		arg_513_1.duration_ = 1.6

		local var_513_0 = {
			zh = 0.999999999999,
			ja = 1.6
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play424061121(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.1

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:GetWordFromCfg(424061120)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 4 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 4)

				if (4 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 4)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061120", "story_v_out_424061.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061120", "story_v_out_424061.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_out_424061", "424061120", "story_v_out_424061.awb")

						arg_513_1:RecordAudio("424061120", var_516_6)
						arg_513_1:RecordAudio("424061120", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_424061", "424061120", "story_v_out_424061.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_424061", "424061120", "story_v_out_424061.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play424061121 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 424061121
		arg_517_1.duration_ = 6.8

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play424061122(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_0 = 1

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 then
				local var_520_1 = Color.New(1, 1, 1)

				var_520_1.a = Mathf.Lerp(0, 1, (arg_517_1.time_ - 0) / var_520_0)
				arg_517_1.mask_.color = var_520_1
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 then
				local var_520_2 = Color.New(1, 1, 1)

				var_520_2.a = 1
				arg_517_1.mask_.color = var_520_2
			end

			local var_520_3 = 1

			if 1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_3 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_4 = 1

			if var_520_3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_3 + var_520_4 then
				local var_520_5 = Color.New(1, 1, 1)

				var_520_5.a = Mathf.Lerp(1, 0, (arg_517_1.time_ - var_520_3) / var_520_4)
				arg_517_1.mask_.color = var_520_5
			end

			if arg_517_1.time_ >= var_520_3 + var_520_4 and arg_517_1.time_ < var_520_3 + var_520_4 + arg_520_0 then
				local var_520_6 = Color.New(1, 1, 1)

				arg_517_1.mask_.enabled = false
				var_520_6.a = 0
				arg_517_1.mask_.color = var_520_6
			end

			if 0.947435903130099 < arg_517_1.time_ and arg_517_1.time_ <= 0.947435903130099 + arg_520_0 then
				arg_517_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			if 1 < arg_517_1.time_ and arg_517_1.time_ <= 1 + arg_520_0 then
				if arg_517_1.var_.effectheipaojiejin1 then
					Object.Destroy(arg_517_1.var_.effectheipaojiejin1)

					arg_517_1.var_.effectheipaojiejin1 = nil
				end
			end

			if arg_517_1.frameCnt_ <= 1 then
				arg_517_1.dialog_:SetActive(false)
			end

			local var_520_9 = 1.8
			local var_520_10 = 1.3

			if 1.8 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				arg_517_1.dialog_:SetActive(true)

				arg_517_1.dialogCg_.alpha = 0

				local var_520_11 = LeanTween.value(arg_517_1.dialog_, 0, 1, 0.3)

				var_520_11:setOnUpdate(LuaHelper.FloatAction(function(arg_521_0)
					arg_517_1.dialogCg_.alpha = arg_521_0
				end))
				var_520_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_517_1.dialog_)
					var_520_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_517_1.duration_ = arg_517_1.duration_ + 0.3

				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_12 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(424061121).content)

				arg_517_1.text_.text = var_520_12

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_14 = 52 <= 0 and var_520_10 or var_520_10 * (utf8.len(var_520_12) / 52)

				if (52 <= 0 and var_520_10 or var_520_10 * (utf8.len(var_520_12) / 52)) > 0 and var_520_10 < var_520_14 then
					arg_517_1.talkMaxDuration = var_520_14
					var_520_9 = var_520_9 + 0.3

					if var_520_14 + var_520_9 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_14 + var_520_9
					end
				end

				arg_517_1.text_.text = var_520_12
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_15 = var_520_9 + 0.3
			local var_520_16 = math.max(var_520_10, arg_517_1.talkMaxDuration)

			if var_520_9 + 0.3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_15 + var_520_16 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_15) / var_520_16

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_15 + var_520_16 and arg_517_1.time_ < var_520_15 + var_520_16 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play424061122 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 424061122
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play424061123(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 1.2

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(424061122).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 48 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 48)

				if (48 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 48)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play424061123 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 424061123
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play424061124(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_9002
			local var_530_9001
			local var_530_9000

			if 0.034 < arg_527_1.time_ and arg_527_1.time_ <= 0.034 + arg_530_0 then
				arg_527_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun05", "")
			end

			if 0.034 < arg_527_1.time_ and arg_527_1.time_ <= 0.034 + arg_530_0 then
				local var_530_1 = arg_527_1.var_.effectsanfazidan1

				if not arg_527_1.var_.effectsanfazidan1 then
					var_530_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_530_1.name = "sanfazidan1"
					arg_527_1.var_.effectsanfazidan1 = var_530_1
				else
					var_530_1.transform:SetParent(var_530_9002)
				end

				var_530_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_530_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.034 < arg_527_1.time_ and arg_527_1.time_ <= 2.034 + arg_530_0 then
				if arg_527_1.var_.effectsanfazidan1 then
					Object.Destroy(arg_527_1.var_.effectsanfazidan1)

					arg_527_1.var_.effectsanfazidan1 = nil
				end
			end

			if 0.166666666666667 < arg_527_1.time_ and arg_527_1.time_ <= 0.166666666666667 + arg_530_0 then
				local var_530_4 = arg_527_1.var_.effectsanfazidan2

				if not arg_527_1.var_.effectsanfazidan2 then
					var_530_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_530_4.name = "sanfazidan2"
					arg_527_1.var_.effectsanfazidan2 = var_530_4
				else
					var_530_4.transform:SetParent(var_530_9001)
				end

				var_530_4.transform.localPosition = Vector3.New(-0.5, -1, 0)
				var_530_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.16666666666667 < arg_527_1.time_ and arg_527_1.time_ <= 2.16666666666667 + arg_530_0 then
				if arg_527_1.var_.effectsanfazidan2 then
					Object.Destroy(arg_527_1.var_.effectsanfazidan2)

					arg_527_1.var_.effectsanfazidan2 = nil
				end
			end

			if 0.366666666666667 < arg_527_1.time_ and arg_527_1.time_ <= 0.366666666666667 + arg_530_0 then
				local var_530_7 = arg_527_1.var_.effectsanfazidan3

				if not arg_527_1.var_.effectsanfazidan3 then
					var_530_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_530_7.name = "sanfazidan3"
					arg_527_1.var_.effectsanfazidan3 = var_530_7
				else
					var_530_7.transform:SetParent(var_530_9000)
				end

				var_530_7.transform.localPosition = Vector3.New(2, 0.5, 0)
				var_530_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.36666666666667 < arg_527_1.time_ and arg_527_1.time_ <= 2.36666666666667 + arg_530_0 then
				if arg_527_1.var_.effectsanfazidan3 then
					Object.Destroy(arg_527_1.var_.effectsanfazidan3)

					arg_527_1.var_.effectsanfazidan3 = nil
				end
			end

			local var_530_10 = 0
			local var_530_11 = 0.85

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_10 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_12 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(424061123).content)

				arg_527_1.text_.text = var_530_12

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_14 = 34 <= 0 and var_530_11 or var_530_11 * (utf8.len(var_530_12) / 34)

				if (34 <= 0 and var_530_11 or var_530_11 * (utf8.len(var_530_12) / 34)) > 0 and var_530_11 < var_530_14 then
					arg_527_1.talkMaxDuration = var_530_14

					if var_530_14 + var_530_10 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_10
					end
				end

				arg_527_1.text_.text = var_530_12
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_15 = math.max(var_530_11, arg_527_1.talkMaxDuration)

			if var_530_10 <= arg_527_1.time_ and arg_527_1.time_ < var_530_10 + var_530_15 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_10) / var_530_15

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_10 + var_530_15 and arg_527_1.time_ < var_530_10 + var_530_15 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play424061124 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 424061124
		arg_531_1.duration_ = 1.23

		local var_531_0 = {
			zh = 1.233,
			ja = 1.166
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play424061125(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1094"]) and arg_531_1.var_.actorSpriteComps1094 == nil then
				arg_531_1.var_.actorSpriteComps1094 = arg_531_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_0 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1094"]) then
				if arg_531_1.var_.actorSpriteComps1094 then
					for iter_534_0, iter_534_1 in pairs(arg_531_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_534_1 then
							if arg_531_1.isInRecall_ then
								iter_534_1.color = Color.New(Mathf.Lerp(iter_534_1.color.r, arg_531_1.hightColor1.r, (arg_531_1.time_ - 0) / var_534_0), Mathf.Lerp(iter_534_1.color.g, arg_531_1.hightColor1.g, (arg_531_1.time_ - 0) / var_534_0), (Mathf.Lerp(iter_534_1.color.b, arg_531_1.hightColor1.b, (arg_531_1.time_ - 0) / var_534_0)))
							else
								local var_534_1 = Mathf.Lerp(iter_534_1.color.r, 1, (arg_531_1.time_ - 0) / var_534_0)

								iter_534_1.color = Color.New(var_534_1, var_534_1, var_534_1)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1094"]) and arg_531_1.var_.actorSpriteComps1094 then
				for iter_534_2, iter_534_3 in pairs(arg_531_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_534_3 then
						iter_534_3.color = arg_531_1.isInRecall_ and (arg_531_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_531_1.var_.actorSpriteComps1094 = nil
			end

			local var_534_2 = arg_531_1.actors_["1094"].transform

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1094 = var_534_2.localPosition
				var_534_2.localScale = Vector3.New(1, 1, 1)

				arg_531_1:CheckSpriteTmpPos("1094", 3)

				for iter_534_4 = 0, var_534_2.childCount - 1 do
					local var_534_3 = var_534_2:GetChild(iter_534_4)

					if var_534_3.name == "split_3" or not string.find(var_534_3.name, "split") then
						var_534_3.gameObject:SetActive(true)
					else
						var_534_3.gameObject:SetActive(false)
					end
				end
			end

			local var_534_4 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				var_534_2.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_531_1.time_ - 0) / var_534_4)
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				var_534_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_534_5 = 0
			local var_534_6 = 0.1

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_5 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_7 = arg_531_1:GetWordFromCfg(424061124)
				local var_534_8 = arg_531_1:FormatText(var_534_7.content)

				arg_531_1.text_.text = var_534_8

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_10 = 4 <= 0 and var_534_6 or var_534_6 * (utf8.len(var_534_8) / 4)

				if (4 <= 0 and var_534_6 or var_534_6 * (utf8.len(var_534_8) / 4)) > 0 and var_534_6 < var_534_10 then
					arg_531_1.talkMaxDuration = var_534_10

					if var_534_10 + var_534_5 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_10 + var_534_5
					end
				end

				arg_531_1.text_.text = var_534_8
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061124", "story_v_out_424061.awb") ~= 0 then
					local var_534_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061124", "story_v_out_424061.awb") / 1000

					if var_534_11 + var_534_5 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_11 + var_534_5
					end

					if var_534_7.prefab_name ~= "" and arg_531_1.actors_[var_534_7.prefab_name] ~= nil then
						local var_534_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_7.prefab_name].transform, "story_v_out_424061", "424061124", "story_v_out_424061.awb")

						arg_531_1:RecordAudio("424061124", var_534_12)
						arg_531_1:RecordAudio("424061124", var_534_12)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_424061", "424061124", "story_v_out_424061.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_424061", "424061124", "story_v_out_424061.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_13 = math.max(var_534_6, arg_531_1.talkMaxDuration)

			if var_534_5 <= arg_531_1.time_ and arg_531_1.time_ < var_534_5 + var_534_13 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_5) / var_534_13

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_5 + var_534_13 and arg_531_1.time_ < var_534_5 + var_534_13 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
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

		arg_531_1:InitPlayNodeList()
	end,
	Play424061125 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 424061125
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play424061126(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1094"]) and arg_535_1.var_.actorSpriteComps1094 == nil then
				arg_535_1.var_.actorSpriteComps1094 = arg_535_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_538_0 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1094"]) then
				if arg_535_1.var_.actorSpriteComps1094 then
					for iter_538_0, iter_538_1 in pairs(arg_535_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_538_1 then
							if arg_535_1.isInRecall_ then
								iter_538_1.color = Color.New(Mathf.Lerp(iter_538_1.color.r, arg_535_1.hightColor2.r, (arg_535_1.time_ - 0) / var_538_0), Mathf.Lerp(iter_538_1.color.g, arg_535_1.hightColor2.g, (arg_535_1.time_ - 0) / var_538_0), (Mathf.Lerp(iter_538_1.color.b, arg_535_1.hightColor2.b, (arg_535_1.time_ - 0) / var_538_0)))
							else
								local var_538_1 = Mathf.Lerp(iter_538_1.color.r, 0.5, (arg_535_1.time_ - 0) / var_538_0)

								iter_538_1.color = Color.New(var_538_1, var_538_1, var_538_1)
							end
						end
					end
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1094"]) and arg_535_1.var_.actorSpriteComps1094 then
				for iter_538_2, iter_538_3 in pairs(arg_535_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_538_3 then
						iter_538_3.color = arg_535_1.isInRecall_ and (arg_535_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_535_1.var_.actorSpriteComps1094 = nil
			end

			local var_538_2 = arg_535_1.actors_["1094"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1094 = var_538_2.localPosition
				var_538_2.localScale = Vector3.New(1, 1, 1)

				arg_535_1:CheckSpriteTmpPos("1094", 7)

				for iter_538_4 = 0, var_538_2.childCount - 1 do
					local var_538_3 = var_538_2:GetChild(iter_538_4)

					if var_538_3.name == "" or not string.find(var_538_3.name, "split") then
						var_538_3.gameObject:SetActive(true)
					else
						var_538_3.gameObject:SetActive(false)
					end
				end
			end

			local var_538_4 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				var_538_2.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_535_1.time_ - 0) / var_538_4)
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				var_538_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.566666666666667 < arg_535_1.time_ and arg_535_1.time_ <= 0.566666666666667 + arg_538_0 then
				arg_535_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion03", "")
			end

			local var_538_6 = 0
			local var_538_7 = 1.4

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_6 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_8 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(424061125).content)

				arg_535_1.text_.text = var_538_8

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_10 = 56 <= 0 and var_538_7 or var_538_7 * (utf8.len(var_538_8) / 56)

				if (56 <= 0 and var_538_7 or var_538_7 * (utf8.len(var_538_8) / 56)) > 0 and var_538_7 < var_538_10 then
					arg_535_1.talkMaxDuration = var_538_10

					if var_538_10 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_10 + var_538_6
					end
				end

				arg_535_1.text_.text = var_538_8
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_11 = math.max(var_538_7, arg_535_1.talkMaxDuration)

			if var_538_6 <= arg_535_1.time_ and arg_535_1.time_ < var_538_6 + var_538_11 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_6) / var_538_11

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_6 + var_538_11 and arg_535_1.time_ < var_538_6 + var_538_11 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
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

		arg_535_1:InitPlayNodeList()
	end,
	Play424061126 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 424061126
		arg_539_1.duration_ = 7

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play424061127(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_9000

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				local var_542_0 = arg_539_1.var_.effectpaodandaji1

				if not arg_539_1.var_.effectpaodandaji1 then
					var_542_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_542_0.name = "paodandaji1"
					arg_539_1.var_.effectpaodandaji1 = var_542_0
				else
					var_542_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_542_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_542_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.633333333333333 < arg_539_1.time_ and arg_539_1.time_ <= 0.633333333333333 + arg_542_0 then
				local var_542_2 = arg_539_1.var_.effectpaodandaji2

				if not arg_539_1.var_.effectpaodandaji2 then
					var_542_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_542_2.name = "paodandaji2"
					arg_539_1.var_.effectpaodandaji2 = var_542_2
				else
					var_542_2.transform:SetParent(var_542_9000)
				end

				var_542_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_542_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_542_2.transform.localScale = Vector3.New(var_542_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_542_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_542_2.transform.localScale.z)
			end

			if 0.633333333333333 < arg_539_1.time_ and arg_539_1.time_ <= 0.633333333333333 + arg_542_0 then
				if arg_539_1.var_.effecthongsemiwu1 then
					Object.Destroy(arg_539_1.var_.effecthongsemiwu1)

					arg_539_1.var_.effecthongsemiwu1 = nil
				end
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion04", "")
			end

			if arg_539_1.frameCnt_ <= 1 then
				arg_539_1.dialog_:SetActive(false)
			end

			local var_542_6 = 2
			local var_542_7 = 1.55

			if 2 < arg_539_1.time_ and arg_539_1.time_ <= var_542_6 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0

				arg_539_1.dialog_:SetActive(true)

				arg_539_1.dialogCg_.alpha = 0

				local var_542_8 = LeanTween.value(arg_539_1.dialog_, 0, 1, 0.3)

				var_542_8:setOnUpdate(LuaHelper.FloatAction(function(arg_543_0)
					arg_539_1.dialogCg_.alpha = arg_543_0
				end))
				var_542_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_539_1.dialog_)
					var_542_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_539_1.duration_ = arg_539_1.duration_ + 0.3

				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_9 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(424061126).content)

				arg_539_1.text_.text = var_542_9

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_11 = 62 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 62)

				if (62 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 62)) > 0 and var_542_7 < var_542_11 then
					arg_539_1.talkMaxDuration = var_542_11
					var_542_6 = var_542_6 + 0.3

					if var_542_11 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_6
					end
				end

				arg_539_1.text_.text = var_542_9
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_12 = var_542_6 + 0.3
			local var_542_13 = math.max(var_542_7, arg_539_1.talkMaxDuration)

			if var_542_6 + 0.3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_12 + var_542_13 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_12) / var_542_13

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_12 + var_542_13 and arg_539_1.time_ < var_542_12 + var_542_13 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play424061127 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 424061127
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play424061128(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0.25

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_1 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(424061127).content)

				arg_545_1.text_.text = var_548_1

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_3 = 10 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 10)

				if (10 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 10)) > 0 and var_548_0 < var_548_3 then
					arg_545_1.talkMaxDuration = var_548_3

					if var_548_3 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_3 + 0
					end
				end

				arg_545_1.text_.text = var_548_1
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_4 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_4

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play424061128 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 424061128
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play424061129(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.85

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(424061128).content)

				arg_549_1.text_.text = var_552_1

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_3 = 34 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 34)

				if (34 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 34)) > 0 and var_552_0 < var_552_3 then
					arg_549_1.talkMaxDuration = var_552_3

					if var_552_3 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_3 + 0
					end
				end

				arg_549_1.text_.text = var_552_1
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_4 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_4

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play424061129 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 424061129
		arg_553_1.duration_ = 2.63

		local var_553_0 = {
			zh = 2.633,
			ja = 2.3
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play424061130(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1094"]) and arg_553_1.var_.actorSpriteComps1094 == nil then
				arg_553_1.var_.actorSpriteComps1094 = arg_553_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1094"]) then
				if arg_553_1.var_.actorSpriteComps1094 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								iter_556_1.color = Color.New(Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, (arg_553_1.time_ - 0) / var_556_0), Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, (arg_553_1.time_ - 0) / var_556_0), (Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, (arg_553_1.time_ - 0) / var_556_0)))
							else
								local var_556_1 = Mathf.Lerp(iter_556_1.color.r, 1, (arg_553_1.time_ - 0) / var_556_0)

								iter_556_1.color = Color.New(var_556_1, var_556_1, var_556_1)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1094"]) and arg_553_1.var_.actorSpriteComps1094 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_556_3 then
						iter_556_3.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_553_1.var_.actorSpriteComps1094 = nil
			end

			local var_556_2 = arg_553_1.actors_["1094"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1094 = var_556_2.localPosition
				var_556_2.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("1094", 3)

				for iter_556_4 = 0, var_556_2.childCount - 1 do
					local var_556_3 = var_556_2:GetChild(iter_556_4)

					if var_556_3.name == "split_3" or not string.find(var_556_3.name, "split") then
						var_556_3.gameObject:SetActive(true)
					else
						var_556_3.gameObject:SetActive(false)
					end
				end
			end

			local var_556_4 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				var_556_2.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_553_1.time_ - 0) / var_556_4)
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				var_556_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_556_5 = 0
			local var_556_6 = 0.225

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_7 = arg_553_1:GetWordFromCfg(424061129)
				local var_556_8 = arg_553_1:FormatText(var_556_7.content)

				arg_553_1.text_.text = var_556_8

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_10 = 9 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_8) / 9)

				if (9 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_8) / 9)) > 0 and var_556_6 < var_556_10 then
					arg_553_1.talkMaxDuration = var_556_10

					if var_556_10 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_5
					end
				end

				arg_553_1.text_.text = var_556_8
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061129", "story_v_out_424061.awb") ~= 0 then
					local var_556_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061129", "story_v_out_424061.awb") / 1000

					if var_556_11 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_11 + var_556_5
					end

					if var_556_7.prefab_name ~= "" and arg_553_1.actors_[var_556_7.prefab_name] ~= nil then
						local var_556_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_7.prefab_name].transform, "story_v_out_424061", "424061129", "story_v_out_424061.awb")

						arg_553_1:RecordAudio("424061129", var_556_12)
						arg_553_1:RecordAudio("424061129", var_556_12)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_424061", "424061129", "story_v_out_424061.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_424061", "424061129", "story_v_out_424061.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_13 = math.max(var_556_6, arg_553_1.talkMaxDuration)

			if var_556_5 <= arg_553_1.time_ and arg_553_1.time_ < var_556_5 + var_556_13 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_5) / var_556_13

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_5 + var_556_13 and arg_553_1.time_ < var_556_5 + var_556_13 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
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

		arg_553_1:InitPlayNodeList()
	end,
	Play424061130 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 424061130
		arg_557_1.duration_ = 7

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play424061131(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0.8 < arg_557_1.time_ and arg_557_1.time_ <= 0.8 + arg_560_0 and not isNil(arg_557_1.actors_["1094"]) and arg_557_1.var_.actorSpriteComps1094 == nil then
				arg_557_1.var_.actorSpriteComps1094 = arg_557_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_0 = 0.2

			if 0.8 <= arg_557_1.time_ and arg_557_1.time_ < 0.8 + var_560_0 and not isNil(arg_557_1.actors_["1094"]) then
				if arg_557_1.var_.actorSpriteComps1094 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								iter_560_1.color = Color.New(Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, (arg_557_1.time_ - 0.8) / var_560_0), Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, (arg_557_1.time_ - 0.8) / var_560_0), (Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, (arg_557_1.time_ - 0.8) / var_560_0)))
							else
								local var_560_1 = Mathf.Lerp(iter_560_1.color.r, 0.5, (arg_557_1.time_ - 0.8) / var_560_0)

								iter_560_1.color = Color.New(var_560_1, var_560_1, var_560_1)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0.8 + var_560_0 and arg_557_1.time_ < 0.8 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1094"]) and arg_557_1.var_.actorSpriteComps1094 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_560_3 then
						iter_560_3.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_557_1.var_.actorSpriteComps1094 = nil
			end

			local var_560_2 = 0

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_2 + arg_560_0 then
				arg_557_1.mask_.enabled = true
				arg_557_1.mask_.raycastTarget = true

				arg_557_1:SetGaussion(false)
			end

			local var_560_3 = 1

			if var_560_2 <= arg_557_1.time_ and arg_557_1.time_ < var_560_2 + var_560_3 then
				local var_560_4 = Color.New(0, 0, 0)

				var_560_4.a = Mathf.Lerp(0, 1, (arg_557_1.time_ - var_560_2) / var_560_3)
				arg_557_1.mask_.color = var_560_4
			end

			if arg_557_1.time_ >= var_560_2 + var_560_3 and arg_557_1.time_ < var_560_2 + var_560_3 + arg_560_0 then
				local var_560_5 = Color.New(0, 0, 0)

				var_560_5.a = 1
				arg_557_1.mask_.color = var_560_5
			end

			local var_560_6 = 1

			if 1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_6 + arg_560_0 then
				arg_557_1.mask_.enabled = true
				arg_557_1.mask_.raycastTarget = true

				arg_557_1:SetGaussion(false)
			end

			local var_560_7 = 1

			if var_560_6 <= arg_557_1.time_ and arg_557_1.time_ < var_560_6 + var_560_7 then
				local var_560_8 = Color.New(0, 0, 0)

				var_560_8.a = Mathf.Lerp(1, 0, (arg_557_1.time_ - var_560_6) / var_560_7)
				arg_557_1.mask_.color = var_560_8
			end

			if arg_557_1.time_ >= var_560_6 + var_560_7 and arg_557_1.time_ < var_560_6 + var_560_7 + arg_560_0 then
				local var_560_9 = Color.New(0, 0, 0)

				arg_557_1.mask_.enabled = false
				var_560_9.a = 0
				arg_557_1.mask_.color = var_560_9
			end

			local var_560_10 = arg_557_1.actors_["1094"].transform

			if 0.966 < arg_557_1.time_ and arg_557_1.time_ <= 0.966 + arg_560_0 then
				arg_557_1.var_.moveOldPos1094 = var_560_10.localPosition
				var_560_10.localScale = Vector3.New(1, 1, 1)

				arg_557_1:CheckSpriteTmpPos("1094", 7)

				for iter_560_4 = 0, var_560_10.childCount - 1 do
					local var_560_11 = var_560_10:GetChild(iter_560_4)

					if var_560_11.name == "split_3" or not string.find(var_560_11.name, "split") then
						var_560_11.gameObject:SetActive(true)
					else
						var_560_11.gameObject:SetActive(false)
					end
				end
			end

			local var_560_12 = 0.001

			if 0.966 <= arg_557_1.time_ and arg_557_1.time_ < 0.966 + var_560_12 then
				var_560_10.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_557_1.time_ - 0.966) / var_560_12)
			end

			if arg_557_1.time_ >= 0.966 + var_560_12 and arg_557_1.time_ < 0.966 + var_560_12 + arg_560_0 then
				var_560_10.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_557_1.time_ and arg_557_1.time_ <= 1 + arg_560_0 then
				if arg_557_1.var_.effectpaodandaji2 then
					Object.Destroy(arg_557_1.var_.effectpaodandaji2)

					arg_557_1.var_.effectpaodandaji2 = nil
				end
			end

			if arg_557_1.frameCnt_ <= 1 then
				arg_557_1.dialog_:SetActive(false)
			end

			local var_560_14 = 2
			local var_560_15 = 0.25

			if 2 < arg_557_1.time_ and arg_557_1.time_ <= var_560_14 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0

				arg_557_1.dialog_:SetActive(true)

				arg_557_1.dialogCg_.alpha = 0

				local var_560_16 = LeanTween.value(arg_557_1.dialog_, 0, 1, 0.3)

				var_560_16:setOnUpdate(LuaHelper.FloatAction(function(arg_561_0)
					arg_557_1.dialogCg_.alpha = arg_561_0
				end))
				var_560_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_557_1.dialog_)
					var_560_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_557_1.duration_ = arg_557_1.duration_ + 0.3

				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_17 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(424061130).content)

				arg_557_1.text_.text = var_560_17

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_19 = 10 <= 0 and var_560_15 or var_560_15 * (utf8.len(var_560_17) / 10)

				if (10 <= 0 and var_560_15 or var_560_15 * (utf8.len(var_560_17) / 10)) > 0 and var_560_15 < var_560_19 then
					arg_557_1.talkMaxDuration = var_560_19
					var_560_14 = var_560_14 + 0.3

					if var_560_19 + var_560_14 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_19 + var_560_14
					end
				end

				arg_557_1.text_.text = var_560_17
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_20 = var_560_14 + 0.3
			local var_560_21 = math.max(var_560_15, arg_557_1.talkMaxDuration)

			if var_560_14 + 0.3 <= arg_557_1.time_ and arg_557_1.time_ < var_560_20 + var_560_21 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_20) / var_560_21

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_20 + var_560_21 and arg_557_1.time_ < var_560_20 + var_560_21 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play424061131 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 424061131
		arg_563_1.duration_ = 5.2

		local var_563_0 = {
			zh = 3.866,
			ja = 5.2
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play424061132(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.var_.moveOldPos1094 = arg_563_1.actors_["1094"].transform.localPosition
				arg_563_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_563_1:CheckSpriteTmpPos("1094", 7)

				for iter_566_0 = 0, arg_563_1.actors_["1094"].transform.childCount - 1 do
					local var_566_0 = arg_563_1.actors_["1094"].transform:GetChild(iter_566_0)

					if var_566_0.name == "" or not string.find(var_566_0.name, "split") then
						var_566_0.gameObject:SetActive(true)
					else
						var_566_0.gameObject:SetActive(false)
					end
				end
			end

			local var_566_1 = 0.001

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_1 then
				arg_563_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_563_1.time_ - 0) / var_566_1)
			end

			if arg_563_1.time_ >= 0 + var_566_1 and arg_563_1.time_ < 0 + var_566_1 + arg_566_0 then
				arg_563_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_566_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_563_1.bgmTxt_.text ~= var_566_4 and arg_563_1.bgmTxt_.text ~= "" then
						if arg_563_1.bgmTxt2_.text ~= "" then
							arg_563_1.bgmTxt_.text = arg_563_1.bgmTxt2_.text
						end

						arg_563_1.bgmTxt2_.text = var_566_4

						arg_563_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_563_1.bgmTxt_.text = var_566_4
						arg_563_1.bgmTxt2_.text = var_566_4
					end

					if arg_563_1.bgmTimer then
						arg_563_1.bgmTimer:Stop()

						arg_563_1.bgmTimer = nil
					end

					if arg_563_1.settingData.show_music_name == 1 then
						arg_563_1.musicController:SetSelectedState("show")
						arg_563_1.musicAnimator_:Play("open", 0, 0)

						if arg_563_1.settingData.music_time ~= 0 then
							arg_563_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_563_1.settingData.music_time), function()
								if arg_563_1 == nil or isNil(arg_563_1.bgmTxt_) then
									return
								end

								arg_563_1.musicController:SetSelectedState("hide")
								arg_563_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_563_1.time_ and arg_563_1.time_ <= 0.3 + arg_566_0 then
				arg_563_1:AudioAction("play", "music", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense.awb")

				local var_566_7 = manager.audio:GetAudioName("bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense")

				if "" ~= "" then
					if arg_563_1.bgmTxt_.text ~= var_566_7 and arg_563_1.bgmTxt_.text ~= "" then
						if arg_563_1.bgmTxt2_.text ~= "" then
							arg_563_1.bgmTxt_.text = arg_563_1.bgmTxt2_.text
						end

						arg_563_1.bgmTxt2_.text = var_566_7

						arg_563_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_563_1.bgmTxt_.text = var_566_7
						arg_563_1.bgmTxt2_.text = var_566_7
					end

					if arg_563_1.bgmTimer then
						arg_563_1.bgmTimer:Stop()

						arg_563_1.bgmTimer = nil
					end

					if arg_563_1.settingData.show_music_name == 1 then
						arg_563_1.musicController:SetSelectedState("show")
						arg_563_1.musicAnimator_:Play("open", 0, 0)

						if arg_563_1.settingData.music_time ~= 0 then
							arg_563_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_563_1.settingData.music_time), function()
								if arg_563_1 == nil or isNil(arg_563_1.bgmTxt_) then
									return
								end

								arg_563_1.musicController:SetSelectedState("hide")
								arg_563_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_566_8 = 0
			local var_566_9 = 0.5

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_8 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_10 = arg_563_1:GetWordFromCfg(424061131)
				local var_566_11 = arg_563_1:FormatText(var_566_10.content)

				arg_563_1.text_.text = var_566_11

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_13 = 20 <= 0 and var_566_9 or var_566_9 * (utf8.len(var_566_11) / 20)

				if (20 <= 0 and var_566_9 or var_566_9 * (utf8.len(var_566_11) / 20)) > 0 and var_566_9 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_8 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_8
					end
				end

				arg_563_1.text_.text = var_566_11
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061131", "story_v_out_424061.awb") ~= 0 then
					local var_566_14 = manager.audio:GetVoiceLength("story_v_out_424061", "424061131", "story_v_out_424061.awb") / 1000

					if var_566_14 + var_566_8 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_14 + var_566_8
					end

					if var_566_10.prefab_name ~= "" and arg_563_1.actors_[var_566_10.prefab_name] ~= nil then
						local var_566_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_10.prefab_name].transform, "story_v_out_424061", "424061131", "story_v_out_424061.awb")

						arg_563_1:RecordAudio("424061131", var_566_15)
						arg_563_1:RecordAudio("424061131", var_566_15)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_424061", "424061131", "story_v_out_424061.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_424061", "424061131", "story_v_out_424061.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_16 = math.max(var_566_9, arg_563_1.talkMaxDuration)

			if var_566_8 <= arg_563_1.time_ and arg_563_1.time_ < var_566_8 + var_566_16 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_8) / var_566_16

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_8 + var_566_16 and arg_563_1.time_ < var_566_8 + var_566_16 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
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

		arg_563_1:InitPlayNodeList()
	end,
	Play424061132 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 424061132
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play424061133(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.475

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_1 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(424061132).content)

				arg_569_1.text_.text = var_572_1

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_3 = 19 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_1) / 19)

				if (19 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_1) / 19)) > 0 and var_572_0 < var_572_3 then
					arg_569_1.talkMaxDuration = var_572_3

					if var_572_3 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_3 + 0
					end
				end

				arg_569_1.text_.text = var_572_1
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_4 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_4 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_4

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_4 and arg_569_1.time_ < 0 + var_572_4 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play424061133 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 424061133
		arg_573_1.duration_ = 3.3

		local var_573_0 = {
			zh = 3.3,
			ja = 3.266
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play424061134(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1094"]) and arg_573_1.var_.actorSpriteComps1094 == nil then
				arg_573_1.var_.actorSpriteComps1094 = arg_573_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_576_0 = 0.2

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1094"]) then
				if arg_573_1.var_.actorSpriteComps1094 then
					for iter_576_0, iter_576_1 in pairs(arg_573_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_576_1 then
							if arg_573_1.isInRecall_ then
								iter_576_1.color = Color.New(Mathf.Lerp(iter_576_1.color.r, arg_573_1.hightColor1.r, (arg_573_1.time_ - 0) / var_576_0), Mathf.Lerp(iter_576_1.color.g, arg_573_1.hightColor1.g, (arg_573_1.time_ - 0) / var_576_0), (Mathf.Lerp(iter_576_1.color.b, arg_573_1.hightColor1.b, (arg_573_1.time_ - 0) / var_576_0)))
							else
								local var_576_1 = Mathf.Lerp(iter_576_1.color.r, 1, (arg_573_1.time_ - 0) / var_576_0)

								iter_576_1.color = Color.New(var_576_1, var_576_1, var_576_1)
							end
						end
					end
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1094"]) and arg_573_1.var_.actorSpriteComps1094 then
				for iter_576_2, iter_576_3 in pairs(arg_573_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_576_3 then
						iter_576_3.color = arg_573_1.isInRecall_ and (arg_573_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_573_1.var_.actorSpriteComps1094 = nil
			end

			local var_576_2 = arg_573_1.actors_["1094"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1094 = var_576_2.localPosition
				var_576_2.localScale = Vector3.New(1, 1, 1)

				arg_573_1:CheckSpriteTmpPos("1094", 3)

				for iter_576_4 = 0, var_576_2.childCount - 1 do
					local var_576_3 = var_576_2:GetChild(iter_576_4)

					if var_576_3.name == "split_1" or not string.find(var_576_3.name, "split") then
						var_576_3.gameObject:SetActive(true)
					else
						var_576_3.gameObject:SetActive(false)
					end
				end
			end

			local var_576_4 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_4 then
				var_576_2.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_573_1.time_ - 0) / var_576_4)
			end

			if arg_573_1.time_ >= 0 + var_576_4 and arg_573_1.time_ < 0 + var_576_4 + arg_576_0 then
				var_576_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_576_5 = 0
			local var_576_6 = 0.275

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_5 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_7 = arg_573_1:GetWordFromCfg(424061133)
				local var_576_8 = arg_573_1:FormatText(var_576_7.content)

				arg_573_1.text_.text = var_576_8

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_10 = 11 <= 0 and var_576_6 or var_576_6 * (utf8.len(var_576_8) / 11)

				if (11 <= 0 and var_576_6 or var_576_6 * (utf8.len(var_576_8) / 11)) > 0 and var_576_6 < var_576_10 then
					arg_573_1.talkMaxDuration = var_576_10

					if var_576_10 + var_576_5 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_10 + var_576_5
					end
				end

				arg_573_1.text_.text = var_576_8
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061133", "story_v_out_424061.awb") ~= 0 then
					local var_576_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061133", "story_v_out_424061.awb") / 1000

					if var_576_11 + var_576_5 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_11 + var_576_5
					end

					if var_576_7.prefab_name ~= "" and arg_573_1.actors_[var_576_7.prefab_name] ~= nil then
						local var_576_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_7.prefab_name].transform, "story_v_out_424061", "424061133", "story_v_out_424061.awb")

						arg_573_1:RecordAudio("424061133", var_576_12)
						arg_573_1:RecordAudio("424061133", var_576_12)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_424061", "424061133", "story_v_out_424061.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_424061", "424061133", "story_v_out_424061.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_13 = math.max(var_576_6, arg_573_1.talkMaxDuration)

			if var_576_5 <= arg_573_1.time_ and arg_573_1.time_ < var_576_5 + var_576_13 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_5) / var_576_13

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_5 + var_576_13 and arg_573_1.time_ < var_576_5 + var_576_13 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
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

		arg_573_1:InitPlayNodeList()
	end,
	Play424061134 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 424061134
		arg_577_1.duration_ = 1

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"

			SetActive(arg_577_1.choicesGo_, true)

			for iter_578_0, iter_578_1 in ipairs(arg_577_1.choices_) do
				SetActive(iter_578_1.go, iter_578_0 <= 2)
			end

			arg_577_1.choices_[1].txt.text = arg_577_1:FormatText(StoryChoiceCfg[1483].name)
			arg_577_1.choices_[2].txt.text = arg_577_1:FormatText(StoryChoiceCfg[1484].name)
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play424061135(arg_577_1)
			end

			if arg_579_0 == 2 then
				arg_577_0:Play424061137(arg_577_1)
			end

			arg_577_1:RecordChoiceLog(424061134, 1483, 1484)
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1094"]) and arg_577_1.var_.actorSpriteComps1094 == nil then
				arg_577_1.var_.actorSpriteComps1094 = arg_577_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_0 = 0.2

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1094"]) then
				if arg_577_1.var_.actorSpriteComps1094 then
					for iter_580_0, iter_580_1 in pairs(arg_577_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_580_1 then
							if arg_577_1.isInRecall_ then
								iter_580_1.color = Color.New(Mathf.Lerp(iter_580_1.color.r, arg_577_1.hightColor2.r, (arg_577_1.time_ - 0) / var_580_0), Mathf.Lerp(iter_580_1.color.g, arg_577_1.hightColor2.g, (arg_577_1.time_ - 0) / var_580_0), (Mathf.Lerp(iter_580_1.color.b, arg_577_1.hightColor2.b, (arg_577_1.time_ - 0) / var_580_0)))
							else
								local var_580_1 = Mathf.Lerp(iter_580_1.color.r, 0.5, (arg_577_1.time_ - 0) / var_580_0)

								iter_580_1.color = Color.New(var_580_1, var_580_1, var_580_1)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1094"]) and arg_577_1.var_.actorSpriteComps1094 then
				for iter_580_2, iter_580_3 in pairs(arg_577_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_580_3 then
						iter_580_3.color = arg_577_1.isInRecall_ and (arg_577_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_577_1.var_.actorSpriteComps1094 = nil
			end

			local var_580_2 = 0

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_2 + arg_580_0 then
				arg_577_1.allBtn_.enabled = false
			end

			if arg_577_1.time_ >= var_580_2 + 0.6 and arg_577_1.time_ < var_580_2 + 0.6 + arg_580_0 then
				arg_577_1.allBtn_.enabled = true
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play424061135 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 424061135
		arg_581_1.duration_ = 1.27

		local var_581_0 = {
			zh = 1.266,
			ja = 1.233
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play424061136(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["1094"]) and arg_581_1.var_.actorSpriteComps1094 == nil then
				arg_581_1.var_.actorSpriteComps1094 = arg_581_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_584_0 = 0.2

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["1094"]) then
				if arg_581_1.var_.actorSpriteComps1094 then
					for iter_584_0, iter_584_1 in pairs(arg_581_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_584_1 then
							if arg_581_1.isInRecall_ then
								iter_584_1.color = Color.New(Mathf.Lerp(iter_584_1.color.r, arg_581_1.hightColor1.r, (arg_581_1.time_ - 0) / var_584_0), Mathf.Lerp(iter_584_1.color.g, arg_581_1.hightColor1.g, (arg_581_1.time_ - 0) / var_584_0), (Mathf.Lerp(iter_584_1.color.b, arg_581_1.hightColor1.b, (arg_581_1.time_ - 0) / var_584_0)))
							else
								local var_584_1 = Mathf.Lerp(iter_584_1.color.r, 1, (arg_581_1.time_ - 0) / var_584_0)

								iter_584_1.color = Color.New(var_584_1, var_584_1, var_584_1)
							end
						end
					end
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["1094"]) and arg_581_1.var_.actorSpriteComps1094 then
				for iter_584_2, iter_584_3 in pairs(arg_581_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_584_3 then
						iter_584_3.color = arg_581_1.isInRecall_ and (arg_581_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_581_1.var_.actorSpriteComps1094 = nil
			end

			local var_584_2 = arg_581_1.actors_["1094"].transform

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1094 = var_584_2.localPosition
				var_584_2.localScale = Vector3.New(1, 1, 1)

				arg_581_1:CheckSpriteTmpPos("1094", 3)

				for iter_584_4 = 0, var_584_2.childCount - 1 do
					local var_584_3 = var_584_2:GetChild(iter_584_4)

					if var_584_3.name == "split_5" then
						var_584_3:SetAsLastSibling()
						var_584_3.gameObject:SetActive(true)

						arg_581_1.var_.actorSpriteSplit1094 = var_584_3.gameObject:GetComponent(typeof(Image))

						arg_581_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_584_4 = 0.5

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_4 then
				var_584_2.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_581_1.time_ - 0) / var_584_4)

				if arg_581_1.var_.actorSpriteSplit1094 ~= nil then
					arg_581_1.var_.actorSpriteSplit1094:SetAlpha((arg_581_1.time_ - 0) / var_584_4)
				end
			end

			if arg_581_1.time_ >= 0 + var_584_4 and arg_581_1.time_ < 0 + var_584_4 + arg_584_0 then
				var_584_2.localPosition = Vector3.New(0, -335, -230)

				if arg_581_1.var_.actorSpriteSplit1094 ~= nil then
					arg_581_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_584_5 = 0
			local var_584_6 = 0.075

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_5 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_7 = arg_581_1:GetWordFromCfg(424061135)
				local var_584_8 = arg_581_1:FormatText(var_584_7.content)

				arg_581_1.text_.text = var_584_8

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_10 = 3 <= 0 and var_584_6 or var_584_6 * (utf8.len(var_584_8) / 3)

				if (3 <= 0 and var_584_6 or var_584_6 * (utf8.len(var_584_8) / 3)) > 0 and var_584_6 < var_584_10 then
					arg_581_1.talkMaxDuration = var_584_10

					if var_584_10 + var_584_5 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_10 + var_584_5
					end
				end

				arg_581_1.text_.text = var_584_8
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061135", "story_v_out_424061.awb") ~= 0 then
					local var_584_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061135", "story_v_out_424061.awb") / 1000

					if var_584_11 + var_584_5 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_11 + var_584_5
					end

					if var_584_7.prefab_name ~= "" and arg_581_1.actors_[var_584_7.prefab_name] ~= nil then
						local var_584_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_7.prefab_name].transform, "story_v_out_424061", "424061135", "story_v_out_424061.awb")

						arg_581_1:RecordAudio("424061135", var_584_12)
						arg_581_1:RecordAudio("424061135", var_584_12)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_424061", "424061135", "story_v_out_424061.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_424061", "424061135", "story_v_out_424061.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_13 = math.max(var_584_6, arg_581_1.talkMaxDuration)

			if var_584_5 <= arg_581_1.time_ and arg_581_1.time_ < var_584_5 + var_584_13 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_5) / var_584_13

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_5 + var_584_13 and arg_581_1.time_ < var_584_5 + var_584_13 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
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

		arg_581_1:InitPlayNodeList()
	end,
	Play424061136 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 424061136
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play424061137(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["1094"]) and arg_585_1.var_.actorSpriteComps1094 == nil then
				arg_585_1.var_.actorSpriteComps1094 = arg_585_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_588_0 = 0.2

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["1094"]) then
				if arg_585_1.var_.actorSpriteComps1094 then
					for iter_588_0, iter_588_1 in pairs(arg_585_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_588_1 then
							if arg_585_1.isInRecall_ then
								iter_588_1.color = Color.New(Mathf.Lerp(iter_588_1.color.r, arg_585_1.hightColor2.r, (arg_585_1.time_ - 0) / var_588_0), Mathf.Lerp(iter_588_1.color.g, arg_585_1.hightColor2.g, (arg_585_1.time_ - 0) / var_588_0), (Mathf.Lerp(iter_588_1.color.b, arg_585_1.hightColor2.b, (arg_585_1.time_ - 0) / var_588_0)))
							else
								local var_588_1 = Mathf.Lerp(iter_588_1.color.r, 0.5, (arg_585_1.time_ - 0) / var_588_0)

								iter_588_1.color = Color.New(var_588_1, var_588_1, var_588_1)
							end
						end
					end
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["1094"]) and arg_585_1.var_.actorSpriteComps1094 then
				for iter_588_2, iter_588_3 in pairs(arg_585_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_588_3 then
						iter_588_3.color = arg_585_1.isInRecall_ and (arg_585_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_585_1.var_.actorSpriteComps1094 = nil
			end

			local var_588_2 = 0
			local var_588_3 = 0.25

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_2 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_4 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(424061136).content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_6 = 10 <= 0 and var_588_3 or var_588_3 * (utf8.len(var_588_4) / 10)

				if (10 <= 0 and var_588_3 or var_588_3 * (utf8.len(var_588_4) / 10)) > 0 and var_588_3 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_2 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_2
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_3, arg_585_1.talkMaxDuration)

			if var_588_2 <= arg_585_1.time_ and arg_585_1.time_ < var_588_2 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_2) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_2 + var_588_7 and arg_585_1.time_ < var_588_2 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play424061137 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 424061137
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play424061138(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos1094 = arg_589_1.actors_["1094"].transform.localPosition
				arg_589_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_589_1:CheckSpriteTmpPos("1094", 3)

				for iter_592_0 = 0, arg_589_1.actors_["1094"].transform.childCount - 1 do
					local var_592_0 = arg_589_1.actors_["1094"].transform:GetChild(iter_592_0)

					if var_592_0.name == "" or not string.find(var_592_0.name, "split") then
						var_592_0.gameObject:SetActive(true)
					else
						var_592_0.gameObject:SetActive(false)
					end
				end
			end

			local var_592_1 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_1 then
				arg_589_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_589_1.time_ - 0) / var_592_1)
			end

			if arg_589_1.time_ >= 0 + var_592_1 and arg_589_1.time_ < 0 + var_592_1 + arg_592_0 then
				arg_589_1.actors_["1094"].transform.localPosition = Vector3.New(0, -335, -230)
			end

			local var_592_2 = 0
			local var_592_3 = 0.425

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_2 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_4 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(424061137).content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_6 = 17 <= 0 and var_592_3 or var_592_3 * (utf8.len(var_592_4) / 17)

				if (17 <= 0 and var_592_3 or var_592_3 * (utf8.len(var_592_4) / 17)) > 0 and var_592_3 < var_592_6 then
					arg_589_1.talkMaxDuration = var_592_6

					if var_592_6 + var_592_2 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_6 + var_592_2
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_7 = math.max(var_592_3, arg_589_1.talkMaxDuration)

			if var_592_2 <= arg_589_1.time_ and arg_589_1.time_ < var_592_2 + var_592_7 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_2) / var_592_7

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_2 + var_592_7 and arg_589_1.time_ < var_592_2 + var_592_7 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
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

		arg_589_1:InitPlayNodeList()
	end,
	Play424061138 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 424061138
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play424061139(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.moveOldPos1094 = arg_593_1.actors_["1094"].transform.localPosition
				arg_593_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_593_1:CheckSpriteTmpPos("1094", 7)

				for iter_596_0 = 0, arg_593_1.actors_["1094"].transform.childCount - 1 do
					local var_596_0 = arg_593_1.actors_["1094"].transform:GetChild(iter_596_0)

					if var_596_0.name == "" or not string.find(var_596_0.name, "split") then
						var_596_0.gameObject:SetActive(true)
					else
						var_596_0.gameObject:SetActive(false)
					end
				end
			end

			local var_596_1 = 0.001

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_1 then
				arg_593_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_593_1.time_ - 0) / var_596_1)
			end

			if arg_593_1.time_ >= 0 + var_596_1 and arg_593_1.time_ < 0 + var_596_1 + arg_596_0 then
				arg_593_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.333333333333333 < arg_593_1.time_ and arg_593_1.time_ <= 0.333333333333333 + arg_596_0 then
				arg_593_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_scan", "")
			end

			local var_596_3 = 0
			local var_596_4 = 0.75

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_3 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_5 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(424061138).content)

				arg_593_1.text_.text = var_596_5

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_7 = 30 <= 0 and var_596_4 or var_596_4 * (utf8.len(var_596_5) / 30)

				if (30 <= 0 and var_596_4 or var_596_4 * (utf8.len(var_596_5) / 30)) > 0 and var_596_4 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_3 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_3
					end
				end

				arg_593_1.text_.text = var_596_5
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_8 = math.max(var_596_4, arg_593_1.talkMaxDuration)

			if var_596_3 <= arg_593_1.time_ and arg_593_1.time_ < var_596_3 + var_596_8 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_3) / var_596_8

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_3 + var_596_8 and arg_593_1.time_ < var_596_3 + var_596_8 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {
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

		arg_593_1:InitPlayNodeList()
	end,
	Play424061139 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 424061139
		arg_597_1.duration_ = 1.23

		local var_597_0 = {
			zh = 1.233,
			ja = 0.999999999999
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play424061140(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1094"]) and arg_597_1.var_.actorSpriteComps1094 == nil then
				arg_597_1.var_.actorSpriteComps1094 = arg_597_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_600_0 = 0.2

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1094"]) then
				if arg_597_1.var_.actorSpriteComps1094 then
					for iter_600_0, iter_600_1 in pairs(arg_597_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_600_1 then
							if arg_597_1.isInRecall_ then
								iter_600_1.color = Color.New(Mathf.Lerp(iter_600_1.color.r, arg_597_1.hightColor1.r, (arg_597_1.time_ - 0) / var_600_0), Mathf.Lerp(iter_600_1.color.g, arg_597_1.hightColor1.g, (arg_597_1.time_ - 0) / var_600_0), (Mathf.Lerp(iter_600_1.color.b, arg_597_1.hightColor1.b, (arg_597_1.time_ - 0) / var_600_0)))
							else
								local var_600_1 = Mathf.Lerp(iter_600_1.color.r, 1, (arg_597_1.time_ - 0) / var_600_0)

								iter_600_1.color = Color.New(var_600_1, var_600_1, var_600_1)
							end
						end
					end
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1094"]) and arg_597_1.var_.actorSpriteComps1094 then
				for iter_600_2, iter_600_3 in pairs(arg_597_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_600_3 then
						iter_600_3.color = arg_597_1.isInRecall_ and (arg_597_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_597_1.var_.actorSpriteComps1094 = nil
			end

			local var_600_2 = arg_597_1.actors_["1094"].transform

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.var_.moveOldPos1094 = var_600_2.localPosition
				var_600_2.localScale = Vector3.New(1, 1, 1)

				arg_597_1:CheckSpriteTmpPos("1094", 3)

				for iter_600_4 = 0, var_600_2.childCount - 1 do
					local var_600_3 = var_600_2:GetChild(iter_600_4)

					if var_600_3.name == "split_4" or not string.find(var_600_3.name, "split") then
						var_600_3.gameObject:SetActive(true)
					else
						var_600_3.gameObject:SetActive(false)
					end
				end
			end

			local var_600_4 = 0.001

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				var_600_2.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_597_1.time_ - 0) / var_600_4)
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				var_600_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_600_5 = 0
			local var_600_6 = 0.075

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_5 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_7 = arg_597_1:GetWordFromCfg(424061139)
				local var_600_8 = arg_597_1:FormatText(var_600_7.content)

				arg_597_1.text_.text = var_600_8

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_10 = 3 <= 0 and var_600_6 or var_600_6 * (utf8.len(var_600_8) / 3)

				if (3 <= 0 and var_600_6 or var_600_6 * (utf8.len(var_600_8) / 3)) > 0 and var_600_6 < var_600_10 then
					arg_597_1.talkMaxDuration = var_600_10

					if var_600_10 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_10 + var_600_5
					end
				end

				arg_597_1.text_.text = var_600_8
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061139", "story_v_out_424061.awb") ~= 0 then
					local var_600_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061139", "story_v_out_424061.awb") / 1000

					if var_600_11 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_11 + var_600_5
					end

					if var_600_7.prefab_name ~= "" and arg_597_1.actors_[var_600_7.prefab_name] ~= nil then
						local var_600_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_7.prefab_name].transform, "story_v_out_424061", "424061139", "story_v_out_424061.awb")

						arg_597_1:RecordAudio("424061139", var_600_12)
						arg_597_1:RecordAudio("424061139", var_600_12)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_424061", "424061139", "story_v_out_424061.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_424061", "424061139", "story_v_out_424061.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_13 = math.max(var_600_6, arg_597_1.talkMaxDuration)

			if var_600_5 <= arg_597_1.time_ and arg_597_1.time_ < var_600_5 + var_600_13 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_5) / var_600_13

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_5 + var_600_13 and arg_597_1.time_ < var_600_5 + var_600_13 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
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

		arg_597_1:InitPlayNodeList()
	end,
	Play424061140 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 424061140
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play424061141(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["1094"]) and arg_601_1.var_.actorSpriteComps1094 == nil then
				arg_601_1.var_.actorSpriteComps1094 = arg_601_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_604_0 = 0.2

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["1094"]) then
				if arg_601_1.var_.actorSpriteComps1094 then
					for iter_604_0, iter_604_1 in pairs(arg_601_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_604_1 then
							if arg_601_1.isInRecall_ then
								iter_604_1.color = Color.New(Mathf.Lerp(iter_604_1.color.r, arg_601_1.hightColor2.r, (arg_601_1.time_ - 0) / var_604_0), Mathf.Lerp(iter_604_1.color.g, arg_601_1.hightColor2.g, (arg_601_1.time_ - 0) / var_604_0), (Mathf.Lerp(iter_604_1.color.b, arg_601_1.hightColor2.b, (arg_601_1.time_ - 0) / var_604_0)))
							else
								local var_604_1 = Mathf.Lerp(iter_604_1.color.r, 0.5, (arg_601_1.time_ - 0) / var_604_0)

								iter_604_1.color = Color.New(var_604_1, var_604_1, var_604_1)
							end
						end
					end
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["1094"]) and arg_601_1.var_.actorSpriteComps1094 then
				for iter_604_2, iter_604_3 in pairs(arg_601_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_604_3 then
						iter_604_3.color = arg_601_1.isInRecall_ and (arg_601_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_601_1.var_.actorSpriteComps1094 = nil
			end

			local var_604_2 = 0
			local var_604_3 = 0.825

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_2 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_4 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(424061140).content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_6 = 33 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_4) / 33)

				if (33 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_4) / 33)) > 0 and var_604_3 < var_604_6 then
					arg_601_1.talkMaxDuration = var_604_6

					if var_604_6 + var_604_2 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_6 + var_604_2
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_3, arg_601_1.talkMaxDuration)

			if var_604_2 <= arg_601_1.time_ and arg_601_1.time_ < var_604_2 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_2) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_2 + var_604_7 and arg_601_1.time_ < var_604_2 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play424061141 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 424061141
		arg_605_1.duration_ = 5.97

		local var_605_0 = {
			zh = 4.433,
			ja = 5.966
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play424061142(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.525

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_1 = arg_605_1:GetWordFromCfg(424061141)
				local var_608_2 = arg_605_1:FormatText(var_608_1.content)

				arg_605_1.text_.text = var_608_2

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 21 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 21)

				if (21 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 21)) > 0 and var_608_0 < var_608_4 then
					arg_605_1.talkMaxDuration = var_608_4

					if var_608_4 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_4 + 0
					end
				end

				arg_605_1.text_.text = var_608_2
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061141", "story_v_out_424061.awb") ~= 0 then
					local var_608_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061141", "story_v_out_424061.awb") / 1000

					if var_608_5 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_5 + 0
					end

					if var_608_1.prefab_name ~= "" and arg_605_1.actors_[var_608_1.prefab_name] ~= nil then
						local var_608_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_1.prefab_name].transform, "story_v_out_424061", "424061141", "story_v_out_424061.awb")

						arg_605_1:RecordAudio("424061141", var_608_6)
						arg_605_1:RecordAudio("424061141", var_608_6)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_424061", "424061141", "story_v_out_424061.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_424061", "424061141", "story_v_out_424061.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_7 and arg_605_1.time_ < 0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play424061142 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 424061142
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play424061143(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.55

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, true)
				arg_609_1.iconController_:SetSelectedState("hero")

				arg_609_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_609_1.callingController_:SetSelectedState("normal")

				arg_609_1.keyicon_.color = Color.New(1, 1, 1)
				arg_609_1.icon_.color = Color.New(1, 1, 1)

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(424061142).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 22 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 22)

				if (22 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 22)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play424061143 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 424061143
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play424061144(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.var_.moveOldPos1094 = arg_613_1.actors_["1094"].transform.localPosition
				arg_613_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_613_1:CheckSpriteTmpPos("1094", 7)

				for iter_616_0 = 0, arg_613_1.actors_["1094"].transform.childCount - 1 do
					local var_616_0 = arg_613_1.actors_["1094"].transform:GetChild(iter_616_0)

					if var_616_0.name == "" or not string.find(var_616_0.name, "split") then
						var_616_0.gameObject:SetActive(true)
					else
						var_616_0.gameObject:SetActive(false)
					end
				end
			end

			local var_616_1 = 0.001

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_1 then
				arg_613_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_613_1.time_ - 0) / var_616_1)
			end

			if arg_613_1.time_ >= 0 + var_616_1 and arg_613_1.time_ < 0 + var_616_1 + arg_616_0 then
				arg_613_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_616_2 = 0
			local var_616_3 = 1.275

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_2 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_4 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(424061143).content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_6 = 51 <= 0 and var_616_3 or var_616_3 * (utf8.len(var_616_4) / 51)

				if (51 <= 0 and var_616_3 or var_616_3 * (utf8.len(var_616_4) / 51)) > 0 and var_616_3 < var_616_6 then
					arg_613_1.talkMaxDuration = var_616_6

					if var_616_6 + var_616_2 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_6 + var_616_2
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_7 = math.max(var_616_3, arg_613_1.talkMaxDuration)

			if var_616_2 <= arg_613_1.time_ and arg_613_1.time_ < var_616_2 + var_616_7 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_2) / var_616_7

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_2 + var_616_7 and arg_613_1.time_ < var_616_2 + var_616_7 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
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

		arg_613_1:InitPlayNodeList()
	end,
	Play424061144 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 424061144
		arg_617_1.duration_ = 2.77

		local var_617_0 = {
			zh = 1.5,
			ja = 2.766
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play424061145(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0.2

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, true)
				arg_617_1.iconController_:SetSelectedState("hero")

				arg_617_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_617_1.callingController_:SetSelectedState("normal")

				arg_617_1.keyicon_.color = Color.New(1, 1, 1)
				arg_617_1.icon_.color = Color.New(1, 1, 1)

				local var_620_1 = arg_617_1:GetWordFromCfg(424061144)
				local var_620_2 = arg_617_1:FormatText(var_620_1.content)

				arg_617_1.text_.text = var_620_2

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 8 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 8)

				if (8 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 8)) > 0 and var_620_0 < var_620_4 then
					arg_617_1.talkMaxDuration = var_620_4

					if var_620_4 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_4 + 0
					end
				end

				arg_617_1.text_.text = var_620_2
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061144", "story_v_out_424061.awb") ~= 0 then
					local var_620_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061144", "story_v_out_424061.awb") / 1000

					if var_620_5 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + 0
					end

					if var_620_1.prefab_name ~= "" and arg_617_1.actors_[var_620_1.prefab_name] ~= nil then
						local var_620_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_1.prefab_name].transform, "story_v_out_424061", "424061144", "story_v_out_424061.awb")

						arg_617_1:RecordAudio("424061144", var_620_6)
						arg_617_1:RecordAudio("424061144", var_620_6)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_424061", "424061144", "story_v_out_424061.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_424061", "424061144", "story_v_out_424061.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_7 and arg_617_1.time_ < 0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play424061145 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 424061145
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play424061146(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 1.025

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_1 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(424061145).content)

				arg_621_1.text_.text = var_624_1

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_3 = 41 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_1) / 41)

				if (41 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_1) / 41)) > 0 and var_624_0 < var_624_3 then
					arg_621_1.talkMaxDuration = var_624_3

					if var_624_3 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_3 + 0
					end
				end

				arg_621_1.text_.text = var_624_1
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_4 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_4 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_4

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_4 and arg_621_1.time_ < 0 + var_624_4 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play424061146 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 424061146
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play424061147(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.625

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_1 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(424061146).content)

				arg_625_1.text_.text = var_628_1

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_3 = 25 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 25)

				if (25 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 25)) > 0 and var_628_0 < var_628_3 then
					arg_625_1.talkMaxDuration = var_628_3

					if var_628_3 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_3 + 0
					end
				end

				arg_625_1.text_.text = var_628_1
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_4 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_4 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_4

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_4 and arg_625_1.time_ < 0 + var_628_4 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play424061147 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 424061147
		arg_629_1.duration_ = 2.57

		local var_629_0 = {
			zh = 2.266,
			ja = 2.566
		}
		local var_629_1 = manager.audio:GetLocalizationFlag()

		if var_629_0[var_629_1] ~= nil then
			arg_629_1.duration_ = var_629_0[var_629_1]
		end

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play424061148(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 and not isNil(arg_629_1.actors_["1094"]) and arg_629_1.var_.actorSpriteComps1094 == nil then
				arg_629_1.var_.actorSpriteComps1094 = arg_629_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_632_0 = 0.2

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_0 and not isNil(arg_629_1.actors_["1094"]) then
				if arg_629_1.var_.actorSpriteComps1094 then
					for iter_632_0, iter_632_1 in pairs(arg_629_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_632_1 then
							if arg_629_1.isInRecall_ then
								iter_632_1.color = Color.New(Mathf.Lerp(iter_632_1.color.r, arg_629_1.hightColor1.r, (arg_629_1.time_ - 0) / var_632_0), Mathf.Lerp(iter_632_1.color.g, arg_629_1.hightColor1.g, (arg_629_1.time_ - 0) / var_632_0), (Mathf.Lerp(iter_632_1.color.b, arg_629_1.hightColor1.b, (arg_629_1.time_ - 0) / var_632_0)))
							else
								local var_632_1 = Mathf.Lerp(iter_632_1.color.r, 1, (arg_629_1.time_ - 0) / var_632_0)

								iter_632_1.color = Color.New(var_632_1, var_632_1, var_632_1)
							end
						end
					end
				end
			end

			if arg_629_1.time_ >= 0 + var_632_0 and arg_629_1.time_ < 0 + var_632_0 + arg_632_0 and not isNil(arg_629_1.actors_["1094"]) and arg_629_1.var_.actorSpriteComps1094 then
				for iter_632_2, iter_632_3 in pairs(arg_629_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_632_3 then
						iter_632_3.color = arg_629_1.isInRecall_ and (arg_629_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_629_1.var_.actorSpriteComps1094 = nil
			end

			local var_632_2 = arg_629_1.actors_["1094"].transform

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.var_.moveOldPos1094 = var_632_2.localPosition
				var_632_2.localScale = Vector3.New(1, 1, 1)

				arg_629_1:CheckSpriteTmpPos("1094", 3)

				for iter_632_4 = 0, var_632_2.childCount - 1 do
					local var_632_3 = var_632_2:GetChild(iter_632_4)

					if var_632_3.name == "split_2" or not string.find(var_632_3.name, "split") then
						var_632_3.gameObject:SetActive(true)
					else
						var_632_3.gameObject:SetActive(false)
					end
				end
			end

			local var_632_4 = 0.001

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_4 then
				var_632_2.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_629_1.time_ - 0) / var_632_4)
			end

			if arg_629_1.time_ >= 0 + var_632_4 and arg_629_1.time_ < 0 + var_632_4 + arg_632_0 then
				var_632_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_632_5 = 0
			local var_632_6 = 0.225

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_5 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_7 = arg_629_1:GetWordFromCfg(424061147)
				local var_632_8 = arg_629_1:FormatText(var_632_7.content)

				arg_629_1.text_.text = var_632_8

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_10 = 9 <= 0 and var_632_6 or var_632_6 * (utf8.len(var_632_8) / 9)

				if (9 <= 0 and var_632_6 or var_632_6 * (utf8.len(var_632_8) / 9)) > 0 and var_632_6 < var_632_10 then
					arg_629_1.talkMaxDuration = var_632_10

					if var_632_10 + var_632_5 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_10 + var_632_5
					end
				end

				arg_629_1.text_.text = var_632_8
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061147", "story_v_out_424061.awb") ~= 0 then
					local var_632_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061147", "story_v_out_424061.awb") / 1000

					if var_632_11 + var_632_5 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_11 + var_632_5
					end

					if var_632_7.prefab_name ~= "" and arg_629_1.actors_[var_632_7.prefab_name] ~= nil then
						local var_632_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_7.prefab_name].transform, "story_v_out_424061", "424061147", "story_v_out_424061.awb")

						arg_629_1:RecordAudio("424061147", var_632_12)
						arg_629_1:RecordAudio("424061147", var_632_12)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_424061", "424061147", "story_v_out_424061.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_424061", "424061147", "story_v_out_424061.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_13 = math.max(var_632_6, arg_629_1.talkMaxDuration)

			if var_632_5 <= arg_629_1.time_ and arg_629_1.time_ < var_632_5 + var_632_13 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_5) / var_632_13

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_5 + var_632_13 and arg_629_1.time_ < var_632_5 + var_632_13 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
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

		arg_629_1:InitPlayNodeList()
	end,
	Play424061148 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 424061148
		arg_633_1.duration_ = 5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play424061149(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(arg_633_1.actors_["1094"]) and arg_633_1.var_.actorSpriteComps1094 == nil then
				arg_633_1.var_.actorSpriteComps1094 = arg_633_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_636_0 = 0.2

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 and not isNil(arg_633_1.actors_["1094"]) then
				if arg_633_1.var_.actorSpriteComps1094 then
					for iter_636_0, iter_636_1 in pairs(arg_633_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_636_1 then
							if arg_633_1.isInRecall_ then
								iter_636_1.color = Color.New(Mathf.Lerp(iter_636_1.color.r, arg_633_1.hightColor2.r, (arg_633_1.time_ - 0) / var_636_0), Mathf.Lerp(iter_636_1.color.g, arg_633_1.hightColor2.g, (arg_633_1.time_ - 0) / var_636_0), (Mathf.Lerp(iter_636_1.color.b, arg_633_1.hightColor2.b, (arg_633_1.time_ - 0) / var_636_0)))
							else
								local var_636_1 = Mathf.Lerp(iter_636_1.color.r, 0.5, (arg_633_1.time_ - 0) / var_636_0)

								iter_636_1.color = Color.New(var_636_1, var_636_1, var_636_1)
							end
						end
					end
				end
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 and not isNil(arg_633_1.actors_["1094"]) and arg_633_1.var_.actorSpriteComps1094 then
				for iter_636_2, iter_636_3 in pairs(arg_633_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_636_3 then
						iter_636_3.color = arg_633_1.isInRecall_ and (arg_633_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_633_1.var_.actorSpriteComps1094 = nil
			end

			local var_636_2 = 0
			local var_636_3 = 0.925

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_2 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, true)
				arg_633_1.iconController_:SetSelectedState("hero")

				arg_633_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_633_1.callingController_:SetSelectedState("normal")

				arg_633_1.keyicon_.color = Color.New(1, 1, 1)
				arg_633_1.icon_.color = Color.New(1, 1, 1)

				local var_636_4 = arg_633_1:FormatText(arg_633_1:GetWordFromCfg(424061148).content)

				arg_633_1.text_.text = var_636_4

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_6 = 37 <= 0 and var_636_3 or var_636_3 * (utf8.len(var_636_4) / 37)

				if (37 <= 0 and var_636_3 or var_636_3 * (utf8.len(var_636_4) / 37)) > 0 and var_636_3 < var_636_6 then
					arg_633_1.talkMaxDuration = var_636_6

					if var_636_6 + var_636_2 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_6 + var_636_2
					end
				end

				arg_633_1.text_.text = var_636_4
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)
				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_7 = math.max(var_636_3, arg_633_1.talkMaxDuration)

			if var_636_2 <= arg_633_1.time_ and arg_633_1.time_ < var_636_2 + var_636_7 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_2) / var_636_7

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_2 + var_636_7 and arg_633_1.time_ < var_636_2 + var_636_7 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play424061149 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 424061149
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play424061150(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0.7

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_1 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(424061149).content)

				arg_637_1.text_.text = var_640_1

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_3 = 28 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_1) / 28)

				if (28 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_1) / 28)) > 0 and var_640_0 < var_640_3 then
					arg_637_1.talkMaxDuration = var_640_3

					if var_640_3 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_3 + 0
					end
				end

				arg_637_1.text_.text = var_640_1
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_4 = math.max(var_640_0, arg_637_1.talkMaxDuration)

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_4 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - 0) / var_640_4

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= 0 + var_640_4 and arg_637_1.time_ < 0 + var_640_4 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play424061150 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 424061150
		arg_641_1.duration_ = 2.33

		local var_641_0 = {
			zh = 2.333,
			ja = 2.1
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play424061151(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0.275

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, true)
				arg_641_1.iconController_:SetSelectedState("hero")

				arg_641_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_641_1.callingController_:SetSelectedState("normal")

				arg_641_1.keyicon_.color = Color.New(1, 1, 1)
				arg_641_1.icon_.color = Color.New(1, 1, 1)

				local var_644_1 = arg_641_1:GetWordFromCfg(424061150)
				local var_644_2 = arg_641_1:FormatText(var_644_1.content)

				arg_641_1.text_.text = var_644_2

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_4 = 11 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_2) / 11)

				if (11 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_2) / 11)) > 0 and var_644_0 < var_644_4 then
					arg_641_1.talkMaxDuration = var_644_4

					if var_644_4 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_4 + 0
					end
				end

				arg_641_1.text_.text = var_644_2
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061150", "story_v_out_424061.awb") ~= 0 then
					local var_644_5 = manager.audio:GetVoiceLength("story_v_out_424061", "424061150", "story_v_out_424061.awb") / 1000

					if var_644_5 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_5 + 0
					end

					if var_644_1.prefab_name ~= "" and arg_641_1.actors_[var_644_1.prefab_name] ~= nil then
						local var_644_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_1.prefab_name].transform, "story_v_out_424061", "424061150", "story_v_out_424061.awb")

						arg_641_1:RecordAudio("424061150", var_644_6)
						arg_641_1:RecordAudio("424061150", var_644_6)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_424061", "424061150", "story_v_out_424061.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_424061", "424061150", "story_v_out_424061.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_7 = math.max(var_644_0, arg_641_1.talkMaxDuration)

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_7 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - 0) / var_644_7

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= 0 + var_644_7 and arg_641_1.time_ < 0 + var_644_7 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play424061151 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 424061151
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play424061152(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0.475

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_1 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(424061151).content)

				arg_645_1.text_.text = var_648_1

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_3 = 19 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 19)

				if (19 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 19)) > 0 and var_648_0 < var_648_3 then
					arg_645_1.talkMaxDuration = var_648_3

					if var_648_3 + 0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_3 + 0
					end
				end

				arg_645_1.text_.text = var_648_1
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_4 = math.max(var_648_0, arg_645_1.talkMaxDuration)

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_4 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - 0) / var_648_4

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= 0 + var_648_4 and arg_645_1.time_ < 0 + var_648_4 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play424061152 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 424061152
		arg_649_1.duration_ = 3.13

		local var_649_0 = {
			zh = 2.633,
			ja = 3.133
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play424061153(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 and not isNil(arg_649_1.actors_["1094"]) and arg_649_1.var_.actorSpriteComps1094 == nil then
				arg_649_1.var_.actorSpriteComps1094 = arg_649_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_652_0 = 0.2

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_0 and not isNil(arg_649_1.actors_["1094"]) then
				if arg_649_1.var_.actorSpriteComps1094 then
					for iter_652_0, iter_652_1 in pairs(arg_649_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_652_1 then
							if arg_649_1.isInRecall_ then
								iter_652_1.color = Color.New(Mathf.Lerp(iter_652_1.color.r, arg_649_1.hightColor1.r, (arg_649_1.time_ - 0) / var_652_0), Mathf.Lerp(iter_652_1.color.g, arg_649_1.hightColor1.g, (arg_649_1.time_ - 0) / var_652_0), (Mathf.Lerp(iter_652_1.color.b, arg_649_1.hightColor1.b, (arg_649_1.time_ - 0) / var_652_0)))
							else
								local var_652_1 = Mathf.Lerp(iter_652_1.color.r, 1, (arg_649_1.time_ - 0) / var_652_0)

								iter_652_1.color = Color.New(var_652_1, var_652_1, var_652_1)
							end
						end
					end
				end
			end

			if arg_649_1.time_ >= 0 + var_652_0 and arg_649_1.time_ < 0 + var_652_0 + arg_652_0 and not isNil(arg_649_1.actors_["1094"]) and arg_649_1.var_.actorSpriteComps1094 then
				for iter_652_2, iter_652_3 in pairs(arg_649_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_652_3 then
						iter_652_3.color = arg_649_1.isInRecall_ and (arg_649_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_649_1.var_.actorSpriteComps1094 = nil
			end

			local var_652_2 = arg_649_1.actors_["1094"].transform

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.var_.moveOldPos1094 = var_652_2.localPosition
				var_652_2.localScale = Vector3.New(1, 1, 1)

				arg_649_1:CheckSpriteTmpPos("1094", 3)

				for iter_652_4 = 0, var_652_2.childCount - 1 do
					local var_652_3 = var_652_2:GetChild(iter_652_4)

					if var_652_3.name == "split_1" then
						var_652_3:SetAsLastSibling()
						var_652_3.gameObject:SetActive(true)

						arg_649_1.var_.actorSpriteSplit1094 = var_652_3.gameObject:GetComponent(typeof(Image))

						arg_649_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_652_4 = 0.5

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				var_652_2.localPosition = Vector3.Lerp(arg_649_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_649_1.time_ - 0) / var_652_4)

				if arg_649_1.var_.actorSpriteSplit1094 ~= nil then
					arg_649_1.var_.actorSpriteSplit1094:SetAlpha((arg_649_1.time_ - 0) / var_652_4)
				end
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				var_652_2.localPosition = Vector3.New(0, -335, -230)

				if arg_649_1.var_.actorSpriteSplit1094 ~= nil then
					arg_649_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_652_5 = 0
			local var_652_6 = 0.25

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_5 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_7 = arg_649_1:GetWordFromCfg(424061152)
				local var_652_8 = arg_649_1:FormatText(var_652_7.content)

				arg_649_1.text_.text = var_652_8

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_10 = 10 <= 0 and var_652_6 or var_652_6 * (utf8.len(var_652_8) / 10)

				if (10 <= 0 and var_652_6 or var_652_6 * (utf8.len(var_652_8) / 10)) > 0 and var_652_6 < var_652_10 then
					arg_649_1.talkMaxDuration = var_652_10

					if var_652_10 + var_652_5 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_10 + var_652_5
					end
				end

				arg_649_1.text_.text = var_652_8
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061152", "story_v_out_424061.awb") ~= 0 then
					local var_652_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061152", "story_v_out_424061.awb") / 1000

					if var_652_11 + var_652_5 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_11 + var_652_5
					end

					if var_652_7.prefab_name ~= "" and arg_649_1.actors_[var_652_7.prefab_name] ~= nil then
						local var_652_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_7.prefab_name].transform, "story_v_out_424061", "424061152", "story_v_out_424061.awb")

						arg_649_1:RecordAudio("424061152", var_652_12)
						arg_649_1:RecordAudio("424061152", var_652_12)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_424061", "424061152", "story_v_out_424061.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_424061", "424061152", "story_v_out_424061.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_13 = math.max(var_652_6, arg_649_1.talkMaxDuration)

			if var_652_5 <= arg_649_1.time_ and arg_649_1.time_ < var_652_5 + var_652_13 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_5) / var_652_13

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_5 + var_652_13 and arg_649_1.time_ < var_652_5 + var_652_13 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {
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

		arg_649_1:InitPlayNodeList()
	end,
	Play424061153 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 424061153
		arg_653_1.duration_ = 5.17

		local var_653_0 = {
			zh = 4.766,
			ja = 5.166
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play424061154(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(arg_653_1.actors_["1094"]) and arg_653_1.var_.actorSpriteComps1094 == nil then
				arg_653_1.var_.actorSpriteComps1094 = arg_653_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_656_0 = 0.2

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 and not isNil(arg_653_1.actors_["1094"]) then
				if arg_653_1.var_.actorSpriteComps1094 then
					for iter_656_0, iter_656_1 in pairs(arg_653_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_656_1 then
							if arg_653_1.isInRecall_ then
								iter_656_1.color = Color.New(Mathf.Lerp(iter_656_1.color.r, arg_653_1.hightColor2.r, (arg_653_1.time_ - 0) / var_656_0), Mathf.Lerp(iter_656_1.color.g, arg_653_1.hightColor2.g, (arg_653_1.time_ - 0) / var_656_0), (Mathf.Lerp(iter_656_1.color.b, arg_653_1.hightColor2.b, (arg_653_1.time_ - 0) / var_656_0)))
							else
								local var_656_1 = Mathf.Lerp(iter_656_1.color.r, 0.5, (arg_653_1.time_ - 0) / var_656_0)

								iter_656_1.color = Color.New(var_656_1, var_656_1, var_656_1)
							end
						end
					end
				end
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 and not isNil(arg_653_1.actors_["1094"]) and arg_653_1.var_.actorSpriteComps1094 then
				for iter_656_2, iter_656_3 in pairs(arg_653_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_656_3 then
						iter_656_3.color = arg_653_1.isInRecall_ and (arg_653_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_653_1.var_.actorSpriteComps1094 = nil
			end

			local var_656_2 = 0
			local var_656_3 = 0.55

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_2 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_4 = arg_653_1:GetWordFromCfg(424061153)
				local var_656_5 = arg_653_1:FormatText(var_656_4.content)

				arg_653_1.text_.text = var_656_5

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_7 = 22 <= 0 and var_656_3 or var_656_3 * (utf8.len(var_656_5) / 22)

				if (22 <= 0 and var_656_3 or var_656_3 * (utf8.len(var_656_5) / 22)) > 0 and var_656_3 < var_656_7 then
					arg_653_1.talkMaxDuration = var_656_7

					if var_656_7 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_7 + var_656_2
					end
				end

				arg_653_1.text_.text = var_656_5
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061153", "story_v_out_424061.awb") ~= 0 then
					local var_656_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061153", "story_v_out_424061.awb") / 1000

					if var_656_8 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_8 + var_656_2
					end

					if var_656_4.prefab_name ~= "" and arg_653_1.actors_[var_656_4.prefab_name] ~= nil then
						local var_656_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_4.prefab_name].transform, "story_v_out_424061", "424061153", "story_v_out_424061.awb")

						arg_653_1:RecordAudio("424061153", var_656_9)
						arg_653_1:RecordAudio("424061153", var_656_9)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_out_424061", "424061153", "story_v_out_424061.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_out_424061", "424061153", "story_v_out_424061.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_10 = math.max(var_656_3, arg_653_1.talkMaxDuration)

			if var_656_2 <= arg_653_1.time_ and arg_653_1.time_ < var_656_2 + var_656_10 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_2) / var_656_10

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_2 + var_656_10 and arg_653_1.time_ < var_656_2 + var_656_10 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play424061154 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 424061154
		arg_657_1.duration_ = 2.03

		local var_657_0 = {
			zh = 1.933,
			ja = 2.033
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play424061155(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(arg_657_1.actors_["1094"]) and arg_657_1.var_.actorSpriteComps1094 == nil then
				arg_657_1.var_.actorSpriteComps1094 = arg_657_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_660_0 = 0.2

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 and not isNil(arg_657_1.actors_["1094"]) then
				if arg_657_1.var_.actorSpriteComps1094 then
					for iter_660_0, iter_660_1 in pairs(arg_657_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_660_1 then
							if arg_657_1.isInRecall_ then
								iter_660_1.color = Color.New(Mathf.Lerp(iter_660_1.color.r, arg_657_1.hightColor1.r, (arg_657_1.time_ - 0) / var_660_0), Mathf.Lerp(iter_660_1.color.g, arg_657_1.hightColor1.g, (arg_657_1.time_ - 0) / var_660_0), (Mathf.Lerp(iter_660_1.color.b, arg_657_1.hightColor1.b, (arg_657_1.time_ - 0) / var_660_0)))
							else
								local var_660_1 = Mathf.Lerp(iter_660_1.color.r, 1, (arg_657_1.time_ - 0) / var_660_0)

								iter_660_1.color = Color.New(var_660_1, var_660_1, var_660_1)
							end
						end
					end
				end
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 and not isNil(arg_657_1.actors_["1094"]) and arg_657_1.var_.actorSpriteComps1094 then
				for iter_660_2, iter_660_3 in pairs(arg_657_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_660_3 then
						iter_660_3.color = arg_657_1.isInRecall_ and (arg_657_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_657_1.var_.actorSpriteComps1094 = nil
			end

			local var_660_2 = arg_657_1.actors_["1094"].transform

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.var_.moveOldPos1094 = var_660_2.localPosition
				var_660_2.localScale = Vector3.New(1, 1, 1)

				arg_657_1:CheckSpriteTmpPos("1094", 3)

				for iter_660_4 = 0, var_660_2.childCount - 1 do
					local var_660_3 = var_660_2:GetChild(iter_660_4)

					if var_660_3.name == "split_2" or not string.find(var_660_3.name, "split") then
						var_660_3.gameObject:SetActive(true)
					else
						var_660_3.gameObject:SetActive(false)
					end
				end
			end

			local var_660_4 = 0.001

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_4 then
				var_660_2.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_657_1.time_ - 0) / var_660_4)
			end

			if arg_657_1.time_ >= 0 + var_660_4 and arg_657_1.time_ < 0 + var_660_4 + arg_660_0 then
				var_660_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_660_5 = 0
			local var_660_6 = 0.225

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_7 = arg_657_1:GetWordFromCfg(424061154)
				local var_660_8 = arg_657_1:FormatText(var_660_7.content)

				arg_657_1.text_.text = var_660_8

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_10 = 9 <= 0 and var_660_6 or var_660_6 * (utf8.len(var_660_8) / 9)

				if (9 <= 0 and var_660_6 or var_660_6 * (utf8.len(var_660_8) / 9)) > 0 and var_660_6 < var_660_10 then
					arg_657_1.talkMaxDuration = var_660_10

					if var_660_10 + var_660_5 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_10 + var_660_5
					end
				end

				arg_657_1.text_.text = var_660_8
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061154", "story_v_out_424061.awb") ~= 0 then
					local var_660_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061154", "story_v_out_424061.awb") / 1000

					if var_660_11 + var_660_5 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_11 + var_660_5
					end

					if var_660_7.prefab_name ~= "" and arg_657_1.actors_[var_660_7.prefab_name] ~= nil then
						local var_660_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_7.prefab_name].transform, "story_v_out_424061", "424061154", "story_v_out_424061.awb")

						arg_657_1:RecordAudio("424061154", var_660_12)
						arg_657_1:RecordAudio("424061154", var_660_12)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_424061", "424061154", "story_v_out_424061.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_424061", "424061154", "story_v_out_424061.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_13 = math.max(var_660_6, arg_657_1.talkMaxDuration)

			if var_660_5 <= arg_657_1.time_ and arg_657_1.time_ < var_660_5 + var_660_13 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_5) / var_660_13

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_5 + var_660_13 and arg_657_1.time_ < var_660_5 + var_660_13 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
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

		arg_657_1:InitPlayNodeList()
	end,
	Play424061155 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 424061155
		arg_661_1.duration_ = 4.53

		local var_661_0 = {
			zh = 3.033,
			ja = 4.533
		}
		local var_661_1 = manager.audio:GetLocalizationFlag()

		if var_661_0[var_661_1] ~= nil then
			arg_661_1.duration_ = var_661_0[var_661_1]
		end

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play424061156(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["1094"]) and arg_661_1.var_.actorSpriteComps1094 == nil then
				arg_661_1.var_.actorSpriteComps1094 = arg_661_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_664_0 = 0.2

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["1094"]) then
				if arg_661_1.var_.actorSpriteComps1094 then
					for iter_664_0, iter_664_1 in pairs(arg_661_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_664_1 then
							if arg_661_1.isInRecall_ then
								iter_664_1.color = Color.New(Mathf.Lerp(iter_664_1.color.r, arg_661_1.hightColor2.r, (arg_661_1.time_ - 0) / var_664_0), Mathf.Lerp(iter_664_1.color.g, arg_661_1.hightColor2.g, (arg_661_1.time_ - 0) / var_664_0), (Mathf.Lerp(iter_664_1.color.b, arg_661_1.hightColor2.b, (arg_661_1.time_ - 0) / var_664_0)))
							else
								local var_664_1 = Mathf.Lerp(iter_664_1.color.r, 0.5, (arg_661_1.time_ - 0) / var_664_0)

								iter_664_1.color = Color.New(var_664_1, var_664_1, var_664_1)
							end
						end
					end
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["1094"]) and arg_661_1.var_.actorSpriteComps1094 then
				for iter_664_2, iter_664_3 in pairs(arg_661_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_664_3 then
						iter_664_3.color = arg_661_1.isInRecall_ and (arg_661_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_661_1.var_.actorSpriteComps1094 = nil
			end

			local var_664_2 = 0
			local var_664_3 = 0.4

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_2 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_4 = arg_661_1:GetWordFromCfg(424061155)
				local var_664_5 = arg_661_1:FormatText(var_664_4.content)

				arg_661_1.text_.text = var_664_5

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_7 = 16 <= 0 and var_664_3 or var_664_3 * (utf8.len(var_664_5) / 16)

				if (16 <= 0 and var_664_3 or var_664_3 * (utf8.len(var_664_5) / 16)) > 0 and var_664_3 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_2
					end
				end

				arg_661_1.text_.text = var_664_5
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061155", "story_v_out_424061.awb") ~= 0 then
					local var_664_8 = manager.audio:GetVoiceLength("story_v_out_424061", "424061155", "story_v_out_424061.awb") / 1000

					if var_664_8 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_8 + var_664_2
					end

					if var_664_4.prefab_name ~= "" and arg_661_1.actors_[var_664_4.prefab_name] ~= nil then
						local var_664_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_4.prefab_name].transform, "story_v_out_424061", "424061155", "story_v_out_424061.awb")

						arg_661_1:RecordAudio("424061155", var_664_9)
						arg_661_1:RecordAudio("424061155", var_664_9)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_out_424061", "424061155", "story_v_out_424061.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_out_424061", "424061155", "story_v_out_424061.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_10 = math.max(var_664_3, arg_661_1.talkMaxDuration)

			if var_664_2 <= arg_661_1.time_ and arg_661_1.time_ < var_664_2 + var_664_10 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_2) / var_664_10

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_2 + var_664_10 and arg_661_1.time_ < var_664_2 + var_664_10 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play424061156 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 424061156
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play424061157(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0.225

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_1 = arg_665_1:FormatText(arg_665_1:GetWordFromCfg(424061156).content)

				arg_665_1.text_.text = var_668_1

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_3 = 9 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 9)

				if (9 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 9)) > 0 and var_668_0 < var_668_3 then
					arg_665_1.talkMaxDuration = var_668_3

					if var_668_3 + 0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_3 + 0
					end
				end

				arg_665_1.text_.text = var_668_1
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_4 = math.max(var_668_0, arg_665_1.talkMaxDuration)

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_4 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - 0) / var_668_4

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= 0 + var_668_4 and arg_665_1.time_ < 0 + var_668_4 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play424061157 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 424061157
		arg_669_1.duration_ = 3.13

		local var_669_0 = {
			zh = 3.133,
			ja = 3
		}
		local var_669_1 = manager.audio:GetLocalizationFlag()

		if var_669_0[var_669_1] ~= nil then
			arg_669_1.duration_ = var_669_0[var_669_1]
		end

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play424061158(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(arg_669_1.actors_["1094"]) and arg_669_1.var_.actorSpriteComps1094 == nil then
				arg_669_1.var_.actorSpriteComps1094 = arg_669_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_672_0 = 0.2

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 and not isNil(arg_669_1.actors_["1094"]) then
				if arg_669_1.var_.actorSpriteComps1094 then
					for iter_672_0, iter_672_1 in pairs(arg_669_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_672_1 then
							if arg_669_1.isInRecall_ then
								iter_672_1.color = Color.New(Mathf.Lerp(iter_672_1.color.r, arg_669_1.hightColor1.r, (arg_669_1.time_ - 0) / var_672_0), Mathf.Lerp(iter_672_1.color.g, arg_669_1.hightColor1.g, (arg_669_1.time_ - 0) / var_672_0), (Mathf.Lerp(iter_672_1.color.b, arg_669_1.hightColor1.b, (arg_669_1.time_ - 0) / var_672_0)))
							else
								local var_672_1 = Mathf.Lerp(iter_672_1.color.r, 1, (arg_669_1.time_ - 0) / var_672_0)

								iter_672_1.color = Color.New(var_672_1, var_672_1, var_672_1)
							end
						end
					end
				end
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 and not isNil(arg_669_1.actors_["1094"]) and arg_669_1.var_.actorSpriteComps1094 then
				for iter_672_2, iter_672_3 in pairs(arg_669_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_672_3 then
						iter_672_3.color = arg_669_1.isInRecall_ and (arg_669_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_669_1.var_.actorSpriteComps1094 = nil
			end

			local var_672_2 = arg_669_1.actors_["1094"].transform

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.var_.moveOldPos1094 = var_672_2.localPosition
				var_672_2.localScale = Vector3.New(1, 1, 1)

				arg_669_1:CheckSpriteTmpPos("1094", 3)

				for iter_672_4 = 0, var_672_2.childCount - 1 do
					local var_672_3 = var_672_2:GetChild(iter_672_4)

					if var_672_3.name == "split_4" then
						var_672_3:SetAsLastSibling()
						var_672_3.gameObject:SetActive(true)

						arg_669_1.var_.actorSpriteSplit1094 = var_672_3.gameObject:GetComponent(typeof(Image))

						arg_669_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_672_4 = 0.5

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_4 then
				var_672_2.localPosition = Vector3.Lerp(arg_669_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_669_1.time_ - 0) / var_672_4)

				if arg_669_1.var_.actorSpriteSplit1094 ~= nil then
					arg_669_1.var_.actorSpriteSplit1094:SetAlpha((arg_669_1.time_ - 0) / var_672_4)
				end
			end

			if arg_669_1.time_ >= 0 + var_672_4 and arg_669_1.time_ < 0 + var_672_4 + arg_672_0 then
				var_672_2.localPosition = Vector3.New(0, -335, -230)

				if arg_669_1.var_.actorSpriteSplit1094 ~= nil then
					arg_669_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_672_5 = 0
			local var_672_6 = 0.275

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_5 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_7 = arg_669_1:GetWordFromCfg(424061157)
				local var_672_8 = arg_669_1:FormatText(var_672_7.content)

				arg_669_1.text_.text = var_672_8

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_10 = 11 <= 0 and var_672_6 or var_672_6 * (utf8.len(var_672_8) / 11)

				if (11 <= 0 and var_672_6 or var_672_6 * (utf8.len(var_672_8) / 11)) > 0 and var_672_6 < var_672_10 then
					arg_669_1.talkMaxDuration = var_672_10

					if var_672_10 + var_672_5 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_10 + var_672_5
					end
				end

				arg_669_1.text_.text = var_672_8
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424061", "424061157", "story_v_out_424061.awb") ~= 0 then
					local var_672_11 = manager.audio:GetVoiceLength("story_v_out_424061", "424061157", "story_v_out_424061.awb") / 1000

					if var_672_11 + var_672_5 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_11 + var_672_5
					end

					if var_672_7.prefab_name ~= "" and arg_669_1.actors_[var_672_7.prefab_name] ~= nil then
						local var_672_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_7.prefab_name].transform, "story_v_out_424061", "424061157", "story_v_out_424061.awb")

						arg_669_1:RecordAudio("424061157", var_672_12)
						arg_669_1:RecordAudio("424061157", var_672_12)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_out_424061", "424061157", "story_v_out_424061.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_out_424061", "424061157", "story_v_out_424061.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_13 = math.max(var_672_6, arg_669_1.talkMaxDuration)

			if var_672_5 <= arg_669_1.time_ and arg_669_1.time_ < var_672_5 + var_672_13 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_5) / var_672_13

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_5 + var_672_13 and arg_669_1.time_ < var_672_5 + var_672_13 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {
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

		arg_669_1:InitPlayNodeList()
	end,
	Play424061158 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 424061158
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play424061159(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["1094"]) and arg_673_1.var_.actorSpriteComps1094 == nil then
				arg_673_1.var_.actorSpriteComps1094 = arg_673_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_676_0 = 0.2

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["1094"]) then
				if arg_673_1.var_.actorSpriteComps1094 then
					for iter_676_0, iter_676_1 in pairs(arg_673_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_676_1 then
							if arg_673_1.isInRecall_ then
								iter_676_1.color = Color.New(Mathf.Lerp(iter_676_1.color.r, arg_673_1.hightColor2.r, (arg_673_1.time_ - 0) / var_676_0), Mathf.Lerp(iter_676_1.color.g, arg_673_1.hightColor2.g, (arg_673_1.time_ - 0) / var_676_0), (Mathf.Lerp(iter_676_1.color.b, arg_673_1.hightColor2.b, (arg_673_1.time_ - 0) / var_676_0)))
							else
								local var_676_1 = Mathf.Lerp(iter_676_1.color.r, 0.5, (arg_673_1.time_ - 0) / var_676_0)

								iter_676_1.color = Color.New(var_676_1, var_676_1, var_676_1)
							end
						end
					end
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["1094"]) and arg_673_1.var_.actorSpriteComps1094 then
				for iter_676_2, iter_676_3 in pairs(arg_673_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_676_3 then
						iter_676_3.color = arg_673_1.isInRecall_ and (arg_673_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_673_1.var_.actorSpriteComps1094 = nil
			end

			local var_676_2 = arg_673_1.actors_["1094"].transform

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1.var_.moveOldPos1094 = var_676_2.localPosition
				var_676_2.localScale = Vector3.New(1, 1, 1)

				arg_673_1:CheckSpriteTmpPos("1094", 7)

				for iter_676_4 = 0, var_676_2.childCount - 1 do
					local var_676_3 = var_676_2:GetChild(iter_676_4)

					if var_676_3.name == "" or not string.find(var_676_3.name, "split") then
						var_676_3.gameObject:SetActive(true)
					else
						var_676_3.gameObject:SetActive(false)
					end
				end
			end

			local var_676_4 = 0.001

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_4 then
				var_676_2.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_673_1.time_ - 0) / var_676_4)
			end

			if arg_673_1.time_ >= 0 + var_676_4 and arg_673_1.time_ < 0 + var_676_4 + arg_676_0 then
				var_676_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_676_5 = 0
			local var_676_6 = 0.875

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_5 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, false)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_7 = arg_673_1:FormatText(arg_673_1:GetWordFromCfg(424061158).content)

				arg_673_1.text_.text = var_676_7

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_9 = 35 <= 0 and var_676_6 or var_676_6 * (utf8.len(var_676_7) / 35)

				if (35 <= 0 and var_676_6 or var_676_6 * (utf8.len(var_676_7) / 35)) > 0 and var_676_6 < var_676_9 then
					arg_673_1.talkMaxDuration = var_676_9

					if var_676_9 + var_676_5 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_9 + var_676_5
					end
				end

				arg_673_1.text_.text = var_676_7
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_10 = math.max(var_676_6, arg_673_1.talkMaxDuration)

			if var_676_5 <= arg_673_1.time_ and arg_673_1.time_ < var_676_5 + var_676_10 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_5) / var_676_10

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_5 + var_676_10 and arg_673_1.time_ < var_676_5 + var_676_10 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {
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

		arg_673_1:InitPlayNodeList()
	end,
	Play424061159 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 424061159
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
			arg_677_1.auto_ = false
		end

		function arg_677_1.playNext_(arg_679_0)
			arg_677_1.onStoryFinished_()
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = 0.275

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, true)
				arg_677_1.iconController_:SetSelectedState("hero")

				arg_677_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_677_1.callingController_:SetSelectedState("normal")

				arg_677_1.keyicon_.color = Color.New(1, 1, 1)
				arg_677_1.icon_.color = Color.New(1, 1, 1)

				local var_680_1 = arg_677_1:FormatText(arg_677_1:GetWordFromCfg(424061159).content)

				arg_677_1.text_.text = var_680_1

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_3 = 11 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_1) / 11)

				if (11 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_1) / 11)) > 0 and var_680_0 < var_680_3 then
					arg_677_1.talkMaxDuration = var_680_3

					if var_680_3 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_3 + 0
					end
				end

				arg_677_1.text_.text = var_680_1
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_4 = math.max(var_680_0, arg_677_1.talkMaxDuration)

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_4 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - 0) / var_680_4

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= 0 + var_680_4 and arg_677_1.time_ < 0 + var_680_4 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0116c"
	},
	voices = {
		"story_v_out_424061.awb"
	}
}
