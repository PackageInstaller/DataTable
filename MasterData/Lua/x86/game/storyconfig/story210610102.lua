return {
	Play1106102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106102001
		arg_1_1.duration_ = 19.1

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST39 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST39")
				var_4_0.name = "ST39"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST39 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST39

				arg_1_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST39" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1.55

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(1106102001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 62 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 62)

				if (62 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 62)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102001", "story_v_side_new_1106102.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102001", "story_v_side_new_1106102.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_side_new_1106102", "1106102001", "story_v_side_new_1106102.awb")

						arg_1_1:RecordAudio("1106102001", var_4_24)
						arg_1_1:RecordAudio("1106102001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102001", "story_v_side_new_1106102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102001", "story_v_side_new_1106102.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106102002
		arg_9_1.duration_ = 7.97

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.8

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(1106102002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 32)

				if (32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 32)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102002", "story_v_side_new_1106102.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102002", "story_v_side_new_1106102.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_side_new_1106102", "1106102002", "story_v_side_new_1106102.awb")

						arg_9_1:RecordAudio("1106102002", var_12_6)
						arg_9_1:RecordAudio("1106102002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102002", "story_v_side_new_1106102.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102002", "story_v_side_new_1106102.awb")
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
	Play1106102003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106102003
		arg_13_1.duration_ = 11.73

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1106102004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(1106102003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 44 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 44)

				if (44 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 44)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102003", "story_v_side_new_1106102.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102003", "story_v_side_new_1106102.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_new_1106102", "1106102003", "story_v_side_new_1106102.awb")

						arg_13_1:RecordAudio("1106102003", var_16_6)
						arg_13_1:RecordAudio("1106102003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102003", "story_v_side_new_1106102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102003", "story_v_side_new_1106102.awb")
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
	Play1106102004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106102004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1106102005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.875

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1106102004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 35 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 35)

				if (35 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 35)) > 0 and var_20_0 < var_20_3 then
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
	Play1106102005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106102005
		arg_21_1.duration_ = 2.73

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1106102006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1061ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1061ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1061ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1061ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1061ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect1061ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1061ui_story then
				arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_6 = arg_21_1.actors_["1061ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061ui_story = var_24_6.localPosition

				arg_21_1:ShowWeapon(arg_21_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_6.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_21_1.time_ - 0) / var_24_7)
				var_24_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_6.position).x, (manager.ui.mainCamera.transform.position - var_24_6.position).y, (manager.ui.mainCamera.transform.position - var_24_6.position).z)
				var_24_6.localEulerAngles.z = 0
				var_24_6.localEulerAngles.x = 0
				var_24_6.localEulerAngles = var_24_6.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_6.localPosition = Vector3.New(0, -1.18, -6.15)
				var_24_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_6.position).x, (manager.ui.mainCamera.transform.position - var_24_6.position).y, (manager.ui.mainCamera.transform.position - var_24_6.position).z)
				var_24_6.localEulerAngles.z = 0
				var_24_6.localEulerAngles.x = 0
				var_24_6.localEulerAngles = var_24_6.localEulerAngles
			end

			local var_24_8 = 0
			local var_24_9 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
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

				local var_24_10 = arg_21_1:GetWordFromCfg(1106102005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 11 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 11)

				if (11 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 11)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102005", "story_v_side_new_1106102.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102005", "story_v_side_new_1106102.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_side_new_1106102", "1106102005", "story_v_side_new_1106102.awb")

						arg_21_1:RecordAudio("1106102005", var_24_15)
						arg_21_1:RecordAudio("1106102005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102005", "story_v_side_new_1106102.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102005", "story_v_side_new_1106102.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play1106102006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106102006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1106102007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = arg_25_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) then
				if arg_25_1.var_.characterEffect1061ui_story and not isNil(arg_25_1.actors_["1061ui_story"]) then
					arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) and arg_25_1.var_.characterEffect1061ui_story then
				arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
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

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1106102006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 7 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 7)

				if (7 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 7)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1106102007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106102007
		arg_29_1.duration_ = 6.93

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1106102008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = arg_29_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) then
				if arg_29_1.var_.characterEffect1061ui_story and not isNil(arg_29_1.actors_["1061ui_story"]) then
					arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) and arg_29_1.var_.characterEffect1061ui_story then
				arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action423")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_2 = 0
			local var_32_3 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(1106102007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 33)

				if (33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 33)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102007", "story_v_side_new_1106102.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102007", "story_v_side_new_1106102.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_new_1106102", "1106102007", "story_v_side_new_1106102.awb")

						arg_29_1:RecordAudio("1106102007", var_32_9)
						arg_29_1:RecordAudio("1106102007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102007", "story_v_side_new_1106102.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102007", "story_v_side_new_1106102.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1106102008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106102008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106102009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1061ui_story"]) and arg_33_1.var_.characterEffect1061ui_story == nil then
				arg_33_1.var_.characterEffect1061ui_story = arg_33_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1061ui_story"]) then
				if arg_33_1.var_.characterEffect1061ui_story and not isNil(arg_33_1.actors_["1061ui_story"]) then
					arg_33_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1061ui_story"]) and arg_33_1.var_.characterEffect1061ui_story then
				arg_33_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1106102008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 22 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 22)

				if (22 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 22)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1106102009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106102009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1106102010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.875

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1106102009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 35 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 35)

				if (35 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 35)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1106102010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106102010
		arg_41_1.duration_ = 9.33

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1106102011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061ui_story = arg_41_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).z)
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles = arg_41_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).z)
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles = arg_41_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_44_1 = 0
			local var_44_2 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(1106102010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 30 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 30)

				if (30 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 30)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102010", "story_v_side_new_1106102.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102010", "story_v_side_new_1106102.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_new_1106102", "1106102010", "story_v_side_new_1106102.awb")

						arg_41_1:RecordAudio("1106102010", var_44_8)
						arg_41_1:RecordAudio("1106102010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102010", "story_v_side_new_1106102.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102010", "story_v_side_new_1106102.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play1106102011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106102011
		arg_45_1.duration_ = 7.03

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1106102012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.8

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(1106102011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 32 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 32)

				if (32 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 32)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102011", "story_v_side_new_1106102.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102011", "story_v_side_new_1106102.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_new_1106102", "1106102011", "story_v_side_new_1106102.awb")

						arg_45_1:RecordAudio("1106102011", var_48_6)
						arg_45_1:RecordAudio("1106102011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102011", "story_v_side_new_1106102.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102011", "story_v_side_new_1106102.awb")
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
	Play1106102012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106102012
		arg_49_1.duration_ = 6.93

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1106102013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(1106102012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 28 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 28)

				if (28 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 28)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102012", "story_v_side_new_1106102.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102012", "story_v_side_new_1106102.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_side_new_1106102", "1106102012", "story_v_side_new_1106102.awb")

						arg_49_1:RecordAudio("1106102012", var_52_6)
						arg_49_1:RecordAudio("1106102012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102012", "story_v_side_new_1106102.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102012", "story_v_side_new_1106102.awb")
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
	Play1106102013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106102013
		arg_53_1.duration_ = 13.97

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1106102014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.2

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(1106102013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 48 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 48)

				if (48 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 48)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102013", "story_v_side_new_1106102.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102013", "story_v_side_new_1106102.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_side_new_1106102", "1106102013", "story_v_side_new_1106102.awb")

						arg_53_1:RecordAudio("1106102013", var_56_6)
						arg_53_1:RecordAudio("1106102013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102013", "story_v_side_new_1106102.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102013", "story_v_side_new_1106102.awb")
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
	Play1106102014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106102014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1106102015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.675

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(1106102014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 27 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 27)

				if (27 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 27)) > 0 and var_60_0 < var_60_3 then
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
	Play1106102015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106102015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1106102016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0.1 < arg_61_1.time_ and arg_61_1.time_ <= 0.1 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_bell", "")
			end

			local var_64_1 = 0
			local var_64_2 = 1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1106102015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 40 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 40)

				if (40 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 40)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1106102016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106102016
		arg_65_1.duration_ = 7.1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1106102017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_clap_wood", "")
			end

			local var_68_1 = 0
			local var_68_2 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(1106102016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 24 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 24)

				if (24 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 24)) > 0 and var_68_2 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102016", "story_v_side_new_1106102.awb") ~= 0 then
					local var_68_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102016", "story_v_side_new_1106102.awb") / 1000

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_side_new_1106102", "1106102016", "story_v_side_new_1106102.awb")

						arg_65_1:RecordAudio("1106102016", var_68_8)
						arg_65_1:RecordAudio("1106102016", var_68_8)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102016", "story_v_side_new_1106102.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102016", "story_v_side_new_1106102.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_9 and arg_65_1.time_ < var_68_1 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1106102017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106102017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106102018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.725

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1106102017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 29 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 29)

				if (29 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 29)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1106102018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106102018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1106102019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1106102018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 19 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 19)

				if (19 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 19)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1106102019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106102019
		arg_77_1.duration_ = 2

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106102020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061ui_story = arg_77_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1061ui_story"].transform.position).z)
				arg_77_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1061ui_story"].transform.localEulerAngles = arg_77_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_77_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1061ui_story"].transform.position).z)
				arg_77_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1061ui_story"].transform.localEulerAngles = arg_77_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1061ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1061ui_story == nil then
				arg_77_1.var_.characterEffect1061ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1061ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1061ui_story then
				arg_77_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_80_4 = 0
			local var_80_5 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(1106102019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 4 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 4)

				if (4 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 4)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102019", "story_v_side_new_1106102.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102019", "story_v_side_new_1106102.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_new_1106102", "1106102019", "story_v_side_new_1106102.awb")

						arg_77_1:RecordAudio("1106102019", var_80_11)
						arg_77_1:RecordAudio("1106102019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102019", "story_v_side_new_1106102.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102019", "story_v_side_new_1106102.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1106102020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106102020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1106102021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1061ui_story = arg_81_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1061ui_story"].transform.position).z)
				arg_81_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1061ui_story"].transform.localEulerAngles = arg_81_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1061ui_story"].transform.position).z)
				arg_81_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1061ui_story"].transform.localEulerAngles = arg_81_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1061ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1061ui_story == nil then
				arg_81_1.var_.characterEffect1061ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1061ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1061ui_story then
				arg_81_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0
			local var_84_4 = 1.35

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1106102020).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 54 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 54)

				if (54 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 54)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1106102021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106102021
		arg_85_1.duration_ = 7.2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1106102022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_plate", "")
			end

			local var_88_1 = 0
			local var_88_2 = 1.075

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1352].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(1106102021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 41 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 41)

				if (41 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 41)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102021", "story_v_side_new_1106102.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102021", "story_v_side_new_1106102.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_side_new_1106102", "1106102021", "story_v_side_new_1106102.awb")

						arg_85_1:RecordAudio("1106102021", var_88_8)
						arg_85_1:RecordAudio("1106102021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102021", "story_v_side_new_1106102.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102021", "story_v_side_new_1106102.awb")
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
	Play1106102022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106102022
		arg_89_1.duration_ = 1

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"

			SetActive(arg_89_1.choicesGo_, true)

			for iter_90_0, iter_90_1 in ipairs(arg_89_1.choices_) do
				SetActive(iter_90_1.go, iter_90_0 <= 1)
			end

			arg_89_1.choices_[1].txt.text = arg_89_1:FormatText(StoryChoiceCfg[1389].name)
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1106102023(arg_89_1)
			end

			arg_89_1:RecordChoiceLog(1106102022, 1389)
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= 0 + 0.6 and arg_89_1.time_ < 0 + 0.6 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1106102023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1106102023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1106102024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.825

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1106102023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 33 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 33)

				if (33 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 33)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1106102024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1106102024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1106102025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.275

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1106102024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 11 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 11)

				if (11 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 11)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1106102025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1106102025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1106102026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
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

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1106102025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 24 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 24)

				if (24 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 24)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1106102026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1106102026
		arg_105_1.duration_ = 5.3

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1106102027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1061ui_story = arg_105_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1061ui_story"].transform.position).z)
				arg_105_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1061ui_story"].transform.localEulerAngles = arg_105_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_105_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1061ui_story"].transform.position).z)
				arg_105_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1061ui_story"].transform.localEulerAngles = arg_105_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1061ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1061ui_story == nil then
				arg_105_1.var_.characterEffect1061ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1061ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1061ui_story then
				arg_105_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(1106102026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 14 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 14)

				if (14 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 14)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102026", "story_v_side_new_1106102.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102026", "story_v_side_new_1106102.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_side_new_1106102", "1106102026", "story_v_side_new_1106102.awb")

						arg_105_1:RecordAudio("1106102026", var_108_11)
						arg_105_1:RecordAudio("1106102026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102026", "story_v_side_new_1106102.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102026", "story_v_side_new_1106102.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play1106102027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1106102027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1106102028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061ui_story = arg_109_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1061ui_story"].transform.position).z)
				arg_109_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1061ui_story"].transform.localEulerAngles = arg_109_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1061ui_story"].transform.position).z)
				arg_109_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1061ui_story"].transform.localEulerAngles = arg_109_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1061ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1061ui_story == nil then
				arg_109_1.var_.characterEffect1061ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1061ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1061ui_story then
				arg_109_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_112_3 = 0
			local var_112_4 = 0.9

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1106102027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 36 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 36)

				if (36 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 36)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play1106102028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1106102028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1106102029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.225

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1106102028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 9 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 9)

				if (9 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 9)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1106102029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1106102029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1106102030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.8

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1106102029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 32 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 32)

				if (32 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 32)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1106102030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1106102030
		arg_121_1.duration_ = 2

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1106102031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1061ui_story"]) and arg_121_1.var_.characterEffect1061ui_story == nil then
				arg_121_1.var_.characterEffect1061ui_story = arg_121_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1061ui_story"]) then
				if arg_121_1.var_.characterEffect1061ui_story and not isNil(arg_121_1.actors_["1061ui_story"]) then
					arg_121_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1061ui_story"]) and arg_121_1.var_.characterEffect1061ui_story then
				arg_121_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action447")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_124_2 = arg_121_1.actors_["1061ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1061ui_story = var_124_2.localPosition
			end

			local var_124_3 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_121_1.time_ - 0) / var_124_3)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -1.18, -6.15)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			local var_124_4 = 0
			local var_124_5 = 0.125

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
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

				local var_124_6 = arg_121_1:GetWordFromCfg(1106102030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 5 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 5)

				if (5 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 5)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102030", "story_v_side_new_1106102.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102030", "story_v_side_new_1106102.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_new_1106102", "1106102030", "story_v_side_new_1106102.awb")

						arg_121_1:RecordAudio("1106102030", var_124_11)
						arg_121_1:RecordAudio("1106102030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102030", "story_v_side_new_1106102.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102030", "story_v_side_new_1106102.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play1106102031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1106102031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1106102032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1061ui_story"]) and arg_125_1.var_.characterEffect1061ui_story == nil then
				arg_125_1.var_.characterEffect1061ui_story = arg_125_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1061ui_story"]) then
				if arg_125_1.var_.characterEffect1061ui_story and not isNil(arg_125_1.actors_["1061ui_story"]) then
					arg_125_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1061ui_story"]) and arg_125_1.var_.characterEffect1061ui_story then
				arg_125_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.275

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1106102031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 11 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 11)

				if (11 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 11)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1106102032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1106102032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1106102033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1106102032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 14)

				if (14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 14)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1106102033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1106102033
		arg_133_1.duration_ = 5.53

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1106102034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1061ui_story"]) and arg_133_1.var_.characterEffect1061ui_story == nil then
				arg_133_1.var_.characterEffect1061ui_story = arg_133_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1061ui_story"]) then
				if arg_133_1.var_.characterEffect1061ui_story and not isNil(arg_133_1.actors_["1061ui_story"]) then
					arg_133_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1061ui_story"]) and arg_133_1.var_.characterEffect1061ui_story then
				arg_133_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_2 = 0
			local var_136_3 = 0.625

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
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

				local var_136_4 = arg_133_1:GetWordFromCfg(1106102033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 25 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 25)

				if (25 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 25)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102033", "story_v_side_new_1106102.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102033", "story_v_side_new_1106102.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_side_new_1106102", "1106102033", "story_v_side_new_1106102.awb")

						arg_133_1:RecordAudio("1106102033", var_136_9)
						arg_133_1:RecordAudio("1106102033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102033", "story_v_side_new_1106102.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102033", "story_v_side_new_1106102.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1106102034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1106102034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1106102035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1061ui_story = arg_137_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1061ui_story"].transform.position).z)
				arg_137_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1061ui_story"].transform.localEulerAngles = arg_137_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1061ui_story"].transform.position).z)
				arg_137_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1061ui_story"].transform.localEulerAngles = arg_137_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1061ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1061ui_story == nil then
				arg_137_1.var_.characterEffect1061ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1061ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_2)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1061ui_story then
				arg_137_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_140_3 = 0
			local var_140_4 = 1.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1106102034).content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 55 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 55)

				if (55 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 55)) > 0 and var_140_4 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_3 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_3
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_4, arg_137_1.talkMaxDuration)

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_3) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_3 + var_140_8 and arg_137_1.time_ < var_140_3 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play1106102035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1106102035
		arg_141_1.duration_ = 6.6

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1106102036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_0 = 1.9

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				local var_144_1 = Color.New(0, 0, 0)

				var_144_1.a = Mathf.Lerp(1, 0, (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.mask_.color = var_144_1
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				local var_144_2 = Color.New(0, 0, 0)

				arg_141_1.mask_.enabled = false
				var_144_2.a = 0
				arg_141_1.mask_.color = var_144_2
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_3 = 1.6
			local var_144_4 = 0.3

			if 1.6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_5 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_5:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_6 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1106102035).content)

				arg_141_1.text_.text = var_144_6

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_8 = 12 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_6) / 12)

				if (12 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_6) / 12)) > 0 and var_144_4 < var_144_8 then
					arg_141_1.talkMaxDuration = var_144_8
					var_144_3 = var_144_3 + 0.3

					if var_144_8 + var_144_3 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_3
					end
				end

				arg_141_1.text_.text = var_144_6
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_9 = var_144_3 + 0.3
			local var_144_10 = math.max(var_144_4, arg_141_1.talkMaxDuration)

			if var_144_3 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_9) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1106102036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106102036
		arg_147_1.duration_ = 3.1

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106102037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061ui_story = arg_147_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1061ui_story"].transform.position).z)
				arg_147_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1061ui_story"].transform.localEulerAngles = arg_147_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_147_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1061ui_story"].transform.position).z)
				arg_147_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1061ui_story"].transform.localEulerAngles = arg_147_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1061ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1061ui_story == nil then
				arg_147_1.var_.characterEffect1061ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1061ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1061ui_story then
				arg_147_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_4 = 0
			local var_150_5 = 0.375

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(1106102036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 15 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 15)

				if (15 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 15)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102036", "story_v_side_new_1106102.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102036", "story_v_side_new_1106102.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_side_new_1106102", "1106102036", "story_v_side_new_1106102.awb")

						arg_147_1:RecordAudio("1106102036", var_150_11)
						arg_147_1:RecordAudio("1106102036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102036", "story_v_side_new_1106102.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102036", "story_v_side_new_1106102.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1106102037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1106102037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1106102038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1061ui_story"]) and arg_151_1.var_.characterEffect1061ui_story == nil then
				arg_151_1.var_.characterEffect1061ui_story = arg_151_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1061ui_story"]) then
				if arg_151_1.var_.characterEffect1061ui_story and not isNil(arg_151_1.actors_["1061ui_story"]) then
					arg_151_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1061ui_story"]) and arg_151_1.var_.characterEffect1061ui_story then
				arg_151_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.775

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1106102037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 31 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 31)

				if (31 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 31)) > 0 and var_154_2 < var_154_5 then
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
	Play1106102038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1106102038
		arg_155_1.duration_ = 2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1106102039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1061ui_story"]) and arg_155_1.var_.characterEffect1061ui_story == nil then
				arg_155_1.var_.characterEffect1061ui_story = arg_155_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1061ui_story"]) then
				if arg_155_1.var_.characterEffect1061ui_story and not isNil(arg_155_1.actors_["1061ui_story"]) then
					arg_155_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1061ui_story"]) and arg_155_1.var_.characterEffect1061ui_story then
				arg_155_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action425")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_158_2 = 0
			local var_158_3 = 0.25

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(1106102038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 10 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 10)

				if (10 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 10)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102038", "story_v_side_new_1106102.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102038", "story_v_side_new_1106102.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_side_new_1106102", "1106102038", "story_v_side_new_1106102.awb")

						arg_155_1:RecordAudio("1106102038", var_158_9)
						arg_155_1:RecordAudio("1106102038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102038", "story_v_side_new_1106102.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102038", "story_v_side_new_1106102.awb")
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
	Play1106102039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106102039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106102040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1061ui_story"]) and arg_159_1.var_.characterEffect1061ui_story == nil then
				arg_159_1.var_.characterEffect1061ui_story = arg_159_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1061ui_story"]) then
				if arg_159_1.var_.characterEffect1061ui_story and not isNil(arg_159_1.actors_["1061ui_story"]) then
					arg_159_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1061ui_story"]) and arg_159_1.var_.characterEffect1061ui_story then
				arg_159_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.75

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1106102039).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 30 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 30)

				if (30 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 30)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1106102040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106102040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106102041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1061ui_story = arg_163_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1061ui_story"].transform.position).z)
				arg_163_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1061ui_story"].transform.localEulerAngles = arg_163_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1061ui_story"].transform.position).z)
				arg_163_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1061ui_story"].transform.localEulerAngles = arg_163_1.actors_["1061ui_story"].transform.localEulerAngles
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

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1106102040).content)

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

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play1106102041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106102041
		arg_167_1.duration_ = 2

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106102042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1061ui_story = arg_167_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1061ui_story"].transform.position).z)
				arg_167_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1061ui_story"].transform.localEulerAngles = arg_167_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_167_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1061ui_story"].transform.position).z)
				arg_167_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1061ui_story"].transform.localEulerAngles = arg_167_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1061ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1061ui_story == nil then
				arg_167_1.var_.characterEffect1061ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1061ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1061ui_story then
				arg_167_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_170_4 = 0
			local var_170_5 = 0.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(1106102041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 4 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 4)

				if (4 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 4)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102041", "story_v_side_new_1106102.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102041", "story_v_side_new_1106102.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_side_new_1106102", "1106102041", "story_v_side_new_1106102.awb")

						arg_167_1:RecordAudio("1106102041", var_170_11)
						arg_167_1:RecordAudio("1106102041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102041", "story_v_side_new_1106102.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102041", "story_v_side_new_1106102.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play1106102042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106102042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1106102043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1061ui_story"]) and arg_171_1.var_.characterEffect1061ui_story == nil then
				arg_171_1.var_.characterEffect1061ui_story = arg_171_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1061ui_story"]) then
				if arg_171_1.var_.characterEffect1061ui_story and not isNil(arg_171_1.actors_["1061ui_story"]) then
					arg_171_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1061ui_story"]) and arg_171_1.var_.characterEffect1061ui_story then
				arg_171_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.425

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1106102042).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 17 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 17)

				if (17 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 17)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1106102043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106102043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106102044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.575

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
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

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1106102043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 23)

				if (23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 23)) > 0 and var_178_0 < var_178_3 then
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
	Play1106102044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106102044
		arg_179_1.duration_ = 5.63

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1106102045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1061ui_story"]) and arg_179_1.var_.characterEffect1061ui_story == nil then
				arg_179_1.var_.characterEffect1061ui_story = arg_179_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1061ui_story"]) then
				if arg_179_1.var_.characterEffect1061ui_story and not isNil(arg_179_1.actors_["1061ui_story"]) then
					arg_179_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1061ui_story"]) and arg_179_1.var_.characterEffect1061ui_story then
				arg_179_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_182_2 = 0
			local var_182_3 = 0.525

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(1106102044)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 21 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 21)

				if (21 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 21)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102044", "story_v_side_new_1106102.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102044", "story_v_side_new_1106102.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_side_new_1106102", "1106102044", "story_v_side_new_1106102.awb")

						arg_179_1:RecordAudio("1106102044", var_182_9)
						arg_179_1:RecordAudio("1106102044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102044", "story_v_side_new_1106102.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102044", "story_v_side_new_1106102.awb")
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
	Play1106102045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106102045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1106102046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1061ui_story"]) and arg_183_1.var_.characterEffect1061ui_story == nil then
				arg_183_1.var_.characterEffect1061ui_story = arg_183_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1061ui_story"]) then
				if arg_183_1.var_.characterEffect1061ui_story and not isNil(arg_183_1.actors_["1061ui_story"]) then
					arg_183_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1061ui_story"]) and arg_183_1.var_.characterEffect1061ui_story then
				arg_183_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.525

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1106102045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 21 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 21)

				if (21 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 21)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1106102046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106102046
		arg_187_1.duration_ = 6.37

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106102047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1061ui_story"]) and arg_187_1.var_.characterEffect1061ui_story == nil then
				arg_187_1.var_.characterEffect1061ui_story = arg_187_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1061ui_story"]) then
				if arg_187_1.var_.characterEffect1061ui_story and not isNil(arg_187_1.actors_["1061ui_story"]) then
					arg_187_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1061ui_story"]) and arg_187_1.var_.characterEffect1061ui_story then
				arg_187_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_190_2 = 0
			local var_190_3 = 0.75

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(1106102046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 30 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 30)

				if (30 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 30)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102046", "story_v_side_new_1106102.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102046", "story_v_side_new_1106102.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_side_new_1106102", "1106102046", "story_v_side_new_1106102.awb")

						arg_187_1:RecordAudio("1106102046", var_190_9)
						arg_187_1:RecordAudio("1106102046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102046", "story_v_side_new_1106102.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102046", "story_v_side_new_1106102.awb")
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
	Play1106102047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106102047
		arg_191_1.duration_ = 7.03

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1106102048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_0 = 0
			local var_194_1 = 0.8

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(1106102047)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 32 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 32)

				if (32 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 32)) > 0 and var_194_1 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102047", "story_v_side_new_1106102.awb") ~= 0 then
					local var_194_6 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102047", "story_v_side_new_1106102.awb") / 1000

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end

					if var_194_2.prefab_name ~= "" and arg_191_1.actors_[var_194_2.prefab_name] ~= nil then
						local var_194_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_2.prefab_name].transform, "story_v_side_new_1106102", "1106102047", "story_v_side_new_1106102.awb")

						arg_191_1:RecordAudio("1106102047", var_194_7)
						arg_191_1:RecordAudio("1106102047", var_194_7)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102047", "story_v_side_new_1106102.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102047", "story_v_side_new_1106102.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1106102048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1106102048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1106102049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1061ui_story"]) and arg_195_1.var_.characterEffect1061ui_story == nil then
				arg_195_1.var_.characterEffect1061ui_story = arg_195_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1061ui_story"]) then
				if arg_195_1.var_.characterEffect1061ui_story and not isNil(arg_195_1.actors_["1061ui_story"]) then
					arg_195_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1061ui_story"]) and arg_195_1.var_.characterEffect1061ui_story then
				arg_195_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1106102048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 13 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 13)

				if (13 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 13)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1106102049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1106102049
		arg_199_1.duration_ = 9.63

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1106102050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1061ui_story"]) and arg_199_1.var_.characterEffect1061ui_story == nil then
				arg_199_1.var_.characterEffect1061ui_story = arg_199_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1061ui_story"]) then
				if arg_199_1.var_.characterEffect1061ui_story and not isNil(arg_199_1.actors_["1061ui_story"]) then
					arg_199_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1061ui_story"]) and arg_199_1.var_.characterEffect1061ui_story then
				arg_199_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_202_2 = 0
			local var_202_3 = 1.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
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

				local var_202_4 = arg_199_1:GetWordFromCfg(1106102049)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 46 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 46)

				if (46 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 46)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102049", "story_v_side_new_1106102.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102049", "story_v_side_new_1106102.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_side_new_1106102", "1106102049", "story_v_side_new_1106102.awb")

						arg_199_1:RecordAudio("1106102049", var_202_9)
						arg_199_1:RecordAudio("1106102049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102049", "story_v_side_new_1106102.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102049", "story_v_side_new_1106102.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1106102050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1106102050
		arg_203_1.duration_ = 7.1

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1106102051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_206_0 = 0
			local var_206_1 = 0.925

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(1106102050)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 37 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 37)

				if (37 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 37)) > 0 and var_206_1 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102050", "story_v_side_new_1106102.awb") ~= 0 then
					local var_206_6 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102050", "story_v_side_new_1106102.awb") / 1000

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end

					if var_206_2.prefab_name ~= "" and arg_203_1.actors_[var_206_2.prefab_name] ~= nil then
						local var_206_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_2.prefab_name].transform, "story_v_side_new_1106102", "1106102050", "story_v_side_new_1106102.awb")

						arg_203_1:RecordAudio("1106102050", var_206_7)
						arg_203_1:RecordAudio("1106102050", var_206_7)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102050", "story_v_side_new_1106102.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102050", "story_v_side_new_1106102.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1106102051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1106102051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1106102052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1061ui_story"]) and arg_207_1.var_.characterEffect1061ui_story == nil then
				arg_207_1.var_.characterEffect1061ui_story = arg_207_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1061ui_story"]) then
				if arg_207_1.var_.characterEffect1061ui_story and not isNil(arg_207_1.actors_["1061ui_story"]) then
					arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1061ui_story"]) and arg_207_1.var_.characterEffect1061ui_story then
				arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1106102051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 12 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 12)

				if (12 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 12)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1106102052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1106102052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1106102053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061ui_story = arg_211_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1061ui_story"].transform.position).z)
				arg_211_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1061ui_story"].transform.localEulerAngles = arg_211_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1061ui_story"].transform.position).z)
				arg_211_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1061ui_story"].transform.localEulerAngles = arg_211_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_214_1 = 0
			local var_214_2 = 0.575

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

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1106102052).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 23 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 23)

				if (23 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 23)) > 0 and var_214_2 < var_214_5 then
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
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1106102053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1106102053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1106102054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.225

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1106102053).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 9 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 9)

				if (9 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 9)) > 0 and var_218_0 < var_218_3 then
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
	Play1106102054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1106102054
		arg_219_1.duration_ = 2

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1106102055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1061ui_story = arg_219_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).z)
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles = arg_219_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_219_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).z)
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles = arg_219_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1061ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1061ui_story == nil then
				arg_219_1.var_.characterEffect1061ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1061ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1061ui_story then
				arg_219_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_4 = 0
			local var_222_5 = 0.15

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(1106102054)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 6 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 6)

				if (6 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 6)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102054", "story_v_side_new_1106102.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102054", "story_v_side_new_1106102.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_side_new_1106102", "1106102054", "story_v_side_new_1106102.awb")

						arg_219_1:RecordAudio("1106102054", var_222_11)
						arg_219_1:RecordAudio("1106102054", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102054", "story_v_side_new_1106102.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102054", "story_v_side_new_1106102.awb")
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
				actorName = "1061ui_story",
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
	Play1106102055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1106102055
		arg_223_1.duration_ = 5.93

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1106102056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:GetWordFromCfg(1106102055)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 27 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 27)

				if (27 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 27)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102055", "story_v_side_new_1106102.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102055", "story_v_side_new_1106102.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_side_new_1106102", "1106102055", "story_v_side_new_1106102.awb")

						arg_223_1:RecordAudio("1106102055", var_226_6)
						arg_223_1:RecordAudio("1106102055", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102055", "story_v_side_new_1106102.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102055", "story_v_side_new_1106102.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1106102056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1106102056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1106102057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1061ui_story = arg_227_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1061ui_story"].transform.position).z)
				arg_227_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1061ui_story"].transform.localEulerAngles = arg_227_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1061ui_story"].transform.position).z)
				arg_227_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1061ui_story"].transform.localEulerAngles = arg_227_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1061ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1061ui_story == nil then
				arg_227_1.var_.characterEffect1061ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1061ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_2)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1061ui_story then
				arg_227_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_230_3 = 0
			local var_230_4 = 1.075

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

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1106102056).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 43 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 43)

				if (43 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 43)) > 0 and var_230_4 < var_230_7 then
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
				actorName = "1061ui_story",
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
	Play1106102057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1106102057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1106102058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.95

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1106102057).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 38 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 38)

				if (38 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 38)) > 0 and var_234_0 < var_234_3 then
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
	Play1106102058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1106102058
		arg_235_1.duration_ = 6.03

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1106102059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1061ui_story = arg_235_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1061ui_story"].transform.position).z)
				arg_235_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1061ui_story"].transform.localEulerAngles = arg_235_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_235_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1061ui_story"].transform.position).z)
				arg_235_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1061ui_story"].transform.localEulerAngles = arg_235_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1061ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1061ui_story == nil then
				arg_235_1.var_.characterEffect1061ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1061ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1061ui_story then
				arg_235_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_238_4 = 0
			local var_238_5 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(1106102058)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 24 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 24)

				if (24 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 24)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102058", "story_v_side_new_1106102.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102058", "story_v_side_new_1106102.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_side_new_1106102", "1106102058", "story_v_side_new_1106102.awb")

						arg_235_1:RecordAudio("1106102058", var_238_11)
						arg_235_1:RecordAudio("1106102058", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102058", "story_v_side_new_1106102.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102058", "story_v_side_new_1106102.awb")
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

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play1106102059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1106102059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1106102060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1061ui_story"]) and arg_239_1.var_.characterEffect1061ui_story == nil then
				arg_239_1.var_.characterEffect1061ui_story = arg_239_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1061ui_story"]) then
				if arg_239_1.var_.characterEffect1061ui_story and not isNil(arg_239_1.actors_["1061ui_story"]) then
					arg_239_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1061ui_story"]) and arg_239_1.var_.characterEffect1061ui_story then
				arg_239_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.35

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(1106102059).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 14 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 14)

				if (14 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 14)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1106102060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1106102060
		arg_243_1.duration_ = 2

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1106102061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1061ui_story"]) and arg_243_1.var_.characterEffect1061ui_story == nil then
				arg_243_1.var_.characterEffect1061ui_story = arg_243_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1061ui_story"]) then
				if arg_243_1.var_.characterEffect1061ui_story and not isNil(arg_243_1.actors_["1061ui_story"]) then
					arg_243_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1061ui_story"]) and arg_243_1.var_.characterEffect1061ui_story then
				arg_243_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_246_2 = 0
			local var_246_3 = 0.125

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(1106102060)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 5 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 5)

				if (5 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 5)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102060", "story_v_side_new_1106102.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102060", "story_v_side_new_1106102.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_side_new_1106102", "1106102060", "story_v_side_new_1106102.awb")

						arg_243_1:RecordAudio("1106102060", var_246_9)
						arg_243_1:RecordAudio("1106102060", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102060", "story_v_side_new_1106102.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102060", "story_v_side_new_1106102.awb")
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

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1106102061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1106102061
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1106102062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.bgs_.H03 == nil then
				local var_250_0 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H03")
				var_250_0.name = "H03"
				var_250_0.transform.parent = arg_247_1.stage_.transform
				var_250_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_.H03 = var_250_0
			end

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				local var_250_1 = arg_247_1.bgs_.H03

				arg_247_1.bgs_.H03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_2 = var_250_1:GetComponent("SpriteRenderer")

				if var_250_2 and var_250_2.sprite then
					local var_250_3 = 2 * (var_250_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_1.transform.localScale = Vector3.New(var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "H03" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_4 = 3.999999999999

			if 3.999999999999 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			if arg_247_1.time_ >= var_250_4 + 0.3 and arg_247_1.time_ < var_250_4 + 0.3 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			local var_250_5 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_6 = 2

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 then
				local var_250_7 = Color.New(0, 0, 0)

				var_250_7.a = Mathf.Lerp(0, 1, (arg_247_1.time_ - var_250_5) / var_250_6)
				arg_247_1.mask_.color = var_250_7
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 then
				local var_250_8 = Color.New(0, 0, 0)

				var_250_8.a = 1
				arg_247_1.mask_.color = var_250_8
			end

			local var_250_9 = 2

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_10 = 2

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_10 then
				local var_250_11 = Color.New(0, 0, 0)

				var_250_11.a = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_9) / var_250_10)
				arg_247_1.mask_.color = var_250_11
			end

			if arg_247_1.time_ >= var_250_9 + var_250_10 and arg_247_1.time_ < var_250_9 + var_250_10 + arg_250_0 then
				local var_250_12 = Color.New(0, 0, 0)

				arg_247_1.mask_.enabled = false
				var_250_12.a = 0
				arg_247_1.mask_.color = var_250_12
			end

			local var_250_13 = arg_247_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_247_1.time_ and arg_247_1.time_ <= 1.96599999815226 + arg_250_0 then
				arg_247_1.var_.moveOldPos1061ui_story = var_250_13.localPosition
			end

			local var_250_14 = 0.001

			if 1.96599999815226 <= arg_247_1.time_ and arg_247_1.time_ < 1.96599999815226 + var_250_14 then
				var_250_13.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 1.96599999815226) / var_250_14)
				var_250_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_13.position).x, (manager.ui.mainCamera.transform.position - var_250_13.position).y, (manager.ui.mainCamera.transform.position - var_250_13.position).z)
				var_250_13.localEulerAngles.z = 0
				var_250_13.localEulerAngles.x = 0
				var_250_13.localEulerAngles = var_250_13.localEulerAngles
			end

			if arg_247_1.time_ >= 1.96599999815226 + var_250_14 and arg_247_1.time_ < 1.96599999815226 + var_250_14 + arg_250_0 then
				var_250_13.localPosition = Vector3.New(0, 100, 0)
				var_250_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_13.position).x, (manager.ui.mainCamera.transform.position - var_250_13.position).y, (manager.ui.mainCamera.transform.position - var_250_13.position).z)
				var_250_13.localEulerAngles.z = 0
				var_250_13.localEulerAngles.x = 0
				var_250_13.localEulerAngles = var_250_13.localEulerAngles
			end

			local var_250_15 = arg_247_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_247_1.time_ and arg_247_1.time_ <= 1.96599999815226 + arg_250_0 and not isNil(var_250_15) and arg_247_1.var_.characterEffect1061ui_story == nil then
				arg_247_1.var_.characterEffect1061ui_story = var_250_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_16 = 0.034000001847744

			if 1.96599999815226 <= arg_247_1.time_ and arg_247_1.time_ < 1.96599999815226 + var_250_16 and not isNil(var_250_15) then
				if arg_247_1.var_.characterEffect1061ui_story and not isNil(var_250_15) then
					arg_247_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 1.96599999815226) / var_250_16)
				end
			end

			if arg_247_1.time_ >= 1.96599999815226 + var_250_16 and arg_247_1.time_ < 1.96599999815226 + var_250_16 + arg_250_0 and not isNil(var_250_15) and arg_247_1.var_.characterEffect1061ui_story then
				arg_247_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 1.53333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.53333333333333 + arg_250_0 then
				arg_247_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_250_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_20 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_20

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_20
						arg_247_1.bgmTxt2_.text = var_250_20
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_247_1.time_ and arg_247_1.time_ <= 0.6 + arg_250_0 then
				arg_247_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_250_23 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if "" ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_23 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_23

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_23
						arg_247_1.bgmTxt2_.text = var_250_23
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.0666666666666667 < arg_247_1.time_ and arg_247_1.time_ <= 0.0666666666666667 + arg_250_0 then
				arg_247_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_25 = 3.999999999999
			local var_250_26 = 1.275

			if 3.999999999999 < arg_247_1.time_ and arg_247_1.time_ <= var_250_25 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_27 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_27:setOnUpdate(LuaHelper.FloatAction(function(arg_253_0)
					arg_247_1.dialogCg_.alpha = arg_253_0
				end))
				var_250_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_28 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1106102061).content)

				arg_247_1.text_.text = var_250_28

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_30 = 51 <= 0 and var_250_26 or var_250_26 * (utf8.len(var_250_28) / 51)

				if (51 <= 0 and var_250_26 or var_250_26 * (utf8.len(var_250_28) / 51)) > 0 and var_250_26 < var_250_30 then
					arg_247_1.talkMaxDuration = var_250_30
					var_250_25 = var_250_25 + 0.3

					if var_250_30 + var_250_25 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_25
					end
				end

				arg_247_1.text_.text = var_250_28
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_31 = var_250_25 + 0.3
			local var_250_32 = math.max(var_250_26, arg_247_1.talkMaxDuration)

			if var_250_25 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_31 + var_250_32 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_31) / var_250_32

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_31 + var_250_32 and arg_247_1.time_ < var_250_31 + var_250_32 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play1106102062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1106102062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1106102063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1.125

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1106102062).content)

				arg_255_1.text_.text = var_258_1

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_3 = 45 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 45)

				if (45 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 45)) > 0 and var_258_0 < var_258_3 then
					arg_255_1.talkMaxDuration = var_258_3

					if var_258_3 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_3 + 0
					end
				end

				arg_255_1.text_.text = var_258_1
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_4 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_4

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1106102063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1106102063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1106102064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.2

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1106102063).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 8 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 8)

				if (8 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 8)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1106102064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1106102064
		arg_263_1.duration_ = 3.93

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1106102065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1061ui_story = arg_263_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1061ui_story"].transform.position).z)
				arg_263_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1061ui_story"].transform.localEulerAngles = arg_263_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_263_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1061ui_story"].transform.position).z)
				arg_263_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1061ui_story"].transform.localEulerAngles = arg_263_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1061ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1061ui_story == nil then
				arg_263_1.var_.characterEffect1061ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1061ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1061ui_story then
				arg_263_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_266_4 = 0
			local var_266_5 = 0.35

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
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

				local var_266_6 = arg_263_1:GetWordFromCfg(1106102064)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 14 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 14)

				if (14 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 14)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102064", "story_v_side_new_1106102.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102064", "story_v_side_new_1106102.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_side_new_1106102", "1106102064", "story_v_side_new_1106102.awb")

						arg_263_1:RecordAudio("1106102064", var_266_11)
						arg_263_1:RecordAudio("1106102064", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102064", "story_v_side_new_1106102.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102064", "story_v_side_new_1106102.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play1106102065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1106102065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1106102066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1061ui_story"]) and arg_267_1.var_.characterEffect1061ui_story == nil then
				arg_267_1.var_.characterEffect1061ui_story = arg_267_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1061ui_story"]) then
				if arg_267_1.var_.characterEffect1061ui_story and not isNil(arg_267_1.actors_["1061ui_story"]) then
					arg_267_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1061ui_story"]) and arg_267_1.var_.characterEffect1061ui_story then
				arg_267_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.775

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1106102065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 31 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 31)

				if (31 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 31)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1106102066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1106102066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1106102067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.325

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
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

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1106102066).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 13 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 13)

				if (13 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 13)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1106102067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1106102067
		arg_275_1.duration_ = 8.9

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1106102068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1061ui_story"]) and arg_275_1.var_.characterEffect1061ui_story == nil then
				arg_275_1.var_.characterEffect1061ui_story = arg_275_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1061ui_story"]) then
				if arg_275_1.var_.characterEffect1061ui_story and not isNil(arg_275_1.actors_["1061ui_story"]) then
					arg_275_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1061ui_story"]) and arg_275_1.var_.characterEffect1061ui_story then
				arg_275_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_278_2 = 0
			local var_278_3 = 0.975

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(1106102067)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 39 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 39)

				if (39 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 39)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102067", "story_v_side_new_1106102.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102067", "story_v_side_new_1106102.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_side_new_1106102", "1106102067", "story_v_side_new_1106102.awb")

						arg_275_1:RecordAudio("1106102067", var_278_9)
						arg_275_1:RecordAudio("1106102067", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102067", "story_v_side_new_1106102.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102067", "story_v_side_new_1106102.awb")
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
	Play1106102068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1106102068
		arg_279_1.duration_ = 8.23

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1106102069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 1.025

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(1106102068)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 41 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 41)

				if (41 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 41)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102068", "story_v_side_new_1106102.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102068", "story_v_side_new_1106102.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_side_new_1106102", "1106102068", "story_v_side_new_1106102.awb")

						arg_279_1:RecordAudio("1106102068", var_282_6)
						arg_279_1:RecordAudio("1106102068", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102068", "story_v_side_new_1106102.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102068", "story_v_side_new_1106102.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1106102069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1106102069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1106102070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1061ui_story"]) and arg_283_1.var_.characterEffect1061ui_story == nil then
				arg_283_1.var_.characterEffect1061ui_story = arg_283_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1061ui_story"]) then
				if arg_283_1.var_.characterEffect1061ui_story and not isNil(arg_283_1.actors_["1061ui_story"]) then
					arg_283_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1061ui_story"]) and arg_283_1.var_.characterEffect1061ui_story then
				arg_283_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.275

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1106102069).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 11 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 11)

				if (11 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 11)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1106102070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1106102070
		arg_287_1.duration_ = 4.43

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1106102071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1061ui_story"]) and arg_287_1.var_.characterEffect1061ui_story == nil then
				arg_287_1.var_.characterEffect1061ui_story = arg_287_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1061ui_story"]) then
				if arg_287_1.var_.characterEffect1061ui_story and not isNil(arg_287_1.actors_["1061ui_story"]) then
					arg_287_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1061ui_story"]) and arg_287_1.var_.characterEffect1061ui_story then
				arg_287_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_290_2 = 0
			local var_290_3 = 0.575

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(1106102070)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 23 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 23)

				if (23 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 23)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102070", "story_v_side_new_1106102.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102070", "story_v_side_new_1106102.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_side_new_1106102", "1106102070", "story_v_side_new_1106102.awb")

						arg_287_1:RecordAudio("1106102070", var_290_9)
						arg_287_1:RecordAudio("1106102070", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102070", "story_v_side_new_1106102.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102070", "story_v_side_new_1106102.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1106102071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1106102071
		arg_291_1.duration_ = 7.3

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1106102072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.7

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(1106102071)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 28 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 28)

				if (28 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 28)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102071", "story_v_side_new_1106102.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102071", "story_v_side_new_1106102.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_side_new_1106102", "1106102071", "story_v_side_new_1106102.awb")

						arg_291_1:RecordAudio("1106102071", var_294_6)
						arg_291_1:RecordAudio("1106102071", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102071", "story_v_side_new_1106102.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102071", "story_v_side_new_1106102.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1106102072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1106102072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1106102073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1061ui_story"]) and arg_295_1.var_.characterEffect1061ui_story == nil then
				arg_295_1.var_.characterEffect1061ui_story = arg_295_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1061ui_story"]) then
				if arg_295_1.var_.characterEffect1061ui_story and not isNil(arg_295_1.actors_["1061ui_story"]) then
					arg_295_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1061ui_story"]) and arg_295_1.var_.characterEffect1061ui_story then
				arg_295_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.65

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1106102072).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 26 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 26)

				if (26 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 26)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1106102073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1106102073
		arg_299_1.duration_ = 10.63

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1106102074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1061ui_story"]) and arg_299_1.var_.characterEffect1061ui_story == nil then
				arg_299_1.var_.characterEffect1061ui_story = arg_299_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1061ui_story"]) then
				if arg_299_1.var_.characterEffect1061ui_story and not isNil(arg_299_1.actors_["1061ui_story"]) then
					arg_299_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1061ui_story"]) and arg_299_1.var_.characterEffect1061ui_story then
				arg_299_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_302_2 = 0
			local var_302_3 = 1.175

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:GetWordFromCfg(1106102073)
				local var_302_5 = arg_299_1:FormatText(var_302_4.content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 47 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 47)

				if (47 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 47)) > 0 and var_302_3 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102073", "story_v_side_new_1106102.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102073", "story_v_side_new_1106102.awb") / 1000

					if var_302_8 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_2
					end

					if var_302_4.prefab_name ~= "" and arg_299_1.actors_[var_302_4.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_4.prefab_name].transform, "story_v_side_new_1106102", "1106102073", "story_v_side_new_1106102.awb")

						arg_299_1:RecordAudio("1106102073", var_302_9)
						arg_299_1:RecordAudio("1106102073", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102073", "story_v_side_new_1106102.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102073", "story_v_side_new_1106102.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_10 and arg_299_1.time_ < var_302_2 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1106102074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1106102074
		arg_303_1.duration_ = 3.2

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1106102075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_306_0 = 0
			local var_306_1 = 0.325

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_2 = arg_303_1:GetWordFromCfg(1106102074)
				local var_306_3 = arg_303_1:FormatText(var_306_2.content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 13 <= 0 and var_306_1 or var_306_1 * (utf8.len(var_306_3) / 13)

				if (13 <= 0 and var_306_1 or var_306_1 * (utf8.len(var_306_3) / 13)) > 0 and var_306_1 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102074", "story_v_side_new_1106102.awb") ~= 0 then
					local var_306_6 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102074", "story_v_side_new_1106102.awb") / 1000

					if var_306_6 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_0
					end

					if var_306_2.prefab_name ~= "" and arg_303_1.actors_[var_306_2.prefab_name] ~= nil then
						local var_306_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_2.prefab_name].transform, "story_v_side_new_1106102", "1106102074", "story_v_side_new_1106102.awb")

						arg_303_1:RecordAudio("1106102074", var_306_7)
						arg_303_1:RecordAudio("1106102074", var_306_7)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102074", "story_v_side_new_1106102.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102074", "story_v_side_new_1106102.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_8 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_8 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_8

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_8 and arg_303_1.time_ < var_306_0 + var_306_8 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1106102075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1106102075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1106102076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1061ui_story"]) and arg_307_1.var_.characterEffect1061ui_story == nil then
				arg_307_1.var_.characterEffect1061ui_story = arg_307_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1061ui_story"]) then
				if arg_307_1.var_.characterEffect1061ui_story and not isNil(arg_307_1.actors_["1061ui_story"]) then
					arg_307_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1061ui_story"]) and arg_307_1.var_.characterEffect1061ui_story then
				arg_307_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.475

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1106102075).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 19 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 19)

				if (19 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 19)) > 0 and var_310_2 < var_310_5 then
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
	Play1106102076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1106102076
		arg_311_1.duration_ = 2.43

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1106102077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1061ui_story"]) and arg_311_1.var_.characterEffect1061ui_story == nil then
				arg_311_1.var_.characterEffect1061ui_story = arg_311_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1061ui_story"]) then
				if arg_311_1.var_.characterEffect1061ui_story and not isNil(arg_311_1.actors_["1061ui_story"]) then
					arg_311_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1061ui_story"]) and arg_311_1.var_.characterEffect1061ui_story then
				arg_311_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action425")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_314_2 = 0
			local var_314_3 = 0.325

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_4 = arg_311_1:GetWordFromCfg(1106102076)
				local var_314_5 = arg_311_1:FormatText(var_314_4.content)

				arg_311_1.text_.text = var_314_5

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_7 = 13 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 13)

				if (13 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 13)) > 0 and var_314_3 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_5
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102076", "story_v_side_new_1106102.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102076", "story_v_side_new_1106102.awb") / 1000

					if var_314_8 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_2
					end

					if var_314_4.prefab_name ~= "" and arg_311_1.actors_[var_314_4.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_4.prefab_name].transform, "story_v_side_new_1106102", "1106102076", "story_v_side_new_1106102.awb")

						arg_311_1:RecordAudio("1106102076", var_314_9)
						arg_311_1:RecordAudio("1106102076", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102076", "story_v_side_new_1106102.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102076", "story_v_side_new_1106102.awb")
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
	Play1106102077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1106102077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1106102078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1061ui_story"]) and arg_315_1.var_.characterEffect1061ui_story == nil then
				arg_315_1.var_.characterEffect1061ui_story = arg_315_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1061ui_story"]) then
				if arg_315_1.var_.characterEffect1061ui_story and not isNil(arg_315_1.actors_["1061ui_story"]) then
					arg_315_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1061ui_story"]) and arg_315_1.var_.characterEffect1061ui_story then
				arg_315_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.425

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1106102077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 17 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 17)

				if (17 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 17)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1106102078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1106102078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1106102079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.875

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1106102078).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 35 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 35)

				if (35 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 35)) > 0 and var_322_0 < var_322_3 then
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
	Play1106102079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1106102079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1106102080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1061ui_story = arg_323_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1061ui_story"].transform.position).z)
				arg_323_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1061ui_story"].transform.localEulerAngles = arg_323_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1061ui_story"].transform.position).z)
				arg_323_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1061ui_story"].transform.localEulerAngles = arg_323_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 0.666666666666667 < arg_323_1.time_ and arg_323_1.time_ <= 0.666666666666667 + arg_326_0 then
				arg_323_1:AudioAction("play", "effect", "se_story_141", "se_story_141_xuanji02", "")
			end

			local var_326_2 = 0
			local var_326_3 = 0.825

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1106102079).content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_6 = 33 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_4) / 33)

				if (33 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_4) / 33)) > 0 and var_326_3 < var_326_6 then
					arg_323_1.talkMaxDuration = var_326_6

					if var_326_6 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_6 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_4
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_7 and arg_323_1.time_ < var_326_2 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1106102080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1106102080
		arg_327_1.duration_ = 2.5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1106102081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1061ui_story = arg_327_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1061ui_story"].transform.position).z)
				arg_327_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1061ui_story"].transform.localEulerAngles = arg_327_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_327_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1061ui_story"].transform.position).z)
				arg_327_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1061ui_story"].transform.localEulerAngles = arg_327_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["1061ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1061ui_story == nil then
				arg_327_1.var_.characterEffect1061ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect1061ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1061ui_story then
				arg_327_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_330_4 = 0
			local var_330_5 = 0.3

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(1106102080)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 12 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 12)

				if (12 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 12)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102080", "story_v_side_new_1106102.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102080", "story_v_side_new_1106102.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_side_new_1106102", "1106102080", "story_v_side_new_1106102.awb")

						arg_327_1:RecordAudio("1106102080", var_330_11)
						arg_327_1:RecordAudio("1106102080", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102080", "story_v_side_new_1106102.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102080", "story_v_side_new_1106102.awb")
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

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play1106102081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1106102081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1106102082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1061ui_story = arg_331_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1061ui_story"].transform.position).z)
				arg_331_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1061ui_story"].transform.localEulerAngles = arg_331_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1061ui_story"].transform.position).z)
				arg_331_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1061ui_story"].transform.localEulerAngles = arg_331_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1061ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1061ui_story == nil then
				arg_331_1.var_.characterEffect1061ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1061ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_2)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1061ui_story then
				arg_331_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_334_3 = 0
			local var_334_4 = 1.325

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_3 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_5 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1106102081).content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 53 <= 0 and var_334_4 or var_334_4 * (utf8.len(var_334_5) / 53)

				if (53 <= 0 and var_334_4 or var_334_4 * (utf8.len(var_334_5) / 53)) > 0 and var_334_4 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_3 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_3
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_4, arg_331_1.talkMaxDuration)

			if var_334_3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_3 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_3) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_3 + var_334_8 and arg_331_1.time_ < var_334_3 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play1106102082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1106102082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1106102083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.325

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
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

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1106102082).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 13 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 13)

				if (13 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 13)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1106102083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1106102083
		arg_339_1.duration_ = 2.03

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1106102084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1061ui_story = arg_339_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1061ui_story"].transform.position).z)
				arg_339_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1061ui_story"].transform.localEulerAngles = arg_339_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_339_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1061ui_story"].transform.position).z)
				arg_339_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1061ui_story"].transform.localEulerAngles = arg_339_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1061ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1061ui_story == nil then
				arg_339_1.var_.characterEffect1061ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1061ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1061ui_story then
				arg_339_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_342_4 = 0
			local var_342_5 = 0.25

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(1106102083)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 10 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 10)

				if (10 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 10)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102083", "story_v_side_new_1106102.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102083", "story_v_side_new_1106102.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_side_new_1106102", "1106102083", "story_v_side_new_1106102.awb")

						arg_339_1:RecordAudio("1106102083", var_342_11)
						arg_339_1:RecordAudio("1106102083", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102083", "story_v_side_new_1106102.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102083", "story_v_side_new_1106102.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play1106102084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1106102084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1106102085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1061ui_story"]) and arg_343_1.var_.characterEffect1061ui_story == nil then
				arg_343_1.var_.characterEffect1061ui_story = arg_343_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1061ui_story"]) then
				if arg_343_1.var_.characterEffect1061ui_story and not isNil(arg_343_1.actors_["1061ui_story"]) then
					arg_343_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1061ui_story"]) and arg_343_1.var_.characterEffect1061ui_story then
				arg_343_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.35

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
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

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1106102084).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 14 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 14)

				if (14 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 14)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1106102085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1106102085
		arg_347_1.duration_ = 5.9

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1106102086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1061ui_story"]) and arg_347_1.var_.characterEffect1061ui_story == nil then
				arg_347_1.var_.characterEffect1061ui_story = arg_347_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1061ui_story"]) then
				if arg_347_1.var_.characterEffect1061ui_story and not isNil(arg_347_1.actors_["1061ui_story"]) then
					arg_347_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1061ui_story"]) and arg_347_1.var_.characterEffect1061ui_story then
				arg_347_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_350_2 = 0
			local var_350_3 = 0.775

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(1106102085)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 31 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 31)

				if (31 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 31)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102085", "story_v_side_new_1106102.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102085", "story_v_side_new_1106102.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_side_new_1106102", "1106102085", "story_v_side_new_1106102.awb")

						arg_347_1:RecordAudio("1106102085", var_350_9)
						arg_347_1:RecordAudio("1106102085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102085", "story_v_side_new_1106102.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102085", "story_v_side_new_1106102.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1106102086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1106102086
		arg_351_1.duration_ = 3.67

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1106102087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action424")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_354_0 = 0
			local var_354_1 = 0.425

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(1106102086)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 17 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_3) / 17)

				if (17 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_3) / 17)) > 0 and var_354_1 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102086", "story_v_side_new_1106102.awb") ~= 0 then
					local var_354_6 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102086", "story_v_side_new_1106102.awb") / 1000

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end

					if var_354_2.prefab_name ~= "" and arg_351_1.actors_[var_354_2.prefab_name] ~= nil then
						local var_354_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_2.prefab_name].transform, "story_v_side_new_1106102", "1106102086", "story_v_side_new_1106102.awb")

						arg_351_1:RecordAudio("1106102086", var_354_7)
						arg_351_1:RecordAudio("1106102086", var_354_7)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102086", "story_v_side_new_1106102.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102086", "story_v_side_new_1106102.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_8 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_8 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_8

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_8 and arg_351_1.time_ < var_354_0 + var_354_8 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1106102087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1106102087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1106102088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1061ui_story"]) and arg_355_1.var_.characterEffect1061ui_story == nil then
				arg_355_1.var_.characterEffect1061ui_story = arg_355_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1061ui_story"]) then
				if arg_355_1.var_.characterEffect1061ui_story and not isNil(arg_355_1.actors_["1061ui_story"]) then
					arg_355_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1061ui_story"]) and arg_355_1.var_.characterEffect1061ui_story then
				arg_355_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.35

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1106102087).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 14 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 14)

				if (14 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 14)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1106102088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1106102088
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1106102089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1061ui_story"]) and arg_359_1.var_.characterEffect1061ui_story == nil then
				arg_359_1.var_.characterEffect1061ui_story = arg_359_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1061ui_story"]) then
				if arg_359_1.var_.characterEffect1061ui_story and not isNil(arg_359_1.actors_["1061ui_story"]) then
					arg_359_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1061ui_story"]) and arg_359_1.var_.characterEffect1061ui_story then
				arg_359_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_362_2 = 0
			local var_362_3 = 0.125

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_4 = arg_359_1:GetWordFromCfg(1106102088)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 5 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 5)

				if (5 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 5)) > 0 and var_362_3 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102088", "story_v_side_new_1106102.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102088", "story_v_side_new_1106102.awb") / 1000

					if var_362_8 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_2
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_side_new_1106102", "1106102088", "story_v_side_new_1106102.awb")

						arg_359_1:RecordAudio("1106102088", var_362_9)
						arg_359_1:RecordAudio("1106102088", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102088", "story_v_side_new_1106102.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102088", "story_v_side_new_1106102.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_10 and arg_359_1.time_ < var_362_2 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1106102089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1106102089
		arg_363_1.duration_ = 1

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"

			SetActive(arg_363_1.choicesGo_, true)

			for iter_364_0, iter_364_1 in ipairs(arg_363_1.choices_) do
				SetActive(iter_364_1.go, iter_364_0 <= 2)
			end

			arg_363_1.choices_[1].txt.text = arg_363_1:FormatText(StoryChoiceCfg[1390].name)
			arg_363_1.choices_[2].txt.text = arg_363_1:FormatText(StoryChoiceCfg[1391].name)
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1106102090(arg_363_1)
			end

			if arg_365_0 == 2 then
				arg_363_0:Play1106102090(arg_363_1)
			end

			arg_363_1:RecordChoiceLog(1106102089, 1390, 1391)
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1061ui_story"]) and arg_363_1.var_.characterEffect1061ui_story == nil then
				arg_363_1.var_.characterEffect1061ui_story = arg_363_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1061ui_story"]) then
				if arg_363_1.var_.characterEffect1061ui_story and not isNil(arg_363_1.actors_["1061ui_story"]) then
					arg_363_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1061ui_story"]) and arg_363_1.var_.characterEffect1061ui_story then
				arg_363_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			if arg_363_1.time_ >= var_366_1 + 0.6 and arg_363_1.time_ < var_366_1 + 0.6 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1106102090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1106102090
		arg_367_1.duration_ = 5.83

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1106102091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_0 = 1

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				local var_370_1 = Color.New(1, 1, 1)

				var_370_1.a = Mathf.Lerp(1, 0, (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.mask_.color = var_370_1
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				local var_370_2 = Color.New(1, 1, 1)

				arg_367_1.mask_.enabled = false
				var_370_2.a = 0
				arg_367_1.mask_.color = var_370_2
			end

			local var_370_3 = arg_367_1.actors_["1061ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1061ui_story = var_370_3.localPosition
			end

			local var_370_4 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_3.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_4)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_3.localPosition = Vector3.New(0, 100, 0)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			if 1.266666666666 < arg_367_1.time_ and arg_367_1.time_ <= 1.266666666666 + arg_370_0 then
				arg_367_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_xuanji", "")
			end

			if arg_367_1.frameCnt_ <= 1 then
				arg_367_1.dialog_:SetActive(false)
			end

			local var_370_6 = 0.833333333333333
			local var_370_7 = 0.7

			if 0.833333333333333 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0

				arg_367_1.dialog_:SetActive(true)

				arg_367_1.dialogCg_.alpha = 0

				local var_370_8 = LeanTween.value(arg_367_1.dialog_, 0, 1, 0.3)

				var_370_8:setOnUpdate(LuaHelper.FloatAction(function(arg_371_0)
					arg_367_1.dialogCg_.alpha = arg_371_0
				end))
				var_370_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_367_1.dialog_)
					var_370_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_367_1.duration_ = arg_367_1.duration_ + 0.3

				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_9 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1106102090).content)

				arg_367_1.text_.text = var_370_9

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_11 = 28 <= 0 and var_370_7 or var_370_7 * (utf8.len(var_370_9) / 28)

				if (28 <= 0 and var_370_7 or var_370_7 * (utf8.len(var_370_9) / 28)) > 0 and var_370_7 < var_370_11 then
					arg_367_1.talkMaxDuration = var_370_11
					var_370_6 = var_370_6 + 0.3

					if var_370_11 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_6
					end
				end

				arg_367_1.text_.text = var_370_9
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = var_370_6 + 0.3
			local var_370_13 = math.max(var_370_7, arg_367_1.talkMaxDuration)

			if var_370_6 + 0.3 <= arg_367_1.time_ and arg_367_1.time_ < var_370_12 + var_370_13 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_12) / var_370_13

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_12 + var_370_13 and arg_367_1.time_ < var_370_12 + var_370_13 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play1106102091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1106102091
		arg_373_1.duration_ = 8

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1106102092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if arg_373_1.bgs_.H03a == nil then
				local var_376_0 = Object.Instantiate(arg_373_1.paintGo_)

				var_376_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H03a")
				var_376_0.name = "H03a"
				var_376_0.transform.parent = arg_373_1.stage_.transform
				var_376_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.bgs_.H03a = var_376_0
			end

			if 1 < arg_373_1.time_ and arg_373_1.time_ <= 1 + arg_376_0 then
				local var_376_1 = arg_373_1.bgs_.H03a

				arg_373_1.bgs_.H03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_376_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_2 = var_376_1:GetComponent("SpriteRenderer")

				if var_376_2 and var_376_2.sprite then
					local var_376_3 = 2 * (var_376_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_376_1.transform.localScale = Vector3.New(var_376_3 / var_376_2.sprite.bounds.size.y < var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x and var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x or var_376_3 / var_376_2.sprite.bounds.size.y, var_376_3 / var_376_2.sprite.bounds.size.y < var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x and var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x or var_376_3 / var_376_2.sprite.bounds.size.y, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "H03a" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_376_4 = 2.999999999999

			if 2.999999999999 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			if arg_373_1.time_ >= var_376_4 + 0.3 and arg_373_1.time_ < var_376_4 + 0.3 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end

			local var_376_5 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_6 = 1

			if var_376_5 <= arg_373_1.time_ and arg_373_1.time_ < var_376_5 + var_376_6 then
				local var_376_7 = Color.New(0, 0, 0)

				var_376_7.a = Mathf.Lerp(0, 1, (arg_373_1.time_ - var_376_5) / var_376_6)
				arg_373_1.mask_.color = var_376_7
			end

			if arg_373_1.time_ >= var_376_5 + var_376_6 and arg_373_1.time_ < var_376_5 + var_376_6 + arg_376_0 then
				local var_376_8 = Color.New(0, 0, 0)

				var_376_8.a = 1
				arg_373_1.mask_.color = var_376_8
			end

			local var_376_9 = 1

			if 1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_10 = 2

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_10 then
				local var_376_11 = Color.New(0, 0, 0)

				var_376_11.a = Mathf.Lerp(1, 0, (arg_373_1.time_ - var_376_9) / var_376_10)
				arg_373_1.mask_.color = var_376_11
			end

			if arg_373_1.time_ >= var_376_9 + var_376_10 and arg_373_1.time_ < var_376_9 + var_376_10 + arg_376_0 then
				local var_376_12 = Color.New(0, 0, 0)

				arg_373_1.mask_.enabled = false
				var_376_12.a = 0
				arg_373_1.mask_.color = var_376_12
			end

			local var_376_13 = arg_373_1.actors_["1061ui_story"].transform

			if 1 < arg_373_1.time_ and arg_373_1.time_ <= 1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1061ui_story = var_376_13.localPosition
			end

			local var_376_14 = 0.001

			if 1 <= arg_373_1.time_ and arg_373_1.time_ < 1 + var_376_14 then
				var_376_13.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 1) / var_376_14)
				var_376_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_13.position).x, (manager.ui.mainCamera.transform.position - var_376_13.position).y, (manager.ui.mainCamera.transform.position - var_376_13.position).z)
				var_376_13.localEulerAngles.z = 0
				var_376_13.localEulerAngles.x = 0
				var_376_13.localEulerAngles = var_376_13.localEulerAngles
			end

			if arg_373_1.time_ >= 1 + var_376_14 and arg_373_1.time_ < 1 + var_376_14 + arg_376_0 then
				var_376_13.localPosition = Vector3.New(0, 100, 0)
				var_376_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_13.position).x, (manager.ui.mainCamera.transform.position - var_376_13.position).y, (manager.ui.mainCamera.transform.position - var_376_13.position).z)
				var_376_13.localEulerAngles.z = 0
				var_376_13.localEulerAngles.x = 0
				var_376_13.localEulerAngles = var_376_13.localEulerAngles
			end

			if 0.6 < arg_373_1.time_ and arg_373_1.time_ <= 0.6 + arg_376_0 then
				arg_373_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night", "")
			end

			if 0.0666666666666667 < arg_373_1.time_ and arg_373_1.time_ <= 0.0666666666666667 + arg_376_0 then
				arg_373_1:AudioAction("stop", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_17 = 2.999999999999
			local var_376_18 = 0.725

			if 2.999999999999 < arg_373_1.time_ and arg_373_1.time_ <= var_376_17 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_19 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_19:setOnUpdate(LuaHelper.FloatAction(function(arg_377_0)
					arg_373_1.dialogCg_.alpha = arg_377_0
				end))
				var_376_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_20 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1106102091).content)

				arg_373_1.text_.text = var_376_20

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_22 = 29 <= 0 and var_376_18 or var_376_18 * (utf8.len(var_376_20) / 29)

				if (29 <= 0 and var_376_18 or var_376_18 * (utf8.len(var_376_20) / 29)) > 0 and var_376_18 < var_376_22 then
					arg_373_1.talkMaxDuration = var_376_22
					var_376_17 = var_376_17 + 0.3

					if var_376_22 + var_376_17 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_22 + var_376_17
					end
				end

				arg_373_1.text_.text = var_376_20
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_23 = var_376_17 + 0.3
			local var_376_24 = math.max(var_376_18, arg_373_1.talkMaxDuration)

			if var_376_17 + 0.3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_24 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_23) / var_376_24

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_23 + var_376_24 and arg_373_1.time_ < var_376_23 + var_376_24 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play1106102092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1106102092
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1106102093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 1.125

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1106102092).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 45 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 45)

				if (45 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 45)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1106102093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1106102093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1106102094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.85

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1106102093).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 34 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 34)

				if (34 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 34)) > 0 and var_386_0 < var_386_3 then
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
	Play1106102094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1106102094
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1106102095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.925

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1106102094).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 37 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 37)

				if (37 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 37)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1106102095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1106102095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1106102096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.5

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1106102095).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 20 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 20)

				if (20 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 20)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1106102096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1106102096
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1106102097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.675

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1106102096).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 27 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 27)

				if (27 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 27)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1106102097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1106102097
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1106102098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.325

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1106102097).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 13 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 13)

				if (13 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 13)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1106102098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1106102098
		arg_403_1.duration_ = 4.9

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1106102099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1061ui_story = arg_403_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1061ui_story"].transform.position).z)
				arg_403_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1061ui_story"].transform.localEulerAngles = arg_403_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_403_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1061ui_story"].transform.position).z)
				arg_403_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1061ui_story"].transform.localEulerAngles = arg_403_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1061ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1061ui_story == nil then
				arg_403_1.var_.characterEffect1061ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1061ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1061ui_story then
				arg_403_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_406_4 = 0
			local var_406_5 = 0.475

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(1106102098)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 19 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 19)

				if (19 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 19)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102098", "story_v_side_new_1106102.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102098", "story_v_side_new_1106102.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_new_1106102", "1106102098", "story_v_side_new_1106102.awb")

						arg_403_1:RecordAudio("1106102098", var_406_11)
						arg_403_1:RecordAudio("1106102098", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102098", "story_v_side_new_1106102.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102098", "story_v_side_new_1106102.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1106102099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1106102099
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1106102100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1061ui_story = arg_407_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1061ui_story"].transform.position).z)
				arg_407_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1061ui_story"].transform.localEulerAngles = arg_407_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_407_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1061ui_story"].transform.position).z)
				arg_407_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1061ui_story"].transform.localEulerAngles = arg_407_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["1061ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1061ui_story == nil then
				arg_407_1.var_.characterEffect1061ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect1061ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_2)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1061ui_story then
				arg_407_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_410_3 = 0
			local var_410_4 = 0.675

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_3 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_5 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1106102099).content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 27 <= 0 and var_410_4 or var_410_4 * (utf8.len(var_410_5) / 27)

				if (27 <= 0 and var_410_4 or var_410_4 * (utf8.len(var_410_5) / 27)) > 0 and var_410_4 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_3 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_3
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_8 = math.max(var_410_4, arg_407_1.talkMaxDuration)

			if var_410_3 <= arg_407_1.time_ and arg_407_1.time_ < var_410_3 + var_410_8 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_3) / var_410_8

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_3 + var_410_8 and arg_407_1.time_ < var_410_3 + var_410_8 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play1106102100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1106102100
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1106102101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.575

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

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1106102100).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 23 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 23)

				if (23 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 23)) > 0 and var_414_0 < var_414_3 then
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
	Play1106102101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1106102101
		arg_415_1.duration_ = 3.4

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1106102102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1061ui_story = arg_415_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1061ui_story"].transform.position).z)
				arg_415_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1061ui_story"].transform.localEulerAngles = arg_415_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_415_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1061ui_story"].transform.position).z)
				arg_415_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1061ui_story"].transform.localEulerAngles = arg_415_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["1061ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1061ui_story == nil then
				arg_415_1.var_.characterEffect1061ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1061ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1061ui_story then
				arg_415_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_418_4 = 0
			local var_418_5 = 0.375

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(1106102101)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 15 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 15)

				if (15 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 15)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102101", "story_v_side_new_1106102.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102101", "story_v_side_new_1106102.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_side_new_1106102", "1106102101", "story_v_side_new_1106102.awb")

						arg_415_1:RecordAudio("1106102101", var_418_11)
						arg_415_1:RecordAudio("1106102101", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102101", "story_v_side_new_1106102.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102101", "story_v_side_new_1106102.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1106102102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1106102102
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1106102103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1061ui_story"]) and arg_419_1.var_.characterEffect1061ui_story == nil then
				arg_419_1.var_.characterEffect1061ui_story = arg_419_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1061ui_story"]) then
				if arg_419_1.var_.characterEffect1061ui_story and not isNil(arg_419_1.actors_["1061ui_story"]) then
					arg_419_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_0)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1061ui_story"]) and arg_419_1.var_.characterEffect1061ui_story then
				arg_419_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_422_1 = 0
			local var_422_2 = 0.25

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(1106102102).content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 10 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 10)

				if (10 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 10)) > 0 and var_422_2 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_6 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_6 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_6

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_6 and arg_419_1.time_ < var_422_1 + var_422_6 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1106102103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1106102103
		arg_423_1.duration_ = 4.1

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1106102104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1061ui_story"]) and arg_423_1.var_.characterEffect1061ui_story == nil then
				arg_423_1.var_.characterEffect1061ui_story = arg_423_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1061ui_story"]) then
				if arg_423_1.var_.characterEffect1061ui_story and not isNil(arg_423_1.actors_["1061ui_story"]) then
					arg_423_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1061ui_story"]) and arg_423_1.var_.characterEffect1061ui_story then
				arg_423_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_426_2 = 0
			local var_426_3 = 0.5

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_4 = arg_423_1:GetWordFromCfg(1106102103)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 20 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 20)

				if (20 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 20)) > 0 and var_426_3 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102103", "story_v_side_new_1106102.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102103", "story_v_side_new_1106102.awb") / 1000

					if var_426_8 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_2
					end

					if var_426_4.prefab_name ~= "" and arg_423_1.actors_[var_426_4.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_4.prefab_name].transform, "story_v_side_new_1106102", "1106102103", "story_v_side_new_1106102.awb")

						arg_423_1:RecordAudio("1106102103", var_426_9)
						arg_423_1:RecordAudio("1106102103", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102103", "story_v_side_new_1106102.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102103", "story_v_side_new_1106102.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_10 and arg_423_1.time_ < var_426_2 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1106102104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1106102104
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1106102105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1061ui_story"]) and arg_427_1.var_.characterEffect1061ui_story == nil then
				arg_427_1.var_.characterEffect1061ui_story = arg_427_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1061ui_story"]) then
				if arg_427_1.var_.characterEffect1061ui_story and not isNil(arg_427_1.actors_["1061ui_story"]) then
					arg_427_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1061ui_story"]) and arg_427_1.var_.characterEffect1061ui_story then
				arg_427_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_430_1 = 0
			local var_430_2 = 0.75

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
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

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1106102104).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 30 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 30)

				if (30 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 30)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1106102105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1106102105
		arg_431_1.duration_ = 3.8

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1106102106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1061ui_story"]) and arg_431_1.var_.characterEffect1061ui_story == nil then
				arg_431_1.var_.characterEffect1061ui_story = arg_431_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1061ui_story"]) then
				if arg_431_1.var_.characterEffect1061ui_story and not isNil(arg_431_1.actors_["1061ui_story"]) then
					arg_431_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1061ui_story"]) and arg_431_1.var_.characterEffect1061ui_story then
				arg_431_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action432")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_434_2 = 0
			local var_434_3 = 0.425

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_4 = arg_431_1:GetWordFromCfg(1106102105)
				local var_434_5 = arg_431_1:FormatText(var_434_4.content)

				arg_431_1.text_.text = var_434_5

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_7 = 17 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 17)

				if (17 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 17)) > 0 and var_434_3 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_5
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102105", "story_v_side_new_1106102.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102105", "story_v_side_new_1106102.awb") / 1000

					if var_434_8 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_2
					end

					if var_434_4.prefab_name ~= "" and arg_431_1.actors_[var_434_4.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_4.prefab_name].transform, "story_v_side_new_1106102", "1106102105", "story_v_side_new_1106102.awb")

						arg_431_1:RecordAudio("1106102105", var_434_9)
						arg_431_1:RecordAudio("1106102105", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102105", "story_v_side_new_1106102.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102105", "story_v_side_new_1106102.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_10 and arg_431_1.time_ < var_434_2 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1106102106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1106102106
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1106102107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1061ui_story"]) and arg_435_1.var_.characterEffect1061ui_story == nil then
				arg_435_1.var_.characterEffect1061ui_story = arg_435_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1061ui_story"]) then
				if arg_435_1.var_.characterEffect1061ui_story and not isNil(arg_435_1.actors_["1061ui_story"]) then
					arg_435_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1061ui_story"]) and arg_435_1.var_.characterEffect1061ui_story then
				arg_435_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_438_1 = 0
			local var_438_2 = 0.45

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(1106102106).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 18 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 18)

				if (18 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 18)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1106102107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1106102107
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1106102108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1061ui_story = arg_439_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1061ui_story"].transform.position).z)
				arg_439_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1061ui_story"].transform.localEulerAngles = arg_439_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_439_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1061ui_story"].transform.position).z)
				arg_439_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1061ui_story"].transform.localEulerAngles = arg_439_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 0.3 < arg_439_1.time_ and arg_439_1.time_ <= 0.3 + arg_442_0 then
				arg_439_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_map", "")
			end

			local var_442_2 = 0
			local var_442_3 = 0.7

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1106102107).content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_6 = 28 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_4) / 28)

				if (28 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_4) / 28)) > 0 and var_442_3 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_7 and arg_439_1.time_ < var_442_2 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play1106102108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1106102108
		arg_443_1.duration_ = 3.53

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1106102109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1061ui_story = arg_443_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1061ui_story"].transform.position).z)
				arg_443_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1061ui_story"].transform.localEulerAngles = arg_443_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_443_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1061ui_story"].transform.position).z)
				arg_443_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1061ui_story"].transform.localEulerAngles = arg_443_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1061ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1061ui_story == nil then
				arg_443_1.var_.characterEffect1061ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1061ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1061ui_story then
				arg_443_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_446_4 = 0
			local var_446_5 = 0.425

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_6 = arg_443_1:GetWordFromCfg(1106102108)
				local var_446_7 = arg_443_1:FormatText(var_446_6.content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 17 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 17)

				if (17 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 17)) > 0 and var_446_5 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_4
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102108", "story_v_side_new_1106102.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102108", "story_v_side_new_1106102.awb") / 1000

					if var_446_10 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_4
					end

					if var_446_6.prefab_name ~= "" and arg_443_1.actors_[var_446_6.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_6.prefab_name].transform, "story_v_side_new_1106102", "1106102108", "story_v_side_new_1106102.awb")

						arg_443_1:RecordAudio("1106102108", var_446_11)
						arg_443_1:RecordAudio("1106102108", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102108", "story_v_side_new_1106102.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102108", "story_v_side_new_1106102.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = math.max(var_446_5, arg_443_1.talkMaxDuration)

			if var_446_4 <= arg_443_1.time_ and arg_443_1.time_ < var_446_4 + var_446_12 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_4) / var_446_12

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_4 + var_446_12 and arg_443_1.time_ < var_446_4 + var_446_12 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play1106102109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1106102109
		arg_447_1.duration_ = 9

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1106102110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if arg_447_1.bgs_.ST29a == nil then
				local var_450_0 = Object.Instantiate(arg_447_1.paintGo_)

				var_450_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29a")
				var_450_0.name = "ST29a"
				var_450_0.transform.parent = arg_447_1.stage_.transform
				var_450_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.bgs_.ST29a = var_450_0
			end

			if 2 < arg_447_1.time_ and arg_447_1.time_ <= 2 + arg_450_0 then
				local var_450_1 = arg_447_1.bgs_.ST29a

				arg_447_1.bgs_.ST29a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_450_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_450_2 = var_450_1:GetComponent("SpriteRenderer")

				if var_450_2 and var_450_2.sprite then
					local var_450_3 = 2 * (var_450_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_450_1.transform.localScale = Vector3.New(var_450_3 / var_450_2.sprite.bounds.size.y < var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x and var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x or var_450_3 / var_450_2.sprite.bounds.size.y, var_450_3 / var_450_2.sprite.bounds.size.y < var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x and var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x or var_450_3 / var_450_2.sprite.bounds.size.y, 0)
				end

				for iter_450_0, iter_450_1 in pairs(arg_447_1.bgs_) do
					if iter_450_0 ~= "ST29a" then
						iter_450_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_450_4 = 4

			if 4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1.allBtn_.enabled = false
			end

			if arg_447_1.time_ >= var_450_4 + 0.3 and arg_447_1.time_ < var_450_4 + 0.3 + arg_450_0 then
				arg_447_1.allBtn_.enabled = true
			end

			local var_450_5 = 0

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_6 = 2

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_6 then
				local var_450_7 = Color.New(0, 0, 0)

				var_450_7.a = Mathf.Lerp(0, 1, (arg_447_1.time_ - var_450_5) / var_450_6)
				arg_447_1.mask_.color = var_450_7
			end

			if arg_447_1.time_ >= var_450_5 + var_450_6 and arg_447_1.time_ < var_450_5 + var_450_6 + arg_450_0 then
				local var_450_8 = Color.New(0, 0, 0)

				var_450_8.a = 1
				arg_447_1.mask_.color = var_450_8
			end

			local var_450_9 = 2

			if 2 < arg_447_1.time_ and arg_447_1.time_ <= var_450_9 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_10 = 2

			if var_450_9 <= arg_447_1.time_ and arg_447_1.time_ < var_450_9 + var_450_10 then
				local var_450_11 = Color.New(0, 0, 0)

				var_450_11.a = Mathf.Lerp(1, 0, (arg_447_1.time_ - var_450_9) / var_450_10)
				arg_447_1.mask_.color = var_450_11
			end

			if arg_447_1.time_ >= var_450_9 + var_450_10 and arg_447_1.time_ < var_450_9 + var_450_10 + arg_450_0 then
				local var_450_12 = Color.New(0, 0, 0)

				arg_447_1.mask_.enabled = false
				var_450_12.a = 0
				arg_447_1.mask_.color = var_450_12
			end

			local var_450_13 = arg_447_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_447_1.time_ and arg_447_1.time_ <= 1.96599999815226 + arg_450_0 then
				arg_447_1.var_.moveOldPos1061ui_story = var_450_13.localPosition
			end

			local var_450_14 = 0.001

			if 1.96599999815226 <= arg_447_1.time_ and arg_447_1.time_ < 1.96599999815226 + var_450_14 then
				var_450_13.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_447_1.time_ - 1.96599999815226) / var_450_14)
				var_450_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_13.position).x, (manager.ui.mainCamera.transform.position - var_450_13.position).y, (manager.ui.mainCamera.transform.position - var_450_13.position).z)
				var_450_13.localEulerAngles.z = 0
				var_450_13.localEulerAngles.x = 0
				var_450_13.localEulerAngles = var_450_13.localEulerAngles
			end

			if arg_447_1.time_ >= 1.96599999815226 + var_450_14 and arg_447_1.time_ < 1.96599999815226 + var_450_14 + arg_450_0 then
				var_450_13.localPosition = Vector3.New(0, 100, 0)
				var_450_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_13.position).x, (manager.ui.mainCamera.transform.position - var_450_13.position).y, (manager.ui.mainCamera.transform.position - var_450_13.position).z)
				var_450_13.localEulerAngles.z = 0
				var_450_13.localEulerAngles.x = 0
				var_450_13.localEulerAngles = var_450_13.localEulerAngles
			end

			local var_450_15 = arg_447_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_447_1.time_ and arg_447_1.time_ <= 1.96599999815226 + arg_450_0 and not isNil(var_450_15) and arg_447_1.var_.characterEffect1061ui_story == nil then
				arg_447_1.var_.characterEffect1061ui_story = var_450_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_16 = 0.034000001847744

			if 1.96599999815226 <= arg_447_1.time_ and arg_447_1.time_ < 1.96599999815226 + var_450_16 and not isNil(var_450_15) then
				if arg_447_1.var_.characterEffect1061ui_story and not isNil(var_450_15) then
					arg_447_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 1.96599999815226) / var_450_16)
				end
			end

			if arg_447_1.time_ >= 1.96599999815226 + var_450_16 and arg_447_1.time_ < 1.96599999815226 + var_450_16 + arg_450_0 and not isNil(var_450_15) and arg_447_1.var_.characterEffect1061ui_story then
				arg_447_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 1.46666666666667 < arg_447_1.time_ and arg_447_1.time_ <= 1.46666666666667 + arg_450_0 then
				arg_447_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 4 < arg_447_1.time_ and arg_447_1.time_ <= 4 + arg_450_0 then
				arg_447_1:AudioAction("play", "effect", "se_story_141", "se_story_141_xuanji03", "")
			end

			if 0.0666666666666667 < arg_447_1.time_ and arg_447_1.time_ <= 0.0666666666666667 + arg_450_0 then
				arg_447_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night", "")
			end

			if arg_447_1.frameCnt_ <= 1 then
				arg_447_1.dialog_:SetActive(false)
			end

			local var_450_20 = 4
			local var_450_21 = 0.7

			if 4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_20 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				arg_447_1.dialog_:SetActive(true)

				arg_447_1.dialogCg_.alpha = 0

				local var_450_22 = LeanTween.value(arg_447_1.dialog_, 0, 1, 0.3)

				var_450_22:setOnUpdate(LuaHelper.FloatAction(function(arg_451_0)
					arg_447_1.dialogCg_.alpha = arg_451_0
				end))
				var_450_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_447_1.dialog_)
					var_450_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_447_1.duration_ = arg_447_1.duration_ + 0.3

				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_23 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1106102109).content)

				arg_447_1.text_.text = var_450_23

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_25 = 28 <= 0 and var_450_21 or var_450_21 * (utf8.len(var_450_23) / 28)

				if (28 <= 0 and var_450_21 or var_450_21 * (utf8.len(var_450_23) / 28)) > 0 and var_450_21 < var_450_25 then
					arg_447_1.talkMaxDuration = var_450_25
					var_450_20 = var_450_20 + 0.3

					if var_450_25 + var_450_20 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_25 + var_450_20
					end
				end

				arg_447_1.text_.text = var_450_23
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_26 = var_450_20 + 0.3
			local var_450_27 = math.max(var_450_21, arg_447_1.talkMaxDuration)

			if var_450_20 + 0.3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_26 + var_450_27 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_26) / var_450_27

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_26 + var_450_27 and arg_447_1.time_ < var_450_26 + var_450_27 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1106102110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1106102110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1106102111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.95

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1106102110).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 38 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 38)

				if (38 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 38)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1106102111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1106102111
		arg_457_1.duration_ = 4.7

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1106102112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1061ui_story = arg_457_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1061ui_story"].transform.position).z)
				arg_457_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1061ui_story"].transform.localEulerAngles = arg_457_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_457_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1061ui_story"].transform.position).z)
				arg_457_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1061ui_story"].transform.localEulerAngles = arg_457_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1061ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1061ui_story == nil then
				arg_457_1.var_.characterEffect1061ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1061ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1061ui_story then
				arg_457_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_460_4 = 0
			local var_460_5 = 0.475

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(1106102111)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 19 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 19)

				if (19 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 19)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102111", "story_v_side_new_1106102.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102111", "story_v_side_new_1106102.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_side_new_1106102", "1106102111", "story_v_side_new_1106102.awb")

						arg_457_1:RecordAudio("1106102111", var_460_11)
						arg_457_1:RecordAudio("1106102111", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102111", "story_v_side_new_1106102.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102111", "story_v_side_new_1106102.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1106102112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1106102112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1106102113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1061ui_story"]) and arg_461_1.var_.characterEffect1061ui_story == nil then
				arg_461_1.var_.characterEffect1061ui_story = arg_461_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1061ui_story"]) then
				if arg_461_1.var_.characterEffect1061ui_story and not isNil(arg_461_1.actors_["1061ui_story"]) then
					arg_461_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1061ui_story"]) and arg_461_1.var_.characterEffect1061ui_story then
				arg_461_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.9

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1106102112).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 36 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 36)

				if (36 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 36)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1106102113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1106102113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1106102114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.9

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1106102113).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 36 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 36)

				if (36 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 36)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1106102114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1106102114
		arg_469_1.duration_ = 9

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1106102115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if arg_469_1.bgs_.ST37 == nil then
				local var_472_0 = Object.Instantiate(arg_469_1.paintGo_)

				var_472_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_472_0.name = "ST37"
				var_472_0.transform.parent = arg_469_1.stage_.transform
				var_472_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.bgs_.ST37 = var_472_0
			end

			if 2 < arg_469_1.time_ and arg_469_1.time_ <= 2 + arg_472_0 then
				local var_472_1 = arg_469_1.bgs_.ST37

				arg_469_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_472_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_472_2 = var_472_1:GetComponent("SpriteRenderer")

				if var_472_2 and var_472_2.sprite then
					local var_472_3 = 2 * (var_472_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_472_1.transform.localScale = Vector3.New(var_472_3 / var_472_2.sprite.bounds.size.y < var_472_3 * manager.ui.mainCameraCom_.aspect / var_472_2.sprite.bounds.size.x and var_472_3 * manager.ui.mainCameraCom_.aspect / var_472_2.sprite.bounds.size.x or var_472_3 / var_472_2.sprite.bounds.size.y, var_472_3 / var_472_2.sprite.bounds.size.y < var_472_3 * manager.ui.mainCameraCom_.aspect / var_472_2.sprite.bounds.size.x and var_472_3 * manager.ui.mainCameraCom_.aspect / var_472_2.sprite.bounds.size.x or var_472_3 / var_472_2.sprite.bounds.size.y, 0)
				end

				for iter_472_0, iter_472_1 in pairs(arg_469_1.bgs_) do
					if iter_472_0 ~= "ST37" then
						iter_472_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_472_4 = 3.999999999999

			if 3.999999999999 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			if arg_469_1.time_ >= var_472_4 + 0.3 and arg_469_1.time_ < var_472_4 + 0.3 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_5 = 0

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_5 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_6 = 2

			if var_472_5 <= arg_469_1.time_ and arg_469_1.time_ < var_472_5 + var_472_6 then
				local var_472_7 = Color.New(0, 0, 0)

				var_472_7.a = Mathf.Lerp(0, 1, (arg_469_1.time_ - var_472_5) / var_472_6)
				arg_469_1.mask_.color = var_472_7
			end

			if arg_469_1.time_ >= var_472_5 + var_472_6 and arg_469_1.time_ < var_472_5 + var_472_6 + arg_472_0 then
				local var_472_8 = Color.New(0, 0, 0)

				var_472_8.a = 1
				arg_469_1.mask_.color = var_472_8
			end

			local var_472_9 = 2

			if 2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_9 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_10 = 2

			if var_472_9 <= arg_469_1.time_ and arg_469_1.time_ < var_472_9 + var_472_10 then
				local var_472_11 = Color.New(0, 0, 0)

				var_472_11.a = Mathf.Lerp(1, 0, (arg_469_1.time_ - var_472_9) / var_472_10)
				arg_469_1.mask_.color = var_472_11
			end

			if arg_469_1.time_ >= var_472_9 + var_472_10 and arg_469_1.time_ < var_472_9 + var_472_10 + arg_472_0 then
				local var_472_12 = Color.New(0, 0, 0)

				arg_469_1.mask_.enabled = false
				var_472_12.a = 0
				arg_469_1.mask_.color = var_472_12
			end

			local var_472_13 = arg_469_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_469_1.time_ and arg_469_1.time_ <= 1.96599999815226 + arg_472_0 then
				arg_469_1.var_.moveOldPos1061ui_story = var_472_13.localPosition
			end

			local var_472_14 = 0.001

			if 1.96599999815226 <= arg_469_1.time_ and arg_469_1.time_ < 1.96599999815226 + var_472_14 then
				var_472_13.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 1.96599999815226) / var_472_14)
				var_472_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_13.position).x, (manager.ui.mainCamera.transform.position - var_472_13.position).y, (manager.ui.mainCamera.transform.position - var_472_13.position).z)
				var_472_13.localEulerAngles.z = 0
				var_472_13.localEulerAngles.x = 0
				var_472_13.localEulerAngles = var_472_13.localEulerAngles
			end

			if arg_469_1.time_ >= 1.96599999815226 + var_472_14 and arg_469_1.time_ < 1.96599999815226 + var_472_14 + arg_472_0 then
				var_472_13.localPosition = Vector3.New(0, 100, 0)
				var_472_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_13.position).x, (manager.ui.mainCamera.transform.position - var_472_13.position).y, (manager.ui.mainCamera.transform.position - var_472_13.position).z)
				var_472_13.localEulerAngles.z = 0
				var_472_13.localEulerAngles.x = 0
				var_472_13.localEulerAngles = var_472_13.localEulerAngles
			end

			if 1.5 < arg_469_1.time_ and arg_469_1.time_ <= 1.5 + arg_472_0 then
				arg_469_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_472_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_469_1.bgmTxt_.text ~= var_472_18 and arg_469_1.bgmTxt_.text ~= "" then
						if arg_469_1.bgmTxt2_.text ~= "" then
							arg_469_1.bgmTxt_.text = arg_469_1.bgmTxt2_.text
						end

						arg_469_1.bgmTxt2_.text = var_472_18

						arg_469_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_469_1.bgmTxt_.text = var_472_18
						arg_469_1.bgmTxt2_.text = var_472_18
					end

					if arg_469_1.bgmTimer then
						arg_469_1.bgmTimer:Stop()

						arg_469_1.bgmTimer = nil
					end

					if arg_469_1.settingData.show_music_name == 1 then
						arg_469_1.musicController:SetSelectedState("show")
						arg_469_1.musicAnimator_:Play("open", 0, 0)

						if arg_469_1.settingData.music_time ~= 0 then
							arg_469_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_469_1.settingData.music_time), function()
								if arg_469_1 == nil or isNil(arg_469_1.bgmTxt_) then
									return
								end

								arg_469_1.musicController:SetSelectedState("hide")
								arg_469_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_469_1.time_ and arg_469_1.time_ <= 0.6 + arg_472_0 then
				arg_469_1:AudioAction("play", "music", "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_472_21 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if "" ~= "" then
					if arg_469_1.bgmTxt_.text ~= var_472_21 and arg_469_1.bgmTxt_.text ~= "" then
						if arg_469_1.bgmTxt2_.text ~= "" then
							arg_469_1.bgmTxt_.text = arg_469_1.bgmTxt2_.text
						end

						arg_469_1.bgmTxt2_.text = var_472_21

						arg_469_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_469_1.bgmTxt_.text = var_472_21
						arg_469_1.bgmTxt2_.text = var_472_21
					end

					if arg_469_1.bgmTimer then
						arg_469_1.bgmTimer:Stop()

						arg_469_1.bgmTimer = nil
					end

					if arg_469_1.settingData.show_music_name == 1 then
						arg_469_1.musicController:SetSelectedState("show")
						arg_469_1.musicAnimator_:Play("open", 0, 0)

						if arg_469_1.settingData.music_time ~= 0 then
							arg_469_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_469_1.settingData.music_time), function()
								if arg_469_1 == nil or isNil(arg_469_1.bgmTxt_) then
									return
								end

								arg_469_1.musicController:SetSelectedState("hide")
								arg_469_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.0666666666666667 < arg_469_1.time_ and arg_469_1.time_ <= 0.0666666666666667 + arg_472_0 then
				arg_469_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_23 = 3.999999999999
			local var_472_24 = 0.4

			if 3.999999999999 < arg_469_1.time_ and arg_469_1.time_ <= var_472_23 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_25 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_25:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_469_1.dialogCg_.alpha = arg_475_0
				end))
				var_472_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_26 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1106102114).content)

				arg_469_1.text_.text = var_472_26

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_28 = 16 <= 0 and var_472_24 or var_472_24 * (utf8.len(var_472_26) / 16)

				if (16 <= 0 and var_472_24 or var_472_24 * (utf8.len(var_472_26) / 16)) > 0 and var_472_24 < var_472_28 then
					arg_469_1.talkMaxDuration = var_472_28
					var_472_23 = var_472_23 + 0.3

					if var_472_28 + var_472_23 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_28 + var_472_23
					end
				end

				arg_469_1.text_.text = var_472_26
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_29 = var_472_23 + 0.3
			local var_472_30 = math.max(var_472_24, arg_469_1.talkMaxDuration)

			if var_472_23 + 0.3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_29 + var_472_30 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_29) / var_472_30

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_29 + var_472_30 and arg_469_1.time_ < var_472_29 + var_472_30 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play1106102115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1106102115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1106102116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.6

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1106102115).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 24 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 24)

				if (24 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 24)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1106102116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1106102116
		arg_481_1.duration_ = 2.07

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1106102117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1061ui_story = arg_481_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1061ui_story"].transform.position).z)
				arg_481_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1061ui_story"].transform.localEulerAngles = arg_481_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_481_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1061ui_story"].transform.position).z)
				arg_481_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1061ui_story"].transform.localEulerAngles = arg_481_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1061ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1061ui_story == nil then
				arg_481_1.var_.characterEffect1061ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1061ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1061ui_story then
				arg_481_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_484_4 = 0
			local var_484_5 = 0.25

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_6 = arg_481_1:GetWordFromCfg(1106102116)
				local var_484_7 = arg_481_1:FormatText(var_484_6.content)

				arg_481_1.text_.text = var_484_7

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 10 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 10)

				if (10 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 10)) > 0 and var_484_5 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_7
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102116", "story_v_side_new_1106102.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102116", "story_v_side_new_1106102.awb") / 1000

					if var_484_10 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_4
					end

					if var_484_6.prefab_name ~= "" and arg_481_1.actors_[var_484_6.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_6.prefab_name].transform, "story_v_side_new_1106102", "1106102116", "story_v_side_new_1106102.awb")

						arg_481_1:RecordAudio("1106102116", var_484_11)
						arg_481_1:RecordAudio("1106102116", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102116", "story_v_side_new_1106102.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102116", "story_v_side_new_1106102.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_12 and arg_481_1.time_ < var_484_4 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1106102117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1106102117
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1106102118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1061ui_story"]) and arg_485_1.var_.characterEffect1061ui_story == nil then
				arg_485_1.var_.characterEffect1061ui_story = arg_485_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1061ui_story"]) then
				if arg_485_1.var_.characterEffect1061ui_story and not isNil(arg_485_1.actors_["1061ui_story"]) then
					arg_485_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_0)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1061ui_story"]) and arg_485_1.var_.characterEffect1061ui_story then
				arg_485_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_488_1 = 0
			local var_488_2 = 0.675

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1106102117).content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 27 <= 0 and var_488_2 or var_488_2 * (utf8.len(var_488_3) / 27)

				if (27 <= 0 and var_488_2 or var_488_2 * (utf8.len(var_488_3) / 27)) > 0 and var_488_2 < var_488_5 then
					arg_485_1.talkMaxDuration = var_488_5

					if var_488_5 + var_488_1 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + var_488_1
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_6 = math.max(var_488_2, arg_485_1.talkMaxDuration)

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_6 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_1) / var_488_6

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_1 + var_488_6 and arg_485_1.time_ < var_488_1 + var_488_6 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1106102118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1106102118
		arg_489_1.duration_ = 2.03

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1106102119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1061ui_story"]) and arg_489_1.var_.characterEffect1061ui_story == nil then
				arg_489_1.var_.characterEffect1061ui_story = arg_489_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1061ui_story"]) then
				if arg_489_1.var_.characterEffect1061ui_story and not isNil(arg_489_1.actors_["1061ui_story"]) then
					arg_489_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1061ui_story"]) and arg_489_1.var_.characterEffect1061ui_story then
				arg_489_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action425")
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_492_2 = 0
			local var_492_3 = 0.275

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_2 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_4 = arg_489_1:GetWordFromCfg(1106102118)
				local var_492_5 = arg_489_1:FormatText(var_492_4.content)

				arg_489_1.text_.text = var_492_5

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_7 = 11 <= 0 and var_492_3 or var_492_3 * (utf8.len(var_492_5) / 11)

				if (11 <= 0 and var_492_3 or var_492_3 * (utf8.len(var_492_5) / 11)) > 0 and var_492_3 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_2 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_2
					end
				end

				arg_489_1.text_.text = var_492_5
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102118", "story_v_side_new_1106102.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102118", "story_v_side_new_1106102.awb") / 1000

					if var_492_8 + var_492_2 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_2
					end

					if var_492_4.prefab_name ~= "" and arg_489_1.actors_[var_492_4.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_4.prefab_name].transform, "story_v_side_new_1106102", "1106102118", "story_v_side_new_1106102.awb")

						arg_489_1:RecordAudio("1106102118", var_492_9)
						arg_489_1:RecordAudio("1106102118", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102118", "story_v_side_new_1106102.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102118", "story_v_side_new_1106102.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_3, arg_489_1.talkMaxDuration)

			if var_492_2 <= arg_489_1.time_ and arg_489_1.time_ < var_492_2 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_2) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_2 + var_492_10 and arg_489_1.time_ < var_492_2 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1106102119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1106102119
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1106102120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1061ui_story = arg_493_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1061ui_story"].transform.position).z)
				arg_493_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1061ui_story"].transform.localEulerAngles = arg_493_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1061ui_story"].transform.position).z)
				arg_493_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1061ui_story"].transform.localEulerAngles = arg_493_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1061ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1061ui_story == nil then
				arg_493_1.var_.characterEffect1061ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1061ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_2)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1061ui_story then
				arg_493_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_doorbell02", "")
			end

			local var_496_4 = 0
			local var_496_5 = 0.7

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1106102119).content)

				arg_493_1.text_.text = var_496_6

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_8 = 28 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_6) / 28)

				if (28 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_6) / 28)) > 0 and var_496_5 < var_496_8 then
					arg_493_1.talkMaxDuration = var_496_8

					if var_496_8 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_6
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_9 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_9 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_9

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_9 and arg_493_1.time_ < var_496_4 + var_496_9 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1106102120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1106102120
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1106102121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.675

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1106102120).content)

				arg_497_1.text_.text = var_500_1

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_3 = 27 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 27)

				if (27 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_1) / 27)) > 0 and var_500_0 < var_500_3 then
					arg_497_1.talkMaxDuration = var_500_3

					if var_500_3 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_3 + 0
					end
				end

				arg_497_1.text_.text = var_500_1
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_4 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_4 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_4

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_4 and arg_497_1.time_ < 0 + var_500_4 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1106102121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1106102121
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1106102122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 1.225

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1106102121).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 49 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 49)

				if (49 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 49)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1106102122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1106102122
		arg_505_1.duration_ = 10

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1106102123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1061ui_story = arg_505_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_508_0 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 then
				arg_505_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_505_1.time_ - 0) / var_508_0)
				arg_505_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_505_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1061ui_story"].transform.position).z)
				arg_505_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_505_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_505_1.actors_["1061ui_story"].transform.localEulerAngles = arg_505_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 then
				arg_505_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_505_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_505_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1061ui_story"].transform.position).z)
				arg_505_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_505_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_505_1.actors_["1061ui_story"].transform.localEulerAngles = arg_505_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_508_1 = arg_505_1.actors_["1061ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_1) and arg_505_1.var_.characterEffect1061ui_story == nil then
				arg_505_1.var_.characterEffect1061ui_story = var_508_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_2 and not isNil(var_508_1) then
				if arg_505_1.var_.characterEffect1061ui_story and not isNil(var_508_1) then
					arg_505_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_2 and arg_505_1.time_ < 0 + var_508_2 + arg_508_0 and not isNil(var_508_1) and arg_505_1.var_.characterEffect1061ui_story then
				arg_505_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_508_4 = 0
			local var_508_5 = 1.225

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_6 = arg_505_1:GetWordFromCfg(1106102122)
				local var_508_7 = arg_505_1:FormatText(var_508_6.content)

				arg_505_1.text_.text = var_508_7

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_9 = 49 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 49)

				if (49 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 49)) > 0 and var_508_5 < var_508_9 then
					arg_505_1.talkMaxDuration = var_508_9

					if var_508_9 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_9 + var_508_4
					end
				end

				arg_505_1.text_.text = var_508_7
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102122", "story_v_side_new_1106102.awb") ~= 0 then
					local var_508_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102122", "story_v_side_new_1106102.awb") / 1000

					if var_508_10 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_10 + var_508_4
					end

					if var_508_6.prefab_name ~= "" and arg_505_1.actors_[var_508_6.prefab_name] ~= nil then
						local var_508_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_6.prefab_name].transform, "story_v_side_new_1106102", "1106102122", "story_v_side_new_1106102.awb")

						arg_505_1:RecordAudio("1106102122", var_508_11)
						arg_505_1:RecordAudio("1106102122", var_508_11)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102122", "story_v_side_new_1106102.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102122", "story_v_side_new_1106102.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_12 = math.max(var_508_5, arg_505_1.talkMaxDuration)

			if var_508_4 <= arg_505_1.time_ and arg_505_1.time_ < var_508_4 + var_508_12 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_4) / var_508_12

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_4 + var_508_12 and arg_505_1.time_ < var_508_4 + var_508_12 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play1106102123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1106102123
		arg_509_1.duration_ = 4.7

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1106102124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["1061ui_story"]) and arg_509_1.var_.characterEffect1061ui_story == nil then
				arg_509_1.var_.characterEffect1061ui_story = arg_509_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_0 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["1061ui_story"]) then
				if arg_509_1.var_.characterEffect1061ui_story and not isNil(arg_509_1.actors_["1061ui_story"]) then
					arg_509_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_0)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["1061ui_story"]) and arg_509_1.var_.characterEffect1061ui_story then
				arg_509_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_512_1 = 0
			local var_512_2 = 0.475

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_3 = arg_509_1:GetWordFromCfg(1106102123)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_6 = 19 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_4) / 19)

				if (19 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_4) / 19)) > 0 and var_512_2 < var_512_6 then
					arg_509_1.talkMaxDuration = var_512_6

					if var_512_6 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102123", "story_v_side_new_1106102.awb") ~= 0 then
					local var_512_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102123", "story_v_side_new_1106102.awb") / 1000

					if var_512_7 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_1
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_side_new_1106102", "1106102123", "story_v_side_new_1106102.awb")

						arg_509_1:RecordAudio("1106102123", var_512_8)
						arg_509_1:RecordAudio("1106102123", var_512_8)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102123", "story_v_side_new_1106102.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102123", "story_v_side_new_1106102.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_9 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_9 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_9

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_9 and arg_509_1.time_ < var_512_1 + var_512_9 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1106102124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1106102124
		arg_513_1.duration_ = 2

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1106102125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_516_0 = arg_513_1.actors_["1061ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1061ui_story == nil then
				arg_513_1.var_.characterEffect1061ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_1 = 0.2

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_1 and not isNil(var_516_0) then
				if arg_513_1.var_.characterEffect1061ui_story and not isNil(var_516_0) then
					arg_513_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_1 and arg_513_1.time_ < 0 + var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1061ui_story then
				arg_513_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_516_3 = 0
			local var_516_4 = 0.125

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_3 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[1354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_5 = arg_513_1:GetWordFromCfg(1106102124)
				local var_516_6 = arg_513_1:FormatText(var_516_5.content)

				arg_513_1.text_.text = var_516_6

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_8 = 5 <= 0 and var_516_4 or var_516_4 * (utf8.len(var_516_6) / 5)

				if (5 <= 0 and var_516_4 or var_516_4 * (utf8.len(var_516_6) / 5)) > 0 and var_516_4 < var_516_8 then
					arg_513_1.talkMaxDuration = var_516_8

					if var_516_8 + var_516_3 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_3
					end
				end

				arg_513_1.text_.text = var_516_6
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102124", "story_v_side_new_1106102.awb") ~= 0 then
					local var_516_9 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102124", "story_v_side_new_1106102.awb") / 1000

					if var_516_9 + var_516_3 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_3
					end

					if var_516_5.prefab_name ~= "" and arg_513_1.actors_[var_516_5.prefab_name] ~= nil then
						local var_516_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_5.prefab_name].transform, "story_v_side_new_1106102", "1106102124", "story_v_side_new_1106102.awb")

						arg_513_1:RecordAudio("1106102124", var_516_10)
						arg_513_1:RecordAudio("1106102124", var_516_10)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102124", "story_v_side_new_1106102.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102124", "story_v_side_new_1106102.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_11 = math.max(var_516_4, arg_513_1.talkMaxDuration)

			if var_516_3 <= arg_513_1.time_ and arg_513_1.time_ < var_516_3 + var_516_11 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_3) / var_516_11

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_3 + var_516_11 and arg_513_1.time_ < var_516_3 + var_516_11 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1106102125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1106102125
		arg_517_1.duration_ = 2

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1106102126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_1")
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_520_0 = 0
			local var_520_1 = 0.225

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[1354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_2 = arg_517_1:GetWordFromCfg(1106102125)
				local var_520_3 = arg_517_1:FormatText(var_520_2.content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 9 <= 0 and var_520_1 or var_520_1 * (utf8.len(var_520_3) / 9)

				if (9 <= 0 and var_520_1 or var_520_1 * (utf8.len(var_520_3) / 9)) > 0 and var_520_1 < var_520_5 then
					arg_517_1.talkMaxDuration = var_520_5

					if var_520_5 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102125", "story_v_side_new_1106102.awb") ~= 0 then
					local var_520_6 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102125", "story_v_side_new_1106102.awb") / 1000

					if var_520_6 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_0
					end

					if var_520_2.prefab_name ~= "" and arg_517_1.actors_[var_520_2.prefab_name] ~= nil then
						local var_520_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_2.prefab_name].transform, "story_v_side_new_1106102", "1106102125", "story_v_side_new_1106102.awb")

						arg_517_1:RecordAudio("1106102125", var_520_7)
						arg_517_1:RecordAudio("1106102125", var_520_7)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102125", "story_v_side_new_1106102.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102125", "story_v_side_new_1106102.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1106102126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1106102126
		arg_521_1.duration_ = 1.97

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1106102127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1061ui_story"]) and arg_521_1.var_.characterEffect1061ui_story == nil then
				arg_521_1.var_.characterEffect1061ui_story = arg_521_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1061ui_story"]) then
				if arg_521_1.var_.characterEffect1061ui_story and not isNil(arg_521_1.actors_["1061ui_story"]) then
					arg_521_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1061ui_story"]) and arg_521_1.var_.characterEffect1061ui_story then
				arg_521_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_524_1 = 0
			local var_524_2 = 0.2

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:GetWordFromCfg(1106102126)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_6 = 8 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_4) / 8)

				if (8 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_4) / 8)) > 0 and var_524_2 < var_524_6 then
					arg_521_1.talkMaxDuration = var_524_6

					if var_524_6 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_6 + var_524_1
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102126", "story_v_side_new_1106102.awb") ~= 0 then
					local var_524_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102126", "story_v_side_new_1106102.awb") / 1000

					if var_524_7 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_1
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_side_new_1106102", "1106102126", "story_v_side_new_1106102.awb")

						arg_521_1:RecordAudio("1106102126", var_524_8)
						arg_521_1:RecordAudio("1106102126", var_524_8)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102126", "story_v_side_new_1106102.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102126", "story_v_side_new_1106102.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_9 = math.max(var_524_2, arg_521_1.talkMaxDuration)

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_9 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_1) / var_524_9

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_1 + var_524_9 and arg_521_1.time_ < var_524_1 + var_524_9 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1106102127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1106102127
		arg_525_1.duration_ = 2

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1106102128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action496")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_528_0 = arg_525_1.actors_["1061ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1061ui_story == nil then
				arg_525_1.var_.characterEffect1061ui_story = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_1 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_1 and not isNil(var_528_0) then
				if arg_525_1.var_.characterEffect1061ui_story and not isNil(var_528_0) then
					arg_525_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_1 and arg_525_1.time_ < 0 + var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1061ui_story then
				arg_525_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_528_3 = 0
			local var_528_4 = 0.425

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_3 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[1354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_5 = arg_525_1:GetWordFromCfg(1106102127)
				local var_528_6 = arg_525_1:FormatText(var_528_5.content)

				arg_525_1.text_.text = var_528_6

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_8 = 17 <= 0 and var_528_4 or var_528_4 * (utf8.len(var_528_6) / 17)

				if (17 <= 0 and var_528_4 or var_528_4 * (utf8.len(var_528_6) / 17)) > 0 and var_528_4 < var_528_8 then
					arg_525_1.talkMaxDuration = var_528_8

					if var_528_8 + var_528_3 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_8 + var_528_3
					end
				end

				arg_525_1.text_.text = var_528_6
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102127", "story_v_side_new_1106102.awb") ~= 0 then
					local var_528_9 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102127", "story_v_side_new_1106102.awb") / 1000

					if var_528_9 + var_528_3 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_9 + var_528_3
					end

					if var_528_5.prefab_name ~= "" and arg_525_1.actors_[var_528_5.prefab_name] ~= nil then
						local var_528_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_5.prefab_name].transform, "story_v_side_new_1106102", "1106102127", "story_v_side_new_1106102.awb")

						arg_525_1:RecordAudio("1106102127", var_528_10)
						arg_525_1:RecordAudio("1106102127", var_528_10)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102127", "story_v_side_new_1106102.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102127", "story_v_side_new_1106102.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_11 = math.max(var_528_4, arg_525_1.talkMaxDuration)

			if var_528_3 <= arg_525_1.time_ and arg_525_1.time_ < var_528_3 + var_528_11 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_3) / var_528_11

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_3 + var_528_11 and arg_525_1.time_ < var_528_3 + var_528_11 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1106102128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1106102128
		arg_529_1.duration_ = 5.8

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1106102129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1061ui_story"]) and arg_529_1.var_.characterEffect1061ui_story == nil then
				arg_529_1.var_.characterEffect1061ui_story = arg_529_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.2

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1061ui_story"]) then
				if arg_529_1.var_.characterEffect1061ui_story and not isNil(arg_529_1.actors_["1061ui_story"]) then
					arg_529_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_0)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1061ui_story"]) and arg_529_1.var_.characterEffect1061ui_story then
				arg_529_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_532_1 = 0
			local var_532_2 = 0.725

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:GetWordFromCfg(1106102128)
				local var_532_4 = arg_529_1:FormatText(var_532_3.content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_6 = 29 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_4) / 29)

				if (29 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_4) / 29)) > 0 and var_532_2 < var_532_6 then
					arg_529_1.talkMaxDuration = var_532_6

					if var_532_6 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_1
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102128", "story_v_side_new_1106102.awb") ~= 0 then
					local var_532_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102128", "story_v_side_new_1106102.awb") / 1000

					if var_532_7 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_1
					end

					if var_532_3.prefab_name ~= "" and arg_529_1.actors_[var_532_3.prefab_name] ~= nil then
						local var_532_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_3.prefab_name].transform, "story_v_side_new_1106102", "1106102128", "story_v_side_new_1106102.awb")

						arg_529_1:RecordAudio("1106102128", var_532_8)
						arg_529_1:RecordAudio("1106102128", var_532_8)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102128", "story_v_side_new_1106102.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102128", "story_v_side_new_1106102.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_9 = math.max(var_532_2, arg_529_1.talkMaxDuration)

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_9 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_1) / var_532_9

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_1 + var_532_9 and arg_529_1.time_ < var_532_1 + var_532_9 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1106102129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1106102129
		arg_533_1.duration_ = 7

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1106102130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.925

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_1 = arg_533_1:GetWordFromCfg(1106102129)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 37 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 37)

				if (37 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 37)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102129", "story_v_side_new_1106102.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102129", "story_v_side_new_1106102.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_side_new_1106102", "1106102129", "story_v_side_new_1106102.awb")

						arg_533_1:RecordAudio("1106102129", var_536_6)
						arg_533_1:RecordAudio("1106102129", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102129", "story_v_side_new_1106102.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102129", "story_v_side_new_1106102.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1106102130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1106102130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1106102131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action6_2")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_540_0 = arg_537_1.actors_["1061ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1061ui_story == nil then
				arg_537_1.var_.characterEffect1061ui_story = var_540_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_1 = 0.2

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_1 and not isNil(var_540_0) then
				if arg_537_1.var_.characterEffect1061ui_story and not isNil(var_540_0) then
					arg_537_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_1 and arg_537_1.time_ < 0 + var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1061ui_story then
				arg_537_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_540_3 = 0
			local var_540_4 = 0.05

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_3 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[1354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_5 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1106102130).content)

				arg_537_1.text_.text = var_540_5

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 2 <= 0 and var_540_4 or var_540_4 * (utf8.len(var_540_5) / 2)

				if (2 <= 0 and var_540_4 or var_540_4 * (utf8.len(var_540_5) / 2)) > 0 and var_540_4 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_3 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_3
					end
				end

				arg_537_1.text_.text = var_540_5
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_4, arg_537_1.talkMaxDuration)

			if var_540_3 <= arg_537_1.time_ and arg_537_1.time_ < var_540_3 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_3) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_3 + var_540_8 and arg_537_1.time_ < var_540_3 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1106102131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1106102131
		arg_541_1.duration_ = 3.23

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1106102132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1061ui_story"]) and arg_541_1.var_.characterEffect1061ui_story == nil then
				arg_541_1.var_.characterEffect1061ui_story = arg_541_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_0 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1061ui_story"]) then
				if arg_541_1.var_.characterEffect1061ui_story and not isNil(arg_541_1.actors_["1061ui_story"]) then
					arg_541_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1061ui_story"]) and arg_541_1.var_.characterEffect1061ui_story then
				arg_541_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_544_2 = 0
			local var_544_3 = 0.325

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_2 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_4 = arg_541_1:GetWordFromCfg(1106102131)
				local var_544_5 = arg_541_1:FormatText(var_544_4.content)

				arg_541_1.text_.text = var_544_5

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_7 = 13 <= 0 and var_544_3 or var_544_3 * (utf8.len(var_544_5) / 13)

				if (13 <= 0 and var_544_3 or var_544_3 * (utf8.len(var_544_5) / 13)) > 0 and var_544_3 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_2 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_2
					end
				end

				arg_541_1.text_.text = var_544_5
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102131", "story_v_side_new_1106102.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102131", "story_v_side_new_1106102.awb") / 1000

					if var_544_8 + var_544_2 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_2
					end

					if var_544_4.prefab_name ~= "" and arg_541_1.actors_[var_544_4.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_4.prefab_name].transform, "story_v_side_new_1106102", "1106102131", "story_v_side_new_1106102.awb")

						arg_541_1:RecordAudio("1106102131", var_544_9)
						arg_541_1:RecordAudio("1106102131", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102131", "story_v_side_new_1106102.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102131", "story_v_side_new_1106102.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_3, arg_541_1.talkMaxDuration)

			if var_544_2 <= arg_541_1.time_ and arg_541_1.time_ < var_544_2 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_2) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_2 + var_544_10 and arg_541_1.time_ < var_544_2 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1106102132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1106102132
		arg_545_1.duration_ = 4.23

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1106102133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["1061ui_story"]) and arg_545_1.var_.characterEffect1061ui_story == nil then
				arg_545_1.var_.characterEffect1061ui_story = arg_545_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_0 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["1061ui_story"]) then
				if arg_545_1.var_.characterEffect1061ui_story and not isNil(arg_545_1.actors_["1061ui_story"]) then
					arg_545_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_545_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_545_1.time_ - 0) / var_548_0)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["1061ui_story"]) and arg_545_1.var_.characterEffect1061ui_story then
				arg_545_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_545_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_548_1 = 0
			local var_548_2 = 0.55

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:GetWordFromCfg(1106102132)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_6 = 22 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_4) / 22)

				if (22 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_4) / 22)) > 0 and var_548_2 < var_548_6 then
					arg_545_1.talkMaxDuration = var_548_6

					if var_548_6 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_1
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102132", "story_v_side_new_1106102.awb") ~= 0 then
					local var_548_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102132", "story_v_side_new_1106102.awb") / 1000

					if var_548_7 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_1
					end

					if var_548_3.prefab_name ~= "" and arg_545_1.actors_[var_548_3.prefab_name] ~= nil then
						local var_548_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_3.prefab_name].transform, "story_v_side_new_1106102", "1106102132", "story_v_side_new_1106102.awb")

						arg_545_1:RecordAudio("1106102132", var_548_8)
						arg_545_1:RecordAudio("1106102132", var_548_8)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102132", "story_v_side_new_1106102.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102132", "story_v_side_new_1106102.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_9 = math.max(var_548_2, arg_545_1.talkMaxDuration)

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_9 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_1) / var_548_9

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_1 + var_548_9 and arg_545_1.time_ < var_548_1 + var_548_9 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1106102133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1106102133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1106102134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1061ui_story = arg_549_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_552_0 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 then
				arg_549_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_549_1.time_ - 0) / var_552_0)
				arg_549_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1061ui_story"].transform.position).z)
				arg_549_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1061ui_story"].transform.localEulerAngles = arg_549_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 then
				arg_549_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_549_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1061ui_story"].transform.position).z)
				arg_549_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1061ui_story"].transform.localEulerAngles = arg_549_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_552_1 = 0
			local var_552_2 = 0.5

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1106102133).content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 20 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 20)

				if (20 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 20)) > 0 and var_552_2 < var_552_5 then
					arg_549_1.talkMaxDuration = var_552_5

					if var_552_5 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_6 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_6 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_6

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_6 and arg_549_1.time_ < var_552_1 + var_552_6 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	Play1106102134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1106102134
		arg_553_1.duration_ = 3.6

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1106102135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0.325

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_1 = arg_553_1:GetWordFromCfg(1106102134)
				local var_556_2 = arg_553_1:FormatText(var_556_1.content)

				arg_553_1.text_.text = var_556_2

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 13 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_2) / 13)

				if (13 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_2) / 13)) > 0 and var_556_0 < var_556_4 then
					arg_553_1.talkMaxDuration = var_556_4

					if var_556_4 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_4 + 0
					end
				end

				arg_553_1.text_.text = var_556_2
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102134", "story_v_side_new_1106102.awb") ~= 0 then
					local var_556_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102134", "story_v_side_new_1106102.awb") / 1000

					if var_556_5 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + 0
					end

					if var_556_1.prefab_name ~= "" and arg_553_1.actors_[var_556_1.prefab_name] ~= nil then
						local var_556_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_1.prefab_name].transform, "story_v_side_new_1106102", "1106102134", "story_v_side_new_1106102.awb")

						arg_553_1:RecordAudio("1106102134", var_556_6)
						arg_553_1:RecordAudio("1106102134", var_556_6)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102134", "story_v_side_new_1106102.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102134", "story_v_side_new_1106102.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_7 and arg_553_1.time_ < 0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1106102135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1106102135
		arg_557_1.duration_ = 4.07

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1106102136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.55

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_1 = arg_557_1:GetWordFromCfg(1106102135)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 22 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 22)

				if (22 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 22)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102135", "story_v_side_new_1106102.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102135", "story_v_side_new_1106102.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_side_new_1106102", "1106102135", "story_v_side_new_1106102.awb")

						arg_557_1:RecordAudio("1106102135", var_560_6)
						arg_557_1:RecordAudio("1106102135", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102135", "story_v_side_new_1106102.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102135", "story_v_side_new_1106102.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1106102136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1106102136
		arg_561_1.duration_ = 6.1

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1106102137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.8

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_1 = arg_561_1:GetWordFromCfg(1106102136)
				local var_564_2 = arg_561_1:FormatText(var_564_1.content)

				arg_561_1.text_.text = var_564_2

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 32 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 32)

				if (32 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 32)) > 0 and var_564_0 < var_564_4 then
					arg_561_1.talkMaxDuration = var_564_4

					if var_564_4 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_4 + 0
					end
				end

				arg_561_1.text_.text = var_564_2
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102136", "story_v_side_new_1106102.awb") ~= 0 then
					local var_564_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102136", "story_v_side_new_1106102.awb") / 1000

					if var_564_5 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + 0
					end

					if var_564_1.prefab_name ~= "" and arg_561_1.actors_[var_564_1.prefab_name] ~= nil then
						local var_564_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_1.prefab_name].transform, "story_v_side_new_1106102", "1106102136", "story_v_side_new_1106102.awb")

						arg_561_1:RecordAudio("1106102136", var_564_6)
						arg_561_1:RecordAudio("1106102136", var_564_6)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102136", "story_v_side_new_1106102.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102136", "story_v_side_new_1106102.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_7 and arg_561_1.time_ < 0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1106102137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1106102137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1106102138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0.45

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_1 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(1106102137).content)

				arg_565_1.text_.text = var_568_1

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_3 = 18 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_1) / 18)

				if (18 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_1) / 18)) > 0 and var_568_0 < var_568_3 then
					arg_565_1.talkMaxDuration = var_568_3

					if var_568_3 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_3 + 0
					end
				end

				arg_565_1.text_.text = var_568_1
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_4 = math.max(var_568_0, arg_565_1.talkMaxDuration)

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_4 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - 0) / var_568_4

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= 0 + var_568_4 and arg_565_1.time_ < 0 + var_568_4 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1106102138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1106102138
		arg_569_1.duration_ = 3.57

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1106102139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.35

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_1 = arg_569_1:GetWordFromCfg(1106102138)
				local var_572_2 = arg_569_1:FormatText(var_572_1.content)

				arg_569_1.text_.text = var_572_2

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 14 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 14)

				if (14 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 14)) > 0 and var_572_0 < var_572_4 then
					arg_569_1.talkMaxDuration = var_572_4

					if var_572_4 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_4 + 0
					end
				end

				arg_569_1.text_.text = var_572_2
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102138", "story_v_side_new_1106102.awb") ~= 0 then
					local var_572_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102138", "story_v_side_new_1106102.awb") / 1000

					if var_572_5 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + 0
					end

					if var_572_1.prefab_name ~= "" and arg_569_1.actors_[var_572_1.prefab_name] ~= nil then
						local var_572_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_1.prefab_name].transform, "story_v_side_new_1106102", "1106102138", "story_v_side_new_1106102.awb")

						arg_569_1:RecordAudio("1106102138", var_572_6)
						arg_569_1:RecordAudio("1106102138", var_572_6)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102138", "story_v_side_new_1106102.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102138", "story_v_side_new_1106102.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1106102139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1106102139
		arg_573_1.duration_ = 2

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1106102140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1061ui_story = arg_573_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_576_0 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 then
				arg_573_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_573_1.time_ - 0) / var_576_0)
				arg_573_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1061ui_story"].transform.position).z)
				arg_573_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1061ui_story"].transform.localEulerAngles = arg_573_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 then
				arg_573_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_573_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1061ui_story"].transform.position).z)
				arg_573_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1061ui_story"].transform.localEulerAngles = arg_573_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_576_1 = arg_573_1.actors_["1061ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_1) and arg_573_1.var_.characterEffect1061ui_story == nil then
				arg_573_1.var_.characterEffect1061ui_story = var_576_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_2 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_2 and not isNil(var_576_1) then
				if arg_573_1.var_.characterEffect1061ui_story and not isNil(var_576_1) then
					arg_573_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= 0 + var_576_2 and arg_573_1.time_ < 0 + var_576_2 + arg_576_0 and not isNil(var_576_1) and arg_573_1.var_.characterEffect1061ui_story then
				arg_573_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action434")
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_576_4 = 0
			local var_576_5 = 0.1

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_6 = arg_573_1:GetWordFromCfg(1106102139)
				local var_576_7 = arg_573_1:FormatText(var_576_6.content)

				arg_573_1.text_.text = var_576_7

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_9 = 4 <= 0 and var_576_5 or var_576_5 * (utf8.len(var_576_7) / 4)

				if (4 <= 0 and var_576_5 or var_576_5 * (utf8.len(var_576_7) / 4)) > 0 and var_576_5 < var_576_9 then
					arg_573_1.talkMaxDuration = var_576_9

					if var_576_9 + var_576_4 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_9 + var_576_4
					end
				end

				arg_573_1.text_.text = var_576_7
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102139", "story_v_side_new_1106102.awb") ~= 0 then
					local var_576_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102139", "story_v_side_new_1106102.awb") / 1000

					if var_576_10 + var_576_4 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_10 + var_576_4
					end

					if var_576_6.prefab_name ~= "" and arg_573_1.actors_[var_576_6.prefab_name] ~= nil then
						local var_576_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_6.prefab_name].transform, "story_v_side_new_1106102", "1106102139", "story_v_side_new_1106102.awb")

						arg_573_1:RecordAudio("1106102139", var_576_11)
						arg_573_1:RecordAudio("1106102139", var_576_11)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102139", "story_v_side_new_1106102.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102139", "story_v_side_new_1106102.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_12 = math.max(var_576_5, arg_573_1.talkMaxDuration)

			if var_576_4 <= arg_573_1.time_ and arg_573_1.time_ < var_576_4 + var_576_12 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_4) / var_576_12

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_4 + var_576_12 and arg_573_1.time_ < var_576_4 + var_576_12 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play1106102140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1106102140
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1106102141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos1061ui_story = arg_577_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_580_0 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 then
				arg_577_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_577_1.time_ - 0) / var_580_0)
				arg_577_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1061ui_story"].transform.position).z)
				arg_577_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["1061ui_story"].transform.localEulerAngles = arg_577_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 then
				arg_577_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_577_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1061ui_story"].transform.position).z)
				arg_577_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["1061ui_story"].transform.localEulerAngles = arg_577_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_580_1 = arg_577_1.actors_["1061ui_story"]

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(var_580_1) and arg_577_1.var_.characterEffect1061ui_story == nil then
				arg_577_1.var_.characterEffect1061ui_story = var_580_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_2 and not isNil(var_580_1) then
				if arg_577_1.var_.characterEffect1061ui_story and not isNil(var_580_1) then
					arg_577_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_2)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_2 and arg_577_1.time_ < 0 + var_580_2 + arg_580_0 and not isNil(var_580_1) and arg_577_1.var_.characterEffect1061ui_story then
				arg_577_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_580_3 = 0
			local var_580_4 = 0.875

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_3 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_5 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(1106102140).content)

				arg_577_1.text_.text = var_580_5

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_7 = 35 <= 0 and var_580_4 or var_580_4 * (utf8.len(var_580_5) / 35)

				if (35 <= 0 and var_580_4 or var_580_4 * (utf8.len(var_580_5) / 35)) > 0 and var_580_4 < var_580_7 then
					arg_577_1.talkMaxDuration = var_580_7

					if var_580_7 + var_580_3 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_7 + var_580_3
					end
				end

				arg_577_1.text_.text = var_580_5
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_8 = math.max(var_580_4, arg_577_1.talkMaxDuration)

			if var_580_3 <= arg_577_1.time_ and arg_577_1.time_ < var_580_3 + var_580_8 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_3) / var_580_8

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_3 + var_580_8 and arg_577_1.time_ < var_580_3 + var_580_8 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play1106102141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1106102141
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1106102142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0.425

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, false)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_1 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(1106102141).content)

				arg_581_1.text_.text = var_584_1

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_3 = 17 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_1) / 17)

				if (17 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_1) / 17)) > 0 and var_584_0 < var_584_3 then
					arg_581_1.talkMaxDuration = var_584_3

					if var_584_3 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_3 + 0
					end
				end

				arg_581_1.text_.text = var_584_1
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_4 = math.max(var_584_0, arg_581_1.talkMaxDuration)

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_4 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - 0) / var_584_4

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= 0 + var_584_4 and arg_581_1.time_ < 0 + var_584_4 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1106102142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1106102142
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1106102143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.475

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
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

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1106102142).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 19 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 19)

				if (19 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 19)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1106102143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1106102143
		arg_589_1.duration_ = 7.93

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1106102144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos1061ui_story = arg_589_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_592_0 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 then
				arg_589_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_589_1.time_ - 0) / var_592_0)
				arg_589_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1061ui_story"].transform.position).z)
				arg_589_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1061ui_story"].transform.localEulerAngles = arg_589_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 then
				arg_589_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_589_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1061ui_story"].transform.position).z)
				arg_589_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1061ui_story"].transform.localEulerAngles = arg_589_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_592_1 = arg_589_1.actors_["1061ui_story"]

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(var_592_1) and arg_589_1.var_.characterEffect1061ui_story == nil then
				arg_589_1.var_.characterEffect1061ui_story = var_592_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_2 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_2 and not isNil(var_592_1) then
				if arg_589_1.var_.characterEffect1061ui_story and not isNil(var_592_1) then
					arg_589_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= 0 + var_592_2 and arg_589_1.time_ < 0 + var_592_2 + arg_592_0 and not isNil(var_592_1) and arg_589_1.var_.characterEffect1061ui_story then
				arg_589_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_592_4 = 0
			local var_592_5 = 0.775

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_4 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_6 = arg_589_1:GetWordFromCfg(1106102143)
				local var_592_7 = arg_589_1:FormatText(var_592_6.content)

				arg_589_1.text_.text = var_592_7

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_9 = 31 <= 0 and var_592_5 or var_592_5 * (utf8.len(var_592_7) / 31)

				if (31 <= 0 and var_592_5 or var_592_5 * (utf8.len(var_592_7) / 31)) > 0 and var_592_5 < var_592_9 then
					arg_589_1.talkMaxDuration = var_592_9

					if var_592_9 + var_592_4 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_9 + var_592_4
					end
				end

				arg_589_1.text_.text = var_592_7
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102143", "story_v_side_new_1106102.awb") ~= 0 then
					local var_592_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102143", "story_v_side_new_1106102.awb") / 1000

					if var_592_10 + var_592_4 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_10 + var_592_4
					end

					if var_592_6.prefab_name ~= "" and arg_589_1.actors_[var_592_6.prefab_name] ~= nil then
						local var_592_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_6.prefab_name].transform, "story_v_side_new_1106102", "1106102143", "story_v_side_new_1106102.awb")

						arg_589_1:RecordAudio("1106102143", var_592_11)
						arg_589_1:RecordAudio("1106102143", var_592_11)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102143", "story_v_side_new_1106102.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102143", "story_v_side_new_1106102.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_12 = math.max(var_592_5, arg_589_1.talkMaxDuration)

			if var_592_4 <= arg_589_1.time_ and arg_589_1.time_ < var_592_4 + var_592_12 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_4) / var_592_12

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_4 + var_592_12 and arg_589_1.time_ < var_592_4 + var_592_12 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play1106102144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1106102144
		arg_593_1.duration_ = 2.7

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1106102145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.325

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:GetWordFromCfg(1106102144)
				local var_596_2 = arg_593_1:FormatText(var_596_1.content)

				arg_593_1.text_.text = var_596_2

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_4 = 13 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 13)

				if (13 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 13)) > 0 and var_596_0 < var_596_4 then
					arg_593_1.talkMaxDuration = var_596_4

					if var_596_4 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_4 + 0
					end
				end

				arg_593_1.text_.text = var_596_2
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102144", "story_v_side_new_1106102.awb") ~= 0 then
					local var_596_5 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102144", "story_v_side_new_1106102.awb") / 1000

					if var_596_5 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_5 + 0
					end

					if var_596_1.prefab_name ~= "" and arg_593_1.actors_[var_596_1.prefab_name] ~= nil then
						local var_596_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_1.prefab_name].transform, "story_v_side_new_1106102", "1106102144", "story_v_side_new_1106102.awb")

						arg_593_1:RecordAudio("1106102144", var_596_6)
						arg_593_1:RecordAudio("1106102144", var_596_6)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102144", "story_v_side_new_1106102.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102144", "story_v_side_new_1106102.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_7 and arg_593_1.time_ < 0 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1106102145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1106102145
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1106102146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1061ui_story"]) and arg_597_1.var_.characterEffect1061ui_story == nil then
				arg_597_1.var_.characterEffect1061ui_story = arg_597_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_0 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1061ui_story"]) then
				if arg_597_1.var_.characterEffect1061ui_story and not isNil(arg_597_1.actors_["1061ui_story"]) then
					arg_597_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_597_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_597_1.time_ - 0) / var_600_0)
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1061ui_story"]) and arg_597_1.var_.characterEffect1061ui_story then
				arg_597_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_597_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_600_1 = 0
			local var_600_2 = 0.525

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, true)
				arg_597_1.iconController_:SetSelectedState("hero")

				arg_597_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_597_1.callingController_:SetSelectedState("normal")

				arg_597_1.keyicon_.color = Color.New(1, 1, 1)
				arg_597_1.icon_.color = Color.New(1, 1, 1)

				local var_600_3 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(1106102145).content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 21 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 21)

				if (21 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 21)) > 0 and var_600_2 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_6 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_6 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_6

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_6 and arg_597_1.time_ < var_600_1 + var_600_6 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1106102146 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1106102146
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1106102147(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.var_.moveOldPos1061ui_story = arg_601_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_604_0 = 0.001

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 then
				arg_601_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_601_1.time_ - 0) / var_604_0)
				arg_601_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1061ui_story"].transform.position).z)
				arg_601_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1061ui_story"].transform.localEulerAngles = arg_601_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 then
				arg_601_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_601_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1061ui_story"].transform.position).z)
				arg_601_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1061ui_story"].transform.localEulerAngles = arg_601_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_604_1 = 0
			local var_604_2 = 0.55

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(1106102146).content)

				arg_601_1.text_.text = var_604_3

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 22 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 22)

				if (22 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 22)) > 0 and var_604_2 < var_604_5 then
					arg_601_1.talkMaxDuration = var_604_5

					if var_604_5 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + var_604_1
					end
				end

				arg_601_1.text_.text = var_604_3
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_6 = math.max(var_604_2, arg_601_1.talkMaxDuration)

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_6 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_1) / var_604_6

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_1 + var_604_6 and arg_601_1.time_ < var_604_1 + var_604_6 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_601_1:InitPlayNodeList()
	end,
	Play1106102147 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1106102147
		arg_605_1.duration_ = 2.27

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1106102148(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.var_.moveOldPos1061ui_story = arg_605_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_608_0 = 0.001

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_0 then
				arg_605_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_605_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_605_1.time_ - 0) / var_608_0)
				arg_605_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_605_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_605_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_605_1.actors_["1061ui_story"].transform.position).z)
				arg_605_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_605_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_605_1.actors_["1061ui_story"].transform.localEulerAngles = arg_605_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_605_1.time_ >= 0 + var_608_0 and arg_605_1.time_ < 0 + var_608_0 + arg_608_0 then
				arg_605_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_605_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_605_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_605_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_605_1.actors_["1061ui_story"].transform.position).z)
				arg_605_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_605_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_605_1.actors_["1061ui_story"].transform.localEulerAngles = arg_605_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_608_1 = arg_605_1.actors_["1061ui_story"]

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 and not isNil(var_608_1) and arg_605_1.var_.characterEffect1061ui_story == nil then
				arg_605_1.var_.characterEffect1061ui_story = var_608_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_2 = 0.200000002980232

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_2 and not isNil(var_608_1) then
				if arg_605_1.var_.characterEffect1061ui_story and not isNil(var_608_1) then
					arg_605_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= 0 + var_608_2 and arg_605_1.time_ < 0 + var_608_2 + arg_608_0 and not isNil(var_608_1) and arg_605_1.var_.characterEffect1061ui_story then
				arg_605_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_608_4 = 0
			local var_608_5 = 0.225

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_4 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_6 = arg_605_1:GetWordFromCfg(1106102147)
				local var_608_7 = arg_605_1:FormatText(var_608_6.content)

				arg_605_1.text_.text = var_608_7

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_9 = 9 <= 0 and var_608_5 or var_608_5 * (utf8.len(var_608_7) / 9)

				if (9 <= 0 and var_608_5 or var_608_5 * (utf8.len(var_608_7) / 9)) > 0 and var_608_5 < var_608_9 then
					arg_605_1.talkMaxDuration = var_608_9

					if var_608_9 + var_608_4 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_9 + var_608_4
					end
				end

				arg_605_1.text_.text = var_608_7
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102147", "story_v_side_new_1106102.awb") ~= 0 then
					local var_608_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102147", "story_v_side_new_1106102.awb") / 1000

					if var_608_10 + var_608_4 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_10 + var_608_4
					end

					if var_608_6.prefab_name ~= "" and arg_605_1.actors_[var_608_6.prefab_name] ~= nil then
						local var_608_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_6.prefab_name].transform, "story_v_side_new_1106102", "1106102147", "story_v_side_new_1106102.awb")

						arg_605_1:RecordAudio("1106102147", var_608_11)
						arg_605_1:RecordAudio("1106102147", var_608_11)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102147", "story_v_side_new_1106102.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102147", "story_v_side_new_1106102.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_12 = math.max(var_608_5, arg_605_1.talkMaxDuration)

			if var_608_4 <= arg_605_1.time_ and arg_605_1.time_ < var_608_4 + var_608_12 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_4) / var_608_12

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_4 + var_608_12 and arg_605_1.time_ < var_608_4 + var_608_12 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_605_1:InitPlayNodeList()
	end,
	Play1106102148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1106102148
		arg_609_1.duration_ = 7.07

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1106102149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.var_.moveOldPos1061ui_story = arg_609_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_612_0 = 0.001

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_0 then
				arg_609_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_609_1.time_ - 0) / var_612_0)
				arg_609_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1061ui_story"].transform.position).z)
				arg_609_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["1061ui_story"].transform.localEulerAngles = arg_609_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_609_1.time_ >= 0 + var_612_0 and arg_609_1.time_ < 0 + var_612_0 + arg_612_0 then
				arg_609_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_609_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1061ui_story"].transform.position).z)
				arg_609_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["1061ui_story"].transform.localEulerAngles = arg_609_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action486")
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_612_1 = 0
			local var_612_2 = 0.9

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_3 = arg_609_1:GetWordFromCfg(1106102148)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_6 = 36 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_4) / 36)

				if (36 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_4) / 36)) > 0 and var_612_2 < var_612_6 then
					arg_609_1.talkMaxDuration = var_612_6

					if var_612_6 + var_612_1 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_6 + var_612_1
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102148", "story_v_side_new_1106102.awb") ~= 0 then
					local var_612_7 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102148", "story_v_side_new_1106102.awb") / 1000

					if var_612_7 + var_612_1 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_7 + var_612_1
					end

					if var_612_3.prefab_name ~= "" and arg_609_1.actors_[var_612_3.prefab_name] ~= nil then
						local var_612_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_3.prefab_name].transform, "story_v_side_new_1106102", "1106102148", "story_v_side_new_1106102.awb")

						arg_609_1:RecordAudio("1106102148", var_612_8)
						arg_609_1:RecordAudio("1106102148", var_612_8)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102148", "story_v_side_new_1106102.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102148", "story_v_side_new_1106102.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_9 = math.max(var_612_2, arg_609_1.talkMaxDuration)

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_9 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_1) / var_612_9

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_1 + var_612_9 and arg_609_1.time_ < var_612_1 + var_612_9 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play1106102149 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1106102149
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1106102150(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.var_.moveOldPos1061ui_story = arg_613_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_616_0 = 0.001

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 then
				arg_613_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_613_1.time_ - 0) / var_616_0)
				arg_613_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_613_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1061ui_story"].transform.position).z)
				arg_613_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_613_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_613_1.actors_["1061ui_story"].transform.localEulerAngles = arg_613_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 then
				arg_613_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_613_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_613_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1061ui_story"].transform.position).z)
				arg_613_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_613_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_613_1.actors_["1061ui_story"].transform.localEulerAngles = arg_613_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_616_1 = arg_613_1.actors_["1061ui_story"]

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(var_616_1) and arg_613_1.var_.characterEffect1061ui_story == nil then
				arg_613_1.var_.characterEffect1061ui_story = var_616_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_2 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_2 and not isNil(var_616_1) then
				if arg_613_1.var_.characterEffect1061ui_story and not isNil(var_616_1) then
					arg_613_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_613_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_613_1.time_ - 0) / var_616_2)
				end
			end

			if arg_613_1.time_ >= 0 + var_616_2 and arg_613_1.time_ < 0 + var_616_2 + arg_616_0 and not isNil(var_616_1) and arg_613_1.var_.characterEffect1061ui_story then
				arg_613_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_613_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_616_3 = 0
			local var_616_4 = 0.275

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_3 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_5 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1106102149).content)

				arg_613_1.text_.text = var_616_5

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_7 = 11 <= 0 and var_616_4 or var_616_4 * (utf8.len(var_616_5) / 11)

				if (11 <= 0 and var_616_4 or var_616_4 * (utf8.len(var_616_5) / 11)) > 0 and var_616_4 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_3 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_3
					end
				end

				arg_613_1.text_.text = var_616_5
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_4, arg_613_1.talkMaxDuration)

			if var_616_3 <= arg_613_1.time_ and arg_613_1.time_ < var_616_3 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_3) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_3 + var_616_8 and arg_613_1.time_ < var_616_3 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_613_1:InitPlayNodeList()
	end,
	Play1106102150 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1106102150
		arg_617_1.duration_ = 3.47

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
			arg_617_1.auto_ = false
		end

		function arg_617_1.playNext_(arg_619_0)
			arg_617_1.onStoryFinished_()
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.var_.moveOldPos1061ui_story = arg_617_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_620_0 = 0.001

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 then
				arg_617_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_617_1.time_ - 0) / var_620_0)
				arg_617_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1061ui_story"].transform.position).z)
				arg_617_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["1061ui_story"].transform.localEulerAngles = arg_617_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 then
				arg_617_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_617_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1061ui_story"].transform.position).z)
				arg_617_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["1061ui_story"].transform.localEulerAngles = arg_617_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_620_1 = arg_617_1.actors_["1061ui_story"]

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect1061ui_story == nil then
				arg_617_1.var_.characterEffect1061ui_story = var_620_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_2 and not isNil(var_620_1) then
				if arg_617_1.var_.characterEffect1061ui_story and not isNil(var_620_1) then
					arg_617_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 0 + var_620_2 and arg_617_1.time_ < 0 + var_620_2 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect1061ui_story then
				arg_617_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action6_2")
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_620_4 = 0
			local var_620_5 = 0.475

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_4 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_6 = arg_617_1:GetWordFromCfg(1106102150)
				local var_620_7 = arg_617_1:FormatText(var_620_6.content)

				arg_617_1.text_.text = var_620_7

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_9 = 19 <= 0 and var_620_5 or var_620_5 * (utf8.len(var_620_7) / 19)

				if (19 <= 0 and var_620_5 or var_620_5 * (utf8.len(var_620_7) / 19)) > 0 and var_620_5 < var_620_9 then
					arg_617_1.talkMaxDuration = var_620_9

					if var_620_9 + var_620_4 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_9 + var_620_4
					end
				end

				arg_617_1.text_.text = var_620_7
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102150", "story_v_side_new_1106102.awb") ~= 0 then
					local var_620_10 = manager.audio:GetVoiceLength("story_v_side_new_1106102", "1106102150", "story_v_side_new_1106102.awb") / 1000

					if var_620_10 + var_620_4 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_10 + var_620_4
					end

					if var_620_6.prefab_name ~= "" and arg_617_1.actors_[var_620_6.prefab_name] ~= nil then
						local var_620_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_6.prefab_name].transform, "story_v_side_new_1106102", "1106102150", "story_v_side_new_1106102.awb")

						arg_617_1:RecordAudio("1106102150", var_620_11)
						arg_617_1:RecordAudio("1106102150", var_620_11)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1106102", "1106102150", "story_v_side_new_1106102.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1106102", "1106102150", "story_v_side_new_1106102.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_12 = math.max(var_620_5, arg_617_1.talkMaxDuration)

			if var_620_4 <= arg_617_1.time_ and arg_617_1.time_ < var_620_4 + var_620_12 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_4) / var_620_12

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_4 + var_620_12 and arg_617_1.time_ < var_620_4 + var_620_12 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST39",
		"TextureConfig/Background/H03",
		"TextureConfig/Background/H03a",
		"TextureConfig/Background/ST29a",
		"TextureConfig/Background/ST37"
	},
	voices = {
		"story_v_side_new_1106102.awb"
	}
}
