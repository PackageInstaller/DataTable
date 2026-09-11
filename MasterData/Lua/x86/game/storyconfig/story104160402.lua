return {
	Play416042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416042001
		arg_1_1.duration_ = 5.77

		local var_1_0 = {
			zh = 5.2,
			ja = 5.766
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
				arg_1_0:Play416042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I14f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I14f")
				var_4_0.name = "I14f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I14f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I14f

				arg_1_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I14f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.05

			if 2.05 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.35

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(416042001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 14 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 14)

				if (14 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 14)) > 0 and var_4_17 < var_4_22 then
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

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042001", "story_v_out_416042.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_416042", "416042001", "story_v_out_416042.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_416042", "416042001", "story_v_out_416042.awb")

						arg_1_1:RecordAudio("416042001", var_4_24)
						arg_1_1:RecordAudio("416042001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416042", "416042001", "story_v_out_416042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416042", "416042001", "story_v_out_416042.awb")
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
	Play416042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416042002
		arg_9_1.duration_ = 3.9

		local var_9_0 = {
			zh = 3.9,
			ja = 3.4
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
				arg_9_0:Play416042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(416042002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 17)

				if (17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 17)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042002", "story_v_out_416042.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042002", "story_v_out_416042.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_416042", "416042002", "story_v_out_416042.awb")

						arg_9_1:RecordAudio("416042002", var_12_6)
						arg_9_1:RecordAudio("416042002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416042", "416042002", "story_v_out_416042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416042", "416042002", "story_v_out_416042.awb")
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
	Play416042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416042003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0.633333333333333 < arg_13_1.time_ and arg_13_1.time_ <= 0.633333333333333 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_16_1 = 0
			local var_16_2 = 1.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(416042003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 71 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 71)

				if (71 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 71)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play416042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416042004
		arg_17_1.duration_ = 4

		local var_17_0 = {
			zh = 4,
			ja = 3.6
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
				arg_17_0:Play416042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(416042004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 9 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 9)

				if (9 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 9)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042004", "story_v_out_416042.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042004", "story_v_out_416042.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_416042", "416042004", "story_v_out_416042.awb")

						arg_17_1:RecordAudio("416042004", var_20_6)
						arg_17_1:RecordAudio("416042004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416042", "416042004", "story_v_out_416042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416042", "416042004", "story_v_out_416042.awb")
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
	Play416042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416042005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.75

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(416042005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 70 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 70)

				if (70 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 70)) > 0 and var_24_0 < var_24_3 then
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
	Play416042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416042006
		arg_25_1.duration_ = 3.17

		local var_25_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_25_0:Play416042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1148"] == nil then
				local var_28_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_28_0) then
					local var_28_1 = Object.Instantiate(var_28_0, arg_25_1.canvasGo_.transform)

					var_28_1.transform:SetSiblingIndex(1)

					var_28_1.name = "1148"
					var_28_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_["1148"] = var_28_1

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs((var_28_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_2 = arg_25_1.actors_["1148"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.125

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								iter_28_3.color = Color.New(Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_3.color.r, 1, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_3.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_5 then
						iter_28_5.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_5 = arg_25_1.actors_["1148"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 3)

				for iter_28_6 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_6)

					if var_28_6.name == "split_6" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -429, -180)
			end

			local var_28_8 = 0
			local var_28_9 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(416042006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 11 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 11)

				if (11 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 11)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042006", "story_v_out_416042.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042006", "story_v_out_416042.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_416042", "416042006", "story_v_out_416042.awb")

						arg_25_1:RecordAudio("416042006", var_28_15)
						arg_25_1:RecordAudio("416042006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416042", "416042006", "story_v_out_416042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416042", "416042006", "story_v_out_416042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416042007
		arg_29_1.duration_ = 5.47

		local var_29_0 = {
			zh = 5.466,
			ja = 5.1
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
				arg_29_0:Play416042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1148"]) and arg_29_1.var_.actorSpriteComps1148 == nil then
				arg_29_1.var_.actorSpriteComps1148 = arg_29_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1148"]) then
				if arg_29_1.var_.actorSpriteComps1148 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1148"]) and arg_29_1.var_.actorSpriteComps1148 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1148 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_4 = arg_29_1:GetWordFromCfg(416042007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 21 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 21)

				if (21 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 21)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042007", "story_v_out_416042.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042007", "story_v_out_416042.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_416042", "416042007", "story_v_out_416042.awb")

						arg_29_1:RecordAudio("416042007", var_32_9)
						arg_29_1:RecordAudio("416042007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416042", "416042007", "story_v_out_416042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416042", "416042007", "story_v_out_416042.awb")
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
	Play416042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416042008
		arg_33_1.duration_ = 7.3

		local var_33_0 = {
			zh = 4.766,
			ja = 7.3
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
				arg_33_0:Play416042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1148"]) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = arg_33_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1148"]) then
				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 1, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1148"]) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(416042008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 22 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 22)

				if (22 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 22)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042008", "story_v_out_416042.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042008", "story_v_out_416042.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_416042", "416042008", "story_v_out_416042.awb")

						arg_33_1:RecordAudio("416042008", var_36_9)
						arg_33_1:RecordAudio("416042008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416042", "416042008", "story_v_out_416042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416042", "416042008", "story_v_out_416042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416042009
		arg_37_1.duration_ = 5.27

		local var_37_0 = {
			zh = 5.166,
			ja = 5.266
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
				arg_37_0:Play416042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.575

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(416042009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 23 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 23)

				if (23 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 23)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042009", "story_v_out_416042.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042009", "story_v_out_416042.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_416042", "416042009", "story_v_out_416042.awb")

						arg_37_1:RecordAudio("416042009", var_40_6)
						arg_37_1:RecordAudio("416042009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416042", "416042009", "story_v_out_416042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416042", "416042009", "story_v_out_416042.awb")
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
	Play416042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416042010
		arg_41_1.duration_ = 4.27

		local var_41_0 = {
			zh = 4.233,
			ja = 4.266
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
				arg_41_0:Play416042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1148"]) and arg_41_1.var_.actorSpriteComps1148 == nil then
				arg_41_1.var_.actorSpriteComps1148 = arg_41_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1148"]) then
				if arg_41_1.var_.actorSpriteComps1148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1148"]) and arg_41_1.var_.actorSpriteComps1148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1148 = nil
			end

			local var_44_2 = 0
			local var_44_3 = 0.225

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_4 = arg_41_1:GetWordFromCfg(416042010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 9 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 9)

				if (9 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 9)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042010", "story_v_out_416042.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042010", "story_v_out_416042.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_416042", "416042010", "story_v_out_416042.awb")

						arg_41_1:RecordAudio("416042010", var_44_9)
						arg_41_1:RecordAudio("416042010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416042", "416042010", "story_v_out_416042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416042", "416042010", "story_v_out_416042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416042011
		arg_45_1.duration_ = 5.7

		local var_45_0 = {
			zh = 4.2,
			ja = 5.7
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
				arg_45_0:Play416042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 1 < arg_45_1.time_ and arg_45_1.time_ <= 1 + arg_48_0 then
				local var_48_0 = arg_45_1.bgs_.I14f

				arg_45_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_1 = var_48_0:GetComponent("SpriteRenderer")

				if var_48_1 and var_48_1.sprite then
					local var_48_2 = 2 * (var_48_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_0.transform.localScale = Vector3.New(var_48_2 / var_48_1.sprite.bounds.size.y < var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x and var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x or var_48_2 / var_48_1.sprite.bounds.size.y, var_48_2 / var_48_1.sprite.bounds.size.y < var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x and var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x or var_48_2 / var_48_1.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "I14f" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_3 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_4 = 1

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_4 then
				local var_48_5 = Color.New(0, 0, 0)

				var_48_5.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_3) / var_48_4)
				arg_45_1.mask_.color = var_48_5
			end

			if arg_45_1.time_ >= var_48_3 + var_48_4 and arg_45_1.time_ < var_48_3 + var_48_4 + arg_48_0 then
				local var_48_6 = Color.New(0, 0, 0)

				var_48_6.a = 1
				arg_45_1.mask_.color = var_48_6
			end

			local var_48_7 = 1

			if 1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_8 = 1

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 then
				local var_48_9 = Color.New(0, 0, 0)

				var_48_9.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_7) / var_48_8)
				arg_45_1.mask_.color = var_48_9
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 then
				local var_48_10 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_10.a = 0
				arg_45_1.mask_.color = var_48_10
			end

			local var_48_11 = arg_45_1.actors_["1148"].transform

			if 0.966666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 0.966666666666667 + arg_48_0 then
				arg_45_1.var_.moveOldPos1148 = var_48_11.localPosition
				var_48_11.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1148", 7)

				for iter_48_2 = 0, var_48_11.childCount - 1 do
					local var_48_12 = var_48_11:GetChild(iter_48_2)

					if var_48_12.name == "" or not string.find(var_48_12.name, "split") then
						var_48_12.gameObject:SetActive(true)
					else
						var_48_12.gameObject:SetActive(false)
					end
				end
			end

			local var_48_13 = 0.001

			if 0.966666666666667 <= arg_45_1.time_ and arg_45_1.time_ < 0.966666666666667 + var_48_13 then
				var_48_11.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0.966666666666667) / var_48_13)
			end

			if arg_45_1.time_ >= 0.966666666666667 + var_48_13 and arg_45_1.time_ < 0.966666666666667 + var_48_13 + arg_48_0 then
				var_48_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_14 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= var_48_14 + 0.1 and arg_45_1.time_ < var_48_14 + 0.1 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_15 = 2
			local var_48_16 = 0.175

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_17 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_17:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_18 = arg_45_1:GetWordFromCfg(416042011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_21 = 7 <= 0 and var_48_16 or var_48_16 * (utf8.len(var_48_19) / 7)

				if (7 <= 0 and var_48_16 or var_48_16 * (utf8.len(var_48_19) / 7)) > 0 and var_48_16 < var_48_21 then
					arg_45_1.talkMaxDuration = var_48_21
					var_48_15 = var_48_15 + 0.3

					if var_48_21 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_21 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042011", "story_v_out_416042.awb") ~= 0 then
					local var_48_22 = manager.audio:GetVoiceLength("story_v_out_416042", "416042011", "story_v_out_416042.awb") / 1000

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_416042", "416042011", "story_v_out_416042.awb")

						arg_45_1:RecordAudio("416042011", var_48_23)
						arg_45_1:RecordAudio("416042011", var_48_23)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416042", "416042011", "story_v_out_416042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416042", "416042011", "story_v_out_416042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_24 = var_48_15 + 0.3
			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_24 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_24) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_24 + var_48_25 and arg_45_1.time_ < var_48_24 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play416042012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416042012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play416042013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1148 = arg_51_1.actors_["1148"].transform.localPosition
				arg_51_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1148", 7)

				for iter_54_0 = 0, arg_51_1.actors_["1148"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["1148"].transform:GetChild(iter_54_0)

					if var_54_0.name == "" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_2 = 0
			local var_54_3 = 1.875

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(416042012).content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 75 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 75)

				if (75 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 75)) > 0 and var_54_3 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_7 and arg_51_1.time_ < var_54_2 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play416042013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416042013
		arg_55_1.duration_ = 5.9

		local var_55_0 = {
			zh = 4.266,
			ja = 5.9
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
				arg_55_0:Play416042014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1148 = arg_55_1.actors_["1148"].transform.localPosition
				arg_55_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1148", 3)

				for iter_58_0 = 0, arg_55_1.actors_["1148"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["1148"].transform:GetChild(iter_58_0)

					if var_58_0.name == "split_3" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_58_2 = arg_55_1.actors_["1148"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps1148 == nil then
				arg_55_1.var_.actorSpriteComps1148 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 0.125

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps1148 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_58_2 then
							if arg_55_1.isInRecall_ then
								iter_58_2.color = Color.New(Mathf.Lerp(iter_58_2.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_2.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_2.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_2.color.r, 1, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_2.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps1148 then
				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_58_4 then
						iter_58_4.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps1148 = nil
			end

			local var_58_5 = 0
			local var_58_6 = 0.525

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:GetWordFromCfg(416042013)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 21 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 21)

				if (21 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 21)) > 0 and var_58_6 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042013", "story_v_out_416042.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042013", "story_v_out_416042.awb") / 1000

					if var_58_11 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_5
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_416042", "416042013", "story_v_out_416042.awb")

						arg_55_1:RecordAudio("416042013", var_58_12)
						arg_55_1:RecordAudio("416042013", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_416042", "416042013", "story_v_out_416042.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_416042", "416042013", "story_v_out_416042.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_13 and arg_55_1.time_ < var_58_5 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play416042014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 416042014
		arg_59_1.duration_ = 4.03

		local var_59_0 = {
			zh = 3.1,
			ja = 4.033
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play416042015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1148"]) and arg_59_1.var_.actorSpriteComps1148 == nil then
				arg_59_1.var_.actorSpriteComps1148 = arg_59_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.125

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1148"]) then
				if arg_59_1.var_.actorSpriteComps1148 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1148"]) and arg_59_1.var_.actorSpriteComps1148 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps1148 = nil
			end

			local var_62_2 = 0
			local var_62_3 = 0.325

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_4 = arg_59_1:GetWordFromCfg(416042014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 13 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 13)

				if (13 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 13)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042014", "story_v_out_416042.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042014", "story_v_out_416042.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_416042", "416042014", "story_v_out_416042.awb")

						arg_59_1:RecordAudio("416042014", var_62_9)
						arg_59_1:RecordAudio("416042014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_416042", "416042014", "story_v_out_416042.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_416042", "416042014", "story_v_out_416042.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play416042015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416042015
		arg_63_1.duration_ = 7.33

		local var_63_0 = {
			zh = 4.1,
			ja = 7.333
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play416042016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1148"]) and arg_63_1.var_.actorSpriteComps1148 == nil then
				arg_63_1.var_.actorSpriteComps1148 = arg_63_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.125

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1148"]) then
				if arg_63_1.var_.actorSpriteComps1148 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 1, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1148"]) and arg_63_1.var_.actorSpriteComps1148 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps1148 = nil
			end

			local var_66_2 = arg_63_1.actors_["1148"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1148 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1148", 3)

				for iter_66_4 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_4)

					if var_66_3.name == "split_6" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_66_5 = 0
			local var_66_6 = 0.525

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(416042015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 21 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 21)

				if (21 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 21)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042015", "story_v_out_416042.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042015", "story_v_out_416042.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_416042", "416042015", "story_v_out_416042.awb")

						arg_63_1:RecordAudio("416042015", var_66_12)
						arg_63_1:RecordAudio("416042015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416042", "416042015", "story_v_out_416042.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416042", "416042015", "story_v_out_416042.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play416042016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416042016
		arg_67_1.duration_ = 4

		local var_67_0 = {
			zh = 2.933,
			ja = 4
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
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416042017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.325

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(416042016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 13 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 13)

				if (13 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 13)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042016", "story_v_out_416042.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042016", "story_v_out_416042.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_416042", "416042016", "story_v_out_416042.awb")

						arg_67_1:RecordAudio("416042016", var_70_6)
						arg_67_1:RecordAudio("416042016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_416042", "416042016", "story_v_out_416042.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_416042", "416042016", "story_v_out_416042.awb")
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
	Play416042017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416042017
		arg_71_1.duration_ = 6.77

		local var_71_0 = {
			zh = 3.7,
			ja = 6.766
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
				arg_71_0:Play416042018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 1.00066666666667 < arg_71_1.time_ and arg_71_1.time_ <= 1.00066666666667 + arg_74_0 then
				local var_74_0 = arg_71_1.bgs_.I14f

				arg_71_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_1 = var_74_0:GetComponent("SpriteRenderer")

				if var_74_1 and var_74_1.sprite then
					local var_74_2 = 2 * (var_74_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_0.transform.localScale = Vector3.New(var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "I14f" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_3 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_4 = 1

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_4 then
				local var_74_5 = Color.New(0, 0, 0)

				var_74_5.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_3) / var_74_4)
				arg_71_1.mask_.color = var_74_5
			end

			if arg_71_1.time_ >= var_74_3 + var_74_4 and arg_71_1.time_ < var_74_3 + var_74_4 + arg_74_0 then
				local var_74_6 = Color.New(0, 0, 0)

				var_74_6.a = 1
				arg_71_1.mask_.color = var_74_6
			end

			local var_74_7 = 1.00066666666667

			if 1.00066666666667 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_8 = 0.999333333333333

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 then
				local var_74_9 = Color.New(0, 0, 0)

				var_74_9.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_7) / var_74_8)
				arg_71_1.mask_.color = var_74_9
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 then
				local var_74_10 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_10.a = 0
				arg_71_1.mask_.color = var_74_10
			end

			local var_74_11 = arg_71_1.actors_["1148"].transform

			if 0.966666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.966666666666667 + arg_74_0 then
				arg_71_1.var_.moveOldPos1148 = var_74_11.localPosition
				var_74_11.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1148", 7)

				for iter_74_2 = 0, var_74_11.childCount - 1 do
					local var_74_12 = var_74_11:GetChild(iter_74_2)

					if var_74_12.name == "split_6" or not string.find(var_74_12.name, "split") then
						var_74_12.gameObject:SetActive(true)
					else
						var_74_12.gameObject:SetActive(false)
					end
				end
			end

			local var_74_13 = 0.001

			if 0.966666666666667 <= arg_71_1.time_ and arg_71_1.time_ < 0.966666666666667 + var_74_13 then
				var_74_11.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_71_1.time_ - 0.966666666666667) / var_74_13)
			end

			if arg_71_1.time_ >= 0.966666666666667 + var_74_13 and arg_71_1.time_ < 0.966666666666667 + var_74_13 + arg_74_0 then
				var_74_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_14 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_14 + 0.0333333333333332 and arg_71_1.time_ < var_74_14 + 0.0333333333333332 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_15 = 2
			local var_74_16 = 0.075

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_17 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_17:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_18 = arg_71_1:GetWordFromCfg(416042017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_21 = 3 <= 0 and var_74_16 or var_74_16 * (utf8.len(var_74_19) / 3)

				if (3 <= 0 and var_74_16 or var_74_16 * (utf8.len(var_74_19) / 3)) > 0 and var_74_16 < var_74_21 then
					arg_71_1.talkMaxDuration = var_74_21
					var_74_15 = var_74_15 + 0.3

					if var_74_21 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042017", "story_v_out_416042.awb") ~= 0 then
					local var_74_22 = manager.audio:GetVoiceLength("story_v_out_416042", "416042017", "story_v_out_416042.awb") / 1000

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_416042", "416042017", "story_v_out_416042.awb")

						arg_71_1:RecordAudio("416042017", var_74_23)
						arg_71_1:RecordAudio("416042017", var_74_23)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416042", "416042017", "story_v_out_416042.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416042", "416042017", "story_v_out_416042.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_24 = var_74_15 + 0.3
			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_24 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_24) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_24 + var_74_25 and arg_71_1.time_ < var_74_24 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play416042018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416042018
		arg_77_1.duration_ = 3.63

		local var_77_0 = {
			zh = 3.1,
			ja = 3.633
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
				arg_77_0:Play416042019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.325

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(416042018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 13 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 13)

				if (13 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 13)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042018", "story_v_out_416042.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042018", "story_v_out_416042.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_416042", "416042018", "story_v_out_416042.awb")

						arg_77_1:RecordAudio("416042018", var_80_6)
						arg_77_1:RecordAudio("416042018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416042", "416042018", "story_v_out_416042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416042", "416042018", "story_v_out_416042.awb")
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
	Play416042019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416042019
		arg_81_1.duration_ = 4.27

		local var_81_0 = {
			zh = 3.566,
			ja = 4.266
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
				arg_81_0:Play416042020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148 = arg_81_1.actors_["1148"].transform.localPosition
				arg_81_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1148", 3)

				for iter_84_0 = 0, arg_81_1.actors_["1148"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["1148"].transform:GetChild(iter_84_0)

					if var_84_0.name == "split_5" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_84_2 = 0
			local var_84_3 = 0.325

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(416042019)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 13 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 13)

				if (13 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 13)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042019", "story_v_out_416042.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042019", "story_v_out_416042.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_416042", "416042019", "story_v_out_416042.awb")

						arg_81_1:RecordAudio("416042019", var_84_9)
						arg_81_1:RecordAudio("416042019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416042", "416042019", "story_v_out_416042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416042", "416042019", "story_v_out_416042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416042020
		arg_85_1.duration_ = 8.13

		local var_85_0 = {
			zh = 4.2,
			ja = 8.133
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
				arg_85_0:Play416042021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148 = arg_85_1.actors_["1148"].transform.localPosition
				arg_85_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1148", 7)

				for iter_88_0 = 0, arg_85_1.actors_["1148"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1148"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_5" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_88_2 = 0
			local var_88_3 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_4 = arg_85_1:GetWordFromCfg(416042020)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 17 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 17)

				if (17 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 17)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042020", "story_v_out_416042.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042020", "story_v_out_416042.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_416042", "416042020", "story_v_out_416042.awb")

						arg_85_1:RecordAudio("416042020", var_88_9)
						arg_85_1:RecordAudio("416042020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416042", "416042020", "story_v_out_416042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416042", "416042020", "story_v_out_416042.awb")
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

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416042021
		arg_89_1.duration_ = 4.5

		local var_89_0 = {
			zh = 4.299999999997,
			ja = 4.5
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
				arg_89_0:Play416042022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 1 < arg_89_1.time_ and arg_89_1.time_ <= 1 + arg_92_0 then
				local var_92_0 = arg_89_1.bgs_.I14f

				arg_89_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_1 = var_92_0:GetComponent("SpriteRenderer")

				if var_92_1 and var_92_1.sprite then
					local var_92_2 = 2 * (var_92_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_0.transform.localScale = Vector3.New(var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "I14f" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_3 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_4 = 1

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_4 then
				local var_92_5 = Color.New(0, 0, 0)

				var_92_5.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_3) / var_92_4)
				arg_89_1.mask_.color = var_92_5
			end

			if arg_89_1.time_ >= var_92_3 + var_92_4 and arg_89_1.time_ < var_92_3 + var_92_4 + arg_92_0 then
				local var_92_6 = Color.New(0, 0, 0)

				var_92_6.a = 1
				arg_89_1.mask_.color = var_92_6
			end

			local var_92_7 = 1

			if 1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_8 = 1

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 then
				local var_92_9 = Color.New(0, 0, 0)

				var_92_9.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_7) / var_92_8)
				arg_89_1.mask_.color = var_92_9
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 then
				local var_92_10 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_10.a = 0
				arg_89_1.mask_.color = var_92_10
			end

			local var_92_11 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_11 + 0.0333333333333332 and arg_89_1.time_ < var_92_11 + 0.0333333333333332 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_12 = 2
			local var_92_13 = 0.0666666666666669

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_14 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_14:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_15 = arg_89_1:GetWordFromCfg(416042021)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_18 = 2 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_16) / 2)

				if (2 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_16) / 2)) > 0 and var_92_13 < var_92_18 then
					arg_89_1.talkMaxDuration = var_92_18
					var_92_12 = var_92_12 + 0.3

					if var_92_18 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042021", "story_v_out_416042.awb") ~= 0 then
					local var_92_19 = manager.audio:GetVoiceLength("story_v_out_416042", "416042021", "story_v_out_416042.awb") / 1000

					if var_92_19 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_12
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_416042", "416042021", "story_v_out_416042.awb")

						arg_89_1:RecordAudio("416042021", var_92_20)
						arg_89_1:RecordAudio("416042021", var_92_20)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416042", "416042021", "story_v_out_416042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416042", "416042021", "story_v_out_416042.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = var_92_12 + 0.3
			local var_92_22 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_21) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_21 + var_92_22 and arg_89_1.time_ < var_92_21 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416042022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416042022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play416042023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1148 = arg_95_1.actors_["1148"].transform.localPosition
				arg_95_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1148", 7)

				for iter_98_0 = 0, arg_95_1.actors_["1148"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1148"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_2 = 0
			local var_98_3 = 1.75

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(416042022).content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 70 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 70)

				if (70 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 70)) > 0 and var_98_3 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_7 and arg_95_1.time_ < var_98_2 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play416042023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416042023
		arg_99_1.duration_ = 6.33

		local var_99_0 = {
			zh = 4.5,
			ja = 6.333
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
				arg_99_0:Play416042024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.475

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(416042023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 19 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 19)

				if (19 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 19)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042023", "story_v_out_416042.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042023", "story_v_out_416042.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_416042", "416042023", "story_v_out_416042.awb")

						arg_99_1:RecordAudio("416042023", var_102_6)
						arg_99_1:RecordAudio("416042023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_416042", "416042023", "story_v_out_416042.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_416042", "416042023", "story_v_out_416042.awb")
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
	Play416042024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416042024
		arg_103_1.duration_ = 5.5

		local var_103_0 = {
			zh = 4.633,
			ja = 5.5
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
				arg_103_0:Play416042025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1148"]) and arg_103_1.var_.actorSpriteComps1148 == nil then
				arg_103_1.var_.actorSpriteComps1148 = arg_103_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.125

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1148"]) then
				if arg_103_1.var_.actorSpriteComps1148 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1148"]) and arg_103_1.var_.actorSpriteComps1148 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1148 = nil
			end

			local var_106_2 = arg_103_1.actors_["1148"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1148 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1148", 3)

				for iter_106_4 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_4)

					if var_106_3.name == "split_6" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_106_5 = 0
			local var_106_6 = 0.475

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(416042024)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 19 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 19)

				if (19 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 19)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042024", "story_v_out_416042.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042024", "story_v_out_416042.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_416042", "416042024", "story_v_out_416042.awb")

						arg_103_1:RecordAudio("416042024", var_106_12)
						arg_103_1:RecordAudio("416042024", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416042", "416042024", "story_v_out_416042.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416042", "416042024", "story_v_out_416042.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play416042025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416042025
		arg_107_1.duration_ = 4.77

		local var_107_0 = {
			zh = 2.7,
			ja = 4.766
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
				arg_107_0:Play416042026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1148 = arg_107_1.actors_["1148"].transform.localPosition
				arg_107_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1148", 3)

				for iter_110_0 = 0, arg_107_1.actors_["1148"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["1148"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_6" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_110_2 = 0
			local var_110_3 = 0.35

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(416042025)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 14 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 14)

				if (14 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 14)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042025", "story_v_out_416042.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042025", "story_v_out_416042.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_416042", "416042025", "story_v_out_416042.awb")

						arg_107_1:RecordAudio("416042025", var_110_9)
						arg_107_1:RecordAudio("416042025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416042", "416042025", "story_v_out_416042.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416042", "416042025", "story_v_out_416042.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416042026
		arg_111_1.duration_ = 2.4

		local var_111_0 = {
			zh = 2.4,
			ja = 2.266
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
				arg_111_0:Play416042027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= 0 + 0.175 and arg_111_1.time_ < 0 + 0.175 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_0 = 0
			local var_114_1 = 0.175

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(416042026)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 7 <= 0 and var_114_1 or var_114_1 * (utf8.len(var_114_3) / 7)

				if (7 <= 0 and var_114_1 or var_114_1 * (utf8.len(var_114_3) / 7)) > 0 and var_114_1 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042026", "story_v_out_416042.awb") ~= 0 then
					local var_114_6 = manager.audio:GetVoiceLength("story_v_out_416042", "416042026", "story_v_out_416042.awb") / 1000

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end

					if var_114_2.prefab_name ~= "" and arg_111_1.actors_[var_114_2.prefab_name] ~= nil then
						local var_114_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_2.prefab_name].transform, "story_v_out_416042", "416042026", "story_v_out_416042.awb")

						arg_111_1:RecordAudio("416042026", var_114_7)
						arg_111_1:RecordAudio("416042026", var_114_7)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416042", "416042026", "story_v_out_416042.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416042", "416042026", "story_v_out_416042.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_8 and arg_111_1.time_ < var_114_0 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416042027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416042027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play416042028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = arg_115_1.actors_["1148"].transform.localPosition
				arg_115_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 7)

				for iter_118_0 = 0, arg_115_1.actors_["1148"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1148"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_2 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			if arg_115_1.time_ >= var_118_2 + 0.5 and arg_115_1.time_ < var_118_2 + 0.5 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_3 = 0
			local var_118_4 = 1.9

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(416042027).content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 76 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 76)

				if (76 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 76)) > 0 and var_118_4 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_8 and arg_115_1.time_ < var_118_3 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416042028
		arg_119_1.duration_ = 6.73

		local var_119_0 = {
			zh = 3.133,
			ja = 6.733
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
				arg_119_0:Play416042029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1148"]) and arg_119_1.var_.actorSpriteComps1148 == nil then
				arg_119_1.var_.actorSpriteComps1148 = arg_119_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.125

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1148"]) then
				if arg_119_1.var_.actorSpriteComps1148 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1148"]) and arg_119_1.var_.actorSpriteComps1148 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1148 = nil
			end

			local var_122_2 = arg_119_1.actors_["1148"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1148 = var_122_2.localPosition
				var_122_2.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1148", 3)

				for iter_122_4 = 0, var_122_2.childCount - 1 do
					local var_122_3 = var_122_2:GetChild(iter_122_4)

					if var_122_3.name == "split_6" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_2.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_119_1.time_ - 0) / var_122_4)
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_122_5 = 0
			local var_122_6 = 0.3

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(416042028)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 12 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 12)

				if (12 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 12)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042028", "story_v_out_416042.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042028", "story_v_out_416042.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_416042", "416042028", "story_v_out_416042.awb")

						arg_119_1:RecordAudio("416042028", var_122_12)
						arg_119_1:RecordAudio("416042028", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416042", "416042028", "story_v_out_416042.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416042", "416042028", "story_v_out_416042.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play416042029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416042029
		arg_123_1.duration_ = 6.43

		local var_123_0 = {
			zh = 6.266,
			ja = 6.433
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
				arg_123_0:Play416042030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1148"]) and arg_123_1.var_.actorSpriteComps1148 == nil then
				arg_123_1.var_.actorSpriteComps1148 = arg_123_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.125

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1148"]) then
				if arg_123_1.var_.actorSpriteComps1148 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1148"]) and arg_123_1.var_.actorSpriteComps1148 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1148 = nil
			end

			local var_126_2 = 0
			local var_126_3 = 0.45

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_4 = arg_123_1:GetWordFromCfg(416042029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 18 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 18)

				if (18 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 18)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042029", "story_v_out_416042.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042029", "story_v_out_416042.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_416042", "416042029", "story_v_out_416042.awb")

						arg_123_1:RecordAudio("416042029", var_126_9)
						arg_123_1:RecordAudio("416042029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416042", "416042029", "story_v_out_416042.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416042", "416042029", "story_v_out_416042.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play416042030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416042030
		arg_127_1.duration_ = 5.07

		local var_127_0 = {
			zh = 4.7,
			ja = 5.066
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
				arg_127_0:Play416042031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1148"]) and arg_127_1.var_.actorSpriteComps1148 == nil then
				arg_127_1.var_.actorSpriteComps1148 = arg_127_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.125

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1148"]) then
				if arg_127_1.var_.actorSpriteComps1148 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 1, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1148"]) and arg_127_1.var_.actorSpriteComps1148 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1148 = nil
			end

			local var_130_2 = 0
			local var_130_3 = 0.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:GetWordFromCfg(416042030)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 24 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 24)

				if (24 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 24)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042030", "story_v_out_416042.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042030", "story_v_out_416042.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_out_416042", "416042030", "story_v_out_416042.awb")

						arg_127_1:RecordAudio("416042030", var_130_9)
						arg_127_1:RecordAudio("416042030", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416042", "416042030", "story_v_out_416042.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416042", "416042030", "story_v_out_416042.awb")
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
	Play416042031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416042031
		arg_131_1.duration_ = 3.02

		local var_131_0 = {
			zh = 2.415999999999,
			ja = 3.015999999999
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
				arg_131_0:Play416042032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1148 = arg_131_1.actors_["1148"].transform.localPosition
				arg_131_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1148", 3)

				for iter_134_0 = 0, arg_131_1.actors_["1148"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["1148"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_3" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_134_2 = manager.ui.mainCamera.transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.shakeOldPos = var_134_2.localPosition
			end

			local var_134_3 = 0.433333333333333

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 then
				local var_134_4, var_134_5 = math.modf((arg_131_1.time_ - 0) / 0.066)

				var_134_2.localPosition = Vector3.New(var_134_5 * 0.13, var_134_5 * 0.13, var_134_5 * 0.13) + arg_131_1.var_.shakeOldPos
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 then
				var_134_2.localPosition = arg_131_1.var_.shakeOldPos
			end

			local var_134_6 = 0

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.allBtn_.enabled = false
			end

			if arg_131_1.time_ >= var_134_6 + 0.849999999999 and arg_131_1.time_ < var_134_6 + 0.849999999999 + arg_134_0 then
				arg_131_1.allBtn_.enabled = true
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_7 = 0.849999999999
			local var_134_8 = 0.15

			if 0.849999999999 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_9 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_9:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(416042031)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 6 <= 0 and var_134_8 or var_134_8 * (utf8.len(var_134_11) / 6)

				if (6 <= 0 and var_134_8 or var_134_8 * (utf8.len(var_134_11) / 6)) > 0 and var_134_8 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13
					var_134_7 = var_134_7 + 0.3

					if var_134_13 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_7
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042031", "story_v_out_416042.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042031", "story_v_out_416042.awb") / 1000

					if var_134_14 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_7
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_416042", "416042031", "story_v_out_416042.awb")

						arg_131_1:RecordAudio("416042031", var_134_15)
						arg_131_1:RecordAudio("416042031", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416042", "416042031", "story_v_out_416042.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416042", "416042031", "story_v_out_416042.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = var_134_7 + 0.3
			local var_134_17 = math.max(var_134_8, arg_131_1.talkMaxDuration)

			if var_134_7 + 0.3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_16) / var_134_17

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play416042032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416042032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play416042033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1148 = arg_137_1.actors_["1148"].transform.localPosition
				arg_137_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1148", 7)

				for iter_140_0 = 0, arg_137_1.actors_["1148"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1148"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_2" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_2 = 0
			local var_140_3 = 1.2

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(416042032).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 48 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 48)

				if (48 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 48)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416042033
		arg_141_1.duration_ = 6.9

		local var_141_0 = {
			zh = 5.4,
			ja = 6.9
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
				arg_141_0:Play416042034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148 = arg_141_1.actors_["1148"].transform.localPosition
				arg_141_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1148", 3)

				for iter_144_0 = 0, arg_141_1.actors_["1148"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["1148"].transform:GetChild(iter_144_0)

					if var_144_0.name == "split_6" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_144_2 = arg_141_1.actors_["1148"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1148 == nil then
				arg_141_1.var_.actorSpriteComps1148 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps1148 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1148 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps1148 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(416042033)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 19 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 19)

				if (19 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 19)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042033", "story_v_out_416042.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042033", "story_v_out_416042.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_416042", "416042033", "story_v_out_416042.awb")

						arg_141_1:RecordAudio("416042033", var_144_12)
						arg_141_1:RecordAudio("416042033", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416042", "416042033", "story_v_out_416042.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416042", "416042033", "story_v_out_416042.awb")
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
				actorName = "1148",
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
	Play416042034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416042034
		arg_145_1.duration_ = 5.03

		local var_145_0 = {
			zh = 5.033,
			ja = 4.666
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
				arg_145_0:Play416042035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.375

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(416042034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 15 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 15)

				if (15 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 15)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042034", "story_v_out_416042.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042034", "story_v_out_416042.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_416042", "416042034", "story_v_out_416042.awb")

						arg_145_1:RecordAudio("416042034", var_148_6)
						arg_145_1:RecordAudio("416042034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416042", "416042034", "story_v_out_416042.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416042", "416042034", "story_v_out_416042.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play416042035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416042035
		arg_149_1.duration_ = 6.97

		local var_149_0 = {
			zh = 6.366,
			ja = 6.966
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
				arg_149_0:Play416042036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1148"]) and arg_149_1.var_.actorSpriteComps1148 == nil then
				arg_149_1.var_.actorSpriteComps1148 = arg_149_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.125

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1148"]) then
				if arg_149_1.var_.actorSpriteComps1148 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1148"]) and arg_149_1.var_.actorSpriteComps1148 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1148 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.675

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:GetWordFromCfg(416042035)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 27 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 27)

				if (27 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 27)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042035", "story_v_out_416042.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042035", "story_v_out_416042.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_416042", "416042035", "story_v_out_416042.awb")

						arg_149_1:RecordAudio("416042035", var_152_9)
						arg_149_1:RecordAudio("416042035", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416042", "416042035", "story_v_out_416042.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416042", "416042035", "story_v_out_416042.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416042036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416042036
		arg_153_1.duration_ = 6.7

		local var_153_0 = {
			zh = 6.033,
			ja = 6.7
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
				arg_153_0:Play416042037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1148"]) and arg_153_1.var_.actorSpriteComps1148 == nil then
				arg_153_1.var_.actorSpriteComps1148 = arg_153_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.125

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1148"]) then
				if arg_153_1.var_.actorSpriteComps1148 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1148"]) and arg_153_1.var_.actorSpriteComps1148 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1148 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(416042036)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 20 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 20)

				if (20 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 20)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042036", "story_v_out_416042.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042036", "story_v_out_416042.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_416042", "416042036", "story_v_out_416042.awb")

						arg_153_1:RecordAudio("416042036", var_156_9)
						arg_153_1:RecordAudio("416042036", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416042", "416042036", "story_v_out_416042.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416042", "416042036", "story_v_out_416042.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416042037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416042037
		arg_157_1.duration_ = 8.4

		local var_157_0 = {
			zh = 5.933,
			ja = 8.4
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
				arg_157_0:Play416042038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(416042037)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 24 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 24)

				if (24 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 24)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042037", "story_v_out_416042.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042037", "story_v_out_416042.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_416042", "416042037", "story_v_out_416042.awb")

						arg_157_1:RecordAudio("416042037", var_160_6)
						arg_157_1:RecordAudio("416042037", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416042", "416042037", "story_v_out_416042.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416042", "416042037", "story_v_out_416042.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416042038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416042038
		arg_161_1.duration_ = 5.1

		local var_161_0 = {
			zh = 4.9,
			ja = 5.1
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
				arg_161_0:Play416042039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1148"]) and arg_161_1.var_.actorSpriteComps1148 == nil then
				arg_161_1.var_.actorSpriteComps1148 = arg_161_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.125

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1148"]) then
				if arg_161_1.var_.actorSpriteComps1148 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1148"]) and arg_161_1.var_.actorSpriteComps1148 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps1148 = nil
			end

			local var_164_2 = 0
			local var_164_3 = 0.45

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_4 = arg_161_1:GetWordFromCfg(416042038)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 18 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 18)

				if (18 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 18)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042038", "story_v_out_416042.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042038", "story_v_out_416042.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_416042", "416042038", "story_v_out_416042.awb")

						arg_161_1:RecordAudio("416042038", var_164_9)
						arg_161_1:RecordAudio("416042038", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416042", "416042038", "story_v_out_416042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416042", "416042038", "story_v_out_416042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play416042039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416042039
		arg_165_1.duration_ = 5.57

		local var_165_0 = {
			zh = 3.466,
			ja = 5.566
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play416042040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1148"]) and arg_165_1.var_.actorSpriteComps1148 == nil then
				arg_165_1.var_.actorSpriteComps1148 = arg_165_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.125

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1148"]) then
				if arg_165_1.var_.actorSpriteComps1148 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 1, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1148"]) and arg_165_1.var_.actorSpriteComps1148 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1148 = nil
			end

			local var_168_2 = 0
			local var_168_3 = 0.375

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(416042039)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 15 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 15)

				if (15 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 15)) > 0 and var_168_3 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042039", "story_v_out_416042.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042039", "story_v_out_416042.awb") / 1000

					if var_168_8 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_2
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_416042", "416042039", "story_v_out_416042.awb")

						arg_165_1:RecordAudio("416042039", var_168_9)
						arg_165_1:RecordAudio("416042039", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416042", "416042039", "story_v_out_416042.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416042", "416042039", "story_v_out_416042.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_10 and arg_165_1.time_ < var_168_2 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play416042040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416042040
		arg_169_1.duration_ = 5.23

		local var_169_0 = {
			zh = 5.233,
			ja = 4.733
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
				arg_169_0:Play416042041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1148"]) and arg_169_1.var_.actorSpriteComps1148 == nil then
				arg_169_1.var_.actorSpriteComps1148 = arg_169_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.125

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1148"]) then
				if arg_169_1.var_.actorSpriteComps1148 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1148"]) and arg_169_1.var_.actorSpriteComps1148 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1148 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.575

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_4 = arg_169_1:GetWordFromCfg(416042040)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 23 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 23)

				if (23 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 23)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042040", "story_v_out_416042.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042040", "story_v_out_416042.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_416042", "416042040", "story_v_out_416042.awb")

						arg_169_1:RecordAudio("416042040", var_172_9)
						arg_169_1:RecordAudio("416042040", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416042", "416042040", "story_v_out_416042.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416042", "416042040", "story_v_out_416042.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416042041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416042041
		arg_173_1.duration_ = 7.13

		local var_173_0 = {
			zh = 5.133,
			ja = 7.133
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
				arg_173_0:Play416042042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1148"]) and arg_173_1.var_.actorSpriteComps1148 == nil then
				arg_173_1.var_.actorSpriteComps1148 = arg_173_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.125

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1148"]) then
				if arg_173_1.var_.actorSpriteComps1148 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 1, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1148"]) and arg_173_1.var_.actorSpriteComps1148 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps1148 = nil
			end

			local var_176_2 = 0
			local var_176_3 = 0.45

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:GetWordFromCfg(416042041)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 18 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 18)

				if (18 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 18)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042041", "story_v_out_416042.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042041", "story_v_out_416042.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_416042", "416042041", "story_v_out_416042.awb")

						arg_173_1:RecordAudio("416042041", var_176_9)
						arg_173_1:RecordAudio("416042041", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416042", "416042041", "story_v_out_416042.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416042", "416042041", "story_v_out_416042.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416042042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416042042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play416042043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1148 = arg_177_1.actors_["1148"].transform.localPosition
				arg_177_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1148", 7)

				for iter_180_0 = 0, arg_177_1.actors_["1148"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["1148"].transform:GetChild(iter_180_0)

					if var_180_0.name == "" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_180_2 = 0
			local var_180_3 = 1

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

				local var_180_4 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(416042042).content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 40 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 40)

				if (40 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 40)) > 0 and var_180_3 < var_180_6 then
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

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play416042043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416042043
		arg_181_1.duration_ = 4.93

		local var_181_0 = {
			zh = 4.933,
			ja = 4.733
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
				arg_181_0:Play416042044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1148 = arg_181_1.actors_["1148"].transform.localPosition
				arg_181_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1148", 3)

				for iter_184_0 = 0, arg_181_1.actors_["1148"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["1148"].transform:GetChild(iter_184_0)

					if var_184_0.name == "split_4" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_184_2 = arg_181_1.actors_["1148"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1148 == nil then
				arg_181_1.var_.actorSpriteComps1148 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.125

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1148 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1148 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1148 = nil
			end

			if 2.6 < arg_181_1.time_ and arg_181_1.time_ <= 2.6 + arg_184_0 then
				arg_181_1:AudioAction("play", "effect", "se_story_138", "se_story_138_sizzle", "")
			end

			local var_184_6 = 0
			local var_184_7 = 0.5

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(416042043)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 20 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 20)

				if (20 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 20)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042043", "story_v_out_416042.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_416042", "416042043", "story_v_out_416042.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_416042", "416042043", "story_v_out_416042.awb")

						arg_181_1:RecordAudio("416042043", var_184_13)
						arg_181_1:RecordAudio("416042043", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416042", "416042043", "story_v_out_416042.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416042", "416042043", "story_v_out_416042.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416042044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416042045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1148 = arg_185_1.actors_["1148"].transform.localPosition
				arg_185_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1148", 7)

				for iter_188_0 = 0, arg_185_1.actors_["1148"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["1148"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_6" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_188_2 = 0
			local var_188_3 = 1.925

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(416042044).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 77 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 77)

				if (77 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 77)) > 0 and var_188_3 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_7 and arg_185_1.time_ < var_188_2 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416042045
		arg_189_1.duration_ = 4.53

		local var_189_0 = {
			zh = 2.8,
			ja = 4.533
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
				arg_189_0:Play416042046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1148"]) and arg_189_1.var_.actorSpriteComps1148 == nil then
				arg_189_1.var_.actorSpriteComps1148 = arg_189_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.125

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1148"]) then
				if arg_189_1.var_.actorSpriteComps1148 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 1, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1148"]) and arg_189_1.var_.actorSpriteComps1148 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1148 = nil
			end

			local var_192_2 = arg_189_1.actors_["1148"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1148", 3)

				for iter_192_4 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_4)

					if var_192_3.name == "split_6" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_192_5 = 0
			local var_192_6 = 0.2

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(416042045)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 8 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 8)

				if (8 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 8)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042045", "story_v_out_416042.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042045", "story_v_out_416042.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_416042", "416042045", "story_v_out_416042.awb")

						arg_189_1:RecordAudio("416042045", var_192_12)
						arg_189_1:RecordAudio("416042045", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_416042", "416042045", "story_v_out_416042.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_416042", "416042045", "story_v_out_416042.awb")
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
				actorName = "1148",
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
	Play416042046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416042046
		arg_193_1.duration_ = 8.57

		local var_193_0 = {
			zh = 7.033,
			ja = 8.566
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play416042047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.625

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(416042046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 25 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 25)

				if (25 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 25)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042046", "story_v_out_416042.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042046", "story_v_out_416042.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_416042", "416042046", "story_v_out_416042.awb")

						arg_193_1:RecordAudio("416042046", var_196_6)
						arg_193_1:RecordAudio("416042046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416042", "416042046", "story_v_out_416042.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416042", "416042046", "story_v_out_416042.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play416042047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416042047
		arg_197_1.duration_ = 4.17

		local var_197_0 = {
			zh = 4.166,
			ja = 3.666
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
				arg_197_0:Play416042048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1148"]) and arg_197_1.var_.actorSpriteComps1148 == nil then
				arg_197_1.var_.actorSpriteComps1148 = arg_197_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_0 = 0.125

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1148"]) then
				if arg_197_1.var_.actorSpriteComps1148 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								iter_200_1.color = Color.New(Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_0), Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_0), (Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_0)))
							else
								local var_200_1 = Mathf.Lerp(iter_200_1.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_0)

								iter_200_1.color = Color.New(var_200_1, var_200_1, var_200_1)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1148"]) and arg_197_1.var_.actorSpriteComps1148 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_200_3 then
						iter_200_3.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps1148 = nil
			end

			local var_200_2 = 0
			local var_200_3 = 0.225

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_4 = arg_197_1:GetWordFromCfg(416042047)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 9 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 9)

				if (9 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 9)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042047", "story_v_out_416042.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042047", "story_v_out_416042.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_416042", "416042047", "story_v_out_416042.awb")

						arg_197_1:RecordAudio("416042047", var_200_9)
						arg_197_1:RecordAudio("416042047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416042", "416042047", "story_v_out_416042.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416042", "416042047", "story_v_out_416042.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play416042048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416042048
		arg_201_1.duration_ = 5.93

		local var_201_0 = {
			zh = 4.666,
			ja = 5.933
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play416042049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1148"]) and arg_201_1.var_.actorSpriteComps1148 == nil then
				arg_201_1.var_.actorSpriteComps1148 = arg_201_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.125

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1148"]) then
				if arg_201_1.var_.actorSpriteComps1148 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 1, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1148"]) and arg_201_1.var_.actorSpriteComps1148 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps1148 = nil
			end

			local var_204_2 = arg_201_1.actors_["1148"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1148 = var_204_2.localPosition
				var_204_2.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1148", 3)

				for iter_204_4 = 0, var_204_2.childCount - 1 do
					local var_204_3 = var_204_2:GetChild(iter_204_4)

					if var_204_3.name == "split_6" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_2.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_201_1.time_ - 0) / var_204_4)
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_204_5 = 0
			local var_204_6 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(416042048)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 19 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 19)

				if (19 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 19)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042048", "story_v_out_416042.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042048", "story_v_out_416042.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_416042", "416042048", "story_v_out_416042.awb")

						arg_201_1:RecordAudio("416042048", var_204_12)
						arg_201_1:RecordAudio("416042048", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416042", "416042048", "story_v_out_416042.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416042", "416042048", "story_v_out_416042.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_13 and arg_201_1.time_ < var_204_5 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play416042049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416042049
		arg_205_1.duration_ = 7.1

		local var_205_0 = {
			zh = 4.5,
			ja = 7.1
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play416042050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(416042049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 22 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 22)

				if (22 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 22)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042049", "story_v_out_416042.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042049", "story_v_out_416042.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_416042", "416042049", "story_v_out_416042.awb")

						arg_205_1:RecordAudio("416042049", var_208_6)
						arg_205_1:RecordAudio("416042049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_416042", "416042049", "story_v_out_416042.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_416042", "416042049", "story_v_out_416042.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play416042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416042050
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play416042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_9000

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= 4 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			if arg_209_1.time_ >= 4 + 0.3 and arg_209_1.time_ < 4 + 0.3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_0 = "SS1602"

			if arg_209_1.bgs_.SS1602 == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_2 = arg_209_1.bgs_.SS1602

				arg_209_1.bgs_.SS1602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_3 = var_212_2:GetComponent("SpriteRenderer")

				if var_212_3 and var_212_3.sprite then
					local var_212_4 = 2 * (var_212_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_2.transform.localScale = Vector3.New(var_212_4 / var_212_3.sprite.bounds.size.y < var_212_4 * manager.ui.mainCameraCom_.aspect / var_212_3.sprite.bounds.size.x and var_212_4 * manager.ui.mainCameraCom_.aspect / var_212_3.sprite.bounds.size.x or var_212_4 / var_212_3.sprite.bounds.size.y, var_212_4 / var_212_3.sprite.bounds.size.y < var_212_4 * manager.ui.mainCameraCom_.aspect / var_212_3.sprite.bounds.size.x and var_212_4 * manager.ui.mainCameraCom_.aspect / var_212_3.sprite.bounds.size.x or var_212_4 / var_212_3.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "SS1602" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_5 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_6 = 2

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_5) / var_212_6)
				arg_209_1.mask_.color = var_212_7
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 then
				local var_212_8 = Color.New(0, 0, 0)

				var_212_8.a = 1
				arg_209_1.mask_.color = var_212_8
			end

			local var_212_9 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_10 = 2

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 then
				local var_212_11 = Color.New(0, 0, 0)

				var_212_11.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_9) / var_212_10)
				arg_209_1.mask_.color = var_212_11
			end

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 then
				local var_212_12 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_12.a = 0
				arg_209_1.mask_.color = var_212_12
			end

			local var_212_13 = arg_209_1.actors_["1148"].transform

			if 1.966 < arg_209_1.time_ and arg_209_1.time_ <= 1.966 + arg_212_0 then
				arg_209_1.var_.moveOldPos1148 = var_212_13.localPosition
				var_212_13.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1148", 7)

				for iter_212_2 = 0, var_212_13.childCount - 1 do
					local var_212_14 = var_212_13:GetChild(iter_212_2)

					if var_212_14.name == "" or not string.find(var_212_14.name, "split") then
						var_212_14.gameObject:SetActive(true)
					else
						var_212_14.gameObject:SetActive(false)
					end
				end
			end

			local var_212_15 = 0.001

			if 1.966 <= arg_209_1.time_ and arg_209_1.time_ < 1.966 + var_212_15 then
				var_212_13.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_209_1.time_ - 1.966) / var_212_15)
			end

			if arg_209_1.time_ >= 1.966 + var_212_15 and arg_209_1.time_ < 1.966 + var_212_15 + arg_212_0 then
				var_212_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_16 = arg_209_1.var_.effect3330402

				if not arg_209_1.var_.effect3330402 then
					var_212_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_212_16.name = "0402"
					arg_209_1.var_.effect3330402 = var_212_16
				else
					var_212_16.transform:SetParent(var_212_9000)
				end

				var_212_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_212_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_212_18 = arg_209_1.bgs_.SS1602.transform

			if 2.03333333333333 < arg_209_1.time_ and arg_209_1.time_ <= 2.03333333333333 + arg_212_0 then
				arg_209_1.var_.moveOldPosSS1602 = var_212_18.localPosition
			end

			local var_212_19 = 0.001

			if 2.03333333333333 <= arg_209_1.time_ and arg_209_1.time_ < 2.03333333333333 + var_212_19 then
				var_212_18.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSS1602, Vector3.New(0, 1, 10), (arg_209_1.time_ - 2.03333333333333) / var_212_19)
			end

			if arg_209_1.time_ >= 2.03333333333333 + var_212_19 and arg_209_1.time_ < 2.03333333333333 + var_212_19 + arg_212_0 then
				var_212_18.localPosition = Vector3.New(0, 1, 10)
			end

			local var_212_20 = arg_209_1.bgs_.SS1602.transform

			if 2.06733333333333 < arg_209_1.time_ and arg_209_1.time_ <= 2.06733333333333 + arg_212_0 then
				arg_209_1.var_.moveOldPosSS1602 = var_212_20.localPosition
			end

			local var_212_21 = 1.93266666666667

			if 2.06733333333333 <= arg_209_1.time_ and arg_209_1.time_ < 2.06733333333333 + var_212_21 then
				var_212_20.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSS1602, Vector3.New(0, 1, 9), (arg_209_1.time_ - 2.06733333333333) / var_212_21)
			end

			if arg_209_1.time_ >= 2.06733333333333 + var_212_21 and arg_209_1.time_ < 2.06733333333333 + var_212_21 + arg_212_0 then
				var_212_20.localPosition = Vector3.New(0, 1, 9)
			end

			local var_212_22 = manager.ui.mainCamera.transform

			if 4.3 < arg_209_1.time_ and arg_209_1.time_ <= 4.3 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_22.localPosition
			end

			local var_212_23 = 0.9

			if 4.3 <= arg_209_1.time_ and arg_209_1.time_ < 4.3 + var_212_23 then
				local var_212_24, var_212_25 = math.modf((arg_209_1.time_ - 4.3) / 0.066)

				var_212_22.localPosition = Vector3.New(var_212_25 * 0.13, var_212_25 * 0.13, var_212_25 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= 4.3 + var_212_23 and arg_209_1.time_ < 4.3 + var_212_23 + arg_212_0 then
				var_212_22.localPosition = arg_209_1.var_.shakeOldPos
			end

			if 4.3 < arg_209_1.time_ and arg_209_1.time_ <= 4.3 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_fire", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_27 = 4
			local var_212_28 = 1.55

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_27 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_29 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_29:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_30 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(416042050).content)

				arg_209_1.text_.text = var_212_30

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_32 = 62 <= 0 and var_212_28 or var_212_28 * (utf8.len(var_212_30) / 62)

				if (62 <= 0 and var_212_28 or var_212_28 * (utf8.len(var_212_30) / 62)) > 0 and var_212_28 < var_212_32 then
					arg_209_1.talkMaxDuration = var_212_32
					var_212_27 = var_212_27 + 0.3

					if var_212_32 + var_212_27 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_32 + var_212_27
					end
				end

				arg_209_1.text_.text = var_212_30
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_33 = var_212_27 + 0.3
			local var_212_34 = math.max(var_212_28, arg_209_1.talkMaxDuration)

			if var_212_27 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_33 + var_212_34 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_33) / var_212_34

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_33 + var_212_34 and arg_209_1.time_ < var_212_33 + var_212_34 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93266666666667,
				className = "StoryMoveNode",
				startTime = 2.06733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play416042051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416042051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416042052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.95

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

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(416042051).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 78 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 78)

				if (78 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 78)) > 0 and var_218_0 < var_218_3 then
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
	Play416042052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416042052
		arg_219_1.duration_ = 5.57

		local var_219_0 = {
			zh = 4.833,
			ja = 5.566
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
				arg_219_0:Play416042053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(416042052)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 12 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 12)

				if (12 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 12)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042052", "story_v_out_416042.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042052", "story_v_out_416042.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_416042", "416042052", "story_v_out_416042.awb")

						arg_219_1:RecordAudio("416042052", var_222_6)
						arg_219_1:RecordAudio("416042052", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416042", "416042052", "story_v_out_416042.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416042", "416042052", "story_v_out_416042.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play416042053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416042053
		arg_223_1.duration_ = 11.2

		local var_223_0 = {
			zh = 6.2,
			ja = 11.2
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
				arg_223_0:Play416042054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.6

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:GetWordFromCfg(416042053)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 24 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 24)

				if (24 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 24)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042053", "story_v_out_416042.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042053", "story_v_out_416042.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_416042", "416042053", "story_v_out_416042.awb")

						arg_223_1:RecordAudio("416042053", var_226_6)
						arg_223_1:RecordAudio("416042053", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416042", "416042053", "story_v_out_416042.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416042", "416042053", "story_v_out_416042.awb")
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
	Play416042054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416042054
		arg_227_1.duration_ = 7.5

		local var_227_0 = {
			zh = 5.4,
			ja = 7.5
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
				arg_227_0:Play416042055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.525

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(416042054)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 21 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 21)

				if (21 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 21)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042054", "story_v_out_416042.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042054", "story_v_out_416042.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_416042", "416042054", "story_v_out_416042.awb")

						arg_227_1:RecordAudio("416042054", var_230_6)
						arg_227_1:RecordAudio("416042054", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416042", "416042054", "story_v_out_416042.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416042", "416042054", "story_v_out_416042.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416042055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416042055
		arg_231_1.duration_ = 4.26

		local var_231_0 = {
			zh = 3.158,
			ja = 4.258
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
				arg_231_0:Play416042056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_9000

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1148 = arg_231_1.actors_["1148"].transform.localPosition
				arg_231_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1148", 7)

				for iter_234_0 = 0, arg_231_1.actors_["1148"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["1148"].transform:GetChild(iter_234_0)

					if var_234_0.name == "" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				local var_234_2 = arg_231_1.var_.effect77

				if not arg_231_1.var_.effect77 then
					var_234_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_234_2.name = "77"
					arg_231_1.var_.effect77 = var_234_2
				else
					var_234_2.transform:SetParent(var_234_9000)
				end

				var_234_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_231_1.time_ and arg_231_1.time_ <= 1 + arg_234_0 then
				if arg_231_1.var_.effect77 then
					Object.Destroy(arg_231_1.var_.effect77)

					arg_231_1.var_.effect77 = nil
				end
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_16", "se_story_16_channel", "")
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_6 = 0.625
			local var_234_7 = 0.375

			if 0.625 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_8 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_8:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(416042055)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_12 = 15 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_10) / 15)

				if (15 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_10) / 15)) > 0 and var_234_7 < var_234_12 then
					arg_231_1.talkMaxDuration = var_234_12
					var_234_6 = var_234_6 + 0.3

					if var_234_12 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042055", "story_v_out_416042.awb") ~= 0 then
					local var_234_13 = manager.audio:GetVoiceLength("story_v_out_416042", "416042055", "story_v_out_416042.awb") / 1000

					if var_234_13 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_6
					end

					if var_234_9.prefab_name ~= "" and arg_231_1.actors_[var_234_9.prefab_name] ~= nil then
						local var_234_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_9.prefab_name].transform, "story_v_out_416042", "416042055", "story_v_out_416042.awb")

						arg_231_1:RecordAudio("416042055", var_234_14)
						arg_231_1:RecordAudio("416042055", var_234_14)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416042", "416042055", "story_v_out_416042.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416042", "416042055", "story_v_out_416042.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_15 = var_234_6 + 0.3
			local var_234_16 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_16 and arg_231_1.time_ < var_234_15 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416042056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 416042056
		arg_237_1.duration_ = 5.93

		local var_237_0 = {
			zh = 5.633,
			ja = 5.933
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play416042057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.575

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(416042056)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 23 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 23)

				if (23 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 23)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042056", "story_v_out_416042.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042056", "story_v_out_416042.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_416042", "416042056", "story_v_out_416042.awb")

						arg_237_1:RecordAudio("416042056", var_240_6)
						arg_237_1:RecordAudio("416042056", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_416042", "416042056", "story_v_out_416042.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_416042", "416042056", "story_v_out_416042.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play416042057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 416042057
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play416042058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 2.05

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

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(416042057).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 82 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 82)

				if (82 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 82)) > 0 and var_244_0 < var_244_3 then
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
	Play416042058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 416042058
		arg_245_1.duration_ = 6.6

		local var_245_0 = {
			zh = 4.033,
			ja = 6.6
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
				arg_245_0:Play416042059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_0 = arg_245_1.var_.effect77

				if not arg_245_1.var_.effect77 then
					var_248_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_248_0.name = "77"
					arg_245_1.var_.effect77 = var_248_0
				else
					var_248_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_248_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_245_1.time_ and arg_245_1.time_ <= 1 + arg_248_0 then
				if arg_245_1.var_.effect77 then
					Object.Destroy(arg_245_1.var_.effect77)

					arg_245_1.var_.effect77 = nil
				end
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_16", "se_story_16_channel", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_4 = 1
			local var_248_5 = 0.45

			if 1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_6 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_6:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_7 = arg_245_1:GetWordFromCfg(416042058)
				local var_248_8 = arg_245_1:FormatText(var_248_7.content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 18 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_8) / 18)

				if (18 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_8) / 18)) > 0 and var_248_5 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10
					var_248_4 = var_248_4 + 0.3

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042058", "story_v_out_416042.awb") ~= 0 then
					local var_248_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042058", "story_v_out_416042.awb") / 1000

					if var_248_11 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_4
					end

					if var_248_7.prefab_name ~= "" and arg_245_1.actors_[var_248_7.prefab_name] ~= nil then
						local var_248_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_7.prefab_name].transform, "story_v_out_416042", "416042058", "story_v_out_416042.awb")

						arg_245_1:RecordAudio("416042058", var_248_12)
						arg_245_1:RecordAudio("416042058", var_248_12)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_416042", "416042058", "story_v_out_416042.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_416042", "416042058", "story_v_out_416042.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = var_248_4 + 0.3
			local var_248_14 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_13 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_13) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_13 + var_248_14 and arg_245_1.time_ < var_248_13 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play416042059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416042059
		arg_251_1.duration_ = 8.67

		local var_251_0 = {
			zh = 8.666,
			ja = 8.366
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
				arg_251_0:Play416042060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 2 < arg_251_1.time_ and arg_251_1.time_ <= 2 + arg_254_0 then
				local var_254_0 = arg_251_1.bgs_.I14f

				arg_251_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_1 = var_254_0:GetComponent("SpriteRenderer")

				if var_254_1 and var_254_1.sprite then
					local var_254_2 = 2 * (var_254_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_0.transform.localScale = Vector3.New(var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "I14f" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_3 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_4 = 2

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_4 then
				local var_254_5 = Color.New(0, 0, 0)

				var_254_5.a = Mathf.Lerp(0, 1, (arg_251_1.time_ - var_254_3) / var_254_4)
				arg_251_1.mask_.color = var_254_5
			end

			if arg_251_1.time_ >= var_254_3 + var_254_4 and arg_251_1.time_ < var_254_3 + var_254_4 + arg_254_0 then
				local var_254_6 = Color.New(0, 0, 0)

				var_254_6.a = 1
				arg_251_1.mask_.color = var_254_6
			end

			local var_254_7 = 2

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_8 = 2

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_8 then
				local var_254_9 = Color.New(0, 0, 0)

				var_254_9.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_7) / var_254_8)
				arg_251_1.mask_.color = var_254_9
			end

			if arg_251_1.time_ >= var_254_7 + var_254_8 and arg_251_1.time_ < var_254_7 + var_254_8 + arg_254_0 then
				local var_254_10 = Color.New(0, 0, 0)

				arg_251_1.mask_.enabled = false
				var_254_10.a = 0
				arg_251_1.mask_.color = var_254_10
			end

			local var_254_11 = "1028"

			if arg_251_1.actors_["1028"] == nil then
				local var_254_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_254_12) then
					local var_254_13 = Object.Instantiate(var_254_12, arg_251_1.canvasGo_.transform)

					var_254_13.transform:SetSiblingIndex(1)

					var_254_13.name = var_254_11
					var_254_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_251_1.actors_[var_254_11] = var_254_13

					if arg_251_1.isInRecall_ then
						for iter_254_2, iter_254_3 in ipairs((var_254_13:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_254_14 = arg_251_1.actors_["1028"]

			if 3.46733333333333 < arg_251_1.time_ and arg_251_1.time_ <= 3.46733333333333 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.actorSpriteComps1028 == nil then
				arg_251_1.var_.actorSpriteComps1028 = var_254_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_15 = 0.125

			if 3.46733333333333 <= arg_251_1.time_ and arg_251_1.time_ < 3.46733333333333 + var_254_15 and not isNil(var_254_14) then
				if arg_251_1.var_.actorSpriteComps1028 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								iter_254_5.color = Color.New(Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 3.46733333333333) / var_254_15), Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 3.46733333333333) / var_254_15), (Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 3.46733333333333) / var_254_15)))
							else
								local var_254_16 = Mathf.Lerp(iter_254_5.color.r, 1, (arg_251_1.time_ - 3.46733333333333) / var_254_15)

								iter_254_5.color = Color.New(var_254_16, var_254_16, var_254_16)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 3.46733333333333 + var_254_15 and arg_251_1.time_ < 3.46733333333333 + var_254_15 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.actorSpriteComps1028 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_254_7 then
						iter_254_7.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1028 = nil
			end

			local var_254_17 = arg_251_1.actors_["1028"].transform

			if 3.46733333333333 < arg_251_1.time_ and arg_251_1.time_ <= 3.46733333333333 + arg_254_0 then
				arg_251_1.var_.moveOldPos1028 = var_254_17.localPosition
				var_254_17.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1028", 3)

				for iter_254_8 = 0, var_254_17.childCount - 1 do
					local var_254_18 = var_254_17:GetChild(iter_254_8)

					if var_254_18.name == "split_2" or not string.find(var_254_18.name, "split") then
						var_254_18.gameObject:SetActive(true)
					else
						var_254_18.gameObject:SetActive(false)
					end
				end
			end

			local var_254_19 = 0.001

			if 3.46733333333333 <= arg_251_1.time_ and arg_251_1.time_ < 3.46733333333333 + var_254_19 then
				var_254_17.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_251_1.time_ - 3.46733333333333) / var_254_19)
			end

			if arg_251_1.time_ >= 3.46733333333333 + var_254_19 and arg_251_1.time_ < 3.46733333333333 + var_254_19 + arg_254_0 then
				var_254_17.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			if 3.46733333333333 < arg_251_1.time_ and arg_251_1.time_ <= 3.46733333333333 + arg_254_0 then
				local var_254_20 = arg_251_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_20 then
					arg_251_1.var_.alphaOldValue1028 = var_254_20.alpha
					arg_251_1.var_.characterEffect1028 = var_254_20
				end

				arg_251_1.var_.alphaOldValue1028 = 0
			end

			local var_254_21 = 0.857666666666667

			if 3.46733333333333 <= arg_251_1.time_ and arg_251_1.time_ < 3.46733333333333 + var_254_21 then
				if arg_251_1.var_.characterEffect1028 then
					arg_251_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_251_1.var_.alphaOldValue1028, 1, (arg_251_1.time_ - 3.46733333333333) / var_254_21)
				end
			end

			if arg_251_1.time_ >= 3.46733333333333 + var_254_21 and arg_251_1.time_ < 3.46733333333333 + var_254_21 + arg_254_0 and arg_251_1.var_.characterEffect1028 then
				arg_251_1.var_.characterEffect1028.alpha = 1
			end

			if 1.83333333333333 < arg_251_1.time_ and arg_251_1.time_ <= 1.83333333333333 + arg_254_0 then
				if arg_251_1.var_.effect3330402 then
					Object.Destroy(arg_251_1.var_.effect3330402)

					arg_251_1.var_.effect3330402 = nil
				end
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_254_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_251_1.bgmTxt_.text ~= var_254_25 and arg_251_1.bgmTxt_.text ~= "" then
						if arg_251_1.bgmTxt2_.text ~= "" then
							arg_251_1.bgmTxt_.text = arg_251_1.bgmTxt2_.text
						end

						arg_251_1.bgmTxt2_.text = var_254_25

						arg_251_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_251_1.bgmTxt_.text = var_254_25
						arg_251_1.bgmTxt2_.text = var_254_25
					end

					if arg_251_1.bgmTimer then
						arg_251_1.bgmTimer:Stop()

						arg_251_1.bgmTimer = nil
					end

					if arg_251_1.settingData.show_music_name == 1 then
						arg_251_1.musicController:SetSelectedState("show")
						arg_251_1.musicAnimator_:Play("open", 0, 0)

						if arg_251_1.settingData.music_time ~= 0 then
							arg_251_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_251_1.settingData.music_time), function()
								if arg_251_1 == nil or isNil(arg_251_1.bgmTxt_) then
									return
								end

								arg_251_1.musicController:SetSelectedState("hide")
								arg_251_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_26 = 4
			local var_254_27 = 0.325

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= var_254_26 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_28 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_28:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_251_1.dialogCg_.alpha = arg_256_0
				end))
				var_254_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_29 = arg_251_1:GetWordFromCfg(416042059)
				local var_254_30 = arg_251_1:FormatText(var_254_29.content)

				arg_251_1.text_.text = var_254_30

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_32 = 13 <= 0 and var_254_27 or var_254_27 * (utf8.len(var_254_30) / 13)

				if (13 <= 0 and var_254_27 or var_254_27 * (utf8.len(var_254_30) / 13)) > 0 and var_254_27 < var_254_32 then
					arg_251_1.talkMaxDuration = var_254_32
					var_254_26 = var_254_26 + 0.3

					if var_254_32 + var_254_26 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_32 + var_254_26
					end
				end

				arg_251_1.text_.text = var_254_30
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042059", "story_v_out_416042.awb") ~= 0 then
					local var_254_33 = manager.audio:GetVoiceLength("story_v_out_416042", "416042059", "story_v_out_416042.awb") / 1000

					if var_254_33 + var_254_26 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_33 + var_254_26
					end

					if var_254_29.prefab_name ~= "" and arg_251_1.actors_[var_254_29.prefab_name] ~= nil then
						local var_254_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_29.prefab_name].transform, "story_v_out_416042", "416042059", "story_v_out_416042.awb")

						arg_251_1:RecordAudio("416042059", var_254_34)
						arg_251_1:RecordAudio("416042059", var_254_34)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416042", "416042059", "story_v_out_416042.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416042", "416042059", "story_v_out_416042.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_35 = var_254_26 + 0.3
			local var_254_36 = math.max(var_254_27, arg_251_1.talkMaxDuration)

			if var_254_26 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_35 + var_254_36 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_35) / var_254_36

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_35 + var_254_36 and arg_251_1.time_ < var_254_35 + var_254_36 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.46733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play416042060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 416042060
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play416042061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1028 = arg_258_1.actors_["1028"].transform.localPosition
				arg_258_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1028", 7)

				for iter_261_0 = 0, arg_258_1.actors_["1028"].transform.childCount - 1 do
					local var_261_0 = arg_258_1.actors_["1028"].transform:GetChild(iter_261_0)

					if var_261_0.name == "" or not string.find(var_261_0.name, "split") then
						var_261_0.gameObject:SetActive(true)
					else
						var_261_0.gameObject:SetActive(false)
					end
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_258_1.time_ - 0) / var_261_1)
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_2 = 0
			local var_261_3 = 1.925

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_4 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(416042060).content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_6 = 77 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_4) / 77)

				if (77 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_4) / 77)) > 0 and var_261_3 < var_261_6 then
					arg_258_1.talkMaxDuration = var_261_6

					if var_261_6 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_6 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_7 and arg_258_1.time_ < var_261_2 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play416042061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 416042061
		arg_262_1.duration_ = 6.17

		local var_262_0 = {
			zh = 4.2,
			ja = 6.166
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play416042062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1028 = arg_262_1.actors_["1028"].transform.localPosition
				arg_262_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1028", 3)

				for iter_265_0 = 0, arg_262_1.actors_["1028"].transform.childCount - 1 do
					local var_265_0 = arg_262_1.actors_["1028"].transform:GetChild(iter_265_0)

					if var_265_0.name == "split_2" or not string.find(var_265_0.name, "split") then
						var_265_0.gameObject:SetActive(true)
					else
						var_265_0.gameObject:SetActive(false)
					end
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_262_1.time_ - 0) / var_265_1)
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["1028"].transform.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_265_2 = arg_262_1.actors_["1028"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps1028 == nil then
				arg_262_1.var_.actorSpriteComps1028 = var_265_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_3 = 0.125

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.actorSpriteComps1028 then
					for iter_265_1, iter_265_2 in pairs(arg_262_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_265_2 then
							if arg_262_1.isInRecall_ then
								iter_265_2.color = Color.New(Mathf.Lerp(iter_265_2.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_3), Mathf.Lerp(iter_265_2.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_3), (Mathf.Lerp(iter_265_2.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_3)))
							else
								local var_265_4 = Mathf.Lerp(iter_265_2.color.r, 1, (arg_262_1.time_ - 0) / var_265_3)

								iter_265_2.color = Color.New(var_265_4, var_265_4, var_265_4)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps1028 then
				for iter_265_3, iter_265_4 in pairs(arg_262_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_265_4 then
						iter_265_4.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps1028 = nil
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_265_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_7 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_7

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_7
						arg_262_1.bgmTxt2_.text = var_265_7
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_262_1.time_ and arg_262_1.time_ <= 0.466666666666667 + arg_265_0 then
				arg_262_1:AudioAction("play", "music", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_265_10 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if "" ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_10 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_10

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_10
						arg_262_1.bgmTxt2_.text = var_265_10
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_11 = 0
			local var_265_12 = 0.525

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_11 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:GetWordFromCfg(416042061)
				local var_265_14 = arg_262_1:FormatText(var_265_13.content)

				arg_262_1.text_.text = var_265_14

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_16 = 21 <= 0 and var_265_12 or var_265_12 * (utf8.len(var_265_14) / 21)

				if (21 <= 0 and var_265_12 or var_265_12 * (utf8.len(var_265_14) / 21)) > 0 and var_265_12 < var_265_16 then
					arg_262_1.talkMaxDuration = var_265_16

					if var_265_16 + var_265_11 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_16 + var_265_11
					end
				end

				arg_262_1.text_.text = var_265_14
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042061", "story_v_out_416042.awb") ~= 0 then
					local var_265_17 = manager.audio:GetVoiceLength("story_v_out_416042", "416042061", "story_v_out_416042.awb") / 1000

					if var_265_17 + var_265_11 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_11
					end

					if var_265_13.prefab_name ~= "" and arg_262_1.actors_[var_265_13.prefab_name] ~= nil then
						local var_265_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_13.prefab_name].transform, "story_v_out_416042", "416042061", "story_v_out_416042.awb")

						arg_262_1:RecordAudio("416042061", var_265_18)
						arg_262_1:RecordAudio("416042061", var_265_18)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_416042", "416042061", "story_v_out_416042.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_416042", "416042061", "story_v_out_416042.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_19 = math.max(var_265_12, arg_262_1.talkMaxDuration)

			if var_265_11 <= arg_262_1.time_ and arg_262_1.time_ < var_265_11 + var_265_19 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_11) / var_265_19

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_11 + var_265_19 and arg_262_1.time_ < var_265_11 + var_265_19 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play416042062 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 416042062
		arg_268_1.duration_ = 4.7

		local var_268_0 = {
			zh = 4.066,
			ja = 4.7
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play416042063(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1028 = arg_268_1.actors_["1028"].transform.localPosition
				arg_268_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("1028", 2)

				for iter_271_0 = 0, arg_268_1.actors_["1028"].transform.childCount - 1 do
					local var_271_0 = arg_268_1.actors_["1028"].transform:GetChild(iter_271_0)

					if var_271_0.name == "" or not string.find(var_271_0.name, "split") then
						var_271_0.gameObject:SetActive(true)
					else
						var_271_0.gameObject:SetActive(false)
					end
				end
			end

			local var_271_1 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_1 then
				arg_268_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_268_1.time_ - 0) / var_271_1)
			end

			if arg_268_1.time_ >= 0 + var_271_1 and arg_268_1.time_ < 0 + var_271_1 + arg_271_0 then
				arg_268_1.actors_["1028"].transform.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_271_2 = arg_268_1.actors_["1028"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps1028 == nil then
				arg_268_1.var_.actorSpriteComps1028 = var_271_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_3 = 0.125

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 and not isNil(var_271_2) then
				if arg_268_1.var_.actorSpriteComps1028 then
					for iter_271_1, iter_271_2 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_271_2 then
							if arg_268_1.isInRecall_ then
								iter_271_2.color = Color.New(Mathf.Lerp(iter_271_2.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_3), Mathf.Lerp(iter_271_2.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_3), (Mathf.Lerp(iter_271_2.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_3)))
							else
								local var_271_4 = Mathf.Lerp(iter_271_2.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_3)

								iter_271_2.color = Color.New(var_271_4, var_271_4, var_271_4)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps1028 then
				for iter_271_3, iter_271_4 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_271_4 then
						iter_271_4.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps1028 = nil
			end

			local var_271_5 = "10108"

			if arg_268_1.actors_["10108"] == nil then
				local var_271_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_271_6) then
					local var_271_7 = Object.Instantiate(var_271_6, arg_268_1.canvasGo_.transform)

					var_271_7.transform:SetSiblingIndex(1)

					var_271_7.name = var_271_5
					var_271_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_268_1.actors_[var_271_5] = var_271_7

					if arg_268_1.isInRecall_ then
						for iter_271_5, iter_271_6 in ipairs((var_271_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_271_6.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_271_8 = arg_268_1.actors_["10108"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10108 = var_271_8.localPosition
				var_271_8.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10108", 4)

				for iter_271_7 = 0, var_271_8.childCount - 1 do
					local var_271_9 = var_271_8:GetChild(iter_271_7)

					if var_271_9.name == "" or not string.find(var_271_9.name, "split") then
						var_271_9.gameObject:SetActive(true)
					else
						var_271_9.gameObject:SetActive(false)
					end
				end
			end

			local var_271_10 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_10 then
				var_271_8.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_268_1.time_ - 0) / var_271_10)
			end

			if arg_268_1.time_ >= 0 + var_271_10 and arg_268_1.time_ < 0 + var_271_10 + arg_271_0 then
				var_271_8.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_271_11 = arg_268_1.actors_["10108"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_11) and arg_268_1.var_.actorSpriteComps10108 == nil then
				arg_268_1.var_.actorSpriteComps10108 = var_271_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_12 = 0.125

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_12 and not isNil(var_271_11) then
				if arg_268_1.var_.actorSpriteComps10108 then
					for iter_271_8, iter_271_9 in pairs(arg_268_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_271_9 then
							if arg_268_1.isInRecall_ then
								iter_271_9.color = Color.New(Mathf.Lerp(iter_271_9.color.r, arg_268_1.hightColor1.r, (arg_268_1.time_ - 0) / var_271_12), Mathf.Lerp(iter_271_9.color.g, arg_268_1.hightColor1.g, (arg_268_1.time_ - 0) / var_271_12), (Mathf.Lerp(iter_271_9.color.b, arg_268_1.hightColor1.b, (arg_268_1.time_ - 0) / var_271_12)))
							else
								local var_271_13 = Mathf.Lerp(iter_271_9.color.r, 1, (arg_268_1.time_ - 0) / var_271_12)

								iter_271_9.color = Color.New(var_271_13, var_271_13, var_271_13)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_12 and arg_268_1.time_ < 0 + var_271_12 + arg_271_0 and not isNil(var_271_11) and arg_268_1.var_.actorSpriteComps10108 then
				for iter_271_10, iter_271_11 in pairs(arg_268_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_271_11 then
						iter_271_11.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_268_1.var_.actorSpriteComps10108 = nil
			end

			local var_271_14 = 0
			local var_271_15 = 0.325

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_16 = arg_268_1:GetWordFromCfg(416042062)
				local var_271_17 = arg_268_1:FormatText(var_271_16.content)

				arg_268_1.text_.text = var_271_17

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_19 = 13 <= 0 and var_271_15 or var_271_15 * (utf8.len(var_271_17) / 13)

				if (13 <= 0 and var_271_15 or var_271_15 * (utf8.len(var_271_17) / 13)) > 0 and var_271_15 < var_271_19 then
					arg_268_1.talkMaxDuration = var_271_19

					if var_271_19 + var_271_14 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_19 + var_271_14
					end
				end

				arg_268_1.text_.text = var_271_17
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042062", "story_v_out_416042.awb") ~= 0 then
					local var_271_20 = manager.audio:GetVoiceLength("story_v_out_416042", "416042062", "story_v_out_416042.awb") / 1000

					if var_271_20 + var_271_14 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_20 + var_271_14
					end

					if var_271_16.prefab_name ~= "" and arg_268_1.actors_[var_271_16.prefab_name] ~= nil then
						local var_271_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_16.prefab_name].transform, "story_v_out_416042", "416042062", "story_v_out_416042.awb")

						arg_268_1:RecordAudio("416042062", var_271_21)
						arg_268_1:RecordAudio("416042062", var_271_21)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_416042", "416042062", "story_v_out_416042.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_416042", "416042062", "story_v_out_416042.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_22 = math.max(var_271_15, arg_268_1.talkMaxDuration)

			if var_271_14 <= arg_268_1.time_ and arg_268_1.time_ < var_271_14 + var_271_22 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_14) / var_271_22

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_14 + var_271_22 and arg_268_1.time_ < var_271_14 + var_271_22 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play416042063 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 416042063
		arg_272_1.duration_ = 7.93

		local var_272_0 = {
			zh = 3.933,
			ja = 7.933
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
				arg_272_0:Play416042064(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.425

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:GetWordFromCfg(416042063)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 17 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 17)

				if (17 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 17)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042063", "story_v_out_416042.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042063", "story_v_out_416042.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_416042", "416042063", "story_v_out_416042.awb")

						arg_272_1:RecordAudio("416042063", var_275_6)
						arg_272_1:RecordAudio("416042063", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_416042", "416042063", "story_v_out_416042.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_416042", "416042063", "story_v_out_416042.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play416042064 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 416042064
		arg_276_1.duration_ = 7.1

		local var_276_0 = {
			zh = 7.1,
			ja = 6.866
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play416042065(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["10108"]) and arg_276_1.var_.actorSpriteComps10108 == nil then
				arg_276_1.var_.actorSpriteComps10108 = arg_276_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_0 = 0.125

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["10108"]) then
				if arg_276_1.var_.actorSpriteComps10108 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								iter_279_1.color = Color.New(Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_0), Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_0), (Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_0)))
							else
								local var_279_1 = Mathf.Lerp(iter_279_1.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_0)

								iter_279_1.color = Color.New(var_279_1, var_279_1, var_279_1)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["10108"]) and arg_276_1.var_.actorSpriteComps10108 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_279_3 then
						iter_279_3.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps10108 = nil
			end

			local var_279_2 = arg_276_1.actors_["1028"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps1028 == nil then
				arg_276_1.var_.actorSpriteComps1028 = var_279_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_3 = 0.125

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_3 and not isNil(var_279_2) then
				if arg_276_1.var_.actorSpriteComps1028 then
					for iter_279_4, iter_279_5 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_279_5 then
							if arg_276_1.isInRecall_ then
								iter_279_5.color = Color.New(Mathf.Lerp(iter_279_5.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_3), Mathf.Lerp(iter_279_5.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_3), (Mathf.Lerp(iter_279_5.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_3)))
							else
								local var_279_4 = Mathf.Lerp(iter_279_5.color.r, 1, (arg_276_1.time_ - 0) / var_279_3)

								iter_279_5.color = Color.New(var_279_4, var_279_4, var_279_4)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_3 and arg_276_1.time_ < 0 + var_279_3 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps1028 then
				for iter_279_6, iter_279_7 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_279_7 then
						iter_279_7.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps1028 = nil
			end

			local var_279_5 = 0
			local var_279_6 = 0.525

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_7 = arg_276_1:GetWordFromCfg(416042064)
				local var_279_8 = arg_276_1:FormatText(var_279_7.content)

				arg_276_1.text_.text = var_279_8

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 21 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 21)

				if (21 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 21)) > 0 and var_279_6 < var_279_10 then
					arg_276_1.talkMaxDuration = var_279_10

					if var_279_10 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_8
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042064", "story_v_out_416042.awb") ~= 0 then
					local var_279_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042064", "story_v_out_416042.awb") / 1000

					if var_279_11 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_11 + var_279_5
					end

					if var_279_7.prefab_name ~= "" and arg_276_1.actors_[var_279_7.prefab_name] ~= nil then
						local var_279_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_7.prefab_name].transform, "story_v_out_416042", "416042064", "story_v_out_416042.awb")

						arg_276_1:RecordAudio("416042064", var_279_12)
						arg_276_1:RecordAudio("416042064", var_279_12)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_416042", "416042064", "story_v_out_416042.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_416042", "416042064", "story_v_out_416042.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_13 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_13

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_13 and arg_276_1.time_ < var_279_5 + var_279_13 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play416042065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 416042065
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play416042066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1028 = arg_280_1.actors_["1028"].transform.localPosition
				arg_280_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("1028", 7)

				for iter_283_0 = 0, arg_280_1.actors_["1028"].transform.childCount - 1 do
					local var_283_0 = arg_280_1.actors_["1028"].transform:GetChild(iter_283_0)

					if var_283_0.name == "" or not string.find(var_283_0.name, "split") then
						var_283_0.gameObject:SetActive(true)
					else
						var_283_0.gameObject:SetActive(false)
					end
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_280_1.time_ - 0) / var_283_1)
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_283_2 = arg_280_1.actors_["10108"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10108 = var_283_2.localPosition
				var_283_2.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10108", 7)

				for iter_283_1 = 0, var_283_2.childCount - 1 do
					local var_283_3 = var_283_2:GetChild(iter_283_1)

					if var_283_3.name == "" or not string.find(var_283_3.name, "split") then
						var_283_3.gameObject:SetActive(true)
					else
						var_283_3.gameObject:SetActive(false)
					end
				end
			end

			local var_283_4 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				var_283_2.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_280_1.time_ - 0) / var_283_4)
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				var_283_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_283_5 = 0
			local var_283_6 = 1.85

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_7 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(416042065).content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 74 <= 0 and var_283_6 or var_283_6 * (utf8.len(var_283_7) / 74)

				if (74 <= 0 and var_283_6 or var_283_6 * (utf8.len(var_283_7) / 74)) > 0 and var_283_6 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_5 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_5
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_6, arg_280_1.talkMaxDuration)

			if var_283_5 <= arg_280_1.time_ and arg_280_1.time_ < var_283_5 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_5) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_5 + var_283_10 and arg_280_1.time_ < var_283_5 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play416042066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 416042066
		arg_284_1.duration_ = 11.63

		local var_284_0 = {
			zh = 6.1,
			ja = 11.633
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play416042067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if arg_284_1.actors_["1086"] == nil then
				local var_287_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_287_0) then
					local var_287_1 = Object.Instantiate(var_287_0, arg_284_1.canvasGo_.transform)

					var_287_1.transform:SetSiblingIndex(1)

					var_287_1.name = "1086"
					var_287_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_284_1.actors_["1086"] = var_287_1

					if arg_284_1.isInRecall_ then
						for iter_287_0, iter_287_1 in ipairs((var_287_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_287_1.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_287_2 = arg_284_1.actors_["1086"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1086 = var_287_2.localPosition
				var_287_2.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1086", 3)

				for iter_287_2 = 0, var_287_2.childCount - 1 do
					local var_287_3 = var_287_2:GetChild(iter_287_2)

					if var_287_3.name == "split_1" or not string.find(var_287_3.name, "split") then
						var_287_3.gameObject:SetActive(true)
					else
						var_287_3.gameObject:SetActive(false)
					end
				end
			end

			local var_287_4 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				var_287_2.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_284_1.time_ - 0) / var_287_4)
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				var_287_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_287_5 = arg_284_1.actors_["1086"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_5) and arg_284_1.var_.actorSpriteComps1086 == nil then
				arg_284_1.var_.actorSpriteComps1086 = var_287_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_6 = 0.125

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_6 and not isNil(var_287_5) then
				if arg_284_1.var_.actorSpriteComps1086 then
					for iter_287_3, iter_287_4 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_287_4 then
							if arg_284_1.isInRecall_ then
								iter_287_4.color = Color.New(Mathf.Lerp(iter_287_4.color.r, arg_284_1.hightColor1.r, (arg_284_1.time_ - 0) / var_287_6), Mathf.Lerp(iter_287_4.color.g, arg_284_1.hightColor1.g, (arg_284_1.time_ - 0) / var_287_6), (Mathf.Lerp(iter_287_4.color.b, arg_284_1.hightColor1.b, (arg_284_1.time_ - 0) / var_287_6)))
							else
								local var_287_7 = Mathf.Lerp(iter_287_4.color.r, 1, (arg_284_1.time_ - 0) / var_287_6)

								iter_287_4.color = Color.New(var_287_7, var_287_7, var_287_7)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_6 and arg_284_1.time_ < 0 + var_287_6 + arg_287_0 and not isNil(var_287_5) and arg_284_1.var_.actorSpriteComps1086 then
				for iter_287_5, iter_287_6 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_287_6 then
						iter_287_6.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_284_1.var_.actorSpriteComps1086 = nil
			end

			local var_287_8 = 0
			local var_287_9 = 0.525

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_10 = arg_284_1:GetWordFromCfg(416042066)
				local var_287_11 = arg_284_1:FormatText(var_287_10.content)

				arg_284_1.text_.text = var_287_11

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_13 = 21 <= 0 and var_287_9 or var_287_9 * (utf8.len(var_287_11) / 21)

				if (21 <= 0 and var_287_9 or var_287_9 * (utf8.len(var_287_11) / 21)) > 0 and var_287_9 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_8
					end
				end

				arg_284_1.text_.text = var_287_11
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042066", "story_v_out_416042.awb") ~= 0 then
					local var_287_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042066", "story_v_out_416042.awb") / 1000

					if var_287_14 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_8
					end

					if var_287_10.prefab_name ~= "" and arg_284_1.actors_[var_287_10.prefab_name] ~= nil then
						local var_287_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_10.prefab_name].transform, "story_v_out_416042", "416042066", "story_v_out_416042.awb")

						arg_284_1:RecordAudio("416042066", var_287_15)
						arg_284_1:RecordAudio("416042066", var_287_15)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_416042", "416042066", "story_v_out_416042.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_416042", "416042066", "story_v_out_416042.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_9, arg_284_1.talkMaxDuration)

			if var_287_8 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_8) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_8 + var_287_16 and arg_284_1.time_ < var_287_8 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play416042067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 416042067
		arg_288_1.duration_ = 4.6

		local var_288_0 = {
			zh = 2.566,
			ja = 4.6
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
				arg_288_0:Play416042068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1086"]) and arg_288_1.var_.actorSpriteComps1086 == nil then
				arg_288_1.var_.actorSpriteComps1086 = arg_288_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_0 = 0.125

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1086"]) then
				if arg_288_1.var_.actorSpriteComps1086 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								iter_291_1.color = Color.New(Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor2.r, (arg_288_1.time_ - 0) / var_291_0), Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor2.g, (arg_288_1.time_ - 0) / var_291_0), (Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor2.b, (arg_288_1.time_ - 0) / var_291_0)))
							else
								local var_291_1 = Mathf.Lerp(iter_291_1.color.r, 0.5, (arg_288_1.time_ - 0) / var_291_0)

								iter_291_1.color = Color.New(var_291_1, var_291_1, var_291_1)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1086"]) and arg_288_1.var_.actorSpriteComps1086 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_291_3 then
						iter_291_3.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_288_1.var_.actorSpriteComps1086 = nil
			end

			local var_291_2 = 0
			local var_291_3 = 0.325

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1081].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10121")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_4 = arg_288_1:GetWordFromCfg(416042067)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 13 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 13)

				if (13 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 13)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042067", "story_v_out_416042.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042067", "story_v_out_416042.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_out_416042", "416042067", "story_v_out_416042.awb")

						arg_288_1:RecordAudio("416042067", var_291_9)
						arg_288_1:RecordAudio("416042067", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_416042", "416042067", "story_v_out_416042.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_416042", "416042067", "story_v_out_416042.awb")
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
	Play416042068 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 416042068
		arg_292_1.duration_ = 5.23

		local var_292_0 = {
			zh = 3.033,
			ja = 5.233
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
				arg_292_0:Play416042069(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1086"]) and arg_292_1.var_.actorSpriteComps1086 == nil then
				arg_292_1.var_.actorSpriteComps1086 = arg_292_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_0 = 0.125

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1086"]) then
				if arg_292_1.var_.actorSpriteComps1086 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								iter_295_1.color = Color.New(Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_0), Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_0), (Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_0)))
							else
								local var_295_1 = Mathf.Lerp(iter_295_1.color.r, 1, (arg_292_1.time_ - 0) / var_295_0)

								iter_295_1.color = Color.New(var_295_1, var_295_1, var_295_1)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1086"]) and arg_292_1.var_.actorSpriteComps1086 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_295_3 then
						iter_295_3.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps1086 = nil
			end

			local var_295_2 = 0
			local var_295_3 = 0.375

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_4 = arg_292_1:GetWordFromCfg(416042068)
				local var_295_5 = arg_292_1:FormatText(var_295_4.content)

				arg_292_1.text_.text = var_295_5

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_7 = 15 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_5) / 15)

				if (15 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_5) / 15)) > 0 and var_295_3 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_2
					end
				end

				arg_292_1.text_.text = var_295_5
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042068", "story_v_out_416042.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_416042", "416042068", "story_v_out_416042.awb") / 1000

					if var_295_8 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_2
					end

					if var_295_4.prefab_name ~= "" and arg_292_1.actors_[var_295_4.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_4.prefab_name].transform, "story_v_out_416042", "416042068", "story_v_out_416042.awb")

						arg_292_1:RecordAudio("416042068", var_295_9)
						arg_292_1:RecordAudio("416042068", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_416042", "416042068", "story_v_out_416042.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_416042", "416042068", "story_v_out_416042.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_3, arg_292_1.talkMaxDuration)

			if var_295_2 <= arg_292_1.time_ and arg_292_1.time_ < var_295_2 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_2) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_2 + var_295_10 and arg_292_1.time_ < var_295_2 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play416042069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 416042069
		arg_296_1.duration_ = 7.27

		local var_296_0 = {
			zh = 5.533,
			ja = 7.266
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play416042070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.675

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_1 = arg_296_1:GetWordFromCfg(416042069)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 27 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 27)

				if (27 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 27)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042069", "story_v_out_416042.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042069", "story_v_out_416042.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_416042", "416042069", "story_v_out_416042.awb")

						arg_296_1:RecordAudio("416042069", var_299_6)
						arg_296_1:RecordAudio("416042069", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_416042", "416042069", "story_v_out_416042.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_416042", "416042069", "story_v_out_416042.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play416042070 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 416042070
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play416042071(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1086 = arg_300_1.actors_["1086"].transform.localPosition
				arg_300_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("1086", 7)

				for iter_303_0 = 0, arg_300_1.actors_["1086"].transform.childCount - 1 do
					local var_303_0 = arg_300_1.actors_["1086"].transform:GetChild(iter_303_0)

					if var_303_0.name == "" or not string.find(var_303_0.name, "split") then
						var_303_0.gameObject:SetActive(true)
					else
						var_303_0.gameObject:SetActive(false)
					end
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_300_1.time_ - 0) / var_303_1)
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_303_2 = 0
			local var_303_3 = 1.475

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_2 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_4 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(416042070).content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 59 <= 0 and var_303_3 or var_303_3 * (utf8.len(var_303_4) / 59)

				if (59 <= 0 and var_303_3 or var_303_3 * (utf8.len(var_303_4) / 59)) > 0 and var_303_3 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_2
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_3, arg_300_1.talkMaxDuration)

			if var_303_2 <= arg_300_1.time_ and arg_300_1.time_ < var_303_2 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_2) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_2 + var_303_7 and arg_300_1.time_ < var_303_2 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play416042071 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 416042071
		arg_304_1.duration_ = 5.53

		local var_304_0 = {
			zh = 3.466,
			ja = 5.533
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
				arg_304_0:Play416042072(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1086 = arg_304_1.actors_["1086"].transform.localPosition
				arg_304_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("1086", 3)

				for iter_307_0 = 0, arg_304_1.actors_["1086"].transform.childCount - 1 do
					local var_307_0 = arg_304_1.actors_["1086"].transform:GetChild(iter_307_0)

					if var_307_0.name == "split_2" or not string.find(var_307_0.name, "split") then
						var_307_0.gameObject:SetActive(true)
					else
						var_307_0.gameObject:SetActive(false)
					end
				end
			end

			local var_307_1 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_1 then
				arg_304_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_304_1.time_ - 0) / var_307_1)
			end

			if arg_304_1.time_ >= 0 + var_307_1 and arg_304_1.time_ < 0 + var_307_1 + arg_307_0 then
				arg_304_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_307_2 = arg_304_1.actors_["1086"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps1086 == nil then
				arg_304_1.var_.actorSpriteComps1086 = var_307_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_3 = 0.125

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_3 and not isNil(var_307_2) then
				if arg_304_1.var_.actorSpriteComps1086 then
					for iter_307_1, iter_307_2 in pairs(arg_304_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_307_2 then
							if arg_304_1.isInRecall_ then
								iter_307_2.color = Color.New(Mathf.Lerp(iter_307_2.color.r, arg_304_1.hightColor1.r, (arg_304_1.time_ - 0) / var_307_3), Mathf.Lerp(iter_307_2.color.g, arg_304_1.hightColor1.g, (arg_304_1.time_ - 0) / var_307_3), (Mathf.Lerp(iter_307_2.color.b, arg_304_1.hightColor1.b, (arg_304_1.time_ - 0) / var_307_3)))
							else
								local var_307_4 = Mathf.Lerp(iter_307_2.color.r, 1, (arg_304_1.time_ - 0) / var_307_3)

								iter_307_2.color = Color.New(var_307_4, var_307_4, var_307_4)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_3 and arg_304_1.time_ < 0 + var_307_3 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps1086 then
				for iter_307_3, iter_307_4 in pairs(arg_304_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_307_4 then
						iter_307_4.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_304_1.var_.actorSpriteComps1086 = nil
			end

			local var_307_5 = 0
			local var_307_6 = 0.4

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_7 = arg_304_1:GetWordFromCfg(416042071)
				local var_307_8 = arg_304_1:FormatText(var_307_7.content)

				arg_304_1.text_.text = var_307_8

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_10 = 16 <= 0 and var_307_6 or var_307_6 * (utf8.len(var_307_8) / 16)

				if (16 <= 0 and var_307_6 or var_307_6 * (utf8.len(var_307_8) / 16)) > 0 and var_307_6 < var_307_10 then
					arg_304_1.talkMaxDuration = var_307_10

					if var_307_10 + var_307_5 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_5
					end
				end

				arg_304_1.text_.text = var_307_8
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042071", "story_v_out_416042.awb") ~= 0 then
					local var_307_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042071", "story_v_out_416042.awb") / 1000

					if var_307_11 + var_307_5 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_11 + var_307_5
					end

					if var_307_7.prefab_name ~= "" and arg_304_1.actors_[var_307_7.prefab_name] ~= nil then
						local var_307_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_7.prefab_name].transform, "story_v_out_416042", "416042071", "story_v_out_416042.awb")

						arg_304_1:RecordAudio("416042071", var_307_12)
						arg_304_1:RecordAudio("416042071", var_307_12)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_416042", "416042071", "story_v_out_416042.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_416042", "416042071", "story_v_out_416042.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_13 = math.max(var_307_6, arg_304_1.talkMaxDuration)

			if var_307_5 <= arg_304_1.time_ and arg_304_1.time_ < var_307_5 + var_307_13 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_5) / var_307_13

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_5 + var_307_13 and arg_304_1.time_ < var_307_5 + var_307_13 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play416042072 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 416042072
		arg_308_1.duration_ = 6.93

		local var_308_0 = {
			zh = 5.466,
			ja = 6.933
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play416042073(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1086 = arg_308_1.actors_["1086"].transform.localPosition
				arg_308_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				for iter_311_0 = 0, arg_308_1.actors_["1086"].transform.childCount - 1 do
					local var_311_0 = arg_308_1.actors_["1086"].transform:GetChild(iter_311_0)

					if var_311_0.name == "split_2" or not string.find(var_311_0.name, "split") then
						var_311_0.gameObject:SetActive(true)
					else
						var_311_0.gameObject:SetActive(false)
					end
				end
			end

			local var_311_1 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_1 then
				arg_308_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1086, Vector3.New(-390, -398.8, -250.2), (arg_308_1.time_ - 0) / var_311_1)
			end

			if arg_308_1.time_ >= 0 + var_311_1 and arg_308_1.time_ < 0 + var_311_1 + arg_311_0 then
				arg_308_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -398.8, -250.2)
			end

			local var_311_2 = arg_308_1.actors_["1086"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.actorSpriteComps1086 == nil then
				arg_308_1.var_.actorSpriteComps1086 = var_311_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_3 = 0.125

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_3 and not isNil(var_311_2) then
				if arg_308_1.var_.actorSpriteComps1086 then
					for iter_311_1, iter_311_2 in pairs(arg_308_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_311_2 then
							if arg_308_1.isInRecall_ then
								iter_311_2.color = Color.New(Mathf.Lerp(iter_311_2.color.r, arg_308_1.hightColor2.r, (arg_308_1.time_ - 0) / var_311_3), Mathf.Lerp(iter_311_2.color.g, arg_308_1.hightColor2.g, (arg_308_1.time_ - 0) / var_311_3), (Mathf.Lerp(iter_311_2.color.b, arg_308_1.hightColor2.b, (arg_308_1.time_ - 0) / var_311_3)))
							else
								local var_311_4 = Mathf.Lerp(iter_311_2.color.r, 0.5, (arg_308_1.time_ - 0) / var_311_3)

								iter_311_2.color = Color.New(var_311_4, var_311_4, var_311_4)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_3 and arg_308_1.time_ < 0 + var_311_3 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.actorSpriteComps1086 then
				for iter_311_3, iter_311_4 in pairs(arg_308_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_311_4 then
						iter_311_4.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_308_1.var_.actorSpriteComps1086 = nil
			end

			local var_311_5 = arg_308_1.actors_["1028"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.actorSpriteComps1028 == nil then
				arg_308_1.var_.actorSpriteComps1028 = var_311_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_6 = 0.125

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.actorSpriteComps1028 then
					for iter_311_5, iter_311_6 in pairs(arg_308_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_311_6 then
							if arg_308_1.isInRecall_ then
								iter_311_6.color = Color.New(Mathf.Lerp(iter_311_6.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_6), Mathf.Lerp(iter_311_6.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_6), (Mathf.Lerp(iter_311_6.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_6)))
							else
								local var_311_7 = Mathf.Lerp(iter_311_6.color.r, 1, (arg_308_1.time_ - 0) / var_311_6)

								iter_311_6.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.actorSpriteComps1028 then
				for iter_311_7, iter_311_8 in pairs(arg_308_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_311_8 then
						iter_311_8.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps1028 = nil
			end

			local var_311_8 = arg_308_1.actors_["1028"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1028 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("1028", 4)

				for iter_311_9 = 0, var_311_8.childCount - 1 do
					local var_311_9 = var_311_8:GetChild(iter_311_9)

					if var_311_9.name == "" or not string.find(var_311_9.name, "split") then
						var_311_9.gameObject:SetActive(true)
					else
						var_311_9.gameObject:SetActive(false)
					end
				end
			end

			local var_311_10 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_10 then
				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_308_1.time_ - 0) / var_311_10)
			end

			if arg_308_1.time_ >= 0 + var_311_10 and arg_308_1.time_ < 0 + var_311_10 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_311_11 = 0
			local var_311_12 = 0.6

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_11 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_13 = arg_308_1:GetWordFromCfg(416042072)
				local var_311_14 = arg_308_1:FormatText(var_311_13.content)

				arg_308_1.text_.text = var_311_14

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_16 = 24 <= 0 and var_311_12 or var_311_12 * (utf8.len(var_311_14) / 24)

				if (24 <= 0 and var_311_12 or var_311_12 * (utf8.len(var_311_14) / 24)) > 0 and var_311_12 < var_311_16 then
					arg_308_1.talkMaxDuration = var_311_16

					if var_311_16 + var_311_11 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_16 + var_311_11
					end
				end

				arg_308_1.text_.text = var_311_14
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042072", "story_v_out_416042.awb") ~= 0 then
					local var_311_17 = manager.audio:GetVoiceLength("story_v_out_416042", "416042072", "story_v_out_416042.awb") / 1000

					if var_311_17 + var_311_11 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_17 + var_311_11
					end

					if var_311_13.prefab_name ~= "" and arg_308_1.actors_[var_311_13.prefab_name] ~= nil then
						local var_311_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_13.prefab_name].transform, "story_v_out_416042", "416042072", "story_v_out_416042.awb")

						arg_308_1:RecordAudio("416042072", var_311_18)
						arg_308_1:RecordAudio("416042072", var_311_18)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_416042", "416042072", "story_v_out_416042.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_416042", "416042072", "story_v_out_416042.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_19 = math.max(var_311_12, arg_308_1.talkMaxDuration)

			if var_311_11 <= arg_308_1.time_ and arg_308_1.time_ < var_311_11 + var_311_19 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_11) / var_311_19

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_11 + var_311_19 and arg_308_1.time_ < var_311_11 + var_311_19 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play416042073 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 416042073
		arg_312_1.duration_ = 10.57

		local var_312_0 = {
			zh = 4.066,
			ja = 10.566
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play416042074(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1028"]) and arg_312_1.var_.actorSpriteComps1028 == nil then
				arg_312_1.var_.actorSpriteComps1028 = arg_312_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_0 = 0.125

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1028"]) then
				if arg_312_1.var_.actorSpriteComps1028 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								iter_315_1.color = Color.New(Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_0), Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_0), (Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_0)))
							else
								local var_315_1 = Mathf.Lerp(iter_315_1.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_0)

								iter_315_1.color = Color.New(var_315_1, var_315_1, var_315_1)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1028"]) and arg_312_1.var_.actorSpriteComps1028 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_315_3 then
						iter_315_3.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps1028 = nil
			end

			local var_315_2 = arg_312_1.actors_["1086"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps1086 == nil then
				arg_312_1.var_.actorSpriteComps1086 = var_315_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_3 = 0.125

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.actorSpriteComps1086 then
					for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_315_5 then
							if arg_312_1.isInRecall_ then
								iter_315_5.color = Color.New(Mathf.Lerp(iter_315_5.color.r, arg_312_1.hightColor1.r, (arg_312_1.time_ - 0) / var_315_3), Mathf.Lerp(iter_315_5.color.g, arg_312_1.hightColor1.g, (arg_312_1.time_ - 0) / var_315_3), (Mathf.Lerp(iter_315_5.color.b, arg_312_1.hightColor1.b, (arg_312_1.time_ - 0) / var_315_3)))
							else
								local var_315_4 = Mathf.Lerp(iter_315_5.color.r, 1, (arg_312_1.time_ - 0) / var_315_3)

								iter_315_5.color = Color.New(var_315_4, var_315_4, var_315_4)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps1086 then
				for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_315_7 then
						iter_315_7.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps1086 = nil
			end

			local var_315_5 = 0
			local var_315_6 = 0.525

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_7 = arg_312_1:GetWordFromCfg(416042073)
				local var_315_8 = arg_312_1:FormatText(var_315_7.content)

				arg_312_1.text_.text = var_315_8

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_10 = 21 <= 0 and var_315_6 or var_315_6 * (utf8.len(var_315_8) / 21)

				if (21 <= 0 and var_315_6 or var_315_6 * (utf8.len(var_315_8) / 21)) > 0 and var_315_6 < var_315_10 then
					arg_312_1.talkMaxDuration = var_315_10

					if var_315_10 + var_315_5 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_5
					end
				end

				arg_312_1.text_.text = var_315_8
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042073", "story_v_out_416042.awb") ~= 0 then
					local var_315_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042073", "story_v_out_416042.awb") / 1000

					if var_315_11 + var_315_5 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_11 + var_315_5
					end

					if var_315_7.prefab_name ~= "" and arg_312_1.actors_[var_315_7.prefab_name] ~= nil then
						local var_315_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_7.prefab_name].transform, "story_v_out_416042", "416042073", "story_v_out_416042.awb")

						arg_312_1:RecordAudio("416042073", var_315_12)
						arg_312_1:RecordAudio("416042073", var_315_12)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_416042", "416042073", "story_v_out_416042.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_416042", "416042073", "story_v_out_416042.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_13 = math.max(var_315_6, arg_312_1.talkMaxDuration)

			if var_315_5 <= arg_312_1.time_ and arg_312_1.time_ < var_315_5 + var_315_13 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_5) / var_315_13

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_5 + var_315_13 and arg_312_1.time_ < var_315_5 + var_315_13 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play416042074 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 416042074
		arg_316_1.duration_ = 11.57

		local var_316_0 = {
			zh = 7.6,
			ja = 11.566
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
				arg_316_0:Play416042075(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1028"]) and arg_316_1.var_.actorSpriteComps1028 == nil then
				arg_316_1.var_.actorSpriteComps1028 = arg_316_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 0.125

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1028"]) then
				if arg_316_1.var_.actorSpriteComps1028 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 1, (arg_316_1.time_ - 0) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1028"]) and arg_316_1.var_.actorSpriteComps1028 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps1028 = nil
			end

			local var_319_2 = arg_316_1.actors_["1086"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps1086 == nil then
				arg_316_1.var_.actorSpriteComps1086 = var_319_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_3 = 0.125

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_3 and not isNil(var_319_2) then
				if arg_316_1.var_.actorSpriteComps1086 then
					for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_319_5 then
							if arg_316_1.isInRecall_ then
								iter_319_5.color = Color.New(Mathf.Lerp(iter_319_5.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_3), Mathf.Lerp(iter_319_5.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_3), (Mathf.Lerp(iter_319_5.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_3)))
							else
								local var_319_4 = Mathf.Lerp(iter_319_5.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_3)

								iter_319_5.color = Color.New(var_319_4, var_319_4, var_319_4)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_3 and arg_316_1.time_ < 0 + var_319_3 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps1086 then
				for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_319_7 then
						iter_319_7.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps1086 = nil
			end

			local var_319_5 = 0
			local var_319_6 = 0.8

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_7 = arg_316_1:GetWordFromCfg(416042074)
				local var_319_8 = arg_316_1:FormatText(var_319_7.content)

				arg_316_1.text_.text = var_319_8

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_10 = 32 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_8) / 32)

				if (32 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_8) / 32)) > 0 and var_319_6 < var_319_10 then
					arg_316_1.talkMaxDuration = var_319_10

					if var_319_10 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_5
					end
				end

				arg_316_1.text_.text = var_319_8
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042074", "story_v_out_416042.awb") ~= 0 then
					local var_319_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042074", "story_v_out_416042.awb") / 1000

					if var_319_11 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_11 + var_319_5
					end

					if var_319_7.prefab_name ~= "" and arg_316_1.actors_[var_319_7.prefab_name] ~= nil then
						local var_319_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_7.prefab_name].transform, "story_v_out_416042", "416042074", "story_v_out_416042.awb")

						arg_316_1:RecordAudio("416042074", var_319_12)
						arg_316_1:RecordAudio("416042074", var_319_12)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_416042", "416042074", "story_v_out_416042.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_416042", "416042074", "story_v_out_416042.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_13 = math.max(var_319_6, arg_316_1.talkMaxDuration)

			if var_319_5 <= arg_316_1.time_ and arg_316_1.time_ < var_319_5 + var_319_13 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_5) / var_319_13

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_5 + var_319_13 and arg_316_1.time_ < var_319_5 + var_319_13 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play416042075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 416042075
		arg_320_1.duration_ = 10.8

		local var_320_0 = {
			zh = 6.4,
			ja = 10.8
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play416042076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos10108 = arg_320_1.actors_["10108"].transform.localPosition
				arg_320_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10108", 3)

				for iter_323_0 = 0, arg_320_1.actors_["10108"].transform.childCount - 1 do
					local var_323_0 = arg_320_1.actors_["10108"].transform:GetChild(iter_323_0)

					if var_323_0.name == "split_2" or not string.find(var_323_0.name, "split") then
						var_323_0.gameObject:SetActive(true)
					else
						var_323_0.gameObject:SetActive(false)
					end
				end
			end

			local var_323_1 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_1 then
				arg_320_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_320_1.time_ - 0) / var_323_1)
			end

			if arg_320_1.time_ >= 0 + var_323_1 and arg_320_1.time_ < 0 + var_323_1 + arg_323_0 then
				arg_320_1.actors_["10108"].transform.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_323_2 = arg_320_1.actors_["1028"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1028 = var_323_2.localPosition
				var_323_2.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("1028", 7)

				for iter_323_1 = 0, var_323_2.childCount - 1 do
					local var_323_3 = var_323_2:GetChild(iter_323_1)

					if var_323_3.name == "" or not string.find(var_323_3.name, "split") then
						var_323_3.gameObject:SetActive(true)
					else
						var_323_3.gameObject:SetActive(false)
					end
				end
			end

			local var_323_4 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				var_323_2.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_320_1.time_ - 0) / var_323_4)
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				var_323_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_5 = arg_320_1.actors_["1086"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1086 = var_323_5.localPosition
				var_323_5.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("1086", 7)

				for iter_323_2 = 0, var_323_5.childCount - 1 do
					local var_323_6 = var_323_5:GetChild(iter_323_2)

					if var_323_6.name == "" or not string.find(var_323_6.name, "split") then
						var_323_6.gameObject:SetActive(true)
					else
						var_323_6.gameObject:SetActive(false)
					end
				end
			end

			local var_323_7 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				var_323_5.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_320_1.time_ - 0) / var_323_7)
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				var_323_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_8 = arg_320_1.actors_["10108"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_8) and arg_320_1.var_.actorSpriteComps10108 == nil then
				arg_320_1.var_.actorSpriteComps10108 = var_323_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_9 = 0.125

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_9 and not isNil(var_323_8) then
				if arg_320_1.var_.actorSpriteComps10108 then
					for iter_323_3, iter_323_4 in pairs(arg_320_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_323_4 then
							if arg_320_1.isInRecall_ then
								iter_323_4.color = Color.New(Mathf.Lerp(iter_323_4.color.r, arg_320_1.hightColor1.r, (arg_320_1.time_ - 0) / var_323_9), Mathf.Lerp(iter_323_4.color.g, arg_320_1.hightColor1.g, (arg_320_1.time_ - 0) / var_323_9), (Mathf.Lerp(iter_323_4.color.b, arg_320_1.hightColor1.b, (arg_320_1.time_ - 0) / var_323_9)))
							else
								local var_323_10 = Mathf.Lerp(iter_323_4.color.r, 1, (arg_320_1.time_ - 0) / var_323_9)

								iter_323_4.color = Color.New(var_323_10, var_323_10, var_323_10)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_9 and arg_320_1.time_ < 0 + var_323_9 + arg_323_0 and not isNil(var_323_8) and arg_320_1.var_.actorSpriteComps10108 then
				for iter_323_5, iter_323_6 in pairs(arg_320_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_323_6 then
						iter_323_6.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_320_1.var_.actorSpriteComps10108 = nil
			end

			local var_323_11 = 0
			local var_323_12 = 0.625

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_11 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_13 = arg_320_1:GetWordFromCfg(416042075)
				local var_323_14 = arg_320_1:FormatText(var_323_13.content)

				arg_320_1.text_.text = var_323_14

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_16 = 25 <= 0 and var_323_12 or var_323_12 * (utf8.len(var_323_14) / 25)

				if (25 <= 0 and var_323_12 or var_323_12 * (utf8.len(var_323_14) / 25)) > 0 and var_323_12 < var_323_16 then
					arg_320_1.talkMaxDuration = var_323_16

					if var_323_16 + var_323_11 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_16 + var_323_11
					end
				end

				arg_320_1.text_.text = var_323_14
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042075", "story_v_out_416042.awb") ~= 0 then
					local var_323_17 = manager.audio:GetVoiceLength("story_v_out_416042", "416042075", "story_v_out_416042.awb") / 1000

					if var_323_17 + var_323_11 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_17 + var_323_11
					end

					if var_323_13.prefab_name ~= "" and arg_320_1.actors_[var_323_13.prefab_name] ~= nil then
						local var_323_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_13.prefab_name].transform, "story_v_out_416042", "416042075", "story_v_out_416042.awb")

						arg_320_1:RecordAudio("416042075", var_323_18)
						arg_320_1:RecordAudio("416042075", var_323_18)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_416042", "416042075", "story_v_out_416042.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_416042", "416042075", "story_v_out_416042.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_19 = math.max(var_323_12, arg_320_1.talkMaxDuration)

			if var_323_11 <= arg_320_1.time_ and arg_320_1.time_ < var_323_11 + var_323_19 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_11) / var_323_19

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_11 + var_323_19 and arg_320_1.time_ < var_323_11 + var_323_19 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play416042076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 416042076
		arg_324_1.duration_ = 10.1

		local var_324_0 = {
			zh = 8.466,
			ja = 10.1
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play416042077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 4 < arg_324_1.time_ and arg_324_1.time_ <= 4 + arg_327_0 then
				arg_324_1.allBtn_.enabled = false
			end

			if arg_324_1.time_ >= 4 + 0.3 and arg_324_1.time_ < 4 + 0.3 + arg_327_0 then
				arg_324_1.allBtn_.enabled = true
			end

			local var_327_0 = "ST0106"

			if arg_324_1.bgs_.ST0106 == nil then
				local var_327_1 = Object.Instantiate(arg_324_1.paintGo_)

				var_327_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_327_0)
				var_327_1.name = var_327_0
				var_327_1.transform.parent = arg_324_1.stage_.transform
				var_327_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_324_1.bgs_[var_327_0] = var_327_1
			end

			if 2 < arg_324_1.time_ and arg_324_1.time_ <= 2 + arg_327_0 then
				local var_327_2 = arg_324_1.bgs_.ST0106

				arg_324_1.bgs_.ST0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_327_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_3 = var_327_2:GetComponent("SpriteRenderer")

				if var_327_3 and var_327_3.sprite then
					local var_327_4 = 2 * (var_327_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_327_2.transform.localScale = Vector3.New(var_327_4 / var_327_3.sprite.bounds.size.y < var_327_4 * manager.ui.mainCameraCom_.aspect / var_327_3.sprite.bounds.size.x and var_327_4 * manager.ui.mainCameraCom_.aspect / var_327_3.sprite.bounds.size.x or var_327_4 / var_327_3.sprite.bounds.size.y, var_327_4 / var_327_3.sprite.bounds.size.y < var_327_4 * manager.ui.mainCameraCom_.aspect / var_327_3.sprite.bounds.size.x and var_327_4 * manager.ui.mainCameraCom_.aspect / var_327_3.sprite.bounds.size.x or var_327_4 / var_327_3.sprite.bounds.size.y, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "ST0106" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_5 = 0

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_5 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_6 = 2

			if var_327_5 <= arg_324_1.time_ and arg_324_1.time_ < var_327_5 + var_327_6 then
				local var_327_7 = Color.New(0, 0, 0)

				var_327_7.a = Mathf.Lerp(0, 1, (arg_324_1.time_ - var_327_5) / var_327_6)
				arg_324_1.mask_.color = var_327_7
			end

			if arg_324_1.time_ >= var_327_5 + var_327_6 and arg_324_1.time_ < var_327_5 + var_327_6 + arg_327_0 then
				local var_327_8 = Color.New(0, 0, 0)

				var_327_8.a = 1
				arg_324_1.mask_.color = var_327_8
			end

			local var_327_9 = 2

			if 2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_9 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_10 = 2

			if var_327_9 <= arg_324_1.time_ and arg_324_1.time_ < var_327_9 + var_327_10 then
				local var_327_11 = Color.New(0, 0, 0)

				var_327_11.a = Mathf.Lerp(1, 0, (arg_324_1.time_ - var_327_9) / var_327_10)
				arg_324_1.mask_.color = var_327_11
			end

			if arg_324_1.time_ >= var_327_9 + var_327_10 and arg_324_1.time_ < var_327_9 + var_327_10 + arg_327_0 then
				local var_327_12 = Color.New(0, 0, 0)

				arg_324_1.mask_.enabled = false
				var_327_12.a = 0
				arg_324_1.mask_.color = var_327_12
			end

			local var_327_13 = arg_324_1.actors_["10108"].transform

			if 1.966 < arg_324_1.time_ and arg_324_1.time_ <= 1.966 + arg_327_0 then
				arg_324_1.var_.moveOldPos10108 = var_327_13.localPosition
				var_327_13.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("10108", 7)

				for iter_327_2 = 0, var_327_13.childCount - 1 do
					local var_327_14 = var_327_13:GetChild(iter_327_2)

					if var_327_14.name == "" or not string.find(var_327_14.name, "split") then
						var_327_14.gameObject:SetActive(true)
					else
						var_327_14.gameObject:SetActive(false)
					end
				end
			end

			local var_327_15 = 0.001

			if 1.966 <= arg_324_1.time_ and arg_324_1.time_ < 1.966 + var_327_15 then
				var_327_13.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_324_1.time_ - 1.966) / var_327_15)
			end

			if arg_324_1.time_ >= 1.966 + var_327_15 and arg_324_1.time_ < 1.966 + var_327_15 + arg_327_0 then
				var_327_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_327_16 = arg_324_1.actors_["1086"]

			if 3.63333333333333 < arg_324_1.time_ and arg_324_1.time_ <= 3.63333333333333 + arg_327_0 and not isNil(var_327_16) and arg_324_1.var_.actorSpriteComps1086 == nil then
				arg_324_1.var_.actorSpriteComps1086 = var_327_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_17 = 0.125

			if 3.63333333333333 <= arg_324_1.time_ and arg_324_1.time_ < 3.63333333333333 + var_327_17 and not isNil(var_327_16) then
				if arg_324_1.var_.actorSpriteComps1086 then
					for iter_327_3, iter_327_4 in pairs(arg_324_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_327_4 then
							if arg_324_1.isInRecall_ then
								iter_327_4.color = Color.New(Mathf.Lerp(iter_327_4.color.r, arg_324_1.hightColor1.r, (arg_324_1.time_ - 3.63333333333333) / var_327_17), Mathf.Lerp(iter_327_4.color.g, arg_324_1.hightColor1.g, (arg_324_1.time_ - 3.63333333333333) / var_327_17), (Mathf.Lerp(iter_327_4.color.b, arg_324_1.hightColor1.b, (arg_324_1.time_ - 3.63333333333333) / var_327_17)))
							else
								local var_327_18 = Mathf.Lerp(iter_327_4.color.r, 1, (arg_324_1.time_ - 3.63333333333333) / var_327_17)

								iter_327_4.color = Color.New(var_327_18, var_327_18, var_327_18)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 3.63333333333333 + var_327_17 and arg_324_1.time_ < 3.63333333333333 + var_327_17 + arg_327_0 and not isNil(var_327_16) and arg_324_1.var_.actorSpriteComps1086 then
				for iter_327_5, iter_327_6 in pairs(arg_324_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_327_6 then
						iter_327_6.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_324_1.var_.actorSpriteComps1086 = nil
			end

			local var_327_19 = arg_324_1.actors_["1086"].transform

			if 3.63333333333333 < arg_324_1.time_ and arg_324_1.time_ <= 3.63333333333333 + arg_327_0 then
				arg_324_1.var_.moveOldPos1086 = var_327_19.localPosition
				var_327_19.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1086", 3)

				for iter_327_7 = 0, var_327_19.childCount - 1 do
					local var_327_20 = var_327_19:GetChild(iter_327_7)

					if var_327_20.name == "" or not string.find(var_327_20.name, "split") then
						var_327_20.gameObject:SetActive(true)
					else
						var_327_20.gameObject:SetActive(false)
					end
				end
			end

			local var_327_21 = 0.001

			if 3.63333333333333 <= arg_324_1.time_ and arg_324_1.time_ < 3.63333333333333 + var_327_21 then
				var_327_19.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_324_1.time_ - 3.63333333333333) / var_327_21)
			end

			if arg_324_1.time_ >= 3.63333333333333 + var_327_21 and arg_324_1.time_ < 3.63333333333333 + var_327_21 + arg_327_0 then
				var_327_19.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			if 3.63333333333333 < arg_324_1.time_ and arg_324_1.time_ <= 3.63333333333333 + arg_327_0 then
				local var_327_22 = arg_324_1.actors_["1086"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_327_22 then
					arg_324_1.var_.alphaOldValue1086 = var_327_22.alpha
					arg_324_1.var_.characterEffect1086 = var_327_22
				end

				arg_324_1.var_.alphaOldValue1086 = 0
			end

			local var_327_23 = 0.466666666666666

			if 3.63333333333333 <= arg_324_1.time_ and arg_324_1.time_ < 3.63333333333333 + var_327_23 then
				if arg_324_1.var_.characterEffect1086 then
					arg_324_1.var_.characterEffect1086.alpha = Mathf.Lerp(arg_324_1.var_.alphaOldValue1086, 1, (arg_324_1.time_ - 3.63333333333333) / var_327_23)
				end
			end

			if arg_324_1.time_ >= 3.63333333333333 + var_327_23 and arg_324_1.time_ < 3.63333333333333 + var_327_23 + arg_327_0 and arg_324_1.var_.characterEffect1086 then
				arg_324_1.var_.characterEffect1086.alpha = 1
			end

			if arg_324_1.frameCnt_ <= 1 then
				arg_324_1.dialog_:SetActive(false)
			end

			local var_327_24 = 4
			local var_327_25 = 0.625

			if 4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_24 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_26 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_26:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_27 = arg_324_1:GetWordFromCfg(416042076)
				local var_327_28 = arg_324_1:FormatText(var_327_27.content)

				arg_324_1.text_.text = var_327_28

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_30 = 25 <= 0 and var_327_25 or var_327_25 * (utf8.len(var_327_28) / 25)

				if (25 <= 0 and var_327_25 or var_327_25 * (utf8.len(var_327_28) / 25)) > 0 and var_327_25 < var_327_30 then
					arg_324_1.talkMaxDuration = var_327_30
					var_327_24 = var_327_24 + 0.3

					if var_327_30 + var_327_24 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_30 + var_327_24
					end
				end

				arg_324_1.text_.text = var_327_28
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042076", "story_v_out_416042.awb") ~= 0 then
					local var_327_31 = manager.audio:GetVoiceLength("story_v_out_416042", "416042076", "story_v_out_416042.awb") / 1000

					if var_327_31 + var_327_24 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_31 + var_327_24
					end

					if var_327_27.prefab_name ~= "" and arg_324_1.actors_[var_327_27.prefab_name] ~= nil then
						local var_327_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_27.prefab_name].transform, "story_v_out_416042", "416042076", "story_v_out_416042.awb")

						arg_324_1:RecordAudio("416042076", var_327_32)
						arg_324_1:RecordAudio("416042076", var_327_32)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_416042", "416042076", "story_v_out_416042.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_416042", "416042076", "story_v_out_416042.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_33 = var_327_24 + 0.3
			local var_327_34 = math.max(var_327_25, arg_324_1.talkMaxDuration)

			if var_327_24 + 0.3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_33 + var_327_34 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_33) / var_327_34

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_33 + var_327_34 and arg_324_1.time_ < var_327_33 + var_327_34 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play416042077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 416042077
		arg_330_1.duration_ = 13.4

		local var_330_0 = {
			zh = 8.1,
			ja = 13.4
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play416042078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 1.05

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(416042077)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 42 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 42)

				if (42 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 42)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042077", "story_v_out_416042.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042077", "story_v_out_416042.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_416042", "416042077", "story_v_out_416042.awb")

						arg_330_1:RecordAudio("416042077", var_333_6)
						arg_330_1:RecordAudio("416042077", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_416042", "416042077", "story_v_out_416042.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_416042", "416042077", "story_v_out_416042.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play416042078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 416042078
		arg_334_1.duration_ = 13.53

		local var_334_0 = {
			zh = 3.9,
			ja = 13.533
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play416042079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1086 = arg_334_1.actors_["1086"].transform.localPosition
				arg_334_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("1086", 2)

				for iter_337_0 = 0, arg_334_1.actors_["1086"].transform.childCount - 1 do
					local var_337_0 = arg_334_1.actors_["1086"].transform:GetChild(iter_337_0)

					if var_337_0.name == "" or not string.find(var_337_0.name, "split") then
						var_337_0.gameObject:SetActive(true)
					else
						var_337_0.gameObject:SetActive(false)
					end
				end
			end

			local var_337_1 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_1 then
				arg_334_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_334_1.time_ - 0) / var_337_1)
			end

			if arg_334_1.time_ >= 0 + var_337_1 and arg_334_1.time_ < 0 + var_337_1 + arg_337_0 then
				arg_334_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_337_2 = arg_334_1.actors_["10108"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10108 = var_337_2.localPosition
				var_337_2.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10108", 4)

				for iter_337_1 = 0, var_337_2.childCount - 1 do
					local var_337_3 = var_337_2:GetChild(iter_337_1)

					if var_337_3.name == "split_4" or not string.find(var_337_3.name, "split") then
						var_337_3.gameObject:SetActive(true)
					else
						var_337_3.gameObject:SetActive(false)
					end
				end
			end

			local var_337_4 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				var_337_2.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_334_1.time_ - 0) / var_337_4)
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				var_337_2.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_337_5 = arg_334_1.actors_["10108"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_5) and arg_334_1.var_.actorSpriteComps10108 == nil then
				arg_334_1.var_.actorSpriteComps10108 = var_337_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_6 = 0.125

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_6 and not isNil(var_337_5) then
				if arg_334_1.var_.actorSpriteComps10108 then
					for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_337_3 then
							if arg_334_1.isInRecall_ then
								iter_337_3.color = Color.New(Mathf.Lerp(iter_337_3.color.r, arg_334_1.hightColor1.r, (arg_334_1.time_ - 0) / var_337_6), Mathf.Lerp(iter_337_3.color.g, arg_334_1.hightColor1.g, (arg_334_1.time_ - 0) / var_337_6), (Mathf.Lerp(iter_337_3.color.b, arg_334_1.hightColor1.b, (arg_334_1.time_ - 0) / var_337_6)))
							else
								local var_337_7 = Mathf.Lerp(iter_337_3.color.r, 1, (arg_334_1.time_ - 0) / var_337_6)

								iter_337_3.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_6 and arg_334_1.time_ < 0 + var_337_6 + arg_337_0 and not isNil(var_337_5) and arg_334_1.var_.actorSpriteComps10108 then
				for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_337_5 then
						iter_337_5.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_334_1.var_.actorSpriteComps10108 = nil
			end

			local var_337_8 = arg_334_1.actors_["1086"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps1086 == nil then
				arg_334_1.var_.actorSpriteComps1086 = var_337_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_9 = 0.125

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_9 and not isNil(var_337_8) then
				if arg_334_1.var_.actorSpriteComps1086 then
					for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_337_7 then
							if arg_334_1.isInRecall_ then
								iter_337_7.color = Color.New(Mathf.Lerp(iter_337_7.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_9), Mathf.Lerp(iter_337_7.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_9), (Mathf.Lerp(iter_337_7.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_9)))
							else
								local var_337_10 = Mathf.Lerp(iter_337_7.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_9)

								iter_337_7.color = Color.New(var_337_10, var_337_10, var_337_10)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_9 and arg_334_1.time_ < 0 + var_337_9 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps1086 then
				for iter_337_8, iter_337_9 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_337_9 then
						iter_337_9.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps1086 = nil
			end

			local var_337_11 = 0
			local var_337_12 = 0.4

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_11 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_13 = arg_334_1:GetWordFromCfg(416042078)
				local var_337_14 = arg_334_1:FormatText(var_337_13.content)

				arg_334_1.text_.text = var_337_14

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_16 = 16 <= 0 and var_337_12 or var_337_12 * (utf8.len(var_337_14) / 16)

				if (16 <= 0 and var_337_12 or var_337_12 * (utf8.len(var_337_14) / 16)) > 0 and var_337_12 < var_337_16 then
					arg_334_1.talkMaxDuration = var_337_16

					if var_337_16 + var_337_11 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_16 + var_337_11
					end
				end

				arg_334_1.text_.text = var_337_14
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042078", "story_v_out_416042.awb") ~= 0 then
					local var_337_17 = manager.audio:GetVoiceLength("story_v_out_416042", "416042078", "story_v_out_416042.awb") / 1000

					if var_337_17 + var_337_11 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_17 + var_337_11
					end

					if var_337_13.prefab_name ~= "" and arg_334_1.actors_[var_337_13.prefab_name] ~= nil then
						local var_337_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_13.prefab_name].transform, "story_v_out_416042", "416042078", "story_v_out_416042.awb")

						arg_334_1:RecordAudio("416042078", var_337_18)
						arg_334_1:RecordAudio("416042078", var_337_18)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_416042", "416042078", "story_v_out_416042.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_416042", "416042078", "story_v_out_416042.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_19 = math.max(var_337_12, arg_334_1.talkMaxDuration)

			if var_337_11 <= arg_334_1.time_ and arg_334_1.time_ < var_337_11 + var_337_19 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_11) / var_337_19

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_11 + var_337_19 and arg_334_1.time_ < var_337_11 + var_337_19 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play416042079 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 416042079
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play416042080(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1086 = arg_338_1.actors_["1086"].transform.localPosition
				arg_338_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1086", 7)

				for iter_341_0 = 0, arg_338_1.actors_["1086"].transform.childCount - 1 do
					local var_341_0 = arg_338_1.actors_["1086"].transform:GetChild(iter_341_0)

					if var_341_0.name == "" or not string.find(var_341_0.name, "split") then
						var_341_0.gameObject:SetActive(true)
					else
						var_341_0.gameObject:SetActive(false)
					end
				end
			end

			local var_341_1 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_1 then
				arg_338_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_338_1.time_ - 0) / var_341_1)
			end

			if arg_338_1.time_ >= 0 + var_341_1 and arg_338_1.time_ < 0 + var_341_1 + arg_341_0 then
				arg_338_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_2 = arg_338_1.actors_["10108"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10108 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10108", 7)

				for iter_341_1 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_1)

					if var_341_3.name == "" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_338_1.time_ - 0) / var_341_4)
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_5 = 0
			local var_341_6 = 1.575

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(416042079).content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 63 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_7) / 63)

				if (63 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_7) / 63)) > 0 and var_341_6 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_5
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_6, arg_338_1.talkMaxDuration)

			if var_341_5 <= arg_338_1.time_ and arg_338_1.time_ < var_341_5 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_5) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_5 + var_341_10 and arg_338_1.time_ < var_341_5 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play416042080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 416042080
		arg_342_1.duration_ = 7.07

		local var_342_0 = {
			zh = 6,
			ja = 7.066
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
				arg_342_0:Play416042081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1086 = arg_342_1.actors_["1086"].transform.localPosition
				arg_342_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("1086", 3)

				for iter_345_0 = 0, arg_342_1.actors_["1086"].transform.childCount - 1 do
					local var_345_0 = arg_342_1.actors_["1086"].transform:GetChild(iter_345_0)

					if var_345_0.name == "split_4" or not string.find(var_345_0.name, "split") then
						var_345_0.gameObject:SetActive(true)
					else
						var_345_0.gameObject:SetActive(false)
					end
				end
			end

			local var_345_1 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_1 then
				arg_342_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_342_1.time_ - 0) / var_345_1)
			end

			if arg_342_1.time_ >= 0 + var_345_1 and arg_342_1.time_ < 0 + var_345_1 + arg_345_0 then
				arg_342_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_345_2 = arg_342_1.actors_["1086"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps1086 == nil then
				arg_342_1.var_.actorSpriteComps1086 = var_345_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_3 = 0.125

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_3 and not isNil(var_345_2) then
				if arg_342_1.var_.actorSpriteComps1086 then
					for iter_345_1, iter_345_2 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_345_2 then
							if arg_342_1.isInRecall_ then
								iter_345_2.color = Color.New(Mathf.Lerp(iter_345_2.color.r, arg_342_1.hightColor1.r, (arg_342_1.time_ - 0) / var_345_3), Mathf.Lerp(iter_345_2.color.g, arg_342_1.hightColor1.g, (arg_342_1.time_ - 0) / var_345_3), (Mathf.Lerp(iter_345_2.color.b, arg_342_1.hightColor1.b, (arg_342_1.time_ - 0) / var_345_3)))
							else
								local var_345_4 = Mathf.Lerp(iter_345_2.color.r, 1, (arg_342_1.time_ - 0) / var_345_3)

								iter_345_2.color = Color.New(var_345_4, var_345_4, var_345_4)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_3 and arg_342_1.time_ < 0 + var_345_3 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps1086 then
				for iter_345_3, iter_345_4 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_345_4 then
						iter_345_4.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_342_1.var_.actorSpriteComps1086 = nil
			end

			local var_345_5 = 0
			local var_345_6 = 0.725

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_5 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_7 = arg_342_1:GetWordFromCfg(416042080)
				local var_345_8 = arg_342_1:FormatText(var_345_7.content)

				arg_342_1.text_.text = var_345_8

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_10 = 29 <= 0 and var_345_6 or var_345_6 * (utf8.len(var_345_8) / 29)

				if (29 <= 0 and var_345_6 or var_345_6 * (utf8.len(var_345_8) / 29)) > 0 and var_345_6 < var_345_10 then
					arg_342_1.talkMaxDuration = var_345_10

					if var_345_10 + var_345_5 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_10 + var_345_5
					end
				end

				arg_342_1.text_.text = var_345_8
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042080", "story_v_out_416042.awb") ~= 0 then
					local var_345_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042080", "story_v_out_416042.awb") / 1000

					if var_345_11 + var_345_5 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_11 + var_345_5
					end

					if var_345_7.prefab_name ~= "" and arg_342_1.actors_[var_345_7.prefab_name] ~= nil then
						local var_345_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_7.prefab_name].transform, "story_v_out_416042", "416042080", "story_v_out_416042.awb")

						arg_342_1:RecordAudio("416042080", var_345_12)
						arg_342_1:RecordAudio("416042080", var_345_12)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_416042", "416042080", "story_v_out_416042.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_416042", "416042080", "story_v_out_416042.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_13 = math.max(var_345_6, arg_342_1.talkMaxDuration)

			if var_345_5 <= arg_342_1.time_ and arg_342_1.time_ < var_345_5 + var_345_13 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_5) / var_345_13

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_5 + var_345_13 and arg_342_1.time_ < var_345_5 + var_345_13 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play416042081 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 416042081
		arg_346_1.duration_ = 8.3

		local var_346_0 = {
			zh = 4.266,
			ja = 8.3
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play416042082(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1086 = arg_346_1.actors_["1086"].transform.localPosition
				arg_346_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1086", 2)

				for iter_349_0 = 0, arg_346_1.actors_["1086"].transform.childCount - 1 do
					local var_349_0 = arg_346_1.actors_["1086"].transform:GetChild(iter_349_0)

					if var_349_0.name == "split_4" or not string.find(var_349_0.name, "split") then
						var_349_0.gameObject:SetActive(true)
					else
						var_349_0.gameObject:SetActive(false)
					end
				end
			end

			local var_349_1 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_1 then
				arg_346_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_346_1.time_ - 0) / var_349_1)
			end

			if arg_346_1.time_ >= 0 + var_349_1 and arg_346_1.time_ < 0 + var_349_1 + arg_349_0 then
				arg_346_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_349_2 = arg_346_1.actors_["1086"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.actorSpriteComps1086 == nil then
				arg_346_1.var_.actorSpriteComps1086 = var_349_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_3 = 0.125

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_3 and not isNil(var_349_2) then
				if arg_346_1.var_.actorSpriteComps1086 then
					for iter_349_1, iter_349_2 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_349_2 then
							if arg_346_1.isInRecall_ then
								iter_349_2.color = Color.New(Mathf.Lerp(iter_349_2.color.r, arg_346_1.hightColor2.r, (arg_346_1.time_ - 0) / var_349_3), Mathf.Lerp(iter_349_2.color.g, arg_346_1.hightColor2.g, (arg_346_1.time_ - 0) / var_349_3), (Mathf.Lerp(iter_349_2.color.b, arg_346_1.hightColor2.b, (arg_346_1.time_ - 0) / var_349_3)))
							else
								local var_349_4 = Mathf.Lerp(iter_349_2.color.r, 0.5, (arg_346_1.time_ - 0) / var_349_3)

								iter_349_2.color = Color.New(var_349_4, var_349_4, var_349_4)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_3 and arg_346_1.time_ < 0 + var_349_3 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.actorSpriteComps1086 then
				for iter_349_3, iter_349_4 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_349_4 then
						iter_349_4.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_346_1.var_.actorSpriteComps1086 = nil
			end

			local var_349_5 = arg_346_1.actors_["1028"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1028 = var_349_5.localPosition
				var_349_5.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1028", 4)

				for iter_349_5 = 0, var_349_5.childCount - 1 do
					local var_349_6 = var_349_5:GetChild(iter_349_5)

					if var_349_6.name == "" or not string.find(var_349_6.name, "split") then
						var_349_6.gameObject:SetActive(true)
					else
						var_349_6.gameObject:SetActive(false)
					end
				end
			end

			local var_349_7 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				var_349_5.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_346_1.time_ - 0) / var_349_7)
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				var_349_5.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_349_8 = arg_346_1.actors_["1028"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_8) and arg_346_1.var_.actorSpriteComps1028 == nil then
				arg_346_1.var_.actorSpriteComps1028 = var_349_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_9 = 0.125

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_9 and not isNil(var_349_8) then
				if arg_346_1.var_.actorSpriteComps1028 then
					for iter_349_6, iter_349_7 in pairs(arg_346_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_349_7 then
							if arg_346_1.isInRecall_ then
								iter_349_7.color = Color.New(Mathf.Lerp(iter_349_7.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_9), Mathf.Lerp(iter_349_7.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_9), (Mathf.Lerp(iter_349_7.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_9)))
							else
								local var_349_10 = Mathf.Lerp(iter_349_7.color.r, 1, (arg_346_1.time_ - 0) / var_349_9)

								iter_349_7.color = Color.New(var_349_10, var_349_10, var_349_10)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_9 and arg_346_1.time_ < 0 + var_349_9 + arg_349_0 and not isNil(var_349_8) and arg_346_1.var_.actorSpriteComps1028 then
				for iter_349_8, iter_349_9 in pairs(arg_346_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_349_9 then
						iter_349_9.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps1028 = nil
			end

			local var_349_11 = 0
			local var_349_12 = 0.4

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_11 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_13 = arg_346_1:GetWordFromCfg(416042081)
				local var_349_14 = arg_346_1:FormatText(var_349_13.content)

				arg_346_1.text_.text = var_349_14

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_16 = 16 <= 0 and var_349_12 or var_349_12 * (utf8.len(var_349_14) / 16)

				if (16 <= 0 and var_349_12 or var_349_12 * (utf8.len(var_349_14) / 16)) > 0 and var_349_12 < var_349_16 then
					arg_346_1.talkMaxDuration = var_349_16

					if var_349_16 + var_349_11 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_16 + var_349_11
					end
				end

				arg_346_1.text_.text = var_349_14
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042081", "story_v_out_416042.awb") ~= 0 then
					local var_349_17 = manager.audio:GetVoiceLength("story_v_out_416042", "416042081", "story_v_out_416042.awb") / 1000

					if var_349_17 + var_349_11 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_17 + var_349_11
					end

					if var_349_13.prefab_name ~= "" and arg_346_1.actors_[var_349_13.prefab_name] ~= nil then
						local var_349_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_13.prefab_name].transform, "story_v_out_416042", "416042081", "story_v_out_416042.awb")

						arg_346_1:RecordAudio("416042081", var_349_18)
						arg_346_1:RecordAudio("416042081", var_349_18)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_416042", "416042081", "story_v_out_416042.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_416042", "416042081", "story_v_out_416042.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_19 = math.max(var_349_12, arg_346_1.talkMaxDuration)

			if var_349_11 <= arg_346_1.time_ and arg_346_1.time_ < var_349_11 + var_349_19 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_11) / var_349_19

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_11 + var_349_19 and arg_346_1.time_ < var_349_11 + var_349_19 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play416042082 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 416042082
		arg_350_1.duration_ = 16.13

		local var_350_0 = {
			zh = 8.1,
			ja = 16.133
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
				arg_350_0:Play416042083(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1028"]) and arg_350_1.var_.actorSpriteComps1028 == nil then
				arg_350_1.var_.actorSpriteComps1028 = arg_350_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.125

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1028"]) then
				if arg_350_1.var_.actorSpriteComps1028 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1028"]) and arg_350_1.var_.actorSpriteComps1028 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps1028 = nil
			end

			local var_353_2 = arg_350_1.actors_["1086"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1086 == nil then
				arg_350_1.var_.actorSpriteComps1086 = var_353_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_3 = 0.125

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.actorSpriteComps1086 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								iter_353_5.color = Color.New(Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_3), Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_3), (Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_3)))
							else
								local var_353_4 = Mathf.Lerp(iter_353_5.color.r, 1, (arg_350_1.time_ - 0) / var_353_3)

								iter_353_5.color = Color.New(var_353_4, var_353_4, var_353_4)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1086 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_353_7 then
						iter_353_7.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps1086 = nil
			end

			local var_353_5 = arg_350_1.actors_["1086"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1086 = var_353_5.localPosition
				var_353_5.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1086", 2)

				for iter_353_8 = 0, var_353_5.childCount - 1 do
					local var_353_6 = var_353_5:GetChild(iter_353_8)

					if var_353_6.name == "split_1" or not string.find(var_353_6.name, "split") then
						var_353_6.gameObject:SetActive(true)
					else
						var_353_6.gameObject:SetActive(false)
					end
				end
			end

			local var_353_7 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_7 then
				var_353_5.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_350_1.time_ - 0) / var_353_7)
			end

			if arg_350_1.time_ >= 0 + var_353_7 and arg_350_1.time_ < 0 + var_353_7 + arg_353_0 then
				var_353_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_353_8 = 0
			local var_353_9 = 0.75

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_10 = arg_350_1:GetWordFromCfg(416042082)
				local var_353_11 = arg_350_1:FormatText(var_353_10.content)

				arg_350_1.text_.text = var_353_11

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_13 = 30 <= 0 and var_353_9 or var_353_9 * (utf8.len(var_353_11) / 30)

				if (30 <= 0 and var_353_9 or var_353_9 * (utf8.len(var_353_11) / 30)) > 0 and var_353_9 < var_353_13 then
					arg_350_1.talkMaxDuration = var_353_13

					if var_353_13 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_13 + var_353_8
					end
				end

				arg_350_1.text_.text = var_353_11
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042082", "story_v_out_416042.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042082", "story_v_out_416042.awb") / 1000

					if var_353_14 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_8
					end

					if var_353_10.prefab_name ~= "" and arg_350_1.actors_[var_353_10.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_10.prefab_name].transform, "story_v_out_416042", "416042082", "story_v_out_416042.awb")

						arg_350_1:RecordAudio("416042082", var_353_15)
						arg_350_1:RecordAudio("416042082", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_416042", "416042082", "story_v_out_416042.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_416042", "416042082", "story_v_out_416042.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_9, arg_350_1.talkMaxDuration)

			if var_353_8 <= arg_350_1.time_ and arg_350_1.time_ < var_353_8 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_8) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_8 + var_353_16 and arg_350_1.time_ < var_353_8 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play416042083 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 416042083
		arg_354_1.duration_ = 9.5

		local var_354_0 = {
			zh = 5.033,
			ja = 9.5
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play416042084(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.625

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:GetWordFromCfg(416042083)
				local var_357_2 = arg_354_1:FormatText(var_357_1.content)

				arg_354_1.text_.text = var_357_2

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 25 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 25)

				if (25 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 25)) > 0 and var_357_0 < var_357_4 then
					arg_354_1.talkMaxDuration = var_357_4

					if var_357_4 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_4 + 0
					end
				end

				arg_354_1.text_.text = var_357_2
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042083", "story_v_out_416042.awb") ~= 0 then
					local var_357_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042083", "story_v_out_416042.awb") / 1000

					if var_357_5 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + 0
					end

					if var_357_1.prefab_name ~= "" and arg_354_1.actors_[var_357_1.prefab_name] ~= nil then
						local var_357_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_1.prefab_name].transform, "story_v_out_416042", "416042083", "story_v_out_416042.awb")

						arg_354_1:RecordAudio("416042083", var_357_6)
						arg_354_1:RecordAudio("416042083", var_357_6)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_416042", "416042083", "story_v_out_416042.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_416042", "416042083", "story_v_out_416042.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play416042084 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 416042084
		arg_358_1.duration_ = 4.6

		local var_358_0 = {
			zh = 3.833,
			ja = 4.6
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play416042085(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1028"]) and arg_358_1.var_.actorSpriteComps1028 == nil then
				arg_358_1.var_.actorSpriteComps1028 = arg_358_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.125

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1028"]) then
				if arg_358_1.var_.actorSpriteComps1028 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 1, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1028"]) and arg_358_1.var_.actorSpriteComps1028 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps1028 = nil
			end

			local var_361_2 = arg_358_1.actors_["1086"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps1086 == nil then
				arg_358_1.var_.actorSpriteComps1086 = var_361_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_3 = 0.125

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_3 and not isNil(var_361_2) then
				if arg_358_1.var_.actorSpriteComps1086 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								iter_361_5.color = Color.New(Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor2.r, (arg_358_1.time_ - 0) / var_361_3), Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor2.g, (arg_358_1.time_ - 0) / var_361_3), (Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor2.b, (arg_358_1.time_ - 0) / var_361_3)))
							else
								local var_361_4 = Mathf.Lerp(iter_361_5.color.r, 0.5, (arg_358_1.time_ - 0) / var_361_3)

								iter_361_5.color = Color.New(var_361_4, var_361_4, var_361_4)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_3 and arg_358_1.time_ < 0 + var_361_3 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps1086 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_361_7 then
						iter_361_7.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_358_1.var_.actorSpriteComps1086 = nil
			end

			local var_361_5 = arg_358_1.actors_["1028"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1028 = var_361_5.localPosition
				var_361_5.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1028", 4)

				for iter_361_8 = 0, var_361_5.childCount - 1 do
					local var_361_6 = var_361_5:GetChild(iter_361_8)

					if var_361_6.name == "split_2" or not string.find(var_361_6.name, "split") then
						var_361_6.gameObject:SetActive(true)
					else
						var_361_6.gameObject:SetActive(false)
					end
				end
			end

			local var_361_7 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				var_361_5.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_358_1.time_ - 0) / var_361_7)
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				var_361_5.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_361_8 = 0
			local var_361_9 = 0.325

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_8 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_10 = arg_358_1:GetWordFromCfg(416042084)
				local var_361_11 = arg_358_1:FormatText(var_361_10.content)

				arg_358_1.text_.text = var_361_11

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_13 = 13 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 13)

				if (13 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 13)) > 0 and var_361_9 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_8
					end
				end

				arg_358_1.text_.text = var_361_11
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042084", "story_v_out_416042.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042084", "story_v_out_416042.awb") / 1000

					if var_361_14 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_8
					end

					if var_361_10.prefab_name ~= "" and arg_358_1.actors_[var_361_10.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_10.prefab_name].transform, "story_v_out_416042", "416042084", "story_v_out_416042.awb")

						arg_358_1:RecordAudio("416042084", var_361_15)
						arg_358_1:RecordAudio("416042084", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_416042", "416042084", "story_v_out_416042.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_416042", "416042084", "story_v_out_416042.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_9, arg_358_1.talkMaxDuration)

			if var_361_8 <= arg_358_1.time_ and arg_358_1.time_ < var_361_8 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_8) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_8 + var_361_16 and arg_358_1.time_ < var_361_8 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play416042085 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 416042085
		arg_362_1.duration_ = 10.03

		local var_362_0 = {
			zh = 6.6,
			ja = 10.033
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
				arg_362_0:Play416042086(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1028"]) and arg_362_1.var_.actorSpriteComps1028 == nil then
				arg_362_1.var_.actorSpriteComps1028 = arg_362_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.125

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1028"]) then
				if arg_362_1.var_.actorSpriteComps1028 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor2.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor2.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor2.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 0.5, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1028"]) and arg_362_1.var_.actorSpriteComps1028 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_362_1.var_.actorSpriteComps1028 = nil
			end

			local var_365_2 = arg_362_1.actors_["1086"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps1086 == nil then
				arg_362_1.var_.actorSpriteComps1086 = var_365_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_3 = 0.125

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 and not isNil(var_365_2) then
				if arg_362_1.var_.actorSpriteComps1086 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								iter_365_5.color = Color.New(Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_3), Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_3), (Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_3)))
							else
								local var_365_4 = Mathf.Lerp(iter_365_5.color.r, 1, (arg_362_1.time_ - 0) / var_365_3)

								iter_365_5.color = Color.New(var_365_4, var_365_4, var_365_4)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps1086 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_365_7 then
						iter_365_7.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps1086 = nil
			end

			local var_365_5 = 0
			local var_365_6 = 0.725

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_7 = arg_362_1:GetWordFromCfg(416042085)
				local var_365_8 = arg_362_1:FormatText(var_365_7.content)

				arg_362_1.text_.text = var_365_8

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_10 = 29 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 29)

				if (29 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 29)) > 0 and var_365_6 < var_365_10 then
					arg_362_1.talkMaxDuration = var_365_10

					if var_365_10 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_5
					end
				end

				arg_362_1.text_.text = var_365_8
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042085", "story_v_out_416042.awb") ~= 0 then
					local var_365_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042085", "story_v_out_416042.awb") / 1000

					if var_365_11 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_5
					end

					if var_365_7.prefab_name ~= "" and arg_362_1.actors_[var_365_7.prefab_name] ~= nil then
						local var_365_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_7.prefab_name].transform, "story_v_out_416042", "416042085", "story_v_out_416042.awb")

						arg_362_1:RecordAudio("416042085", var_365_12)
						arg_362_1:RecordAudio("416042085", var_365_12)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_416042", "416042085", "story_v_out_416042.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_416042", "416042085", "story_v_out_416042.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_13 = math.max(var_365_6, arg_362_1.talkMaxDuration)

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_13 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_5) / var_365_13

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_5 + var_365_13 and arg_362_1.time_ < var_365_5 + var_365_13 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play416042086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 416042086
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play416042087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1028"]) and arg_366_1.var_.actorSpriteComps1028 == nil then
				arg_366_1.var_.actorSpriteComps1028 = arg_366_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.125

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1028"]) then
				if arg_366_1.var_.actorSpriteComps1028 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								iter_369_1.color = Color.New(Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_0), Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_0), (Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_0)))
							else
								local var_369_1 = Mathf.Lerp(iter_369_1.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_0)

								iter_369_1.color = Color.New(var_369_1, var_369_1, var_369_1)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1028"]) and arg_366_1.var_.actorSpriteComps1028 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps1028 = nil
			end

			local var_369_2 = arg_366_1.actors_["1086"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps1086 == nil then
				arg_366_1.var_.actorSpriteComps1086 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.125

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps1086 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								iter_369_5.color = Color.New(Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_3), Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_3), (Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_3)))
							else
								local var_369_4 = Mathf.Lerp(iter_369_5.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_3)

								iter_369_5.color = Color.New(var_369_4, var_369_4, var_369_4)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps1086 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_369_7 then
						iter_369_7.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps1086 = nil
			end

			local var_369_5 = 0
			local var_369_6 = 1.1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_7 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(416042086).content)

				arg_366_1.text_.text = var_369_7

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_9 = 44 <= 0 and var_369_6 or var_369_6 * (utf8.len(var_369_7) / 44)

				if (44 <= 0 and var_369_6 or var_369_6 * (utf8.len(var_369_7) / 44)) > 0 and var_369_6 < var_369_9 then
					arg_366_1.talkMaxDuration = var_369_9

					if var_369_9 + var_369_5 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_9 + var_369_5
					end
				end

				arg_366_1.text_.text = var_369_7
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_6, arg_366_1.talkMaxDuration)

			if var_369_5 <= arg_366_1.time_ and arg_366_1.time_ < var_369_5 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_5) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_5 + var_369_10 and arg_366_1.time_ < var_369_5 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play416042087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 416042087
		arg_370_1.duration_ = 4.83

		local var_370_0 = {
			zh = 4.833,
			ja = 4.8
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play416042088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1028"]) and arg_370_1.var_.actorSpriteComps1028 == nil then
				arg_370_1.var_.actorSpriteComps1028 = arg_370_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.125

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1028"]) then
				if arg_370_1.var_.actorSpriteComps1028 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								iter_373_1.color = Color.New(Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, (arg_370_1.time_ - 0) / var_373_0), Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, (arg_370_1.time_ - 0) / var_373_0), (Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, (arg_370_1.time_ - 0) / var_373_0)))
							else
								local var_373_1 = Mathf.Lerp(iter_373_1.color.r, 1, (arg_370_1.time_ - 0) / var_373_0)

								iter_373_1.color = Color.New(var_373_1, var_373_1, var_373_1)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1028"]) and arg_370_1.var_.actorSpriteComps1028 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps1028 = nil
			end

			local var_373_2 = arg_370_1.actors_["1086"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps1086 == nil then
				arg_370_1.var_.actorSpriteComps1086 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.125

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps1086 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								iter_373_5.color = Color.New(Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, (arg_370_1.time_ - 0) / var_373_3), Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, (arg_370_1.time_ - 0) / var_373_3), (Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, (arg_370_1.time_ - 0) / var_373_3)))
							else
								local var_373_4 = Mathf.Lerp(iter_373_5.color.r, 0.5, (arg_370_1.time_ - 0) / var_373_3)

								iter_373_5.color = Color.New(var_373_4, var_373_4, var_373_4)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps1086 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps1086 = nil
			end

			local var_373_5 = 0
			local var_373_6 = 0.575

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_7 = arg_370_1:GetWordFromCfg(416042087)
				local var_373_8 = arg_370_1:FormatText(var_373_7.content)

				arg_370_1.text_.text = var_373_8

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_10 = 23 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_8) / 23)

				if (23 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_8) / 23)) > 0 and var_373_6 < var_373_10 then
					arg_370_1.talkMaxDuration = var_373_10

					if var_373_10 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_5
					end
				end

				arg_370_1.text_.text = var_373_8
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042087", "story_v_out_416042.awb") ~= 0 then
					local var_373_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042087", "story_v_out_416042.awb") / 1000

					if var_373_11 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_11 + var_373_5
					end

					if var_373_7.prefab_name ~= "" and arg_370_1.actors_[var_373_7.prefab_name] ~= nil then
						local var_373_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_7.prefab_name].transform, "story_v_out_416042", "416042087", "story_v_out_416042.awb")

						arg_370_1:RecordAudio("416042087", var_373_12)
						arg_370_1:RecordAudio("416042087", var_373_12)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_416042", "416042087", "story_v_out_416042.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_416042", "416042087", "story_v_out_416042.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_13 = math.max(var_373_6, arg_370_1.talkMaxDuration)

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_13 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_5) / var_373_13

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_5 + var_373_13 and arg_370_1.time_ < var_373_5 + var_373_13 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play416042088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 416042088
		arg_374_1.duration_ = 8.87

		local var_374_0 = {
			zh = 8.866,
			ja = 6.433
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play416042089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1028"]) and arg_374_1.var_.actorSpriteComps1028 == nil then
				arg_374_1.var_.actorSpriteComps1028 = arg_374_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.125

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1028"]) then
				if arg_374_1.var_.actorSpriteComps1028 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								iter_377_1.color = Color.New(Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor2.r, (arg_374_1.time_ - 0) / var_377_0), Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor2.g, (arg_374_1.time_ - 0) / var_377_0), (Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor2.b, (arg_374_1.time_ - 0) / var_377_0)))
							else
								local var_377_1 = Mathf.Lerp(iter_377_1.color.r, 0.5, (arg_374_1.time_ - 0) / var_377_0)

								iter_377_1.color = Color.New(var_377_1, var_377_1, var_377_1)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1028"]) and arg_374_1.var_.actorSpriteComps1028 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps1028 = nil
			end

			local var_377_2 = arg_374_1.actors_["1086"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1086 == nil then
				arg_374_1.var_.actorSpriteComps1086 = var_377_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_3 = 0.125

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.actorSpriteComps1086 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								iter_377_5.color = Color.New(Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor1.r, (arg_374_1.time_ - 0) / var_377_3), Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor1.g, (arg_374_1.time_ - 0) / var_377_3), (Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor1.b, (arg_374_1.time_ - 0) / var_377_3)))
							else
								local var_377_4 = Mathf.Lerp(iter_377_5.color.r, 1, (arg_374_1.time_ - 0) / var_377_3)

								iter_377_5.color = Color.New(var_377_4, var_377_4, var_377_4)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1086 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_377_7 then
						iter_377_7.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_374_1.var_.actorSpriteComps1086 = nil
			end

			local var_377_5 = 0
			local var_377_6 = 0.75

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_7 = arg_374_1:GetWordFromCfg(416042088)
				local var_377_8 = arg_374_1:FormatText(var_377_7.content)

				arg_374_1.text_.text = var_377_8

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_10 = 30 <= 0 and var_377_6 or var_377_6 * (utf8.len(var_377_8) / 30)

				if (30 <= 0 and var_377_6 or var_377_6 * (utf8.len(var_377_8) / 30)) > 0 and var_377_6 < var_377_10 then
					arg_374_1.talkMaxDuration = var_377_10

					if var_377_10 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_5
					end
				end

				arg_374_1.text_.text = var_377_8
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042088", "story_v_out_416042.awb") ~= 0 then
					local var_377_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042088", "story_v_out_416042.awb") / 1000

					if var_377_11 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_11 + var_377_5
					end

					if var_377_7.prefab_name ~= "" and arg_374_1.actors_[var_377_7.prefab_name] ~= nil then
						local var_377_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_7.prefab_name].transform, "story_v_out_416042", "416042088", "story_v_out_416042.awb")

						arg_374_1:RecordAudio("416042088", var_377_12)
						arg_374_1:RecordAudio("416042088", var_377_12)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_416042", "416042088", "story_v_out_416042.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_416042", "416042088", "story_v_out_416042.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_13 = math.max(var_377_6, arg_374_1.talkMaxDuration)

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_13 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_5) / var_377_13

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_5 + var_377_13 and arg_374_1.time_ < var_377_5 + var_377_13 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play416042089 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 416042089
		arg_378_1.duration_ = 10.73

		local var_378_0 = {
			zh = 8.8,
			ja = 10.733
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
				arg_378_0:Play416042090(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 1

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(416042089)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 40 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 40)

				if (40 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 40)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042089", "story_v_out_416042.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_416042", "416042089", "story_v_out_416042.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_416042", "416042089", "story_v_out_416042.awb")

						arg_378_1:RecordAudio("416042089", var_381_6)
						arg_378_1:RecordAudio("416042089", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_416042", "416042089", "story_v_out_416042.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_416042", "416042089", "story_v_out_416042.awb")
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
	Play416042090 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 416042090
		arg_382_1.duration_ = 3.2

		local var_382_0 = {
			zh = 2.966,
			ja = 3.2
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play416042091(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1028"]) and arg_382_1.var_.actorSpriteComps1028 == nil then
				arg_382_1.var_.actorSpriteComps1028 = arg_382_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_0 = 0.125

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1028"]) then
				if arg_382_1.var_.actorSpriteComps1028 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								iter_385_1.color = Color.New(Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, (arg_382_1.time_ - 0) / var_385_0), Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, (arg_382_1.time_ - 0) / var_385_0), (Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, (arg_382_1.time_ - 0) / var_385_0)))
							else
								local var_385_1 = Mathf.Lerp(iter_385_1.color.r, 1, (arg_382_1.time_ - 0) / var_385_0)

								iter_385_1.color = Color.New(var_385_1, var_385_1, var_385_1)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1028"]) and arg_382_1.var_.actorSpriteComps1028 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_385_3 then
						iter_385_3.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_382_1.var_.actorSpriteComps1028 = nil
			end

			local var_385_2 = arg_382_1.actors_["1086"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps1086 == nil then
				arg_382_1.var_.actorSpriteComps1086 = var_385_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_3 = 0.125

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_3 and not isNil(var_385_2) then
				if arg_382_1.var_.actorSpriteComps1086 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								iter_385_5.color = Color.New(Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, (arg_382_1.time_ - 0) / var_385_3), Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, (arg_382_1.time_ - 0) / var_385_3), (Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, (arg_382_1.time_ - 0) / var_385_3)))
							else
								local var_385_4 = Mathf.Lerp(iter_385_5.color.r, 0.5, (arg_382_1.time_ - 0) / var_385_3)

								iter_385_5.color = Color.New(var_385_4, var_385_4, var_385_4)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= 0 + var_385_3 and arg_382_1.time_ < 0 + var_385_3 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps1086 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_385_7 then
						iter_385_7.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_382_1.var_.actorSpriteComps1086 = nil
			end

			local var_385_5 = arg_382_1.actors_["1028"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1028 = var_385_5.localPosition
				var_385_5.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1028", 4)

				for iter_385_8 = 0, var_385_5.childCount - 1 do
					local var_385_6 = var_385_5:GetChild(iter_385_8)

					if var_385_6.name == "split_2" or not string.find(var_385_6.name, "split") then
						var_385_6.gameObject:SetActive(true)
					else
						var_385_6.gameObject:SetActive(false)
					end
				end
			end

			local var_385_7 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				var_385_5.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_382_1.time_ - 0) / var_385_7)
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				var_385_5.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_385_8 = 0
			local var_385_9 = 0.175

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_8 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_10 = arg_382_1:GetWordFromCfg(416042090)
				local var_385_11 = arg_382_1:FormatText(var_385_10.content)

				arg_382_1.text_.text = var_385_11

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_13 = 7 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_11) / 7)

				if (7 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_11) / 7)) > 0 and var_385_9 < var_385_13 then
					arg_382_1.talkMaxDuration = var_385_13

					if var_385_13 + var_385_8 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_8
					end
				end

				arg_382_1.text_.text = var_385_11
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042090", "story_v_out_416042.awb") ~= 0 then
					local var_385_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042090", "story_v_out_416042.awb") / 1000

					if var_385_14 + var_385_8 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_14 + var_385_8
					end

					if var_385_10.prefab_name ~= "" and arg_382_1.actors_[var_385_10.prefab_name] ~= nil then
						local var_385_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_10.prefab_name].transform, "story_v_out_416042", "416042090", "story_v_out_416042.awb")

						arg_382_1:RecordAudio("416042090", var_385_15)
						arg_382_1:RecordAudio("416042090", var_385_15)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_416042", "416042090", "story_v_out_416042.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_416042", "416042090", "story_v_out_416042.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_16 = math.max(var_385_9, arg_382_1.talkMaxDuration)

			if var_385_8 <= arg_382_1.time_ and arg_382_1.time_ < var_385_8 + var_385_16 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_8) / var_385_16

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_8 + var_385_16 and arg_382_1.time_ < var_385_8 + var_385_16 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play416042091 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 416042091
		arg_386_1.duration_ = 4.53

		local var_386_0 = {
			zh = 3.7,
			ja = 4.533
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
				arg_386_0:Play416042092(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1028"]) and arg_386_1.var_.actorSpriteComps1028 == nil then
				arg_386_1.var_.actorSpriteComps1028 = arg_386_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_0 = 0.125

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1028"]) then
				if arg_386_1.var_.actorSpriteComps1028 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								iter_389_1.color = Color.New(Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor2.r, (arg_386_1.time_ - 0) / var_389_0), Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor2.g, (arg_386_1.time_ - 0) / var_389_0), (Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor2.b, (arg_386_1.time_ - 0) / var_389_0)))
							else
								local var_389_1 = Mathf.Lerp(iter_389_1.color.r, 0.5, (arg_386_1.time_ - 0) / var_389_0)

								iter_389_1.color = Color.New(var_389_1, var_389_1, var_389_1)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1028"]) and arg_386_1.var_.actorSpriteComps1028 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_389_3 then
						iter_389_3.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_386_1.var_.actorSpriteComps1028 = nil
			end

			local var_389_2 = arg_386_1.actors_["1086"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.actorSpriteComps1086 == nil then
				arg_386_1.var_.actorSpriteComps1086 = var_389_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_3 = 0.125

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_3 and not isNil(var_389_2) then
				if arg_386_1.var_.actorSpriteComps1086 then
					for iter_389_4, iter_389_5 in pairs(arg_386_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_389_5 then
							if arg_386_1.isInRecall_ then
								iter_389_5.color = Color.New(Mathf.Lerp(iter_389_5.color.r, arg_386_1.hightColor1.r, (arg_386_1.time_ - 0) / var_389_3), Mathf.Lerp(iter_389_5.color.g, arg_386_1.hightColor1.g, (arg_386_1.time_ - 0) / var_389_3), (Mathf.Lerp(iter_389_5.color.b, arg_386_1.hightColor1.b, (arg_386_1.time_ - 0) / var_389_3)))
							else
								local var_389_4 = Mathf.Lerp(iter_389_5.color.r, 1, (arg_386_1.time_ - 0) / var_389_3)

								iter_389_5.color = Color.New(var_389_4, var_389_4, var_389_4)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_3 and arg_386_1.time_ < 0 + var_389_3 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.actorSpriteComps1086 then
				for iter_389_6, iter_389_7 in pairs(arg_386_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_389_7 then
						iter_389_7.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_386_1.var_.actorSpriteComps1086 = nil
			end

			local var_389_5 = arg_386_1.actors_["1086"].transform

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1086 = var_389_5.localPosition
				var_389_5.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("1086", 2)

				for iter_389_8 = 0, var_389_5.childCount - 1 do
					local var_389_6 = var_389_5:GetChild(iter_389_8)

					if var_389_6.name == "split_6" or not string.find(var_389_6.name, "split") then
						var_389_6.gameObject:SetActive(true)
					else
						var_389_6.gameObject:SetActive(false)
					end
				end
			end

			local var_389_7 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				var_389_5.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_386_1.time_ - 0) / var_389_7)
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				var_389_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_389_8 = 0
			local var_389_9 = 0.3

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_10 = arg_386_1:GetWordFromCfg(416042091)
				local var_389_11 = arg_386_1:FormatText(var_389_10.content)

				arg_386_1.text_.text = var_389_11

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_13 = 12 <= 0 and var_389_9 or var_389_9 * (utf8.len(var_389_11) / 12)

				if (12 <= 0 and var_389_9 or var_389_9 * (utf8.len(var_389_11) / 12)) > 0 and var_389_9 < var_389_13 then
					arg_386_1.talkMaxDuration = var_389_13

					if var_389_13 + var_389_8 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_8
					end
				end

				arg_386_1.text_.text = var_389_11
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042091", "story_v_out_416042.awb") ~= 0 then
					local var_389_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042091", "story_v_out_416042.awb") / 1000

					if var_389_14 + var_389_8 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_14 + var_389_8
					end

					if var_389_10.prefab_name ~= "" and arg_386_1.actors_[var_389_10.prefab_name] ~= nil then
						local var_389_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_10.prefab_name].transform, "story_v_out_416042", "416042091", "story_v_out_416042.awb")

						arg_386_1:RecordAudio("416042091", var_389_15)
						arg_386_1:RecordAudio("416042091", var_389_15)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_416042", "416042091", "story_v_out_416042.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_416042", "416042091", "story_v_out_416042.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_16 = math.max(var_389_9, arg_386_1.talkMaxDuration)

			if var_389_8 <= arg_386_1.time_ and arg_386_1.time_ < var_389_8 + var_389_16 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_8) / var_389_16

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_8 + var_389_16 and arg_386_1.time_ < var_389_8 + var_389_16 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play416042092 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 416042092
		arg_390_1.duration_ = 8.5

		local var_390_0 = {
			zh = 5.033,
			ja = 8.5
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play416042093(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1028"]) and arg_390_1.var_.actorSpriteComps1028 == nil then
				arg_390_1.var_.actorSpriteComps1028 = arg_390_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_0 = 0.125

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1028"]) then
				if arg_390_1.var_.actorSpriteComps1028 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								iter_393_1.color = Color.New(Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, (arg_390_1.time_ - 0) / var_393_0), Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, (arg_390_1.time_ - 0) / var_393_0), (Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, (arg_390_1.time_ - 0) / var_393_0)))
							else
								local var_393_1 = Mathf.Lerp(iter_393_1.color.r, 1, (arg_390_1.time_ - 0) / var_393_0)

								iter_393_1.color = Color.New(var_393_1, var_393_1, var_393_1)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1028"]) and arg_390_1.var_.actorSpriteComps1028 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_393_3 then
						iter_393_3.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps1028 = nil
			end

			local var_393_2 = arg_390_1.actors_["1086"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps1086 == nil then
				arg_390_1.var_.actorSpriteComps1086 = var_393_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_3 = 0.125

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 and not isNil(var_393_2) then
				if arg_390_1.var_.actorSpriteComps1086 then
					for iter_393_4, iter_393_5 in pairs(arg_390_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_393_5 then
							if arg_390_1.isInRecall_ then
								iter_393_5.color = Color.New(Mathf.Lerp(iter_393_5.color.r, arg_390_1.hightColor2.r, (arg_390_1.time_ - 0) / var_393_3), Mathf.Lerp(iter_393_5.color.g, arg_390_1.hightColor2.g, (arg_390_1.time_ - 0) / var_393_3), (Mathf.Lerp(iter_393_5.color.b, arg_390_1.hightColor2.b, (arg_390_1.time_ - 0) / var_393_3)))
							else
								local var_393_4 = Mathf.Lerp(iter_393_5.color.r, 0.5, (arg_390_1.time_ - 0) / var_393_3)

								iter_393_5.color = Color.New(var_393_4, var_393_4, var_393_4)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps1086 then
				for iter_393_6, iter_393_7 in pairs(arg_390_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_393_7 then
						iter_393_7.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_390_1.var_.actorSpriteComps1086 = nil
			end

			local var_393_5 = arg_390_1.actors_["1028"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1028 = var_393_5.localPosition
				var_393_5.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("1028", 4)

				for iter_393_8 = 0, var_393_5.childCount - 1 do
					local var_393_6 = var_393_5:GetChild(iter_393_8)

					if var_393_6.name == "split_2" or not string.find(var_393_6.name, "split") then
						var_393_6.gameObject:SetActive(true)
					else
						var_393_6.gameObject:SetActive(false)
					end
				end
			end

			local var_393_7 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				var_393_5.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_390_1.time_ - 0) / var_393_7)
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				var_393_5.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_393_8 = 0
			local var_393_9 = 0.7

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_10 = arg_390_1:GetWordFromCfg(416042092)
				local var_393_11 = arg_390_1:FormatText(var_393_10.content)

				arg_390_1.text_.text = var_393_11

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_13 = 28 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_11) / 28)

				if (28 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_11) / 28)) > 0 and var_393_9 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_8
					end
				end

				arg_390_1.text_.text = var_393_11
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042092", "story_v_out_416042.awb") ~= 0 then
					local var_393_14 = manager.audio:GetVoiceLength("story_v_out_416042", "416042092", "story_v_out_416042.awb") / 1000

					if var_393_14 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_14 + var_393_8
					end

					if var_393_10.prefab_name ~= "" and arg_390_1.actors_[var_393_10.prefab_name] ~= nil then
						local var_393_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_10.prefab_name].transform, "story_v_out_416042", "416042092", "story_v_out_416042.awb")

						arg_390_1:RecordAudio("416042092", var_393_15)
						arg_390_1:RecordAudio("416042092", var_393_15)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_416042", "416042092", "story_v_out_416042.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_416042", "416042092", "story_v_out_416042.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_16 = math.max(var_393_9, arg_390_1.talkMaxDuration)

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_16 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_8) / var_393_16

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_8 + var_393_16 and arg_390_1.time_ < var_393_8 + var_393_16 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play416042093 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 416042093
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play416042094(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1028"]) and arg_394_1.var_.actorSpriteComps1028 == nil then
				arg_394_1.var_.actorSpriteComps1028 = arg_394_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_0 = 0.125

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1028"]) then
				if arg_394_1.var_.actorSpriteComps1028 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								iter_397_1.color = Color.New(Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor2.r, (arg_394_1.time_ - 0) / var_397_0), Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor2.g, (arg_394_1.time_ - 0) / var_397_0), (Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor2.b, (arg_394_1.time_ - 0) / var_397_0)))
							else
								local var_397_1 = Mathf.Lerp(iter_397_1.color.r, 0.5, (arg_394_1.time_ - 0) / var_397_0)

								iter_397_1.color = Color.New(var_397_1, var_397_1, var_397_1)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1028"]) and arg_394_1.var_.actorSpriteComps1028 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_397_3 then
						iter_397_3.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_394_1.var_.actorSpriteComps1028 = nil
			end

			local var_397_2 = arg_394_1.actors_["1086"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps1086 == nil then
				arg_394_1.var_.actorSpriteComps1086 = var_397_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_3 = 0.125

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.actorSpriteComps1086 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								iter_397_5.color = Color.New(Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, (arg_394_1.time_ - 0) / var_397_3), Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, (arg_394_1.time_ - 0) / var_397_3), (Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, (arg_394_1.time_ - 0) / var_397_3)))
							else
								local var_397_4 = Mathf.Lerp(iter_397_5.color.r, 0.5, (arg_394_1.time_ - 0) / var_397_3)

								iter_397_5.color = Color.New(var_397_4, var_397_4, var_397_4)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps1086 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_397_7 then
						iter_397_7.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_394_1.var_.actorSpriteComps1086 = nil
			end

			local var_397_5 = 0
			local var_397_6 = 1.125

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_7 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(416042093).content)

				arg_394_1.text_.text = var_397_7

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_9 = 45 <= 0 and var_397_6 or var_397_6 * (utf8.len(var_397_7) / 45)

				if (45 <= 0 and var_397_6 or var_397_6 * (utf8.len(var_397_7) / 45)) > 0 and var_397_6 < var_397_9 then
					arg_394_1.talkMaxDuration = var_397_9

					if var_397_9 + var_397_5 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_9 + var_397_5
					end
				end

				arg_394_1.text_.text = var_397_7
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_6, arg_394_1.talkMaxDuration)

			if var_397_5 <= arg_394_1.time_ and arg_394_1.time_ < var_397_5 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_5) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_5 + var_397_10 and arg_394_1.time_ < var_397_5 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play416042094 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 416042094
		arg_398_1.duration_ = 6.7

		local var_398_0 = {
			zh = 6.7,
			ja = 2.066
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play416042095(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1028"]) and arg_398_1.var_.actorSpriteComps1028 == nil then
				arg_398_1.var_.actorSpriteComps1028 = arg_398_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_0 = 0.125

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1028"]) then
				if arg_398_1.var_.actorSpriteComps1028 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								iter_401_1.color = Color.New(Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor1.r, (arg_398_1.time_ - 0) / var_401_0), Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor1.g, (arg_398_1.time_ - 0) / var_401_0), (Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor1.b, (arg_398_1.time_ - 0) / var_401_0)))
							else
								local var_401_1 = Mathf.Lerp(iter_401_1.color.r, 1, (arg_398_1.time_ - 0) / var_401_0)

								iter_401_1.color = Color.New(var_401_1, var_401_1, var_401_1)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1028"]) and arg_398_1.var_.actorSpriteComps1028 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_401_3 then
						iter_401_3.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_398_1.var_.actorSpriteComps1028 = nil
			end

			local var_401_2 = arg_398_1.actors_["1086"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps1086 == nil then
				arg_398_1.var_.actorSpriteComps1086 = var_401_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_3 = 0.125

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_3 and not isNil(var_401_2) then
				if arg_398_1.var_.actorSpriteComps1086 then
					for iter_401_4, iter_401_5 in pairs(arg_398_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_401_5 then
							if arg_398_1.isInRecall_ then
								iter_401_5.color = Color.New(Mathf.Lerp(iter_401_5.color.r, arg_398_1.hightColor2.r, (arg_398_1.time_ - 0) / var_401_3), Mathf.Lerp(iter_401_5.color.g, arg_398_1.hightColor2.g, (arg_398_1.time_ - 0) / var_401_3), (Mathf.Lerp(iter_401_5.color.b, arg_398_1.hightColor2.b, (arg_398_1.time_ - 0) / var_401_3)))
							else
								local var_401_4 = Mathf.Lerp(iter_401_5.color.r, 0.5, (arg_398_1.time_ - 0) / var_401_3)

								iter_401_5.color = Color.New(var_401_4, var_401_4, var_401_4)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_3 and arg_398_1.time_ < 0 + var_401_3 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps1086 then
				for iter_401_6, iter_401_7 in pairs(arg_398_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_401_7 then
						iter_401_7.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_398_1.var_.actorSpriteComps1086 = nil
			end

			local var_401_5 = 0
			local var_401_6 = 0.375

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_5 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_7 = arg_398_1:GetWordFromCfg(416042094)
				local var_401_8 = arg_398_1:FormatText(var_401_7.content)

				arg_398_1.text_.text = var_401_8

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_10 = 15 <= 0 and var_401_6 or var_401_6 * (utf8.len(var_401_8) / 15)

				if (15 <= 0 and var_401_6 or var_401_6 * (utf8.len(var_401_8) / 15)) > 0 and var_401_6 < var_401_10 then
					arg_398_1.talkMaxDuration = var_401_10

					if var_401_10 + var_401_5 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_5
					end
				end

				arg_398_1.text_.text = var_401_8
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042094", "story_v_out_416042.awb") ~= 0 then
					local var_401_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042094", "story_v_out_416042.awb") / 1000

					if var_401_11 + var_401_5 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_11 + var_401_5
					end

					if var_401_7.prefab_name ~= "" and arg_398_1.actors_[var_401_7.prefab_name] ~= nil then
						local var_401_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_7.prefab_name].transform, "story_v_out_416042", "416042094", "story_v_out_416042.awb")

						arg_398_1:RecordAudio("416042094", var_401_12)
						arg_398_1:RecordAudio("416042094", var_401_12)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_416042", "416042094", "story_v_out_416042.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_416042", "416042094", "story_v_out_416042.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_13 = math.max(var_401_6, arg_398_1.talkMaxDuration)

			if var_401_5 <= arg_398_1.time_ and arg_398_1.time_ < var_401_5 + var_401_13 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_5) / var_401_13

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_5 + var_401_13 and arg_398_1.time_ < var_401_5 + var_401_13 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play416042095 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 416042095
		arg_402_1.duration_ = 12.4

		local var_402_0 = {
			zh = 3.833,
			ja = 12.4
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play416042096(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1028"]) and arg_402_1.var_.actorSpriteComps1028 == nil then
				arg_402_1.var_.actorSpriteComps1028 = arg_402_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_0 = 0.125

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1028"]) then
				if arg_402_1.var_.actorSpriteComps1028 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								iter_405_1.color = Color.New(Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor2.r, (arg_402_1.time_ - 0) / var_405_0), Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor2.g, (arg_402_1.time_ - 0) / var_405_0), (Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor2.b, (arg_402_1.time_ - 0) / var_405_0)))
							else
								local var_405_1 = Mathf.Lerp(iter_405_1.color.r, 0.5, (arg_402_1.time_ - 0) / var_405_0)

								iter_405_1.color = Color.New(var_405_1, var_405_1, var_405_1)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1028"]) and arg_402_1.var_.actorSpriteComps1028 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_405_3 then
						iter_405_3.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_402_1.var_.actorSpriteComps1028 = nil
			end

			local var_405_2 = arg_402_1.actors_["1086"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_2) and arg_402_1.var_.actorSpriteComps1086 == nil then
				arg_402_1.var_.actorSpriteComps1086 = var_405_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_3 = 0.125

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_3 and not isNil(var_405_2) then
				if arg_402_1.var_.actorSpriteComps1086 then
					for iter_405_4, iter_405_5 in pairs(arg_402_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_405_5 then
							if arg_402_1.isInRecall_ then
								iter_405_5.color = Color.New(Mathf.Lerp(iter_405_5.color.r, arg_402_1.hightColor1.r, (arg_402_1.time_ - 0) / var_405_3), Mathf.Lerp(iter_405_5.color.g, arg_402_1.hightColor1.g, (arg_402_1.time_ - 0) / var_405_3), (Mathf.Lerp(iter_405_5.color.b, arg_402_1.hightColor1.b, (arg_402_1.time_ - 0) / var_405_3)))
							else
								local var_405_4 = Mathf.Lerp(iter_405_5.color.r, 1, (arg_402_1.time_ - 0) / var_405_3)

								iter_405_5.color = Color.New(var_405_4, var_405_4, var_405_4)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_3 and arg_402_1.time_ < 0 + var_405_3 + arg_405_0 and not isNil(var_405_2) and arg_402_1.var_.actorSpriteComps1086 then
				for iter_405_6, iter_405_7 in pairs(arg_402_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_405_7 then
						iter_405_7.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_402_1.var_.actorSpriteComps1086 = nil
			end

			local var_405_5 = 0
			local var_405_6 = 0.425

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_5 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_7 = arg_402_1:GetWordFromCfg(416042095)
				local var_405_8 = arg_402_1:FormatText(var_405_7.content)

				arg_402_1.text_.text = var_405_8

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_10 = 17 <= 0 and var_405_6 or var_405_6 * (utf8.len(var_405_8) / 17)

				if (17 <= 0 and var_405_6 or var_405_6 * (utf8.len(var_405_8) / 17)) > 0 and var_405_6 < var_405_10 then
					arg_402_1.talkMaxDuration = var_405_10

					if var_405_10 + var_405_5 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_5
					end
				end

				arg_402_1.text_.text = var_405_8
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042095", "story_v_out_416042.awb") ~= 0 then
					local var_405_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042095", "story_v_out_416042.awb") / 1000

					if var_405_11 + var_405_5 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_11 + var_405_5
					end

					if var_405_7.prefab_name ~= "" and arg_402_1.actors_[var_405_7.prefab_name] ~= nil then
						local var_405_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_7.prefab_name].transform, "story_v_out_416042", "416042095", "story_v_out_416042.awb")

						arg_402_1:RecordAudio("416042095", var_405_12)
						arg_402_1:RecordAudio("416042095", var_405_12)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_416042", "416042095", "story_v_out_416042.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_416042", "416042095", "story_v_out_416042.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_13 = math.max(var_405_6, arg_402_1.talkMaxDuration)

			if var_405_5 <= arg_402_1.time_ and arg_402_1.time_ < var_405_5 + var_405_13 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_5) / var_405_13

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_5 + var_405_13 and arg_402_1.time_ < var_405_5 + var_405_13 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play416042096 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416042096
		arg_406_1.duration_ = 4.2

		local var_406_0 = {
			zh = 3.366,
			ja = 4.2
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
				arg_406_0:Play416042097(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1028"]) and arg_406_1.var_.actorSpriteComps1028 == nil then
				arg_406_1.var_.actorSpriteComps1028 = arg_406_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_0 = 0.125

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1028"]) then
				if arg_406_1.var_.actorSpriteComps1028 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								iter_409_1.color = Color.New(Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor1.r, (arg_406_1.time_ - 0) / var_409_0), Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor1.g, (arg_406_1.time_ - 0) / var_409_0), (Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor1.b, (arg_406_1.time_ - 0) / var_409_0)))
							else
								local var_409_1 = Mathf.Lerp(iter_409_1.color.r, 1, (arg_406_1.time_ - 0) / var_409_0)

								iter_409_1.color = Color.New(var_409_1, var_409_1, var_409_1)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1028"]) and arg_406_1.var_.actorSpriteComps1028 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_409_3 then
						iter_409_3.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_406_1.var_.actorSpriteComps1028 = nil
			end

			local var_409_2 = arg_406_1.actors_["1086"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.actorSpriteComps1086 == nil then
				arg_406_1.var_.actorSpriteComps1086 = var_409_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_3 = 0.125

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 and not isNil(var_409_2) then
				if arg_406_1.var_.actorSpriteComps1086 then
					for iter_409_4, iter_409_5 in pairs(arg_406_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_409_5 then
							if arg_406_1.isInRecall_ then
								iter_409_5.color = Color.New(Mathf.Lerp(iter_409_5.color.r, arg_406_1.hightColor2.r, (arg_406_1.time_ - 0) / var_409_3), Mathf.Lerp(iter_409_5.color.g, arg_406_1.hightColor2.g, (arg_406_1.time_ - 0) / var_409_3), (Mathf.Lerp(iter_409_5.color.b, arg_406_1.hightColor2.b, (arg_406_1.time_ - 0) / var_409_3)))
							else
								local var_409_4 = Mathf.Lerp(iter_409_5.color.r, 0.5, (arg_406_1.time_ - 0) / var_409_3)

								iter_409_5.color = Color.New(var_409_4, var_409_4, var_409_4)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.actorSpriteComps1086 then
				for iter_409_6, iter_409_7 in pairs(arg_406_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_409_7 then
						iter_409_7.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_406_1.var_.actorSpriteComps1086 = nil
			end

			local var_409_5 = 0
			local var_409_6 = 0.375

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_7 = arg_406_1:GetWordFromCfg(416042096)
				local var_409_8 = arg_406_1:FormatText(var_409_7.content)

				arg_406_1.text_.text = var_409_8

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_10 = 15 <= 0 and var_409_6 or var_409_6 * (utf8.len(var_409_8) / 15)

				if (15 <= 0 and var_409_6 or var_409_6 * (utf8.len(var_409_8) / 15)) > 0 and var_409_6 < var_409_10 then
					arg_406_1.talkMaxDuration = var_409_10

					if var_409_10 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_5
					end
				end

				arg_406_1.text_.text = var_409_8
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416042", "416042096", "story_v_out_416042.awb") ~= 0 then
					local var_409_11 = manager.audio:GetVoiceLength("story_v_out_416042", "416042096", "story_v_out_416042.awb") / 1000

					if var_409_11 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_11 + var_409_5
					end

					if var_409_7.prefab_name ~= "" and arg_406_1.actors_[var_409_7.prefab_name] ~= nil then
						local var_409_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_7.prefab_name].transform, "story_v_out_416042", "416042096", "story_v_out_416042.awb")

						arg_406_1:RecordAudio("416042096", var_409_12)
						arg_406_1:RecordAudio("416042096", var_409_12)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_416042", "416042096", "story_v_out_416042.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_416042", "416042096", "story_v_out_416042.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_13 = math.max(var_409_6, arg_406_1.talkMaxDuration)

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_13 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_5) / var_409_13

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_5 + var_409_13 and arg_406_1.time_ < var_409_5 + var_409_13 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play416042097 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 416042097
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
			arg_410_1.auto_ = false
		end

		function arg_410_1.playNext_(arg_412_0)
			arg_410_1.onStoryFinished_()
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1028 = arg_410_1.actors_["1028"].transform.localPosition
				arg_410_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1028", 7)

				for iter_413_0 = 0, arg_410_1.actors_["1028"].transform.childCount - 1 do
					local var_413_0 = arg_410_1.actors_["1028"].transform:GetChild(iter_413_0)

					if var_413_0.name == "" or not string.find(var_413_0.name, "split") then
						var_413_0.gameObject:SetActive(true)
					else
						var_413_0.gameObject:SetActive(false)
					end
				end
			end

			local var_413_1 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_1 then
				arg_410_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_410_1.time_ - 0) / var_413_1)
			end

			if arg_410_1.time_ >= 0 + var_413_1 and arg_410_1.time_ < 0 + var_413_1 + arg_413_0 then
				arg_410_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_413_2 = arg_410_1.actors_["1086"].transform

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1086 = var_413_2.localPosition
				var_413_2.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1086", 7)

				for iter_413_1 = 0, var_413_2.childCount - 1 do
					local var_413_3 = var_413_2:GetChild(iter_413_1)

					if var_413_3.name == "" or not string.find(var_413_3.name, "split") then
						var_413_3.gameObject:SetActive(true)
					else
						var_413_3.gameObject:SetActive(false)
					end
				end
			end

			local var_413_4 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				var_413_2.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_410_1.time_ - 0) / var_413_4)
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				var_413_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_413_5 = 0
			local var_413_6 = 1.175

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_5 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_7 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(416042097).content)

				arg_410_1.text_.text = var_413_7

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_9 = 47 <= 0 and var_413_6 or var_413_6 * (utf8.len(var_413_7) / 47)

				if (47 <= 0 and var_413_6 or var_413_6 * (utf8.len(var_413_7) / 47)) > 0 and var_413_6 < var_413_9 then
					arg_410_1.talkMaxDuration = var_413_9

					if var_413_9 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_5
					end
				end

				arg_410_1.text_.text = var_413_7
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_6, arg_410_1.talkMaxDuration)

			if var_413_5 <= arg_410_1.time_ and arg_410_1.time_ < var_413_5 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_5) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_5 + var_413_10 and arg_410_1.time_ < var_413_5 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/SS1602",
		"TextureConfig/Background/ST0106"
	},
	voices = {
		"story_v_out_416042.awb"
	}
}
