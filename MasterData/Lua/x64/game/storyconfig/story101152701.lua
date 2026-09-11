return {
	Play115271001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115271001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115271002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_4_0.name = "ST22"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22

				arg_1_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
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

			if 1.33333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.33333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

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

			local var_4_15 = 2
			local var_4_16 = 1.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115271001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_17) / 52)

				if (52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_17) / 52)) > 0 and var_4_16 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19

					if var_4_19 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_15) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_15 + var_4_20 and arg_1_1.time_ < var_4_15 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115271002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 115271002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play115271003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.275

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(115271002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 51 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 51)

				if (51 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 51)) > 0 and var_10_0 < var_10_3 then
					arg_7_1.talkMaxDuration = var_10_3

					if var_10_3 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_3 + 0
					end
				end

				arg_7_1.text_.text = var_10_1
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_4 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_4

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play115271003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 115271003
		arg_11_1.duration_ = 3.8

		local var_11_0 = {
			ja = 2.933,
			ko = 3.733,
			zh = 2.7,
			en = 3.8
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play115271004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.325

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:GetWordFromCfg(115271003)
				local var_14_2 = arg_11_1:FormatText(var_14_1.content)

				arg_11_1.text_.text = var_14_2

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 13 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_2) / 13)

				if (13 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_2) / 13)) > 0 and var_14_0 < var_14_4 then
					arg_11_1.talkMaxDuration = var_14_4

					if var_14_4 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_4 + 0
					end
				end

				arg_11_1.text_.text = var_14_2
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271003", "story_v_out_115271.awb") ~= 0 then
					local var_14_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271003", "story_v_out_115271.awb") / 1000

					if var_14_5 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + 0
					end

					if var_14_1.prefab_name ~= "" and arg_11_1.actors_[var_14_1.prefab_name] ~= nil then
						local var_14_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_1.prefab_name].transform, "story_v_out_115271", "115271003", "story_v_out_115271.awb")

						arg_11_1:RecordAudio("115271003", var_14_6)
						arg_11_1:RecordAudio("115271003", var_14_6)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_115271", "115271003", "story_v_out_115271.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_115271", "115271003", "story_v_out_115271.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_7 and arg_11_1.time_ < 0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play115271004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 115271004
		arg_15_1.duration_ = 3.8

		local var_15_0 = {
			ja = 3.233,
			ko = 3.8,
			zh = 2.533,
			en = 3.233
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
				arg_15_0:Play115271005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.325

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(115271004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 13 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 13)

				if (13 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 13)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271004", "story_v_out_115271.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271004", "story_v_out_115271.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_115271", "115271004", "story_v_out_115271.awb")

						arg_15_1:RecordAudio("115271004", var_18_6)
						arg_15_1:RecordAudio("115271004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_115271", "115271004", "story_v_out_115271.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_115271", "115271004", "story_v_out_115271.awb")
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
	Play115271005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 115271005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play115271006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 1.15

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(115271005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 46 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 46)

				if (46 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 46)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play115271006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115271006
		arg_23_1.duration_ = 8.13

		local var_23_0 = {
			ja = 3.866,
			ko = 3.6,
			zh = 2.6,
			en = 8.133
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
				arg_23_0:Play115271007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.3

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_1 = arg_23_1:GetWordFromCfg(115271006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 12 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 12)

				if (12 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 12)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271006", "story_v_out_115271.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271006", "story_v_out_115271.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_115271", "115271006", "story_v_out_115271.awb")

						arg_23_1:RecordAudio("115271006", var_26_6)
						arg_23_1:RecordAudio("115271006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115271", "115271006", "story_v_out_115271.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115271", "115271006", "story_v_out_115271.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play115271007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115271007
		arg_27_1.duration_ = 7.13

		local var_27_0 = {
			ja = 4.866,
			ko = 6.5,
			zh = 5.8,
			en = 7.133
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play115271008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.725

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(115271007)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 29 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 29)

				if (29 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 29)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271007", "story_v_out_115271.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271007", "story_v_out_115271.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_115271", "115271007", "story_v_out_115271.awb")

						arg_27_1:RecordAudio("115271007", var_30_6)
						arg_27_1:RecordAudio("115271007", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_115271", "115271007", "story_v_out_115271.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_115271", "115271007", "story_v_out_115271.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115271008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115271008
		arg_31_1.duration_ = 10.37

		local var_31_0 = {
			ja = 8.066,
			ko = 6.566,
			zh = 4.7,
			en = 10.366
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
				arg_31_0:Play115271009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.625

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(115271008)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 25 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 25)

				if (25 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 25)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271008", "story_v_out_115271.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271008", "story_v_out_115271.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_115271", "115271008", "story_v_out_115271.awb")

						arg_31_1:RecordAudio("115271008", var_34_6)
						arg_31_1:RecordAudio("115271008", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_115271", "115271008", "story_v_out_115271.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_115271", "115271008", "story_v_out_115271.awb")
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
	Play115271009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115271009
		arg_35_1.duration_ = 16.6

		local var_35_0 = {
			ja = 7.466,
			ko = 13.3,
			zh = 12.033,
			en = 16.6
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
				arg_35_0:Play115271010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.525

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(115271009)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 61 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 61)

				if (61 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 61)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271009", "story_v_out_115271.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271009", "story_v_out_115271.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_115271", "115271009", "story_v_out_115271.awb")

						arg_35_1:RecordAudio("115271009", var_38_6)
						arg_35_1:RecordAudio("115271009", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_115271", "115271009", "story_v_out_115271.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_115271", "115271009", "story_v_out_115271.awb")
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
	Play115271010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115271010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115271011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.3

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(115271010).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 52 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 52)

				if (52 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 52)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115271011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115271011
		arg_43_1.duration_ = 9

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115271012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.bgs_.F01a == nil then
				local var_46_0 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_46_0.name = "F01a"
				var_46_0.transform.parent = arg_43_1.stage_.transform
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_.F01a = var_46_0
			end

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				local var_46_1 = arg_43_1.bgs_.F01a

				arg_43_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_2 = var_46_1:GetComponent("SpriteRenderer")

				if var_46_2 and var_46_2.sprite then
					local var_46_3 = 2 * (var_46_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_1.transform.localScale = Vector3.New(var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "F01a" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_4 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = false

				arg_43_1:SetGaussion(false)
			end

			local var_46_5 = 2

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_5 then
				local var_46_6 = Color.New(0, 0, 0)

				var_46_6.a = Mathf.Lerp(0, 1, (arg_43_1.time_ - var_46_4) / var_46_5)
				arg_43_1.mask_.color = var_46_6
			end

			if arg_43_1.time_ >= var_46_4 + var_46_5 and arg_43_1.time_ < var_46_4 + var_46_5 + arg_46_0 then
				local var_46_7 = Color.New(0, 0, 0)

				var_46_7.a = 1
				arg_43_1.mask_.color = var_46_7
			end

			local var_46_8 = 2

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = false

				arg_43_1:SetGaussion(false)
			end

			local var_46_9 = 2

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 then
				local var_46_10 = Color.New(0, 0, 0)

				var_46_10.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_8) / var_46_9)
				arg_43_1.mask_.color = var_46_10
			end

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 then
				local var_46_11 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_11.a = 0
				arg_43_1.mask_.color = var_46_11
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:AudioAction("stop", "music", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")

				local var_46_14 = manager.audio:GetAudioName("se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop")

				if "" ~= "" then
					if arg_43_1.bgmTxt_.text ~= var_46_14 and arg_43_1.bgmTxt_.text ~= "" then
						if arg_43_1.bgmTxt2_.text ~= "" then
							arg_43_1.bgmTxt_.text = arg_43_1.bgmTxt2_.text
						end

						arg_43_1.bgmTxt2_.text = var_46_14

						arg_43_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_43_1.bgmTxt_.text = var_46_14
						arg_43_1.bgmTxt2_.text = var_46_14
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

			local var_46_15 = 4
			local var_46_16 = 0.85

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_17 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_17:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_43_1.dialogCg_.alpha = arg_48_0
				end))
				var_46_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(115271011).content)

				arg_43_1.text_.text = var_46_18

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 34 <= 0 and var_46_16 or var_46_16 * (utf8.len(var_46_18) / 34)

				if (34 <= 0 and var_46_16 or var_46_16 * (utf8.len(var_46_18) / 34)) > 0 and var_46_16 < var_46_20 then
					arg_43_1.talkMaxDuration = var_46_20
					var_46_15 = var_46_15 + 0.3

					if var_46_20 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_20 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_18
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_21 = var_46_15 + 0.3
			local var_46_22 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_21 + var_46_22 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_21) / var_46_22

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_21 + var_46_22 and arg_43_1.time_ < var_46_21 + var_46_22 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play115271012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 115271012
		arg_50_1.duration_ = 3.8

		local var_50_0 = {
			ja = 1.7,
			ko = 2.3,
			zh = 2.4,
			en = 3.8
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
				arg_50_0:Play115271013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.actors_["1041_1"] == nil then
				local var_53_0 = Object.Instantiate(arg_50_1.imageGo_, arg_50_1.canvasGo_.transform)

				var_53_0.transform:SetSiblingIndex(1)

				var_53_0.name = "1041_1"

				local var_53_1 = var_53_0:GetComponent(typeof(Image))

				var_53_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1041_1")

				var_53_1:SetNativeSize()

				var_53_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_50_1.actors_["1041_1"] = var_53_0
			end

			local var_53_2 = arg_50_1.actors_["1041_1"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1041_1 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_53_3 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1041_1, Vector3.New(440, -310, -370), (arg_50_1.time_ - 0) / var_53_3)
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(440, -310, -370)
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_4 = arg_50_1.actors_["1041_1"]:GetComponent("Image")

				if var_53_4 then
					arg_50_1.var_.alphaMatValue1041_1 = var_53_4
					arg_50_1.var_.alphaOldValue1041_1 = var_53_4.color.a
				end

				arg_50_1.var_.alphaOldValue1041_1 = 0
			end

			local var_53_5 = 0.5

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_5 then
				if arg_50_1.var_.alphaMatValue1041_1 then
					arg_50_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_50_1.var_.alphaOldValue1041_1, 1, (arg_50_1.time_ - 0) / var_53_5)
					arg_50_1.var_.alphaMatValue1041_1.color = arg_50_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_50_1.time_ >= 0 + var_53_5 and arg_50_1.time_ < 0 + var_53_5 + arg_53_0 and arg_50_1.var_.alphaMatValue1041_1 then
				arg_50_1.var_.alphaMatValue1041_1.color.a = 1
				arg_50_1.var_.alphaMatValue1041_1.color = arg_50_1.var_.alphaMatValue1041_1.color
			end

			local var_53_6 = arg_50_1.actors_["1041_1"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_6) then
				local var_53_7 = var_53_6:GetComponent("Image")

				if var_53_7 then
					arg_50_1.var_.highlightMatValue1041_1 = var_53_7
				end
			end

			local var_53_8 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_8 and not isNil(var_53_6) then
				if arg_50_1.var_.highlightMatValue1041_1 then
					local var_53_9 = Mathf.Lerp(0.5, 1, (arg_50_1.time_ - 0) / var_53_8)

					arg_50_1.var_.highlightMatValue1041_1.color.r = var_53_9
					arg_50_1.var_.highlightMatValue1041_1.color.g = var_53_9
					arg_50_1.var_.highlightMatValue1041_1.color.b = var_53_9
					arg_50_1.var_.highlightMatValue1041_1.color = arg_50_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_50_1.time_ >= 0 + var_53_8 and arg_50_1.time_ < 0 + var_53_8 + arg_53_0 and not isNil(var_53_6) and arg_50_1.var_.highlightMatValue1041_1 then
				var_53_6.transform:SetSiblingIndex(1)

				arg_50_1.var_.highlightMatValue1041_1.color.r = 1
				arg_50_1.var_.highlightMatValue1041_1.color.g = 1
				arg_50_1.var_.highlightMatValue1041_1.color.b = 1
				arg_50_1.var_.highlightMatValue1041_1.color = arg_50_1.var_.highlightMatValue1041_1.color
			end

			local var_53_10 = 0
			local var_53_11 = 0.3

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_12 = arg_50_1:GetWordFromCfg(115271012)
				local var_53_13 = arg_50_1:FormatText(var_53_12.content)

				arg_50_1.text_.text = var_53_13

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_15 = 12 <= 0 and var_53_11 or var_53_11 * (utf8.len(var_53_13) / 12)

				if (12 <= 0 and var_53_11 or var_53_11 * (utf8.len(var_53_13) / 12)) > 0 and var_53_11 < var_53_15 then
					arg_50_1.talkMaxDuration = var_53_15

					if var_53_15 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_15 + var_53_10
					end
				end

				arg_50_1.text_.text = var_53_13
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271012", "story_v_out_115271.awb") ~= 0 then
					local var_53_16 = manager.audio:GetVoiceLength("story_v_out_115271", "115271012", "story_v_out_115271.awb") / 1000

					if var_53_16 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_16 + var_53_10
					end

					if var_53_12.prefab_name ~= "" and arg_50_1.actors_[var_53_12.prefab_name] ~= nil then
						local var_53_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_12.prefab_name].transform, "story_v_out_115271", "115271012", "story_v_out_115271.awb")

						arg_50_1:RecordAudio("115271012", var_53_17)
						arg_50_1:RecordAudio("115271012", var_53_17)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_115271", "115271012", "story_v_out_115271.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_115271", "115271012", "story_v_out_115271.awb")
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
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play115271013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 115271013
		arg_54_1.duration_ = 9.33

		local var_54_0 = {
			ja = 6.733,
			ko = 6.266,
			zh = 5.2,
			en = 9.333
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
				arg_54_0:Play115271014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.actors_["1038"] == nil then
				local var_57_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_57_0) then
					local var_57_1 = Object.Instantiate(var_57_0, arg_54_1.canvasGo_.transform)

					var_57_1.transform:SetSiblingIndex(1)

					var_57_1.name = "1038"
					var_57_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_54_1.actors_["1038"] = var_57_1

					if arg_54_1.isInRecall_ then
						for iter_57_0, iter_57_1 in ipairs((var_57_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_57_1.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_57_2 = arg_54_1.actors_["1038"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1038 = var_57_2.localPosition
				var_57_2.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1038", 2)

				for iter_57_2 = 0, var_57_2.childCount - 1 do
					local var_57_3 = var_57_2:GetChild(iter_57_2)

					if var_57_3.name == "split_1" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_2.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_54_1.time_ - 0) / var_57_4)
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_2.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				local var_57_5 = arg_54_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_57_5 then
					arg_54_1.var_.alphaOldValue1038 = var_57_5.alpha
					arg_54_1.var_.characterEffect1038 = var_57_5
				end

				arg_54_1.var_.alphaOldValue1038 = 0
			end

			local var_57_6 = 0.5

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_6 then
				if arg_54_1.var_.characterEffect1038 then
					arg_54_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_54_1.var_.alphaOldValue1038, 1, (arg_54_1.time_ - 0) / var_57_6)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_6 and arg_54_1.time_ < 0 + var_57_6 + arg_57_0 and arg_54_1.var_.characterEffect1038 then
				arg_54_1.var_.characterEffect1038.alpha = 1
			end

			local var_57_7 = arg_54_1.actors_["1038"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_7) and arg_54_1.var_.actorSpriteComps1038 == nil then
				arg_54_1.var_.actorSpriteComps1038 = var_57_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_8 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_8 and not isNil(var_57_7) then
				if arg_54_1.var_.actorSpriteComps1038 then
					for iter_57_3, iter_57_4 in pairs(arg_54_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_57_4 then
							if arg_54_1.isInRecall_ then
								iter_57_4.color = Color.New(Mathf.Lerp(iter_57_4.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_8), Mathf.Lerp(iter_57_4.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_8), (Mathf.Lerp(iter_57_4.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_8)))
							else
								local var_57_9 = Mathf.Lerp(iter_57_4.color.r, 1, (arg_54_1.time_ - 0) / var_57_8)

								iter_57_4.color = Color.New(var_57_9, var_57_9, var_57_9)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_8 and arg_54_1.time_ < 0 + var_57_8 + arg_57_0 and not isNil(var_57_7) and arg_54_1.var_.actorSpriteComps1038 then
				for iter_57_5, iter_57_6 in pairs(arg_54_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_57_6 then
						iter_57_6.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps1038 = nil
			end

			local var_57_10 = arg_54_1.actors_["1041_1"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_10) then
				local var_57_11 = var_57_10:GetComponent("Image")

				if var_57_11 then
					arg_54_1.var_.highlightMatValue1041_1 = var_57_11
				end
			end

			local var_57_12 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_12 and not isNil(var_57_10) then
				if arg_54_1.var_.highlightMatValue1041_1 then
					local var_57_13 = Mathf.Lerp(1, 0.5, (arg_54_1.time_ - 0) / var_57_12)

					arg_54_1.var_.highlightMatValue1041_1.color.r = var_57_13
					arg_54_1.var_.highlightMatValue1041_1.color.g = var_57_13
					arg_54_1.var_.highlightMatValue1041_1.color.b = var_57_13
					arg_54_1.var_.highlightMatValue1041_1.color = arg_54_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_54_1.time_ >= 0 + var_57_12 and arg_54_1.time_ < 0 + var_57_12 + arg_57_0 and not isNil(var_57_10) and arg_54_1.var_.highlightMatValue1041_1 then
				arg_54_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_54_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_54_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_54_1.var_.highlightMatValue1041_1.color = arg_54_1.var_.highlightMatValue1041_1.color
			end

			local var_57_14 = 0
			local var_57_15 = 0.575

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_16 = arg_54_1:GetWordFromCfg(115271013)
				local var_57_17 = arg_54_1:FormatText(var_57_16.content)

				arg_54_1.text_.text = var_57_17

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_19 = 23 <= 0 and var_57_15 or var_57_15 * (utf8.len(var_57_17) / 23)

				if (23 <= 0 and var_57_15 or var_57_15 * (utf8.len(var_57_17) / 23)) > 0 and var_57_15 < var_57_19 then
					arg_54_1.talkMaxDuration = var_57_19

					if var_57_19 + var_57_14 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_19 + var_57_14
					end
				end

				arg_54_1.text_.text = var_57_17
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271013", "story_v_out_115271.awb") ~= 0 then
					local var_57_20 = manager.audio:GetVoiceLength("story_v_out_115271", "115271013", "story_v_out_115271.awb") / 1000

					if var_57_20 + var_57_14 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_20 + var_57_14
					end

					if var_57_16.prefab_name ~= "" and arg_54_1.actors_[var_57_16.prefab_name] ~= nil then
						local var_57_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_16.prefab_name].transform, "story_v_out_115271", "115271013", "story_v_out_115271.awb")

						arg_54_1:RecordAudio("115271013", var_57_21)
						arg_54_1:RecordAudio("115271013", var_57_21)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_115271", "115271013", "story_v_out_115271.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_115271", "115271013", "story_v_out_115271.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_22 = math.max(var_57_15, arg_54_1.talkMaxDuration)

			if var_57_14 <= arg_54_1.time_ and arg_54_1.time_ < var_57_14 + var_57_22 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_14) / var_57_22

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_14 + var_57_22 and arg_54_1.time_ < var_57_14 + var_57_22 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play115271014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 115271014
		arg_58_1.duration_ = 16.6

		local var_58_0 = {
			ja = 10.366,
			ko = 14.566,
			zh = 12.233,
			en = 16.6
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
				arg_58_0:Play115271015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1038"]) and arg_58_1.var_.actorSpriteComps1038 == nil then
				arg_58_1.var_.actorSpriteComps1038 = arg_58_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1038"]) then
				if arg_58_1.var_.actorSpriteComps1038 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1038"]) and arg_58_1.var_.actorSpriteComps1038 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1038 = nil
			end

			local var_61_2 = arg_58_1.actors_["1041_1"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) then
				local var_61_3 = var_61_2:GetComponent("Image")

				if var_61_3 then
					arg_58_1.var_.highlightMatValue1041_1 = var_61_3
				end
			end

			local var_61_4 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 and not isNil(var_61_2) then
				if arg_58_1.var_.highlightMatValue1041_1 then
					local var_61_5 = Mathf.Lerp(0.5, 1, (arg_58_1.time_ - 0) / var_61_4)

					arg_58_1.var_.highlightMatValue1041_1.color.r = var_61_5
					arg_58_1.var_.highlightMatValue1041_1.color.g = var_61_5
					arg_58_1.var_.highlightMatValue1041_1.color.b = var_61_5
					arg_58_1.var_.highlightMatValue1041_1.color = arg_58_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.highlightMatValue1041_1 then
				var_61_2.transform:SetSiblingIndex(1)

				arg_58_1.var_.highlightMatValue1041_1.color.r = 1
				arg_58_1.var_.highlightMatValue1041_1.color.g = 1
				arg_58_1.var_.highlightMatValue1041_1.color.b = 1
				arg_58_1.var_.highlightMatValue1041_1.color = arg_58_1.var_.highlightMatValue1041_1.color
			end

			local var_61_6 = 0
			local var_61_7 = 1.475

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(115271014)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 59 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 59)

				if (59 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 59)) > 0 and var_61_7 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271014", "story_v_out_115271.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271014", "story_v_out_115271.awb") / 1000

					if var_61_12 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_6
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_115271", "115271014", "story_v_out_115271.awb")

						arg_58_1:RecordAudio("115271014", var_61_13)
						arg_58_1:RecordAudio("115271014", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_115271", "115271014", "story_v_out_115271.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_115271", "115271014", "story_v_out_115271.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play115271015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 115271015
		arg_62_1.duration_ = 11.17

		local var_62_0 = {
			ja = 11.166,
			ko = 7.133,
			zh = 6.466,
			en = 7.866
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
				arg_62_0:Play115271016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.85

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(115271015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 34 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 34)

				if (34 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 34)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271015", "story_v_out_115271.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271015", "story_v_out_115271.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_115271", "115271015", "story_v_out_115271.awb")

						arg_62_1:RecordAudio("115271015", var_65_6)
						arg_62_1:RecordAudio("115271015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_115271", "115271015", "story_v_out_115271.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_115271", "115271015", "story_v_out_115271.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play115271016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 115271016
		arg_66_1.duration_ = 9.1

		local var_66_0 = {
			ja = 6.666,
			ko = 9.1,
			zh = 8.4,
			en = 8.3
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
				arg_66_0:Play115271017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1038"]) and arg_66_1.var_.actorSpriteComps1038 == nil then
				arg_66_1.var_.actorSpriteComps1038 = arg_66_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1038"]) then
				if arg_66_1.var_.actorSpriteComps1038 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 1, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1038"]) and arg_66_1.var_.actorSpriteComps1038 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps1038 = nil
			end

			local var_69_2 = arg_66_1.actors_["1041_1"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) then
				local var_69_3 = var_69_2:GetComponent("Image")

				if var_69_3 then
					arg_66_1.var_.highlightMatValue1041_1 = var_69_3
				end
			end

			local var_69_4 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_2) then
				if arg_66_1.var_.highlightMatValue1041_1 then
					local var_69_5 = Mathf.Lerp(1, 0.5, (arg_66_1.time_ - 0) / var_69_4)

					arg_66_1.var_.highlightMatValue1041_1.color.r = var_69_5
					arg_66_1.var_.highlightMatValue1041_1.color.g = var_69_5
					arg_66_1.var_.highlightMatValue1041_1.color.b = var_69_5
					arg_66_1.var_.highlightMatValue1041_1.color = arg_66_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.highlightMatValue1041_1 then
				arg_66_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_66_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_66_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_66_1.var_.highlightMatValue1041_1.color = arg_66_1.var_.highlightMatValue1041_1.color
			end

			local var_69_6 = 0
			local var_69_7 = 0.9

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_8 = arg_66_1:GetWordFromCfg(115271016)
				local var_69_9 = arg_66_1:FormatText(var_69_8.content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 36 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 36)

				if (36 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 36)) > 0 and var_69_7 < var_69_11 then
					arg_66_1.talkMaxDuration = var_69_11

					if var_69_11 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271016", "story_v_out_115271.awb") ~= 0 then
					local var_69_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271016", "story_v_out_115271.awb") / 1000

					if var_69_12 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_6
					end

					if var_69_8.prefab_name ~= "" and arg_66_1.actors_[var_69_8.prefab_name] ~= nil then
						local var_69_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_8.prefab_name].transform, "story_v_out_115271", "115271016", "story_v_out_115271.awb")

						arg_66_1:RecordAudio("115271016", var_69_13)
						arg_66_1:RecordAudio("115271016", var_69_13)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_115271", "115271016", "story_v_out_115271.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_115271", "115271016", "story_v_out_115271.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play115271017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 115271017
		arg_70_1.duration_ = 7.17

		local var_70_0 = {
			ja = 7.166,
			ko = 2.733,
			zh = 3.466,
			en = 2.933
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
				arg_70_0:Play115271018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1038"]) and arg_70_1.var_.actorSpriteComps1038 == nil then
				arg_70_1.var_.actorSpriteComps1038 = arg_70_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1038"]) then
				if arg_70_1.var_.actorSpriteComps1038 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1038"]) and arg_70_1.var_.actorSpriteComps1038 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps1038 = nil
			end

			local var_73_2 = arg_70_1.actors_["1041_1"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) then
				local var_73_3 = var_73_2:GetComponent("Image")

				if var_73_3 then
					arg_70_1.var_.highlightMatValue1041_1 = var_73_3
				end
			end

			local var_73_4 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_2) then
				if arg_70_1.var_.highlightMatValue1041_1 then
					local var_73_5 = Mathf.Lerp(0.5, 1, (arg_70_1.time_ - 0) / var_73_4)

					arg_70_1.var_.highlightMatValue1041_1.color.r = var_73_5
					arg_70_1.var_.highlightMatValue1041_1.color.g = var_73_5
					arg_70_1.var_.highlightMatValue1041_1.color.b = var_73_5
					arg_70_1.var_.highlightMatValue1041_1.color = arg_70_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.highlightMatValue1041_1 then
				var_73_2.transform:SetSiblingIndex(1)

				arg_70_1.var_.highlightMatValue1041_1.color.r = 1
				arg_70_1.var_.highlightMatValue1041_1.color.g = 1
				arg_70_1.var_.highlightMatValue1041_1.color.b = 1
				arg_70_1.var_.highlightMatValue1041_1.color = arg_70_1.var_.highlightMatValue1041_1.color
			end

			local var_73_6 = 0
			local var_73_7 = 0.425

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(115271017)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 17 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 17)

				if (17 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 17)) > 0 and var_73_7 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271017", "story_v_out_115271.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271017", "story_v_out_115271.awb") / 1000

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_115271", "115271017", "story_v_out_115271.awb")

						arg_70_1:RecordAudio("115271017", var_73_13)
						arg_70_1:RecordAudio("115271017", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_115271", "115271017", "story_v_out_115271.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_115271", "115271017", "story_v_out_115271.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play115271018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 115271018
		arg_74_1.duration_ = 9.53

		local var_74_0 = {
			ja = 9.533,
			ko = 6.7,
			zh = 8.4,
			en = 7.166
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
				arg_74_0:Play115271019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1038 = arg_74_1.actors_["1038"].transform.localPosition
				arg_74_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("1038", 2)

				for iter_77_0 = 0, arg_74_1.actors_["1038"].transform.childCount - 1 do
					local var_77_0 = arg_74_1.actors_["1038"].transform:GetChild(iter_77_0)

					if var_77_0.name == "split_2" or not string.find(var_77_0.name, "split") then
						var_77_0.gameObject:SetActive(true)
					else
						var_77_0.gameObject:SetActive(false)
					end
				end
			end

			local var_77_1 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_1 then
				arg_74_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_74_1.time_ - 0) / var_77_1)
			end

			if arg_74_1.time_ >= 0 + var_77_1 and arg_74_1.time_ < 0 + var_77_1 + arg_77_0 then
				arg_74_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_77_2 = arg_74_1.actors_["1038"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.actorSpriteComps1038 == nil then
				arg_74_1.var_.actorSpriteComps1038 = var_77_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_3 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.actorSpriteComps1038 then
					for iter_77_1, iter_77_2 in pairs(arg_74_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_77_2 then
							if arg_74_1.isInRecall_ then
								iter_77_2.color = Color.New(Mathf.Lerp(iter_77_2.color.r, arg_74_1.hightColor1.r, (arg_74_1.time_ - 0) / var_77_3), Mathf.Lerp(iter_77_2.color.g, arg_74_1.hightColor1.g, (arg_74_1.time_ - 0) / var_77_3), (Mathf.Lerp(iter_77_2.color.b, arg_74_1.hightColor1.b, (arg_74_1.time_ - 0) / var_77_3)))
							else
								local var_77_4 = Mathf.Lerp(iter_77_2.color.r, 1, (arg_74_1.time_ - 0) / var_77_3)

								iter_77_2.color = Color.New(var_77_4, var_77_4, var_77_4)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.actorSpriteComps1038 then
				for iter_77_3, iter_77_4 in pairs(arg_74_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_77_4 then
						iter_77_4.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_74_1.var_.actorSpriteComps1038 = nil
			end

			local var_77_5 = arg_74_1.actors_["1041_1"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_5) then
				local var_77_6 = var_77_5:GetComponent("Image")

				if var_77_6 then
					arg_74_1.var_.highlightMatValue1041_1 = var_77_6
				end
			end

			local var_77_7 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 and not isNil(var_77_5) then
				if arg_74_1.var_.highlightMatValue1041_1 then
					local var_77_8 = Mathf.Lerp(1, 0.5, (arg_74_1.time_ - 0) / var_77_7)

					arg_74_1.var_.highlightMatValue1041_1.color.r = var_77_8
					arg_74_1.var_.highlightMatValue1041_1.color.g = var_77_8
					arg_74_1.var_.highlightMatValue1041_1.color.b = var_77_8
					arg_74_1.var_.highlightMatValue1041_1.color = arg_74_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.highlightMatValue1041_1 then
				arg_74_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_74_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_74_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_74_1.var_.highlightMatValue1041_1.color = arg_74_1.var_.highlightMatValue1041_1.color
			end

			local var_77_9 = arg_74_1.actors_["1038"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.actorSpriteComps1038 == nil then
				arg_74_1.var_.actorSpriteComps1038 = var_77_9:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_10 = 0.0166666666666667

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_10 and not isNil(var_77_9) then
				if arg_74_1.var_.actorSpriteComps1038 then
					for iter_77_5, iter_77_6 in pairs(arg_74_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_77_6 then
							if arg_74_1.isInRecall_ then
								iter_77_6.color = Color.New(Mathf.Lerp(iter_77_6.color.r, arg_74_1.hightColor1.r, (arg_74_1.time_ - 0) / var_77_10), Mathf.Lerp(iter_77_6.color.g, arg_74_1.hightColor1.g, (arg_74_1.time_ - 0) / var_77_10), (Mathf.Lerp(iter_77_6.color.b, arg_74_1.hightColor1.b, (arg_74_1.time_ - 0) / var_77_10)))
							else
								local var_77_11 = Mathf.Lerp(iter_77_6.color.r, 1, (arg_74_1.time_ - 0) / var_77_10)

								iter_77_6.color = Color.New(var_77_11, var_77_11, var_77_11)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_10 and arg_74_1.time_ < 0 + var_77_10 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.actorSpriteComps1038 then
				for iter_77_7, iter_77_8 in pairs(arg_74_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_77_8 then
						iter_77_8.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_74_1.var_.actorSpriteComps1038 = nil
			end

			local var_77_12 = 0
			local var_77_13 = 0.775

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_14 = arg_74_1:GetWordFromCfg(115271018)
				local var_77_15 = arg_74_1:FormatText(var_77_14.content)

				arg_74_1.text_.text = var_77_15

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_17 = 31 <= 0 and var_77_13 or var_77_13 * (utf8.len(var_77_15) / 31)

				if (31 <= 0 and var_77_13 or var_77_13 * (utf8.len(var_77_15) / 31)) > 0 and var_77_13 < var_77_17 then
					arg_74_1.talkMaxDuration = var_77_17

					if var_77_17 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_15
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271018", "story_v_out_115271.awb") ~= 0 then
					local var_77_18 = manager.audio:GetVoiceLength("story_v_out_115271", "115271018", "story_v_out_115271.awb") / 1000

					if var_77_18 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_12
					end

					if var_77_14.prefab_name ~= "" and arg_74_1.actors_[var_77_14.prefab_name] ~= nil then
						local var_77_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_14.prefab_name].transform, "story_v_out_115271", "115271018", "story_v_out_115271.awb")

						arg_74_1:RecordAudio("115271018", var_77_19)
						arg_74_1:RecordAudio("115271018", var_77_19)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_115271", "115271018", "story_v_out_115271.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_115271", "115271018", "story_v_out_115271.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_20 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_20 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_12) / var_77_20

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_12 + var_77_20 and arg_74_1.time_ < var_77_12 + var_77_20 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play115271019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 115271019
		arg_78_1.duration_ = 8.2

		local var_78_0 = {
			ja = 8.2,
			ko = 8.033,
			zh = 7.4,
			en = 4.1
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
				arg_78_0:Play115271020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1038 = arg_78_1.actors_["1038"].transform.localPosition
				arg_78_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1038", 2)

				for iter_81_0 = 0, arg_78_1.actors_["1038"].transform.childCount - 1 do
					local var_81_0 = arg_78_1.actors_["1038"].transform:GetChild(iter_81_0)

					if var_81_0.name == "split_1" or not string.find(var_81_0.name, "split") then
						var_81_0.gameObject:SetActive(true)
					else
						var_81_0.gameObject:SetActive(false)
					end
				end
			end

			local var_81_1 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_1 then
				arg_78_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_78_1.time_ - 0) / var_81_1)
			end

			if arg_78_1.time_ >= 0 + var_81_1 and arg_78_1.time_ < 0 + var_81_1 + arg_81_0 then
				arg_78_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_81_2 = 0
			local var_81_3 = 0.7

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(115271019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 28 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 28)

				if (28 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 28)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271019", "story_v_out_115271.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_115271", "115271019", "story_v_out_115271.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_115271", "115271019", "story_v_out_115271.awb")

						arg_78_1:RecordAudio("115271019", var_81_9)
						arg_78_1:RecordAudio("115271019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_115271", "115271019", "story_v_out_115271.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_115271", "115271019", "story_v_out_115271.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play115271020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 115271020
		arg_82_1.duration_ = 6.5

		local var_82_0 = {
			ja = 5.2,
			ko = 6.5,
			zh = 6.266,
			en = 6.133
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
				arg_82_0:Play115271021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1038"]) and arg_82_1.var_.actorSpriteComps1038 == nil then
				arg_82_1.var_.actorSpriteComps1038 = arg_82_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1038"]) then
				if arg_82_1.var_.actorSpriteComps1038 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 0.5, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1038"]) and arg_82_1.var_.actorSpriteComps1038 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps1038 = nil
			end

			local var_85_2 = arg_82_1.actors_["1041_1"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) then
				local var_85_3 = var_85_2:GetComponent("Image")

				if var_85_3 then
					arg_82_1.var_.highlightMatValue1041_1 = var_85_3
				end
			end

			local var_85_4 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_2) then
				if arg_82_1.var_.highlightMatValue1041_1 then
					local var_85_5 = Mathf.Lerp(0.5, 1, (arg_82_1.time_ - 0) / var_85_4)

					arg_82_1.var_.highlightMatValue1041_1.color.r = var_85_5
					arg_82_1.var_.highlightMatValue1041_1.color.g = var_85_5
					arg_82_1.var_.highlightMatValue1041_1.color.b = var_85_5
					arg_82_1.var_.highlightMatValue1041_1.color = arg_82_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.highlightMatValue1041_1 then
				var_85_2.transform:SetSiblingIndex(1)

				arg_82_1.var_.highlightMatValue1041_1.color.r = 1
				arg_82_1.var_.highlightMatValue1041_1.color.g = 1
				arg_82_1.var_.highlightMatValue1041_1.color.b = 1
				arg_82_1.var_.highlightMatValue1041_1.color = arg_82_1.var_.highlightMatValue1041_1.color
			end

			local var_85_6 = 0
			local var_85_7 = 0.675

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(115271020)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 27 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 27)

				if (27 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 27)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271020", "story_v_out_115271.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271020", "story_v_out_115271.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_115271", "115271020", "story_v_out_115271.awb")

						arg_82_1:RecordAudio("115271020", var_85_13)
						arg_82_1:RecordAudio("115271020", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_115271", "115271020", "story_v_out_115271.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_115271", "115271020", "story_v_out_115271.awb")
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

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play115271021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 115271021
		arg_86_1.duration_ = 13.4

		local var_86_0 = {
			ja = 13.4,
			ko = 12.466,
			zh = 12.333,
			en = 12.6
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
				arg_86_0:Play115271022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.425

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(115271021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 57 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 57)

				if (57 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 57)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271021", "story_v_out_115271.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271021", "story_v_out_115271.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_115271", "115271021", "story_v_out_115271.awb")

						arg_86_1:RecordAudio("115271021", var_89_6)
						arg_86_1:RecordAudio("115271021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_115271", "115271021", "story_v_out_115271.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_115271", "115271021", "story_v_out_115271.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play115271022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 115271022
		arg_90_1.duration_ = 12.23

		local var_90_0 = {
			ja = 8.7,
			ko = 7.5,
			zh = 8.8,
			en = 12.233
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
				arg_90_0:Play115271023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.175

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(115271022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 47 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 47)

				if (47 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 47)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271022", "story_v_out_115271.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271022", "story_v_out_115271.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_115271", "115271022", "story_v_out_115271.awb")

						arg_90_1:RecordAudio("115271022", var_93_6)
						arg_90_1:RecordAudio("115271022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_115271", "115271022", "story_v_out_115271.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_115271", "115271022", "story_v_out_115271.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play115271023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 115271023
		arg_94_1.duration_ = 2.87

		local var_94_0 = {
			ja = 2.866,
			ko = 2.6,
			zh = 2.866,
			en = 2.466
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
				arg_94_0:Play115271024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1038"]) and arg_94_1.var_.actorSpriteComps1038 == nil then
				arg_94_1.var_.actorSpriteComps1038 = arg_94_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1038"]) then
				if arg_94_1.var_.actorSpriteComps1038 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 1, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1038"]) and arg_94_1.var_.actorSpriteComps1038 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps1038 = nil
			end

			local var_97_2 = arg_94_1.actors_["1041_1"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) then
				local var_97_3 = var_97_2:GetComponent("Image")

				if var_97_3 then
					arg_94_1.var_.highlightMatValue1041_1 = var_97_3
				end
			end

			local var_97_4 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_2) then
				if arg_94_1.var_.highlightMatValue1041_1 then
					local var_97_5 = Mathf.Lerp(1, 0.5, (arg_94_1.time_ - 0) / var_97_4)

					arg_94_1.var_.highlightMatValue1041_1.color.r = var_97_5
					arg_94_1.var_.highlightMatValue1041_1.color.g = var_97_5
					arg_94_1.var_.highlightMatValue1041_1.color.b = var_97_5
					arg_94_1.var_.highlightMatValue1041_1.color = arg_94_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.highlightMatValue1041_1 then
				arg_94_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_94_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_94_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_94_1.var_.highlightMatValue1041_1.color = arg_94_1.var_.highlightMatValue1041_1.color
			end

			local var_97_6 = arg_94_1.actors_["1038"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1038 = var_97_6.localPosition
				var_97_6.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1038", 2)

				for iter_97_4 = 0, var_97_6.childCount - 1 do
					local var_97_7 = var_97_6:GetChild(iter_97_4)

					if var_97_7.name == "split_9" or not string.find(var_97_7.name, "split") then
						var_97_7.gameObject:SetActive(true)
					else
						var_97_7.gameObject:SetActive(false)
					end
				end
			end

			local var_97_8 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_8 then
				var_97_6.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_94_1.time_ - 0) / var_97_8)
			end

			if arg_94_1.time_ >= 0 + var_97_8 and arg_94_1.time_ < 0 + var_97_8 + arg_97_0 then
				var_97_6.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_97_9 = 0
			local var_97_10 = 0.2

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_11 = arg_94_1:GetWordFromCfg(115271023)
				local var_97_12 = arg_94_1:FormatText(var_97_11.content)

				arg_94_1.text_.text = var_97_12

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_14 = 8 <= 0 and var_97_10 or var_97_10 * (utf8.len(var_97_12) / 8)

				if (8 <= 0 and var_97_10 or var_97_10 * (utf8.len(var_97_12) / 8)) > 0 and var_97_10 < var_97_14 then
					arg_94_1.talkMaxDuration = var_97_14

					if var_97_14 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_9
					end
				end

				arg_94_1.text_.text = var_97_12
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271023", "story_v_out_115271.awb") ~= 0 then
					local var_97_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271023", "story_v_out_115271.awb") / 1000

					if var_97_15 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_9
					end

					if var_97_11.prefab_name ~= "" and arg_94_1.actors_[var_97_11.prefab_name] ~= nil then
						local var_97_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_11.prefab_name].transform, "story_v_out_115271", "115271023", "story_v_out_115271.awb")

						arg_94_1:RecordAudio("115271023", var_97_16)
						arg_94_1:RecordAudio("115271023", var_97_16)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_115271", "115271023", "story_v_out_115271.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_115271", "115271023", "story_v_out_115271.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_17 = math.max(var_97_10, arg_94_1.talkMaxDuration)

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_17 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_9) / var_97_17

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_9 + var_97_17 and arg_94_1.time_ < var_97_9 + var_97_17 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play115271024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 115271024
		arg_98_1.duration_ = 11.9

		local var_98_0 = {
			ja = 11.9,
			ko = 4.533,
			zh = 6.4,
			en = 5.6
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
				arg_98_0:Play115271025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.675

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(115271024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 27 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 27)

				if (27 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 27)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271024", "story_v_out_115271.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271024", "story_v_out_115271.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_115271", "115271024", "story_v_out_115271.awb")

						arg_98_1:RecordAudio("115271024", var_101_6)
						arg_98_1:RecordAudio("115271024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_115271", "115271024", "story_v_out_115271.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_115271", "115271024", "story_v_out_115271.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play115271025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 115271025
		arg_102_1.duration_ = 13.6

		local var_102_0 = {
			ja = 10.1,
			ko = 9.833,
			zh = 8.333,
			en = 13.6
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
				arg_102_0:Play115271026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1038"]) and arg_102_1.var_.actorSpriteComps1038 == nil then
				arg_102_1.var_.actorSpriteComps1038 = arg_102_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1038"]) then
				if arg_102_1.var_.actorSpriteComps1038 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1038"]) and arg_102_1.var_.actorSpriteComps1038 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps1038 = nil
			end

			local var_105_2 = arg_102_1.actors_["1041_1"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) then
				local var_105_3 = var_105_2:GetComponent("Image")

				if var_105_3 then
					arg_102_1.var_.highlightMatValue1041_1 = var_105_3
				end
			end

			local var_105_4 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 and not isNil(var_105_2) then
				if arg_102_1.var_.highlightMatValue1041_1 then
					local var_105_5 = Mathf.Lerp(0.5, 1, (arg_102_1.time_ - 0) / var_105_4)

					arg_102_1.var_.highlightMatValue1041_1.color.r = var_105_5
					arg_102_1.var_.highlightMatValue1041_1.color.g = var_105_5
					arg_102_1.var_.highlightMatValue1041_1.color.b = var_105_5
					arg_102_1.var_.highlightMatValue1041_1.color = arg_102_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.highlightMatValue1041_1 then
				var_105_2.transform:SetSiblingIndex(1)

				arg_102_1.var_.highlightMatValue1041_1.color.r = 1
				arg_102_1.var_.highlightMatValue1041_1.color.g = 1
				arg_102_1.var_.highlightMatValue1041_1.color.b = 1
				arg_102_1.var_.highlightMatValue1041_1.color = arg_102_1.var_.highlightMatValue1041_1.color
			end

			local var_105_6 = 0
			local var_105_7 = 0.95

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(115271025)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 38 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 38)

				if (38 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 38)) > 0 and var_105_7 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271025", "story_v_out_115271.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271025", "story_v_out_115271.awb") / 1000

					if var_105_12 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_6
					end

					if var_105_8.prefab_name ~= "" and arg_102_1.actors_[var_105_8.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_8.prefab_name].transform, "story_v_out_115271", "115271025", "story_v_out_115271.awb")

						arg_102_1:RecordAudio("115271025", var_105_13)
						arg_102_1:RecordAudio("115271025", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_115271", "115271025", "story_v_out_115271.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_115271", "115271025", "story_v_out_115271.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play115271026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 115271026
		arg_106_1.duration_ = 14

		local var_106_0 = {
			ja = 14,
			ko = 12.5,
			zh = 12,
			en = 12.866
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
				arg_106_0:Play115271027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.6

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(115271026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 64 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 64)

				if (64 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 64)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271026", "story_v_out_115271.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271026", "story_v_out_115271.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_115271", "115271026", "story_v_out_115271.awb")

						arg_106_1:RecordAudio("115271026", var_109_6)
						arg_106_1:RecordAudio("115271026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_115271", "115271026", "story_v_out_115271.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_115271", "115271026", "story_v_out_115271.awb")
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
	Play115271027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 115271027
		arg_110_1.duration_ = 15.53

		local var_110_0 = {
			ja = 10.6,
			ko = 10.833,
			zh = 10.933,
			en = 15.533
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
				arg_110_0:Play115271028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 1.375

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(115271027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 55 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 55)

				if (55 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 55)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271027", "story_v_out_115271.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271027", "story_v_out_115271.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_115271", "115271027", "story_v_out_115271.awb")

						arg_110_1:RecordAudio("115271027", var_113_6)
						arg_110_1:RecordAudio("115271027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_115271", "115271027", "story_v_out_115271.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_115271", "115271027", "story_v_out_115271.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play115271028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 115271028
		arg_114_1.duration_ = 6.3

		local var_114_0 = {
			ja = 6.3,
			ko = 3.266,
			zh = 4.233,
			en = 3.266
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
				arg_114_0:Play115271029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1038 = arg_114_1.actors_["1038"].transform.localPosition
				arg_114_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("1038", 2)

				for iter_117_0 = 0, arg_114_1.actors_["1038"].transform.childCount - 1 do
					local var_117_0 = arg_114_1.actors_["1038"].transform:GetChild(iter_117_0)

					if var_117_0.name == "split_5" or not string.find(var_117_0.name, "split") then
						var_117_0.gameObject:SetActive(true)
					else
						var_117_0.gameObject:SetActive(false)
					end
				end
			end

			local var_117_1 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 then
				arg_114_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_114_1.time_ - 0) / var_117_1)
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 then
				arg_114_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_117_2 = arg_114_1.actors_["1038"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.actorSpriteComps1038 == nil then
				arg_114_1.var_.actorSpriteComps1038 = var_117_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_3 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.actorSpriteComps1038 then
					for iter_117_1, iter_117_2 in pairs(arg_114_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_117_2 then
							if arg_114_1.isInRecall_ then
								iter_117_2.color = Color.New(Mathf.Lerp(iter_117_2.color.r, arg_114_1.hightColor1.r, (arg_114_1.time_ - 0) / var_117_3), Mathf.Lerp(iter_117_2.color.g, arg_114_1.hightColor1.g, (arg_114_1.time_ - 0) / var_117_3), (Mathf.Lerp(iter_117_2.color.b, arg_114_1.hightColor1.b, (arg_114_1.time_ - 0) / var_117_3)))
							else
								local var_117_4 = Mathf.Lerp(iter_117_2.color.r, 1, (arg_114_1.time_ - 0) / var_117_3)

								iter_117_2.color = Color.New(var_117_4, var_117_4, var_117_4)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.actorSpriteComps1038 then
				for iter_117_3, iter_117_4 in pairs(arg_114_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_117_4 then
						iter_117_4.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_114_1.var_.actorSpriteComps1038 = nil
			end

			local var_117_5 = arg_114_1.actors_["1041_1"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_5) then
				local var_117_6 = var_117_5:GetComponent("Image")

				if var_117_6 then
					arg_114_1.var_.highlightMatValue1041_1 = var_117_6
				end
			end

			local var_117_7 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 and not isNil(var_117_5) then
				if arg_114_1.var_.highlightMatValue1041_1 then
					local var_117_8 = Mathf.Lerp(1, 0.5, (arg_114_1.time_ - 0) / var_117_7)

					arg_114_1.var_.highlightMatValue1041_1.color.r = var_117_8
					arg_114_1.var_.highlightMatValue1041_1.color.g = var_117_8
					arg_114_1.var_.highlightMatValue1041_1.color.b = var_117_8
					arg_114_1.var_.highlightMatValue1041_1.color = arg_114_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.highlightMatValue1041_1 then
				arg_114_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_114_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_114_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_114_1.var_.highlightMatValue1041_1.color = arg_114_1.var_.highlightMatValue1041_1.color
			end

			local var_117_9 = 0
			local var_117_10 = 0.25

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_11 = arg_114_1:GetWordFromCfg(115271028)
				local var_117_12 = arg_114_1:FormatText(var_117_11.content)

				arg_114_1.text_.text = var_117_12

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_14 = 10 <= 0 and var_117_10 or var_117_10 * (utf8.len(var_117_12) / 10)

				if (10 <= 0 and var_117_10 or var_117_10 * (utf8.len(var_117_12) / 10)) > 0 and var_117_10 < var_117_14 then
					arg_114_1.talkMaxDuration = var_117_14

					if var_117_14 + var_117_9 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_14 + var_117_9
					end
				end

				arg_114_1.text_.text = var_117_12
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271028", "story_v_out_115271.awb") ~= 0 then
					local var_117_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271028", "story_v_out_115271.awb") / 1000

					if var_117_15 + var_117_9 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_9
					end

					if var_117_11.prefab_name ~= "" and arg_114_1.actors_[var_117_11.prefab_name] ~= nil then
						local var_117_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_11.prefab_name].transform, "story_v_out_115271", "115271028", "story_v_out_115271.awb")

						arg_114_1:RecordAudio("115271028", var_117_16)
						arg_114_1:RecordAudio("115271028", var_117_16)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_115271", "115271028", "story_v_out_115271.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_115271", "115271028", "story_v_out_115271.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_17 = math.max(var_117_10, arg_114_1.talkMaxDuration)

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_17 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_9) / var_117_17

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_9 + var_117_17 and arg_114_1.time_ < var_117_9 + var_117_17 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play115271029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 115271029
		arg_118_1.duration_ = 3.8

		local var_118_0 = {
			ja = 3.1,
			ko = 2.633,
			zh = 2.733,
			en = 3.8
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
				arg_118_0:Play115271030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1038"]) and arg_118_1.var_.actorSpriteComps1038 == nil then
				arg_118_1.var_.actorSpriteComps1038 = arg_118_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1038"]) then
				if arg_118_1.var_.actorSpriteComps1038 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 0.5, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1038"]) and arg_118_1.var_.actorSpriteComps1038 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_118_1.var_.actorSpriteComps1038 = nil
			end

			local var_121_2 = arg_118_1.actors_["1041_1"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) then
				local var_121_3 = var_121_2:GetComponent("Image")

				if var_121_3 then
					arg_118_1.var_.highlightMatValue1041_1 = var_121_3
				end
			end

			local var_121_4 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 and not isNil(var_121_2) then
				if arg_118_1.var_.highlightMatValue1041_1 then
					local var_121_5 = Mathf.Lerp(0.5, 1, (arg_118_1.time_ - 0) / var_121_4)

					arg_118_1.var_.highlightMatValue1041_1.color.r = var_121_5
					arg_118_1.var_.highlightMatValue1041_1.color.g = var_121_5
					arg_118_1.var_.highlightMatValue1041_1.color.b = var_121_5
					arg_118_1.var_.highlightMatValue1041_1.color = arg_118_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.highlightMatValue1041_1 then
				var_121_2.transform:SetSiblingIndex(1)

				arg_118_1.var_.highlightMatValue1041_1.color.r = 1
				arg_118_1.var_.highlightMatValue1041_1.color.g = 1
				arg_118_1.var_.highlightMatValue1041_1.color.b = 1
				arg_118_1.var_.highlightMatValue1041_1.color = arg_118_1.var_.highlightMatValue1041_1.color
			end

			local var_121_6 = 0
			local var_121_7 = 0.3

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(115271029)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 12 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 12)

				if (12 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 12)) > 0 and var_121_7 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11

					if var_121_11 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271029", "story_v_out_115271.awb") ~= 0 then
					local var_121_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271029", "story_v_out_115271.awb") / 1000

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end

					if var_121_8.prefab_name ~= "" and arg_118_1.actors_[var_121_8.prefab_name] ~= nil then
						local var_121_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_8.prefab_name].transform, "story_v_out_115271", "115271029", "story_v_out_115271.awb")

						arg_118_1:RecordAudio("115271029", var_121_13)
						arg_118_1:RecordAudio("115271029", var_121_13)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_115271", "115271029", "story_v_out_115271.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_115271", "115271029", "story_v_out_115271.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play115271030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 115271030
		arg_122_1.duration_ = 11.57

		local var_122_0 = {
			ja = 10.2,
			ko = 8.4,
			zh = 8.366,
			en = 11.566
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
				arg_122_0:Play115271031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1038 = arg_122_1.actors_["1038"].transform.localPosition
				arg_122_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("1038", 2)

				for iter_125_0 = 0, arg_122_1.actors_["1038"].transform.childCount - 1 do
					local var_125_0 = arg_122_1.actors_["1038"].transform:GetChild(iter_125_0)

					if var_125_0.name == "split_1" or not string.find(var_125_0.name, "split") then
						var_125_0.gameObject:SetActive(true)
					else
						var_125_0.gameObject:SetActive(false)
					end
				end
			end

			local var_125_1 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_1 then
				arg_122_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_122_1.time_ - 0) / var_125_1)
			end

			if arg_122_1.time_ >= 0 + var_125_1 and arg_122_1.time_ < 0 + var_125_1 + arg_125_0 then
				arg_122_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_125_2 = arg_122_1.actors_["1038"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps1038 == nil then
				arg_122_1.var_.actorSpriteComps1038 = var_125_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_3 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.actorSpriteComps1038 then
					for iter_125_1, iter_125_2 in pairs(arg_122_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_125_2 then
							if arg_122_1.isInRecall_ then
								iter_125_2.color = Color.New(Mathf.Lerp(iter_125_2.color.r, arg_122_1.hightColor1.r, (arg_122_1.time_ - 0) / var_125_3), Mathf.Lerp(iter_125_2.color.g, arg_122_1.hightColor1.g, (arg_122_1.time_ - 0) / var_125_3), (Mathf.Lerp(iter_125_2.color.b, arg_122_1.hightColor1.b, (arg_122_1.time_ - 0) / var_125_3)))
							else
								local var_125_4 = Mathf.Lerp(iter_125_2.color.r, 1, (arg_122_1.time_ - 0) / var_125_3)

								iter_125_2.color = Color.New(var_125_4, var_125_4, var_125_4)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps1038 then
				for iter_125_3, iter_125_4 in pairs(arg_122_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_125_4 then
						iter_125_4.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps1038 = nil
			end

			local var_125_5 = arg_122_1.actors_["1041_1"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_5) then
				local var_125_6 = var_125_5:GetComponent("Image")

				if var_125_6 then
					arg_122_1.var_.highlightMatValue1041_1 = var_125_6
				end
			end

			local var_125_7 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 and not isNil(var_125_5) then
				if arg_122_1.var_.highlightMatValue1041_1 then
					local var_125_8 = Mathf.Lerp(1, 0.5, (arg_122_1.time_ - 0) / var_125_7)

					arg_122_1.var_.highlightMatValue1041_1.color.r = var_125_8
					arg_122_1.var_.highlightMatValue1041_1.color.g = var_125_8
					arg_122_1.var_.highlightMatValue1041_1.color.b = var_125_8
					arg_122_1.var_.highlightMatValue1041_1.color = arg_122_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.highlightMatValue1041_1 then
				arg_122_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_122_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_122_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_122_1.var_.highlightMatValue1041_1.color = arg_122_1.var_.highlightMatValue1041_1.color
			end

			local var_125_9 = 0
			local var_125_10 = 0.8

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_11 = arg_122_1:GetWordFromCfg(115271030)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_14 = 32 <= 0 and var_125_10 or var_125_10 * (utf8.len(var_125_12) / 32)

				if (32 <= 0 and var_125_10 or var_125_10 * (utf8.len(var_125_12) / 32)) > 0 and var_125_10 < var_125_14 then
					arg_122_1.talkMaxDuration = var_125_14

					if var_125_14 + var_125_9 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_9
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271030", "story_v_out_115271.awb") ~= 0 then
					local var_125_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271030", "story_v_out_115271.awb") / 1000

					if var_125_15 + var_125_9 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_9
					end

					if var_125_11.prefab_name ~= "" and arg_122_1.actors_[var_125_11.prefab_name] ~= nil then
						local var_125_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_11.prefab_name].transform, "story_v_out_115271", "115271030", "story_v_out_115271.awb")

						arg_122_1:RecordAudio("115271030", var_125_16)
						arg_122_1:RecordAudio("115271030", var_125_16)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_115271", "115271030", "story_v_out_115271.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_115271", "115271030", "story_v_out_115271.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_17 = math.max(var_125_10, arg_122_1.talkMaxDuration)

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_17 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_9) / var_125_17

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_9 + var_125_17 and arg_122_1.time_ < var_125_9 + var_125_17 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play115271031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 115271031
		arg_126_1.duration_ = 4.93

		local var_126_0 = {
			ja = 3.666,
			ko = 4,
			zh = 4.433,
			en = 4.933
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play115271032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1038"]) and arg_126_1.var_.actorSpriteComps1038 == nil then
				arg_126_1.var_.actorSpriteComps1038 = arg_126_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1038"]) then
				if arg_126_1.var_.actorSpriteComps1038 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1038"]) and arg_126_1.var_.actorSpriteComps1038 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps1038 = nil
			end

			local var_129_2 = arg_126_1.actors_["1041_1"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) then
				local var_129_3 = var_129_2:GetComponent("Image")

				if var_129_3 then
					arg_126_1.var_.highlightMatValue1041_1 = var_129_3
				end
			end

			local var_129_4 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 and not isNil(var_129_2) then
				if arg_126_1.var_.highlightMatValue1041_1 then
					local var_129_5 = Mathf.Lerp(0.5, 1, (arg_126_1.time_ - 0) / var_129_4)

					arg_126_1.var_.highlightMatValue1041_1.color.r = var_129_5
					arg_126_1.var_.highlightMatValue1041_1.color.g = var_129_5
					arg_126_1.var_.highlightMatValue1041_1.color.b = var_129_5
					arg_126_1.var_.highlightMatValue1041_1.color = arg_126_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.highlightMatValue1041_1 then
				var_129_2.transform:SetSiblingIndex(1)

				arg_126_1.var_.highlightMatValue1041_1.color.r = 1
				arg_126_1.var_.highlightMatValue1041_1.color.g = 1
				arg_126_1.var_.highlightMatValue1041_1.color.b = 1
				arg_126_1.var_.highlightMatValue1041_1.color = arg_126_1.var_.highlightMatValue1041_1.color
			end

			local var_129_6 = 0
			local var_129_7 = 0.4

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_8 = arg_126_1:GetWordFromCfg(115271031)
				local var_129_9 = arg_126_1:FormatText(var_129_8.content)

				arg_126_1.text_.text = var_129_9

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 16 <= 0 and var_129_7 or var_129_7 * (utf8.len(var_129_9) / 16)

				if (16 <= 0 and var_129_7 or var_129_7 * (utf8.len(var_129_9) / 16)) > 0 and var_129_7 < var_129_11 then
					arg_126_1.talkMaxDuration = var_129_11

					if var_129_11 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_11 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_9
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271031", "story_v_out_115271.awb") ~= 0 then
					local var_129_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271031", "story_v_out_115271.awb") / 1000

					if var_129_12 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_12 + var_129_6
					end

					if var_129_8.prefab_name ~= "" and arg_126_1.actors_[var_129_8.prefab_name] ~= nil then
						local var_129_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_8.prefab_name].transform, "story_v_out_115271", "115271031", "story_v_out_115271.awb")

						arg_126_1:RecordAudio("115271031", var_129_13)
						arg_126_1:RecordAudio("115271031", var_129_13)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_115271", "115271031", "story_v_out_115271.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_115271", "115271031", "story_v_out_115271.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play115271032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 115271032
		arg_130_1.duration_ = 12.1

		local var_130_0 = {
			ja = 9.366,
			ko = 8.766,
			zh = 9.266,
			en = 12.1
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
				arg_130_0:Play115271033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 1.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:GetWordFromCfg(115271032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 50 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 50)

				if (50 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 50)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271032", "story_v_out_115271.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271032", "story_v_out_115271.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_115271", "115271032", "story_v_out_115271.awb")

						arg_130_1:RecordAudio("115271032", var_133_6)
						arg_130_1:RecordAudio("115271032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_115271", "115271032", "story_v_out_115271.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_115271", "115271032", "story_v_out_115271.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play115271033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 115271033
		arg_134_1.duration_ = 6

		local var_134_0 = {
			ja = 6,
			ko = 5.666,
			zh = 5.833,
			en = 4.7
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
				arg_134_0:Play115271034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1038"]) and arg_134_1.var_.actorSpriteComps1038 == nil then
				arg_134_1.var_.actorSpriteComps1038 = arg_134_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1038"]) then
				if arg_134_1.var_.actorSpriteComps1038 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								iter_137_1.color = Color.New(Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, (arg_134_1.time_ - 0) / var_137_0), Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, (arg_134_1.time_ - 0) / var_137_0), (Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, (arg_134_1.time_ - 0) / var_137_0)))
							else
								local var_137_1 = Mathf.Lerp(iter_137_1.color.r, 1, (arg_134_1.time_ - 0) / var_137_0)

								iter_137_1.color = Color.New(var_137_1, var_137_1, var_137_1)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1038"]) and arg_134_1.var_.actorSpriteComps1038 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_137_3 then
						iter_137_3.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_134_1.var_.actorSpriteComps1038 = nil
			end

			local var_137_2 = arg_134_1.actors_["1041_1"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) then
				local var_137_3 = var_137_2:GetComponent("Image")

				if var_137_3 then
					arg_134_1.var_.highlightMatValue1041_1 = var_137_3
				end
			end

			local var_137_4 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 and not isNil(var_137_2) then
				if arg_134_1.var_.highlightMatValue1041_1 then
					local var_137_5 = Mathf.Lerp(1, 0.5, (arg_134_1.time_ - 0) / var_137_4)

					arg_134_1.var_.highlightMatValue1041_1.color.r = var_137_5
					arg_134_1.var_.highlightMatValue1041_1.color.g = var_137_5
					arg_134_1.var_.highlightMatValue1041_1.color.b = var_137_5
					arg_134_1.var_.highlightMatValue1041_1.color = arg_134_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.highlightMatValue1041_1 then
				arg_134_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_134_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_134_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_134_1.var_.highlightMatValue1041_1.color = arg_134_1.var_.highlightMatValue1041_1.color
			end

			local var_137_6 = arg_134_1.actors_["1038"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1038 = var_137_6.localPosition
				var_137_6.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("1038", 2)

				for iter_137_4 = 0, var_137_6.childCount - 1 do
					local var_137_7 = var_137_6:GetChild(iter_137_4)

					if var_137_7.name == "split_2" or not string.find(var_137_7.name, "split") then
						var_137_7.gameObject:SetActive(true)
					else
						var_137_7.gameObject:SetActive(false)
					end
				end
			end

			local var_137_8 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_8 then
				var_137_6.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_134_1.time_ - 0) / var_137_8)
			end

			if arg_134_1.time_ >= 0 + var_137_8 and arg_134_1.time_ < 0 + var_137_8 + arg_137_0 then
				var_137_6.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_137_9 = 0
			local var_137_10 = 0.575

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_11 = arg_134_1:GetWordFromCfg(115271033)
				local var_137_12 = arg_134_1:FormatText(var_137_11.content)

				arg_134_1.text_.text = var_137_12

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_14 = 23 <= 0 and var_137_10 or var_137_10 * (utf8.len(var_137_12) / 23)

				if (23 <= 0 and var_137_10 or var_137_10 * (utf8.len(var_137_12) / 23)) > 0 and var_137_10 < var_137_14 then
					arg_134_1.talkMaxDuration = var_137_14

					if var_137_14 + var_137_9 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_9
					end
				end

				arg_134_1.text_.text = var_137_12
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271033", "story_v_out_115271.awb") ~= 0 then
					local var_137_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271033", "story_v_out_115271.awb") / 1000

					if var_137_15 + var_137_9 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_15 + var_137_9
					end

					if var_137_11.prefab_name ~= "" and arg_134_1.actors_[var_137_11.prefab_name] ~= nil then
						local var_137_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_11.prefab_name].transform, "story_v_out_115271", "115271033", "story_v_out_115271.awb")

						arg_134_1:RecordAudio("115271033", var_137_16)
						arg_134_1:RecordAudio("115271033", var_137_16)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_115271", "115271033", "story_v_out_115271.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_115271", "115271033", "story_v_out_115271.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_17 = math.max(var_137_10, arg_134_1.talkMaxDuration)

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_17 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_9) / var_137_17

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_9 + var_137_17 and arg_134_1.time_ < var_137_9 + var_137_17 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play115271034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 115271034
		arg_138_1.duration_ = 11.13

		local var_138_0 = {
			ja = 11.133,
			ko = 7.633,
			zh = 7.333,
			en = 9.666
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
				arg_138_0:Play115271035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1038 = arg_138_1.actors_["1038"].transform.localPosition
				arg_138_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("1038", 2)

				for iter_141_0 = 0, arg_138_1.actors_["1038"].transform.childCount - 1 do
					local var_141_0 = arg_138_1.actors_["1038"].transform:GetChild(iter_141_0)

					if var_141_0.name == "split_7" or not string.find(var_141_0.name, "split") then
						var_141_0.gameObject:SetActive(true)
					else
						var_141_0.gameObject:SetActive(false)
					end
				end
			end

			local var_141_1 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 then
				arg_138_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_138_1.time_ - 0) / var_141_1)
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 then
				arg_138_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_141_2 = arg_138_1.actors_["1038"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1038 == nil then
				arg_138_1.var_.actorSpriteComps1038 = var_141_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_3 = 0.034

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.actorSpriteComps1038 then
					for iter_141_1, iter_141_2 in pairs(arg_138_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_141_2 then
							if arg_138_1.isInRecall_ then
								iter_141_2.color = Color.New(Mathf.Lerp(iter_141_2.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_3), Mathf.Lerp(iter_141_2.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_3), (Mathf.Lerp(iter_141_2.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_3)))
							else
								local var_141_4 = Mathf.Lerp(iter_141_2.color.r, 1, (arg_138_1.time_ - 0) / var_141_3)

								iter_141_2.color = Color.New(var_141_4, var_141_4, var_141_4)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1038 then
				for iter_141_3, iter_141_4 in pairs(arg_138_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_141_4 then
						iter_141_4.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps1038 = nil
			end

			local var_141_5 = 0
			local var_141_6 = 0.75

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(115271034)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 30 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 30)

				if (30 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 30)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271034", "story_v_out_115271.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271034", "story_v_out_115271.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_115271", "115271034", "story_v_out_115271.awb")

						arg_138_1:RecordAudio("115271034", var_141_12)
						arg_138_1:RecordAudio("115271034", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_115271", "115271034", "story_v_out_115271.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_115271", "115271034", "story_v_out_115271.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play115271035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 115271035
		arg_142_1.duration_ = 9.93

		local var_142_0 = {
			ja = 9.933,
			ko = 7.4,
			zh = 9.733,
			en = 7.633
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
				arg_142_0:Play115271036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1038 = arg_142_1.actors_["1038"].transform.localPosition
				arg_142_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1038", 2)

				for iter_145_0 = 0, arg_142_1.actors_["1038"].transform.childCount - 1 do
					local var_145_0 = arg_142_1.actors_["1038"].transform:GetChild(iter_145_0)

					if var_145_0.name == "split_1" or not string.find(var_145_0.name, "split") then
						var_145_0.gameObject:SetActive(true)
					else
						var_145_0.gameObject:SetActive(false)
					end
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_142_1.time_ - 0) / var_145_1)
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_145_2 = 0
			local var_145_3 = 0.8

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(115271035)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 32 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 32)

				if (32 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 32)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271035", "story_v_out_115271.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_115271", "115271035", "story_v_out_115271.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_115271", "115271035", "story_v_out_115271.awb")

						arg_142_1:RecordAudio("115271035", var_145_9)
						arg_142_1:RecordAudio("115271035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_115271", "115271035", "story_v_out_115271.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_115271", "115271035", "story_v_out_115271.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play115271036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 115271036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play115271037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1038"]) and arg_146_1.var_.actorSpriteComps1038 == nil then
				arg_146_1.var_.actorSpriteComps1038 = arg_146_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1038"]) then
				if arg_146_1.var_.actorSpriteComps1038 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								iter_149_1.color = Color.New(Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_0), Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_0), (Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_0)))
							else
								local var_149_1 = Mathf.Lerp(iter_149_1.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_0)

								iter_149_1.color = Color.New(var_149_1, var_149_1, var_149_1)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1038"]) and arg_146_1.var_.actorSpriteComps1038 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps1038 = nil
			end

			local var_149_2 = 0
			local var_149_3 = 0.625

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_4 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(115271036).content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_6 = 25 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 25)

				if (25 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 25)) > 0 and var_149_3 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_7 and arg_146_1.time_ < var_149_2 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play115271037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 115271037
		arg_150_1.duration_ = 12

		local var_150_0 = {
			ja = 7.266,
			ko = 8.5,
			zh = 7.333,
			en = 12
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play115271038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1041_1"]) then
				local var_153_0 = arg_150_1.actors_["1041_1"]:GetComponent("Image")

				if var_153_0 then
					arg_150_1.var_.highlightMatValue1041_1 = var_153_0
				end
			end

			local var_153_1 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_1 and not isNil(arg_150_1.actors_["1041_1"]) then
				if arg_150_1.var_.highlightMatValue1041_1 then
					local var_153_2 = Mathf.Lerp(0.5, 1, (arg_150_1.time_ - 0) / var_153_1)

					arg_150_1.var_.highlightMatValue1041_1.color.r = var_153_2
					arg_150_1.var_.highlightMatValue1041_1.color.g = var_153_2
					arg_150_1.var_.highlightMatValue1041_1.color.b = var_153_2
					arg_150_1.var_.highlightMatValue1041_1.color = arg_150_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_150_1.time_ >= 0 + var_153_1 and arg_150_1.time_ < 0 + var_153_1 + arg_153_0 and not isNil(arg_150_1.actors_["1041_1"]) and arg_150_1.var_.highlightMatValue1041_1 then
				arg_150_1.actors_["1041_1"].transform:SetSiblingIndex(1)

				arg_150_1.var_.highlightMatValue1041_1.color.r = 1
				arg_150_1.var_.highlightMatValue1041_1.color.g = 1
				arg_150_1.var_.highlightMatValue1041_1.color.b = 1
				arg_150_1.var_.highlightMatValue1041_1.color = arg_150_1.var_.highlightMatValue1041_1.color
			end

			local var_153_3 = 0
			local var_153_4 = 0.9

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_3 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_5 = arg_150_1:GetWordFromCfg(115271037)
				local var_153_6 = arg_150_1:FormatText(var_153_5.content)

				arg_150_1.text_.text = var_153_6

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_8 = 36 <= 0 and var_153_4 or var_153_4 * (utf8.len(var_153_6) / 36)

				if (36 <= 0 and var_153_4 or var_153_4 * (utf8.len(var_153_6) / 36)) > 0 and var_153_4 < var_153_8 then
					arg_150_1.talkMaxDuration = var_153_8

					if var_153_8 + var_153_3 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_3
					end
				end

				arg_150_1.text_.text = var_153_6
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271037", "story_v_out_115271.awb") ~= 0 then
					local var_153_9 = manager.audio:GetVoiceLength("story_v_out_115271", "115271037", "story_v_out_115271.awb") / 1000

					if var_153_9 + var_153_3 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_3
					end

					if var_153_5.prefab_name ~= "" and arg_150_1.actors_[var_153_5.prefab_name] ~= nil then
						local var_153_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_5.prefab_name].transform, "story_v_out_115271", "115271037", "story_v_out_115271.awb")

						arg_150_1:RecordAudio("115271037", var_153_10)
						arg_150_1:RecordAudio("115271037", var_153_10)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_115271", "115271037", "story_v_out_115271.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_115271", "115271037", "story_v_out_115271.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_11 = math.max(var_153_4, arg_150_1.talkMaxDuration)

			if var_153_3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_3 + var_153_11 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_3) / var_153_11

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_3 + var_153_11 and arg_150_1.time_ < var_153_3 + var_153_11 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play115271038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 115271038
		arg_154_1.duration_ = 8.77

		local var_154_0 = {
			ja = 8.766,
			ko = 5.1,
			zh = 5.1,
			en = 6.8
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
				arg_154_0:Play115271039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.525

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:GetWordFromCfg(115271038)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 21 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 21)

				if (21 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 21)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271038", "story_v_out_115271.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271038", "story_v_out_115271.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_115271", "115271038", "story_v_out_115271.awb")

						arg_154_1:RecordAudio("115271038", var_157_6)
						arg_154_1:RecordAudio("115271038", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_115271", "115271038", "story_v_out_115271.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_115271", "115271038", "story_v_out_115271.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play115271039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 115271039
		arg_158_1.duration_ = 8.5

		local var_158_0 = {
			ja = 4.533,
			ko = 5.566,
			zh = 8.5,
			en = 6.2
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
				arg_158_0:Play115271040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1038 = arg_158_1.actors_["1038"].transform.localPosition
				arg_158_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("1038", 2)

				for iter_161_0 = 0, arg_158_1.actors_["1038"].transform.childCount - 1 do
					local var_161_0 = arg_158_1.actors_["1038"].transform:GetChild(iter_161_0)

					if var_161_0.name == "split_9" or not string.find(var_161_0.name, "split") then
						var_161_0.gameObject:SetActive(true)
					else
						var_161_0.gameObject:SetActive(false)
					end
				end
			end

			local var_161_1 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_1 then
				arg_158_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_158_1.time_ - 0) / var_161_1)
			end

			if arg_158_1.time_ >= 0 + var_161_1 and arg_158_1.time_ < 0 + var_161_1 + arg_161_0 then
				arg_158_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_161_2 = arg_158_1.actors_["1038"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.actorSpriteComps1038 == nil then
				arg_158_1.var_.actorSpriteComps1038 = var_161_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_3 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 and not isNil(var_161_2) then
				if arg_158_1.var_.actorSpriteComps1038 then
					for iter_161_1, iter_161_2 in pairs(arg_158_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_161_2 then
							if arg_158_1.isInRecall_ then
								iter_161_2.color = Color.New(Mathf.Lerp(iter_161_2.color.r, arg_158_1.hightColor1.r, (arg_158_1.time_ - 0) / var_161_3), Mathf.Lerp(iter_161_2.color.g, arg_158_1.hightColor1.g, (arg_158_1.time_ - 0) / var_161_3), (Mathf.Lerp(iter_161_2.color.b, arg_158_1.hightColor1.b, (arg_158_1.time_ - 0) / var_161_3)))
							else
								local var_161_4 = Mathf.Lerp(iter_161_2.color.r, 1, (arg_158_1.time_ - 0) / var_161_3)

								iter_161_2.color = Color.New(var_161_4, var_161_4, var_161_4)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.actorSpriteComps1038 then
				for iter_161_3, iter_161_4 in pairs(arg_158_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_161_4 then
						iter_161_4.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_158_1.var_.actorSpriteComps1038 = nil
			end

			local var_161_5 = arg_158_1.actors_["1041_1"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_5) then
				local var_161_6 = var_161_5:GetComponent("Image")

				if var_161_6 then
					arg_158_1.var_.highlightMatValue1041_1 = var_161_6
				end
			end

			local var_161_7 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 and not isNil(var_161_5) then
				if arg_158_1.var_.highlightMatValue1041_1 then
					local var_161_8 = Mathf.Lerp(1, 0.5, (arg_158_1.time_ - 0) / var_161_7)

					arg_158_1.var_.highlightMatValue1041_1.color.r = var_161_8
					arg_158_1.var_.highlightMatValue1041_1.color.g = var_161_8
					arg_158_1.var_.highlightMatValue1041_1.color.b = var_161_8
					arg_158_1.var_.highlightMatValue1041_1.color = arg_158_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.highlightMatValue1041_1 then
				arg_158_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_158_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_158_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_158_1.var_.highlightMatValue1041_1.color = arg_158_1.var_.highlightMatValue1041_1.color
			end

			local var_161_9 = 0
			local var_161_10 = 0.725

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_11 = arg_158_1:GetWordFromCfg(115271039)
				local var_161_12 = arg_158_1:FormatText(var_161_11.content)

				arg_158_1.text_.text = var_161_12

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_14 = 29 <= 0 and var_161_10 or var_161_10 * (utf8.len(var_161_12) / 29)

				if (29 <= 0 and var_161_10 or var_161_10 * (utf8.len(var_161_12) / 29)) > 0 and var_161_10 < var_161_14 then
					arg_158_1.talkMaxDuration = var_161_14

					if var_161_14 + var_161_9 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_9
					end
				end

				arg_158_1.text_.text = var_161_12
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271039", "story_v_out_115271.awb") ~= 0 then
					local var_161_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271039", "story_v_out_115271.awb") / 1000

					if var_161_15 + var_161_9 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_9
					end

					if var_161_11.prefab_name ~= "" and arg_158_1.actors_[var_161_11.prefab_name] ~= nil then
						local var_161_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_11.prefab_name].transform, "story_v_out_115271", "115271039", "story_v_out_115271.awb")

						arg_158_1:RecordAudio("115271039", var_161_16)
						arg_158_1:RecordAudio("115271039", var_161_16)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_115271", "115271039", "story_v_out_115271.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_115271", "115271039", "story_v_out_115271.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_17 = math.max(var_161_10, arg_158_1.talkMaxDuration)

			if var_161_9 <= arg_158_1.time_ and arg_158_1.time_ < var_161_9 + var_161_17 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_9) / var_161_17

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_9 + var_161_17 and arg_158_1.time_ < var_161_9 + var_161_17 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play115271040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 115271040
		arg_162_1.duration_ = 14.03

		local var_162_0 = {
			ja = 14.033,
			ko = 11.233,
			zh = 11.866,
			en = 11.566
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play115271041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:GetWordFromCfg(115271040)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 47 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 47)

				if (47 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 47)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271040", "story_v_out_115271.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271040", "story_v_out_115271.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_115271", "115271040", "story_v_out_115271.awb")

						arg_162_1:RecordAudio("115271040", var_165_6)
						arg_162_1:RecordAudio("115271040", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_115271", "115271040", "story_v_out_115271.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_115271", "115271040", "story_v_out_115271.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play115271041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 115271041
		arg_166_1.duration_ = 2.43

		local var_166_0 = {
			ja = 1.766,
			ko = 1.533,
			zh = 1.233,
			en = 2.433
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
				arg_166_0:Play115271042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1038"]) and arg_166_1.var_.actorSpriteComps1038 == nil then
				arg_166_1.var_.actorSpriteComps1038 = arg_166_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1038"]) then
				if arg_166_1.var_.actorSpriteComps1038 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1038"]) and arg_166_1.var_.actorSpriteComps1038 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps1038 = nil
			end

			local var_169_2 = arg_166_1.actors_["1041_1"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) then
				local var_169_3 = var_169_2:GetComponent("Image")

				if var_169_3 then
					arg_166_1.var_.highlightMatValue1041_1 = var_169_3
				end
			end

			local var_169_4 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 and not isNil(var_169_2) then
				if arg_166_1.var_.highlightMatValue1041_1 then
					local var_169_5 = Mathf.Lerp(0.5, 1, (arg_166_1.time_ - 0) / var_169_4)

					arg_166_1.var_.highlightMatValue1041_1.color.r = var_169_5
					arg_166_1.var_.highlightMatValue1041_1.color.g = var_169_5
					arg_166_1.var_.highlightMatValue1041_1.color.b = var_169_5
					arg_166_1.var_.highlightMatValue1041_1.color = arg_166_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.highlightMatValue1041_1 then
				var_169_2.transform:SetSiblingIndex(1)

				arg_166_1.var_.highlightMatValue1041_1.color.r = 1
				arg_166_1.var_.highlightMatValue1041_1.color.g = 1
				arg_166_1.var_.highlightMatValue1041_1.color.b = 1
				arg_166_1.var_.highlightMatValue1041_1.color = arg_166_1.var_.highlightMatValue1041_1.color
			end

			local var_169_6 = 0
			local var_169_7 = 0.125

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_8 = arg_166_1:GetWordFromCfg(115271041)
				local var_169_9 = arg_166_1:FormatText(var_169_8.content)

				arg_166_1.text_.text = var_169_9

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 5 <= 0 and var_169_7 or var_169_7 * (utf8.len(var_169_9) / 5)

				if (5 <= 0 and var_169_7 or var_169_7 * (utf8.len(var_169_9) / 5)) > 0 and var_169_7 < var_169_11 then
					arg_166_1.talkMaxDuration = var_169_11

					if var_169_11 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_9
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271041", "story_v_out_115271.awb") ~= 0 then
					local var_169_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271041", "story_v_out_115271.awb") / 1000

					if var_169_12 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_6
					end

					if var_169_8.prefab_name ~= "" and arg_166_1.actors_[var_169_8.prefab_name] ~= nil then
						local var_169_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_8.prefab_name].transform, "story_v_out_115271", "115271041", "story_v_out_115271.awb")

						arg_166_1:RecordAudio("115271041", var_169_13)
						arg_166_1:RecordAudio("115271041", var_169_13)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_115271", "115271041", "story_v_out_115271.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_115271", "115271041", "story_v_out_115271.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_14 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_14

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_14 and arg_166_1.time_ < var_169_6 + var_169_14 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play115271042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 115271042
		arg_170_1.duration_ = 2.2

		local var_170_0 = {
			ja = 1.066,
			ko = 0.999999999999,
			zh = 2.2,
			en = 1.566
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
				arg_170_0:Play115271043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1038 = arg_170_1.actors_["1038"].transform.localPosition
				arg_170_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("1038", 2)

				for iter_173_0 = 0, arg_170_1.actors_["1038"].transform.childCount - 1 do
					local var_173_0 = arg_170_1.actors_["1038"].transform:GetChild(iter_173_0)

					if var_173_0.name == "split_5" or not string.find(var_173_0.name, "split") then
						var_173_0.gameObject:SetActive(true)
					else
						var_173_0.gameObject:SetActive(false)
					end
				end
			end

			local var_173_1 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_1 then
				arg_170_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_170_1.time_ - 0) / var_173_1)
			end

			if arg_170_1.time_ >= 0 + var_173_1 and arg_170_1.time_ < 0 + var_173_1 + arg_173_0 then
				arg_170_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_173_2 = arg_170_1.actors_["1038"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps1038 == nil then
				arg_170_1.var_.actorSpriteComps1038 = var_173_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_3 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.actorSpriteComps1038 then
					for iter_173_1, iter_173_2 in pairs(arg_170_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_173_2 then
							if arg_170_1.isInRecall_ then
								iter_173_2.color = Color.New(Mathf.Lerp(iter_173_2.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_3), Mathf.Lerp(iter_173_2.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_3), (Mathf.Lerp(iter_173_2.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_3)))
							else
								local var_173_4 = Mathf.Lerp(iter_173_2.color.r, 1, (arg_170_1.time_ - 0) / var_173_3)

								iter_173_2.color = Color.New(var_173_4, var_173_4, var_173_4)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps1038 then
				for iter_173_3, iter_173_4 in pairs(arg_170_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_173_4 then
						iter_173_4.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps1038 = nil
			end

			local var_173_5 = arg_170_1.actors_["1041_1"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_5) then
				local var_173_6 = var_173_5:GetComponent("Image")

				if var_173_6 then
					arg_170_1.var_.highlightMatValue1041_1 = var_173_6
				end
			end

			local var_173_7 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 and not isNil(var_173_5) then
				if arg_170_1.var_.highlightMatValue1041_1 then
					local var_173_8 = Mathf.Lerp(1, 0.5, (arg_170_1.time_ - 0) / var_173_7)

					arg_170_1.var_.highlightMatValue1041_1.color.r = var_173_8
					arg_170_1.var_.highlightMatValue1041_1.color.g = var_173_8
					arg_170_1.var_.highlightMatValue1041_1.color.b = var_173_8
					arg_170_1.var_.highlightMatValue1041_1.color = arg_170_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.highlightMatValue1041_1 then
				arg_170_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_170_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_170_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_170_1.var_.highlightMatValue1041_1.color = arg_170_1.var_.highlightMatValue1041_1.color
			end

			local var_173_9 = 0
			local var_173_10 = 0.05

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_11 = arg_170_1:GetWordFromCfg(115271042)
				local var_173_12 = arg_170_1:FormatText(var_173_11.content)

				arg_170_1.text_.text = var_173_12

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_14 = 2 <= 0 and var_173_10 or var_173_10 * (utf8.len(var_173_12) / 2)

				if (2 <= 0 and var_173_10 or var_173_10 * (utf8.len(var_173_12) / 2)) > 0 and var_173_10 < var_173_14 then
					arg_170_1.talkMaxDuration = var_173_14

					if var_173_14 + var_173_9 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_9
					end
				end

				arg_170_1.text_.text = var_173_12
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271042", "story_v_out_115271.awb") ~= 0 then
					local var_173_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271042", "story_v_out_115271.awb") / 1000

					if var_173_15 + var_173_9 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_9
					end

					if var_173_11.prefab_name ~= "" and arg_170_1.actors_[var_173_11.prefab_name] ~= nil then
						local var_173_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_11.prefab_name].transform, "story_v_out_115271", "115271042", "story_v_out_115271.awb")

						arg_170_1:RecordAudio("115271042", var_173_16)
						arg_170_1:RecordAudio("115271042", var_173_16)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_115271", "115271042", "story_v_out_115271.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_115271", "115271042", "story_v_out_115271.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_17 = math.max(var_173_10, arg_170_1.talkMaxDuration)

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_17 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_9) / var_173_17

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_9 + var_173_17 and arg_170_1.time_ < var_173_9 + var_173_17 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play115271043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 115271043
		arg_174_1.duration_ = 9.37

		local var_174_0 = {
			ja = 9.366,
			ko = 3.666,
			zh = 4.6,
			en = 5.466
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
				arg_174_0:Play115271044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1038"]) and arg_174_1.var_.actorSpriteComps1038 == nil then
				arg_174_1.var_.actorSpriteComps1038 = arg_174_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1038"]) then
				if arg_174_1.var_.actorSpriteComps1038 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1038"]) and arg_174_1.var_.actorSpriteComps1038 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps1038 = nil
			end

			local var_177_2 = arg_174_1.actors_["1041_1"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) then
				local var_177_3 = var_177_2:GetComponent("Image")

				if var_177_3 then
					arg_174_1.var_.highlightMatValue1041_1 = var_177_3
				end
			end

			local var_177_4 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 and not isNil(var_177_2) then
				if arg_174_1.var_.highlightMatValue1041_1 then
					local var_177_5 = Mathf.Lerp(0.5, 1, (arg_174_1.time_ - 0) / var_177_4)

					arg_174_1.var_.highlightMatValue1041_1.color.r = var_177_5
					arg_174_1.var_.highlightMatValue1041_1.color.g = var_177_5
					arg_174_1.var_.highlightMatValue1041_1.color.b = var_177_5
					arg_174_1.var_.highlightMatValue1041_1.color = arg_174_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.highlightMatValue1041_1 then
				var_177_2.transform:SetSiblingIndex(1)

				arg_174_1.var_.highlightMatValue1041_1.color.r = 1
				arg_174_1.var_.highlightMatValue1041_1.color.g = 1
				arg_174_1.var_.highlightMatValue1041_1.color.b = 1
				arg_174_1.var_.highlightMatValue1041_1.color = arg_174_1.var_.highlightMatValue1041_1.color
			end

			local var_177_6 = 0
			local var_177_7 = 0.55

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_8 = arg_174_1:GetWordFromCfg(115271043)
				local var_177_9 = arg_174_1:FormatText(var_177_8.content)

				arg_174_1.text_.text = var_177_9

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 22 <= 0 and var_177_7 or var_177_7 * (utf8.len(var_177_9) / 22)

				if (22 <= 0 and var_177_7 or var_177_7 * (utf8.len(var_177_9) / 22)) > 0 and var_177_7 < var_177_11 then
					arg_174_1.talkMaxDuration = var_177_11

					if var_177_11 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_9
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271043", "story_v_out_115271.awb") ~= 0 then
					local var_177_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271043", "story_v_out_115271.awb") / 1000

					if var_177_12 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_6
					end

					if var_177_8.prefab_name ~= "" and arg_174_1.actors_[var_177_8.prefab_name] ~= nil then
						local var_177_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_8.prefab_name].transform, "story_v_out_115271", "115271043", "story_v_out_115271.awb")

						arg_174_1:RecordAudio("115271043", var_177_13)
						arg_174_1:RecordAudio("115271043", var_177_13)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_115271", "115271043", "story_v_out_115271.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_115271", "115271043", "story_v_out_115271.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play115271044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 115271044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play115271045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				local var_181_0 = arg_178_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_181_0 then
					arg_178_1.var_.alphaOldValue1038 = var_181_0.alpha
					arg_178_1.var_.characterEffect1038 = var_181_0
				end

				arg_178_1.var_.alphaOldValue1038 = 1
			end

			local var_181_1 = 0.5

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_1 then
				if arg_178_1.var_.characterEffect1038 then
					arg_178_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_178_1.var_.alphaOldValue1038, 0, (arg_178_1.time_ - 0) / var_181_1)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_1 and arg_178_1.time_ < 0 + var_181_1 + arg_181_0 and arg_178_1.var_.characterEffect1038 then
				arg_178_1.var_.characterEffect1038.alpha = 0
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				local var_181_2 = arg_178_1.actors_["1041_1"]:GetComponent("Image")

				if var_181_2 then
					arg_178_1.var_.alphaMatValue1041_1 = var_181_2
					arg_178_1.var_.alphaOldValue1041_1 = var_181_2.color.a
				end

				arg_178_1.var_.alphaOldValue1041_1 = 1
			end

			local var_181_3 = 0.5

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 then
				if arg_178_1.var_.alphaMatValue1041_1 then
					arg_178_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_178_1.var_.alphaOldValue1041_1, 0, (arg_178_1.time_ - 0) / var_181_3)
					arg_178_1.var_.alphaMatValue1041_1.color = arg_178_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and arg_178_1.var_.alphaMatValue1041_1 then
				arg_178_1.var_.alphaMatValue1041_1.color.a = 0
				arg_178_1.var_.alphaMatValue1041_1.color = arg_178_1.var_.alphaMatValue1041_1.color
			end

			local var_181_4 = 0
			local var_181_5 = 0.775

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(115271044).content)

				arg_178_1.text_.text = var_181_6

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_8 = 31 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_6) / 31)

				if (31 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_6) / 31)) > 0 and var_181_5 < var_181_8 then
					arg_178_1.talkMaxDuration = var_181_8

					if var_181_8 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_6
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_9 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_9 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_9

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_9 and arg_178_1.time_ < var_181_4 + var_181_9 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play115271045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 115271045
		arg_182_1.duration_ = 9.97

		local var_182_0 = {
			ja = 9.966,
			ko = 7.566,
			zh = 7.433,
			en = 7.833
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
				arg_182_0:Play115271046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if arg_182_1.bgs_.ST28a == nil then
				local var_185_0 = Object.Instantiate(arg_182_1.paintGo_)

				var_185_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST28a")
				var_185_0.name = "ST28a"
				var_185_0.transform.parent = arg_182_1.stage_.transform
				var_185_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.bgs_.ST28a = var_185_0
			end

			if 2 < arg_182_1.time_ and arg_182_1.time_ <= 2 + arg_185_0 then
				local var_185_1 = arg_182_1.bgs_.ST28a

				arg_182_1.bgs_.ST28a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_185_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_185_2 = var_185_1:GetComponent("SpriteRenderer")

				if var_185_2 and var_185_2.sprite then
					local var_185_3 = 2 * (var_185_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_185_1.transform.localScale = Vector3.New(var_185_3 / var_185_2.sprite.bounds.size.y < var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x and var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x or var_185_3 / var_185_2.sprite.bounds.size.y, var_185_3 / var_185_2.sprite.bounds.size.y < var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x and var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x or var_185_3 / var_185_2.sprite.bounds.size.y, 0)
				end

				for iter_185_0, iter_185_1 in pairs(arg_182_1.bgs_) do
					if iter_185_0 ~= "ST28a" then
						iter_185_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_185_4 = 0

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_5 = 2

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_5 then
				local var_185_6 = Color.New(0, 0, 0)

				var_185_6.a = Mathf.Lerp(0, 1, (arg_182_1.time_ - var_185_4) / var_185_5)
				arg_182_1.mask_.color = var_185_6
			end

			if arg_182_1.time_ >= var_185_4 + var_185_5 and arg_182_1.time_ < var_185_4 + var_185_5 + arg_185_0 then
				local var_185_7 = Color.New(0, 0, 0)

				var_185_7.a = 1
				arg_182_1.mask_.color = var_185_7
			end

			local var_185_8 = 2

			if 2 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_9 = 2

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_9 then
				local var_185_10 = Color.New(0, 0, 0)

				var_185_10.a = Mathf.Lerp(1, 0, (arg_182_1.time_ - var_185_8) / var_185_9)
				arg_182_1.mask_.color = var_185_10
			end

			if arg_182_1.time_ >= var_185_8 + var_185_9 and arg_182_1.time_ < var_185_8 + var_185_9 + arg_185_0 then
				local var_185_11 = Color.New(0, 0, 0)

				arg_182_1.mask_.enabled = false
				var_185_11.a = 0
				arg_182_1.mask_.color = var_185_11
			end

			local var_185_12 = "10030"

			if arg_182_1.actors_["10030"] == nil then
				local var_185_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_185_13) then
					local var_185_14 = Object.Instantiate(var_185_13, arg_182_1.canvasGo_.transform)

					var_185_14.transform:SetSiblingIndex(1)

					var_185_14.name = var_185_12
					var_185_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_182_1.actors_[var_185_12] = var_185_14

					if arg_182_1.isInRecall_ then
						for iter_185_2, iter_185_3 in ipairs((var_185_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_185_15 = arg_182_1.actors_["10030"].transform

			if 3.8 < arg_182_1.time_ and arg_182_1.time_ <= 3.8 + arg_185_0 then
				arg_182_1.var_.moveOldPos10030 = var_185_15.localPosition
				var_185_15.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10030", 4)

				for iter_185_4 = 0, var_185_15.childCount - 1 do
					local var_185_16 = var_185_15:GetChild(iter_185_4)

					if var_185_16.name == "split_3" or not string.find(var_185_16.name, "split") then
						var_185_16.gameObject:SetActive(true)
					else
						var_185_16.gameObject:SetActive(false)
					end
				end
			end

			local var_185_17 = 0.001

			if 3.8 <= arg_182_1.time_ and arg_182_1.time_ < 3.8 + var_185_17 then
				var_185_15.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_182_1.time_ - 3.8) / var_185_17)
			end

			if arg_182_1.time_ >= 3.8 + var_185_17 and arg_182_1.time_ < 3.8 + var_185_17 + arg_185_0 then
				var_185_15.localPosition = Vector3.New(390, -390, 150)
			end

			if 3.8 < arg_182_1.time_ and arg_182_1.time_ <= 3.8 + arg_185_0 then
				local var_185_18 = arg_182_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_185_18 then
					arg_182_1.var_.alphaOldValue10030 = var_185_18.alpha
					arg_182_1.var_.characterEffect10030 = var_185_18
				end

				arg_182_1.var_.alphaOldValue10030 = 0
			end

			local var_185_19 = 0.5

			if 3.8 <= arg_182_1.time_ and arg_182_1.time_ < 3.8 + var_185_19 then
				if arg_182_1.var_.characterEffect10030 then
					arg_182_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_182_1.var_.alphaOldValue10030, 1, (arg_182_1.time_ - 3.8) / var_185_19)
				end
			end

			if arg_182_1.time_ >= 3.8 + var_185_19 and arg_182_1.time_ < 3.8 + var_185_19 + arg_185_0 and arg_182_1.var_.characterEffect10030 then
				arg_182_1.var_.characterEffect10030.alpha = 1
			end

			local var_185_20 = arg_182_1.actors_["10030"]

			if 3.8 < arg_182_1.time_ and arg_182_1.time_ <= 3.8 + arg_185_0 and not isNil(var_185_20) and arg_182_1.var_.actorSpriteComps10030 == nil then
				arg_182_1.var_.actorSpriteComps10030 = var_185_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_21 = 0.2

			if 3.8 <= arg_182_1.time_ and arg_182_1.time_ < 3.8 + var_185_21 and not isNil(var_185_20) then
				if arg_182_1.var_.actorSpriteComps10030 then
					for iter_185_5, iter_185_6 in pairs(arg_182_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_185_6 then
							if arg_182_1.isInRecall_ then
								iter_185_6.color = Color.New(Mathf.Lerp(iter_185_6.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 3.8) / var_185_21), Mathf.Lerp(iter_185_6.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 3.8) / var_185_21), (Mathf.Lerp(iter_185_6.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 3.8) / var_185_21)))
							else
								local var_185_22 = Mathf.Lerp(iter_185_6.color.r, 1, (arg_182_1.time_ - 3.8) / var_185_21)

								iter_185_6.color = Color.New(var_185_22, var_185_22, var_185_22)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 3.8 + var_185_21 and arg_182_1.time_ < 3.8 + var_185_21 + arg_185_0 and not isNil(var_185_20) and arg_182_1.var_.actorSpriteComps10030 then
				for iter_185_7, iter_185_8 in pairs(arg_182_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_185_8 then
						iter_185_8.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_185_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_182_1.bgmTxt_.text ~= var_185_25 and arg_182_1.bgmTxt_.text ~= "" then
						if arg_182_1.bgmTxt2_.text ~= "" then
							arg_182_1.bgmTxt_.text = arg_182_1.bgmTxt2_.text
						end

						arg_182_1.bgmTxt2_.text = var_185_25

						arg_182_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_182_1.bgmTxt_.text = var_185_25
						arg_182_1.bgmTxt2_.text = var_185_25
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

			if 4 < arg_182_1.time_ and arg_182_1.time_ <= 4 + arg_185_0 then
				arg_182_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_185_28 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_182_1.bgmTxt_.text ~= var_185_28 and arg_182_1.bgmTxt_.text ~= "" then
						if arg_182_1.bgmTxt2_.text ~= "" then
							arg_182_1.bgmTxt_.text = arg_182_1.bgmTxt2_.text
						end

						arg_182_1.bgmTxt2_.text = var_185_28

						arg_182_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_182_1.bgmTxt_.text = var_185_28
						arg_182_1.bgmTxt2_.text = var_185_28
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

			if arg_182_1.frameCnt_ <= 1 then
				arg_182_1.dialog_:SetActive(false)
			end

			local var_185_29 = 4
			local var_185_30 = 0.225

			if 4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_29 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0

				arg_182_1.dialog_:SetActive(true)

				arg_182_1.dialogCg_.alpha = 0

				local var_185_31 = LeanTween.value(arg_182_1.dialog_, 0, 1, 0.3)

				var_185_31:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_182_1.dialogCg_.alpha = arg_188_0
				end))
				var_185_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_182_1.dialog_)
					var_185_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_182_1.duration_ = arg_182_1.duration_ + 0.3

				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_32 = arg_182_1:GetWordFromCfg(115271045)
				local var_185_33 = arg_182_1:FormatText(var_185_32.content)

				arg_182_1.text_.text = var_185_33

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_35 = 9 <= 0 and var_185_30 or var_185_30 * (utf8.len(var_185_33) / 9)

				if (9 <= 0 and var_185_30 or var_185_30 * (utf8.len(var_185_33) / 9)) > 0 and var_185_30 < var_185_35 then
					arg_182_1.talkMaxDuration = var_185_35
					var_185_29 = var_185_29 + 0.3

					if var_185_35 + var_185_29 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_35 + var_185_29
					end
				end

				arg_182_1.text_.text = var_185_33
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271045", "story_v_out_115271.awb") ~= 0 then
					local var_185_36 = manager.audio:GetVoiceLength("story_v_out_115271", "115271045", "story_v_out_115271.awb") / 1000

					if var_185_36 + var_185_29 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_36 + var_185_29
					end

					if var_185_32.prefab_name ~= "" and arg_182_1.actors_[var_185_32.prefab_name] ~= nil then
						local var_185_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_32.prefab_name].transform, "story_v_out_115271", "115271045", "story_v_out_115271.awb")

						arg_182_1:RecordAudio("115271045", var_185_37)
						arg_182_1:RecordAudio("115271045", var_185_37)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_115271", "115271045", "story_v_out_115271.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_115271", "115271045", "story_v_out_115271.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_38 = var_185_29 + 0.3
			local var_185_39 = math.max(var_185_30, arg_182_1.talkMaxDuration)

			if var_185_29 + 0.3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_38 + var_185_39 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_38) / var_185_39

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_38 + var_185_39 and arg_182_1.time_ < var_185_38 + var_185_39 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play115271046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 115271046
		arg_190_1.duration_ = 8.77

		local var_190_0 = {
			ja = 5.266,
			ko = 6.766,
			zh = 6.166,
			en = 8.766
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
				arg_190_0:Play115271047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10030"]) and arg_190_1.var_.actorSpriteComps10030 == nil then
				arg_190_1.var_.actorSpriteComps10030 = arg_190_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10030"]) then
				if arg_190_1.var_.actorSpriteComps10030 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10030"]) and arg_190_1.var_.actorSpriteComps10030 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps10030 = nil
			end

			local var_193_2 = "10029"

			if arg_190_1.actors_["10029"] == nil then
				local var_193_3 = Object.Instantiate(arg_190_1.imageGo_, arg_190_1.canvasGo_.transform)

				var_193_3.transform:SetSiblingIndex(1)

				var_193_3.name = var_193_2

				local var_193_4 = var_193_3:GetComponent(typeof(Image))

				var_193_4.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_193_4:SetNativeSize()

				var_193_3.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_190_1.actors_[var_193_2] = var_193_3
			end

			local var_193_5 = arg_190_1.actors_["10029"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_5) then
				local var_193_6 = var_193_5:GetComponent("Image")

				if var_193_6 then
					arg_190_1.var_.highlightMatValue10029 = var_193_6
				end
			end

			local var_193_7 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 and not isNil(var_193_5) then
				if arg_190_1.var_.highlightMatValue10029 then
					local var_193_8 = Mathf.Lerp(0.5, 1, (arg_190_1.time_ - 0) / var_193_7)

					arg_190_1.var_.highlightMatValue10029.color.r = var_193_8
					arg_190_1.var_.highlightMatValue10029.color.g = var_193_8
					arg_190_1.var_.highlightMatValue10029.color.b = var_193_8
					arg_190_1.var_.highlightMatValue10029.color = arg_190_1.var_.highlightMatValue10029.color
				end
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 and not isNil(var_193_5) and arg_190_1.var_.highlightMatValue10029 then
				var_193_5.transform:SetSiblingIndex(1)

				arg_190_1.var_.highlightMatValue10029.color.r = 1
				arg_190_1.var_.highlightMatValue10029.color.g = 1
				arg_190_1.var_.highlightMatValue10029.color.b = 1
				arg_190_1.var_.highlightMatValue10029.color = arg_190_1.var_.highlightMatValue10029.color
			end

			local var_193_9 = arg_190_1.actors_["10029"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10029 = var_193_9.localPosition
				var_193_9.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_193_10 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_10 then
				var_193_9.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_190_1.time_ - 0) / var_193_10)
			end

			if arg_190_1.time_ >= 0 + var_193_10 and arg_190_1.time_ < 0 + var_193_10 + arg_193_0 then
				var_193_9.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				local var_193_11 = arg_190_1.actors_["10029"]:GetComponent("Image")

				if var_193_11 then
					arg_190_1.var_.alphaMatValue10029 = var_193_11
					arg_190_1.var_.alphaOldValue10029 = var_193_11.color.a
				end

				arg_190_1.var_.alphaOldValue10029 = 0
			end

			local var_193_12 = 0.5

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_12 then
				if arg_190_1.var_.alphaMatValue10029 then
					arg_190_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_190_1.var_.alphaOldValue10029, 1, (arg_190_1.time_ - 0) / var_193_12)
					arg_190_1.var_.alphaMatValue10029.color = arg_190_1.var_.alphaMatValue10029.color
				end
			end

			if arg_190_1.time_ >= 0 + var_193_12 and arg_190_1.time_ < 0 + var_193_12 + arg_193_0 and arg_190_1.var_.alphaMatValue10029 then
				arg_190_1.var_.alphaMatValue10029.color.a = 1
				arg_190_1.var_.alphaMatValue10029.color = arg_190_1.var_.alphaMatValue10029.color
			end

			local var_193_13 = 0
			local var_193_14 = 0.625

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_15 = arg_190_1:GetWordFromCfg(115271046)
				local var_193_16 = arg_190_1:FormatText(var_193_15.content)

				arg_190_1.text_.text = var_193_16

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_18 = 25 <= 0 and var_193_14 or var_193_14 * (utf8.len(var_193_16) / 25)

				if (25 <= 0 and var_193_14 or var_193_14 * (utf8.len(var_193_16) / 25)) > 0 and var_193_14 < var_193_18 then
					arg_190_1.talkMaxDuration = var_193_18

					if var_193_18 + var_193_13 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_13
					end
				end

				arg_190_1.text_.text = var_193_16
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271046", "story_v_out_115271.awb") ~= 0 then
					local var_193_19 = manager.audio:GetVoiceLength("story_v_out_115271", "115271046", "story_v_out_115271.awb") / 1000

					if var_193_19 + var_193_13 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_19 + var_193_13
					end

					if var_193_15.prefab_name ~= "" and arg_190_1.actors_[var_193_15.prefab_name] ~= nil then
						local var_193_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_15.prefab_name].transform, "story_v_out_115271", "115271046", "story_v_out_115271.awb")

						arg_190_1:RecordAudio("115271046", var_193_20)
						arg_190_1:RecordAudio("115271046", var_193_20)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_115271", "115271046", "story_v_out_115271.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_115271", "115271046", "story_v_out_115271.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_21 = math.max(var_193_14, arg_190_1.talkMaxDuration)

			if var_193_13 <= arg_190_1.time_ and arg_190_1.time_ < var_193_13 + var_193_21 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_13) / var_193_21

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_13 + var_193_21 and arg_190_1.time_ < var_193_13 + var_193_21 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play115271047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 115271047
		arg_194_1.duration_ = 3.2

		local var_194_0 = {
			ja = 3.2,
			ko = 1.966,
			zh = 1.933,
			en = 2.5
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
				arg_194_0:Play115271048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos10030 = arg_194_1.actors_["10030"].transform.localPosition
				arg_194_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("10030", 4)

				for iter_197_0 = 0, arg_194_1.actors_["10030"].transform.childCount - 1 do
					local var_197_0 = arg_194_1.actors_["10030"].transform:GetChild(iter_197_0)

					if var_197_0.name == "split_2" or not string.find(var_197_0.name, "split") then
						var_197_0.gameObject:SetActive(true)
					else
						var_197_0.gameObject:SetActive(false)
					end
				end
			end

			local var_197_1 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_1 then
				arg_194_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_194_1.time_ - 0) / var_197_1)
			end

			if arg_194_1.time_ >= 0 + var_197_1 and arg_194_1.time_ < 0 + var_197_1 + arg_197_0 then
				arg_194_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_197_2 = arg_194_1.actors_["10030"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.actorSpriteComps10030 == nil then
				arg_194_1.var_.actorSpriteComps10030 = var_197_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_3 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.actorSpriteComps10030 then
					for iter_197_1, iter_197_2 in pairs(arg_194_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_197_2 then
							if arg_194_1.isInRecall_ then
								iter_197_2.color = Color.New(Mathf.Lerp(iter_197_2.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_3), Mathf.Lerp(iter_197_2.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_3), (Mathf.Lerp(iter_197_2.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_3)))
							else
								local var_197_4 = Mathf.Lerp(iter_197_2.color.r, 1, (arg_194_1.time_ - 0) / var_197_3)

								iter_197_2.color = Color.New(var_197_4, var_197_4, var_197_4)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.actorSpriteComps10030 then
				for iter_197_3, iter_197_4 in pairs(arg_194_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_197_4 then
						iter_197_4.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps10030 = nil
			end

			local var_197_5 = arg_194_1.actors_["10029"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_5) then
				local var_197_6 = var_197_5:GetComponent("Image")

				if var_197_6 then
					arg_194_1.var_.highlightMatValue10029 = var_197_6
				end
			end

			local var_197_7 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 and not isNil(var_197_5) then
				if arg_194_1.var_.highlightMatValue10029 then
					local var_197_8 = Mathf.Lerp(1, 0.5, (arg_194_1.time_ - 0) / var_197_7)

					arg_194_1.var_.highlightMatValue10029.color.r = var_197_8
					arg_194_1.var_.highlightMatValue10029.color.g = var_197_8
					arg_194_1.var_.highlightMatValue10029.color.b = var_197_8
					arg_194_1.var_.highlightMatValue10029.color = arg_194_1.var_.highlightMatValue10029.color
				end
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.highlightMatValue10029 then
				arg_194_1.var_.highlightMatValue10029.color.r = 0.5
				arg_194_1.var_.highlightMatValue10029.color.g = 0.5
				arg_194_1.var_.highlightMatValue10029.color.b = 0.5
				arg_194_1.var_.highlightMatValue10029.color = arg_194_1.var_.highlightMatValue10029.color
			end

			local var_197_9 = 0
			local var_197_10 = 0.175

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_11 = arg_194_1:GetWordFromCfg(115271047)
				local var_197_12 = arg_194_1:FormatText(var_197_11.content)

				arg_194_1.text_.text = var_197_12

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_14 = 7 <= 0 and var_197_10 or var_197_10 * (utf8.len(var_197_12) / 7)

				if (7 <= 0 and var_197_10 or var_197_10 * (utf8.len(var_197_12) / 7)) > 0 and var_197_10 < var_197_14 then
					arg_194_1.talkMaxDuration = var_197_14

					if var_197_14 + var_197_9 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_9
					end
				end

				arg_194_1.text_.text = var_197_12
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271047", "story_v_out_115271.awb") ~= 0 then
					local var_197_15 = manager.audio:GetVoiceLength("story_v_out_115271", "115271047", "story_v_out_115271.awb") / 1000

					if var_197_15 + var_197_9 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_15 + var_197_9
					end

					if var_197_11.prefab_name ~= "" and arg_194_1.actors_[var_197_11.prefab_name] ~= nil then
						local var_197_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_11.prefab_name].transform, "story_v_out_115271", "115271047", "story_v_out_115271.awb")

						arg_194_1:RecordAudio("115271047", var_197_16)
						arg_194_1:RecordAudio("115271047", var_197_16)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_115271", "115271047", "story_v_out_115271.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_115271", "115271047", "story_v_out_115271.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_17 = math.max(var_197_10, arg_194_1.talkMaxDuration)

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_17 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_9) / var_197_17

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_9 + var_197_17 and arg_194_1.time_ < var_197_9 + var_197_17 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play115271048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 115271048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play115271049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				local var_201_0 = arg_198_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_201_0 then
					arg_198_1.var_.alphaOldValue10030 = var_201_0.alpha
					arg_198_1.var_.characterEffect10030 = var_201_0
				end

				arg_198_1.var_.alphaOldValue10030 = 1
			end

			local var_201_1 = 0.5

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 then
				if arg_198_1.var_.characterEffect10030 then
					arg_198_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_198_1.var_.alphaOldValue10030, 0, (arg_198_1.time_ - 0) / var_201_1)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 and arg_198_1.var_.characterEffect10030 then
				arg_198_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				local var_201_2 = arg_198_1.actors_["10029"]:GetComponent("Image")

				if var_201_2 then
					arg_198_1.var_.alphaMatValue10029 = var_201_2
					arg_198_1.var_.alphaOldValue10029 = var_201_2.color.a
				end

				arg_198_1.var_.alphaOldValue10029 = 1
			end

			local var_201_3 = 0.5

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 then
				if arg_198_1.var_.alphaMatValue10029 then
					arg_198_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_198_1.var_.alphaOldValue10029, 0, (arg_198_1.time_ - 0) / var_201_3)
					arg_198_1.var_.alphaMatValue10029.color = arg_198_1.var_.alphaMatValue10029.color
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and arg_198_1.var_.alphaMatValue10029 then
				arg_198_1.var_.alphaMatValue10029.color.a = 0
				arg_198_1.var_.alphaMatValue10029.color = arg_198_1.var_.alphaMatValue10029.color
			end

			local var_201_4 = 0
			local var_201_5 = 1.625

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(115271048).content)

				arg_198_1.text_.text = var_201_6

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_8 = 65 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_6) / 65)

				if (65 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_6) / 65)) > 0 and var_201_5 < var_201_8 then
					arg_198_1.talkMaxDuration = var_201_8

					if var_201_8 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_6
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_9 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_9 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_9

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_9 and arg_198_1.time_ < var_201_4 + var_201_9 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play115271049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 115271049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play115271050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 1.85

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(115271049).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 74 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 74)

				if (74 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 74)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play115271050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 115271050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play115271051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 1.8

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

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(115271050).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 72 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 72)

				if (72 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 72)) > 0 and var_209_0 < var_209_3 then
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
	Play115271051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 115271051
		arg_210_1.duration_ = 4.37

		local var_210_0 = {
			ja = 4.366,
			ko = 1.733,
			zh = 3.766,
			en = 3.3
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
				arg_210_0:Play115271052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10030 = arg_210_1.actors_["10030"].transform.localPosition
				arg_210_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10030", 4)

				for iter_213_0 = 0, arg_210_1.actors_["10030"].transform.childCount - 1 do
					local var_213_0 = arg_210_1.actors_["10030"].transform:GetChild(iter_213_0)

					if var_213_0.name == "split_3" or not string.find(var_213_0.name, "split") then
						var_213_0.gameObject:SetActive(true)
					else
						var_213_0.gameObject:SetActive(false)
					end
				end
			end

			local var_213_1 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_1 then
				arg_210_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_210_1.time_ - 0) / var_213_1)
			end

			if arg_210_1.time_ >= 0 + var_213_1 and arg_210_1.time_ < 0 + var_213_1 + arg_213_0 then
				arg_210_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				local var_213_2 = arg_210_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_213_2 then
					arg_210_1.var_.alphaOldValue10030 = var_213_2.alpha
					arg_210_1.var_.characterEffect10030 = var_213_2
				end

				arg_210_1.var_.alphaOldValue10030 = 0
			end

			local var_213_3 = 0.5

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 then
				if arg_210_1.var_.characterEffect10030 then
					arg_210_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_210_1.var_.alphaOldValue10030, 1, (arg_210_1.time_ - 0) / var_213_3)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and arg_210_1.var_.characterEffect10030 then
				arg_210_1.var_.characterEffect10030.alpha = 1
			end

			local var_213_4 = arg_210_1.actors_["10030"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_4) and arg_210_1.var_.actorSpriteComps10030 == nil then
				arg_210_1.var_.actorSpriteComps10030 = var_213_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_5 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_5 and not isNil(var_213_4) then
				if arg_210_1.var_.actorSpriteComps10030 then
					for iter_213_1, iter_213_2 in pairs(arg_210_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_213_2 then
							if arg_210_1.isInRecall_ then
								iter_213_2.color = Color.New(Mathf.Lerp(iter_213_2.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_5), Mathf.Lerp(iter_213_2.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_5), (Mathf.Lerp(iter_213_2.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_5)))
							else
								local var_213_6 = Mathf.Lerp(iter_213_2.color.r, 1, (arg_210_1.time_ - 0) / var_213_5)

								iter_213_2.color = Color.New(var_213_6, var_213_6, var_213_6)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_5 and arg_210_1.time_ < 0 + var_213_5 + arg_213_0 and not isNil(var_213_4) and arg_210_1.var_.actorSpriteComps10030 then
				for iter_213_3, iter_213_4 in pairs(arg_210_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_213_4 then
						iter_213_4.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps10030 = nil
			end

			local var_213_7 = 0
			local var_213_8 = 0.15

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_9 = arg_210_1:GetWordFromCfg(115271051)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_12 = 6 <= 0 and var_213_8 or var_213_8 * (utf8.len(var_213_10) / 6)

				if (6 <= 0 and var_213_8 or var_213_8 * (utf8.len(var_213_10) / 6)) > 0 and var_213_8 < var_213_12 then
					arg_210_1.talkMaxDuration = var_213_12

					if var_213_12 + var_213_7 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_12 + var_213_7
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271051", "story_v_out_115271.awb") ~= 0 then
					local var_213_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271051", "story_v_out_115271.awb") / 1000

					if var_213_13 + var_213_7 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_7
					end

					if var_213_9.prefab_name ~= "" and arg_210_1.actors_[var_213_9.prefab_name] ~= nil then
						local var_213_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_9.prefab_name].transform, "story_v_out_115271", "115271051", "story_v_out_115271.awb")

						arg_210_1:RecordAudio("115271051", var_213_14)
						arg_210_1:RecordAudio("115271051", var_213_14)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_115271", "115271051", "story_v_out_115271.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_115271", "115271051", "story_v_out_115271.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_15 = math.max(var_213_8, arg_210_1.talkMaxDuration)

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_15 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_7) / var_213_15

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_7 + var_213_15 and arg_210_1.time_ < var_213_7 + var_213_15 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play115271052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 115271052
		arg_214_1.duration_ = 5.4

		local var_214_0 = {
			ja = 4.933,
			ko = 5.2,
			zh = 4.066,
			en = 5.4
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
				arg_214_0:Play115271053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10029"]) then
				local var_217_0 = arg_214_1.actors_["10029"]:GetComponent("Image")

				if var_217_0 then
					arg_214_1.var_.highlightMatValue10029 = var_217_0
				end
			end

			local var_217_1 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 and not isNil(arg_214_1.actors_["10029"]) then
				if arg_214_1.var_.highlightMatValue10029 then
					local var_217_2 = Mathf.Lerp(0.5, 1, (arg_214_1.time_ - 0) / var_217_1)

					arg_214_1.var_.highlightMatValue10029.color.r = var_217_2
					arg_214_1.var_.highlightMatValue10029.color.g = var_217_2
					arg_214_1.var_.highlightMatValue10029.color.b = var_217_2
					arg_214_1.var_.highlightMatValue10029.color = arg_214_1.var_.highlightMatValue10029.color
				end
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 and not isNil(arg_214_1.actors_["10029"]) and arg_214_1.var_.highlightMatValue10029 then
				arg_214_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_214_1.var_.highlightMatValue10029.color.r = 1
				arg_214_1.var_.highlightMatValue10029.color.g = 1
				arg_214_1.var_.highlightMatValue10029.color.b = 1
				arg_214_1.var_.highlightMatValue10029.color = arg_214_1.var_.highlightMatValue10029.color
			end

			local var_217_3 = arg_214_1.actors_["10029"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10029 = var_217_3.localPosition
				var_217_3.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_217_4 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				var_217_3.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_214_1.time_ - 0) / var_217_4)
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				var_217_3.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				local var_217_5 = arg_214_1.actors_["10029"]:GetComponent("Image")

				if var_217_5 then
					arg_214_1.var_.alphaMatValue10029 = var_217_5
					arg_214_1.var_.alphaOldValue10029 = var_217_5.color.a
				end

				arg_214_1.var_.alphaOldValue10029 = 0
			end

			local var_217_6 = 0.5

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_6 then
				if arg_214_1.var_.alphaMatValue10029 then
					arg_214_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_214_1.var_.alphaOldValue10029, 1, (arg_214_1.time_ - 0) / var_217_6)
					arg_214_1.var_.alphaMatValue10029.color = arg_214_1.var_.alphaMatValue10029.color
				end
			end

			if arg_214_1.time_ >= 0 + var_217_6 and arg_214_1.time_ < 0 + var_217_6 + arg_217_0 and arg_214_1.var_.alphaMatValue10029 then
				arg_214_1.var_.alphaMatValue10029.color.a = 1
				arg_214_1.var_.alphaMatValue10029.color = arg_214_1.var_.alphaMatValue10029.color
			end

			local var_217_7 = arg_214_1.actors_["10030"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.actorSpriteComps10030 == nil then
				arg_214_1.var_.actorSpriteComps10030 = var_217_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_8 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_8 and not isNil(var_217_7) then
				if arg_214_1.var_.actorSpriteComps10030 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_8), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_8), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_8)))
							else
								local var_217_9 = Mathf.Lerp(iter_217_1.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_8)

								iter_217_1.color = Color.New(var_217_9, var_217_9, var_217_9)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_8 and arg_214_1.time_ < 0 + var_217_8 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.actorSpriteComps10030 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps10030 = nil
			end

			local var_217_10 = 0
			local var_217_11 = 0.375

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_12 = arg_214_1:GetWordFromCfg(115271052)
				local var_217_13 = arg_214_1:FormatText(var_217_12.content)

				arg_214_1.text_.text = var_217_13

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_15 = 15 <= 0 and var_217_11 or var_217_11 * (utf8.len(var_217_13) / 15)

				if (15 <= 0 and var_217_11 or var_217_11 * (utf8.len(var_217_13) / 15)) > 0 and var_217_11 < var_217_15 then
					arg_214_1.talkMaxDuration = var_217_15

					if var_217_15 + var_217_10 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_15 + var_217_10
					end
				end

				arg_214_1.text_.text = var_217_13
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271052", "story_v_out_115271.awb") ~= 0 then
					local var_217_16 = manager.audio:GetVoiceLength("story_v_out_115271", "115271052", "story_v_out_115271.awb") / 1000

					if var_217_16 + var_217_10 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_16 + var_217_10
					end

					if var_217_12.prefab_name ~= "" and arg_214_1.actors_[var_217_12.prefab_name] ~= nil then
						local var_217_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_12.prefab_name].transform, "story_v_out_115271", "115271052", "story_v_out_115271.awb")

						arg_214_1:RecordAudio("115271052", var_217_17)
						arg_214_1:RecordAudio("115271052", var_217_17)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_115271", "115271052", "story_v_out_115271.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_115271", "115271052", "story_v_out_115271.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_18 = math.max(var_217_11, arg_214_1.talkMaxDuration)

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_18 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_10) / var_217_18

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_10 + var_217_18 and arg_214_1.time_ < var_217_10 + var_217_18 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play115271053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 115271053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play115271054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10029"]) then
				local var_221_0 = arg_218_1.actors_["10029"]:GetComponent("Image")

				if var_221_0 then
					arg_218_1.var_.highlightMatValue10029 = var_221_0
				end
			end

			local var_221_1 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 and not isNil(arg_218_1.actors_["10029"]) then
				if arg_218_1.var_.highlightMatValue10029 then
					local var_221_2 = Mathf.Lerp(1, 0.5, (arg_218_1.time_ - 0) / var_221_1)

					arg_218_1.var_.highlightMatValue10029.color.r = var_221_2
					arg_218_1.var_.highlightMatValue10029.color.g = var_221_2
					arg_218_1.var_.highlightMatValue10029.color.b = var_221_2
					arg_218_1.var_.highlightMatValue10029.color = arg_218_1.var_.highlightMatValue10029.color
				end
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 and not isNil(arg_218_1.actors_["10029"]) and arg_218_1.var_.highlightMatValue10029 then
				arg_218_1.var_.highlightMatValue10029.color.r = 0.5
				arg_218_1.var_.highlightMatValue10029.color.g = 0.5
				arg_218_1.var_.highlightMatValue10029.color.b = 0.5
				arg_218_1.var_.highlightMatValue10029.color = arg_218_1.var_.highlightMatValue10029.color
			end

			local var_221_3 = 0
			local var_221_4 = 1

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_3 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_5 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(115271053).content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 40 <= 0 and var_221_4 or var_221_4 * (utf8.len(var_221_5) / 40)

				if (40 <= 0 and var_221_4 or var_221_4 * (utf8.len(var_221_5) / 40)) > 0 and var_221_4 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_3 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_3
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_8 = math.max(var_221_4, arg_218_1.talkMaxDuration)

			if var_221_3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_3 + var_221_8 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_3) / var_221_8

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_3 + var_221_8 and arg_218_1.time_ < var_221_3 + var_221_8 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play115271054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 115271054
		arg_222_1.duration_ = 1.9

		local var_222_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.9,
			en = 1.1
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
				arg_222_0:Play115271055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.05

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:GetWordFromCfg(115271054)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 2 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 2)

				if (2 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 2)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271054", "story_v_out_115271.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271054", "story_v_out_115271.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_115271", "115271054", "story_v_out_115271.awb")

						arg_222_1:RecordAudio("115271054", var_225_6)
						arg_222_1:RecordAudio("115271054", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_115271", "115271054", "story_v_out_115271.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_115271", "115271054", "story_v_out_115271.awb")
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
	Play115271055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 115271055
		arg_226_1.duration_ = 2.6

		local var_226_0 = {
			ja = 2.1,
			ko = 1.4,
			zh = 2.6,
			en = 1.566
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
				arg_226_0:Play115271056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10030 = arg_226_1.actors_["10030"].transform.localPosition
				arg_226_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10030", 4)

				for iter_229_0 = 0, arg_226_1.actors_["10030"].transform.childCount - 1 do
					local var_229_0 = arg_226_1.actors_["10030"].transform:GetChild(iter_229_0)

					if var_229_0.name == "split_2" or not string.find(var_229_0.name, "split") then
						var_229_0.gameObject:SetActive(true)
					else
						var_229_0.gameObject:SetActive(false)
					end
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_226_1.time_ - 0) / var_229_1)
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_229_2 = arg_226_1.actors_["10030"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10030 == nil then
				arg_226_1.var_.actorSpriteComps10030 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps10030 then
					for iter_229_1, iter_229_2 in pairs(arg_226_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_229_2 then
							if arg_226_1.isInRecall_ then
								iter_229_2.color = Color.New(Mathf.Lerp(iter_229_2.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_2.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_2.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_2.color.r, 1, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_2.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10030 then
				for iter_229_3, iter_229_4 in pairs(arg_226_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_229_4 then
						iter_229_4.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				local var_229_5 = arg_226_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_229_5 then
					arg_226_1.var_.alphaOldValue10030 = var_229_5.alpha
					arg_226_1.var_.characterEffect10030 = var_229_5
				end

				arg_226_1.var_.alphaOldValue10030 = 0
			end

			local var_229_6 = 0.0166666666666667

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_6 then
				if arg_226_1.var_.characterEffect10030 then
					arg_226_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_226_1.var_.alphaOldValue10030, 1, (arg_226_1.time_ - 0) / var_229_6)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_6 and arg_226_1.time_ < 0 + var_229_6 + arg_229_0 and arg_226_1.var_.characterEffect10030 then
				arg_226_1.var_.characterEffect10030.alpha = 1
			end

			local var_229_7 = 0
			local var_229_8 = 0.125

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_7 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_9 = arg_226_1:GetWordFromCfg(115271055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_12 = 5 <= 0 and var_229_8 or var_229_8 * (utf8.len(var_229_10) / 5)

				if (5 <= 0 and var_229_8 or var_229_8 * (utf8.len(var_229_10) / 5)) > 0 and var_229_8 < var_229_12 then
					arg_226_1.talkMaxDuration = var_229_12

					if var_229_12 + var_229_7 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_7
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271055", "story_v_out_115271.awb") ~= 0 then
					local var_229_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271055", "story_v_out_115271.awb") / 1000

					if var_229_13 + var_229_7 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_7
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_115271", "115271055", "story_v_out_115271.awb")

						arg_226_1:RecordAudio("115271055", var_229_14)
						arg_226_1:RecordAudio("115271055", var_229_14)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_115271", "115271055", "story_v_out_115271.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_115271", "115271055", "story_v_out_115271.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_15 = math.max(var_229_8, arg_226_1.talkMaxDuration)

			if var_229_7 <= arg_226_1.time_ and arg_226_1.time_ < var_229_7 + var_229_15 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_7) / var_229_15

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_7 + var_229_15 and arg_226_1.time_ < var_229_7 + var_229_15 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play115271056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 115271056
		arg_230_1.duration_ = 13.9

		local var_230_0 = {
			ja = 13.9,
			ko = 10.2,
			zh = 8.266,
			en = 11.6
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
				arg_230_0:Play115271057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10030"]) and arg_230_1.var_.actorSpriteComps10030 == nil then
				arg_230_1.var_.actorSpriteComps10030 = arg_230_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10030"]) then
				if arg_230_1.var_.actorSpriteComps10030 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10030"]) and arg_230_1.var_.actorSpriteComps10030 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10030 = nil
			end

			local var_233_2 = arg_230_1.actors_["10029"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) then
				local var_233_3 = var_233_2:GetComponent("Image")

				if var_233_3 then
					arg_230_1.var_.highlightMatValue10029 = var_233_3
				end
			end

			local var_233_4 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 and not isNil(var_233_2) then
				if arg_230_1.var_.highlightMatValue10029 then
					local var_233_5 = Mathf.Lerp(0.5, 1, (arg_230_1.time_ - 0) / var_233_4)

					arg_230_1.var_.highlightMatValue10029.color.r = var_233_5
					arg_230_1.var_.highlightMatValue10029.color.g = var_233_5
					arg_230_1.var_.highlightMatValue10029.color.b = var_233_5
					arg_230_1.var_.highlightMatValue10029.color = arg_230_1.var_.highlightMatValue10029.color
				end
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.highlightMatValue10029 then
				var_233_2.transform:SetSiblingIndex(1)

				arg_230_1.var_.highlightMatValue10029.color.r = 1
				arg_230_1.var_.highlightMatValue10029.color.g = 1
				arg_230_1.var_.highlightMatValue10029.color.b = 1
				arg_230_1.var_.highlightMatValue10029.color = arg_230_1.var_.highlightMatValue10029.color
			end

			local var_233_6 = 0
			local var_233_7 = 0.9

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_8 = arg_230_1:GetWordFromCfg(115271056)
				local var_233_9 = arg_230_1:FormatText(var_233_8.content)

				arg_230_1.text_.text = var_233_9

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 36 <= 0 and var_233_7 or var_233_7 * (utf8.len(var_233_9) / 36)

				if (36 <= 0 and var_233_7 or var_233_7 * (utf8.len(var_233_9) / 36)) > 0 and var_233_7 < var_233_11 then
					arg_230_1.talkMaxDuration = var_233_11

					if var_233_11 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_9
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271056", "story_v_out_115271.awb") ~= 0 then
					local var_233_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271056", "story_v_out_115271.awb") / 1000

					if var_233_12 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_6
					end

					if var_233_8.prefab_name ~= "" and arg_230_1.actors_[var_233_8.prefab_name] ~= nil then
						local var_233_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_8.prefab_name].transform, "story_v_out_115271", "115271056", "story_v_out_115271.awb")

						arg_230_1:RecordAudio("115271056", var_233_13)
						arg_230_1:RecordAudio("115271056", var_233_13)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_115271", "115271056", "story_v_out_115271.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_115271", "115271056", "story_v_out_115271.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_14 and arg_230_1.time_ < var_233_6 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play115271057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 115271057
		arg_234_1.duration_ = 9.5

		local var_234_0 = {
			ja = 6,
			ko = 9.133,
			zh = 7.9,
			en = 9.5
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
				arg_234_0:Play115271058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.725

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:GetWordFromCfg(115271057)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 29 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 29)

				if (29 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 29)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271057", "story_v_out_115271.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271057", "story_v_out_115271.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_115271", "115271057", "story_v_out_115271.awb")

						arg_234_1:RecordAudio("115271057", var_237_6)
						arg_234_1:RecordAudio("115271057", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_115271", "115271057", "story_v_out_115271.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_115271", "115271057", "story_v_out_115271.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play115271058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 115271058
		arg_238_1.duration_ = 7.2

		local var_238_0 = {
			ja = 7.2,
			ko = 5.2,
			zh = 4.9,
			en = 5.1
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play115271059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10030"]) and arg_238_1.var_.actorSpriteComps10030 == nil then
				arg_238_1.var_.actorSpriteComps10030 = arg_238_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10030"]) then
				if arg_238_1.var_.actorSpriteComps10030 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 1, (arg_238_1.time_ - 0) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10030"]) and arg_238_1.var_.actorSpriteComps10030 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps10030 = nil
			end

			local var_241_2 = arg_238_1.actors_["10029"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) then
				local var_241_3 = var_241_2:GetComponent("Image")

				if var_241_3 then
					arg_238_1.var_.highlightMatValue10029 = var_241_3
				end
			end

			local var_241_4 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 and not isNil(var_241_2) then
				if arg_238_1.var_.highlightMatValue10029 then
					local var_241_5 = Mathf.Lerp(1, 0.5, (arg_238_1.time_ - 0) / var_241_4)

					arg_238_1.var_.highlightMatValue10029.color.r = var_241_5
					arg_238_1.var_.highlightMatValue10029.color.g = var_241_5
					arg_238_1.var_.highlightMatValue10029.color.b = var_241_5
					arg_238_1.var_.highlightMatValue10029.color = arg_238_1.var_.highlightMatValue10029.color
				end
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.highlightMatValue10029 then
				arg_238_1.var_.highlightMatValue10029.color.r = 0.5
				arg_238_1.var_.highlightMatValue10029.color.g = 0.5
				arg_238_1.var_.highlightMatValue10029.color.b = 0.5
				arg_238_1.var_.highlightMatValue10029.color = arg_238_1.var_.highlightMatValue10029.color
			end

			local var_241_6 = 0
			local var_241_7 = 0.5

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_8 = arg_238_1:GetWordFromCfg(115271058)
				local var_241_9 = arg_238_1:FormatText(var_241_8.content)

				arg_238_1.text_.text = var_241_9

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 20 <= 0 and var_241_7 or var_241_7 * (utf8.len(var_241_9) / 20)

				if (20 <= 0 and var_241_7 or var_241_7 * (utf8.len(var_241_9) / 20)) > 0 and var_241_7 < var_241_11 then
					arg_238_1.talkMaxDuration = var_241_11

					if var_241_11 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_11 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_9
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271058", "story_v_out_115271.awb") ~= 0 then
					local var_241_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271058", "story_v_out_115271.awb") / 1000

					if var_241_12 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_12 + var_241_6
					end

					if var_241_8.prefab_name ~= "" and arg_238_1.actors_[var_241_8.prefab_name] ~= nil then
						local var_241_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_8.prefab_name].transform, "story_v_out_115271", "115271058", "story_v_out_115271.awb")

						arg_238_1:RecordAudio("115271058", var_241_13)
						arg_238_1:RecordAudio("115271058", var_241_13)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_115271", "115271058", "story_v_out_115271.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_115271", "115271058", "story_v_out_115271.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_14 and arg_238_1.time_ < var_241_6 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play115271059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 115271059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play115271060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["10030"]) and arg_242_1.var_.actorSpriteComps10030 == nil then
				arg_242_1.var_.actorSpriteComps10030 = arg_242_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["10030"]) then
				if arg_242_1.var_.actorSpriteComps10030 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10030"]) and arg_242_1.var_.actorSpriteComps10030 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps10030 = nil
			end

			local var_245_2 = 0
			local var_245_3 = 0.625

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(115271059).content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_6 = 25 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_4) / 25)

				if (25 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_4) / 25)) > 0 and var_245_3 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_7 and arg_242_1.time_ < var_245_2 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play115271060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 115271060
		arg_246_1.duration_ = 9.57

		local var_246_0 = {
			ja = 9.566,
			ko = 4.366,
			zh = 5.733,
			en = 8.133
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play115271061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["10029"]) then
				local var_249_0 = arg_246_1.actors_["10029"]:GetComponent("Image")

				if var_249_0 then
					arg_246_1.var_.highlightMatValue10029 = var_249_0
				end
			end

			local var_249_1 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 and not isNil(arg_246_1.actors_["10029"]) then
				if arg_246_1.var_.highlightMatValue10029 then
					local var_249_2 = Mathf.Lerp(0.5, 1, (arg_246_1.time_ - 0) / var_249_1)

					arg_246_1.var_.highlightMatValue10029.color.r = var_249_2
					arg_246_1.var_.highlightMatValue10029.color.g = var_249_2
					arg_246_1.var_.highlightMatValue10029.color.b = var_249_2
					arg_246_1.var_.highlightMatValue10029.color = arg_246_1.var_.highlightMatValue10029.color
				end
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 and not isNil(arg_246_1.actors_["10029"]) and arg_246_1.var_.highlightMatValue10029 then
				arg_246_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_246_1.var_.highlightMatValue10029.color.r = 1
				arg_246_1.var_.highlightMatValue10029.color.g = 1
				arg_246_1.var_.highlightMatValue10029.color.b = 1
				arg_246_1.var_.highlightMatValue10029.color = arg_246_1.var_.highlightMatValue10029.color
			end

			local var_249_3 = 0
			local var_249_4 = 0.325

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_3 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:GetWordFromCfg(115271060)
				local var_249_6 = arg_246_1:FormatText(var_249_5.content)

				arg_246_1.text_.text = var_249_6

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_8 = 13 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_6) / 13)

				if (13 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_6) / 13)) > 0 and var_249_4 < var_249_8 then
					arg_246_1.talkMaxDuration = var_249_8

					if var_249_8 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_3
					end
				end

				arg_246_1.text_.text = var_249_6
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271060", "story_v_out_115271.awb") ~= 0 then
					local var_249_9 = manager.audio:GetVoiceLength("story_v_out_115271", "115271060", "story_v_out_115271.awb") / 1000

					if var_249_9 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_3
					end

					if var_249_5.prefab_name ~= "" and arg_246_1.actors_[var_249_5.prefab_name] ~= nil then
						local var_249_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_5.prefab_name].transform, "story_v_out_115271", "115271060", "story_v_out_115271.awb")

						arg_246_1:RecordAudio("115271060", var_249_10)
						arg_246_1:RecordAudio("115271060", var_249_10)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_115271", "115271060", "story_v_out_115271.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_115271", "115271060", "story_v_out_115271.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_11 = math.max(var_249_4, arg_246_1.talkMaxDuration)

			if var_249_3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_3 + var_249_11 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_3) / var_249_11

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_3 + var_249_11 and arg_246_1.time_ < var_249_3 + var_249_11 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play115271061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 115271061
		arg_250_1.duration_ = 8.87

		local var_250_0 = {
			ja = 8.866,
			ko = 6.6,
			zh = 5.5,
			en = 8.266
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
				arg_250_0:Play115271062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.675

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(115271061)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 27 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 27)

				if (27 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 27)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271061", "story_v_out_115271.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271061", "story_v_out_115271.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_115271", "115271061", "story_v_out_115271.awb")

						arg_250_1:RecordAudio("115271061", var_253_6)
						arg_250_1:RecordAudio("115271061", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_115271", "115271061", "story_v_out_115271.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_115271", "115271061", "story_v_out_115271.awb")
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
	Play115271062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 115271062
		arg_254_1.duration_ = 12.1

		local var_254_0 = {
			ja = 10.466,
			ko = 10.066,
			zh = 9.933,
			en = 12.1
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play115271063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				local var_257_0 = arg_254_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_257_0 then
					arg_254_1.var_.alphaOldValue10030 = var_257_0.alpha
					arg_254_1.var_.characterEffect10030 = var_257_0
				end

				arg_254_1.var_.alphaOldValue10030 = 1
			end

			local var_257_1 = 0.5

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_1 then
				if arg_254_1.var_.characterEffect10030 then
					arg_254_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_254_1.var_.alphaOldValue10030, 0, (arg_254_1.time_ - 0) / var_257_1)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_1 and arg_254_1.time_ < 0 + var_257_1 + arg_257_0 and arg_254_1.var_.characterEffect10030 then
				arg_254_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				local var_257_2 = arg_254_1.actors_["10029"]:GetComponent("Image")

				if var_257_2 then
					arg_254_1.var_.alphaMatValue10029 = var_257_2
					arg_254_1.var_.alphaOldValue10029 = var_257_2.color.a
				end

				arg_254_1.var_.alphaOldValue10029 = 1
			end

			local var_257_3 = 0.5

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 then
				if arg_254_1.var_.alphaMatValue10029 then
					arg_254_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_254_1.var_.alphaOldValue10029, 0, (arg_254_1.time_ - 0) / var_257_3)
					arg_254_1.var_.alphaMatValue10029.color = arg_254_1.var_.alphaMatValue10029.color
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and arg_254_1.var_.alphaMatValue10029 then
				arg_254_1.var_.alphaMatValue10029.color.a = 0
				arg_254_1.var_.alphaMatValue10029.color = arg_254_1.var_.alphaMatValue10029.color
			end

			local var_257_4 = 0
			local var_257_5 = 0.85

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[224].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_6 = arg_254_1:GetWordFromCfg(115271062)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 34 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 34)

				if (34 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 34)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271062", "story_v_out_115271.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_out_115271", "115271062", "story_v_out_115271.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_out_115271", "115271062", "story_v_out_115271.awb")

						arg_254_1:RecordAudio("115271062", var_257_11)
						arg_254_1:RecordAudio("115271062", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_115271", "115271062", "story_v_out_115271.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_115271", "115271062", "story_v_out_115271.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play115271063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 115271063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play115271064(arg_258_1)
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

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(115271063).content)

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
	Play115271064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 115271064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play115271065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks", "")
			end

			local var_265_1 = 0
			local var_265_2 = 1.825

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(115271064).content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 73 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 73)

				if (73 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 73)) > 0 and var_265_2 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_6 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_6 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_6

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_6 and arg_262_1.time_ < var_265_1 + var_265_6 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play115271065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 115271065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play115271066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			local var_269_1 = 0
			local var_269_2 = 1.55

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(115271065).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 62 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 62)

				if (62 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 62)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play115271066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 115271066
		arg_270_1.duration_ = 4.53

		local var_270_0 = {
			ja = 1.466,
			ko = 3.5,
			zh = 2.6,
			en = 4.533
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
				arg_270_0:Play115271067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10030 = arg_270_1.actors_["10030"].transform.localPosition
				arg_270_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10030", 4)

				for iter_273_0 = 0, arg_270_1.actors_["10030"].transform.childCount - 1 do
					local var_273_0 = arg_270_1.actors_["10030"].transform:GetChild(iter_273_0)

					if var_273_0.name == "split_1" or not string.find(var_273_0.name, "split") then
						var_273_0.gameObject:SetActive(true)
					else
						var_273_0.gameObject:SetActive(false)
					end
				end
			end

			local var_273_1 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_1 then
				arg_270_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_270_1.time_ - 0) / var_273_1)
			end

			if arg_270_1.time_ >= 0 + var_273_1 and arg_270_1.time_ < 0 + var_273_1 + arg_273_0 then
				arg_270_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_2 = arg_270_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_273_2 then
					arg_270_1.var_.alphaOldValue10030 = var_273_2.alpha
					arg_270_1.var_.characterEffect10030 = var_273_2
				end

				arg_270_1.var_.alphaOldValue10030 = 0
			end

			local var_273_3 = 0.5

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 then
				if arg_270_1.var_.characterEffect10030 then
					arg_270_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_270_1.var_.alphaOldValue10030, 1, (arg_270_1.time_ - 0) / var_273_3)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and arg_270_1.var_.characterEffect10030 then
				arg_270_1.var_.characterEffect10030.alpha = 1
			end

			local var_273_4 = arg_270_1.actors_["10030"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.actorSpriteComps10030 == nil then
				arg_270_1.var_.actorSpriteComps10030 = var_273_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_5 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_5 and not isNil(var_273_4) then
				if arg_270_1.var_.actorSpriteComps10030 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								iter_273_2.color = Color.New(Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_5), Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_5), (Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_5)))
							else
								local var_273_6 = Mathf.Lerp(iter_273_2.color.r, 1, (arg_270_1.time_ - 0) / var_273_5)

								iter_273_2.color = Color.New(var_273_6, var_273_6, var_273_6)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_5 and arg_270_1.time_ < 0 + var_273_5 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.actorSpriteComps10030 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_273_4 then
						iter_273_4.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps10030 = nil
			end

			local var_273_7 = 0
			local var_273_8 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_7 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:GetWordFromCfg(115271066)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_12 = 11 <= 0 and var_273_8 or var_273_8 * (utf8.len(var_273_10) / 11)

				if (11 <= 0 and var_273_8 or var_273_8 * (utf8.len(var_273_10) / 11)) > 0 and var_273_8 < var_273_12 then
					arg_270_1.talkMaxDuration = var_273_12

					if var_273_12 + var_273_7 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_7
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271066", "story_v_out_115271.awb") ~= 0 then
					local var_273_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271066", "story_v_out_115271.awb") / 1000

					if var_273_13 + var_273_7 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_7
					end

					if var_273_9.prefab_name ~= "" and arg_270_1.actors_[var_273_9.prefab_name] ~= nil then
						local var_273_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_9.prefab_name].transform, "story_v_out_115271", "115271066", "story_v_out_115271.awb")

						arg_270_1:RecordAudio("115271066", var_273_14)
						arg_270_1:RecordAudio("115271066", var_273_14)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_115271", "115271066", "story_v_out_115271.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_115271", "115271066", "story_v_out_115271.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_15 = math.max(var_273_8, arg_270_1.talkMaxDuration)

			if var_273_7 <= arg_270_1.time_ and arg_270_1.time_ < var_273_7 + var_273_15 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_7) / var_273_15

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_7 + var_273_15 and arg_270_1.time_ < var_273_7 + var_273_15 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play115271067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 115271067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play115271068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["10030"]) and arg_274_1.var_.actorSpriteComps10030 == nil then
				arg_274_1.var_.actorSpriteComps10030 = arg_274_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["10030"]) then
				if arg_274_1.var_.actorSpriteComps10030 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								iter_277_1.color = Color.New(Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_0), Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_0), (Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_0)))
							else
								local var_277_1 = Mathf.Lerp(iter_277_1.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_0)

								iter_277_1.color = Color.New(var_277_1, var_277_1, var_277_1)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["10030"]) and arg_274_1.var_.actorSpriteComps10030 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_277_3 then
						iter_277_3.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps10030 = nil
			end

			local var_277_2 = 0
			local var_277_3 = 0.5

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(115271067).content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 20 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 20)

				if (20 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 20)) > 0 and var_277_3 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_7 and arg_274_1.time_ < var_277_2 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play115271068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 115271068
		arg_278_1.duration_ = 16.67

		local var_278_0 = {
			ja = 9.4,
			ko = 12.1,
			zh = 8.2,
			en = 16.666
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play115271069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["10029"]) then
				local var_281_0 = arg_278_1.actors_["10029"]:GetComponent("Image")

				if var_281_0 then
					arg_278_1.var_.highlightMatValue10029 = var_281_0
				end
			end

			local var_281_1 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 and not isNil(arg_278_1.actors_["10029"]) then
				if arg_278_1.var_.highlightMatValue10029 then
					local var_281_2 = Mathf.Lerp(0.5, 1, (arg_278_1.time_ - 0) / var_281_1)

					arg_278_1.var_.highlightMatValue10029.color.r = var_281_2
					arg_278_1.var_.highlightMatValue10029.color.g = var_281_2
					arg_278_1.var_.highlightMatValue10029.color.b = var_281_2
					arg_278_1.var_.highlightMatValue10029.color = arg_278_1.var_.highlightMatValue10029.color
				end
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 and not isNil(arg_278_1.actors_["10029"]) and arg_278_1.var_.highlightMatValue10029 then
				arg_278_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_278_1.var_.highlightMatValue10029.color.r = 1
				arg_278_1.var_.highlightMatValue10029.color.g = 1
				arg_278_1.var_.highlightMatValue10029.color.b = 1
				arg_278_1.var_.highlightMatValue10029.color = arg_278_1.var_.highlightMatValue10029.color
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				local var_281_3 = arg_278_1.actors_["10029"]:GetComponent("Image")

				if var_281_3 then
					arg_278_1.var_.alphaMatValue10029 = var_281_3
					arg_278_1.var_.alphaOldValue10029 = var_281_3.color.a
				end

				arg_278_1.var_.alphaOldValue10029 = 0
			end

			local var_281_4 = 0.5

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				if arg_278_1.var_.alphaMatValue10029 then
					arg_278_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_278_1.var_.alphaOldValue10029, 1, (arg_278_1.time_ - 0) / var_281_4)
					arg_278_1.var_.alphaMatValue10029.color = arg_278_1.var_.alphaMatValue10029.color
				end
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 and arg_278_1.var_.alphaMatValue10029 then
				arg_278_1.var_.alphaMatValue10029.color.a = 1
				arg_278_1.var_.alphaMatValue10029.color = arg_278_1.var_.alphaMatValue10029.color
			end

			local var_281_5 = 0
			local var_281_6 = 0.975

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_7 = arg_278_1:GetWordFromCfg(115271068)
				local var_281_8 = arg_278_1:FormatText(var_281_7.content)

				arg_278_1.text_.text = var_281_8

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_10 = 39 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_8) / 39)

				if (39 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_8) / 39)) > 0 and var_281_6 < var_281_10 then
					arg_278_1.talkMaxDuration = var_281_10

					if var_281_10 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_8
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271068", "story_v_out_115271.awb") ~= 0 then
					local var_281_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271068", "story_v_out_115271.awb") / 1000

					if var_281_11 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_11 + var_281_5
					end

					if var_281_7.prefab_name ~= "" and arg_278_1.actors_[var_281_7.prefab_name] ~= nil then
						local var_281_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_7.prefab_name].transform, "story_v_out_115271", "115271068", "story_v_out_115271.awb")

						arg_278_1:RecordAudio("115271068", var_281_12)
						arg_278_1:RecordAudio("115271068", var_281_12)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_115271", "115271068", "story_v_out_115271.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_115271", "115271068", "story_v_out_115271.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_13 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_13 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_5) / var_281_13

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_5 + var_281_13 and arg_278_1.time_ < var_281_5 + var_281_13 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play115271069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 115271069
		arg_282_1.duration_ = 6

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play115271070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_0 = arg_282_1.actors_["10029"]:GetComponent("Image")

				if var_285_0 then
					arg_282_1.var_.alphaMatValue10029 = var_285_0
					arg_282_1.var_.alphaOldValue10029 = var_285_0.color.a
				end

				arg_282_1.var_.alphaOldValue10029 = 1
			end

			local var_285_1 = 0.5

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				if arg_282_1.var_.alphaMatValue10029 then
					arg_282_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_282_1.var_.alphaOldValue10029, 0, (arg_282_1.time_ - 0) / var_285_1)
					arg_282_1.var_.alphaMatValue10029.color = arg_282_1.var_.alphaMatValue10029.color
				end
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 and arg_282_1.var_.alphaMatValue10029 then
				arg_282_1.var_.alphaMatValue10029.color.a = 0
				arg_282_1.var_.alphaMatValue10029.color = arg_282_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_2 = arg_282_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_285_2 then
					arg_282_1.var_.alphaOldValue10030 = var_285_2.alpha
					arg_282_1.var_.characterEffect10030 = var_285_2
				end

				arg_282_1.var_.alphaOldValue10030 = 1
			end

			local var_285_3 = 0.5

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 then
				if arg_282_1.var_.characterEffect10030 then
					arg_282_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_282_1.var_.alphaOldValue10030, 0, (arg_282_1.time_ - 0) / var_285_3)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and arg_282_1.var_.characterEffect10030 then
				arg_282_1.var_.characterEffect10030.alpha = 0
			end

			local var_285_4 = manager.ui.mainCamera.transform

			if 1 < arg_282_1.time_ and arg_282_1.time_ <= 1 + arg_285_0 then
				arg_282_1.var_.shakeOldPos = var_285_4.localPosition
			end

			local var_285_5 = 0.6

			if 1 <= arg_282_1.time_ and arg_282_1.time_ < 1 + var_285_5 then
				local var_285_6, var_285_7 = math.modf((arg_282_1.time_ - 1) / 0.066)

				var_285_4.localPosition = Vector3.New(var_285_7 * 0.13, var_285_7 * 0.13, var_285_7 * 0.13) + arg_282_1.var_.shakeOldPos
			end

			if arg_282_1.time_ >= 1 + var_285_5 and arg_282_1.time_ < 1 + var_285_5 + arg_285_0 then
				var_285_4.localPosition = arg_282_1.var_.shakeOldPos
			end

			local var_285_8 = 0

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			if arg_282_1.time_ >= var_285_8 + 1.6 and arg_282_1.time_ < var_285_8 + 1.6 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:AudioAction("stop", "music", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")

				local var_285_11 = manager.audio:GetAudioName("se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop")

				if "" ~= "" then
					if arg_282_1.bgmTxt_.text ~= var_285_11 and arg_282_1.bgmTxt_.text ~= "" then
						if arg_282_1.bgmTxt2_.text ~= "" then
							arg_282_1.bgmTxt_.text = arg_282_1.bgmTxt2_.text
						end

						arg_282_1.bgmTxt2_.text = var_285_11

						arg_282_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_282_1.bgmTxt_.text = var_285_11
						arg_282_1.bgmTxt2_.text = var_285_11
					end

					if arg_282_1.bgmTimer then
						arg_282_1.bgmTimer:Stop()

						arg_282_1.bgmTimer = nil
					end

					if arg_282_1.settingData.show_music_name == 1 then
						arg_282_1.musicController:SetSelectedState("show")
						arg_282_1.musicAnimator_:Play("open", 0, 0)

						if arg_282_1.settingData.music_time ~= 0 then
							arg_282_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_282_1.settingData.music_time), function()
								if arg_282_1 == nil or isNil(arg_282_1.bgmTxt_) then
									return
								end

								arg_282_1.musicController:SetSelectedState("hide")
								arg_282_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks03", "")
			end

			local var_285_13 = 1

			if 1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_13 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = false

				arg_282_1:SetGaussion(false)
			end

			local var_285_14 = 0.5

			if var_285_13 <= arg_282_1.time_ and arg_282_1.time_ < var_285_13 + var_285_14 then
				local var_285_15 = Color.New(1, 1, 1)

				var_285_15.a = Mathf.Lerp(1, 0, (arg_282_1.time_ - var_285_13) / var_285_14)
				arg_282_1.mask_.color = var_285_15
			end

			if arg_282_1.time_ >= var_285_13 + var_285_14 and arg_282_1.time_ < var_285_13 + var_285_14 + arg_285_0 then
				local var_285_16 = Color.New(1, 1, 1)

				arg_282_1.mask_.enabled = false
				var_285_16.a = 0
				arg_282_1.mask_.color = var_285_16
			end

			local var_285_17 = 1
			local var_285_18 = 0.075

			if 1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_17 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_19 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(115271069).content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_21 = 3 <= 0 and var_285_18 or var_285_18 * (utf8.len(var_285_19) / 3)

				if (3 <= 0 and var_285_18 or var_285_18 * (utf8.len(var_285_19) / 3)) > 0 and var_285_18 < var_285_21 then
					arg_282_1.talkMaxDuration = var_285_21

					if var_285_21 + var_285_17 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_21 + var_285_17
					end
				end

				arg_282_1.text_.text = var_285_19
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_22 = math.max(var_285_18, arg_282_1.talkMaxDuration)

			if var_285_17 <= arg_282_1.time_ and arg_282_1.time_ < var_285_17 + var_285_22 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_17) / var_285_22

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_17 + var_285_22 and arg_282_1.time_ < var_285_17 + var_285_22 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play115271070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 115271070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play115271071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.075

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(115271070).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 43 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 43)

				if (43 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 43)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play115271071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 115271071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play115271072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 1.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(115271071).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 52 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 52)

				if (52 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 52)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play115271072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 115271072
		arg_295_1.duration_ = 2.73

		local var_295_0 = {
			ja = 2.5,
			ko = 1.566,
			zh = 2.733,
			en = 1.733
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
				arg_295_0:Play115271073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.125

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_2")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(115271072)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 5 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 5)

				if (5 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 5)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271072", "story_v_out_115271.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271072", "story_v_out_115271.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_115271", "115271072", "story_v_out_115271.awb")

						arg_295_1:RecordAudio("115271072", var_298_6)
						arg_295_1:RecordAudio("115271072", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_115271", "115271072", "story_v_out_115271.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_115271", "115271072", "story_v_out_115271.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play115271073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 115271073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play115271074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_0 = arg_299_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_302_0 then
					arg_299_1.var_.alphaOldValue10030 = var_302_0.alpha
					arg_299_1.var_.characterEffect10030 = var_302_0
				end

				arg_299_1.var_.alphaOldValue10030 = 1
			end

			local var_302_1 = 0.5

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				if arg_299_1.var_.characterEffect10030 then
					arg_299_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_299_1.var_.alphaOldValue10030, 0, (arg_299_1.time_ - 0) / var_302_1)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 and arg_299_1.var_.characterEffect10030 then
				arg_299_1.var_.characterEffect10030.alpha = 0
			end

			local var_302_2 = 0
			local var_302_3 = 1.325

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(115271073).content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_6 = 53 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_4) / 53)

				if (53 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_4) / 53)) > 0 and var_302_3 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_7 and arg_299_1.time_ < var_302_2 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play115271074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 115271074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play115271075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(115271074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 42 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 42)

				if (42 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 42)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play115271075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 115271075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play115271076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.6

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(115271075).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 24 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 24)

				if (24 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 24)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play115271076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 115271076
		arg_311_1.duration_ = 6.77

		local var_311_0 = {
			ja = 4.2,
			ko = 2.933,
			zh = 3.366,
			en = 6.766
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
				arg_311_0:Play115271077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.325

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:GetWordFromCfg(115271076)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 13 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 13)

				if (13 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 13)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271076", "story_v_out_115271.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271076", "story_v_out_115271.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_115271", "115271076", "story_v_out_115271.awb")

						arg_311_1:RecordAudio("115271076", var_314_6)
						arg_311_1:RecordAudio("115271076", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_115271", "115271076", "story_v_out_115271.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_115271", "115271076", "story_v_out_115271.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play115271077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 115271077
		arg_315_1.duration_ = 7.5

		local var_315_0 = {
			ja = 4.566,
			ko = 5.933,
			zh = 6,
			en = 7.5
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
				arg_315_0:Play115271078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.575

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:GetWordFromCfg(115271077)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 23 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 23)

				if (23 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 23)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271077", "story_v_out_115271.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271077", "story_v_out_115271.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_115271", "115271077", "story_v_out_115271.awb")

						arg_315_1:RecordAudio("115271077", var_318_6)
						arg_315_1:RecordAudio("115271077", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_115271", "115271077", "story_v_out_115271.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_115271", "115271077", "story_v_out_115271.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play115271078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115271078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play115271079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.2

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(115271078).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 48 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 48)

				if (48 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 48)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play115271079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115271079
		arg_323_1.duration_ = 5.17

		local var_323_0 = {
			ja = 5.166,
			ko = 2.733,
			zh = 3.3,
			en = 2.5
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
				arg_323_0:Play115271080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10030 = arg_323_1.actors_["10030"].transform.localPosition
				arg_323_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10030", 3)

				for iter_326_0 = 0, arg_323_1.actors_["10030"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["10030"].transform:GetChild(iter_326_0)

					if var_326_0.name == "split_2" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_326_2 = arg_323_1.actors_["10030"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10030 == nil then
				arg_323_1.var_.actorSpriteComps10030 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps10030 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 1, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10030 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				local var_326_5 = arg_323_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_5 then
					arg_323_1.var_.alphaOldValue10030 = var_326_5.alpha
					arg_323_1.var_.characterEffect10030 = var_326_5
				end

				arg_323_1.var_.alphaOldValue10030 = 0
			end

			local var_326_6 = 0.5

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 then
				if arg_323_1.var_.characterEffect10030 then
					arg_323_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_323_1.var_.alphaOldValue10030, 1, (arg_323_1.time_ - 0) / var_326_6)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 and arg_323_1.var_.characterEffect10030 then
				arg_323_1.var_.characterEffect10030.alpha = 1
			end

			local var_326_7 = 0
			local var_326_8 = 0.2

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_9 = arg_323_1:GetWordFromCfg(115271079)
				local var_326_10 = arg_323_1:FormatText(var_326_9.content)

				arg_323_1.text_.text = var_326_10

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_12 = 8 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_10) / 8)

				if (8 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_10) / 8)) > 0 and var_326_8 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_7
					end
				end

				arg_323_1.text_.text = var_326_10
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271079", "story_v_out_115271.awb") ~= 0 then
					local var_326_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271079", "story_v_out_115271.awb") / 1000

					if var_326_13 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_7
					end

					if var_326_9.prefab_name ~= "" and arg_323_1.actors_[var_326_9.prefab_name] ~= nil then
						local var_326_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_9.prefab_name].transform, "story_v_out_115271", "115271079", "story_v_out_115271.awb")

						arg_323_1:RecordAudio("115271079", var_326_14)
						arg_323_1:RecordAudio("115271079", var_326_14)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_115271", "115271079", "story_v_out_115271.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_115271", "115271079", "story_v_out_115271.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_15 = math.max(var_326_8, arg_323_1.talkMaxDuration)

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_15 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_7) / var_326_15

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_7 + var_326_15 and arg_323_1.time_ < var_326_7 + var_326_15 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play115271080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115271080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play115271081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				local var_330_0 = arg_327_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_330_0 then
					arg_327_1.var_.alphaOldValue10030 = var_330_0.alpha
					arg_327_1.var_.characterEffect10030 = var_330_0
				end

				arg_327_1.var_.alphaOldValue10030 = 1
			end

			local var_330_1 = 0.5

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 then
				if arg_327_1.var_.characterEffect10030 then
					arg_327_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_327_1.var_.alphaOldValue10030, 0, (arg_327_1.time_ - 0) / var_330_1)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 and arg_327_1.var_.characterEffect10030 then
				arg_327_1.var_.characterEffect10030.alpha = 0
			end

			local var_330_2 = 0
			local var_330_3 = 0.55

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_4 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(115271080).content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 22 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_4) / 22)

				if (22 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_4) / 22)) > 0 and var_330_3 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_7 and arg_327_1.time_ < var_330_2 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play115271081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115271081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115271082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.375

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(115271081).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 55 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 55)

				if (55 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 55)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play115271082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115271082
		arg_335_1.duration_ = 10.93

		local var_335_0 = {
			ja = 7.666,
			ko = 7.866,
			zh = 7.3,
			en = 10.933
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
				arg_335_0:Play115271083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10029 = arg_335_1.actors_["10029"].transform.localPosition
				arg_335_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_335_1.time_ - 0) / var_338_0)
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["10029"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				local var_338_1 = arg_335_1.actors_["10029"]:GetComponent("Image")

				if var_338_1 then
					arg_335_1.var_.alphaMatValue10029 = var_338_1
					arg_335_1.var_.alphaOldValue10029 = var_338_1.color.a
				end

				arg_335_1.var_.alphaOldValue10029 = 0
			end

			local var_338_2 = 0.5

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 then
				if arg_335_1.var_.alphaMatValue10029 then
					arg_335_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_335_1.var_.alphaOldValue10029, 1, (arg_335_1.time_ - 0) / var_338_2)
					arg_335_1.var_.alphaMatValue10029.color = arg_335_1.var_.alphaMatValue10029.color
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and arg_335_1.var_.alphaMatValue10029 then
				arg_335_1.var_.alphaMatValue10029.color.a = 1
				arg_335_1.var_.alphaMatValue10029.color = arg_335_1.var_.alphaMatValue10029.color
			end

			local var_338_3 = arg_335_1.actors_["10029"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) then
				local var_338_4 = var_338_3:GetComponent("Image")

				if var_338_4 then
					arg_335_1.var_.highlightMatValue10029 = var_338_4
				end
			end

			local var_338_5 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_5 and not isNil(var_338_3) then
				if arg_335_1.var_.highlightMatValue10029 then
					local var_338_6 = Mathf.Lerp(0.5, 1, (arg_335_1.time_ - 0) / var_338_5)

					arg_335_1.var_.highlightMatValue10029.color.r = var_338_6
					arg_335_1.var_.highlightMatValue10029.color.g = var_338_6
					arg_335_1.var_.highlightMatValue10029.color.b = var_338_6
					arg_335_1.var_.highlightMatValue10029.color = arg_335_1.var_.highlightMatValue10029.color
				end
			end

			if arg_335_1.time_ >= 0 + var_338_5 and arg_335_1.time_ < 0 + var_338_5 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.highlightMatValue10029 then
				var_338_3.transform:SetSiblingIndex(1)

				arg_335_1.var_.highlightMatValue10029.color.r = 1
				arg_335_1.var_.highlightMatValue10029.color.g = 1
				arg_335_1.var_.highlightMatValue10029.color.b = 1
				arg_335_1.var_.highlightMatValue10029.color = arg_335_1.var_.highlightMatValue10029.color
			end

			local var_338_7 = 0
			local var_338_8 = 0.7

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_9 = arg_335_1:GetWordFromCfg(115271082)
				local var_338_10 = arg_335_1:FormatText(var_338_9.content)

				arg_335_1.text_.text = var_338_10

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_12 = 28 <= 0 and var_338_8 or var_338_8 * (utf8.len(var_338_10) / 28)

				if (28 <= 0 and var_338_8 or var_338_8 * (utf8.len(var_338_10) / 28)) > 0 and var_338_8 < var_338_12 then
					arg_335_1.talkMaxDuration = var_338_12

					if var_338_12 + var_338_7 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_7
					end
				end

				arg_335_1.text_.text = var_338_10
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271082", "story_v_out_115271.awb") ~= 0 then
					local var_338_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271082", "story_v_out_115271.awb") / 1000

					if var_338_13 + var_338_7 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_7
					end

					if var_338_9.prefab_name ~= "" and arg_335_1.actors_[var_338_9.prefab_name] ~= nil then
						local var_338_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_9.prefab_name].transform, "story_v_out_115271", "115271082", "story_v_out_115271.awb")

						arg_335_1:RecordAudio("115271082", var_338_14)
						arg_335_1:RecordAudio("115271082", var_338_14)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115271", "115271082", "story_v_out_115271.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115271", "115271082", "story_v_out_115271.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_15 = math.max(var_338_8, arg_335_1.talkMaxDuration)

			if var_338_7 <= arg_335_1.time_ and arg_335_1.time_ < var_338_7 + var_338_15 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_7) / var_338_15

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_7 + var_338_15 and arg_335_1.time_ < var_338_7 + var_338_15 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play115271083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115271083
		arg_339_1.duration_ = 7.33

		local var_339_0 = {
			ja = 6.466,
			ko = 7.333,
			zh = 6.4,
			en = 6.2
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
				arg_339_0:Play115271084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10030 = arg_339_1.actors_["10030"].transform.localPosition
				arg_339_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10030", 4)

				for iter_342_0 = 0, arg_339_1.actors_["10030"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["10030"].transform:GetChild(iter_342_0)

					if var_342_0.name == "split_2" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				local var_342_2 = arg_339_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_342_2 then
					arg_339_1.var_.alphaOldValue10030 = var_342_2.alpha
					arg_339_1.var_.characterEffect10030 = var_342_2
				end

				arg_339_1.var_.alphaOldValue10030 = 0
			end

			local var_342_3 = 0.5

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 then
				if arg_339_1.var_.characterEffect10030 then
					arg_339_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_339_1.var_.alphaOldValue10030, 1, (arg_339_1.time_ - 0) / var_342_3)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and arg_339_1.var_.characterEffect10030 then
				arg_339_1.var_.characterEffect10030.alpha = 1
			end

			local var_342_4 = arg_339_1.actors_["10030"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.actorSpriteComps10030 == nil then
				arg_339_1.var_.actorSpriteComps10030 = var_342_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_5 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_5 and not isNil(var_342_4) then
				if arg_339_1.var_.actorSpriteComps10030 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								iter_342_2.color = Color.New(Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_5), Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_5), (Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_5)))
							else
								local var_342_6 = Mathf.Lerp(iter_342_2.color.r, 1, (arg_339_1.time_ - 0) / var_342_5)

								iter_342_2.color = Color.New(var_342_6, var_342_6, var_342_6)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_5 and arg_339_1.time_ < 0 + var_342_5 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.actorSpriteComps10030 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_342_4 then
						iter_342_4.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps10030 = nil
			end

			local var_342_7 = arg_339_1.actors_["10029"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_7) then
				local var_342_8 = var_342_7:GetComponent("Image")

				if var_342_8 then
					arg_339_1.var_.highlightMatValue10029 = var_342_8
				end
			end

			local var_342_9 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_9 and not isNil(var_342_7) then
				if arg_339_1.var_.highlightMatValue10029 then
					local var_342_10 = Mathf.Lerp(1, 0.5, (arg_339_1.time_ - 0) / var_342_9)

					arg_339_1.var_.highlightMatValue10029.color.r = var_342_10
					arg_339_1.var_.highlightMatValue10029.color.g = var_342_10
					arg_339_1.var_.highlightMatValue10029.color.b = var_342_10
					arg_339_1.var_.highlightMatValue10029.color = arg_339_1.var_.highlightMatValue10029.color
				end
			end

			if arg_339_1.time_ >= 0 + var_342_9 and arg_339_1.time_ < 0 + var_342_9 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.highlightMatValue10029 then
				arg_339_1.var_.highlightMatValue10029.color.r = 0.5
				arg_339_1.var_.highlightMatValue10029.color.g = 0.5
				arg_339_1.var_.highlightMatValue10029.color.b = 0.5
				arg_339_1.var_.highlightMatValue10029.color = arg_339_1.var_.highlightMatValue10029.color
			end

			local var_342_11 = 0
			local var_342_12 = 0.525

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_11 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_13 = arg_339_1:GetWordFromCfg(115271083)
				local var_342_14 = arg_339_1:FormatText(var_342_13.content)

				arg_339_1.text_.text = var_342_14

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_16 = 21 <= 0 and var_342_12 or var_342_12 * (utf8.len(var_342_14) / 21)

				if (21 <= 0 and var_342_12 or var_342_12 * (utf8.len(var_342_14) / 21)) > 0 and var_342_12 < var_342_16 then
					arg_339_1.talkMaxDuration = var_342_16

					if var_342_16 + var_342_11 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_16 + var_342_11
					end
				end

				arg_339_1.text_.text = var_342_14
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271083", "story_v_out_115271.awb") ~= 0 then
					local var_342_17 = manager.audio:GetVoiceLength("story_v_out_115271", "115271083", "story_v_out_115271.awb") / 1000

					if var_342_17 + var_342_11 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_17 + var_342_11
					end

					if var_342_13.prefab_name ~= "" and arg_339_1.actors_[var_342_13.prefab_name] ~= nil then
						local var_342_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_13.prefab_name].transform, "story_v_out_115271", "115271083", "story_v_out_115271.awb")

						arg_339_1:RecordAudio("115271083", var_342_18)
						arg_339_1:RecordAudio("115271083", var_342_18)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115271", "115271083", "story_v_out_115271.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115271", "115271083", "story_v_out_115271.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_19 = math.max(var_342_12, arg_339_1.talkMaxDuration)

			if var_342_11 <= arg_339_1.time_ and arg_339_1.time_ < var_342_11 + var_342_19 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_11) / var_342_19

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_11 + var_342_19 and arg_339_1.time_ < var_342_11 + var_342_19 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115271084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 115271084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play115271085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10030"]) and arg_343_1.var_.actorSpriteComps10030 == nil then
				arg_343_1.var_.actorSpriteComps10030 = arg_343_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10030"]) then
				if arg_343_1.var_.actorSpriteComps10030 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10030"]) and arg_343_1.var_.actorSpriteComps10030 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10030 = nil
			end

			local var_346_2 = 0
			local var_346_3 = 0.75

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(115271084).content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 30 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 30)

				if (30 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 30)) > 0 and var_346_3 < var_346_6 then
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
	Play115271085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 115271085
		arg_347_1.duration_ = 10.77

		local var_347_0 = {
			ja = 10.766,
			ko = 7.8,
			zh = 5.4,
			en = 6.466
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
				arg_347_0:Play115271086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10030 = arg_347_1.actors_["10030"].transform.localPosition
				arg_347_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10030", 4)

				for iter_350_0 = 0, arg_347_1.actors_["10030"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["10030"].transform:GetChild(iter_350_0)

					if var_350_0.name == "split_1" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_350_2 = arg_347_1.actors_["10030"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10030 == nil then
				arg_347_1.var_.actorSpriteComps10030 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps10030 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								iter_350_2.color = Color.New(Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_2.color.r, 1, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_2.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10030 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_350_4 then
						iter_350_4.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				local var_350_5 = arg_347_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_350_5 then
					arg_347_1.var_.alphaOldValue10030 = var_350_5.alpha
					arg_347_1.var_.characterEffect10030 = var_350_5
				end

				arg_347_1.var_.alphaOldValue10030 = 0
			end

			local var_350_6 = 0.0166666666666667

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_6 then
				if arg_347_1.var_.characterEffect10030 then
					arg_347_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_347_1.var_.alphaOldValue10030, 1, (arg_347_1.time_ - 0) / var_350_6)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_6 and arg_347_1.time_ < 0 + var_350_6 + arg_350_0 and arg_347_1.var_.characterEffect10030 then
				arg_347_1.var_.characterEffect10030.alpha = 1
			end

			local var_350_7 = 0
			local var_350_8 = 0.675

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_9 = arg_347_1:GetWordFromCfg(115271085)
				local var_350_10 = arg_347_1:FormatText(var_350_9.content)

				arg_347_1.text_.text = var_350_10

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_12 = 27 <= 0 and var_350_8 or var_350_8 * (utf8.len(var_350_10) / 27)

				if (27 <= 0 and var_350_8 or var_350_8 * (utf8.len(var_350_10) / 27)) > 0 and var_350_8 < var_350_12 then
					arg_347_1.talkMaxDuration = var_350_12

					if var_350_12 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_12 + var_350_7
					end
				end

				arg_347_1.text_.text = var_350_10
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271085", "story_v_out_115271.awb") ~= 0 then
					local var_350_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271085", "story_v_out_115271.awb") / 1000

					if var_350_13 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_7
					end

					if var_350_9.prefab_name ~= "" and arg_347_1.actors_[var_350_9.prefab_name] ~= nil then
						local var_350_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_9.prefab_name].transform, "story_v_out_115271", "115271085", "story_v_out_115271.awb")

						arg_347_1:RecordAudio("115271085", var_350_14)
						arg_347_1:RecordAudio("115271085", var_350_14)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_115271", "115271085", "story_v_out_115271.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_115271", "115271085", "story_v_out_115271.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_15 = math.max(var_350_8, arg_347_1.talkMaxDuration)

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_15 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_7) / var_350_15

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_7 + var_350_15 and arg_347_1.time_ < var_350_7 + var_350_15 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play115271086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 115271086
		arg_351_1.duration_ = 2.77

		local var_351_0 = {
			ja = 2.433,
			ko = 2.766,
			zh = 2.566,
			en = 2.7
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
				arg_351_0:Play115271087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10030"]) and arg_351_1.var_.actorSpriteComps10030 == nil then
				arg_351_1.var_.actorSpriteComps10030 = arg_351_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10030"]) then
				if arg_351_1.var_.actorSpriteComps10030 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 0.5, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10030"]) and arg_351_1.var_.actorSpriteComps10030 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_351_1.var_.actorSpriteComps10030 = nil
			end

			local var_354_2 = arg_351_1.actors_["10029"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) then
				local var_354_3 = var_354_2:GetComponent("Image")

				if var_354_3 then
					arg_351_1.var_.highlightMatValue10029 = var_354_3
				end
			end

			local var_354_4 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 and not isNil(var_354_2) then
				if arg_351_1.var_.highlightMatValue10029 then
					local var_354_5 = Mathf.Lerp(0.5, 1, (arg_351_1.time_ - 0) / var_354_4)

					arg_351_1.var_.highlightMatValue10029.color.r = var_354_5
					arg_351_1.var_.highlightMatValue10029.color.g = var_354_5
					arg_351_1.var_.highlightMatValue10029.color.b = var_354_5
					arg_351_1.var_.highlightMatValue10029.color = arg_351_1.var_.highlightMatValue10029.color
				end
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.highlightMatValue10029 then
				var_354_2.transform:SetSiblingIndex(1)

				arg_351_1.var_.highlightMatValue10029.color.r = 1
				arg_351_1.var_.highlightMatValue10029.color.g = 1
				arg_351_1.var_.highlightMatValue10029.color.b = 1
				arg_351_1.var_.highlightMatValue10029.color = arg_351_1.var_.highlightMatValue10029.color
			end

			local var_354_6 = 0
			local var_354_7 = 0.175

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_8 = arg_351_1:GetWordFromCfg(115271086)
				local var_354_9 = arg_351_1:FormatText(var_354_8.content)

				arg_351_1.text_.text = var_354_9

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 7 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_9) / 7)

				if (7 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_9) / 7)) > 0 and var_354_7 < var_354_11 then
					arg_351_1.talkMaxDuration = var_354_11

					if var_354_11 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_9
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271086", "story_v_out_115271.awb") ~= 0 then
					local var_354_12 = manager.audio:GetVoiceLength("story_v_out_115271", "115271086", "story_v_out_115271.awb") / 1000

					if var_354_12 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_12 + var_354_6
					end

					if var_354_8.prefab_name ~= "" and arg_351_1.actors_[var_354_8.prefab_name] ~= nil then
						local var_354_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_8.prefab_name].transform, "story_v_out_115271", "115271086", "story_v_out_115271.awb")

						arg_351_1:RecordAudio("115271086", var_354_13)
						arg_351_1:RecordAudio("115271086", var_354_13)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_115271", "115271086", "story_v_out_115271.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_115271", "115271086", "story_v_out_115271.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play115271087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 115271087
		arg_355_1.duration_ = 13.03

		local var_355_0 = {
			ja = 10.866,
			ko = 10.533,
			zh = 9.966,
			en = 13.033
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
				arg_355_0:Play115271088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.15

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(115271087)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 46 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 46)

				if (46 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 46)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271087", "story_v_out_115271.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271087", "story_v_out_115271.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_115271", "115271087", "story_v_out_115271.awb")

						arg_355_1:RecordAudio("115271087", var_358_6)
						arg_355_1:RecordAudio("115271087", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_115271", "115271087", "story_v_out_115271.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_115271", "115271087", "story_v_out_115271.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play115271088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 115271088
		arg_359_1.duration_ = 15.93

		local var_359_0 = {
			ja = 15.933,
			ko = 12.766,
			zh = 13.733,
			en = 14.2
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play115271089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.275

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(115271088)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 51 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 51)

				if (51 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 51)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271088", "story_v_out_115271.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271088", "story_v_out_115271.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_115271", "115271088", "story_v_out_115271.awb")

						arg_359_1:RecordAudio("115271088", var_362_6)
						arg_359_1:RecordAudio("115271088", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_115271", "115271088", "story_v_out_115271.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_115271", "115271088", "story_v_out_115271.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play115271089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 115271089
		arg_363_1.duration_ = 8.07

		local var_363_0 = {
			ja = 8.066,
			ko = 7.566,
			zh = 6.933,
			en = 7.133
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
				arg_363_0:Play115271090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 2 < arg_363_1.time_ and arg_363_1.time_ <= 2 + arg_366_0 then
				local var_366_0 = arg_363_1.bgs_.ST28a

				arg_363_1.bgs_.ST28a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_366_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_366_1 = var_366_0:GetComponent("SpriteRenderer")

				if var_366_1 and var_366_1.sprite then
					local var_366_2 = 2 * (var_366_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_366_0.transform.localScale = Vector3.New(var_366_2 / var_366_1.sprite.bounds.size.y < var_366_2 * manager.ui.mainCameraCom_.aspect / var_366_1.sprite.bounds.size.x and var_366_2 * manager.ui.mainCameraCom_.aspect / var_366_1.sprite.bounds.size.x or var_366_2 / var_366_1.sprite.bounds.size.y, var_366_2 / var_366_1.sprite.bounds.size.y < var_366_2 * manager.ui.mainCameraCom_.aspect / var_366_1.sprite.bounds.size.x and var_366_2 * manager.ui.mainCameraCom_.aspect / var_366_1.sprite.bounds.size.x or var_366_2 / var_366_1.sprite.bounds.size.y, 0)
				end

				for iter_366_0, iter_366_1 in pairs(arg_363_1.bgs_) do
					if iter_366_0 ~= "ST28a" then
						iter_366_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_366_3 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_4 = 2

			if var_366_3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_3 + var_366_4 then
				local var_366_5 = Color.New(0, 0, 0)

				var_366_5.a = Mathf.Lerp(0, 1, (arg_363_1.time_ - var_366_3) / var_366_4)
				arg_363_1.mask_.color = var_366_5
			end

			if arg_363_1.time_ >= var_366_3 + var_366_4 and arg_363_1.time_ < var_366_3 + var_366_4 + arg_366_0 then
				local var_366_6 = Color.New(0, 0, 0)

				var_366_6.a = 1
				arg_363_1.mask_.color = var_366_6
			end

			local var_366_7 = 2

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= var_366_7 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_8 = 2

			if var_366_7 <= arg_363_1.time_ and arg_363_1.time_ < var_366_7 + var_366_8 then
				local var_366_9 = Color.New(0, 0, 0)

				var_366_9.a = Mathf.Lerp(1, 0, (arg_363_1.time_ - var_366_7) / var_366_8)
				arg_363_1.mask_.color = var_366_9
			end

			if arg_363_1.time_ >= var_366_7 + var_366_8 and arg_363_1.time_ < var_366_7 + var_366_8 + arg_366_0 then
				local var_366_10 = Color.New(0, 0, 0)

				arg_363_1.mask_.enabled = false
				var_366_10.a = 0
				arg_363_1.mask_.color = var_366_10
			end

			local var_366_11 = arg_363_1.actors_["10029"].transform

			if 1.966 < arg_363_1.time_ and arg_363_1.time_ <= 1.966 + arg_366_0 then
				arg_363_1.var_.moveOldPos10029 = var_366_11.localPosition
				var_366_11.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10029", 7)
			end

			local var_366_12 = 0.001

			if 1.966 <= arg_363_1.time_ and arg_363_1.time_ < 1.966 + var_366_12 then
				var_366_11.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10029, Vector3.New(0, -2000, -180), (arg_363_1.time_ - 1.966) / var_366_12)
			end

			if arg_363_1.time_ >= 1.966 + var_366_12 and arg_363_1.time_ < 1.966 + var_366_12 + arg_366_0 then
				var_366_11.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_366_13 = arg_363_1.actors_["10030"].transform

			if 1.966 < arg_363_1.time_ and arg_363_1.time_ <= 1.966 + arg_366_0 then
				arg_363_1.var_.moveOldPos10030 = var_366_13.localPosition
				var_366_13.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10030", 7)

				for iter_366_2 = 0, var_366_13.childCount - 1 do
					local var_366_14 = var_366_13:GetChild(iter_366_2)

					if var_366_14.name == "split_1" or not string.find(var_366_14.name, "split") then
						var_366_14.gameObject:SetActive(true)
					else
						var_366_14.gameObject:SetActive(false)
					end
				end
			end

			local var_366_15 = 0.001

			if 1.966 <= arg_363_1.time_ and arg_363_1.time_ < 1.966 + var_366_15 then
				var_366_13.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10030, Vector3.New(0, -2000, 150), (arg_363_1.time_ - 1.966) / var_366_15)
			end

			if arg_363_1.time_ >= 1.966 + var_366_15 and arg_363_1.time_ < 1.966 + var_366_15 + arg_366_0 then
				var_366_13.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_366_16 = arg_363_1.actors_["1038"].transform

			if 3.8 < arg_363_1.time_ and arg_363_1.time_ <= 3.8 + arg_366_0 then
				arg_363_1.var_.moveOldPos1038 = var_366_16.localPosition
				var_366_16.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1038", 3)

				for iter_366_3 = 0, var_366_16.childCount - 1 do
					local var_366_17 = var_366_16:GetChild(iter_366_3)

					if var_366_17.name == "split_1" or not string.find(var_366_17.name, "split") then
						var_366_17.gameObject:SetActive(true)
					else
						var_366_17.gameObject:SetActive(false)
					end
				end
			end

			local var_366_18 = 0.001

			if 3.8 <= arg_363_1.time_ and arg_363_1.time_ < 3.8 + var_366_18 then
				var_366_16.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_363_1.time_ - 3.8) / var_366_18)
			end

			if arg_363_1.time_ >= 3.8 + var_366_18 and arg_363_1.time_ < 3.8 + var_366_18 + arg_366_0 then
				var_366_16.localPosition = Vector3.New(0, -400, 0)
			end

			if 3.8 < arg_363_1.time_ and arg_363_1.time_ <= 3.8 + arg_366_0 then
				local var_366_19 = arg_363_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_366_19 then
					arg_363_1.var_.alphaOldValue1038 = var_366_19.alpha
					arg_363_1.var_.characterEffect1038 = var_366_19
				end

				arg_363_1.var_.alphaOldValue1038 = 0
			end

			local var_366_20 = 0.5

			if 3.8 <= arg_363_1.time_ and arg_363_1.time_ < 3.8 + var_366_20 then
				if arg_363_1.var_.characterEffect1038 then
					arg_363_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_363_1.var_.alphaOldValue1038, 1, (arg_363_1.time_ - 3.8) / var_366_20)
				end
			end

			if arg_363_1.time_ >= 3.8 + var_366_20 and arg_363_1.time_ < 3.8 + var_366_20 + arg_366_0 and arg_363_1.var_.characterEffect1038 then
				arg_363_1.var_.characterEffect1038.alpha = 1
			end

			local var_366_21 = arg_363_1.actors_["1038"]

			if 3.8 < arg_363_1.time_ and arg_363_1.time_ <= 3.8 + arg_366_0 and not isNil(var_366_21) and arg_363_1.var_.actorSpriteComps1038 == nil then
				arg_363_1.var_.actorSpriteComps1038 = var_366_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_22 = 0.2

			if 3.8 <= arg_363_1.time_ and arg_363_1.time_ < 3.8 + var_366_22 and not isNil(var_366_21) then
				if arg_363_1.var_.actorSpriteComps1038 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								iter_366_5.color = Color.New(Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor1.r, (arg_363_1.time_ - 3.8) / var_366_22), Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor1.g, (arg_363_1.time_ - 3.8) / var_366_22), (Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor1.b, (arg_363_1.time_ - 3.8) / var_366_22)))
							else
								local var_366_23 = Mathf.Lerp(iter_366_5.color.r, 1, (arg_363_1.time_ - 3.8) / var_366_22)

								iter_366_5.color = Color.New(var_366_23, var_366_23, var_366_23)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 3.8 + var_366_22 and arg_363_1.time_ < 3.8 + var_366_22 + arg_366_0 and not isNil(var_366_21) and arg_363_1.var_.actorSpriteComps1038 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_366_7 then
						iter_366_7.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_363_1.var_.actorSpriteComps1038 = nil
			end

			if arg_363_1.frameCnt_ <= 1 then
				arg_363_1.dialog_:SetActive(false)
			end

			local var_366_24 = 4
			local var_366_25 = 0.225

			if 4 < arg_363_1.time_ and arg_363_1.time_ <= var_366_24 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				arg_363_1.dialog_:SetActive(true)

				arg_363_1.dialogCg_.alpha = 0

				local var_366_26 = LeanTween.value(arg_363_1.dialog_, 0, 1, 0.3)

				var_366_26:setOnUpdate(LuaHelper.FloatAction(function(arg_367_0)
					arg_363_1.dialogCg_.alpha = arg_367_0
				end))
				var_366_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_363_1.dialog_)
					var_366_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_363_1.duration_ = arg_363_1.duration_ + 0.3

				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_27 = arg_363_1:GetWordFromCfg(115271089)
				local var_366_28 = arg_363_1:FormatText(var_366_27.content)

				arg_363_1.text_.text = var_366_28

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_30 = 9 <= 0 and var_366_25 or var_366_25 * (utf8.len(var_366_28) / 9)

				if (9 <= 0 and var_366_25 or var_366_25 * (utf8.len(var_366_28) / 9)) > 0 and var_366_25 < var_366_30 then
					arg_363_1.talkMaxDuration = var_366_30
					var_366_24 = var_366_24 + 0.3

					if var_366_30 + var_366_24 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_30 + var_366_24
					end
				end

				arg_363_1.text_.text = var_366_28
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271089", "story_v_out_115271.awb") ~= 0 then
					local var_366_31 = manager.audio:GetVoiceLength("story_v_out_115271", "115271089", "story_v_out_115271.awb") / 1000

					if var_366_31 + var_366_24 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_31 + var_366_24
					end

					if var_366_27.prefab_name ~= "" and arg_363_1.actors_[var_366_27.prefab_name] ~= nil then
						local var_366_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_27.prefab_name].transform, "story_v_out_115271", "115271089", "story_v_out_115271.awb")

						arg_363_1:RecordAudio("115271089", var_366_32)
						arg_363_1:RecordAudio("115271089", var_366_32)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_115271", "115271089", "story_v_out_115271.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_115271", "115271089", "story_v_out_115271.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_33 = var_366_24 + 0.3
			local var_366_34 = math.max(var_366_25, arg_363_1.talkMaxDuration)

			if var_366_24 + 0.3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_33 + var_366_34 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_33) / var_366_34

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_33 + var_366_34 and arg_363_1.time_ < var_366_33 + var_366_34 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play115271090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 115271090
		arg_369_1.duration_ = 17.23

		local var_369_0 = {
			ja = 15.2,
			ko = 13.9,
			zh = 14.133,
			en = 17.233
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play115271091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 1.45

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:GetWordFromCfg(115271090)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 58 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 58)

				if (58 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 58)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271090", "story_v_out_115271.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271090", "story_v_out_115271.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_115271", "115271090", "story_v_out_115271.awb")

						arg_369_1:RecordAudio("115271090", var_372_6)
						arg_369_1:RecordAudio("115271090", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_115271", "115271090", "story_v_out_115271.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_115271", "115271090", "story_v_out_115271.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play115271091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 115271091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play115271092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				local var_376_0 = arg_373_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_376_0 then
					arg_373_1.var_.alphaOldValue1038 = var_376_0.alpha
					arg_373_1.var_.characterEffect1038 = var_376_0
				end

				arg_373_1.var_.alphaOldValue1038 = 1
			end

			local var_376_1 = 0.5

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_1 then
				if arg_373_1.var_.characterEffect1038 then
					arg_373_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_373_1.var_.alphaOldValue1038, 0, (arg_373_1.time_ - 0) / var_376_1)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_1 and arg_373_1.time_ < 0 + var_376_1 + arg_376_0 and arg_373_1.var_.characterEffect1038 then
				arg_373_1.var_.characterEffect1038.alpha = 0
			end

			local var_376_2 = 0
			local var_376_3 = 0.975

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(115271091).content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_6 = 39 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_4) / 39)

				if (39 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_4) / 39)) > 0 and var_376_3 < var_376_6 then
					arg_373_1.talkMaxDuration = var_376_6

					if var_376_6 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_6 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_7 and arg_373_1.time_ < var_376_2 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play115271092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 115271092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play115271093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.85

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(115271092).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 34 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 34)

				if (34 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 34)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play115271093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 115271093
		arg_381_1.duration_ = 7.3

		local var_381_0 = {
			ja = 7.3,
			ko = 6.666,
			zh = 5.833,
			en = 4.833
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play115271094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.85

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:GetWordFromCfg(115271093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 34 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 34)

				if (34 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 34)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271093", "story_v_out_115271.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271093", "story_v_out_115271.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_115271", "115271093", "story_v_out_115271.awb")

						arg_381_1:RecordAudio("115271093", var_384_6)
						arg_381_1:RecordAudio("115271093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_115271", "115271093", "story_v_out_115271.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_115271", "115271093", "story_v_out_115271.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play115271094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 115271094
		arg_385_1.duration_ = 16.67

		local var_385_0 = {
			ja = 14.6,
			ko = 15.066,
			zh = 13.733,
			en = 16.666
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play115271095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos10029 = arg_385_1.actors_["10029"].transform.localPosition
				arg_385_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_385_1.time_ - 0) / var_388_0)
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["10029"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				local var_388_1 = arg_385_1.actors_["10029"]:GetComponent("Image")

				if var_388_1 then
					arg_385_1.var_.alphaMatValue10029 = var_388_1
					arg_385_1.var_.alphaOldValue10029 = var_388_1.color.a
				end

				arg_385_1.var_.alphaOldValue10029 = 0
			end

			local var_388_2 = 0.5

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 then
				if arg_385_1.var_.alphaMatValue10029 then
					arg_385_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_385_1.var_.alphaOldValue10029, 1, (arg_385_1.time_ - 0) / var_388_2)
					arg_385_1.var_.alphaMatValue10029.color = arg_385_1.var_.alphaMatValue10029.color
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and arg_385_1.var_.alphaMatValue10029 then
				arg_385_1.var_.alphaMatValue10029.color.a = 1
				arg_385_1.var_.alphaMatValue10029.color = arg_385_1.var_.alphaMatValue10029.color
			end

			local var_388_3 = arg_385_1.actors_["10029"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_3) then
				local var_388_4 = var_388_3:GetComponent("Image")

				if var_388_4 then
					arg_385_1.var_.highlightMatValue10029 = var_388_4
				end
			end

			local var_388_5 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_5 and not isNil(var_388_3) then
				if arg_385_1.var_.highlightMatValue10029 then
					local var_388_6 = Mathf.Lerp(0.5, 1, (arg_385_1.time_ - 0) / var_388_5)

					arg_385_1.var_.highlightMatValue10029.color.r = var_388_6
					arg_385_1.var_.highlightMatValue10029.color.g = var_388_6
					arg_385_1.var_.highlightMatValue10029.color.b = var_388_6
					arg_385_1.var_.highlightMatValue10029.color = arg_385_1.var_.highlightMatValue10029.color
				end
			end

			if arg_385_1.time_ >= 0 + var_388_5 and arg_385_1.time_ < 0 + var_388_5 + arg_388_0 and not isNil(var_388_3) and arg_385_1.var_.highlightMatValue10029 then
				var_388_3.transform:SetSiblingIndex(1)

				arg_385_1.var_.highlightMatValue10029.color.r = 1
				arg_385_1.var_.highlightMatValue10029.color.g = 1
				arg_385_1.var_.highlightMatValue10029.color.b = 1
				arg_385_1.var_.highlightMatValue10029.color = arg_385_1.var_.highlightMatValue10029.color
			end

			local var_388_7 = 0
			local var_388_8 = 1.35

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_7 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_9 = arg_385_1:GetWordFromCfg(115271094)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_12 = 54 <= 0 and var_388_8 or var_388_8 * (utf8.len(var_388_10) / 54)

				if (54 <= 0 and var_388_8 or var_388_8 * (utf8.len(var_388_10) / 54)) > 0 and var_388_8 < var_388_12 then
					arg_385_1.talkMaxDuration = var_388_12

					if var_388_12 + var_388_7 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_12 + var_388_7
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271094", "story_v_out_115271.awb") ~= 0 then
					local var_388_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271094", "story_v_out_115271.awb") / 1000

					if var_388_13 + var_388_7 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_7
					end

					if var_388_9.prefab_name ~= "" and arg_385_1.actors_[var_388_9.prefab_name] ~= nil then
						local var_388_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_9.prefab_name].transform, "story_v_out_115271", "115271094", "story_v_out_115271.awb")

						arg_385_1:RecordAudio("115271094", var_388_14)
						arg_385_1:RecordAudio("115271094", var_388_14)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_115271", "115271094", "story_v_out_115271.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_115271", "115271094", "story_v_out_115271.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_15 = math.max(var_388_8, arg_385_1.talkMaxDuration)

			if var_388_7 <= arg_385_1.time_ and arg_385_1.time_ < var_388_7 + var_388_15 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_7) / var_388_15

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_7 + var_388_15 and arg_385_1.time_ < var_388_7 + var_388_15 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play115271095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 115271095
		arg_389_1.duration_ = 18.47

		local var_389_0 = {
			ja = 12.866,
			ko = 15.533,
			zh = 18,
			en = 18.466
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play115271096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 1.8

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:GetWordFromCfg(115271095)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 72 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 72)

				if (72 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 72)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271095", "story_v_out_115271.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271095", "story_v_out_115271.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_115271", "115271095", "story_v_out_115271.awb")

						arg_389_1:RecordAudio("115271095", var_392_6)
						arg_389_1:RecordAudio("115271095", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_115271", "115271095", "story_v_out_115271.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_115271", "115271095", "story_v_out_115271.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play115271096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 115271096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play115271097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				local var_396_0 = arg_393_1.actors_["10029"]:GetComponent("Image")

				if var_396_0 then
					arg_393_1.var_.alphaMatValue10029 = var_396_0
					arg_393_1.var_.alphaOldValue10029 = var_396_0.color.a
				end

				arg_393_1.var_.alphaOldValue10029 = 1
			end

			local var_396_1 = 0.5

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_1 then
				if arg_393_1.var_.alphaMatValue10029 then
					arg_393_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_393_1.var_.alphaOldValue10029, 0, (arg_393_1.time_ - 0) / var_396_1)
					arg_393_1.var_.alphaMatValue10029.color = arg_393_1.var_.alphaMatValue10029.color
				end
			end

			if arg_393_1.time_ >= 0 + var_396_1 and arg_393_1.time_ < 0 + var_396_1 + arg_396_0 and arg_393_1.var_.alphaMatValue10029 then
				arg_393_1.var_.alphaMatValue10029.color.a = 0
				arg_393_1.var_.alphaMatValue10029.color = arg_393_1.var_.alphaMatValue10029.color
			end

			local var_396_2 = 0
			local var_396_3 = 0.725

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(115271096).content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_6 = 29 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_4) / 29)

				if (29 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_4) / 29)) > 0 and var_396_3 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_7 and arg_393_1.time_ < var_396_2 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play115271097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 115271097
		arg_397_1.duration_ = 5.6

		local var_397_0 = {
			ja = 5.6,
			ko = 3.833,
			zh = 4.966,
			en = 3.1
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play115271098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1038 = arg_397_1.actors_["1038"].transform.localPosition
				arg_397_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("1038", 2)

				for iter_400_0 = 0, arg_397_1.actors_["1038"].transform.childCount - 1 do
					local var_400_0 = arg_397_1.actors_["1038"].transform:GetChild(iter_400_0)

					if var_400_0.name == "split_1" or not string.find(var_400_0.name, "split") then
						var_400_0.gameObject:SetActive(true)
					else
						var_400_0.gameObject:SetActive(false)
					end
				end
			end

			local var_400_1 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_1 then
				arg_397_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_397_1.time_ - 0) / var_400_1)
			end

			if arg_397_1.time_ >= 0 + var_400_1 and arg_397_1.time_ < 0 + var_400_1 + arg_400_0 then
				arg_397_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				local var_400_2 = arg_397_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_400_2 then
					arg_397_1.var_.alphaOldValue1038 = var_400_2.alpha
					arg_397_1.var_.characterEffect1038 = var_400_2
				end

				arg_397_1.var_.alphaOldValue1038 = 0
			end

			local var_400_3 = 0.5

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 then
				if arg_397_1.var_.characterEffect1038 then
					arg_397_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_397_1.var_.alphaOldValue1038, 1, (arg_397_1.time_ - 0) / var_400_3)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and arg_397_1.var_.characterEffect1038 then
				arg_397_1.var_.characterEffect1038.alpha = 1
			end

			local var_400_4 = arg_397_1.actors_["1038"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_4) and arg_397_1.var_.actorSpriteComps1038 == nil then
				arg_397_1.var_.actorSpriteComps1038 = var_400_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_5 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_5 and not isNil(var_400_4) then
				if arg_397_1.var_.actorSpriteComps1038 then
					for iter_400_1, iter_400_2 in pairs(arg_397_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_400_2 then
							if arg_397_1.isInRecall_ then
								iter_400_2.color = Color.New(Mathf.Lerp(iter_400_2.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_5), Mathf.Lerp(iter_400_2.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_5), (Mathf.Lerp(iter_400_2.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_5)))
							else
								local var_400_6 = Mathf.Lerp(iter_400_2.color.r, 1, (arg_397_1.time_ - 0) / var_400_5)

								iter_400_2.color = Color.New(var_400_6, var_400_6, var_400_6)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_5 and arg_397_1.time_ < 0 + var_400_5 + arg_400_0 and not isNil(var_400_4) and arg_397_1.var_.actorSpriteComps1038 then
				for iter_400_3, iter_400_4 in pairs(arg_397_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_400_4 then
						iter_400_4.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps1038 = nil
			end

			local var_400_7 = 0
			local var_400_8 = 0.475

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_7 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_9 = arg_397_1:GetWordFromCfg(115271097)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_12 = 19 <= 0 and var_400_8 or var_400_8 * (utf8.len(var_400_10) / 19)

				if (19 <= 0 and var_400_8 or var_400_8 * (utf8.len(var_400_10) / 19)) > 0 and var_400_8 < var_400_12 then
					arg_397_1.talkMaxDuration = var_400_12

					if var_400_12 + var_400_7 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_12 + var_400_7
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271097", "story_v_out_115271.awb") ~= 0 then
					local var_400_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271097", "story_v_out_115271.awb") / 1000

					if var_400_13 + var_400_7 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_7
					end

					if var_400_9.prefab_name ~= "" and arg_397_1.actors_[var_400_9.prefab_name] ~= nil then
						local var_400_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_9.prefab_name].transform, "story_v_out_115271", "115271097", "story_v_out_115271.awb")

						arg_397_1:RecordAudio("115271097", var_400_14)
						arg_397_1:RecordAudio("115271097", var_400_14)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_115271", "115271097", "story_v_out_115271.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_115271", "115271097", "story_v_out_115271.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_15 = math.max(var_400_8, arg_397_1.talkMaxDuration)

			if var_400_7 <= arg_397_1.time_ and arg_397_1.time_ < var_400_7 + var_400_15 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_7) / var_400_15

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_7 + var_400_15 and arg_397_1.time_ < var_400_7 + var_400_15 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play115271098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 115271098
		arg_401_1.duration_ = 11.7

		local var_401_0 = {
			ja = 11.7,
			ko = 8.4,
			zh = 8.666,
			en = 8.666
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play115271099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos10030 = arg_401_1.actors_["10030"].transform.localPosition
				arg_401_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10030", 4)

				for iter_404_0 = 0, arg_401_1.actors_["10030"].transform.childCount - 1 do
					local var_404_0 = arg_401_1.actors_["10030"].transform:GetChild(iter_404_0)

					if var_404_0.name == "split_2" or not string.find(var_404_0.name, "split") then
						var_404_0.gameObject:SetActive(true)
					else
						var_404_0.gameObject:SetActive(false)
					end
				end
			end

			local var_404_1 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_1 then
				arg_401_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_401_1.time_ - 0) / var_404_1)
			end

			if arg_401_1.time_ >= 0 + var_404_1 and arg_401_1.time_ < 0 + var_404_1 + arg_404_0 then
				arg_401_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				local var_404_2 = arg_401_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_2 then
					arg_401_1.var_.alphaOldValue10030 = var_404_2.alpha
					arg_401_1.var_.characterEffect10030 = var_404_2
				end

				arg_401_1.var_.alphaOldValue10030 = 0
			end

			local var_404_3 = 0.5

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 then
				if arg_401_1.var_.characterEffect10030 then
					arg_401_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_401_1.var_.alphaOldValue10030, 1, (arg_401_1.time_ - 0) / var_404_3)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and arg_401_1.var_.characterEffect10030 then
				arg_401_1.var_.characterEffect10030.alpha = 1
			end

			local var_404_4 = arg_401_1.actors_["10030"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.actorSpriteComps10030 == nil then
				arg_401_1.var_.actorSpriteComps10030 = var_404_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_5 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_5 and not isNil(var_404_4) then
				if arg_401_1.var_.actorSpriteComps10030 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								iter_404_2.color = Color.New(Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 0) / var_404_5), Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 0) / var_404_5), (Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 0) / var_404_5)))
							else
								local var_404_6 = Mathf.Lerp(iter_404_2.color.r, 1, (arg_401_1.time_ - 0) / var_404_5)

								iter_404_2.color = Color.New(var_404_6, var_404_6, var_404_6)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_5 and arg_401_1.time_ < 0 + var_404_5 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.actorSpriteComps10030 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_404_4 then
						iter_404_4.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps10030 = nil
			end

			local var_404_7 = arg_401_1.actors_["1038"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps1038 == nil then
				arg_401_1.var_.actorSpriteComps1038 = var_404_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_8 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_8 and not isNil(var_404_7) then
				if arg_401_1.var_.actorSpriteComps1038 then
					for iter_404_5, iter_404_6 in pairs(arg_401_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_404_6 then
							if arg_401_1.isInRecall_ then
								iter_404_6.color = Color.New(Mathf.Lerp(iter_404_6.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_8), Mathf.Lerp(iter_404_6.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_8), (Mathf.Lerp(iter_404_6.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_8)))
							else
								local var_404_9 = Mathf.Lerp(iter_404_6.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_8)

								iter_404_6.color = Color.New(var_404_9, var_404_9, var_404_9)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_8 and arg_401_1.time_ < 0 + var_404_8 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps1038 then
				for iter_404_7, iter_404_8 in pairs(arg_401_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_404_8 then
						iter_404_8.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps1038 = nil
			end

			local var_404_10 = 0
			local var_404_11 = 0.7

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_12 = arg_401_1:GetWordFromCfg(115271098)
				local var_404_13 = arg_401_1:FormatText(var_404_12.content)

				arg_401_1.text_.text = var_404_13

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_15 = 28 <= 0 and var_404_11 or var_404_11 * (utf8.len(var_404_13) / 28)

				if (28 <= 0 and var_404_11 or var_404_11 * (utf8.len(var_404_13) / 28)) > 0 and var_404_11 < var_404_15 then
					arg_401_1.talkMaxDuration = var_404_15

					if var_404_15 + var_404_10 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_15 + var_404_10
					end
				end

				arg_401_1.text_.text = var_404_13
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271098", "story_v_out_115271.awb") ~= 0 then
					local var_404_16 = manager.audio:GetVoiceLength("story_v_out_115271", "115271098", "story_v_out_115271.awb") / 1000

					if var_404_16 + var_404_10 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_16 + var_404_10
					end

					if var_404_12.prefab_name ~= "" and arg_401_1.actors_[var_404_12.prefab_name] ~= nil then
						local var_404_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_12.prefab_name].transform, "story_v_out_115271", "115271098", "story_v_out_115271.awb")

						arg_401_1:RecordAudio("115271098", var_404_17)
						arg_401_1:RecordAudio("115271098", var_404_17)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_115271", "115271098", "story_v_out_115271.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_115271", "115271098", "story_v_out_115271.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_18 = math.max(var_404_11, arg_401_1.talkMaxDuration)

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_18 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_10) / var_404_18

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_10 + var_404_18 and arg_401_1.time_ < var_404_10 + var_404_18 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play115271099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 115271099
		arg_405_1.duration_ = 8.97

		local var_405_0 = {
			ja = 8.833,
			ko = 8.7,
			zh = 7.733,
			en = 8.966
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play115271100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.95

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:GetWordFromCfg(115271099)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 38 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 38)

				if (38 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 38)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271099", "story_v_out_115271.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271099", "story_v_out_115271.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_115271", "115271099", "story_v_out_115271.awb")

						arg_405_1:RecordAudio("115271099", var_408_6)
						arg_405_1:RecordAudio("115271099", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_115271", "115271099", "story_v_out_115271.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_115271", "115271099", "story_v_out_115271.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play115271100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 115271100
		arg_409_1.duration_ = 5.03

		local var_409_0 = {
			ja = 3.033,
			ko = 3.966,
			zh = 4.566,
			en = 5.033
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play115271101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10030"]) and arg_409_1.var_.actorSpriteComps10030 == nil then
				arg_409_1.var_.actorSpriteComps10030 = arg_409_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10030"]) then
				if arg_409_1.var_.actorSpriteComps10030 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								iter_412_1.color = Color.New(Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor2.r, (arg_409_1.time_ - 0) / var_412_0), Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor2.g, (arg_409_1.time_ - 0) / var_412_0), (Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor2.b, (arg_409_1.time_ - 0) / var_412_0)))
							else
								local var_412_1 = Mathf.Lerp(iter_412_1.color.r, 0.5, (arg_409_1.time_ - 0) / var_412_0)

								iter_412_1.color = Color.New(var_412_1, var_412_1, var_412_1)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10030"]) and arg_409_1.var_.actorSpriteComps10030 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_409_1.var_.actorSpriteComps10030 = nil
			end

			local var_412_2 = arg_409_1.actors_["1038"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1038 = var_412_2.localPosition
				var_412_2.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("1038", 2)

				for iter_412_4 = 0, var_412_2.childCount - 1 do
					local var_412_3 = var_412_2:GetChild(iter_412_4)

					if var_412_3.name == "split_9" or not string.find(var_412_3.name, "split") then
						var_412_3.gameObject:SetActive(true)
					else
						var_412_3.gameObject:SetActive(false)
					end
				end
			end

			local var_412_4 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				var_412_2.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_409_1.time_ - 0) / var_412_4)
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				var_412_2.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_412_5 = arg_409_1.actors_["1038"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_5) and arg_409_1.var_.actorSpriteComps1038 == nil then
				arg_409_1.var_.actorSpriteComps1038 = var_412_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_6 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_6 and not isNil(var_412_5) then
				if arg_409_1.var_.actorSpriteComps1038 then
					for iter_412_5, iter_412_6 in pairs(arg_409_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_412_6 then
							if arg_409_1.isInRecall_ then
								iter_412_6.color = Color.New(Mathf.Lerp(iter_412_6.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_6), Mathf.Lerp(iter_412_6.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_6), (Mathf.Lerp(iter_412_6.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_6)))
							else
								local var_412_7 = Mathf.Lerp(iter_412_6.color.r, 1, (arg_409_1.time_ - 0) / var_412_6)

								iter_412_6.color = Color.New(var_412_7, var_412_7, var_412_7)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_6 and arg_409_1.time_ < 0 + var_412_6 + arg_412_0 and not isNil(var_412_5) and arg_409_1.var_.actorSpriteComps1038 then
				for iter_412_7, iter_412_8 in pairs(arg_409_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_412_8 then
						iter_412_8.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps1038 = nil
			end

			local var_412_8 = 0
			local var_412_9 = 0.35

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_10 = arg_409_1:GetWordFromCfg(115271100)
				local var_412_11 = arg_409_1:FormatText(var_412_10.content)

				arg_409_1.text_.text = var_412_11

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_13 = 14 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_11) / 14)

				if (14 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_11) / 14)) > 0 and var_412_9 < var_412_13 then
					arg_409_1.talkMaxDuration = var_412_13

					if var_412_13 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_8
					end
				end

				arg_409_1.text_.text = var_412_11
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271100", "story_v_out_115271.awb") ~= 0 then
					local var_412_14 = manager.audio:GetVoiceLength("story_v_out_115271", "115271100", "story_v_out_115271.awb") / 1000

					if var_412_14 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_8
					end

					if var_412_10.prefab_name ~= "" and arg_409_1.actors_[var_412_10.prefab_name] ~= nil then
						local var_412_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_10.prefab_name].transform, "story_v_out_115271", "115271100", "story_v_out_115271.awb")

						arg_409_1:RecordAudio("115271100", var_412_15)
						arg_409_1:RecordAudio("115271100", var_412_15)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_115271", "115271100", "story_v_out_115271.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_115271", "115271100", "story_v_out_115271.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = math.max(var_412_9, arg_409_1.talkMaxDuration)

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_8) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_8 + var_412_16 and arg_409_1.time_ < var_412_8 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play115271101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 115271101
		arg_413_1.duration_ = 6.33

		local var_413_0 = {
			ja = 4.6,
			ko = 5.1,
			zh = 5.666,
			en = 6.333
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play115271102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["10030"]) and arg_413_1.var_.actorSpriteComps10030 == nil then
				arg_413_1.var_.actorSpriteComps10030 = arg_413_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["10030"]) then
				if arg_413_1.var_.actorSpriteComps10030 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								iter_416_1.color = Color.New(Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor1.r, (arg_413_1.time_ - 0) / var_416_0), Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor1.g, (arg_413_1.time_ - 0) / var_416_0), (Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor1.b, (arg_413_1.time_ - 0) / var_416_0)))
							else
								local var_416_1 = Mathf.Lerp(iter_416_1.color.r, 1, (arg_413_1.time_ - 0) / var_416_0)

								iter_416_1.color = Color.New(var_416_1, var_416_1, var_416_1)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["10030"]) and arg_413_1.var_.actorSpriteComps10030 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_416_3 then
						iter_416_3.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_413_1.var_.actorSpriteComps10030 = nil
			end

			local var_416_2 = arg_413_1.actors_["1038"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps1038 == nil then
				arg_413_1.var_.actorSpriteComps1038 = var_416_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_3 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_3 and not isNil(var_416_2) then
				if arg_413_1.var_.actorSpriteComps1038 then
					for iter_416_4, iter_416_5 in pairs(arg_413_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_416_5 then
							if arg_413_1.isInRecall_ then
								iter_416_5.color = Color.New(Mathf.Lerp(iter_416_5.color.r, arg_413_1.hightColor2.r, (arg_413_1.time_ - 0) / var_416_3), Mathf.Lerp(iter_416_5.color.g, arg_413_1.hightColor2.g, (arg_413_1.time_ - 0) / var_416_3), (Mathf.Lerp(iter_416_5.color.b, arg_413_1.hightColor2.b, (arg_413_1.time_ - 0) / var_416_3)))
							else
								local var_416_4 = Mathf.Lerp(iter_416_5.color.r, 0.5, (arg_413_1.time_ - 0) / var_416_3)

								iter_416_5.color = Color.New(var_416_4, var_416_4, var_416_4)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_3 and arg_413_1.time_ < 0 + var_416_3 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps1038 then
				for iter_416_6, iter_416_7 in pairs(arg_413_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_416_7 then
						iter_416_7.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps1038 = nil
			end

			local var_416_5 = 0
			local var_416_6 = 0.5

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_7 = arg_413_1:GetWordFromCfg(115271101)
				local var_416_8 = arg_413_1:FormatText(var_416_7.content)

				arg_413_1.text_.text = var_416_8

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 20 <= 0 and var_416_6 or var_416_6 * (utf8.len(var_416_8) / 20)

				if (20 <= 0 and var_416_6 or var_416_6 * (utf8.len(var_416_8) / 20)) > 0 and var_416_6 < var_416_10 then
					arg_413_1.talkMaxDuration = var_416_10

					if var_416_10 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_5
					end
				end

				arg_413_1.text_.text = var_416_8
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271101", "story_v_out_115271.awb") ~= 0 then
					local var_416_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271101", "story_v_out_115271.awb") / 1000

					if var_416_11 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_11 + var_416_5
					end

					if var_416_7.prefab_name ~= "" and arg_413_1.actors_[var_416_7.prefab_name] ~= nil then
						local var_416_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_7.prefab_name].transform, "story_v_out_115271", "115271101", "story_v_out_115271.awb")

						arg_413_1:RecordAudio("115271101", var_416_12)
						arg_413_1:RecordAudio("115271101", var_416_12)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_115271", "115271101", "story_v_out_115271.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_115271", "115271101", "story_v_out_115271.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_13 = math.max(var_416_6, arg_413_1.talkMaxDuration)

			if var_416_5 <= arg_413_1.time_ and arg_413_1.time_ < var_416_5 + var_416_13 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_5) / var_416_13

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_5 + var_416_13 and arg_413_1.time_ < var_416_5 + var_416_13 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play115271102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 115271102
		arg_417_1.duration_ = 7.3

		local var_417_0 = {
			ja = 7.3,
			ko = 4.533,
			zh = 5.5,
			en = 4.666
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play115271103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10030"]) and arg_417_1.var_.actorSpriteComps10030 == nil then
				arg_417_1.var_.actorSpriteComps10030 = arg_417_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["10030"]) then
				if arg_417_1.var_.actorSpriteComps10030 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								iter_420_1.color = Color.New(Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor2.r, (arg_417_1.time_ - 0) / var_420_0), Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor2.g, (arg_417_1.time_ - 0) / var_420_0), (Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor2.b, (arg_417_1.time_ - 0) / var_420_0)))
							else
								local var_420_1 = Mathf.Lerp(iter_420_1.color.r, 0.5, (arg_417_1.time_ - 0) / var_420_0)

								iter_420_1.color = Color.New(var_420_1, var_420_1, var_420_1)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["10030"]) and arg_417_1.var_.actorSpriteComps10030 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_417_1.var_.actorSpriteComps10030 = nil
			end

			local var_420_2 = arg_417_1.actors_["1038"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps1038 == nil then
				arg_417_1.var_.actorSpriteComps1038 = var_420_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_3 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_3 and not isNil(var_420_2) then
				if arg_417_1.var_.actorSpriteComps1038 then
					for iter_420_4, iter_420_5 in pairs(arg_417_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_420_5 then
							if arg_417_1.isInRecall_ then
								iter_420_5.color = Color.New(Mathf.Lerp(iter_420_5.color.r, arg_417_1.hightColor1.r, (arg_417_1.time_ - 0) / var_420_3), Mathf.Lerp(iter_420_5.color.g, arg_417_1.hightColor1.g, (arg_417_1.time_ - 0) / var_420_3), (Mathf.Lerp(iter_420_5.color.b, arg_417_1.hightColor1.b, (arg_417_1.time_ - 0) / var_420_3)))
							else
								local var_420_4 = Mathf.Lerp(iter_420_5.color.r, 1, (arg_417_1.time_ - 0) / var_420_3)

								iter_420_5.color = Color.New(var_420_4, var_420_4, var_420_4)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_3 and arg_417_1.time_ < 0 + var_420_3 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps1038 then
				for iter_420_6, iter_420_7 in pairs(arg_417_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_420_7 then
						iter_420_7.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps1038 = nil
			end

			local var_420_5 = 0
			local var_420_6 = 0.5

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_7 = arg_417_1:GetWordFromCfg(115271102)
				local var_420_8 = arg_417_1:FormatText(var_420_7.content)

				arg_417_1.text_.text = var_420_8

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 20 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 20)

				if (20 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 20)) > 0 and var_420_6 < var_420_10 then
					arg_417_1.talkMaxDuration = var_420_10

					if var_420_10 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_5
					end
				end

				arg_417_1.text_.text = var_420_8
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271102", "story_v_out_115271.awb") ~= 0 then
					local var_420_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271102", "story_v_out_115271.awb") / 1000

					if var_420_11 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_5
					end

					if var_420_7.prefab_name ~= "" and arg_417_1.actors_[var_420_7.prefab_name] ~= nil then
						local var_420_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_7.prefab_name].transform, "story_v_out_115271", "115271102", "story_v_out_115271.awb")

						arg_417_1:RecordAudio("115271102", var_420_12)
						arg_417_1:RecordAudio("115271102", var_420_12)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_115271", "115271102", "story_v_out_115271.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_115271", "115271102", "story_v_out_115271.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_13 = math.max(var_420_6, arg_417_1.talkMaxDuration)

			if var_420_5 <= arg_417_1.time_ and arg_417_1.time_ < var_420_5 + var_420_13 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_5) / var_420_13

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_5 + var_420_13 and arg_417_1.time_ < var_420_5 + var_420_13 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play115271103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 115271103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play115271104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1038"]) and arg_421_1.var_.actorSpriteComps1038 == nil then
				arg_421_1.var_.actorSpriteComps1038 = arg_421_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1038"]) then
				if arg_421_1.var_.actorSpriteComps1038 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								iter_424_1.color = Color.New(Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor2.r, (arg_421_1.time_ - 0) / var_424_0), Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor2.g, (arg_421_1.time_ - 0) / var_424_0), (Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor2.b, (arg_421_1.time_ - 0) / var_424_0)))
							else
								local var_424_1 = Mathf.Lerp(iter_424_1.color.r, 0.5, (arg_421_1.time_ - 0) / var_424_0)

								iter_424_1.color = Color.New(var_424_1, var_424_1, var_424_1)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1038"]) and arg_421_1.var_.actorSpriteComps1038 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_424_3 then
						iter_424_3.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps1038 = nil
			end

			local var_424_2 = 0
			local var_424_3 = 0.675

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_4 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(115271103).content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_6 = 27 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_4) / 27)

				if (27 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_4) / 27)) > 0 and var_424_3 < var_424_6 then
					arg_421_1.talkMaxDuration = var_424_6

					if var_424_6 + var_424_2 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_2
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_3, arg_421_1.talkMaxDuration)

			if var_424_2 <= arg_421_1.time_ and arg_421_1.time_ < var_424_2 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_2) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_2 + var_424_7 and arg_421_1.time_ < var_424_2 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play115271104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 115271104
		arg_425_1.duration_ = 3.9

		local var_425_0 = {
			ja = 2.8,
			ko = 2.6,
			zh = 3.466,
			en = 3.9
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play115271105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1038"]) and arg_425_1.var_.actorSpriteComps1038 == nil then
				arg_425_1.var_.actorSpriteComps1038 = arg_425_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1038"]) then
				if arg_425_1.var_.actorSpriteComps1038 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								iter_428_1.color = Color.New(Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor1.r, (arg_425_1.time_ - 0) / var_428_0), Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor1.g, (arg_425_1.time_ - 0) / var_428_0), (Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor1.b, (arg_425_1.time_ - 0) / var_428_0)))
							else
								local var_428_1 = Mathf.Lerp(iter_428_1.color.r, 1, (arg_425_1.time_ - 0) / var_428_0)

								iter_428_1.color = Color.New(var_428_1, var_428_1, var_428_1)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1038"]) and arg_425_1.var_.actorSpriteComps1038 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_428_3 then
						iter_428_3.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_425_1.var_.actorSpriteComps1038 = nil
			end

			local var_428_2 = 0
			local var_428_3 = 0.3

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_2 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_4 = arg_425_1:GetWordFromCfg(115271104)
				local var_428_5 = arg_425_1:FormatText(var_428_4.content)

				arg_425_1.text_.text = var_428_5

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_7 = 12 <= 0 and var_428_3 or var_428_3 * (utf8.len(var_428_5) / 12)

				if (12 <= 0 and var_428_3 or var_428_3 * (utf8.len(var_428_5) / 12)) > 0 and var_428_3 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_2 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_2
					end
				end

				arg_425_1.text_.text = var_428_5
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271104", "story_v_out_115271.awb") ~= 0 then
					local var_428_8 = manager.audio:GetVoiceLength("story_v_out_115271", "115271104", "story_v_out_115271.awb") / 1000

					if var_428_8 + var_428_2 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_8 + var_428_2
					end

					if var_428_4.prefab_name ~= "" and arg_425_1.actors_[var_428_4.prefab_name] ~= nil then
						local var_428_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_4.prefab_name].transform, "story_v_out_115271", "115271104", "story_v_out_115271.awb")

						arg_425_1:RecordAudio("115271104", var_428_9)
						arg_425_1:RecordAudio("115271104", var_428_9)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_115271", "115271104", "story_v_out_115271.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_115271", "115271104", "story_v_out_115271.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_10 = math.max(var_428_3, arg_425_1.talkMaxDuration)

			if var_428_2 <= arg_425_1.time_ and arg_425_1.time_ < var_428_2 + var_428_10 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_2) / var_428_10

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_2 + var_428_10 and arg_425_1.time_ < var_428_2 + var_428_10 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play115271105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 115271105
		arg_429_1.duration_ = 6.6

		local var_429_0 = {
			ja = 3.1,
			ko = 5.833,
			zh = 3.666,
			en = 6.6
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play115271106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["10030"]) and arg_429_1.var_.actorSpriteComps10030 == nil then
				arg_429_1.var_.actorSpriteComps10030 = arg_429_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["10030"]) then
				if arg_429_1.var_.actorSpriteComps10030 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								iter_432_1.color = Color.New(Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor1.r, (arg_429_1.time_ - 0) / var_432_0), Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor1.g, (arg_429_1.time_ - 0) / var_432_0), (Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor1.b, (arg_429_1.time_ - 0) / var_432_0)))
							else
								local var_432_1 = Mathf.Lerp(iter_432_1.color.r, 1, (arg_429_1.time_ - 0) / var_432_0)

								iter_432_1.color = Color.New(var_432_1, var_432_1, var_432_1)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["10030"]) and arg_429_1.var_.actorSpriteComps10030 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_429_1.var_.actorSpriteComps10030 = nil
			end

			local var_432_2 = arg_429_1.actors_["1038"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_2) and arg_429_1.var_.actorSpriteComps1038 == nil then
				arg_429_1.var_.actorSpriteComps1038 = var_432_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_3 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_3 and not isNil(var_432_2) then
				if arg_429_1.var_.actorSpriteComps1038 then
					for iter_432_4, iter_432_5 in pairs(arg_429_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_432_5 then
							if arg_429_1.isInRecall_ then
								iter_432_5.color = Color.New(Mathf.Lerp(iter_432_5.color.r, arg_429_1.hightColor2.r, (arg_429_1.time_ - 0) / var_432_3), Mathf.Lerp(iter_432_5.color.g, arg_429_1.hightColor2.g, (arg_429_1.time_ - 0) / var_432_3), (Mathf.Lerp(iter_432_5.color.b, arg_429_1.hightColor2.b, (arg_429_1.time_ - 0) / var_432_3)))
							else
								local var_432_4 = Mathf.Lerp(iter_432_5.color.r, 0.5, (arg_429_1.time_ - 0) / var_432_3)

								iter_432_5.color = Color.New(var_432_4, var_432_4, var_432_4)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_3 and arg_429_1.time_ < 0 + var_432_3 + arg_432_0 and not isNil(var_432_2) and arg_429_1.var_.actorSpriteComps1038 then
				for iter_432_6, iter_432_7 in pairs(arg_429_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_432_7 then
						iter_432_7.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps1038 = nil
			end

			local var_432_5 = arg_429_1.actors_["10030"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10030 = var_432_5.localPosition
				var_432_5.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("10030", 4)

				for iter_432_8 = 0, var_432_5.childCount - 1 do
					local var_432_6 = var_432_5:GetChild(iter_432_8)

					if var_432_6.name == "split_3" or not string.find(var_432_6.name, "split") then
						var_432_6.gameObject:SetActive(true)
					else
						var_432_6.gameObject:SetActive(false)
					end
				end
			end

			local var_432_7 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				var_432_5.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_429_1.time_ - 0) / var_432_7)
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				var_432_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_432_8 = 0
			local var_432_9 = 0.4

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_8 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_10 = arg_429_1:GetWordFromCfg(115271105)
				local var_432_11 = arg_429_1:FormatText(var_432_10.content)

				arg_429_1.text_.text = var_432_11

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_13 = 16 <= 0 and var_432_9 or var_432_9 * (utf8.len(var_432_11) / 16)

				if (16 <= 0 and var_432_9 or var_432_9 * (utf8.len(var_432_11) / 16)) > 0 and var_432_9 < var_432_13 then
					arg_429_1.talkMaxDuration = var_432_13

					if var_432_13 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_13 + var_432_8
					end
				end

				arg_429_1.text_.text = var_432_11
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271105", "story_v_out_115271.awb") ~= 0 then
					local var_432_14 = manager.audio:GetVoiceLength("story_v_out_115271", "115271105", "story_v_out_115271.awb") / 1000

					if var_432_14 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_14 + var_432_8
					end

					if var_432_10.prefab_name ~= "" and arg_429_1.actors_[var_432_10.prefab_name] ~= nil then
						local var_432_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_10.prefab_name].transform, "story_v_out_115271", "115271105", "story_v_out_115271.awb")

						arg_429_1:RecordAudio("115271105", var_432_15)
						arg_429_1:RecordAudio("115271105", var_432_15)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_115271", "115271105", "story_v_out_115271.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_115271", "115271105", "story_v_out_115271.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_16 = math.max(var_432_9, arg_429_1.talkMaxDuration)

			if var_432_8 <= arg_429_1.time_ and arg_429_1.time_ < var_432_8 + var_432_16 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_8) / var_432_16

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_8 + var_432_16 and arg_429_1.time_ < var_432_8 + var_432_16 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play115271106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 115271106
		arg_433_1.duration_ = 10.3

		local var_433_0 = {
			ja = 8.233,
			ko = 10.3,
			zh = 9.5,
			en = 8.566
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play115271107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["10030"]) and arg_433_1.var_.actorSpriteComps10030 == nil then
				arg_433_1.var_.actorSpriteComps10030 = arg_433_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_0 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["10030"]) then
				if arg_433_1.var_.actorSpriteComps10030 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								iter_436_1.color = Color.New(Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor2.r, (arg_433_1.time_ - 0) / var_436_0), Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor2.g, (arg_433_1.time_ - 0) / var_436_0), (Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor2.b, (arg_433_1.time_ - 0) / var_436_0)))
							else
								local var_436_1 = Mathf.Lerp(iter_436_1.color.r, 0.5, (arg_433_1.time_ - 0) / var_436_0)

								iter_436_1.color = Color.New(var_436_1, var_436_1, var_436_1)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["10030"]) and arg_433_1.var_.actorSpriteComps10030 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_436_3 then
						iter_436_3.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_433_1.var_.actorSpriteComps10030 = nil
			end

			local var_436_2 = arg_433_1.actors_["1038"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps1038 == nil then
				arg_433_1.var_.actorSpriteComps1038 = var_436_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_3 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_3 and not isNil(var_436_2) then
				if arg_433_1.var_.actorSpriteComps1038 then
					for iter_436_4, iter_436_5 in pairs(arg_433_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_436_5 then
							if arg_433_1.isInRecall_ then
								iter_436_5.color = Color.New(Mathf.Lerp(iter_436_5.color.r, arg_433_1.hightColor1.r, (arg_433_1.time_ - 0) / var_436_3), Mathf.Lerp(iter_436_5.color.g, arg_433_1.hightColor1.g, (arg_433_1.time_ - 0) / var_436_3), (Mathf.Lerp(iter_436_5.color.b, arg_433_1.hightColor1.b, (arg_433_1.time_ - 0) / var_436_3)))
							else
								local var_436_4 = Mathf.Lerp(iter_436_5.color.r, 1, (arg_433_1.time_ - 0) / var_436_3)

								iter_436_5.color = Color.New(var_436_4, var_436_4, var_436_4)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_3 and arg_433_1.time_ < 0 + var_436_3 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps1038 then
				for iter_436_6, iter_436_7 in pairs(arg_433_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_436_7 then
						iter_436_7.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_433_1.var_.actorSpriteComps1038 = nil
			end

			local var_436_5 = 0
			local var_436_6 = 0.825

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_7 = arg_433_1:GetWordFromCfg(115271106)
				local var_436_8 = arg_433_1:FormatText(var_436_7.content)

				arg_433_1.text_.text = var_436_8

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_10 = 33 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_8) / 33)

				if (33 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_8) / 33)) > 0 and var_436_6 < var_436_10 then
					arg_433_1.talkMaxDuration = var_436_10

					if var_436_10 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_5
					end
				end

				arg_433_1.text_.text = var_436_8
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271106", "story_v_out_115271.awb") ~= 0 then
					local var_436_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271106", "story_v_out_115271.awb") / 1000

					if var_436_11 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_5
					end

					if var_436_7.prefab_name ~= "" and arg_433_1.actors_[var_436_7.prefab_name] ~= nil then
						local var_436_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_7.prefab_name].transform, "story_v_out_115271", "115271106", "story_v_out_115271.awb")

						arg_433_1:RecordAudio("115271106", var_436_12)
						arg_433_1:RecordAudio("115271106", var_436_12)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_115271", "115271106", "story_v_out_115271.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_115271", "115271106", "story_v_out_115271.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_13 = math.max(var_436_6, arg_433_1.talkMaxDuration)

			if var_436_5 <= arg_433_1.time_ and arg_433_1.time_ < var_436_5 + var_436_13 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_5) / var_436_13

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_5 + var_436_13 and arg_433_1.time_ < var_436_5 + var_436_13 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play115271107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 115271107
		arg_437_1.duration_ = 7.03

		local var_437_0 = {
			ja = 4.6,
			ko = 5.666,
			zh = 7.033,
			en = 5.9
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play115271108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.7

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:GetWordFromCfg(115271107)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 28 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 28)

				if (28 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 28)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271107", "story_v_out_115271.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271107", "story_v_out_115271.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_out_115271", "115271107", "story_v_out_115271.awb")

						arg_437_1:RecordAudio("115271107", var_440_6)
						arg_437_1:RecordAudio("115271107", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_115271", "115271107", "story_v_out_115271.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_115271", "115271107", "story_v_out_115271.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play115271108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 115271108
		arg_441_1.duration_ = 9.03

		local var_441_0 = {
			ja = 9.033,
			ko = 6.133,
			zh = 6.066,
			en = 5.766
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play115271109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["10030"]) and arg_441_1.var_.actorSpriteComps10030 == nil then
				arg_441_1.var_.actorSpriteComps10030 = arg_441_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_0 = 0.2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["10030"]) then
				if arg_441_1.var_.actorSpriteComps10030 then
					for iter_444_0, iter_444_1 in pairs(arg_441_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_444_1 then
							if arg_441_1.isInRecall_ then
								iter_444_1.color = Color.New(Mathf.Lerp(iter_444_1.color.r, arg_441_1.hightColor1.r, (arg_441_1.time_ - 0) / var_444_0), Mathf.Lerp(iter_444_1.color.g, arg_441_1.hightColor1.g, (arg_441_1.time_ - 0) / var_444_0), (Mathf.Lerp(iter_444_1.color.b, arg_441_1.hightColor1.b, (arg_441_1.time_ - 0) / var_444_0)))
							else
								local var_444_1 = Mathf.Lerp(iter_444_1.color.r, 1, (arg_441_1.time_ - 0) / var_444_0)

								iter_444_1.color = Color.New(var_444_1, var_444_1, var_444_1)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["10030"]) and arg_441_1.var_.actorSpriteComps10030 then
				for iter_444_2, iter_444_3 in pairs(arg_441_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_444_3 then
						iter_444_3.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_441_1.var_.actorSpriteComps10030 = nil
			end

			local var_444_2 = arg_441_1.actors_["1038"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.actorSpriteComps1038 == nil then
				arg_441_1.var_.actorSpriteComps1038 = var_444_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_3 = 0.2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_3 and not isNil(var_444_2) then
				if arg_441_1.var_.actorSpriteComps1038 then
					for iter_444_4, iter_444_5 in pairs(arg_441_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_444_5 then
							if arg_441_1.isInRecall_ then
								iter_444_5.color = Color.New(Mathf.Lerp(iter_444_5.color.r, arg_441_1.hightColor2.r, (arg_441_1.time_ - 0) / var_444_3), Mathf.Lerp(iter_444_5.color.g, arg_441_1.hightColor2.g, (arg_441_1.time_ - 0) / var_444_3), (Mathf.Lerp(iter_444_5.color.b, arg_441_1.hightColor2.b, (arg_441_1.time_ - 0) / var_444_3)))
							else
								local var_444_4 = Mathf.Lerp(iter_444_5.color.r, 0.5, (arg_441_1.time_ - 0) / var_444_3)

								iter_444_5.color = Color.New(var_444_4, var_444_4, var_444_4)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_3 and arg_441_1.time_ < 0 + var_444_3 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.actorSpriteComps1038 then
				for iter_444_6, iter_444_7 in pairs(arg_441_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_444_7 then
						iter_444_7.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_441_1.var_.actorSpriteComps1038 = nil
			end

			local var_444_5 = 0
			local var_444_6 = 0.5

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_5 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_7 = arg_441_1:GetWordFromCfg(115271108)
				local var_444_8 = arg_441_1:FormatText(var_444_7.content)

				arg_441_1.text_.text = var_444_8

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_10 = 20 <= 0 and var_444_6 or var_444_6 * (utf8.len(var_444_8) / 20)

				if (20 <= 0 and var_444_6 or var_444_6 * (utf8.len(var_444_8) / 20)) > 0 and var_444_6 < var_444_10 then
					arg_441_1.talkMaxDuration = var_444_10

					if var_444_10 + var_444_5 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_5
					end
				end

				arg_441_1.text_.text = var_444_8
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271108", "story_v_out_115271.awb") ~= 0 then
					local var_444_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271108", "story_v_out_115271.awb") / 1000

					if var_444_11 + var_444_5 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_11 + var_444_5
					end

					if var_444_7.prefab_name ~= "" and arg_441_1.actors_[var_444_7.prefab_name] ~= nil then
						local var_444_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_7.prefab_name].transform, "story_v_out_115271", "115271108", "story_v_out_115271.awb")

						arg_441_1:RecordAudio("115271108", var_444_12)
						arg_441_1:RecordAudio("115271108", var_444_12)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_115271", "115271108", "story_v_out_115271.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_115271", "115271108", "story_v_out_115271.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_13 = math.max(var_444_6, arg_441_1.talkMaxDuration)

			if var_444_5 <= arg_441_1.time_ and arg_441_1.time_ < var_444_5 + var_444_13 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_5) / var_444_13

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_5 + var_444_13 and arg_441_1.time_ < var_444_5 + var_444_13 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play115271109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 115271109
		arg_445_1.duration_ = 11.7

		local var_445_0 = {
			ja = 9.5,
			ko = 11.7,
			zh = 10.2,
			en = 10.9
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play115271110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["10030"]) and arg_445_1.var_.actorSpriteComps10030 == nil then
				arg_445_1.var_.actorSpriteComps10030 = arg_445_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["10030"]) then
				if arg_445_1.var_.actorSpriteComps10030 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_448_1 then
							if arg_445_1.isInRecall_ then
								iter_448_1.color = Color.New(Mathf.Lerp(iter_448_1.color.r, arg_445_1.hightColor2.r, (arg_445_1.time_ - 0) / var_448_0), Mathf.Lerp(iter_448_1.color.g, arg_445_1.hightColor2.g, (arg_445_1.time_ - 0) / var_448_0), (Mathf.Lerp(iter_448_1.color.b, arg_445_1.hightColor2.b, (arg_445_1.time_ - 0) / var_448_0)))
							else
								local var_448_1 = Mathf.Lerp(iter_448_1.color.r, 0.5, (arg_445_1.time_ - 0) / var_448_0)

								iter_448_1.color = Color.New(var_448_1, var_448_1, var_448_1)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["10030"]) and arg_445_1.var_.actorSpriteComps10030 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_448_3 then
						iter_448_3.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_445_1.var_.actorSpriteComps10030 = nil
			end

			local var_448_2 = arg_445_1.actors_["1038"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_2) and arg_445_1.var_.actorSpriteComps1038 == nil then
				arg_445_1.var_.actorSpriteComps1038 = var_448_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_3 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_3 and not isNil(var_448_2) then
				if arg_445_1.var_.actorSpriteComps1038 then
					for iter_448_4, iter_448_5 in pairs(arg_445_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_448_5 then
							if arg_445_1.isInRecall_ then
								iter_448_5.color = Color.New(Mathf.Lerp(iter_448_5.color.r, arg_445_1.hightColor1.r, (arg_445_1.time_ - 0) / var_448_3), Mathf.Lerp(iter_448_5.color.g, arg_445_1.hightColor1.g, (arg_445_1.time_ - 0) / var_448_3), (Mathf.Lerp(iter_448_5.color.b, arg_445_1.hightColor1.b, (arg_445_1.time_ - 0) / var_448_3)))
							else
								local var_448_4 = Mathf.Lerp(iter_448_5.color.r, 1, (arg_445_1.time_ - 0) / var_448_3)

								iter_448_5.color = Color.New(var_448_4, var_448_4, var_448_4)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= 0 + var_448_3 and arg_445_1.time_ < 0 + var_448_3 + arg_448_0 and not isNil(var_448_2) and arg_445_1.var_.actorSpriteComps1038 then
				for iter_448_6, iter_448_7 in pairs(arg_445_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_448_7 then
						iter_448_7.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_445_1.var_.actorSpriteComps1038 = nil
			end

			local var_448_5 = 0
			local var_448_6 = 0.95

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_7 = arg_445_1:GetWordFromCfg(115271109)
				local var_448_8 = arg_445_1:FormatText(var_448_7.content)

				arg_445_1.text_.text = var_448_8

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_10 = 38 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_8) / 38)

				if (38 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_8) / 38)) > 0 and var_448_6 < var_448_10 then
					arg_445_1.talkMaxDuration = var_448_10

					if var_448_10 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_5
					end
				end

				arg_445_1.text_.text = var_448_8
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271109", "story_v_out_115271.awb") ~= 0 then
					local var_448_11 = manager.audio:GetVoiceLength("story_v_out_115271", "115271109", "story_v_out_115271.awb") / 1000

					if var_448_11 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_11 + var_448_5
					end

					if var_448_7.prefab_name ~= "" and arg_445_1.actors_[var_448_7.prefab_name] ~= nil then
						local var_448_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_7.prefab_name].transform, "story_v_out_115271", "115271109", "story_v_out_115271.awb")

						arg_445_1:RecordAudio("115271109", var_448_12)
						arg_445_1:RecordAudio("115271109", var_448_12)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_115271", "115271109", "story_v_out_115271.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_115271", "115271109", "story_v_out_115271.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_13 = math.max(var_448_6, arg_445_1.talkMaxDuration)

			if var_448_5 <= arg_445_1.time_ and arg_445_1.time_ < var_448_5 + var_448_13 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_5) / var_448_13

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_5 + var_448_13 and arg_445_1.time_ < var_448_5 + var_448_13 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play115271110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 115271110
		arg_449_1.duration_ = 8.33

		local var_449_0 = {
			ja = 7.433,
			ko = 7.2,
			zh = 8.333,
			en = 7.233
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play115271111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.7

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(115271110)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 28 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 28)

				if (28 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 28)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271110", "story_v_out_115271.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271110", "story_v_out_115271.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_115271", "115271110", "story_v_out_115271.awb")

						arg_449_1:RecordAudio("115271110", var_452_6)
						arg_449_1:RecordAudio("115271110", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_115271", "115271110", "story_v_out_115271.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_115271", "115271110", "story_v_out_115271.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play115271111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 115271111
		arg_453_1.duration_ = 17.67

		local var_453_0 = {
			ja = 13.833,
			ko = 16.933,
			zh = 16.666,
			en = 17.666
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play115271112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 1.65

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:GetWordFromCfg(115271111)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 66 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 66)

				if (66 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 66)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271111", "story_v_out_115271.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271111", "story_v_out_115271.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_out_115271", "115271111", "story_v_out_115271.awb")

						arg_453_1:RecordAudio("115271111", var_456_6)
						arg_453_1:RecordAudio("115271111", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_115271", "115271111", "story_v_out_115271.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_115271", "115271111", "story_v_out_115271.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play115271112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 115271112
		arg_457_1.duration_ = 21.73

		local var_457_0 = {
			ja = 18.066,
			ko = 21.733,
			zh = 17.066,
			en = 17.9
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play115271113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.575

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:GetWordFromCfg(115271112)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 63 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 63)

				if (63 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 63)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271112", "story_v_out_115271.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271112", "story_v_out_115271.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_115271", "115271112", "story_v_out_115271.awb")

						arg_457_1:RecordAudio("115271112", var_460_6)
						arg_457_1:RecordAudio("115271112", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_115271", "115271112", "story_v_out_115271.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_115271", "115271112", "story_v_out_115271.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play115271113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 115271113
		arg_461_1.duration_ = 14.6

		local var_461_0 = {
			ja = 14.6,
			ko = 11.066,
			zh = 10.7,
			en = 9.066
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
				arg_461_0:Play115271114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:GetWordFromCfg(115271113)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 40 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 40)

				if (40 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 40)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271113", "story_v_out_115271.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271113", "story_v_out_115271.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_115271", "115271113", "story_v_out_115271.awb")

						arg_461_1:RecordAudio("115271113", var_464_6)
						arg_461_1:RecordAudio("115271113", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_115271", "115271113", "story_v_out_115271.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_115271", "115271113", "story_v_out_115271.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play115271114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 115271114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play115271115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1038"]) and arg_465_1.var_.actorSpriteComps1038 == nil then
				arg_465_1.var_.actorSpriteComps1038 = arg_465_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1038"]) then
				if arg_465_1.var_.actorSpriteComps1038 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps1038:ToTable()) do
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

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1038"]) and arg_465_1.var_.actorSpriteComps1038 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_468_3 then
						iter_468_3.color = arg_465_1.isInRecall_ and (arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_465_1.var_.actorSpriteComps1038 = nil
			end

			local var_468_2 = 0
			local var_468_3 = 0.725

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(115271114).content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 29 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 29)

				if (29 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 29)) > 0 and var_468_3 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_7 and arg_465_1.time_ < var_468_2 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play115271115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 115271115
		arg_469_1.duration_ = 17.2

		local var_469_0 = {
			ja = 17.2,
			ko = 15.666,
			zh = 15.4,
			en = 15
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play115271116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1038"]) and arg_469_1.var_.actorSpriteComps1038 == nil then
				arg_469_1.var_.actorSpriteComps1038 = arg_469_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_0 = 0.2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1038"]) then
				if arg_469_1.var_.actorSpriteComps1038 then
					for iter_472_0, iter_472_1 in pairs(arg_469_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_472_1 then
							if arg_469_1.isInRecall_ then
								iter_472_1.color = Color.New(Mathf.Lerp(iter_472_1.color.r, arg_469_1.hightColor1.r, (arg_469_1.time_ - 0) / var_472_0), Mathf.Lerp(iter_472_1.color.g, arg_469_1.hightColor1.g, (arg_469_1.time_ - 0) / var_472_0), (Mathf.Lerp(iter_472_1.color.b, arg_469_1.hightColor1.b, (arg_469_1.time_ - 0) / var_472_0)))
							else
								local var_472_1 = Mathf.Lerp(iter_472_1.color.r, 1, (arg_469_1.time_ - 0) / var_472_0)

								iter_472_1.color = Color.New(var_472_1, var_472_1, var_472_1)
							end
						end
					end
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1038"]) and arg_469_1.var_.actorSpriteComps1038 then
				for iter_472_2, iter_472_3 in pairs(arg_469_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_472_3 then
						iter_472_3.color = arg_469_1.isInRecall_ and (arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_469_1.var_.actorSpriteComps1038 = nil
			end

			local var_472_2 = 0
			local var_472_3 = 1.575

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_4 = arg_469_1:GetWordFromCfg(115271115)
				local var_472_5 = arg_469_1:FormatText(var_472_4.content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 63 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 63)

				if (63 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 63)) > 0 and var_472_3 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271115", "story_v_out_115271.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_115271", "115271115", "story_v_out_115271.awb") / 1000

					if var_472_8 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_2
					end

					if var_472_4.prefab_name ~= "" and arg_469_1.actors_[var_472_4.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_4.prefab_name].transform, "story_v_out_115271", "115271115", "story_v_out_115271.awb")

						arg_469_1:RecordAudio("115271115", var_472_9)
						arg_469_1:RecordAudio("115271115", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_115271", "115271115", "story_v_out_115271.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_115271", "115271115", "story_v_out_115271.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_10 and arg_469_1.time_ < var_472_2 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play115271116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 115271116
		arg_473_1.duration_ = 11.93

		local var_473_0 = {
			ja = 11.933,
			ko = 10.1,
			zh = 10.7,
			en = 10.5
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play115271117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 1.05

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:GetWordFromCfg(115271116)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 42 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 42)

				if (42 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 42)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271116", "story_v_out_115271.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271116", "story_v_out_115271.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_115271", "115271116", "story_v_out_115271.awb")

						arg_473_1:RecordAudio("115271116", var_476_6)
						arg_473_1:RecordAudio("115271116", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_115271", "115271116", "story_v_out_115271.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_115271", "115271116", "story_v_out_115271.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play115271117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 115271117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play115271118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				local var_480_0 = arg_477_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_480_0 then
					arg_477_1.var_.alphaOldValue1038 = var_480_0.alpha
					arg_477_1.var_.characterEffect1038 = var_480_0
				end

				arg_477_1.var_.alphaOldValue1038 = 1
			end

			local var_480_1 = 0.5

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_1 then
				if arg_477_1.var_.characterEffect1038 then
					arg_477_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_477_1.var_.alphaOldValue1038, 0, (arg_477_1.time_ - 0) / var_480_1)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_1 and arg_477_1.time_ < 0 + var_480_1 + arg_480_0 and arg_477_1.var_.characterEffect1038 then
				arg_477_1.var_.characterEffect1038.alpha = 0
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				local var_480_2 = arg_477_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_480_2 then
					arg_477_1.var_.alphaOldValue10030 = var_480_2.alpha
					arg_477_1.var_.characterEffect10030 = var_480_2
				end

				arg_477_1.var_.alphaOldValue10030 = 1
			end

			local var_480_3 = 0.5

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_3 then
				if arg_477_1.var_.characterEffect10030 then
					arg_477_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_477_1.var_.alphaOldValue10030, 0, (arg_477_1.time_ - 0) / var_480_3)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_3 and arg_477_1.time_ < 0 + var_480_3 + arg_480_0 and arg_477_1.var_.characterEffect10030 then
				arg_477_1.var_.characterEffect10030.alpha = 0
			end

			local var_480_4 = 0
			local var_480_5 = 0.95

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(115271117).content)

				arg_477_1.text_.text = var_480_6

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_8 = 38 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_6) / 38)

				if (38 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_6) / 38)) > 0 and var_480_5 < var_480_8 then
					arg_477_1.talkMaxDuration = var_480_8

					if var_480_8 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_6
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_9 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_9 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_9

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_9 and arg_477_1.time_ < var_480_4 + var_480_9 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play115271118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 115271118
		arg_481_1.duration_ = 7.5

		local var_481_0 = {
			ja = 7.5,
			ko = 7.366,
			zh = 5.666,
			en = 5.766
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play115271119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.8

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_1 = arg_481_1:GetWordFromCfg(115271118)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 32 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 32)

				if (32 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 32)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271118", "story_v_out_115271.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271118", "story_v_out_115271.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_115271", "115271118", "story_v_out_115271.awb")

						arg_481_1:RecordAudio("115271118", var_484_6)
						arg_481_1:RecordAudio("115271118", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_115271", "115271118", "story_v_out_115271.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_115271", "115271118", "story_v_out_115271.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play115271119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 115271119
		arg_485_1.duration_ = 18.8

		local var_485_0 = {
			ja = 14.633,
			ko = 15.566,
			zh = 14.933,
			en = 18.8
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play115271120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos10029 = arg_485_1.actors_["10029"].transform.localPosition
				arg_485_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_485_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_485_1.time_ - 0) / var_488_0)
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["10029"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				local var_488_1 = arg_485_1.actors_["10029"]:GetComponent("Image")

				if var_488_1 then
					arg_485_1.var_.alphaMatValue10029 = var_488_1
					arg_485_1.var_.alphaOldValue10029 = var_488_1.color.a
				end

				arg_485_1.var_.alphaOldValue10029 = 0
			end

			local var_488_2 = 0.5

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 then
				if arg_485_1.var_.alphaMatValue10029 then
					arg_485_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_485_1.var_.alphaOldValue10029, 1, (arg_485_1.time_ - 0) / var_488_2)
					arg_485_1.var_.alphaMatValue10029.color = arg_485_1.var_.alphaMatValue10029.color
				end
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 and arg_485_1.var_.alphaMatValue10029 then
				arg_485_1.var_.alphaMatValue10029.color.a = 1
				arg_485_1.var_.alphaMatValue10029.color = arg_485_1.var_.alphaMatValue10029.color
			end

			local var_488_3 = arg_485_1.actors_["10029"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_3) then
				local var_488_4 = var_488_3:GetComponent("Image")

				if var_488_4 then
					arg_485_1.var_.highlightMatValue10029 = var_488_4
				end
			end

			local var_488_5 = 0.2

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_5 and not isNil(var_488_3) then
				if arg_485_1.var_.highlightMatValue10029 then
					local var_488_6 = Mathf.Lerp(0.5, 1, (arg_485_1.time_ - 0) / var_488_5)

					arg_485_1.var_.highlightMatValue10029.color.r = var_488_6
					arg_485_1.var_.highlightMatValue10029.color.g = var_488_6
					arg_485_1.var_.highlightMatValue10029.color.b = var_488_6
					arg_485_1.var_.highlightMatValue10029.color = arg_485_1.var_.highlightMatValue10029.color
				end
			end

			if arg_485_1.time_ >= 0 + var_488_5 and arg_485_1.time_ < 0 + var_488_5 + arg_488_0 and not isNil(var_488_3) and arg_485_1.var_.highlightMatValue10029 then
				var_488_3.transform:SetSiblingIndex(1)

				arg_485_1.var_.highlightMatValue10029.color.r = 1
				arg_485_1.var_.highlightMatValue10029.color.g = 1
				arg_485_1.var_.highlightMatValue10029.color.b = 1
				arg_485_1.var_.highlightMatValue10029.color = arg_485_1.var_.highlightMatValue10029.color
			end

			local var_488_7 = 0
			local var_488_8 = 1.6

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_7 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_9 = arg_485_1:GetWordFromCfg(115271119)
				local var_488_10 = arg_485_1:FormatText(var_488_9.content)

				arg_485_1.text_.text = var_488_10

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_12 = 64 <= 0 and var_488_8 or var_488_8 * (utf8.len(var_488_10) / 64)

				if (64 <= 0 and var_488_8 or var_488_8 * (utf8.len(var_488_10) / 64)) > 0 and var_488_8 < var_488_12 then
					arg_485_1.talkMaxDuration = var_488_12

					if var_488_12 + var_488_7 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_12 + var_488_7
					end
				end

				arg_485_1.text_.text = var_488_10
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271119", "story_v_out_115271.awb") ~= 0 then
					local var_488_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271119", "story_v_out_115271.awb") / 1000

					if var_488_13 + var_488_7 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_13 + var_488_7
					end

					if var_488_9.prefab_name ~= "" and arg_485_1.actors_[var_488_9.prefab_name] ~= nil then
						local var_488_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_9.prefab_name].transform, "story_v_out_115271", "115271119", "story_v_out_115271.awb")

						arg_485_1:RecordAudio("115271119", var_488_14)
						arg_485_1:RecordAudio("115271119", var_488_14)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_115271", "115271119", "story_v_out_115271.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_115271", "115271119", "story_v_out_115271.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_15 = math.max(var_488_8, arg_485_1.talkMaxDuration)

			if var_488_7 <= arg_485_1.time_ and arg_485_1.time_ < var_488_7 + var_488_15 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_7) / var_488_15

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_7 + var_488_15 and arg_485_1.time_ < var_488_7 + var_488_15 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play115271120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 115271120
		arg_489_1.duration_ = 22.87

		local var_489_0 = {
			ja = 13.4,
			ko = 18,
			zh = 14.1,
			en = 22.866
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play115271121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 1.65

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:GetWordFromCfg(115271120)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 66 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 66)

				if (66 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 66)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271120", "story_v_out_115271.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271120", "story_v_out_115271.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_115271", "115271120", "story_v_out_115271.awb")

						arg_489_1:RecordAudio("115271120", var_492_6)
						arg_489_1:RecordAudio("115271120", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_115271", "115271120", "story_v_out_115271.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_115271", "115271120", "story_v_out_115271.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play115271121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 115271121
		arg_493_1.duration_ = 18.97

		local var_493_0 = {
			ja = 15.466,
			ko = 14.9,
			zh = 13.166,
			en = 18.966
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
				arg_493_0:Play115271122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 1.475

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:GetWordFromCfg(115271121)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 59 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 59)

				if (59 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 59)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271121", "story_v_out_115271.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271121", "story_v_out_115271.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_out_115271", "115271121", "story_v_out_115271.awb")

						arg_493_1:RecordAudio("115271121", var_496_6)
						arg_493_1:RecordAudio("115271121", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_115271", "115271121", "story_v_out_115271.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_115271", "115271121", "story_v_out_115271.awb")
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
	Play115271122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 115271122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play115271123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				local var_500_0 = arg_497_1.actors_["10029"]:GetComponent("Image")

				if var_500_0 then
					arg_497_1.var_.alphaMatValue10029 = var_500_0
					arg_497_1.var_.alphaOldValue10029 = var_500_0.color.a
				end

				arg_497_1.var_.alphaOldValue10029 = 1
			end

			local var_500_1 = 0.5

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_1 then
				if arg_497_1.var_.alphaMatValue10029 then
					arg_497_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_497_1.var_.alphaOldValue10029, 0, (arg_497_1.time_ - 0) / var_500_1)
					arg_497_1.var_.alphaMatValue10029.color = arg_497_1.var_.alphaMatValue10029.color
				end
			end

			if arg_497_1.time_ >= 0 + var_500_1 and arg_497_1.time_ < 0 + var_500_1 + arg_500_0 and arg_497_1.var_.alphaMatValue10029 then
				arg_497_1.var_.alphaMatValue10029.color.a = 0
				arg_497_1.var_.alphaMatValue10029.color = arg_497_1.var_.alphaMatValue10029.color
			end

			local var_500_2 = 0
			local var_500_3 = 0.525

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_2 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_4 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(115271122).content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 21 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_4) / 21)

				if (21 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_4) / 21)) > 0 and var_500_3 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_2
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_3, arg_497_1.talkMaxDuration)

			if var_500_2 <= arg_497_1.time_ and arg_497_1.time_ < var_500_2 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_2) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_2 + var_500_7 and arg_497_1.time_ < var_500_2 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play115271123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 115271123
		arg_501_1.duration_ = 3.2

		local var_501_0 = {
			ja = 3.2,
			ko = 1.366,
			zh = 2.433,
			en = 1.266
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play115271124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1038 = arg_501_1.actors_["1038"].transform.localPosition
				arg_501_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_501_1:CheckSpriteTmpPos("1038", 2)

				for iter_504_0 = 0, arg_501_1.actors_["1038"].transform.childCount - 1 do
					local var_504_0 = arg_501_1.actors_["1038"].transform:GetChild(iter_504_0)

					if var_504_0.name == "split_9" or not string.find(var_504_0.name, "split") then
						var_504_0.gameObject:SetActive(true)
					else
						var_504_0.gameObject:SetActive(false)
					end
				end
			end

			local var_504_1 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_1 then
				arg_501_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_501_1.time_ - 0) / var_504_1)
			end

			if arg_501_1.time_ >= 0 + var_504_1 and arg_501_1.time_ < 0 + var_504_1 + arg_504_0 then
				arg_501_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				local var_504_2 = arg_501_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_504_2 then
					arg_501_1.var_.alphaOldValue1038 = var_504_2.alpha
					arg_501_1.var_.characterEffect1038 = var_504_2
				end

				arg_501_1.var_.alphaOldValue1038 = 0
			end

			local var_504_3 = 0.5

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_3 then
				if arg_501_1.var_.characterEffect1038 then
					arg_501_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_501_1.var_.alphaOldValue1038, 1, (arg_501_1.time_ - 0) / var_504_3)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_3 and arg_501_1.time_ < 0 + var_504_3 + arg_504_0 and arg_501_1.var_.characterEffect1038 then
				arg_501_1.var_.characterEffect1038.alpha = 1
			end

			local var_504_4 = arg_501_1.actors_["1038"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.actorSpriteComps1038 == nil then
				arg_501_1.var_.actorSpriteComps1038 = var_504_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_504_5 = 0.2

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_5 and not isNil(var_504_4) then
				if arg_501_1.var_.actorSpriteComps1038 then
					for iter_504_1, iter_504_2 in pairs(arg_501_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_504_2 then
							if arg_501_1.isInRecall_ then
								iter_504_2.color = Color.New(Mathf.Lerp(iter_504_2.color.r, arg_501_1.hightColor1.r, (arg_501_1.time_ - 0) / var_504_5), Mathf.Lerp(iter_504_2.color.g, arg_501_1.hightColor1.g, (arg_501_1.time_ - 0) / var_504_5), (Mathf.Lerp(iter_504_2.color.b, arg_501_1.hightColor1.b, (arg_501_1.time_ - 0) / var_504_5)))
							else
								local var_504_6 = Mathf.Lerp(iter_504_2.color.r, 1, (arg_501_1.time_ - 0) / var_504_5)

								iter_504_2.color = Color.New(var_504_6, var_504_6, var_504_6)
							end
						end
					end
				end
			end

			if arg_501_1.time_ >= 0 + var_504_5 and arg_501_1.time_ < 0 + var_504_5 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.actorSpriteComps1038 then
				for iter_504_3, iter_504_4 in pairs(arg_501_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_504_4 then
						iter_504_4.color = arg_501_1.isInRecall_ and (arg_501_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_501_1.var_.actorSpriteComps1038 = nil
			end

			local var_504_7 = 0
			local var_504_8 = 0.125

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_7 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_9 = arg_501_1:GetWordFromCfg(115271123)
				local var_504_10 = arg_501_1:FormatText(var_504_9.content)

				arg_501_1.text_.text = var_504_10

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_12 = 5 <= 0 and var_504_8 or var_504_8 * (utf8.len(var_504_10) / 5)

				if (5 <= 0 and var_504_8 or var_504_8 * (utf8.len(var_504_10) / 5)) > 0 and var_504_8 < var_504_12 then
					arg_501_1.talkMaxDuration = var_504_12

					if var_504_12 + var_504_7 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_12 + var_504_7
					end
				end

				arg_501_1.text_.text = var_504_10
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271123", "story_v_out_115271.awb") ~= 0 then
					local var_504_13 = manager.audio:GetVoiceLength("story_v_out_115271", "115271123", "story_v_out_115271.awb") / 1000

					if var_504_13 + var_504_7 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_13 + var_504_7
					end

					if var_504_9.prefab_name ~= "" and arg_501_1.actors_[var_504_9.prefab_name] ~= nil then
						local var_504_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_9.prefab_name].transform, "story_v_out_115271", "115271123", "story_v_out_115271.awb")

						arg_501_1:RecordAudio("115271123", var_504_14)
						arg_501_1:RecordAudio("115271123", var_504_14)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_115271", "115271123", "story_v_out_115271.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_115271", "115271123", "story_v_out_115271.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_15 = math.max(var_504_8, arg_501_1.talkMaxDuration)

			if var_504_7 <= arg_501_1.time_ and arg_501_1.time_ < var_504_7 + var_504_15 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_7) / var_504_15

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_7 + var_504_15 and arg_501_1.time_ < var_504_7 + var_504_15 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play115271124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 115271124
		arg_505_1.duration_ = 6.2

		local var_505_0 = {
			ja = 5.433,
			ko = 5.233,
			zh = 4.5,
			en = 6.2
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play115271125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				local var_508_0 = arg_505_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_508_0 then
					arg_505_1.var_.alphaOldValue10030 = var_508_0.alpha
					arg_505_1.var_.characterEffect10030 = var_508_0
				end

				arg_505_1.var_.alphaOldValue10030 = 0
			end

			local var_508_1 = 0.5

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_1 then
				if arg_505_1.var_.characterEffect10030 then
					arg_505_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_505_1.var_.alphaOldValue10030, 1, (arg_505_1.time_ - 0) / var_508_1)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_1 and arg_505_1.time_ < 0 + var_508_1 + arg_508_0 and arg_505_1.var_.characterEffect10030 then
				arg_505_1.var_.characterEffect10030.alpha = 1
			end

			local var_508_2 = arg_505_1.actors_["10030"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_2) and arg_505_1.var_.actorSpriteComps10030 == nil then
				arg_505_1.var_.actorSpriteComps10030 = var_508_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_3 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_3 and not isNil(var_508_2) then
				if arg_505_1.var_.actorSpriteComps10030 then
					for iter_508_0, iter_508_1 in pairs(arg_505_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_508_1 then
							if arg_505_1.isInRecall_ then
								iter_508_1.color = Color.New(Mathf.Lerp(iter_508_1.color.r, arg_505_1.hightColor1.r, (arg_505_1.time_ - 0) / var_508_3), Mathf.Lerp(iter_508_1.color.g, arg_505_1.hightColor1.g, (arg_505_1.time_ - 0) / var_508_3), (Mathf.Lerp(iter_508_1.color.b, arg_505_1.hightColor1.b, (arg_505_1.time_ - 0) / var_508_3)))
							else
								local var_508_4 = Mathf.Lerp(iter_508_1.color.r, 1, (arg_505_1.time_ - 0) / var_508_3)

								iter_508_1.color = Color.New(var_508_4, var_508_4, var_508_4)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= 0 + var_508_3 and arg_505_1.time_ < 0 + var_508_3 + arg_508_0 and not isNil(var_508_2) and arg_505_1.var_.actorSpriteComps10030 then
				for iter_508_2, iter_508_3 in pairs(arg_505_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_508_3 then
						iter_508_3.color = arg_505_1.isInRecall_ and (arg_505_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_505_1.var_.actorSpriteComps10030 = nil
			end

			local var_508_5 = arg_505_1.actors_["10030"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos10030 = var_508_5.localPosition
				var_508_5.localScale = Vector3.New(1, 1, 1)

				arg_505_1:CheckSpriteTmpPos("10030", 4)

				for iter_508_4 = 0, var_508_5.childCount - 1 do
					local var_508_6 = var_508_5:GetChild(iter_508_4)

					if var_508_6.name == "split_3" or not string.find(var_508_6.name, "split") then
						var_508_6.gameObject:SetActive(true)
					else
						var_508_6.gameObject:SetActive(false)
					end
				end
			end

			local var_508_7 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				var_508_5.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_505_1.time_ - 0) / var_508_7)
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				var_508_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_508_8 = arg_505_1.actors_["1038"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_8) and arg_505_1.var_.actorSpriteComps1038 == nil then
				arg_505_1.var_.actorSpriteComps1038 = var_508_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_9 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_9 and not isNil(var_508_8) then
				if arg_505_1.var_.actorSpriteComps1038 then
					for iter_508_5, iter_508_6 in pairs(arg_505_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_508_6 then
							if arg_505_1.isInRecall_ then
								iter_508_6.color = Color.New(Mathf.Lerp(iter_508_6.color.r, arg_505_1.hightColor2.r, (arg_505_1.time_ - 0) / var_508_9), Mathf.Lerp(iter_508_6.color.g, arg_505_1.hightColor2.g, (arg_505_1.time_ - 0) / var_508_9), (Mathf.Lerp(iter_508_6.color.b, arg_505_1.hightColor2.b, (arg_505_1.time_ - 0) / var_508_9)))
							else
								local var_508_10 = Mathf.Lerp(iter_508_6.color.r, 0.5, (arg_505_1.time_ - 0) / var_508_9)

								iter_508_6.color = Color.New(var_508_10, var_508_10, var_508_10)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= 0 + var_508_9 and arg_505_1.time_ < 0 + var_508_9 + arg_508_0 and not isNil(var_508_8) and arg_505_1.var_.actorSpriteComps1038 then
				for iter_508_7, iter_508_8 in pairs(arg_505_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_508_8 then
						iter_508_8.color = arg_505_1.isInRecall_ and (arg_505_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_505_1.var_.actorSpriteComps1038 = nil
			end

			local var_508_11 = 0
			local var_508_12 = 0.5

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_11 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_13 = arg_505_1:GetWordFromCfg(115271124)
				local var_508_14 = arg_505_1:FormatText(var_508_13.content)

				arg_505_1.text_.text = var_508_14

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_16 = 19 <= 0 and var_508_12 or var_508_12 * (utf8.len(var_508_14) / 19)

				if (19 <= 0 and var_508_12 or var_508_12 * (utf8.len(var_508_14) / 19)) > 0 and var_508_12 < var_508_16 then
					arg_505_1.talkMaxDuration = var_508_16

					if var_508_16 + var_508_11 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_16 + var_508_11
					end
				end

				arg_505_1.text_.text = var_508_14
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271124", "story_v_out_115271.awb") ~= 0 then
					local var_508_17 = manager.audio:GetVoiceLength("story_v_out_115271", "115271124", "story_v_out_115271.awb") / 1000

					if var_508_17 + var_508_11 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_17 + var_508_11
					end

					if var_508_13.prefab_name ~= "" and arg_505_1.actors_[var_508_13.prefab_name] ~= nil then
						local var_508_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_13.prefab_name].transform, "story_v_out_115271", "115271124", "story_v_out_115271.awb")

						arg_505_1:RecordAudio("115271124", var_508_18)
						arg_505_1:RecordAudio("115271124", var_508_18)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_115271", "115271124", "story_v_out_115271.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_115271", "115271124", "story_v_out_115271.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_19 = math.max(var_508_12, arg_505_1.talkMaxDuration)

			if var_508_11 <= arg_505_1.time_ and arg_505_1.time_ < var_508_11 + var_508_19 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_11) / var_508_19

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_11 + var_508_19 and arg_505_1.time_ < var_508_11 + var_508_19 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play115271125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 115271125
		arg_509_1.duration_ = 6.3

		local var_509_0 = {
			ja = 6.3,
			ko = 2.3,
			zh = 3.166,
			en = 2.933
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play115271126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["10030"]) and arg_509_1.var_.actorSpriteComps10030 == nil then
				arg_509_1.var_.actorSpriteComps10030 = arg_509_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_0 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["10030"]) then
				if arg_509_1.var_.actorSpriteComps10030 then
					for iter_512_0, iter_512_1 in pairs(arg_509_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_512_1 then
							if arg_509_1.isInRecall_ then
								iter_512_1.color = Color.New(Mathf.Lerp(iter_512_1.color.r, arg_509_1.hightColor1.r, (arg_509_1.time_ - 0) / var_512_0), Mathf.Lerp(iter_512_1.color.g, arg_509_1.hightColor1.g, (arg_509_1.time_ - 0) / var_512_0), (Mathf.Lerp(iter_512_1.color.b, arg_509_1.hightColor1.b, (arg_509_1.time_ - 0) / var_512_0)))
							else
								local var_512_1 = Mathf.Lerp(iter_512_1.color.r, 1, (arg_509_1.time_ - 0) / var_512_0)

								iter_512_1.color = Color.New(var_512_1, var_512_1, var_512_1)
							end
						end
					end
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["10030"]) and arg_509_1.var_.actorSpriteComps10030 then
				for iter_512_2, iter_512_3 in pairs(arg_509_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_512_3 then
						iter_512_3.color = arg_509_1.isInRecall_ and (arg_509_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_509_1.var_.actorSpriteComps10030 = nil
			end

			local var_512_2 = arg_509_1.actors_["10030"].transform

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos10030 = var_512_2.localPosition
				var_512_2.localScale = Vector3.New(1, 1, 1)

				arg_509_1:CheckSpriteTmpPos("10030", 3)

				for iter_512_4 = 0, var_512_2.childCount - 1 do
					local var_512_3 = var_512_2:GetChild(iter_512_4)

					if var_512_3.name == "split_2" or not string.find(var_512_3.name, "split") then
						var_512_3.gameObject:SetActive(true)
					else
						var_512_3.gameObject:SetActive(false)
					end
				end
			end

			local var_512_4 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				var_512_2.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_509_1.time_ - 0) / var_512_4)
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				var_512_2.localPosition = Vector3.New(0, -390, 150)
			end

			local var_512_5 = arg_509_1.actors_["1038"].transform

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1038 = var_512_5.localPosition
				var_512_5.localScale = Vector3.New(1, 1, 1)

				arg_509_1:CheckSpriteTmpPos("1038", 7)

				for iter_512_5 = 0, var_512_5.childCount - 1 do
					local var_512_6 = var_512_5:GetChild(iter_512_5)

					if var_512_6.name == "split_9" or not string.find(var_512_6.name, "split") then
						var_512_6.gameObject:SetActive(true)
					else
						var_512_6.gameObject:SetActive(false)
					end
				end
			end

			local var_512_7 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				var_512_5.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1038, Vector3.New(0, -2000, 150), (arg_509_1.time_ - 0) / var_512_7)
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				var_512_5.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_512_8 = 0
			local var_512_9 = 0.25

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_8 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_10 = arg_509_1:GetWordFromCfg(115271125)
				local var_512_11 = arg_509_1:FormatText(var_512_10.content)

				arg_509_1.text_.text = var_512_11

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_13 = 10 <= 0 and var_512_9 or var_512_9 * (utf8.len(var_512_11) / 10)

				if (10 <= 0 and var_512_9 or var_512_9 * (utf8.len(var_512_11) / 10)) > 0 and var_512_9 < var_512_13 then
					arg_509_1.talkMaxDuration = var_512_13

					if var_512_13 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_13 + var_512_8
					end
				end

				arg_509_1.text_.text = var_512_11
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271125", "story_v_out_115271.awb") ~= 0 then
					local var_512_14 = manager.audio:GetVoiceLength("story_v_out_115271", "115271125", "story_v_out_115271.awb") / 1000

					if var_512_14 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_14 + var_512_8
					end

					if var_512_10.prefab_name ~= "" and arg_509_1.actors_[var_512_10.prefab_name] ~= nil then
						local var_512_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_10.prefab_name].transform, "story_v_out_115271", "115271125", "story_v_out_115271.awb")

						arg_509_1:RecordAudio("115271125", var_512_15)
						arg_509_1:RecordAudio("115271125", var_512_15)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_115271", "115271125", "story_v_out_115271.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_115271", "115271125", "story_v_out_115271.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_16 = math.max(var_512_9, arg_509_1.talkMaxDuration)

			if var_512_8 <= arg_509_1.time_ and arg_509_1.time_ < var_512_8 + var_512_16 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_8) / var_512_16

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_8 + var_512_16 and arg_509_1.time_ < var_512_8 + var_512_16 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play115271126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 115271126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play115271127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["10030"]) and arg_513_1.var_.actorSpriteComps10030 == nil then
				arg_513_1.var_.actorSpriteComps10030 = arg_513_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_516_0 = 0.2

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["10030"]) then
				if arg_513_1.var_.actorSpriteComps10030 then
					for iter_516_0, iter_516_1 in pairs(arg_513_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_516_1 then
							if arg_513_1.isInRecall_ then
								iter_516_1.color = Color.New(Mathf.Lerp(iter_516_1.color.r, arg_513_1.hightColor2.r, (arg_513_1.time_ - 0) / var_516_0), Mathf.Lerp(iter_516_1.color.g, arg_513_1.hightColor2.g, (arg_513_1.time_ - 0) / var_516_0), (Mathf.Lerp(iter_516_1.color.b, arg_513_1.hightColor2.b, (arg_513_1.time_ - 0) / var_516_0)))
							else
								local var_516_1 = Mathf.Lerp(iter_516_1.color.r, 0.5, (arg_513_1.time_ - 0) / var_516_0)

								iter_516_1.color = Color.New(var_516_1, var_516_1, var_516_1)
							end
						end
					end
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["10030"]) and arg_513_1.var_.actorSpriteComps10030 then
				for iter_516_2, iter_516_3 in pairs(arg_513_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_516_3 then
						iter_516_3.color = arg_513_1.isInRecall_ and (arg_513_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_513_1.var_.actorSpriteComps10030 = nil
			end

			local var_516_2 = 0
			local var_516_3 = 0.5

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_4 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(115271126).content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_6 = 20 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_4) / 20)

				if (20 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_4) / 20)) > 0 and var_516_3 < var_516_6 then
					arg_513_1.talkMaxDuration = var_516_6

					if var_516_6 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_6 + var_516_2
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_3, arg_513_1.talkMaxDuration)

			if var_516_2 <= arg_513_1.time_ and arg_513_1.time_ < var_516_2 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_2) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_2 + var_516_7 and arg_513_1.time_ < var_516_2 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play115271127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 115271127
		arg_517_1.duration_ = 3.33

		local var_517_0 = {
			ja = 3.1,
			ko = 1.4,
			zh = 3.333,
			en = 1.4
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play115271128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.125

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_1")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:GetWordFromCfg(115271127)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 5 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 5)

				if (5 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 5)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271127", "story_v_out_115271.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271127", "story_v_out_115271.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_out_115271", "115271127", "story_v_out_115271.awb")

						arg_517_1:RecordAudio("115271127", var_520_6)
						arg_517_1:RecordAudio("115271127", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_115271", "115271127", "story_v_out_115271.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_115271", "115271127", "story_v_out_115271.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play115271128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 115271128
		arg_521_1.duration_ = 3.77

		local var_521_0 = {
			ja = 2.933,
			ko = 3.766,
			zh = 2.1,
			en = 1.6
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play115271129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["10030"]) and arg_521_1.var_.actorSpriteComps10030 == nil then
				arg_521_1.var_.actorSpriteComps10030 = arg_521_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_0 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["10030"]) then
				if arg_521_1.var_.actorSpriteComps10030 then
					for iter_524_0, iter_524_1 in pairs(arg_521_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_524_1 then
							if arg_521_1.isInRecall_ then
								iter_524_1.color = Color.New(Mathf.Lerp(iter_524_1.color.r, arg_521_1.hightColor1.r, (arg_521_1.time_ - 0) / var_524_0), Mathf.Lerp(iter_524_1.color.g, arg_521_1.hightColor1.g, (arg_521_1.time_ - 0) / var_524_0), (Mathf.Lerp(iter_524_1.color.b, arg_521_1.hightColor1.b, (arg_521_1.time_ - 0) / var_524_0)))
							else
								local var_524_1 = Mathf.Lerp(iter_524_1.color.r, 1, (arg_521_1.time_ - 0) / var_524_0)

								iter_524_1.color = Color.New(var_524_1, var_524_1, var_524_1)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["10030"]) and arg_521_1.var_.actorSpriteComps10030 then
				for iter_524_2, iter_524_3 in pairs(arg_521_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_524_3 then
						iter_524_3.color = arg_521_1.isInRecall_ and (arg_521_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_521_1.var_.actorSpriteComps10030 = nil
			end

			local var_524_2 = 0
			local var_524_3 = 0.225

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_2 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_4 = arg_521_1:GetWordFromCfg(115271128)
				local var_524_5 = arg_521_1:FormatText(var_524_4.content)

				arg_521_1.text_.text = var_524_5

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_7 = 9 <= 0 and var_524_3 or var_524_3 * (utf8.len(var_524_5) / 9)

				if (9 <= 0 and var_524_3 or var_524_3 * (utf8.len(var_524_5) / 9)) > 0 and var_524_3 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_2 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_2
					end
				end

				arg_521_1.text_.text = var_524_5
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271128", "story_v_out_115271.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_out_115271", "115271128", "story_v_out_115271.awb") / 1000

					if var_524_8 + var_524_2 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_2
					end

					if var_524_4.prefab_name ~= "" and arg_521_1.actors_[var_524_4.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_4.prefab_name].transform, "story_v_out_115271", "115271128", "story_v_out_115271.awb")

						arg_521_1:RecordAudio("115271128", var_524_9)
						arg_521_1:RecordAudio("115271128", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_115271", "115271128", "story_v_out_115271.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_115271", "115271128", "story_v_out_115271.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_3, arg_521_1.talkMaxDuration)

			if var_524_2 <= arg_521_1.time_ and arg_521_1.time_ < var_524_2 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_2) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_2 + var_524_10 and arg_521_1.time_ < var_524_2 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play115271129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 115271129
		arg_525_1.duration_ = 12.9

		local var_525_0 = {
			ja = 12.9,
			ko = 6.2,
			zh = 5.666,
			en = 9.066
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play115271130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.7

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(115271129)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 28 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 28)

				if (28 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 28)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271129", "story_v_out_115271.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271129", "story_v_out_115271.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_out_115271", "115271129", "story_v_out_115271.awb")

						arg_525_1:RecordAudio("115271129", var_528_6)
						arg_525_1:RecordAudio("115271129", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_115271", "115271129", "story_v_out_115271.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_115271", "115271129", "story_v_out_115271.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play115271130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 115271130
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play115271131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				local var_532_0 = arg_529_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_532_0 then
					arg_529_1.var_.alphaOldValue10030 = var_532_0.alpha
					arg_529_1.var_.characterEffect10030 = var_532_0
				end

				arg_529_1.var_.alphaOldValue10030 = 1
			end

			local var_532_1 = 0.5

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_1 then
				if arg_529_1.var_.characterEffect10030 then
					arg_529_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_529_1.var_.alphaOldValue10030, 0, (arg_529_1.time_ - 0) / var_532_1)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_1 and arg_529_1.time_ < 0 + var_532_1 + arg_532_0 and arg_529_1.var_.characterEffect10030 then
				arg_529_1.var_.characterEffect10030.alpha = 0
			end

			local var_532_2 = 0
			local var_532_3 = 0.875

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_2 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_4 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(115271130).content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_6 = 35 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_4) / 35)

				if (35 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_4) / 35)) > 0 and var_532_3 < var_532_6 then
					arg_529_1.talkMaxDuration = var_532_6

					if var_532_6 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_2
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_3, arg_529_1.talkMaxDuration)

			if var_532_2 <= arg_529_1.time_ and arg_529_1.time_ < var_532_2 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_2) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_2 + var_532_7 and arg_529_1.time_ < var_532_2 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play115271131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 115271131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play115271132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.475

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(115271131).content)

				arg_533_1.text_.text = var_536_1

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_3 = 19 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 19)

				if (19 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 19)) > 0 and var_536_0 < var_536_3 then
					arg_533_1.talkMaxDuration = var_536_3

					if var_536_3 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_3 + 0
					end
				end

				arg_533_1.text_.text = var_536_1
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_4 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_4

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play115271132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 115271132
		arg_537_1.duration_ = 9.03

		local var_537_0 = {
			ja = 9.033,
			ko = 6.1,
			zh = 6.966,
			en = 5.033
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
			arg_537_1.auto_ = false
		end

		function arg_537_1.playNext_(arg_539_0)
			arg_537_1.onStoryFinished_()
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.625

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_2")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_1 = arg_537_1:GetWordFromCfg(115271132)
				local var_540_2 = arg_537_1:FormatText(var_540_1.content)

				arg_537_1.text_.text = var_540_2

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 25 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 25)

				if (25 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 25)) > 0 and var_540_0 < var_540_4 then
					arg_537_1.talkMaxDuration = var_540_4

					if var_540_4 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_4 + 0
					end
				end

				arg_537_1.text_.text = var_540_2
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115271", "115271132", "story_v_out_115271.awb") ~= 0 then
					local var_540_5 = manager.audio:GetVoiceLength("story_v_out_115271", "115271132", "story_v_out_115271.awb") / 1000

					if var_540_5 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + 0
					end

					if var_540_1.prefab_name ~= "" and arg_537_1.actors_[var_540_1.prefab_name] ~= nil then
						local var_540_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_1.prefab_name].transform, "story_v_out_115271", "115271132", "story_v_out_115271.awb")

						arg_537_1:RecordAudio("115271132", var_540_6)
						arg_537_1:RecordAudio("115271132", var_540_6)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_115271", "115271132", "story_v_out_115271.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_115271", "115271132", "story_v_out_115271.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_7 and arg_537_1.time_ < 0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/ST28a"
	},
	voices = {
		"story_v_out_115271.awb"
	}
}
