return {
	Play100012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100012001
		arg_1_1.duration_ = 4.1

		local var_1_0 = {
			ja = 4.1,
			ko = 3.466,
			zh = 3.666,
			en = 4
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
				arg_1_0:Play100012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A01b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A01b")
				var_4_0.name = "A01b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A01b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A01b:GetComponent("SpriteRenderer")

				if var_4_1 then
					arg_1_1.var_.alphaOldValueA01b = var_4_1.color.a
					arg_1_1.var_.alphaMatValueA01b = var_4_1
				end

				arg_1_1.var_.alphaOldValueA01b = 0
			end

			local var_4_2 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_2 then
				if arg_1_1.var_.alphaMatValueA01b then
					arg_1_1.var_.alphaMatValueA01b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA01b, 1, (arg_1_1.time_ - 0) / var_4_2)
					arg_1_1.var_.alphaMatValueA01b.color = arg_1_1.var_.alphaMatValueA01b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_2 and arg_1_1.time_ < 0 + var_4_2 + arg_4_0 and arg_1_1.var_.alphaMatValueA01b then
				arg_1_1.var_.alphaMatValueA01b.color.a = 1
				arg_1_1.var_.alphaMatValueA01b.color = arg_1_1.var_.alphaMatValueA01b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_3 = arg_1_1.bgs_.A01b

				arg_1_1.bgs_.A01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_4 = var_4_3:GetComponent("SpriteRenderer")

				if var_4_4 and var_4_4.sprite then
					local var_4_5 = 2 * (var_4_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_3.transform.localScale = Vector3.New(var_4_5 / var_4_4.sprite.bounds.size.y < var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x and var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x or var_4_5 / var_4_4.sprite.bounds.size.y, var_4_5 / var_4_4.sprite.bounds.size.y < var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x and var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x or var_4_5 / var_4_4.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A01b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 1.5 and arg_1_1.time_ < var_4_6 + 1.5 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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
			local var_4_14 = 0.2

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(100012001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 8 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 8)

				if (8 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 8)) > 0 and var_4_14 < var_4_19 then
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

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012001", "story_v_out_100012.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_100012", "100012001", "story_v_out_100012.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_100012", "100012001", "story_v_out_100012.awb")

						arg_1_1:RecordAudio("100012001", var_4_21)
						arg_1_1:RecordAudio("100012001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_100012", "100012001", "story_v_out_100012.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_100012", "100012001", "story_v_out_100012.awb")
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
	Play100012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 100012002
		arg_9_1.duration_ = 5.77

		local var_9_0 = {
			ja = 5.766,
			ko = 5.666,
			zh = 4.333,
			en = 5.433
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
				arg_9_0:Play100012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(100012002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 22)

				if (22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 22)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012002", "story_v_out_100012.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012002", "story_v_out_100012.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_100012", "100012002", "story_v_out_100012.awb")

						arg_9_1:RecordAudio("100012002", var_12_6)
						arg_9_1:RecordAudio("100012002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_100012", "100012002", "story_v_out_100012.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_100012", "100012002", "story_v_out_100012.awb")
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
	Play100012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 100012003
		arg_13_1.duration_ = 10.27

		local var_13_0 = {
			ja = 8.5,
			ko = 8.1,
			zh = 7.8,
			en = 10.266
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
				arg_13_0:Play100012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.875

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(100012003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 35 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 35)

				if (35 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 35)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012003", "story_v_out_100012.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012003", "story_v_out_100012.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_100012", "100012003", "story_v_out_100012.awb")

						arg_13_1:RecordAudio("100012003", var_16_6)
						arg_13_1:RecordAudio("100012003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_100012", "100012003", "story_v_out_100012.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_100012", "100012003", "story_v_out_100012.awb")
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
	Play100012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 100012004
		arg_17_1.duration_ = 6.3

		local var_17_0 = {
			ja = 6.3,
			ko = 5.866,
			zh = 4.866,
			en = 5.266
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
				arg_17_0:Play100012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(100012004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 24 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 24)

				if (24 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 24)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012004", "story_v_out_100012.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012004", "story_v_out_100012.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_100012", "100012004", "story_v_out_100012.awb")

						arg_17_1:RecordAudio("100012004", var_20_6)
						arg_17_1:RecordAudio("100012004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_100012", "100012004", "story_v_out_100012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_100012", "100012004", "story_v_out_100012.awb")
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
	Play100012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 100012005
		arg_21_1.duration_ = 10.93

		local var_21_0 = {
			ja = 10.933,
			ko = 7.833,
			zh = 7.3,
			en = 6.6
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
				arg_21_0:Play100012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(100012005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)

				if (37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012005", "story_v_out_100012.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012005", "story_v_out_100012.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_100012", "100012005", "story_v_out_100012.awb")

						arg_21_1:RecordAudio("100012005", var_24_6)
						arg_21_1:RecordAudio("100012005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_100012", "100012005", "story_v_out_100012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_100012", "100012005", "story_v_out_100012.awb")
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
	Play100012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 100012006
		arg_25_1.duration_ = 0.1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"

			SetActive(arg_25_1.choicesGo_, true)

			for iter_26_0, iter_26_1 in ipairs(arg_25_1.choices_) do
				SetActive(iter_26_1.go, iter_26_0 <= 1)
			end

			arg_25_1.choices_[1].txt.text = arg_25_1:FormatText(StoryChoiceCfg[4].name)
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play100012007(arg_25_1)
			end

			arg_25_1:RecordChoiceLog(100012006, 4)
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			return
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play100012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 100012007
		arg_29_1.duration_ = 4.9

		local var_29_0 = {
			ja = 4.9,
			ko = 4.433,
			zh = 4.6,
			en = 4.033
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
				arg_29_0:Play100012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_0 = arg_29_1.bgs_.A01b:GetComponent("SpriteRenderer")

				if var_32_0 then
					arg_29_1.var_.alphaOldValueA01b = var_32_0.color.a
					arg_29_1.var_.alphaMatValueA01b = var_32_0
				end

				arg_29_1.var_.alphaOldValueA01b = 1
			end

			local var_32_1 = 1.5

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				if arg_29_1.var_.alphaMatValueA01b then
					arg_29_1.var_.alphaMatValueA01b.color.a = Mathf.Lerp(arg_29_1.var_.alphaOldValueA01b, 0, (arg_29_1.time_ - 0) / var_32_1)
					arg_29_1.var_.alphaMatValueA01b.color = arg_29_1.var_.alphaMatValueA01b.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and arg_29_1.var_.alphaMatValueA01b then
				arg_29_1.var_.alphaMatValueA01b.color.a = 0
				arg_29_1.var_.alphaMatValueA01b.color = arg_29_1.var_.alphaMatValueA01b.color
			end

			local var_32_2 = arg_29_1.bgs_.A01b.transform

			if 1.5 < arg_29_1.time_ and arg_29_1.time_ <= 1.5 + arg_32_0 then
				arg_29_1.var_.moveOldPosA01b = var_32_2.localPosition
			end

			local var_32_3 = 0.001

			if 1.5 <= arg_29_1.time_ and arg_29_1.time_ < 1.5 + var_32_3 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosA01b, Vector3.New(0, -100, 10), (arg_29_1.time_ - 1.5) / var_32_3)
			end

			if arg_29_1.time_ >= 1.5 + var_32_3 and arg_29_1.time_ < 1.5 + var_32_3 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -100, 10)
			end

			local var_32_4 = "S0003"

			if arg_29_1.bgs_.S0003 == nil then
				local var_32_5 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_4)
				var_32_5.name = var_32_4
				var_32_5.transform.parent = arg_29_1.stage_.transform
				var_32_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_4] = var_32_5
			end

			if 1.5 < arg_29_1.time_ and arg_29_1.time_ <= 1.5 + arg_32_0 then
				local var_32_6 = arg_29_1.bgs_.S0003:GetComponent("SpriteRenderer")

				if var_32_6 then
					arg_29_1.var_.alphaOldValueS0003 = var_32_6.color.a
					arg_29_1.var_.alphaMatValueS0003 = var_32_6
				end

				arg_29_1.var_.alphaOldValueS0003 = 0
			end

			local var_32_7 = 1.5

			if 1.5 <= arg_29_1.time_ and arg_29_1.time_ < 1.5 + var_32_7 then
				if arg_29_1.var_.alphaMatValueS0003 then
					arg_29_1.var_.alphaMatValueS0003.color.a = Mathf.Lerp(arg_29_1.var_.alphaOldValueS0003, 1, (arg_29_1.time_ - 1.5) / var_32_7)
					arg_29_1.var_.alphaMatValueS0003.color = arg_29_1.var_.alphaMatValueS0003.color
				end
			end

			if arg_29_1.time_ >= 1.5 + var_32_7 and arg_29_1.time_ < 1.5 + var_32_7 + arg_32_0 and arg_29_1.var_.alphaMatValueS0003 then
				arg_29_1.var_.alphaMatValueS0003.color.a = 1
				arg_29_1.var_.alphaMatValueS0003.color = arg_29_1.var_.alphaMatValueS0003.color
			end

			if 1.5 < arg_29_1.time_ and arg_29_1.time_ <= 1.5 + arg_32_0 then
				local var_32_8 = arg_29_1.bgs_.S0003

				arg_29_1.bgs_.S0003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_9 = var_32_8:GetComponent("SpriteRenderer")

				if var_32_9 and var_32_9.sprite then
					local var_32_10 = 2 * (var_32_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_8.transform.localScale = Vector3.New(var_32_10 / var_32_9.sprite.bounds.size.y < var_32_10 * manager.ui.mainCameraCom_.aspect / var_32_9.sprite.bounds.size.x and var_32_10 * manager.ui.mainCameraCom_.aspect / var_32_9.sprite.bounds.size.x or var_32_10 / var_32_9.sprite.bounds.size.y, var_32_10 / var_32_9.sprite.bounds.size.y < var_32_10 * manager.ui.mainCameraCom_.aspect / var_32_9.sprite.bounds.size.x and var_32_10 * manager.ui.mainCameraCom_.aspect / var_32_9.sprite.bounds.size.x or var_32_10 / var_32_9.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "S0003" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_11 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_11 + 1.5 and arg_29_1.time_ < var_32_11 + 1.5 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_12 = 2
			local var_32_13 = 0.25

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_14 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_14:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_15 = arg_29_1:GetWordFromCfg(100012007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 11 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_16) / 11)

				if (11 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_16) / 11)) > 0 and var_32_13 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18
					var_32_12 = var_32_12 + 0.3

					if var_32_18 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012007", "story_v_out_100012.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_100012", "100012007", "story_v_out_100012.awb") / 1000

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_100012", "100012007", "story_v_out_100012.awb")

						arg_29_1:RecordAudio("100012007", var_32_20)
						arg_29_1:RecordAudio("100012007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_100012", "100012007", "story_v_out_100012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_100012", "100012007", "story_v_out_100012.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = var_32_12 + 0.3
			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_21) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A01b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play100012008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 100012008
		arg_35_1.duration_ = 7.97

		local var_35_0 = {
			ja = 7.966,
			ko = 7,
			zh = 5.666,
			en = 5.633
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
				arg_35_0:Play100012009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.725

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(100012008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 28 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 28)

				if (28 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 28)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012008", "story_v_out_100012.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012008", "story_v_out_100012.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_100012", "100012008", "story_v_out_100012.awb")

						arg_35_1:RecordAudio("100012008", var_38_6)
						arg_35_1:RecordAudio("100012008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_100012", "100012008", "story_v_out_100012.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_100012", "100012008", "story_v_out_100012.awb")
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
	Play100012009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 100012009
		arg_39_1.duration_ = 9.57

		local var_39_0 = {
			ja = 9.566,
			ko = 6.366,
			zh = 4.4,
			en = 7.5
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
				arg_39_0:Play100012010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(100012009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 24 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 24)

				if (24 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 24)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012009", "story_v_out_100012.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012009", "story_v_out_100012.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_100012", "100012009", "story_v_out_100012.awb")

						arg_39_1:RecordAudio("100012009", var_42_6)
						arg_39_1:RecordAudio("100012009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_100012", "100012009", "story_v_out_100012.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_100012", "100012009", "story_v_out_100012.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play100012010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 100012010
		arg_43_1.duration_ = 6.17

		local var_43_0 = {
			ja = 6.166,
			ko = 5.266,
			zh = 3.566,
			en = 5.3
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
				arg_43_0:Play100012011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.425

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:GetWordFromCfg(100012010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 17 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 17)

				if (17 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 17)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012010", "story_v_out_100012.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012010", "story_v_out_100012.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_100012", "100012010", "story_v_out_100012.awb")

						arg_43_1:RecordAudio("100012010", var_46_6)
						arg_43_1:RecordAudio("100012010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_100012", "100012010", "story_v_out_100012.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_100012", "100012010", "story_v_out_100012.awb")
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
	Play100012011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 100012011
		arg_47_1.duration_ = 6.97

		local var_47_0 = {
			ja = 6.966,
			ko = 3.333,
			zh = 2.8,
			en = 3.4
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play100012012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.275

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(100012011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 11 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 11)

				if (11 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 11)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012011", "story_v_out_100012.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012011", "story_v_out_100012.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_100012", "100012011", "story_v_out_100012.awb")

						arg_47_1:RecordAudio("100012011", var_50_6)
						arg_47_1:RecordAudio("100012011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_100012", "100012011", "story_v_out_100012.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_100012", "100012011", "story_v_out_100012.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play100012012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 100012012
		arg_51_1.duration_ = 6.17

		local var_51_0 = {
			ja = 6.1,
			ko = 5,
			zh = 4.333,
			en = 6.166
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
				arg_51_0:Play100012013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(100012012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 26 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 26)

				if (26 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 26)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012012", "story_v_out_100012.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012012", "story_v_out_100012.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_100012", "100012012", "story_v_out_100012.awb")

						arg_51_1:RecordAudio("100012012", var_54_6)
						arg_51_1:RecordAudio("100012012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_100012", "100012012", "story_v_out_100012.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_100012", "100012012", "story_v_out_100012.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play100012013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 100012013
		arg_55_1.duration_ = 8.37

		local var_55_0 = {
			ja = 8.366,
			ko = 6.866,
			zh = 7.5,
			en = 6.2
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play100012014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.9

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(100012013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 34 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 34)

				if (34 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 34)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012013", "story_v_out_100012.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012013", "story_v_out_100012.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_100012", "100012013", "story_v_out_100012.awb")

						arg_55_1:RecordAudio("100012013", var_58_6)
						arg_55_1:RecordAudio("100012013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_100012", "100012013", "story_v_out_100012.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_100012", "100012013", "story_v_out_100012.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play100012014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 100012014
		arg_59_1.duration_ = 0.1

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"

			SetActive(arg_59_1.choicesGo_, true)

			for iter_60_0, iter_60_1 in ipairs(arg_59_1.choices_) do
				SetActive(iter_60_1.go, iter_60_0 <= 1)
			end

			arg_59_1.choices_[1].txt.text = arg_59_1:FormatText(StoryChoiceCfg[5].name)
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play100012015(arg_59_1)
			end

			arg_59_1:RecordChoiceLog(100012014, 5)
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			return
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play100012015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 100012015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play100012016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.825

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(100012015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 33 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 33)

				if (33 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 33)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play100012016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 100012016
		arg_67_1.duration_ = 6.8

		local var_67_0 = {
			ja = 6.8,
			ko = 4.4,
			zh = 4.6,
			en = 4.8
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
			arg_67_1.auto_ = false
		end

		function arg_67_1.playNext_(arg_69_0)
			arg_67_1.onStoryFinished_()
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.675

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(100012016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 27 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 27)

				if (27 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 27)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012016", "story_v_out_100012.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_100012", "100012016", "story_v_out_100012.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_100012", "100012016", "story_v_out_100012.awb")

						arg_67_1:RecordAudio("100012016", var_70_6)
						arg_67_1:RecordAudio("100012016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_100012", "100012016", "story_v_out_100012.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_100012", "100012016", "story_v_out_100012.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A01b",
		"TextureConfig/Background/S0003"
	},
	voices = {
		"story_v_out_100012.awb"
	}
}
