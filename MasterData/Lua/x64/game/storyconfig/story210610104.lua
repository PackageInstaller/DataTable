return {
	Play1106104001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106104001
		arg_1_1.duration_ = 6.13

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106104002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST47a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47a")
				var_4_0.name = "ST47a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST47a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST47a

				arg_1_1.bgs_.ST47a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST47a" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 2
			local var_4_18 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1359].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_20 = arg_1_1:GetWordFromCfg(1106104001)
				local var_4_21 = arg_1_1:FormatText(var_4_20.content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 19 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 19)

				if (19 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 19)) > 0 and var_4_18 < var_4_23 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104001", "story_v_side_new_1106104.awb") ~= 0 then
					local var_4_24 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104001", "story_v_side_new_1106104.awb") / 1000

					if var_4_24 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_17
					end

					if var_4_20.prefab_name ~= "" and arg_1_1.actors_[var_4_20.prefab_name] ~= nil then
						local var_4_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_20.prefab_name].transform, "story_v_side_new_1106104", "1106104001", "story_v_side_new_1106104.awb")

						arg_1_1:RecordAudio("1106104001", var_4_25)
						arg_1_1:RecordAudio("1106104001", var_4_25)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104001", "story_v_side_new_1106104.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104001", "story_v_side_new_1106104.awb")
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
	Play1106104002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106104002
		arg_9_1.duration_ = 6.13

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106104003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1359].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(1106104002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 25 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 25)

				if (25 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 25)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104002", "story_v_side_new_1106104.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104002", "story_v_side_new_1106104.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_side_new_1106104", "1106104002", "story_v_side_new_1106104.awb")

						arg_9_1:RecordAudio("1106104002", var_12_6)
						arg_9_1:RecordAudio("1106104002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104002", "story_v_side_new_1106104.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104002", "story_v_side_new_1106104.awb")
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
	Play1106104003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106104003
		arg_13_1.duration_ = 5.5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1106104004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1359].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(1106104003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 14 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 14)

				if (14 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 14)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104003", "story_v_side_new_1106104.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104003", "story_v_side_new_1106104.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_new_1106104", "1106104003", "story_v_side_new_1106104.awb")

						arg_13_1:RecordAudio("1106104003", var_16_6)
						arg_13_1:RecordAudio("1106104003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104003", "story_v_side_new_1106104.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104003", "story_v_side_new_1106104.awb")
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
	Play1106104004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106104004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1106104005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1106104004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 40 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 40)

				if (40 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 40)) > 0 and var_20_0 < var_20_3 then
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
	Play1106104005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106104005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1106104006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1106104005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 25 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 25)

				if (25 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 25)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1106104006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106104006
		arg_25_1.duration_ = 2.93

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1106104007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_28_0 = 0.6

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				local var_28_1, var_28_2 = math.modf((arg_25_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_28_2 * 0.13, var_28_2 * 0.13, var_28_2 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				manager.ui.mainCamera.transform.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_3 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_3 + 0.6 and arg_25_1.time_ < var_28_3 + 0.6 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_4 = 0
			local var_28_5 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1358].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_6 = arg_25_1:GetWordFromCfg(1106104006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 9)

				if (9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 9)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104006", "story_v_side_new_1106104.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104006", "story_v_side_new_1106104.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_new_1106104", "1106104006", "story_v_side_new_1106104.awb")

						arg_25_1:RecordAudio("1106104006", var_28_11)
						arg_25_1:RecordAudio("1106104006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104006", "story_v_side_new_1106104.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104006", "story_v_side_new_1106104.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1106104007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106104007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1106104008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1106104007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 12 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 12)

				if (12 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 12)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1106104008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106104008
		arg_33_1.duration_ = 2.8

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106104009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["106101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "106101ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "106101ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "106101ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["106101ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["106101ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["106101ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["106101ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["106101ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos106101ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["106101ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect106101ui_story == nil then
				arg_33_1.var_.characterEffect106101ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect106101ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect106101ui_story then
				arg_33_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_36_8 = 0
			local var_36_9 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(1106104008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 15 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 15)

				if (15 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 15)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104008", "story_v_side_new_1106104.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104008", "story_v_side_new_1106104.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_side_new_1106104", "1106104008", "story_v_side_new_1106104.awb")

						arg_33_1:RecordAudio("1106104008", var_36_15)
						arg_33_1:RecordAudio("1106104008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104008", "story_v_side_new_1106104.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104008", "story_v_side_new_1106104.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play1106104009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106104009
		arg_37_1.duration_ = 6.63

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1106104010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.875

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
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

				local var_40_1 = arg_37_1:GetWordFromCfg(1106104009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 35 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 35)

				if (35 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 35)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104009", "story_v_side_new_1106104.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104009", "story_v_side_new_1106104.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_side_new_1106104", "1106104009", "story_v_side_new_1106104.awb")

						arg_37_1:RecordAudio("1106104009", var_40_6)
						arg_37_1:RecordAudio("1106104009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104009", "story_v_side_new_1106104.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104009", "story_v_side_new_1106104.awb")
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
	Play1106104010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106104010
		arg_41_1.duration_ = 5.57

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1106104011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos106101ui_story = arg_41_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["106101ui_story"].transform.position).z)
				arg_41_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["106101ui_story"].transform.localEulerAngles = arg_41_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_41_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["106101ui_story"].transform.position).z)
				arg_41_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["106101ui_story"].transform.localEulerAngles = arg_41_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_44_1 = 0
			local var_44_2 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(1106104010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 27 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 27)

				if (27 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 27)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104010", "story_v_side_new_1106104.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104010", "story_v_side_new_1106104.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_new_1106104", "1106104010", "story_v_side_new_1106104.awb")

						arg_41_1:RecordAudio("1106104010", var_44_8)
						arg_41_1:RecordAudio("1106104010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104010", "story_v_side_new_1106104.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104010", "story_v_side_new_1106104.awb")
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
				actorName = "106101ui_story",
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
	Play1106104011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106104011
		arg_45_1.duration_ = 2.83

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1106104012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
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

				local var_48_1 = arg_45_1:GetWordFromCfg(1106104011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 11 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 11)

				if (11 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 11)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104011", "story_v_side_new_1106104.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104011", "story_v_side_new_1106104.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_new_1106104", "1106104011", "story_v_side_new_1106104.awb")

						arg_45_1:RecordAudio("1106104011", var_48_6)
						arg_45_1:RecordAudio("1106104011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104011", "story_v_side_new_1106104.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104011", "story_v_side_new_1106104.awb")
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
	Play1106104012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106104012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1106104013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos106101ui_story = arg_49_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["106101ui_story"].transform.position).z)
				arg_49_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["106101ui_story"].transform.localEulerAngles = arg_49_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["106101ui_story"].transform.position).z)
				arg_49_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["106101ui_story"].transform.localEulerAngles = arg_49_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["106101ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect106101ui_story == nil then
				arg_49_1.var_.characterEffect106101ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect106101ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_49_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect106101ui_story then
				arg_49_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_49_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_52_3 = 0
			local var_52_4 = 1.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1106104012).content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 47 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 47)

				if (47 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 47)) > 0 and var_52_4 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_8 and arg_49_1.time_ < var_52_3 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1106104013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106104013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1106104014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.025

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1106104013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 41 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 41)

				if (41 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 41)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1106104014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106104014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1106104015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.95

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

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(1106104014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 38 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 38)

				if (38 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 38)) > 0 and var_60_0 < var_60_3 then
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
	Play1106104015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106104015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1106104016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos106101ui_story = arg_61_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["106101ui_story"].transform.position).z)
				arg_61_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["106101ui_story"].transform.localEulerAngles = arg_61_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_61_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["106101ui_story"].transform.position).z)
				arg_61_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["106101ui_story"].transform.localEulerAngles = arg_61_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["106101ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect106101ui_story == nil then
				arg_61_1.var_.characterEffect106101ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect106101ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect106101ui_story then
				arg_61_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_4 = 0
			local var_64_5 = 0.2

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
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

				local var_64_6 = arg_61_1:GetWordFromCfg(1106104015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 8 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 8)

				if (8 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 8)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104015", "story_v_side_new_1106104.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104015", "story_v_side_new_1106104.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_side_new_1106104", "1106104015", "story_v_side_new_1106104.awb")

						arg_61_1:RecordAudio("1106104015", var_64_11)
						arg_61_1:RecordAudio("1106104015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104015", "story_v_side_new_1106104.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104015", "story_v_side_new_1106104.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play1106104016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106104016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1106104017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["106101ui_story"]) and arg_65_1.var_.characterEffect106101ui_story == nil then
				arg_65_1.var_.characterEffect106101ui_story = arg_65_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["106101ui_story"]) then
				if arg_65_1.var_.characterEffect106101ui_story and not isNil(arg_65_1.actors_["106101ui_story"]) then
					arg_65_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_65_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["106101ui_story"]) and arg_65_1.var_.characterEffect106101ui_story then
				arg_65_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_65_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1106104016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 13 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 13)

				if (13 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 13)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1106104017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106104017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106104018(arg_69_1)
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

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1106104017).content)

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
	Play1106104018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106104018
		arg_73_1.duration_ = 4.03

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1106104019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["106101ui_story"]) and arg_73_1.var_.characterEffect106101ui_story == nil then
				arg_73_1.var_.characterEffect106101ui_story = arg_73_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["106101ui_story"]) then
				if arg_73_1.var_.characterEffect106101ui_story and not isNil(arg_73_1.actors_["106101ui_story"]) then
					arg_73_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["106101ui_story"]) and arg_73_1.var_.characterEffect106101ui_story then
				arg_73_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_2 = 0
			local var_76_3 = 0.55

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
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

				local var_76_4 = arg_73_1:GetWordFromCfg(1106104018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 22 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 22)

				if (22 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 22)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104018", "story_v_side_new_1106104.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104018", "story_v_side_new_1106104.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1106104", "1106104018", "story_v_side_new_1106104.awb")

						arg_73_1:RecordAudio("1106104018", var_76_9)
						arg_73_1:RecordAudio("1106104018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104018", "story_v_side_new_1106104.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104018", "story_v_side_new_1106104.awb")
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

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1106104019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106104019
		arg_77_1.duration_ = 4.1

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106104020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
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

				local var_80_1 = arg_77_1:GetWordFromCfg(1106104019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 20 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 20)

				if (20 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 20)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104019", "story_v_side_new_1106104.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104019", "story_v_side_new_1106104.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_side_new_1106104", "1106104019", "story_v_side_new_1106104.awb")

						arg_77_1:RecordAudio("1106104019", var_80_6)
						arg_77_1:RecordAudio("1106104019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104019", "story_v_side_new_1106104.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104019", "story_v_side_new_1106104.awb")
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
	Play1106104020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106104020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1106104021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["106101ui_story"]) and arg_81_1.var_.characterEffect106101ui_story == nil then
				arg_81_1.var_.characterEffect106101ui_story = arg_81_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["106101ui_story"]) then
				if arg_81_1.var_.characterEffect106101ui_story and not isNil(arg_81_1.actors_["106101ui_story"]) then
					arg_81_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_81_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["106101ui_story"]) and arg_81_1.var_.characterEffect106101ui_story then
				arg_81_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_81_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1106104020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 25 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 25)

				if (25 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 25)) > 0 and var_84_2 < var_84_5 then
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
	Play1106104021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106104021
		arg_85_1.duration_ = 3.3

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1106104022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["106101ui_story"]) and arg_85_1.var_.characterEffect106101ui_story == nil then
				arg_85_1.var_.characterEffect106101ui_story = arg_85_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["106101ui_story"]) then
				if arg_85_1.var_.characterEffect106101ui_story and not isNil(arg_85_1.actors_["106101ui_story"]) then
					arg_85_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["106101ui_story"]) and arg_85_1.var_.characterEffect106101ui_story then
				arg_85_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_88_2 = 0
			local var_88_3 = 0.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
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

				local var_88_4 = arg_85_1:GetWordFromCfg(1106104021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 15 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 15)

				if (15 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 15)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104021", "story_v_side_new_1106104.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104021", "story_v_side_new_1106104.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_side_new_1106104", "1106104021", "story_v_side_new_1106104.awb")

						arg_85_1:RecordAudio("1106104021", var_88_9)
						arg_85_1:RecordAudio("1106104021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104021", "story_v_side_new_1106104.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104021", "story_v_side_new_1106104.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1106104022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106104022
		arg_89_1.duration_ = 9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1106104023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_0 = arg_89_1.bgs_.ST47a

				arg_89_1.bgs_.ST47a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_1 = var_92_0:GetComponent("SpriteRenderer")

				if var_92_1 and var_92_1.sprite then
					local var_92_2 = 2 * (var_92_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_0.transform.localScale = Vector3.New(var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "ST47a" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_3 = 3.999999999999

			if 3.999999999999 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_3 + 0.3 and arg_89_1.time_ < var_92_3 + 0.3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_4 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_5 = 2

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_5 then
				local var_92_6 = Color.New(0, 0, 0)

				var_92_6.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_4) / var_92_5)
				arg_89_1.mask_.color = var_92_6
			end

			if arg_89_1.time_ >= var_92_4 + var_92_5 and arg_89_1.time_ < var_92_4 + var_92_5 + arg_92_0 then
				local var_92_7 = Color.New(0, 0, 0)

				var_92_7.a = 1
				arg_89_1.mask_.color = var_92_7
			end

			local var_92_8 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_9 = 2

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 then
				local var_92_10 = Color.New(0, 0, 0)

				var_92_10.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_8) / var_92_9)
				arg_89_1.mask_.color = var_92_10
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 then
				local var_92_11 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_11.a = 0
				arg_89_1.mask_.color = var_92_11
			end

			local var_92_12 = arg_89_1.actors_["106101ui_story"].transform

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 then
				arg_89_1.var_.moveOldPos106101ui_story = var_92_12.localPosition
			end

			local var_92_13 = 0.001

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_13 then
				var_92_12.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 1.96599999815226) / var_92_13)
				var_92_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_12.position).x, (manager.ui.mainCamera.transform.position - var_92_12.position).y, (manager.ui.mainCamera.transform.position - var_92_12.position).z)
				var_92_12.localEulerAngles.z = 0
				var_92_12.localEulerAngles.x = 0
				var_92_12.localEulerAngles = var_92_12.localEulerAngles
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_13 and arg_89_1.time_ < 1.96599999815226 + var_92_13 + arg_92_0 then
				var_92_12.localPosition = Vector3.New(0, 100, 0)
				var_92_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_12.position).x, (manager.ui.mainCamera.transform.position - var_92_12.position).y, (manager.ui.mainCamera.transform.position - var_92_12.position).z)
				var_92_12.localEulerAngles.z = 0
				var_92_12.localEulerAngles.x = 0
				var_92_12.localEulerAngles = var_92_12.localEulerAngles
			end

			local var_92_14 = arg_89_1.actors_["106101ui_story"]

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.characterEffect106101ui_story == nil then
				arg_89_1.var_.characterEffect106101ui_story = var_92_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_15 = 0.034000001847744

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_15 and not isNil(var_92_14) then
				if arg_89_1.var_.characterEffect106101ui_story and not isNil(var_92_14) then
					arg_89_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_89_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 1.96599999815226) / var_92_15)
				end
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_15 and arg_89_1.time_ < 1.96599999815226 + var_92_15 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.characterEffect106101ui_story then
				arg_89_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_89_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_16 = 3.999999999999
			local var_92_17 = 1.025

			if 3.999999999999 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_18 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_18:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_19 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1106104022).content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_21 = 41 <= 0 and var_92_17 or var_92_17 * (utf8.len(var_92_19) / 41)

				if (41 <= 0 and var_92_17 or var_92_17 * (utf8.len(var_92_19) / 41)) > 0 and var_92_17 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21
					var_92_16 = var_92_16 + 0.3

					if var_92_21 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_16
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = var_92_16 + 0.3
			local var_92_23 = math.max(var_92_17, arg_89_1.talkMaxDuration)

			if var_92_16 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_22 + var_92_23 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_22) / var_92_23

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_22 + var_92_23 and arg_89_1.time_ < var_92_22 + var_92_23 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1106104023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1106104023
		arg_95_1.duration_ = 9.2

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1106104024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos106101ui_story = arg_95_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["106101ui_story"].transform.position).z)
				arg_95_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["106101ui_story"].transform.localEulerAngles = arg_95_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_95_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["106101ui_story"].transform.position).z)
				arg_95_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["106101ui_story"].transform.localEulerAngles = arg_95_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["106101ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect106101ui_story == nil then
				arg_95_1.var_.characterEffect106101ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect106101ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect106101ui_story then
				arg_95_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_4 = 0
			local var_98_5 = 1.15

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(1106104023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 46 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 46)

				if (46 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 46)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104023", "story_v_side_new_1106104.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104023", "story_v_side_new_1106104.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_side_new_1106104", "1106104023", "story_v_side_new_1106104.awb")

						arg_95_1:RecordAudio("1106104023", var_98_11)
						arg_95_1:RecordAudio("1106104023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104023", "story_v_side_new_1106104.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104023", "story_v_side_new_1106104.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1106104024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1106104024
		arg_99_1.duration_ = 10.07

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1106104025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.2

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(1106104024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 48 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 48)

				if (48 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 48)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104024", "story_v_side_new_1106104.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104024", "story_v_side_new_1106104.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_side_new_1106104", "1106104024", "story_v_side_new_1106104.awb")

						arg_99_1:RecordAudio("1106104024", var_102_6)
						arg_99_1:RecordAudio("1106104024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104024", "story_v_side_new_1106104.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104024", "story_v_side_new_1106104.awb")
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
	Play1106104025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1106104025
		arg_103_1.duration_ = 5.4

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1106104026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_106_0 = 0
			local var_106_1 = 0.725

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(1106104025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 29 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 29)

				if (29 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 29)) > 0 and var_106_1 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104025", "story_v_side_new_1106104.awb") ~= 0 then
					local var_106_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104025", "story_v_side_new_1106104.awb") / 1000

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end

					if var_106_2.prefab_name ~= "" and arg_103_1.actors_[var_106_2.prefab_name] ~= nil then
						local var_106_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_2.prefab_name].transform, "story_v_side_new_1106104", "1106104025", "story_v_side_new_1106104.awb")

						arg_103_1:RecordAudio("1106104025", var_106_7)
						arg_103_1:RecordAudio("1106104025", var_106_7)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104025", "story_v_side_new_1106104.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104025", "story_v_side_new_1106104.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1106104026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1106104026
		arg_107_1.duration_ = 5.07

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1106104027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_110_0 = 0
			local var_110_1 = 0.375

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(1106104026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 15 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 15)

				if (15 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 15)) > 0 and var_110_1 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104026", "story_v_side_new_1106104.awb") ~= 0 then
					local var_110_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104026", "story_v_side_new_1106104.awb") / 1000

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end

					if var_110_2.prefab_name ~= "" and arg_107_1.actors_[var_110_2.prefab_name] ~= nil then
						local var_110_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_2.prefab_name].transform, "story_v_side_new_1106104", "1106104026", "story_v_side_new_1106104.awb")

						arg_107_1:RecordAudio("1106104026", var_110_7)
						arg_107_1:RecordAudio("1106104026", var_110_7)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104026", "story_v_side_new_1106104.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104026", "story_v_side_new_1106104.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_8 and arg_107_1.time_ < var_110_0 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1106104027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1106104027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1106104028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["106101ui_story"]) and arg_111_1.var_.characterEffect106101ui_story == nil then
				arg_111_1.var_.characterEffect106101ui_story = arg_111_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["106101ui_story"]) then
				if arg_111_1.var_.characterEffect106101ui_story and not isNil(arg_111_1.actors_["106101ui_story"]) then
					arg_111_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_111_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["106101ui_story"]) and arg_111_1.var_.characterEffect106101ui_story then
				arg_111_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_111_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.325

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1106104027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 13 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 13)

				if (13 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 13)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1106104028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1106104028
		arg_115_1.duration_ = 5.17

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1106104029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["106101ui_story"]) and arg_115_1.var_.characterEffect106101ui_story == nil then
				arg_115_1.var_.characterEffect106101ui_story = arg_115_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["106101ui_story"]) then
				if arg_115_1.var_.characterEffect106101ui_story and not isNil(arg_115_1.actors_["106101ui_story"]) then
					arg_115_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["106101ui_story"]) and arg_115_1.var_.characterEffect106101ui_story then
				arg_115_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_118_2 = 0
			local var_118_3 = 0.675

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(1106104028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 27 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 27)

				if (27 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 27)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104028", "story_v_side_new_1106104.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104028", "story_v_side_new_1106104.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_side_new_1106104", "1106104028", "story_v_side_new_1106104.awb")

						arg_115_1:RecordAudio("1106104028", var_118_9)
						arg_115_1:RecordAudio("1106104028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104028", "story_v_side_new_1106104.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104028", "story_v_side_new_1106104.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1106104029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1106104029
		arg_119_1.duration_ = 4.93

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1106104030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.675

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(1106104029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 27 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 27)

				if (27 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 27)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104029", "story_v_side_new_1106104.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104029", "story_v_side_new_1106104.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_side_new_1106104", "1106104029", "story_v_side_new_1106104.awb")

						arg_119_1:RecordAudio("1106104029", var_122_6)
						arg_119_1:RecordAudio("1106104029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104029", "story_v_side_new_1106104.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104029", "story_v_side_new_1106104.awb")
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
	Play1106104030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1106104030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1106104031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos106101ui_story = arg_123_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["106101ui_story"].transform.position).z)
				arg_123_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["106101ui_story"].transform.localEulerAngles = arg_123_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["106101ui_story"].transform.position).z)
				arg_123_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["106101ui_story"].transform.localEulerAngles = arg_123_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["106101ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect106101ui_story == nil then
				arg_123_1.var_.characterEffect106101ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect106101ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_123_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_2)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect106101ui_story then
				arg_123_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_123_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_126_3 = 0
			local var_126_4 = 0.95

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1106104030).content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 38 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_5) / 38)

				if (38 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_5) / 38)) > 0 and var_126_4 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_8 and arg_123_1.time_ < var_126_3 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play1106104031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1106104031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1106104032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.85

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1106104031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 34 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 34)

				if (34 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 34)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1106104032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1106104032
		arg_131_1.duration_ = 4.8

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1106104033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos106101ui_story = arg_131_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["106101ui_story"].transform.position).z)
				arg_131_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["106101ui_story"].transform.localEulerAngles = arg_131_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_131_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["106101ui_story"].transform.position).z)
				arg_131_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["106101ui_story"].transform.localEulerAngles = arg_131_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["106101ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect106101ui_story == nil then
				arg_131_1.var_.characterEffect106101ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect106101ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect106101ui_story then
				arg_131_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action435")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_134_4 = 0
			local var_134_5 = 0.625

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(1106104032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 25 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 25)

				if (25 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 25)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104032", "story_v_side_new_1106104.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104032", "story_v_side_new_1106104.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_new_1106104", "1106104032", "story_v_side_new_1106104.awb")

						arg_131_1:RecordAudio("1106104032", var_134_11)
						arg_131_1:RecordAudio("1106104032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104032", "story_v_side_new_1106104.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104032", "story_v_side_new_1106104.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1106104033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1106104033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1106104034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["106101ui_story"]) and arg_135_1.var_.characterEffect106101ui_story == nil then
				arg_135_1.var_.characterEffect106101ui_story = arg_135_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["106101ui_story"]) then
				if arg_135_1.var_.characterEffect106101ui_story and not isNil(arg_135_1.actors_["106101ui_story"]) then
					arg_135_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_135_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["106101ui_story"]) and arg_135_1.var_.characterEffect106101ui_story then
				arg_135_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_135_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.25

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1106104033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 10 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 10)

				if (10 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 10)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1106104034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1106104034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1106104035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos106101ui_story = arg_139_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["106101ui_story"].transform.position).z)
				arg_139_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["106101ui_story"].transform.localEulerAngles = arg_139_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["106101ui_story"].transform.position).z)
				arg_139_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["106101ui_story"].transform.localEulerAngles = arg_139_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_142_1 = 0
			local var_142_2 = 0.7

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1106104034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 28 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 28)

				if (28 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 28)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play1106104035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1106104035
		arg_143_1.duration_ = 3.27

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1106104036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos106101ui_story = arg_143_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["106101ui_story"].transform.position).z)
				arg_143_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["106101ui_story"].transform.localEulerAngles = arg_143_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_143_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["106101ui_story"].transform.position).z)
				arg_143_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["106101ui_story"].transform.localEulerAngles = arg_143_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["106101ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect106101ui_story == nil then
				arg_143_1.var_.characterEffect106101ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect106101ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect106101ui_story then
				arg_143_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_4 = 0
			local var_146_5 = 0.55

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(1106104035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 22 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 22)

				if (22 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 22)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104035", "story_v_side_new_1106104.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104035", "story_v_side_new_1106104.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_side_new_1106104", "1106104035", "story_v_side_new_1106104.awb")

						arg_143_1:RecordAudio("1106104035", var_146_11)
						arg_143_1:RecordAudio("1106104035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104035", "story_v_side_new_1106104.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104035", "story_v_side_new_1106104.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play1106104036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106104036
		arg_147_1.duration_ = 4.6

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106104037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.45

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
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

				local var_150_1 = arg_147_1:GetWordFromCfg(1106104036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 18 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 18)

				if (18 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 18)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104036", "story_v_side_new_1106104.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104036", "story_v_side_new_1106104.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_side_new_1106104", "1106104036", "story_v_side_new_1106104.awb")

						arg_147_1:RecordAudio("1106104036", var_150_6)
						arg_147_1:RecordAudio("1106104036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104036", "story_v_side_new_1106104.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104036", "story_v_side_new_1106104.awb")
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
	Play1106104037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1106104037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1106104038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["106101ui_story"]) and arg_151_1.var_.characterEffect106101ui_story == nil then
				arg_151_1.var_.characterEffect106101ui_story = arg_151_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["106101ui_story"]) then
				if arg_151_1.var_.characterEffect106101ui_story and not isNil(arg_151_1.actors_["106101ui_story"]) then
					arg_151_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_151_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["106101ui_story"]) and arg_151_1.var_.characterEffect106101ui_story then
				arg_151_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_151_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.375

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

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1106104037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 15 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 15)

				if (15 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 15)) > 0 and var_154_2 < var_154_5 then
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
	Play1106104038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1106104038
		arg_155_1.duration_ = 2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1106104039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["106101ui_story"]) and arg_155_1.var_.characterEffect106101ui_story == nil then
				arg_155_1.var_.characterEffect106101ui_story = arg_155_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["106101ui_story"]) then
				if arg_155_1.var_.characterEffect106101ui_story and not isNil(arg_155_1.actors_["106101ui_story"]) then
					arg_155_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["106101ui_story"]) and arg_155_1.var_.characterEffect106101ui_story then
				arg_155_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_2 = 0
			local var_158_3 = 0.175

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

				local var_158_4 = arg_155_1:GetWordFromCfg(1106104038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 7 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 7)

				if (7 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 7)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104038", "story_v_side_new_1106104.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104038", "story_v_side_new_1106104.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_side_new_1106104", "1106104038", "story_v_side_new_1106104.awb")

						arg_155_1:RecordAudio("1106104038", var_158_9)
						arg_155_1:RecordAudio("1106104038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104038", "story_v_side_new_1106104.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104038", "story_v_side_new_1106104.awb")
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
	Play1106104039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106104039
		arg_159_1.duration_ = 1

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"

			SetActive(arg_159_1.choicesGo_, true)

			for iter_160_0, iter_160_1 in ipairs(arg_159_1.choices_) do
				SetActive(iter_160_1.go, iter_160_0 <= 2)
			end

			arg_159_1.choices_[1].txt.text = arg_159_1:FormatText(StoryChoiceCfg[1394].name)
			arg_159_1.choices_[2].txt.text = arg_159_1:FormatText(StoryChoiceCfg[1395].name)
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106104040(arg_159_1)
			end

			if arg_161_0 == 2 then
				arg_159_0:Play1106104042(arg_159_1)
			end

			arg_159_1:RecordChoiceLog(1106104039, 1394, 1395)
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["106101ui_story"]) and arg_159_1.var_.characterEffect106101ui_story == nil then
				arg_159_1.var_.characterEffect106101ui_story = arg_159_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["106101ui_story"]) then
				if arg_159_1.var_.characterEffect106101ui_story and not isNil(arg_159_1.actors_["106101ui_story"]) then
					arg_159_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_159_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["106101ui_story"]) and arg_159_1.var_.characterEffect106101ui_story then
				arg_159_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_159_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_1 + 0.6 and arg_159_1.time_ < var_162_1 + 0.6 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1106104040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106104040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106104041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.5

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1106104040).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 20 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 20)

				if (20 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 20)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1106104041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106104041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106104043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1106104041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 17)

				if (17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 17)) > 0 and var_170_0 < var_170_3 then
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
	Play1106104043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106104043
		arg_171_1.duration_ = 7.93

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1106104044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_174_0 = arg_171_1.actors_["106101ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect106101ui_story == nil then
				arg_171_1.var_.characterEffect106101ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_1 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 and not isNil(var_174_0) then
				if arg_171_1.var_.characterEffect106101ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect106101ui_story then
				arg_171_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_174_3 = 0
			local var_174_4 = 0.925

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:GetWordFromCfg(1106104043)
				local var_174_6 = arg_171_1:FormatText(var_174_5.content)

				arg_171_1.text_.text = var_174_6

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_8 = 37 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_6) / 37)

				if (37 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_6) / 37)) > 0 and var_174_4 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_6
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104043", "story_v_side_new_1106104.awb") ~= 0 then
					local var_174_9 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104043", "story_v_side_new_1106104.awb") / 1000

					if var_174_9 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_3
					end

					if var_174_5.prefab_name ~= "" and arg_171_1.actors_[var_174_5.prefab_name] ~= nil then
						local var_174_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_5.prefab_name].transform, "story_v_side_new_1106104", "1106104043", "story_v_side_new_1106104.awb")

						arg_171_1:RecordAudio("1106104043", var_174_10)
						arg_171_1:RecordAudio("1106104043", var_174_10)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104043", "story_v_side_new_1106104.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104043", "story_v_side_new_1106104.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_11 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_11 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_11

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_11 and arg_171_1.time_ < var_174_3 + var_174_11 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1106104044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106104044
		arg_175_1.duration_ = 3.8

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106104045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(1106104044)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 12 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 12)

				if (12 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 12)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104044", "story_v_side_new_1106104.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104044", "story_v_side_new_1106104.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_side_new_1106104", "1106104044", "story_v_side_new_1106104.awb")

						arg_175_1:RecordAudio("1106104044", var_178_6)
						arg_175_1:RecordAudio("1106104044", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104044", "story_v_side_new_1106104.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104044", "story_v_side_new_1106104.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1106104045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106104045
		arg_179_1.duration_ = 4.73

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1106104046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.575

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
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

				local var_182_1 = arg_179_1:GetWordFromCfg(1106104045)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 23 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 23)

				if (23 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 23)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104045", "story_v_side_new_1106104.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104045", "story_v_side_new_1106104.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_side_new_1106104", "1106104045", "story_v_side_new_1106104.awb")

						arg_179_1:RecordAudio("1106104045", var_182_6)
						arg_179_1:RecordAudio("1106104045", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104045", "story_v_side_new_1106104.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104045", "story_v_side_new_1106104.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1106104046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106104046
		arg_183_1.duration_ = 5.1

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1106104047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.5

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(1106104046)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 20 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 20)

				if (20 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 20)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104046", "story_v_side_new_1106104.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104046", "story_v_side_new_1106104.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_side_new_1106104", "1106104046", "story_v_side_new_1106104.awb")

						arg_183_1:RecordAudio("1106104046", var_186_6)
						arg_183_1:RecordAudio("1106104046", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104046", "story_v_side_new_1106104.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104046", "story_v_side_new_1106104.awb")
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
	Play1106104047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106104047
		arg_187_1.duration_ = 8.63

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106104048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.875

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
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

				local var_190_1 = arg_187_1:GetWordFromCfg(1106104047)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 35 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 35)

				if (35 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 35)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104047", "story_v_side_new_1106104.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104047", "story_v_side_new_1106104.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_side_new_1106104", "1106104047", "story_v_side_new_1106104.awb")

						arg_187_1:RecordAudio("1106104047", var_190_6)
						arg_187_1:RecordAudio("1106104047", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104047", "story_v_side_new_1106104.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104047", "story_v_side_new_1106104.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1106104048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106104048
		arg_191_1.duration_ = 8.03

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1106104049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_0 = 0
			local var_194_1 = 0.95

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

				local var_194_2 = arg_191_1:GetWordFromCfg(1106104048)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 38 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 38)

				if (38 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 38)) > 0 and var_194_1 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104048", "story_v_side_new_1106104.awb") ~= 0 then
					local var_194_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104048", "story_v_side_new_1106104.awb") / 1000

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end

					if var_194_2.prefab_name ~= "" and arg_191_1.actors_[var_194_2.prefab_name] ~= nil then
						local var_194_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_2.prefab_name].transform, "story_v_side_new_1106104", "1106104048", "story_v_side_new_1106104.awb")

						arg_191_1:RecordAudio("1106104048", var_194_7)
						arg_191_1:RecordAudio("1106104048", var_194_7)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104048", "story_v_side_new_1106104.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104048", "story_v_side_new_1106104.awb")
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
	Play1106104049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1106104049
		arg_195_1.duration_ = 7.73

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1106104050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.925

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(1106104049)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 37 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 37)

				if (37 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 37)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104049", "story_v_side_new_1106104.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104049", "story_v_side_new_1106104.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_side_new_1106104", "1106104049", "story_v_side_new_1106104.awb")

						arg_195_1:RecordAudio("1106104049", var_198_6)
						arg_195_1:RecordAudio("1106104049", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104049", "story_v_side_new_1106104.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104049", "story_v_side_new_1106104.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1106104050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1106104050
		arg_199_1.duration_ = 8.2

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1106104051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_0 = 0
			local var_202_1 = 1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
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

				local var_202_2 = arg_199_1:GetWordFromCfg(1106104050)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 40 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_3) / 40)

				if (40 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_3) / 40)) > 0 and var_202_1 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104050", "story_v_side_new_1106104.awb") ~= 0 then
					local var_202_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104050", "story_v_side_new_1106104.awb") / 1000

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end

					if var_202_2.prefab_name ~= "" and arg_199_1.actors_[var_202_2.prefab_name] ~= nil then
						local var_202_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_2.prefab_name].transform, "story_v_side_new_1106104", "1106104050", "story_v_side_new_1106104.awb")

						arg_199_1:RecordAudio("1106104050", var_202_7)
						arg_199_1:RecordAudio("1106104050", var_202_7)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104050", "story_v_side_new_1106104.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104050", "story_v_side_new_1106104.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1106104051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1106104051
		arg_203_1.duration_ = 4.37

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1106104052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
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

				local var_206_1 = arg_203_1:GetWordFromCfg(1106104051)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)

				if (20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104051", "story_v_side_new_1106104.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104051", "story_v_side_new_1106104.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_side_new_1106104", "1106104051", "story_v_side_new_1106104.awb")

						arg_203_1:RecordAudio("1106104051", var_206_6)
						arg_203_1:RecordAudio("1106104051", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104051", "story_v_side_new_1106104.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104051", "story_v_side_new_1106104.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1106104052 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1106104052
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1106104053(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["106101ui_story"]) and arg_207_1.var_.characterEffect106101ui_story == nil then
				arg_207_1.var_.characterEffect106101ui_story = arg_207_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["106101ui_story"]) then
				if arg_207_1.var_.characterEffect106101ui_story and not isNil(arg_207_1.actors_["106101ui_story"]) then
					arg_207_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_207_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["106101ui_story"]) and arg_207_1.var_.characterEffect106101ui_story then
				arg_207_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_207_1.var_.characterEffect106101ui_story.fillRatio = 0.5
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

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1106104052).content)

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
	Play1106104053 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1106104053
		arg_211_1.duration_ = 2.2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1106104054(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["106101ui_story"]) and arg_211_1.var_.characterEffect106101ui_story == nil then
				arg_211_1.var_.characterEffect106101ui_story = arg_211_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["106101ui_story"]) then
				if arg_211_1.var_.characterEffect106101ui_story and not isNil(arg_211_1.actors_["106101ui_story"]) then
					arg_211_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["106101ui_story"]) and arg_211_1.var_.characterEffect106101ui_story then
				arg_211_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_214_2 = 0
			local var_214_3 = 0.3

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
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

				local var_214_4 = arg_211_1:GetWordFromCfg(1106104053)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 12 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 12)

				if (12 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 12)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104053", "story_v_side_new_1106104.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104053", "story_v_side_new_1106104.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_side_new_1106104", "1106104053", "story_v_side_new_1106104.awb")

						arg_211_1:RecordAudio("1106104053", var_214_9)
						arg_211_1:RecordAudio("1106104053", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104053", "story_v_side_new_1106104.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104053", "story_v_side_new_1106104.awb")
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
	Play1106104054 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1106104054
		arg_215_1.duration_ = 7.1

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1106104055(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.85

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
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

				local var_218_1 = arg_215_1:GetWordFromCfg(1106104054)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 34 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 34)

				if (34 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 34)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104054", "story_v_side_new_1106104.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104054", "story_v_side_new_1106104.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_side_new_1106104", "1106104054", "story_v_side_new_1106104.awb")

						arg_215_1:RecordAudio("1106104054", var_218_6)
						arg_215_1:RecordAudio("1106104054", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104054", "story_v_side_new_1106104.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104054", "story_v_side_new_1106104.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1106104055 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1106104055
		arg_219_1.duration_ = 5.17

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1106104056(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_0 = 0
			local var_222_1 = 0.6

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
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

				local var_222_2 = arg_219_1:GetWordFromCfg(1106104055)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 24 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 24)

				if (24 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 24)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104055", "story_v_side_new_1106104.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104055", "story_v_side_new_1106104.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_side_new_1106104", "1106104055", "story_v_side_new_1106104.awb")

						arg_219_1:RecordAudio("1106104055", var_222_7)
						arg_219_1:RecordAudio("1106104055", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104055", "story_v_side_new_1106104.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104055", "story_v_side_new_1106104.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1106104056 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1106104056
		arg_223_1.duration_ = 8.63

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1106104057(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_226_0 = 0
			local var_226_1 = 0.825

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
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

				local var_226_2 = arg_223_1:GetWordFromCfg(1106104056)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 33 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 33)

				if (33 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 33)) > 0 and var_226_1 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104056", "story_v_side_new_1106104.awb") ~= 0 then
					local var_226_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104056", "story_v_side_new_1106104.awb") / 1000

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end

					if var_226_2.prefab_name ~= "" and arg_223_1.actors_[var_226_2.prefab_name] ~= nil then
						local var_226_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_2.prefab_name].transform, "story_v_side_new_1106104", "1106104056", "story_v_side_new_1106104.awb")

						arg_223_1:RecordAudio("1106104056", var_226_7)
						arg_223_1:RecordAudio("1106104056", var_226_7)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104056", "story_v_side_new_1106104.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104056", "story_v_side_new_1106104.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1106104057 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1106104057
		arg_227_1.duration_ = 4.87

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1106104058(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_230_0 = 0
			local var_230_1 = 0.6

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(1106104057)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 24 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 24)

				if (24 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 24)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104057", "story_v_side_new_1106104.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104057", "story_v_side_new_1106104.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_side_new_1106104", "1106104057", "story_v_side_new_1106104.awb")

						arg_227_1:RecordAudio("1106104057", var_230_7)
						arg_227_1:RecordAudio("1106104057", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104057", "story_v_side_new_1106104.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104057", "story_v_side_new_1106104.awb")
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
	Play1106104058 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1106104058
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1106104059(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.ST54 == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST54")
				var_234_0.name = "ST54"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.ST54 = var_234_0
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.ST54

				arg_231_1.bgs_.ST54.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "ST54" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 4

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_4 + 0.3 and arg_231_1.time_ < var_234_4 + 0.3 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			local var_234_5 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_6 = 2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_5) / var_234_6)
				arg_231_1.mask_.color = var_234_7
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				local var_234_8 = Color.New(0, 0, 0)

				var_234_8.a = 1
				arg_231_1.mask_.color = var_234_8
			end

			local var_234_9 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_10 = 2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 then
				local var_234_11 = Color.New(0, 0, 0)

				var_234_11.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_9) / var_234_10)
				arg_231_1.mask_.color = var_234_11
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 then
				local var_234_12 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_12.a = 0
				arg_231_1.mask_.color = var_234_12
			end

			local var_234_13 = arg_231_1.actors_["106101ui_story"].transform

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 then
				arg_231_1.var_.moveOldPos106101ui_story = var_234_13.localPosition
			end

			local var_234_14 = 0.001

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_14 then
				var_234_13.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.96599999815226) / var_234_14)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_14 and arg_231_1.time_ < 1.96599999815226 + var_234_14 + arg_234_0 then
				var_234_13.localPosition = Vector3.New(0, 100, 0)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles
			end

			local var_234_15 = arg_231_1.actors_["106101ui_story"]

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 and not isNil(var_234_15) and arg_231_1.var_.characterEffect106101ui_story == nil then
				arg_231_1.var_.characterEffect106101ui_story = var_234_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_16 = 0.034000001847744

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_16 and not isNil(var_234_15) then
				if arg_231_1.var_.characterEffect106101ui_story and not isNil(var_234_15) then
					arg_231_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_231_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 1.96599999815226) / var_234_16)
				end
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_16 and arg_231_1.time_ < 1.96599999815226 + var_234_16 + arg_234_0 and not isNil(var_234_15) and arg_231_1.var_.characterEffect106101ui_story then
				arg_231_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_231_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			if 1.56666666666667 < arg_231_1.time_ and arg_231_1.time_ <= 1.56666666666667 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.166666666666667 < arg_231_1.time_ and arg_231_1.time_ <= 0.166666666666667 + arg_234_0 then
				arg_231_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_234_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_231_1.bgmTxt_.text ~= var_234_21 and arg_231_1.bgmTxt_.text ~= "" then
						if arg_231_1.bgmTxt2_.text ~= "" then
							arg_231_1.bgmTxt_.text = arg_231_1.bgmTxt2_.text
						end

						arg_231_1.bgmTxt2_.text = var_234_21

						arg_231_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_231_1.bgmTxt_.text = var_234_21
						arg_231_1.bgmTxt2_.text = var_234_21
					end

					if arg_231_1.bgmTimer then
						arg_231_1.bgmTimer:Stop()

						arg_231_1.bgmTimer = nil
					end

					if arg_231_1.settingData.show_music_name == 1 then
						arg_231_1.musicController:SetSelectedState("show")
						arg_231_1.musicAnimator_:Play("open", 0, 0)

						if arg_231_1.settingData.music_time ~= 0 then
							arg_231_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_231_1.settingData.music_time), function()
								if arg_231_1 == nil or isNil(arg_231_1.bgmTxt_) then
									return
								end

								arg_231_1.musicController:SetSelectedState("hide")
								arg_231_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_22 = 4
			local var_234_23 = 0.925

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_22 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_24 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_24:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_231_1.dialogCg_.alpha = arg_236_0
				end))
				var_234_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_25 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1106104058).content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_27 = 37 <= 0 and var_234_23 or var_234_23 * (utf8.len(var_234_25) / 37)

				if (37 <= 0 and var_234_23 or var_234_23 * (utf8.len(var_234_25) / 37)) > 0 and var_234_23 < var_234_27 then
					arg_231_1.talkMaxDuration = var_234_27
					var_234_22 = var_234_22 + 0.3

					if var_234_27 + var_234_22 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_27 + var_234_22
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_28 = var_234_22 + 0.3
			local var_234_29 = math.max(var_234_23, arg_231_1.talkMaxDuration)

			if var_234_22 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_28 + var_234_29 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_28) / var_234_29

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_28 + var_234_29 and arg_231_1.time_ < var_234_28 + var_234_29 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1106104059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1106104059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1106104060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 1.4

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

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1106104059).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 56 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 56)

				if (56 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 56)) > 0 and var_241_0 < var_241_3 then
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
	Play1106104060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1106104060
		arg_242_1.duration_ = 2.07

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1106104061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos106101ui_story = arg_242_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["106101ui_story"].transform.position).z)
				arg_242_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["106101ui_story"].transform.localEulerAngles = arg_242_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_242_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["106101ui_story"].transform.position).z)
				arg_242_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["106101ui_story"].transform.localEulerAngles = arg_242_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["106101ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect106101ui_story == nil then
				arg_242_1.var_.characterEffect106101ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect106101ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect106101ui_story then
				arg_242_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 0.3

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(1106104060)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 12 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 12)

				if (12 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 12)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104060", "story_v_side_new_1106104.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104060", "story_v_side_new_1106104.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_side_new_1106104", "1106104060", "story_v_side_new_1106104.awb")

						arg_242_1:RecordAudio("1106104060", var_245_11)
						arg_242_1:RecordAudio("1106104060", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104060", "story_v_side_new_1106104.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104060", "story_v_side_new_1106104.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1106104061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1106104061
		arg_246_1.duration_ = 4.43

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1106104062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.65

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(1106104061)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 26 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 26)

				if (26 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 26)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104061", "story_v_side_new_1106104.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104061", "story_v_side_new_1106104.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_side_new_1106104", "1106104061", "story_v_side_new_1106104.awb")

						arg_246_1:RecordAudio("1106104061", var_249_6)
						arg_246_1:RecordAudio("1106104061", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104061", "story_v_side_new_1106104.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104061", "story_v_side_new_1106104.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1106104062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1106104062
		arg_250_1.duration_ = 2.87

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1106104063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_253_0 = 0
			local var_253_1 = 0.5

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(1106104062)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 20 <= 0 and var_253_1 or var_253_1 * (utf8.len(var_253_3) / 20)

				if (20 <= 0 and var_253_1 or var_253_1 * (utf8.len(var_253_3) / 20)) > 0 and var_253_1 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104062", "story_v_side_new_1106104.awb") ~= 0 then
					local var_253_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104062", "story_v_side_new_1106104.awb") / 1000

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end

					if var_253_2.prefab_name ~= "" and arg_250_1.actors_[var_253_2.prefab_name] ~= nil then
						local var_253_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_2.prefab_name].transform, "story_v_side_new_1106104", "1106104062", "story_v_side_new_1106104.awb")

						arg_250_1:RecordAudio("1106104062", var_253_7)
						arg_250_1:RecordAudio("1106104062", var_253_7)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104062", "story_v_side_new_1106104.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104062", "story_v_side_new_1106104.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_8 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_8 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_8

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_8 and arg_250_1.time_ < var_253_0 + var_253_8 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1106104063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1106104063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1106104064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos106101ui_story = arg_254_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["106101ui_story"].transform.position).z)
				arg_254_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["106101ui_story"].transform.localEulerAngles = arg_254_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["106101ui_story"].transform.position).z)
				arg_254_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["106101ui_story"].transform.localEulerAngles = arg_254_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["106101ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect106101ui_story == nil then
				arg_254_1.var_.characterEffect106101ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect106101ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_254_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_2)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect106101ui_story then
				arg_254_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_254_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_257_3 = 0
			local var_257_4 = 0.525

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_3 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_5 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1106104063).content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 21 <= 0 and var_257_4 or var_257_4 * (utf8.len(var_257_5) / 21)

				if (21 <= 0 and var_257_4 or var_257_4 * (utf8.len(var_257_5) / 21)) > 0 and var_257_4 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_3 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_3
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_4, arg_254_1.talkMaxDuration)

			if var_257_3 <= arg_254_1.time_ and arg_254_1.time_ < var_257_3 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_3) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_3 + var_257_8 and arg_254_1.time_ < var_257_3 + var_257_8 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play1106104064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1106104064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1106104065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.775

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

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(1106104064).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 31 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 31)

				if (31 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 31)) > 0 and var_261_0 < var_261_3 then
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
	Play1106104065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1106104065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1106104066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				local var_265_0 = arg_262_1.bgs_.ST54

				arg_262_1.bgs_.ST54.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_265_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_265_1 = var_265_0:GetComponent("SpriteRenderer")

				if var_265_1 and var_265_1.sprite then
					local var_265_2 = 2 * (var_265_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_265_0.transform.localScale = Vector3.New(var_265_2 / var_265_1.sprite.bounds.size.y < var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x and var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x or var_265_2 / var_265_1.sprite.bounds.size.y, var_265_2 / var_265_1.sprite.bounds.size.y < var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x and var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x or var_265_2 / var_265_1.sprite.bounds.size.y, 0)
				end

				for iter_265_0, iter_265_1 in pairs(arg_262_1.bgs_) do
					if iter_265_0 ~= "ST54" then
						iter_265_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_265_3 = 2

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= var_265_3 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			if arg_262_1.time_ >= var_265_3 + 0.3 and arg_262_1.time_ < var_265_3 + 0.3 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			local var_265_4 = 1.00008890058234e-12

			if 1.00008890058234e-12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_5 = 2

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_5 then
				local var_265_6 = Color.New(0, 0, 0)

				var_265_6.a = Mathf.Lerp(1, 0, (arg_262_1.time_ - var_265_4) / var_265_5)
				arg_262_1.mask_.color = var_265_6
			end

			if arg_262_1.time_ >= var_265_4 + var_265_5 and arg_262_1.time_ < var_265_4 + var_265_5 + arg_265_0 then
				local var_265_7 = Color.New(0, 0, 0)

				arg_262_1.mask_.enabled = false
				var_265_7.a = 0
				arg_262_1.mask_.color = var_265_7
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_8 = 1.999999999999
			local var_265_9 = 0.3

			if 1.999999999999 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_10 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_10:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1360].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_11 = arg_262_1:GetWordFromCfg(1106104065)
				local var_265_12 = arg_262_1:FormatText(var_265_11.content)

				arg_262_1.text_.text = var_265_12

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_14 = 12 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_12) / 12)

				if (12 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_12) / 12)) > 0 and var_265_9 < var_265_14 then
					arg_262_1.talkMaxDuration = var_265_14
					var_265_8 = var_265_8 + 0.3

					if var_265_14 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_8
					end
				end

				arg_262_1.text_.text = var_265_12
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104065", "story_v_side_new_1106104.awb") ~= 0 then
					local var_265_15 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104065", "story_v_side_new_1106104.awb") / 1000

					if var_265_15 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_15 + var_265_8
					end

					if var_265_11.prefab_name ~= "" and arg_262_1.actors_[var_265_11.prefab_name] ~= nil then
						local var_265_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_11.prefab_name].transform, "story_v_side_new_1106104", "1106104065", "story_v_side_new_1106104.awb")

						arg_262_1:RecordAudio("1106104065", var_265_16)
						arg_262_1:RecordAudio("1106104065", var_265_16)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104065", "story_v_side_new_1106104.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104065", "story_v_side_new_1106104.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_17 = var_265_8 + 0.3
			local var_265_18 = math.max(var_265_9, arg_262_1.talkMaxDuration)

			if var_265_8 + 0.3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_17 + var_265_18 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_17) / var_265_18

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_17 + var_265_18 and arg_262_1.time_ < var_265_17 + var_265_18 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1106104066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1106104066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1106104067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.8

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(1106104066).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 32 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 32)

				if (32 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 32)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1106104067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1106104067
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1106104068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.375

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

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(1106104067).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 15 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 15)

				if (15 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 15)) > 0 and var_275_0 < var_275_3 then
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
	Play1106104068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1106104068
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1106104069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.55

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1106104068).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 22 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 22)

				if (22 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 22)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1106104069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1106104069
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1106104070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.15

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
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

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(1106104069).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 6 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 6)

				if (6 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 6)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1106104070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1106104070
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1106104071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 1.05

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
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

				local var_287_1 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(1106104070).content)

				arg_284_1.text_.text = var_287_1

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_3 = 42 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 42)

				if (42 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 42)) > 0 and var_287_0 < var_287_3 then
					arg_284_1.talkMaxDuration = var_287_3

					if var_287_3 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_3 + 0
					end
				end

				arg_284_1.text_.text = var_287_1
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_4 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_4

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1106104071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1106104071
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1106104072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.9

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(1106104071).content)

				arg_288_1.text_.text = var_291_1

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_3 = 36 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 36)

				if (36 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 36)) > 0 and var_291_0 < var_291_3 then
					arg_288_1.talkMaxDuration = var_291_3

					if var_291_3 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_3 + 0
					end
				end

				arg_288_1.text_.text = var_291_1
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_4 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_4

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1106104072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1106104072
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1106104073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.725

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1106104072).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 29 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 29)

				if (29 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 29)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1106104073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1106104073
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1106104074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.475

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_1 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1106104073).content)

				arg_296_1.text_.text = var_299_1

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_3 = 19 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_1) / 19)

				if (19 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_1) / 19)) > 0 and var_299_0 < var_299_3 then
					arg_296_1.talkMaxDuration = var_299_3

					if var_299_3 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_3 + 0
					end
				end

				arg_296_1.text_.text = var_299_1
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_4 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_4

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play1106104074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1106104074
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1106104075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.825

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(1106104074).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 34 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 34)

				if (34 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 34)) > 0 and var_303_0 < var_303_3 then
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
	Play1106104075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1106104075
		arg_304_1.duration_ = 2

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1106104076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos106101ui_story = arg_304_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["106101ui_story"].transform.position).z)
				arg_304_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["106101ui_story"].transform.localEulerAngles = arg_304_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_304_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["106101ui_story"].transform.position).z)
				arg_304_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["106101ui_story"].transform.localEulerAngles = arg_304_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_307_1 = arg_304_1.actors_["106101ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect106101ui_story == nil then
				arg_304_1.var_.characterEffect106101ui_story = var_307_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_2 and not isNil(var_307_1) then
				if arg_304_1.var_.characterEffect106101ui_story and not isNil(var_307_1) then
					arg_304_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_2 and arg_304_1.time_ < 0 + var_307_2 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect106101ui_story then
				arg_304_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_307_4 = 0
			local var_307_5 = 0.2

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_6 = arg_304_1:GetWordFromCfg(1106104075)
				local var_307_7 = arg_304_1:FormatText(var_307_6.content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_9 = 8 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 8)

				if (8 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 8)) > 0 and var_307_5 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_4
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104075", "story_v_side_new_1106104.awb") ~= 0 then
					local var_307_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104075", "story_v_side_new_1106104.awb") / 1000

					if var_307_10 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_4
					end

					if var_307_6.prefab_name ~= "" and arg_304_1.actors_[var_307_6.prefab_name] ~= nil then
						local var_307_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_6.prefab_name].transform, "story_v_side_new_1106104", "1106104075", "story_v_side_new_1106104.awb")

						arg_304_1:RecordAudio("1106104075", var_307_11)
						arg_304_1:RecordAudio("1106104075", var_307_11)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104075", "story_v_side_new_1106104.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104075", "story_v_side_new_1106104.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_12 = math.max(var_307_5, arg_304_1.talkMaxDuration)

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_12 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_4) / var_307_12

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_4 + var_307_12 and arg_304_1.time_ < var_307_4 + var_307_12 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play1106104076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1106104076
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1106104077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["106101ui_story"]) and arg_308_1.var_.characterEffect106101ui_story == nil then
				arg_308_1.var_.characterEffect106101ui_story = arg_308_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["106101ui_story"]) then
				if arg_308_1.var_.characterEffect106101ui_story and not isNil(arg_308_1.actors_["106101ui_story"]) then
					arg_308_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_308_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["106101ui_story"]) and arg_308_1.var_.characterEffect106101ui_story then
				arg_308_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_308_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_311_1 = 0
			local var_311_2 = 0.175

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

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1106104076).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 7 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 7)

				if (7 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 7)) > 0 and var_311_2 < var_311_5 then
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
	Play1106104077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1106104077
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1106104078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.925

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
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

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(1106104077).content)

				arg_312_1.text_.text = var_315_1

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_3 = 37 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 37)

				if (37 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 37)) > 0 and var_315_0 < var_315_3 then
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
	Play1106104078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1106104078
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1106104079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action492")
			end

			local var_319_0 = 0
			local var_319_1 = 0.675

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1106104078).content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 27 <= 0 and var_319_1 or var_319_1 * (utf8.len(var_319_2) / 27)

				if (27 <= 0 and var_319_1 or var_319_1 * (utf8.len(var_319_2) / 27)) > 0 and var_319_1 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_5 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_5 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_5

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_5 and arg_316_1.time_ < var_319_0 + var_319_5 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1106104079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1106104079
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1106104080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.575

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1106104079).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 23 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 23)

				if (23 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 23)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1106104080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1106104080
		arg_324_1.duration_ = 2.7

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1106104081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["106101ui_story"]) and arg_324_1.var_.characterEffect106101ui_story == nil then
				arg_324_1.var_.characterEffect106101ui_story = arg_324_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["106101ui_story"]) then
				if arg_324_1.var_.characterEffect106101ui_story and not isNil(arg_324_1.actors_["106101ui_story"]) then
					arg_324_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["106101ui_story"]) and arg_324_1.var_.characterEffect106101ui_story then
				arg_324_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action424")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_327_2 = 0
			local var_327_3 = 0.3

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_4 = arg_324_1:GetWordFromCfg(1106104080)
				local var_327_5 = arg_324_1:FormatText(var_327_4.content)

				arg_324_1.text_.text = var_327_5

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 12 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 12)

				if (12 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 12)) > 0 and var_327_3 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_2
					end
				end

				arg_324_1.text_.text = var_327_5
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104080", "story_v_side_new_1106104.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104080", "story_v_side_new_1106104.awb") / 1000

					if var_327_8 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_2
					end

					if var_327_4.prefab_name ~= "" and arg_324_1.actors_[var_327_4.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_4.prefab_name].transform, "story_v_side_new_1106104", "1106104080", "story_v_side_new_1106104.awb")

						arg_324_1:RecordAudio("1106104080", var_327_9)
						arg_324_1:RecordAudio("1106104080", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104080", "story_v_side_new_1106104.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104080", "story_v_side_new_1106104.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_3, arg_324_1.talkMaxDuration)

			if var_327_2 <= arg_324_1.time_ and arg_324_1.time_ < var_327_2 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_2) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_2 + var_327_10 and arg_324_1.time_ < var_327_2 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1106104081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1106104081
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1106104082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos106101ui_story = arg_328_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 then
				arg_328_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_328_1.time_ - 0) / var_331_0)
				arg_328_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["106101ui_story"].transform.position).z)
				arg_328_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["106101ui_story"].transform.localEulerAngles = arg_328_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["106101ui_story"].transform.position).z)
				arg_328_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["106101ui_story"].transform.localEulerAngles = arg_328_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_331_1 = arg_328_1.actors_["106101ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect106101ui_story == nil then
				arg_328_1.var_.characterEffect106101ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_2 and not isNil(var_331_1) then
				if arg_328_1.var_.characterEffect106101ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_328_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_2)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_2 and arg_328_1.time_ < 0 + var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect106101ui_story then
				arg_328_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_328_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_331_3 = 0
			local var_331_4 = 0.575

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_5 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(1106104081).content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 23 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_5) / 23)

				if (23 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_5) / 23)) > 0 and var_331_4 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_3
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_8 = math.max(var_331_4, arg_328_1.talkMaxDuration)

			if var_331_3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_3 + var_331_8 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_3) / var_331_8

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_3 + var_331_8 and arg_328_1.time_ < var_331_3 + var_331_8 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
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
	Play1106104082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1106104082
		arg_332_1.duration_ = 9

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1106104083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 2 < arg_332_1.time_ and arg_332_1.time_ <= 2 + arg_335_0 then
				local var_335_0 = arg_332_1.bgs_.ST54

				arg_332_1.bgs_.ST54.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_335_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_1 = var_335_0:GetComponent("SpriteRenderer")

				if var_335_1 and var_335_1.sprite then
					local var_335_2 = 2 * (var_335_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_335_0.transform.localScale = Vector3.New(var_335_2 / var_335_1.sprite.bounds.size.y < var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x and var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x or var_335_2 / var_335_1.sprite.bounds.size.y, var_335_2 / var_335_1.sprite.bounds.size.y < var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x and var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x or var_335_2 / var_335_1.sprite.bounds.size.y, 0)
				end

				for iter_335_0, iter_335_1 in pairs(arg_332_1.bgs_) do
					if iter_335_0 ~= "ST54" then
						iter_335_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_3 = 3.999999999999

			if 3.999999999999 < arg_332_1.time_ and arg_332_1.time_ <= var_335_3 + arg_335_0 then
				arg_332_1.allBtn_.enabled = false
			end

			if arg_332_1.time_ >= var_335_3 + 0.3 and arg_332_1.time_ < var_335_3 + 0.3 + arg_335_0 then
				arg_332_1.allBtn_.enabled = true
			end

			local var_335_4 = 0

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_5 = 2

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_5 then
				local var_335_6 = Color.New(0, 0, 0)

				var_335_6.a = Mathf.Lerp(0, 1, (arg_332_1.time_ - var_335_4) / var_335_5)
				arg_332_1.mask_.color = var_335_6
			end

			if arg_332_1.time_ >= var_335_4 + var_335_5 and arg_332_1.time_ < var_335_4 + var_335_5 + arg_335_0 then
				local var_335_7 = Color.New(0, 0, 0)

				var_335_7.a = 1
				arg_332_1.mask_.color = var_335_7
			end

			local var_335_8 = 2

			if 2 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_9 = 2

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_9 then
				local var_335_10 = Color.New(0, 0, 0)

				var_335_10.a = Mathf.Lerp(1, 0, (arg_332_1.time_ - var_335_8) / var_335_9)
				arg_332_1.mask_.color = var_335_10
			end

			if arg_332_1.time_ >= var_335_8 + var_335_9 and arg_332_1.time_ < var_335_8 + var_335_9 + arg_335_0 then
				local var_335_11 = Color.New(0, 0, 0)

				arg_332_1.mask_.enabled = false
				var_335_11.a = 0
				arg_332_1.mask_.color = var_335_11
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_12 = 4
			local var_335_13 = 0.875

			if 4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_12 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_14 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_14:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_332_1.dialogCg_.alpha = arg_336_0
				end))
				var_335_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_15 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(1106104082).content)

				arg_332_1.text_.text = var_335_15

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_17 = 35 <= 0 and var_335_13 or var_335_13 * (utf8.len(var_335_15) / 35)

				if (35 <= 0 and var_335_13 or var_335_13 * (utf8.len(var_335_15) / 35)) > 0 and var_335_13 < var_335_17 then
					arg_332_1.talkMaxDuration = var_335_17
					var_335_12 = var_335_12 + 0.3

					if var_335_17 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_17 + var_335_12
					end
				end

				arg_332_1.text_.text = var_335_15
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_18 = var_335_12 + 0.3
			local var_335_19 = math.max(var_335_13, arg_332_1.talkMaxDuration)

			if var_335_12 + 0.3 <= arg_332_1.time_ and arg_332_1.time_ < var_335_18 + var_335_19 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_18) / var_335_19

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_18 + var_335_19 and arg_332_1.time_ < var_335_18 + var_335_19 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1106104083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1106104083
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1106104084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 1.125

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

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(1106104083).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 45 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 45)

				if (45 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 45)) > 0 and var_341_0 < var_341_3 then
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
	Play1106104084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1106104084
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1106104085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.6

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
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

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(1106104084).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 24 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 24)

				if (24 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 24)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1106104085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1106104085
		arg_346_1.duration_ = 3.83

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1106104086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos106101ui_story = arg_346_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["106101ui_story"].transform.position).z)
				arg_346_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["106101ui_story"].transform.localEulerAngles = arg_346_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_346_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["106101ui_story"].transform.position).z)
				arg_346_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["106101ui_story"].transform.localEulerAngles = arg_346_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["106101ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect106101ui_story == nil then
				arg_346_1.var_.characterEffect106101ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect106101ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect106101ui_story then
				arg_346_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_349_4 = 0
			local var_349_5 = 0.5

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_6 = arg_346_1:GetWordFromCfg(1106104085)
				local var_349_7 = arg_346_1:FormatText(var_349_6.content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 20 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 20)

				if (20 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 20)) > 0 and var_349_5 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104085", "story_v_side_new_1106104.awb") ~= 0 then
					local var_349_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104085", "story_v_side_new_1106104.awb") / 1000

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end

					if var_349_6.prefab_name ~= "" and arg_346_1.actors_[var_349_6.prefab_name] ~= nil then
						local var_349_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_6.prefab_name].transform, "story_v_side_new_1106104", "1106104085", "story_v_side_new_1106104.awb")

						arg_346_1:RecordAudio("1106104085", var_349_11)
						arg_346_1:RecordAudio("1106104085", var_349_11)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104085", "story_v_side_new_1106104.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104085", "story_v_side_new_1106104.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_12 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_12 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_12

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_12 and arg_346_1.time_ < var_349_4 + var_349_12 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play1106104086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1106104086
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1106104087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos106101ui_story = arg_350_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["106101ui_story"].transform.position).z)
				arg_350_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["106101ui_story"].transform.localEulerAngles = arg_350_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_350_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["106101ui_story"].transform.position).z)
				arg_350_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["106101ui_story"].transform.localEulerAngles = arg_350_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_353_1 = arg_350_1.actors_["106101ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect106101ui_story == nil then
				arg_350_1.var_.characterEffect106101ui_story = var_353_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 and not isNil(var_353_1) then
				if arg_350_1.var_.characterEffect106101ui_story and not isNil(var_353_1) then
					arg_350_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_350_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_2)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect106101ui_story then
				arg_350_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_350_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_353_3 = 0
			local var_353_4 = 0.9

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_5 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1106104086).content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 36 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 36)

				if (36 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 36)) > 0 and var_353_4 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_3 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_3
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_4, arg_350_1.talkMaxDuration)

			if var_353_3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_3 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_3) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_3 + var_353_8 and arg_350_1.time_ < var_353_3 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
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
	Play1106104087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1106104087
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1106104088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.725

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
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

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(1106104087).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 29 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 29)

				if (29 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 29)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1106104088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1106104088
		arg_358_1.duration_ = 4.57

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1106104089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos106101ui_story = arg_358_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["106101ui_story"].transform.position).z)
				arg_358_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["106101ui_story"].transform.localEulerAngles = arg_358_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_358_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["106101ui_story"].transform.position).z)
				arg_358_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["106101ui_story"].transform.localEulerAngles = arg_358_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["106101ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect106101ui_story == nil then
				arg_358_1.var_.characterEffect106101ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect106101ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect106101ui_story then
				arg_358_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_361_4 = 0
			local var_361_5 = 0.5

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_6 = arg_358_1:GetWordFromCfg(1106104088)
				local var_361_7 = arg_358_1:FormatText(var_361_6.content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 20 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 20)

				if (20 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 20)) > 0 and var_361_5 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104088", "story_v_side_new_1106104.awb") ~= 0 then
					local var_361_10 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104088", "story_v_side_new_1106104.awb") / 1000

					if var_361_10 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_4
					end

					if var_361_6.prefab_name ~= "" and arg_358_1.actors_[var_361_6.prefab_name] ~= nil then
						local var_361_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_6.prefab_name].transform, "story_v_side_new_1106104", "1106104088", "story_v_side_new_1106104.awb")

						arg_358_1:RecordAudio("1106104088", var_361_11)
						arg_358_1:RecordAudio("1106104088", var_361_11)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104088", "story_v_side_new_1106104.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104088", "story_v_side_new_1106104.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_12 = math.max(var_361_5, arg_358_1.talkMaxDuration)

			if var_361_4 <= arg_358_1.time_ and arg_358_1.time_ < var_361_4 + var_361_12 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_4) / var_361_12

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_4 + var_361_12 and arg_358_1.time_ < var_361_4 + var_361_12 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
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
	Play1106104089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1106104089
		arg_362_1.duration_ = 2.2

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1106104090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.3

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(1106104089)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 12 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 12)

				if (12 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 12)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104089", "story_v_side_new_1106104.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104089", "story_v_side_new_1106104.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_side_new_1106104", "1106104089", "story_v_side_new_1106104.awb")

						arg_362_1:RecordAudio("1106104089", var_365_6)
						arg_362_1:RecordAudio("1106104089", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104089", "story_v_side_new_1106104.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104089", "story_v_side_new_1106104.awb")
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
	Play1106104090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1106104090
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1106104091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["106101ui_story"]) and arg_366_1.var_.characterEffect106101ui_story == nil then
				arg_366_1.var_.characterEffect106101ui_story = arg_366_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["106101ui_story"]) then
				if arg_366_1.var_.characterEffect106101ui_story and not isNil(arg_366_1.actors_["106101ui_story"]) then
					arg_366_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_366_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_0)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["106101ui_story"]) and arg_366_1.var_.characterEffect106101ui_story then
				arg_366_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_366_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_369_1 = 0
			local var_369_2 = 0.425

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
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

				local var_369_3 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1106104090).content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 17 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 17)

				if (17 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 17)) > 0 and var_369_2 < var_369_5 then
					arg_366_1.talkMaxDuration = var_369_5

					if var_369_5 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + var_369_1
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_6 = math.max(var_369_2, arg_366_1.talkMaxDuration)

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_6 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_1) / var_369_6

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_1 + var_369_6 and arg_366_1.time_ < var_369_1 + var_369_6 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1106104091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1106104091
		arg_370_1.duration_ = 3.67

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1106104092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["106101ui_story"]) and arg_370_1.var_.characterEffect106101ui_story == nil then
				arg_370_1.var_.characterEffect106101ui_story = arg_370_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["106101ui_story"]) then
				if arg_370_1.var_.characterEffect106101ui_story and not isNil(arg_370_1.actors_["106101ui_story"]) then
					arg_370_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["106101ui_story"]) and arg_370_1.var_.characterEffect106101ui_story then
				arg_370_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_373_2 = 0
			local var_373_3 = 0.525

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_2 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_4 = arg_370_1:GetWordFromCfg(1106104091)
				local var_373_5 = arg_370_1:FormatText(var_373_4.content)

				arg_370_1.text_.text = var_373_5

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_7 = 21 <= 0 and var_373_3 or var_373_3 * (utf8.len(var_373_5) / 21)

				if (21 <= 0 and var_373_3 or var_373_3 * (utf8.len(var_373_5) / 21)) > 0 and var_373_3 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_2
					end
				end

				arg_370_1.text_.text = var_373_5
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104091", "story_v_side_new_1106104.awb") ~= 0 then
					local var_373_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104091", "story_v_side_new_1106104.awb") / 1000

					if var_373_8 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_2
					end

					if var_373_4.prefab_name ~= "" and arg_370_1.actors_[var_373_4.prefab_name] ~= nil then
						local var_373_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_4.prefab_name].transform, "story_v_side_new_1106104", "1106104091", "story_v_side_new_1106104.awb")

						arg_370_1:RecordAudio("1106104091", var_373_9)
						arg_370_1:RecordAudio("1106104091", var_373_9)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104091", "story_v_side_new_1106104.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104091", "story_v_side_new_1106104.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_10 = math.max(var_373_3, arg_370_1.talkMaxDuration)

			if var_373_2 <= arg_370_1.time_ and arg_370_1.time_ < var_373_2 + var_373_10 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_2) / var_373_10

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_2 + var_373_10 and arg_370_1.time_ < var_373_2 + var_373_10 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1106104092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1106104092
		arg_374_1.duration_ = 2

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1106104093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_377_0 = 0
			local var_377_1 = 0.175

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(1106104092)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 7 <= 0 and var_377_1 or var_377_1 * (utf8.len(var_377_3) / 7)

				if (7 <= 0 and var_377_1 or var_377_1 * (utf8.len(var_377_3) / 7)) > 0 and var_377_1 < var_377_5 then
					arg_374_1.talkMaxDuration = var_377_5

					if var_377_5 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104092", "story_v_side_new_1106104.awb") ~= 0 then
					local var_377_6 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104092", "story_v_side_new_1106104.awb") / 1000

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end

					if var_377_2.prefab_name ~= "" and arg_374_1.actors_[var_377_2.prefab_name] ~= nil then
						local var_377_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_2.prefab_name].transform, "story_v_side_new_1106104", "1106104092", "story_v_side_new_1106104.awb")

						arg_374_1:RecordAudio("1106104092", var_377_7)
						arg_374_1:RecordAudio("1106104092", var_377_7)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104092", "story_v_side_new_1106104.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104092", "story_v_side_new_1106104.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_8 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_8 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_8

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_8 and arg_374_1.time_ < var_377_0 + var_377_8 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1106104093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1106104093
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1106104094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos106101ui_story = arg_378_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["106101ui_story"].transform.position).z)
				arg_378_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["106101ui_story"].transform.localEulerAngles = arg_378_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_378_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["106101ui_story"].transform.position).z)
				arg_378_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["106101ui_story"].transform.localEulerAngles = arg_378_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_381_1 = arg_378_1.actors_["106101ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect106101ui_story == nil then
				arg_378_1.var_.characterEffect106101ui_story = var_381_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_2 and not isNil(var_381_1) then
				if arg_378_1.var_.characterEffect106101ui_story and not isNil(var_381_1) then
					arg_378_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_378_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_2)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_2 and arg_378_1.time_ < 0 + var_381_2 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect106101ui_story then
				arg_378_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_378_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_381_3 = 0
			local var_381_4 = 0.975

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_3 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_5 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(1106104093).content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 39 <= 0 and var_381_4 or var_381_4 * (utf8.len(var_381_5) / 39)

				if (39 <= 0 and var_381_4 or var_381_4 * (utf8.len(var_381_5) / 39)) > 0 and var_381_4 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_3 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_3
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_4, arg_378_1.talkMaxDuration)

			if var_381_3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_3 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_3) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_3 + var_381_8 and arg_378_1.time_ < var_381_3 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play1106104094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1106104094
		arg_382_1.duration_ = 1

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"

			SetActive(arg_382_1.choicesGo_, true)

			for iter_383_0, iter_383_1 in ipairs(arg_382_1.choices_) do
				SetActive(iter_383_1.go, iter_383_0 <= 1)
			end

			arg_382_1.choices_[1].txt.text = arg_382_1:FormatText(StoryChoiceCfg[1396].name)
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1106104095(arg_382_1)
			end

			arg_382_1:RecordChoiceLog(1106104094, 1396)
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			return
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1106104095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1106104095
		arg_386_1.duration_ = 8.4

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1106104096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if arg_386_1.bgs_.R6101 == nil then
				local var_389_0 = Object.Instantiate(arg_386_1.paintGo_)

				var_389_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R6101")
				var_389_0.name = "R6101"
				var_389_0.transform.parent = arg_386_1.stage_.transform
				var_389_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_386_1.bgs_.R6101 = var_389_0
			end

			if 1.38333333333333 < arg_386_1.time_ and arg_386_1.time_ <= 1.38333333333333 + arg_389_0 then
				local var_389_1 = arg_386_1.bgs_.R6101

				arg_386_1.bgs_.R6101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_389_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_389_2 = var_389_1:GetComponent("SpriteRenderer")

				if var_389_2 and var_389_2.sprite then
					local var_389_3 = 2 * (var_389_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_389_1.transform.localScale = Vector3.New(var_389_3 / var_389_2.sprite.bounds.size.y < var_389_3 * manager.ui.mainCameraCom_.aspect / var_389_2.sprite.bounds.size.x and var_389_3 * manager.ui.mainCameraCom_.aspect / var_389_2.sprite.bounds.size.x or var_389_3 / var_389_2.sprite.bounds.size.y, var_389_3 / var_389_2.sprite.bounds.size.y < var_389_3 * manager.ui.mainCameraCom_.aspect / var_389_2.sprite.bounds.size.x and var_389_3 * manager.ui.mainCameraCom_.aspect / var_389_2.sprite.bounds.size.x or var_389_3 / var_389_2.sprite.bounds.size.y, 0)
				end

				for iter_389_0, iter_389_1 in pairs(arg_386_1.bgs_) do
					if iter_389_0 ~= "R6101" then
						iter_389_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_389_4 = 1.4

			if 1.4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.allBtn_.enabled = false
			end

			if arg_386_1.time_ >= var_389_4 + 0.3 and arg_386_1.time_ < var_389_4 + 0.3 + arg_389_0 then
				arg_386_1.allBtn_.enabled = true
			end

			local var_389_5 = 0

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_6 = 1.4

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_6 then
				local var_389_7 = Color.New(0, 0, 0)

				var_389_7.a = Mathf.Lerp(0, 1, (arg_386_1.time_ - var_389_5) / var_389_6)
				arg_386_1.mask_.color = var_389_7
			end

			if arg_386_1.time_ >= var_389_5 + var_389_6 and arg_386_1.time_ < var_389_5 + var_389_6 + arg_389_0 then
				local var_389_8 = Color.New(0, 0, 0)

				var_389_8.a = 1
				arg_386_1.mask_.color = var_389_8
			end

			local var_389_9 = 1.4

			if 1.4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_9 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_10 = 2.1

			if var_389_9 <= arg_386_1.time_ and arg_386_1.time_ < var_389_9 + var_389_10 then
				local var_389_11 = Color.New(0, 0, 0)

				var_389_11.a = Mathf.Lerp(1, 0, (arg_386_1.time_ - var_389_9) / var_389_10)
				arg_386_1.mask_.color = var_389_11
			end

			if arg_386_1.time_ >= var_389_9 + var_389_10 and arg_386_1.time_ < var_389_9 + var_389_10 + arg_389_0 then
				local var_389_12 = Color.New(0, 0, 0)

				arg_386_1.mask_.enabled = false
				var_389_12.a = 0
				arg_386_1.mask_.color = var_389_12
			end

			local var_389_13 = arg_386_1.bgs_.R6101.transform

			if 1.4 < arg_386_1.time_ and arg_386_1.time_ <= 1.4 + arg_389_0 then
				arg_386_1.var_.moveOldPosR6101 = var_389_13.localPosition
			end

			local var_389_14 = 0.001

			if 1.4 <= arg_386_1.time_ and arg_386_1.time_ < 1.4 + var_389_14 then
				var_389_13.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPosR6101, Vector3.New(0, 1, 8), (arg_386_1.time_ - 1.4) / var_389_14)
			end

			if arg_386_1.time_ >= 1.4 + var_389_14 and arg_386_1.time_ < 1.4 + var_389_14 + arg_389_0 then
				var_389_13.localPosition = Vector3.New(0, 1, 8)
			end

			local var_389_15 = arg_386_1.bgs_.R6101.transform

			if 1.41666666666667 < arg_386_1.time_ and arg_386_1.time_ <= 1.41666666666667 + arg_389_0 then
				arg_386_1.var_.moveOldPosR6101 = var_389_15.localPosition
			end

			local var_389_16 = 2.08333333333333

			if 1.41666666666667 <= arg_386_1.time_ and arg_386_1.time_ < 1.41666666666667 + var_389_16 then
				var_389_15.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPosR6101, Vector3.New(0, 1, 10), (arg_386_1.time_ - 1.41666666666667) / var_389_16)
			end

			if arg_386_1.time_ >= 1.41666666666667 + var_389_16 and arg_386_1.time_ < 1.41666666666667 + var_389_16 + arg_389_0 then
				var_389_15.localPosition = Vector3.New(0, 1, 10)
			end

			if 1 < arg_386_1.time_ and arg_386_1.time_ <= 1 + arg_389_0 then
				arg_386_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_crowd_down", "")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_389_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_386_1.bgmTxt_.text ~= var_389_20 and arg_386_1.bgmTxt_.text ~= "" then
						if arg_386_1.bgmTxt2_.text ~= "" then
							arg_386_1.bgmTxt_.text = arg_386_1.bgmTxt2_.text
						end

						arg_386_1.bgmTxt2_.text = var_389_20

						arg_386_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_386_1.bgmTxt_.text = var_389_20
						arg_386_1.bgmTxt2_.text = var_389_20
					end

					if arg_386_1.bgmTimer then
						arg_386_1.bgmTimer:Stop()

						arg_386_1.bgmTimer = nil
					end

					if arg_386_1.settingData.show_music_name == 1 then
						arg_386_1.musicController:SetSelectedState("show")
						arg_386_1.musicAnimator_:Play("open", 0, 0)

						if arg_386_1.settingData.music_time ~= 0 then
							arg_386_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_386_1.settingData.music_time), function()
								if arg_386_1 == nil or isNil(arg_386_1.bgmTxt_) then
									return
								end

								arg_386_1.musicController:SetSelectedState("hide")
								arg_386_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_386_1.time_ and arg_386_1.time_ <= 0.6 + arg_389_0 then
				arg_386_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_389_23 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_386_1.bgmTxt_.text ~= var_389_23 and arg_386_1.bgmTxt_.text ~= "" then
						if arg_386_1.bgmTxt2_.text ~= "" then
							arg_386_1.bgmTxt_.text = arg_386_1.bgmTxt2_.text
						end

						arg_386_1.bgmTxt2_.text = var_389_23

						arg_386_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_386_1.bgmTxt_.text = var_389_23
						arg_386_1.bgmTxt2_.text = var_389_23
					end

					if arg_386_1.bgmTimer then
						arg_386_1.bgmTimer:Stop()

						arg_386_1.bgmTimer = nil
					end

					if arg_386_1.settingData.show_music_name == 1 then
						arg_386_1.musicController:SetSelectedState("show")
						arg_386_1.musicAnimator_:Play("open", 0, 0)

						if arg_386_1.settingData.music_time ~= 0 then
							arg_386_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_386_1.settingData.music_time), function()
								if arg_386_1 == nil or isNil(arg_386_1.bgmTxt_) then
									return
								end

								arg_386_1.musicController:SetSelectedState("hide")
								arg_386_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_386_1.time_ and arg_386_1.time_ <= 0.2 + arg_389_0 then
				arg_386_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_386_1.frameCnt_ <= 1 then
				arg_386_1.dialog_:SetActive(false)
			end

			local var_389_25 = 3.4
			local var_389_26 = 0.6

			if 3.4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_25 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0

				arg_386_1.dialog_:SetActive(true)

				arg_386_1.dialogCg_.alpha = 0

				local var_389_27 = LeanTween.value(arg_386_1.dialog_, 0, 1, 0.3)

				var_389_27:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_386_1.dialogCg_.alpha = arg_392_0
				end))
				var_389_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_386_1.dialog_)
					var_389_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_386_1.duration_ = arg_386_1.duration_ + 0.3

				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_28 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(1106104095).content)

				arg_386_1.text_.text = var_389_28

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_30 = 24 <= 0 and var_389_26 or var_389_26 * (utf8.len(var_389_28) / 24)

				if (24 <= 0 and var_389_26 or var_389_26 * (utf8.len(var_389_28) / 24)) > 0 and var_389_26 < var_389_30 then
					arg_386_1.talkMaxDuration = var_389_30
					var_389_25 = var_389_25 + 0.3

					if var_389_30 + var_389_25 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_30 + var_389_25
					end
				end

				arg_386_1.text_.text = var_389_28
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_31 = var_389_25 + 0.3
			local var_389_32 = math.max(var_389_26, arg_386_1.talkMaxDuration)

			if var_389_25 + 0.3 <= arg_386_1.time_ and arg_386_1.time_ < var_389_31 + var_389_32 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_31) / var_389_32

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_31 + var_389_32 and arg_386_1.time_ < var_389_31 + var_389_32 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R6101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R6101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.08333333333333,
				className = "StoryMoveNode",
				startTime = 1.41666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play1106104096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1106104096
		arg_394_1.duration_ = 3.23

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1106104097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.375

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:GetWordFromCfg(1106104096)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 15 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 15)

				if (15 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 15)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104096", "story_v_side_new_1106104.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104096", "story_v_side_new_1106104.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_side_new_1106104", "1106104096", "story_v_side_new_1106104.awb")

						arg_394_1:RecordAudio("1106104096", var_397_6)
						arg_394_1:RecordAudio("1106104096", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104096", "story_v_side_new_1106104.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104096", "story_v_side_new_1106104.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1106104097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1106104097
		arg_398_1.duration_ = 14.83

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1106104098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1.2

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(1106104097)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 48 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 48)

				if (48 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 48)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104097", "story_v_side_new_1106104.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104097", "story_v_side_new_1106104.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_side_new_1106104", "1106104097", "story_v_side_new_1106104.awb")

						arg_398_1:RecordAudio("1106104097", var_401_6)
						arg_398_1:RecordAudio("1106104097", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104097", "story_v_side_new_1106104.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104097", "story_v_side_new_1106104.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1106104098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1106104098
		arg_402_1.duration_ = 8.33

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1106104099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.75

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_1 = arg_402_1:GetWordFromCfg(1106104098)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 30 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 30)

				if (30 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 30)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104098", "story_v_side_new_1106104.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104098", "story_v_side_new_1106104.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_side_new_1106104", "1106104098", "story_v_side_new_1106104.awb")

						arg_402_1:RecordAudio("1106104098", var_405_6)
						arg_402_1:RecordAudio("1106104098", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104098", "story_v_side_new_1106104.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104098", "story_v_side_new_1106104.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1106104099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1106104099
		arg_406_1.duration_ = 9.57

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1106104100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.85

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_1 = arg_406_1:GetWordFromCfg(1106104099)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 34 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 34)

				if (34 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 34)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104099", "story_v_side_new_1106104.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104099", "story_v_side_new_1106104.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_side_new_1106104", "1106104099", "story_v_side_new_1106104.awb")

						arg_406_1:RecordAudio("1106104099", var_409_6)
						arg_406_1:RecordAudio("1106104099", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104099", "story_v_side_new_1106104.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104099", "story_v_side_new_1106104.awb")
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
	Play1106104100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1106104100
		arg_410_1.duration_ = 2.87

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1106104101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.4

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:GetWordFromCfg(1106104100)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 16 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 16)

				if (16 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 16)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104100", "story_v_side_new_1106104.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104100", "story_v_side_new_1106104.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_side_new_1106104", "1106104100", "story_v_side_new_1106104.awb")

						arg_410_1:RecordAudio("1106104100", var_413_6)
						arg_410_1:RecordAudio("1106104100", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104100", "story_v_side_new_1106104.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104100", "story_v_side_new_1106104.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1106104101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1106104101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1106104102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.05

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(1106104101).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 2 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 2)

				if (2 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 2)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1106104102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1106104102
		arg_418_1.duration_ = 10.43

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1106104103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 1.1

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_1 = arg_418_1:GetWordFromCfg(1106104102)
				local var_421_2 = arg_418_1:FormatText(var_421_1.content)

				arg_418_1.text_.text = var_421_2

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 44 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_2) / 44)

				if (44 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_2) / 44)) > 0 and var_421_0 < var_421_4 then
					arg_418_1.talkMaxDuration = var_421_4

					if var_421_4 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_4 + 0
					end
				end

				arg_418_1.text_.text = var_421_2
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104102", "story_v_side_new_1106104.awb") ~= 0 then
					local var_421_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104102", "story_v_side_new_1106104.awb") / 1000

					if var_421_5 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + 0
					end

					if var_421_1.prefab_name ~= "" and arg_418_1.actors_[var_421_1.prefab_name] ~= nil then
						local var_421_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_1.prefab_name].transform, "story_v_side_new_1106104", "1106104102", "story_v_side_new_1106104.awb")

						arg_418_1:RecordAudio("1106104102", var_421_6)
						arg_418_1:RecordAudio("1106104102", var_421_6)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104102", "story_v_side_new_1106104.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104102", "story_v_side_new_1106104.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_7 and arg_418_1.time_ < 0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1106104103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1106104103
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1106104104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.375

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(1106104103).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 15 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 15)

				if (15 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 15)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1106104104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1106104104
		arg_426_1.duration_ = 6.63

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1106104105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPosR6101 = arg_426_1.bgs_.R6101.transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.bgs_.R6101.transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPosR6101, Vector3.New(0, 1, 10), (arg_426_1.time_ - 0) / var_429_0)
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.bgs_.R6101.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_429_1 = arg_426_1.bgs_.R6101.transform

			if 0.0166666666666667 < arg_426_1.time_ and arg_426_1.time_ <= 0.0166666666666667 + arg_429_0 then
				arg_426_1.var_.moveOldPosR6101 = var_429_1.localPosition
			end

			local var_429_2 = 2.25

			if 0.0166666666666667 <= arg_426_1.time_ and arg_426_1.time_ < 0.0166666666666667 + var_429_2 then
				var_429_1.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPosR6101, Vector3.New(0, 0.8, 8), (arg_426_1.time_ - 0.0166666666666667) / var_429_2)
			end

			if arg_426_1.time_ >= 0.0166666666666667 + var_429_2 and arg_426_1.time_ < 0.0166666666666667 + var_429_2 + arg_429_0 then
				var_429_1.localPosition = Vector3.New(0, 0.8, 8)
			end

			local var_429_3 = 0

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_3 + arg_429_0 then
				arg_426_1.allBtn_.enabled = false
			end

			if arg_426_1.time_ >= var_429_3 + 2.266666666666 and arg_426_1.time_ < var_429_3 + 2.266666666666 + arg_429_0 then
				arg_426_1.allBtn_.enabled = true
			end

			if 0.4 < arg_426_1.time_ and arg_426_1.time_ <= 0.4 + arg_429_0 then
				arg_426_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_footstep02", "")
			end

			if arg_426_1.frameCnt_ <= 1 then
				arg_426_1.dialog_:SetActive(false)
			end

			local var_429_5 = 1.63333333333333
			local var_429_6 = 0.5

			if 1.63333333333333 < arg_426_1.time_ and arg_426_1.time_ <= var_429_5 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0

				arg_426_1.dialog_:SetActive(true)

				arg_426_1.dialogCg_.alpha = 0

				local var_429_7 = LeanTween.value(arg_426_1.dialog_, 0, 1, 0.3)

				var_429_7:setOnUpdate(LuaHelper.FloatAction(function(arg_430_0)
					arg_426_1.dialogCg_.alpha = arg_430_0
				end))
				var_429_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_426_1.dialog_)
					var_429_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_426_1.duration_ = arg_426_1.duration_ + 0.3

				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_8 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1106104104).content)

				arg_426_1.text_.text = var_429_8

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_10 = 20 <= 0 and var_429_6 or var_429_6 * (utf8.len(var_429_8) / 20)

				if (20 <= 0 and var_429_6 or var_429_6 * (utf8.len(var_429_8) / 20)) > 0 and var_429_6 < var_429_10 then
					arg_426_1.talkMaxDuration = var_429_10
					var_429_5 = var_429_5 + 0.3

					if var_429_10 + var_429_5 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_5
					end
				end

				arg_426_1.text_.text = var_429_8
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_11 = var_429_5 + 0.3
			local var_429_12 = math.max(var_429_6, arg_426_1.talkMaxDuration)

			if var_429_5 + 0.3 <= arg_426_1.time_ and arg_426_1.time_ < var_429_11 + var_429_12 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_11) / var_429_12

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_11 + var_429_12 and arg_426_1.time_ < var_429_11 + var_429_12 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R6101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R6101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.25,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play1106104105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1106104105
		arg_432_1.duration_ = 4.33

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1106104106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.4

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:GetWordFromCfg(1106104105)
				local var_435_2 = arg_432_1:FormatText(var_435_1.content)

				arg_432_1.text_.text = var_435_2

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 16 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 16)

				if (16 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 16)) > 0 and var_435_0 < var_435_4 then
					arg_432_1.talkMaxDuration = var_435_4

					if var_435_4 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_4 + 0
					end
				end

				arg_432_1.text_.text = var_435_2
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104105", "story_v_side_new_1106104.awb") ~= 0 then
					local var_435_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104105", "story_v_side_new_1106104.awb") / 1000

					if var_435_5 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + 0
					end

					if var_435_1.prefab_name ~= "" and arg_432_1.actors_[var_435_1.prefab_name] ~= nil then
						local var_435_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_1.prefab_name].transform, "story_v_side_new_1106104", "1106104105", "story_v_side_new_1106104.awb")

						arg_432_1:RecordAudio("1106104105", var_435_6)
						arg_432_1:RecordAudio("1106104105", var_435_6)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104105", "story_v_side_new_1106104.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104105", "story_v_side_new_1106104.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1106104106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1106104106
		arg_436_1.duration_ = 9.47

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1106104107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 1

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:GetWordFromCfg(1106104106)
				local var_439_2 = arg_436_1:FormatText(var_439_1.content)

				arg_436_1.text_.text = var_439_2

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 40 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 40)

				if (40 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 40)) > 0 and var_439_0 < var_439_4 then
					arg_436_1.talkMaxDuration = var_439_4

					if var_439_4 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_4 + 0
					end
				end

				arg_436_1.text_.text = var_439_2
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104106", "story_v_side_new_1106104.awb") ~= 0 then
					local var_439_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104106", "story_v_side_new_1106104.awb") / 1000

					if var_439_5 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + 0
					end

					if var_439_1.prefab_name ~= "" and arg_436_1.actors_[var_439_1.prefab_name] ~= nil then
						local var_439_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_1.prefab_name].transform, "story_v_side_new_1106104", "1106104106", "story_v_side_new_1106104.awb")

						arg_436_1:RecordAudio("1106104106", var_439_6)
						arg_436_1:RecordAudio("1106104106", var_439_6)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104106", "story_v_side_new_1106104.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104106", "story_v_side_new_1106104.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_7 and arg_436_1.time_ < 0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1106104107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1106104107
		arg_440_1.duration_ = 6.5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1106104108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.725

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_1 = arg_440_1:GetWordFromCfg(1106104107)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 29 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 29)

				if (29 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 29)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104107", "story_v_side_new_1106104.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104107", "story_v_side_new_1106104.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_side_new_1106104", "1106104107", "story_v_side_new_1106104.awb")

						arg_440_1:RecordAudio("1106104107", var_443_6)
						arg_440_1:RecordAudio("1106104107", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104107", "story_v_side_new_1106104.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104107", "story_v_side_new_1106104.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1106104108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1106104108
		arg_444_1.duration_ = 7.43

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1106104109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.75

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:GetWordFromCfg(1106104108)
				local var_447_2 = arg_444_1:FormatText(var_447_1.content)

				arg_444_1.text_.text = var_447_2

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 30 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 30)

				if (30 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 30)) > 0 and var_447_0 < var_447_4 then
					arg_444_1.talkMaxDuration = var_447_4

					if var_447_4 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_4 + 0
					end
				end

				arg_444_1.text_.text = var_447_2
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104108", "story_v_side_new_1106104.awb") ~= 0 then
					local var_447_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104108", "story_v_side_new_1106104.awb") / 1000

					if var_447_5 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + 0
					end

					if var_447_1.prefab_name ~= "" and arg_444_1.actors_[var_447_1.prefab_name] ~= nil then
						local var_447_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_1.prefab_name].transform, "story_v_side_new_1106104", "1106104108", "story_v_side_new_1106104.awb")

						arg_444_1:RecordAudio("1106104108", var_447_6)
						arg_444_1:RecordAudio("1106104108", var_447_6)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104108", "story_v_side_new_1106104.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104108", "story_v_side_new_1106104.awb")
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
	Play1106104109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1106104109
		arg_448_1.duration_ = 6.17

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1106104110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.625

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_1 = arg_448_1:GetWordFromCfg(1106104109)
				local var_451_2 = arg_448_1:FormatText(var_451_1.content)

				arg_448_1.text_.text = var_451_2

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 25 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 25)

				if (25 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 25)) > 0 and var_451_0 < var_451_4 then
					arg_448_1.talkMaxDuration = var_451_4

					if var_451_4 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_4 + 0
					end
				end

				arg_448_1.text_.text = var_451_2
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104109", "story_v_side_new_1106104.awb") ~= 0 then
					local var_451_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104109", "story_v_side_new_1106104.awb") / 1000

					if var_451_5 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + 0
					end

					if var_451_1.prefab_name ~= "" and arg_448_1.actors_[var_451_1.prefab_name] ~= nil then
						local var_451_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_1.prefab_name].transform, "story_v_side_new_1106104", "1106104109", "story_v_side_new_1106104.awb")

						arg_448_1:RecordAudio("1106104109", var_451_6)
						arg_448_1:RecordAudio("1106104109", var_451_6)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104109", "story_v_side_new_1106104.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104109", "story_v_side_new_1106104.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1106104110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1106104110
		arg_452_1.duration_ = 5.47

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1106104111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.45

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_1 = arg_452_1:GetWordFromCfg(1106104110)
				local var_455_2 = arg_452_1:FormatText(var_455_1.content)

				arg_452_1.text_.text = var_455_2

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_4 = 18 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_2) / 18)

				if (18 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_2) / 18)) > 0 and var_455_0 < var_455_4 then
					arg_452_1.talkMaxDuration = var_455_4

					if var_455_4 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_4 + 0
					end
				end

				arg_452_1.text_.text = var_455_2
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104110", "story_v_side_new_1106104.awb") ~= 0 then
					local var_455_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104110", "story_v_side_new_1106104.awb") / 1000

					if var_455_5 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + 0
					end

					if var_455_1.prefab_name ~= "" and arg_452_1.actors_[var_455_1.prefab_name] ~= nil then
						local var_455_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_1.prefab_name].transform, "story_v_side_new_1106104", "1106104110", "story_v_side_new_1106104.awb")

						arg_452_1:RecordAudio("1106104110", var_455_6)
						arg_452_1:RecordAudio("1106104110", var_455_6)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104110", "story_v_side_new_1106104.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104110", "story_v_side_new_1106104.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_7 and arg_452_1.time_ < 0 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1106104111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1106104111
		arg_456_1.duration_ = 2.97

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1106104112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.25

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_1 = arg_456_1:GetWordFromCfg(1106104111)
				local var_459_2 = arg_456_1:FormatText(var_459_1.content)

				arg_456_1.text_.text = var_459_2

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_4 = 10 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 10)

				if (10 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 10)) > 0 and var_459_0 < var_459_4 then
					arg_456_1.talkMaxDuration = var_459_4

					if var_459_4 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_4 + 0
					end
				end

				arg_456_1.text_.text = var_459_2
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104111", "story_v_side_new_1106104.awb") ~= 0 then
					local var_459_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104111", "story_v_side_new_1106104.awb") / 1000

					if var_459_5 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + 0
					end

					if var_459_1.prefab_name ~= "" and arg_456_1.actors_[var_459_1.prefab_name] ~= nil then
						local var_459_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_1.prefab_name].transform, "story_v_side_new_1106104", "1106104111", "story_v_side_new_1106104.awb")

						arg_456_1:RecordAudio("1106104111", var_459_6)
						arg_456_1:RecordAudio("1106104111", var_459_6)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104111", "story_v_side_new_1106104.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104111", "story_v_side_new_1106104.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_7 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_7

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1106104112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1106104112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1106104113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0.15

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_1 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(1106104112).content)

				arg_460_1.text_.text = var_463_1

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_3 = 6 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 6)

				if (6 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 6)) > 0 and var_463_0 < var_463_3 then
					arg_460_1.talkMaxDuration = var_463_3

					if var_463_3 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_3 + 0
					end
				end

				arg_460_1.text_.text = var_463_1
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_4 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_4 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_4

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_4 and arg_460_1.time_ < 0 + var_463_4 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1106104113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1106104113
		arg_464_1.duration_ = 4.57

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1106104114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0.5

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_1 = arg_464_1:GetWordFromCfg(1106104113)
				local var_467_2 = arg_464_1:FormatText(var_467_1.content)

				arg_464_1.text_.text = var_467_2

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_4 = 20 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_2) / 20)

				if (20 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_2) / 20)) > 0 and var_467_0 < var_467_4 then
					arg_464_1.talkMaxDuration = var_467_4

					if var_467_4 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_4 + 0
					end
				end

				arg_464_1.text_.text = var_467_2
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104113", "story_v_side_new_1106104.awb") ~= 0 then
					local var_467_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104113", "story_v_side_new_1106104.awb") / 1000

					if var_467_5 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + 0
					end

					if var_467_1.prefab_name ~= "" and arg_464_1.actors_[var_467_1.prefab_name] ~= nil then
						local var_467_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_1.prefab_name].transform, "story_v_side_new_1106104", "1106104113", "story_v_side_new_1106104.awb")

						arg_464_1:RecordAudio("1106104113", var_467_6)
						arg_464_1:RecordAudio("1106104113", var_467_6)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104113", "story_v_side_new_1106104.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104113", "story_v_side_new_1106104.awb")
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
	Play1106104114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1106104114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1106104115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.95

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(1106104114).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 38 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 38)

				if (38 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 38)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1106104115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1106104115
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1106104116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.25

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_1 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(1106104115).content)

				arg_472_1.text_.text = var_475_1

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_3 = 10 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_1) / 10)

				if (10 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_1) / 10)) > 0 and var_475_0 < var_475_3 then
					arg_472_1.talkMaxDuration = var_475_3

					if var_475_3 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_3 + 0
					end
				end

				arg_472_1.text_.text = var_475_1
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_4 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_4 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_4

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_4 and arg_472_1.time_ < 0 + var_475_4 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1106104116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1106104116
		arg_476_1.duration_ = 3.73

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1106104117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.175

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_1 = arg_476_1:GetWordFromCfg(1106104116)
				local var_479_2 = arg_476_1:FormatText(var_479_1.content)

				arg_476_1.text_.text = var_479_2

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 7 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 7)

				if (7 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 7)) > 0 and var_479_0 < var_479_4 then
					arg_476_1.talkMaxDuration = var_479_4

					if var_479_4 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_4 + 0
					end
				end

				arg_476_1.text_.text = var_479_2
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104116", "story_v_side_new_1106104.awb") ~= 0 then
					local var_479_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104116", "story_v_side_new_1106104.awb") / 1000

					if var_479_5 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + 0
					end

					if var_479_1.prefab_name ~= "" and arg_476_1.actors_[var_479_1.prefab_name] ~= nil then
						local var_479_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_1.prefab_name].transform, "story_v_side_new_1106104", "1106104116", "story_v_side_new_1106104.awb")

						arg_476_1:RecordAudio("1106104116", var_479_6)
						arg_476_1:RecordAudio("1106104116", var_479_6)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104116", "story_v_side_new_1106104.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104116", "story_v_side_new_1106104.awb")
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
	Play1106104117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1106104117
		arg_480_1.duration_ = 7

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1106104118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if arg_480_1.bgs_.R6101a == nil then
				local var_483_0 = Object.Instantiate(arg_480_1.paintGo_)

				var_483_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R6101a")
				var_483_0.name = "R6101a"
				var_483_0.transform.parent = arg_480_1.stage_.transform
				var_483_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_480_1.bgs_.R6101a = var_483_0
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				local var_483_1 = arg_480_1.bgs_.R6101a

				arg_480_1.bgs_.R6101a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_483_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_483_2 = var_483_1:GetComponent("SpriteRenderer")

				if var_483_2 and var_483_2.sprite then
					local var_483_3 = 2 * (var_483_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_483_1.transform.localScale = Vector3.New(var_483_3 / var_483_2.sprite.bounds.size.y < var_483_3 * manager.ui.mainCameraCom_.aspect / var_483_2.sprite.bounds.size.x and var_483_3 * manager.ui.mainCameraCom_.aspect / var_483_2.sprite.bounds.size.x or var_483_3 / var_483_2.sprite.bounds.size.y, var_483_3 / var_483_2.sprite.bounds.size.y < var_483_3 * manager.ui.mainCameraCom_.aspect / var_483_2.sprite.bounds.size.x and var_483_3 * manager.ui.mainCameraCom_.aspect / var_483_2.sprite.bounds.size.x or var_483_3 / var_483_2.sprite.bounds.size.y, 0)
				end

				for iter_483_0, iter_483_1 in pairs(arg_480_1.bgs_) do
					if iter_483_0 ~= "R6101a" then
						iter_483_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_483_4 = 0

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.allBtn_.enabled = false
			end

			if arg_480_1.time_ >= var_483_4 + 0.3 and arg_480_1.time_ < var_483_4 + 0.3 + arg_483_0 then
				arg_480_1.allBtn_.enabled = true
			end

			local var_483_5 = 0

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_5 + arg_483_0 then
				arg_480_1.mask_.enabled = true
				arg_480_1.mask_.raycastTarget = true

				arg_480_1:SetGaussion(false)
			end

			local var_483_6 = 1

			if var_483_5 <= arg_480_1.time_ and arg_480_1.time_ < var_483_5 + var_483_6 then
				local var_483_7 = Color.New(1, 1, 1)

				var_483_7.a = Mathf.Lerp(1, 0, (arg_480_1.time_ - var_483_5) / var_483_6)
				arg_480_1.mask_.color = var_483_7
			end

			if arg_480_1.time_ >= var_483_5 + var_483_6 and arg_480_1.time_ < var_483_5 + var_483_6 + arg_483_0 then
				local var_483_8 = Color.New(1, 1, 1)

				arg_480_1.mask_.enabled = false
				var_483_8.a = 0
				arg_480_1.mask_.color = var_483_8
			end

			if 0.0666666666666667 < arg_480_1.time_ and arg_480_1.time_ <= 0.0666666666666667 + arg_483_0 then
				arg_480_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_crowd_up", "")
			end

			if 0.0666666666666667 < arg_480_1.time_ and arg_480_1.time_ <= 0.0666666666666667 + arg_483_0 then
				arg_480_1:AudioAction("stop", "effect", "se_story_side_1061", "se_story_side_1061_crowd_down", "")
			end

			if arg_480_1.frameCnt_ <= 1 then
				arg_480_1.dialog_:SetActive(false)
			end

			local var_483_11 = 2
			local var_483_12 = 1.025

			if 2 < arg_480_1.time_ and arg_480_1.time_ <= var_483_11 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0

				arg_480_1.dialog_:SetActive(true)

				arg_480_1.dialogCg_.alpha = 0

				local var_483_13 = LeanTween.value(arg_480_1.dialog_, 0, 1, 0.3)

				var_483_13:setOnUpdate(LuaHelper.FloatAction(function(arg_484_0)
					arg_480_1.dialogCg_.alpha = arg_484_0
				end))
				var_483_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_480_1.dialog_)
					var_483_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_480_1.duration_ = arg_480_1.duration_ + 0.3

				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_14 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(1106104117).content)

				arg_480_1.text_.text = var_483_14

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_16 = 41 <= 0 and var_483_12 or var_483_12 * (utf8.len(var_483_14) / 41)

				if (41 <= 0 and var_483_12 or var_483_12 * (utf8.len(var_483_14) / 41)) > 0 and var_483_12 < var_483_16 then
					arg_480_1.talkMaxDuration = var_483_16
					var_483_11 = var_483_11 + 0.3

					if var_483_16 + var_483_11 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_16 + var_483_11
					end
				end

				arg_480_1.text_.text = var_483_14
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_17 = var_483_11 + 0.3
			local var_483_18 = math.max(var_483_12, arg_480_1.talkMaxDuration)

			if var_483_11 + 0.3 <= arg_480_1.time_ and arg_480_1.time_ < var_483_17 + var_483_18 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_17) / var_483_18

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_17 + var_483_18 and arg_480_1.time_ < var_483_17 + var_483_18 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1106104118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1106104118
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1106104119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.975

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_1 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(1106104118).content)

				arg_486_1.text_.text = var_489_1

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_3 = 39 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 39)

				if (39 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 39)) > 0 and var_489_0 < var_489_3 then
					arg_486_1.talkMaxDuration = var_489_3

					if var_489_3 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_3 + 0
					end
				end

				arg_486_1.text_.text = var_489_1
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_4 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_4 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_4

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_4 and arg_486_1.time_ < 0 + var_489_4 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1106104119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1106104119
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1106104120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0.125

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_1 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(1106104119).content)

				arg_490_1.text_.text = var_493_1

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_3 = 5 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 5)

				if (5 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 5)) > 0 and var_493_0 < var_493_3 then
					arg_490_1.talkMaxDuration = var_493_3

					if var_493_3 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_3 + 0
					end
				end

				arg_490_1.text_.text = var_493_1
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_4 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_4

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1106104120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1106104120
		arg_494_1.duration_ = 5.57

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1106104121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.65

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_1 = arg_494_1:GetWordFromCfg(1106104120)
				local var_497_2 = arg_494_1:FormatText(var_497_1.content)

				arg_494_1.text_.text = var_497_2

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_4 = 26 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 26)

				if (26 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 26)) > 0 and var_497_0 < var_497_4 then
					arg_494_1.talkMaxDuration = var_497_4

					if var_497_4 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_4 + 0
					end
				end

				arg_494_1.text_.text = var_497_2
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104120", "story_v_side_new_1106104.awb") ~= 0 then
					local var_497_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104120", "story_v_side_new_1106104.awb") / 1000

					if var_497_5 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + 0
					end

					if var_497_1.prefab_name ~= "" and arg_494_1.actors_[var_497_1.prefab_name] ~= nil then
						local var_497_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_1.prefab_name].transform, "story_v_side_new_1106104", "1106104120", "story_v_side_new_1106104.awb")

						arg_494_1:RecordAudio("1106104120", var_497_6)
						arg_494_1:RecordAudio("1106104120", var_497_6)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104120", "story_v_side_new_1106104.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104120", "story_v_side_new_1106104.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_7 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_7 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_7

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_7 and arg_494_1.time_ < 0 + var_497_7 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1106104121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1106104121
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1106104122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.525

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_1 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(1106104121).content)

				arg_498_1.text_.text = var_501_1

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_3 = 21 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_1) / 21)

				if (21 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_1) / 21)) > 0 and var_501_0 < var_501_3 then
					arg_498_1.talkMaxDuration = var_501_3

					if var_501_3 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_3 + 0
					end
				end

				arg_498_1.text_.text = var_501_1
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_4 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_4 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_4

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_4 and arg_498_1.time_ < 0 + var_501_4 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1106104122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1106104122
		arg_502_1.duration_ = 3.6

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1106104123(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.45

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_1 = arg_502_1:GetWordFromCfg(1106104122)
				local var_505_2 = arg_502_1:FormatText(var_505_1.content)

				arg_502_1.text_.text = var_505_2

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 18 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 18)

				if (18 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 18)) > 0 and var_505_0 < var_505_4 then
					arg_502_1.talkMaxDuration = var_505_4

					if var_505_4 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_4 + 0
					end
				end

				arg_502_1.text_.text = var_505_2
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104122", "story_v_side_new_1106104.awb") ~= 0 then
					local var_505_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104122", "story_v_side_new_1106104.awb") / 1000

					if var_505_5 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + 0
					end

					if var_505_1.prefab_name ~= "" and arg_502_1.actors_[var_505_1.prefab_name] ~= nil then
						local var_505_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_1.prefab_name].transform, "story_v_side_new_1106104", "1106104122", "story_v_side_new_1106104.awb")

						arg_502_1:RecordAudio("1106104122", var_505_6)
						arg_502_1:RecordAudio("1106104122", var_505_6)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104122", "story_v_side_new_1106104.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104122", "story_v_side_new_1106104.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_7 and arg_502_1.time_ < 0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1106104123 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1106104123
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1106104124(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.5

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(1106104123).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 20 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 20)

				if (20 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 20)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1106104124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1106104124
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1106104125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.825

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(1106104124).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 33 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 33)

				if (33 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 33)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1106104125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1106104125
		arg_514_1.duration_ = 1

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"

			SetActive(arg_514_1.choicesGo_, true)

			for iter_515_0, iter_515_1 in ipairs(arg_514_1.choices_) do
				SetActive(iter_515_1.go, iter_515_0 <= 1)
			end

			arg_514_1.choices_[1].txt.text = arg_514_1:FormatText(StoryChoiceCfg[1397].name)
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1106104126(arg_514_1)
			end

			arg_514_1:RecordChoiceLog(1106104125, 1397)
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			return
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play1106104126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1106104126
		arg_518_1.duration_ = 2.31

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1106104127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPosR6101a = arg_518_1.bgs_.R6101a.transform.localPosition
			end

			local var_521_0 = 1.63333333333333

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 then
				arg_518_1.bgs_.R6101a.transform.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPosR6101a, Vector3.New(0, 0.65, 8), (arg_518_1.time_ - 0) / var_521_0)
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 then
				arg_518_1.bgs_.R6101a.transform.localPosition = Vector3.New(0, 0.65, 8)
			end

			local var_521_1

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				local var_521_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_521_2 then
					var_521_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_521_2.radialBlurScale = 0
					var_521_2.radialBlurGradient = 1
					var_521_2.radialBlurIntensity = 1

					if var_521_1 then
						var_521_2.radialBlurTarget = var_521_1.transform
					end
				end
			end

			local var_521_3 = 1.83333333333333

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 then
				local var_521_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_521_4 then
					var_521_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_521_4.radialBlurScale = Mathf.Lerp(0, 0, (arg_518_1.time_ - 0) / var_521_3)
					var_521_4.radialBlurGradient = Mathf.Lerp(1, 1, (arg_518_1.time_ - 0) / var_521_3)
					var_521_4.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_518_1.time_ - 0) / var_521_3)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 then
				local var_521_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_521_5 then
					var_521_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_521_5.radialBlurScale = 0
					var_521_5.radialBlurGradient = 1
					var_521_5.radialBlurIntensity = 1
				end
			end

			if arg_518_1.frameCnt_ <= 1 then
				arg_518_1.dialog_:SetActive(false)
			end

			local var_521_6 = 0.875
			local var_521_7 = 0.125

			if 0.875 < arg_518_1.time_ and arg_518_1.time_ <= var_521_6 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0

				arg_518_1.dialog_:SetActive(true)

				arg_518_1.dialogCg_.alpha = 0

				local var_521_8 = LeanTween.value(arg_518_1.dialog_, 0, 1, 0.3)

				var_521_8:setOnUpdate(LuaHelper.FloatAction(function(arg_522_0)
					arg_518_1.dialogCg_.alpha = arg_522_0
				end))
				var_521_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_518_1.dialog_)
					var_521_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_518_1.duration_ = arg_518_1.duration_ + 0.3

				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_9 = arg_518_1:GetWordFromCfg(1106104126)
				local var_521_10 = arg_518_1:FormatText(var_521_9.content)

				arg_518_1.text_.text = var_521_10

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_12 = 5 <= 0 and var_521_7 or var_521_7 * (utf8.len(var_521_10) / 5)

				if (5 <= 0 and var_521_7 or var_521_7 * (utf8.len(var_521_10) / 5)) > 0 and var_521_7 < var_521_12 then
					arg_518_1.talkMaxDuration = var_521_12
					var_521_6 = var_521_6 + 0.3

					if var_521_12 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_12 + var_521_6
					end
				end

				arg_518_1.text_.text = var_521_10
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104126", "story_v_side_new_1106104.awb") ~= 0 then
					local var_521_13 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104126", "story_v_side_new_1106104.awb") / 1000

					if var_521_13 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_13 + var_521_6
					end

					if var_521_9.prefab_name ~= "" and arg_518_1.actors_[var_521_9.prefab_name] ~= nil then
						local var_521_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_9.prefab_name].transform, "story_v_side_new_1106104", "1106104126", "story_v_side_new_1106104.awb")

						arg_518_1:RecordAudio("1106104126", var_521_14)
						arg_518_1:RecordAudio("1106104126", var_521_14)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104126", "story_v_side_new_1106104.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104126", "story_v_side_new_1106104.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_15 = var_521_6 + 0.3
			local var_521_16 = math.max(var_521_7, arg_518_1.talkMaxDuration)

			if var_521_6 + 0.3 <= arg_518_1.time_ and arg_518_1.time_ < var_521_15 + var_521_16 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_15) / var_521_16

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_15 + var_521_16 and arg_518_1.time_ < var_521_15 + var_521_16 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R6101a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.63333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play1106104127 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1106104127
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1106104128(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.35

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_1 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(1106104127).content)

				arg_524_1.text_.text = var_527_1

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_3 = 14 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 14)

				if (14 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 14)) > 0 and var_527_0 < var_527_3 then
					arg_524_1.talkMaxDuration = var_527_3

					if var_527_3 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_3 + 0
					end
				end

				arg_524_1.text_.text = var_527_1
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_4 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_4

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play1106104128 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1106104128
		arg_528_1.duration_ = 2.4

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1106104129(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.225

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:GetWordFromCfg(1106104128)
				local var_531_2 = arg_528_1:FormatText(var_531_1.content)

				arg_528_1.text_.text = var_531_2

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 9 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 9)

				if (9 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 9)) > 0 and var_531_0 < var_531_4 then
					arg_528_1.talkMaxDuration = var_531_4

					if var_531_4 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_4 + 0
					end
				end

				arg_528_1.text_.text = var_531_2
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104128", "story_v_side_new_1106104.awb") ~= 0 then
					local var_531_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104128", "story_v_side_new_1106104.awb") / 1000

					if var_531_5 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_5 + 0
					end

					if var_531_1.prefab_name ~= "" and arg_528_1.actors_[var_531_1.prefab_name] ~= nil then
						local var_531_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_1.prefab_name].transform, "story_v_side_new_1106104", "1106104128", "story_v_side_new_1106104.awb")

						arg_528_1:RecordAudio("1106104128", var_531_6)
						arg_528_1:RecordAudio("1106104128", var_531_6)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104128", "story_v_side_new_1106104.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104128", "story_v_side_new_1106104.awb")
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
	Play1106104129 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1106104129
		arg_532_1.duration_ = 5.23

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1106104130(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.5

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:GetWordFromCfg(1106104129)
				local var_535_2 = arg_532_1:FormatText(var_535_1.content)

				arg_532_1.text_.text = var_535_2

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 20 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 20)

				if (20 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 20)) > 0 and var_535_0 < var_535_4 then
					arg_532_1.talkMaxDuration = var_535_4

					if var_535_4 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_4 + 0
					end
				end

				arg_532_1.text_.text = var_535_2
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104129", "story_v_side_new_1106104.awb") ~= 0 then
					local var_535_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104129", "story_v_side_new_1106104.awb") / 1000

					if var_535_5 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + 0
					end

					if var_535_1.prefab_name ~= "" and arg_532_1.actors_[var_535_1.prefab_name] ~= nil then
						local var_535_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_1.prefab_name].transform, "story_v_side_new_1106104", "1106104129", "story_v_side_new_1106104.awb")

						arg_532_1:RecordAudio("1106104129", var_535_6)
						arg_532_1:RecordAudio("1106104129", var_535_6)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104129", "story_v_side_new_1106104.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104129", "story_v_side_new_1106104.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_7 and arg_532_1.time_ < 0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1106104130 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1106104130
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1106104131(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0.225

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_1 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(1106104130).content)

				arg_536_1.text_.text = var_539_1

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_3 = 9 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 9)

				if (9 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 9)) > 0 and var_539_0 < var_539_3 then
					arg_536_1.talkMaxDuration = var_539_3

					if var_539_3 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_3 + 0
					end
				end

				arg_536_1.text_.text = var_539_1
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_4 = math.max(var_539_0, arg_536_1.talkMaxDuration)

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_4 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - 0) / var_539_4

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= 0 + var_539_4 and arg_536_1.time_ < 0 + var_539_4 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1106104131 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1106104131
		arg_540_1.duration_ = 3.37

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1106104132(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.3

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_1 = arg_540_1:GetWordFromCfg(1106104131)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104131", "story_v_side_new_1106104.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104131", "story_v_side_new_1106104.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_side_new_1106104", "1106104131", "story_v_side_new_1106104.awb")

						arg_540_1:RecordAudio("1106104131", var_543_6)
						arg_540_1:RecordAudio("1106104131", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104131", "story_v_side_new_1106104.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104131", "story_v_side_new_1106104.awb")
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
	Play1106104132 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1106104132
		arg_544_1.duration_ = 2.03

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1106104133(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.275

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_1 = arg_544_1:GetWordFromCfg(1106104132)
				local var_547_2 = arg_544_1:FormatText(var_547_1.content)

				arg_544_1.text_.text = var_547_2

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 11 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 11)

				if (11 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 11)) > 0 and var_547_0 < var_547_4 then
					arg_544_1.talkMaxDuration = var_547_4

					if var_547_4 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_4 + 0
					end
				end

				arg_544_1.text_.text = var_547_2
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104132", "story_v_side_new_1106104.awb") ~= 0 then
					local var_547_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104132", "story_v_side_new_1106104.awb") / 1000

					if var_547_5 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + 0
					end

					if var_547_1.prefab_name ~= "" and arg_544_1.actors_[var_547_1.prefab_name] ~= nil then
						local var_547_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_1.prefab_name].transform, "story_v_side_new_1106104", "1106104132", "story_v_side_new_1106104.awb")

						arg_544_1:RecordAudio("1106104132", var_547_6)
						arg_544_1:RecordAudio("1106104132", var_547_6)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104132", "story_v_side_new_1106104.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104132", "story_v_side_new_1106104.awb")
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
	Play1106104133 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1106104133
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1106104134(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.1

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_1 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(1106104133).content)

				arg_548_1.text_.text = var_551_1

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_3 = 4 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 4)

				if (4 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 4)) > 0 and var_551_0 < var_551_3 then
					arg_548_1.talkMaxDuration = var_551_3

					if var_551_3 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_3 + 0
					end
				end

				arg_548_1.text_.text = var_551_1
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_4 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_4

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1106104134 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1106104134
		arg_552_1.duration_ = 9.53

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1106104135(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 1.2

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_1 = arg_552_1:GetWordFromCfg(1106104134)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 48 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 48)

				if (48 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 48)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104134", "story_v_side_new_1106104.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104134", "story_v_side_new_1106104.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_side_new_1106104", "1106104134", "story_v_side_new_1106104.awb")

						arg_552_1:RecordAudio("1106104134", var_555_6)
						arg_552_1:RecordAudio("1106104134", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104134", "story_v_side_new_1106104.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104134", "story_v_side_new_1106104.awb")
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
	Play1106104135 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1106104135
		arg_556_1.duration_ = 3.53

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1106104136(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.325

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_1 = arg_556_1:GetWordFromCfg(1106104135)
				local var_559_2 = arg_556_1:FormatText(var_559_1.content)

				arg_556_1.text_.text = var_559_2

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 13 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 13)

				if (13 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 13)) > 0 and var_559_0 < var_559_4 then
					arg_556_1.talkMaxDuration = var_559_4

					if var_559_4 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_4 + 0
					end
				end

				arg_556_1.text_.text = var_559_2
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104135", "story_v_side_new_1106104.awb") ~= 0 then
					local var_559_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104135", "story_v_side_new_1106104.awb") / 1000

					if var_559_5 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + 0
					end

					if var_559_1.prefab_name ~= "" and arg_556_1.actors_[var_559_1.prefab_name] ~= nil then
						local var_559_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_1.prefab_name].transform, "story_v_side_new_1106104", "1106104135", "story_v_side_new_1106104.awb")

						arg_556_1:RecordAudio("1106104135", var_559_6)
						arg_556_1:RecordAudio("1106104135", var_559_6)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104135", "story_v_side_new_1106104.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104135", "story_v_side_new_1106104.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1106104136 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1106104136
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1106104137(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.275

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_1 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(1106104136).content)

				arg_560_1.text_.text = var_563_1

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_3 = 11 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_1) / 11)

				if (11 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_1) / 11)) > 0 and var_563_0 < var_563_3 then
					arg_560_1.talkMaxDuration = var_563_3

					if var_563_3 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_3 + 0
					end
				end

				arg_560_1.text_.text = var_563_1
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_4 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_4 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_4

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_4 and arg_560_1.time_ < 0 + var_563_4 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play1106104137 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1106104137
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1106104138(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0.5

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_1 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(1106104137).content)

				arg_564_1.text_.text = var_567_1

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_3 = 20 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_1) / 20)

				if (20 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_1) / 20)) > 0 and var_567_0 < var_567_3 then
					arg_564_1.talkMaxDuration = var_567_3

					if var_567_3 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_3 + 0
					end
				end

				arg_564_1.text_.text = var_567_1
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_4 = math.max(var_567_0, arg_564_1.talkMaxDuration)

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_4 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - 0) / var_567_4

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= 0 + var_567_4 and arg_564_1.time_ < 0 + var_567_4 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1106104138 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1106104138
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1106104139(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0.3

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_1 = arg_568_1:GetWordFromCfg(1106104138)
				local var_571_2 = arg_568_1:FormatText(var_571_1.content)

				arg_568_1.text_.text = var_571_2

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_4 = 12 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_2) / 12)

				if (12 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_2) / 12)) > 0 and var_571_0 < var_571_4 then
					arg_568_1.talkMaxDuration = var_571_4

					if var_571_4 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_4 + 0
					end
				end

				arg_568_1.text_.text = var_571_2
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104138", "story_v_side_new_1106104.awb") ~= 0 then
					local var_571_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104138", "story_v_side_new_1106104.awb") / 1000

					if var_571_5 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_5 + 0
					end

					if var_571_1.prefab_name ~= "" and arg_568_1.actors_[var_571_1.prefab_name] ~= nil then
						local var_571_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_1.prefab_name].transform, "story_v_side_new_1106104", "1106104138", "story_v_side_new_1106104.awb")

						arg_568_1:RecordAudio("1106104138", var_571_6)
						arg_568_1:RecordAudio("1106104138", var_571_6)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104138", "story_v_side_new_1106104.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104138", "story_v_side_new_1106104.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_7 = math.max(var_571_0, arg_568_1.talkMaxDuration)

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_7 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - 0) / var_571_7

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= 0 + var_571_7 and arg_568_1.time_ < 0 + var_571_7 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1106104139 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1106104139
		arg_572_1.duration_ = 5.77

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1106104140(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				local var_575_0 = arg_572_1.bgs_.R6101a

				arg_572_1.bgs_.R6101a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_575_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_575_1 = var_575_0:GetComponent("SpriteRenderer")

				if var_575_1 and var_575_1.sprite then
					local var_575_2 = 2 * (var_575_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_575_0.transform.localScale = Vector3.New(var_575_2 / var_575_1.sprite.bounds.size.y < var_575_2 * manager.ui.mainCameraCom_.aspect / var_575_1.sprite.bounds.size.x and var_575_2 * manager.ui.mainCameraCom_.aspect / var_575_1.sprite.bounds.size.x or var_575_2 / var_575_1.sprite.bounds.size.y, var_575_2 / var_575_1.sprite.bounds.size.y < var_575_2 * manager.ui.mainCameraCom_.aspect / var_575_1.sprite.bounds.size.x and var_575_2 * manager.ui.mainCameraCom_.aspect / var_575_1.sprite.bounds.size.x or var_575_2 / var_575_1.sprite.bounds.size.y, 0)
				end

				for iter_575_0, iter_575_1 in pairs(arg_572_1.bgs_) do
					if iter_575_0 ~= "R6101a" then
						iter_575_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_575_3 = 0

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_3 + arg_575_0 then
				arg_572_1.mask_.enabled = true
				arg_572_1.mask_.raycastTarget = true

				arg_572_1:SetGaussion(false)
			end

			local var_575_4 = 0.9

			if var_575_3 <= arg_572_1.time_ and arg_572_1.time_ < var_575_3 + var_575_4 then
				local var_575_5 = Color.New(0.05660379, 0.05660379, 0.05660379)

				var_575_5.a = Mathf.Lerp(1, 0, (arg_572_1.time_ - var_575_3) / var_575_4)
				arg_572_1.mask_.color = var_575_5
			end

			if arg_572_1.time_ >= var_575_3 + var_575_4 and arg_572_1.time_ < var_575_3 + var_575_4 + arg_575_0 then
				local var_575_6 = Color.New(0.05660379, 0.05660379, 0.05660379)

				arg_572_1.mask_.enabled = false
				var_575_6.a = 0
				arg_572_1.mask_.color = var_575_6
			end

			if arg_572_1.frameCnt_ <= 1 then
				arg_572_1.dialog_:SetActive(false)
			end

			local var_575_7 = 0.766666666666667
			local var_575_8 = 0.875

			if 0.766666666666667 < arg_572_1.time_ and arg_572_1.time_ <= var_575_7 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0

				arg_572_1.dialog_:SetActive(true)

				arg_572_1.dialogCg_.alpha = 0

				local var_575_9 = LeanTween.value(arg_572_1.dialog_, 0, 1, 0.3)

				var_575_9:setOnUpdate(LuaHelper.FloatAction(function(arg_576_0)
					arg_572_1.dialogCg_.alpha = arg_576_0
				end))
				var_575_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_572_1.dialog_)
					var_575_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_572_1.duration_ = arg_572_1.duration_ + 0.3

				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_10 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(1106104139).content)

				arg_572_1.text_.text = var_575_10

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_12 = 35 <= 0 and var_575_8 or var_575_8 * (utf8.len(var_575_10) / 35)

				if (35 <= 0 and var_575_8 or var_575_8 * (utf8.len(var_575_10) / 35)) > 0 and var_575_8 < var_575_12 then
					arg_572_1.talkMaxDuration = var_575_12
					var_575_7 = var_575_7 + 0.3

					if var_575_12 + var_575_7 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_12 + var_575_7
					end
				end

				arg_572_1.text_.text = var_575_10
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_13 = var_575_7 + 0.3
			local var_575_14 = math.max(var_575_8, arg_572_1.talkMaxDuration)

			if var_575_7 + 0.3 <= arg_572_1.time_ and arg_572_1.time_ < var_575_13 + var_575_14 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_13) / var_575_14

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_13 + var_575_14 and arg_572_1.time_ < var_575_13 + var_575_14 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1106104140 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1106104140
		arg_578_1.duration_ = 1.97

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1106104141(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0.275

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_1 = arg_578_1:GetWordFromCfg(1106104140)
				local var_581_2 = arg_578_1:FormatText(var_581_1.content)

				arg_578_1.text_.text = var_581_2

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_4 = 11 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_2) / 11)

				if (11 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_2) / 11)) > 0 and var_581_0 < var_581_4 then
					arg_578_1.talkMaxDuration = var_581_4

					if var_581_4 + 0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_4 + 0
					end
				end

				arg_578_1.text_.text = var_581_2
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104140", "story_v_side_new_1106104.awb") ~= 0 then
					local var_581_5 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104140", "story_v_side_new_1106104.awb") / 1000

					if var_581_5 + 0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_5 + 0
					end

					if var_581_1.prefab_name ~= "" and arg_578_1.actors_[var_581_1.prefab_name] ~= nil then
						local var_581_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_1.prefab_name].transform, "story_v_side_new_1106104", "1106104140", "story_v_side_new_1106104.awb")

						arg_578_1:RecordAudio("1106104140", var_581_6)
						arg_578_1:RecordAudio("1106104140", var_581_6)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104140", "story_v_side_new_1106104.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104140", "story_v_side_new_1106104.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_7 = math.max(var_581_0, arg_578_1.talkMaxDuration)

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_7 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - 0) / var_581_7

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= 0 + var_581_7 and arg_578_1.time_ < 0 + var_581_7 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1106104141 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1106104141
		arg_582_1.duration_ = 9

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1106104142(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if arg_582_1.bgs_.ST42 == nil then
				local var_585_0 = Object.Instantiate(arg_582_1.paintGo_)

				var_585_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42")
				var_585_0.name = "ST42"
				var_585_0.transform.parent = arg_582_1.stage_.transform
				var_585_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_582_1.bgs_.ST42 = var_585_0
			end

			if 2 < arg_582_1.time_ and arg_582_1.time_ <= 2 + arg_585_0 then
				local var_585_1 = arg_582_1.bgs_.ST42

				arg_582_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_585_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_585_2 = var_585_1:GetComponent("SpriteRenderer")

				if var_585_2 and var_585_2.sprite then
					local var_585_3 = 2 * (var_585_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_585_1.transform.localScale = Vector3.New(var_585_3 / var_585_2.sprite.bounds.size.y < var_585_3 * manager.ui.mainCameraCom_.aspect / var_585_2.sprite.bounds.size.x and var_585_3 * manager.ui.mainCameraCom_.aspect / var_585_2.sprite.bounds.size.x or var_585_3 / var_585_2.sprite.bounds.size.y, var_585_3 / var_585_2.sprite.bounds.size.y < var_585_3 * manager.ui.mainCameraCom_.aspect / var_585_2.sprite.bounds.size.x and var_585_3 * manager.ui.mainCameraCom_.aspect / var_585_2.sprite.bounds.size.x or var_585_3 / var_585_2.sprite.bounds.size.y, 0)
				end

				for iter_585_0, iter_585_1 in pairs(arg_582_1.bgs_) do
					if iter_585_0 ~= "ST42" then
						iter_585_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_585_4 = 4

			if 4 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			if arg_582_1.time_ >= var_585_4 + 0.3 and arg_582_1.time_ < var_585_4 + 0.3 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end

			local var_585_5 = 0

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_5 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_6 = 2

			if var_585_5 <= arg_582_1.time_ and arg_582_1.time_ < var_585_5 + var_585_6 then
				local var_585_7 = Color.New(0, 0, 0)

				var_585_7.a = Mathf.Lerp(0, 1, (arg_582_1.time_ - var_585_5) / var_585_6)
				arg_582_1.mask_.color = var_585_7
			end

			if arg_582_1.time_ >= var_585_5 + var_585_6 and arg_582_1.time_ < var_585_5 + var_585_6 + arg_585_0 then
				local var_585_8 = Color.New(0, 0, 0)

				var_585_8.a = 1
				arg_582_1.mask_.color = var_585_8
			end

			local var_585_9 = 2

			if 2 < arg_582_1.time_ and arg_582_1.time_ <= var_585_9 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_10 = 2

			if var_585_9 <= arg_582_1.time_ and arg_582_1.time_ < var_585_9 + var_585_10 then
				local var_585_11 = Color.New(0, 0, 0)

				var_585_11.a = Mathf.Lerp(1, 0, (arg_582_1.time_ - var_585_9) / var_585_10)
				arg_582_1.mask_.color = var_585_11
			end

			if arg_582_1.time_ >= var_585_9 + var_585_10 and arg_582_1.time_ < var_585_9 + var_585_10 + arg_585_0 then
				local var_585_12 = Color.New(0, 0, 0)

				arg_582_1.mask_.enabled = false
				var_585_12.a = 0
				arg_582_1.mask_.color = var_585_12
			end

			if 1.56666666666667 < arg_582_1.time_ and arg_582_1.time_ <= 1.56666666666667 + arg_585_0 then
				arg_582_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0.2 < arg_582_1.time_ and arg_582_1.time_ <= 0.2 + arg_585_0 then
				arg_582_1:AudioAction("stop", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 0.2 < arg_582_1.time_ and arg_582_1.time_ <= 0.2 + arg_585_0 then
				arg_582_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.2 < arg_582_1.time_ and arg_582_1.time_ <= 0.2 + arg_585_0 then
				arg_582_1:AudioAction("stop", "effect", "se_story_side_1061", "se_story_side_1061_crowd_up", "")
			end

			if arg_582_1.frameCnt_ <= 1 then
				arg_582_1.dialog_:SetActive(false)
			end

			local var_585_17 = 4
			local var_585_18 = 0.575

			if 4 < arg_582_1.time_ and arg_582_1.time_ <= var_585_17 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0

				arg_582_1.dialog_:SetActive(true)

				arg_582_1.dialogCg_.alpha = 0

				local var_585_19 = LeanTween.value(arg_582_1.dialog_, 0, 1, 0.3)

				var_585_19:setOnUpdate(LuaHelper.FloatAction(function(arg_586_0)
					arg_582_1.dialogCg_.alpha = arg_586_0
				end))
				var_585_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_582_1.dialog_)
					var_585_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_582_1.duration_ = arg_582_1.duration_ + 0.3

				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_20 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(1106104141).content)

				arg_582_1.text_.text = var_585_20

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_22 = 23 <= 0 and var_585_18 or var_585_18 * (utf8.len(var_585_20) / 23)

				if (23 <= 0 and var_585_18 or var_585_18 * (utf8.len(var_585_20) / 23)) > 0 and var_585_18 < var_585_22 then
					arg_582_1.talkMaxDuration = var_585_22
					var_585_17 = var_585_17 + 0.3

					if var_585_22 + var_585_17 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_22 + var_585_17
					end
				end

				arg_582_1.text_.text = var_585_20
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_23 = var_585_17 + 0.3
			local var_585_24 = math.max(var_585_18, arg_582_1.talkMaxDuration)

			if var_585_17 + 0.3 <= arg_582_1.time_ and arg_582_1.time_ < var_585_23 + var_585_24 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_23) / var_585_24

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_23 + var_585_24 and arg_582_1.time_ < var_585_23 + var_585_24 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1106104142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1106104142
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1106104143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.var_.moveOldPos106101ui_story = arg_588_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_591_0 = 0.001

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_0 then
				arg_588_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_588_1.time_ - 0) / var_591_0)
				arg_588_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_588_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_588_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_588_1.actors_["106101ui_story"].transform.position).z)
				arg_588_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_588_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_588_1.actors_["106101ui_story"].transform.localEulerAngles = arg_588_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_588_1.time_ >= 0 + var_591_0 and arg_588_1.time_ < 0 + var_591_0 + arg_591_0 then
				arg_588_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_588_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_588_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_588_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_588_1.actors_["106101ui_story"].transform.position).z)
				arg_588_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_588_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_588_1.actors_["106101ui_story"].transform.localEulerAngles = arg_588_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_591_1 = arg_588_1.actors_["106101ui_story"]

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 and not isNil(var_591_1) and arg_588_1.var_.characterEffect106101ui_story == nil then
				arg_588_1.var_.characterEffect106101ui_story = var_591_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_591_2 = 0.200000002980232

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_2 and not isNil(var_591_1) then
				if arg_588_1.var_.characterEffect106101ui_story and not isNil(var_591_1) then
					arg_588_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_588_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_588_1.time_ - 0) / var_591_2)
				end
			end

			if arg_588_1.time_ >= 0 + var_591_2 and arg_588_1.time_ < 0 + var_591_2 + arg_591_0 and not isNil(var_591_1) and arg_588_1.var_.characterEffect106101ui_story then
				arg_588_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_588_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_591_3 = 0
			local var_591_4 = 0.4

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_3 + arg_591_0 then
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

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_5 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(1106104142).content)

				arg_588_1.text_.text = var_591_5

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_7 = 16 <= 0 and var_591_4 or var_591_4 * (utf8.len(var_591_5) / 16)

				if (16 <= 0 and var_591_4 or var_591_4 * (utf8.len(var_591_5) / 16)) > 0 and var_591_4 < var_591_7 then
					arg_588_1.talkMaxDuration = var_591_7

					if var_591_7 + var_591_3 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_7 + var_591_3
					end
				end

				arg_588_1.text_.text = var_591_5
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_8 = math.max(var_591_4, arg_588_1.talkMaxDuration)

			if var_591_3 <= arg_588_1.time_ and arg_588_1.time_ < var_591_3 + var_591_8 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_3) / var_591_8

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_3 + var_591_8 and arg_588_1.time_ < var_591_3 + var_591_8 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_588_1:InitPlayNodeList()
	end,
	Play1106104143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1106104143
		arg_592_1.duration_ = 3.53

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play1106104144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if arg_592_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_595_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_592_1.stage_.transform)

				var_595_0.name = "1061ui_story"
				var_595_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_592_1.actors_["1061ui_story"] = var_595_0

				local var_595_1 = var_595_0:GetComponentInChildren(typeof(CharacterEffect))

				var_595_1.enabled = true

				local var_595_2 = GameObjectTools.GetOrAddComponent(var_595_0, typeof(DynamicBoneHelper))

				if var_595_2 then
					var_595_2:EnableDynamicBone(false)
				end

				arg_592_1:ShowWeapon(var_595_1.transform, false)

				arg_592_1.var_["1061ui_story" .. "Animator"] = var_595_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_592_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_592_1.var_["1061ui_story" .. "LipSync"] = var_595_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_595_3 = arg_592_1.actors_["1061ui_story"].transform

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.var_.moveOldPos1061ui_story = var_595_3.localPosition
			end

			local var_595_4 = 0.001

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_4 then
				var_595_3.localPosition = Vector3.Lerp(arg_592_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_592_1.time_ - 0) / var_595_4)
				var_595_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_595_3.position).x, (manager.ui.mainCamera.transform.position - var_595_3.position).y, (manager.ui.mainCamera.transform.position - var_595_3.position).z)
				var_595_3.localEulerAngles.z = 0
				var_595_3.localEulerAngles.x = 0
				var_595_3.localEulerAngles = var_595_3.localEulerAngles
			end

			if arg_592_1.time_ >= 0 + var_595_4 and arg_592_1.time_ < 0 + var_595_4 + arg_595_0 then
				var_595_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_595_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_595_3.position).x, (manager.ui.mainCamera.transform.position - var_595_3.position).y, (manager.ui.mainCamera.transform.position - var_595_3.position).z)
				var_595_3.localEulerAngles.z = 0
				var_595_3.localEulerAngles.x = 0
				var_595_3.localEulerAngles = var_595_3.localEulerAngles
			end

			local var_595_5 = arg_592_1.actors_["1061ui_story"]

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(var_595_5) and arg_592_1.var_.characterEffect1061ui_story == nil then
				arg_592_1.var_.characterEffect1061ui_story = var_595_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_6 = 0.200000002980232

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_6 and not isNil(var_595_5) then
				if arg_592_1.var_.characterEffect1061ui_story and not isNil(var_595_5) then
					arg_592_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= 0 + var_595_6 and arg_592_1.time_ < 0 + var_595_6 + arg_595_0 and not isNil(var_595_5) and arg_592_1.var_.characterEffect1061ui_story then
				arg_592_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_595_8 = 0
			local var_595_9 = 0.45

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_8 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_10 = arg_592_1:GetWordFromCfg(1106104143)
				local var_595_11 = arg_592_1:FormatText(var_595_10.content)

				arg_592_1.text_.text = var_595_11

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_13 = 18 <= 0 and var_595_9 or var_595_9 * (utf8.len(var_595_11) / 18)

				if (18 <= 0 and var_595_9 or var_595_9 * (utf8.len(var_595_11) / 18)) > 0 and var_595_9 < var_595_13 then
					arg_592_1.talkMaxDuration = var_595_13

					if var_595_13 + var_595_8 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_13 + var_595_8
					end
				end

				arg_592_1.text_.text = var_595_11
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104143", "story_v_side_new_1106104.awb") ~= 0 then
					local var_595_14 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104143", "story_v_side_new_1106104.awb") / 1000

					if var_595_14 + var_595_8 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_14 + var_595_8
					end

					if var_595_10.prefab_name ~= "" and arg_592_1.actors_[var_595_10.prefab_name] ~= nil then
						local var_595_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_10.prefab_name].transform, "story_v_side_new_1106104", "1106104143", "story_v_side_new_1106104.awb")

						arg_592_1:RecordAudio("1106104143", var_595_15)
						arg_592_1:RecordAudio("1106104143", var_595_15)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104143", "story_v_side_new_1106104.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104143", "story_v_side_new_1106104.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_16 = math.max(var_595_9, arg_592_1.talkMaxDuration)

			if var_595_8 <= arg_592_1.time_ and arg_592_1.time_ < var_595_8 + var_595_16 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_8) / var_595_16

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_8 + var_595_16 and arg_592_1.time_ < var_595_8 + var_595_16 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {
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

		arg_592_1:InitPlayNodeList()
	end,
	Play1106104144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1106104144
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1106104145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 and not isNil(arg_596_1.actors_["1061ui_story"]) and arg_596_1.var_.characterEffect1061ui_story == nil then
				arg_596_1.var_.characterEffect1061ui_story = arg_596_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_0 = 0.200000002980232

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_0 and not isNil(arg_596_1.actors_["1061ui_story"]) then
				if arg_596_1.var_.characterEffect1061ui_story and not isNil(arg_596_1.actors_["1061ui_story"]) then
					arg_596_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_596_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_596_1.time_ - 0) / var_599_0)
				end
			end

			if arg_596_1.time_ >= 0 + var_599_0 and arg_596_1.time_ < 0 + var_599_0 + arg_599_0 and not isNil(arg_596_1.actors_["1061ui_story"]) and arg_596_1.var_.characterEffect1061ui_story then
				arg_596_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_596_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_599_1 = 0
			local var_599_2 = 0.35

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 then
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

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_3 = arg_596_1:FormatText(arg_596_1:GetWordFromCfg(1106104144).content)

				arg_596_1.text_.text = var_599_3

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_5 = 14 <= 0 and var_599_2 or var_599_2 * (utf8.len(var_599_3) / 14)

				if (14 <= 0 and var_599_2 or var_599_2 * (utf8.len(var_599_3) / 14)) > 0 and var_599_2 < var_599_5 then
					arg_596_1.talkMaxDuration = var_599_5

					if var_599_5 + var_599_1 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_5 + var_599_1
					end
				end

				arg_596_1.text_.text = var_599_3
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_6 = math.max(var_599_2, arg_596_1.talkMaxDuration)

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_6 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_1) / var_599_6

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_1 + var_599_6 and arg_596_1.time_ < var_599_1 + var_599_6 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play1106104145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1106104145
		arg_600_1.duration_ = 2

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1106104146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(arg_600_1.actors_["1061ui_story"]) and arg_600_1.var_.characterEffect1061ui_story == nil then
				arg_600_1.var_.characterEffect1061ui_story = arg_600_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_0 = 0.200000002980232

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 and not isNil(arg_600_1.actors_["1061ui_story"]) then
				if arg_600_1.var_.characterEffect1061ui_story and not isNil(arg_600_1.actors_["1061ui_story"]) then
					arg_600_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 and not isNil(arg_600_1.actors_["1061ui_story"]) and arg_600_1.var_.characterEffect1061ui_story then
				arg_600_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_603_2 = 0
			local var_603_3 = 0.075

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_2 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				arg_600_1.leftNameTxt_.text = arg_600_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_4 = arg_600_1:GetWordFromCfg(1106104145)
				local var_603_5 = arg_600_1:FormatText(var_603_4.content)

				arg_600_1.text_.text = var_603_5

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_7 = 3 <= 0 and var_603_3 or var_603_3 * (utf8.len(var_603_5) / 3)

				if (3 <= 0 and var_603_3 or var_603_3 * (utf8.len(var_603_5) / 3)) > 0 and var_603_3 < var_603_7 then
					arg_600_1.talkMaxDuration = var_603_7

					if var_603_7 + var_603_2 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_7 + var_603_2
					end
				end

				arg_600_1.text_.text = var_603_5
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104145", "story_v_side_new_1106104.awb") ~= 0 then
					local var_603_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104145", "story_v_side_new_1106104.awb") / 1000

					if var_603_8 + var_603_2 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_8 + var_603_2
					end

					if var_603_4.prefab_name ~= "" and arg_600_1.actors_[var_603_4.prefab_name] ~= nil then
						local var_603_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_4.prefab_name].transform, "story_v_side_new_1106104", "1106104145", "story_v_side_new_1106104.awb")

						arg_600_1:RecordAudio("1106104145", var_603_9)
						arg_600_1:RecordAudio("1106104145", var_603_9)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104145", "story_v_side_new_1106104.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104145", "story_v_side_new_1106104.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_10 = math.max(var_603_3, arg_600_1.talkMaxDuration)

			if var_603_2 <= arg_600_1.time_ and arg_600_1.time_ < var_603_2 + var_603_10 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_2) / var_603_10

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_2 + var_603_10 and arg_600_1.time_ < var_603_2 + var_603_10 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1106104146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1106104146
		arg_604_1.duration_ = 5

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1106104147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["1061ui_story"]) and arg_604_1.var_.characterEffect1061ui_story == nil then
				arg_604_1.var_.characterEffect1061ui_story = arg_604_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_0 = 0.200000002980232

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["1061ui_story"]) then
				if arg_604_1.var_.characterEffect1061ui_story and not isNil(arg_604_1.actors_["1061ui_story"]) then
					arg_604_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_604_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_604_1.time_ - 0) / var_607_0)
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["1061ui_story"]) and arg_604_1.var_.characterEffect1061ui_story then
				arg_604_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_604_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_607_1 = 0
			local var_607_2 = 0.475

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_3 = arg_604_1:FormatText(arg_604_1:GetWordFromCfg(1106104146).content)

				arg_604_1.text_.text = var_607_3

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_5 = 19 <= 0 and var_607_2 or var_607_2 * (utf8.len(var_607_3) / 19)

				if (19 <= 0 and var_607_2 or var_607_2 * (utf8.len(var_607_3) / 19)) > 0 and var_607_2 < var_607_5 then
					arg_604_1.talkMaxDuration = var_607_5

					if var_607_5 + var_607_1 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_5 + var_607_1
					end
				end

				arg_604_1.text_.text = var_607_3
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)
				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_6 = math.max(var_607_2, arg_604_1.talkMaxDuration)

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_6 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_1) / var_607_6

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_1 + var_607_6 and arg_604_1.time_ < var_607_1 + var_607_6 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play1106104147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1106104147
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1106104148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = 0.475

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_1 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(1106104147).content)

				arg_608_1.text_.text = var_611_1

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_3 = 19 <= 0 and var_611_0 or var_611_0 * (utf8.len(var_611_1) / 19)

				if (19 <= 0 and var_611_0 or var_611_0 * (utf8.len(var_611_1) / 19)) > 0 and var_611_0 < var_611_3 then
					arg_608_1.talkMaxDuration = var_611_3

					if var_611_3 + 0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_3 + 0
					end
				end

				arg_608_1.text_.text = var_611_1
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_4 = math.max(var_611_0, arg_608_1.talkMaxDuration)

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_4 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - 0) / var_611_4

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= 0 + var_611_4 and arg_608_1.time_ < 0 + var_611_4 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play1106104148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1106104148
		arg_612_1.duration_ = 2.23

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1106104149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 and not isNil(arg_612_1.actors_["1061ui_story"]) and arg_612_1.var_.characterEffect1061ui_story == nil then
				arg_612_1.var_.characterEffect1061ui_story = arg_612_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_0 = 0.200000002980232

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_0 and not isNil(arg_612_1.actors_["1061ui_story"]) then
				if arg_612_1.var_.characterEffect1061ui_story and not isNil(arg_612_1.actors_["1061ui_story"]) then
					arg_612_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= 0 + var_615_0 and arg_612_1.time_ < 0 + var_615_0 + arg_615_0 and not isNil(arg_612_1.actors_["1061ui_story"]) and arg_612_1.var_.characterEffect1061ui_story then
				arg_612_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_615_2 = 0
			local var_615_3 = 0.2

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_2 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_4 = arg_612_1:GetWordFromCfg(1106104148)
				local var_615_5 = arg_612_1:FormatText(var_615_4.content)

				arg_612_1.text_.text = var_615_5

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_7 = 8 <= 0 and var_615_3 or var_615_3 * (utf8.len(var_615_5) / 8)

				if (8 <= 0 and var_615_3 or var_615_3 * (utf8.len(var_615_5) / 8)) > 0 and var_615_3 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_2 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_2
					end
				end

				arg_612_1.text_.text = var_615_5
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104148", "story_v_side_new_1106104.awb") ~= 0 then
					local var_615_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104148", "story_v_side_new_1106104.awb") / 1000

					if var_615_8 + var_615_2 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_8 + var_615_2
					end

					if var_615_4.prefab_name ~= "" and arg_612_1.actors_[var_615_4.prefab_name] ~= nil then
						local var_615_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_4.prefab_name].transform, "story_v_side_new_1106104", "1106104148", "story_v_side_new_1106104.awb")

						arg_612_1:RecordAudio("1106104148", var_615_9)
						arg_612_1:RecordAudio("1106104148", var_615_9)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104148", "story_v_side_new_1106104.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104148", "story_v_side_new_1106104.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_10 = math.max(var_615_3, arg_612_1.talkMaxDuration)

			if var_615_2 <= arg_612_1.time_ and arg_612_1.time_ < var_615_2 + var_615_10 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_2) / var_615_10

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_2 + var_615_10 and arg_612_1.time_ < var_615_2 + var_615_10 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play1106104149 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1106104149
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1106104150(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(arg_616_1.actors_["1061ui_story"]) and arg_616_1.var_.characterEffect1061ui_story == nil then
				arg_616_1.var_.characterEffect1061ui_story = arg_616_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_0 = 0.200000002980232

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_0 and not isNil(arg_616_1.actors_["1061ui_story"]) then
				if arg_616_1.var_.characterEffect1061ui_story and not isNil(arg_616_1.actors_["1061ui_story"]) then
					arg_616_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_616_1.time_ - 0) / var_619_0)
				end
			end

			if arg_616_1.time_ >= 0 + var_619_0 and arg_616_1.time_ < 0 + var_619_0 + arg_619_0 and not isNil(arg_616_1.actors_["1061ui_story"]) and arg_616_1.var_.characterEffect1061ui_story then
				arg_616_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_619_1 = 0
			local var_619_2 = 0.45

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_3 = arg_616_1:FormatText(arg_616_1:GetWordFromCfg(1106104149).content)

				arg_616_1.text_.text = var_619_3

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 18 <= 0 and var_619_2 or var_619_2 * (utf8.len(var_619_3) / 18)

				if (18 <= 0 and var_619_2 or var_619_2 * (utf8.len(var_619_3) / 18)) > 0 and var_619_2 < var_619_5 then
					arg_616_1.talkMaxDuration = var_619_5

					if var_619_5 + var_619_1 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_5 + var_619_1
					end
				end

				arg_616_1.text_.text = var_619_3
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_6 = math.max(var_619_2, arg_616_1.talkMaxDuration)

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_6 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_1) / var_619_6

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_1 + var_619_6 and arg_616_1.time_ < var_619_1 + var_619_6 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1106104150 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1106104150
		arg_620_1.duration_ = 4.77

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1106104151(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 and not isNil(arg_620_1.actors_["1061ui_story"]) and arg_620_1.var_.characterEffect1061ui_story == nil then
				arg_620_1.var_.characterEffect1061ui_story = arg_620_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_0 = 0.200000002980232

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_0 and not isNil(arg_620_1.actors_["1061ui_story"]) then
				if arg_620_1.var_.characterEffect1061ui_story and not isNil(arg_620_1.actors_["1061ui_story"]) then
					arg_620_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_620_1.time_ >= 0 + var_623_0 and arg_620_1.time_ < 0 + var_623_0 + arg_623_0 and not isNil(arg_620_1.actors_["1061ui_story"]) and arg_620_1.var_.characterEffect1061ui_story then
				arg_620_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action449")
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_623_2 = 0
			local var_623_3 = 0.6

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_2 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_4 = arg_620_1:GetWordFromCfg(1106104150)
				local var_623_5 = arg_620_1:FormatText(var_623_4.content)

				arg_620_1.text_.text = var_623_5

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_7 = 24 <= 0 and var_623_3 or var_623_3 * (utf8.len(var_623_5) / 24)

				if (24 <= 0 and var_623_3 or var_623_3 * (utf8.len(var_623_5) / 24)) > 0 and var_623_3 < var_623_7 then
					arg_620_1.talkMaxDuration = var_623_7

					if var_623_7 + var_623_2 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_7 + var_623_2
					end
				end

				arg_620_1.text_.text = var_623_5
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104150", "story_v_side_new_1106104.awb") ~= 0 then
					local var_623_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104150", "story_v_side_new_1106104.awb") / 1000

					if var_623_8 + var_623_2 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_8 + var_623_2
					end

					if var_623_4.prefab_name ~= "" and arg_620_1.actors_[var_623_4.prefab_name] ~= nil then
						local var_623_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_4.prefab_name].transform, "story_v_side_new_1106104", "1106104150", "story_v_side_new_1106104.awb")

						arg_620_1:RecordAudio("1106104150", var_623_9)
						arg_620_1:RecordAudio("1106104150", var_623_9)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104150", "story_v_side_new_1106104.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104150", "story_v_side_new_1106104.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_10 = math.max(var_623_3, arg_620_1.talkMaxDuration)

			if var_623_2 <= arg_620_1.time_ and arg_620_1.time_ < var_623_2 + var_623_10 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_2) / var_623_10

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_2 + var_623_10 and arg_620_1.time_ < var_623_2 + var_623_10 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play1106104151 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1106104151
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
			arg_624_1.auto_ = false
		end

		function arg_624_1.playNext_(arg_626_0)
			arg_624_1.onStoryFinished_()
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.var_.moveOldPos1061ui_story = arg_624_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_627_0 = 0.001

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_0 then
				arg_624_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_624_1.time_ - 0) / var_627_0)
				arg_624_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_624_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1061ui_story"].transform.position).z)
				arg_624_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_624_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_624_1.actors_["1061ui_story"].transform.localEulerAngles = arg_624_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_624_1.time_ >= 0 + var_627_0 and arg_624_1.time_ < 0 + var_627_0 + arg_627_0 then
				arg_624_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_624_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_624_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1061ui_story"].transform.position).z)
				arg_624_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_624_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_624_1.actors_["1061ui_story"].transform.localEulerAngles = arg_624_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_627_1 = 0
			local var_627_2 = 0.575

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_1 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, false)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_3 = arg_624_1:FormatText(arg_624_1:GetWordFromCfg(1106104151).content)

				arg_624_1.text_.text = var_627_3

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 23 <= 0 and var_627_2 or var_627_2 * (utf8.len(var_627_3) / 23)

				if (23 <= 0 and var_627_2 or var_627_2 * (utf8.len(var_627_3) / 23)) > 0 and var_627_2 < var_627_5 then
					arg_624_1.talkMaxDuration = var_627_5

					if var_627_5 + var_627_1 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_5 + var_627_1
					end
				end

				arg_624_1.text_.text = var_627_3
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_6 = math.max(var_627_2, arg_624_1.talkMaxDuration)

			if var_627_1 <= arg_624_1.time_ and arg_624_1.time_ < var_627_1 + var_627_6 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_1) / var_627_6

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_1 + var_627_6 and arg_624_1.time_ < var_627_1 + var_627_6 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
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

		arg_624_1:InitPlayNodeList()
	end,
	Play1106104042 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1106104042
		arg_628_1.duration_ = 5.63

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1106104043(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(arg_628_1.actors_["106101ui_story"]) and arg_628_1.var_.characterEffect106101ui_story == nil then
				arg_628_1.var_.characterEffect106101ui_story = arg_628_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_0 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 and not isNil(arg_628_1.actors_["106101ui_story"]) then
				if arg_628_1.var_.characterEffect106101ui_story and not isNil(arg_628_1.actors_["106101ui_story"]) then
					arg_628_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 and not isNil(arg_628_1.actors_["106101ui_story"]) and arg_628_1.var_.characterEffect106101ui_story then
				arg_628_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_631_2 = 0
			local var_631_3 = 0.575

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_2 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_4 = arg_628_1:GetWordFromCfg(1106104042)
				local var_631_5 = arg_628_1:FormatText(var_631_4.content)

				arg_628_1.text_.text = var_631_5

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_7 = 23 <= 0 and var_631_3 or var_631_3 * (utf8.len(var_631_5) / 23)

				if (23 <= 0 and var_631_3 or var_631_3 * (utf8.len(var_631_5) / 23)) > 0 and var_631_3 < var_631_7 then
					arg_628_1.talkMaxDuration = var_631_7

					if var_631_7 + var_631_2 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_7 + var_631_2
					end
				end

				arg_628_1.text_.text = var_631_5
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104042", "story_v_side_new_1106104.awb") ~= 0 then
					local var_631_8 = manager.audio:GetVoiceLength("story_v_side_new_1106104", "1106104042", "story_v_side_new_1106104.awb") / 1000

					if var_631_8 + var_631_2 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_8 + var_631_2
					end

					if var_631_4.prefab_name ~= "" and arg_628_1.actors_[var_631_4.prefab_name] ~= nil then
						local var_631_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_4.prefab_name].transform, "story_v_side_new_1106104", "1106104042", "story_v_side_new_1106104.awb")

						arg_628_1:RecordAudio("1106104042", var_631_9)
						arg_628_1:RecordAudio("1106104042", var_631_9)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_side_new_1106104", "1106104042", "story_v_side_new_1106104.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_side_new_1106104", "1106104042", "story_v_side_new_1106104.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_10 = math.max(var_631_3, arg_628_1.talkMaxDuration)

			if var_631_2 <= arg_628_1.time_ and arg_628_1.time_ < var_631_2 + var_631_10 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_2) / var_631_10

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_2 + var_631_10 and arg_628_1.time_ < var_631_2 + var_631_10 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST47a",
		"TextureConfig/Background/ST54",
		"TextureConfig/Background/R6101",
		"TextureConfig/Background/R6101a",
		"TextureConfig/Background/ST42"
	},
	voices = {
		"story_v_side_new_1106104.awb"
	}
}
