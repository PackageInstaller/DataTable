return {
	Play416111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416111001
		arg_1_1.duration_ = 14.3

		local var_1_0 = {
			zh = 11.1996666666667,
			ja = 14.2996666666667
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
				arg_1_0:Play416111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.SS1604 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1604")
				var_4_0.name = "SS1604"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.SS1604 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.SS1604

				arg_1_1.bgs_.SS1604.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SS1604" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.66666666666667

			if 2.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = arg_1_1.bgs_.SS1604.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS1604 = var_4_9.localPosition
			end

			local var_4_10 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 then
				var_4_9.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS1604, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0) / var_4_10)
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 then
				var_4_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_11 = arg_1_1.bgs_.SS1604.transform

			if 0.0339999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 0.0339999999999999 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS1604 = var_4_11.localPosition
			end

			local var_4_12 = 2.29933333333333

			if 0.0339999999999999 <= arg_1_1.time_ and arg_1_1.time_ < 0.0339999999999999 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS1604, Vector3.New(0, 1, 7), (arg_1_1.time_ - 0.0339999999999999) / var_4_12)
			end

			if arg_1_1.time_ >= 0.0339999999999999 + var_4_12 and arg_1_1.time_ < 0.0339999999999999 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, 1, 7)
			end

			if 0.167333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.167333333333333 + arg_4_0 then
				local var_4_13 = arg_1_1.var_.effect1101

				if not arg_1_1.var_.effect1101 then
					var_4_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), manager.ui.mainCamera.transform)
					var_4_13.name = "1101"
					arg_1_1.var_.effect1101 = var_4_13
				else
					var_4_13.transform:SetParent(var_4_9000)
				end

				var_4_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			local var_4_21 = 2.66666666666667
			local var_4_22 = 0.55

			if 2.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(416111001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 22 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 22)

				if (22 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 22)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111001", "story_v_out_416111.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_416111", "416111001", "story_v_out_416111.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_416111", "416111001", "story_v_out_416111.awb")

						arg_1_1:RecordAudio("416111001", var_4_29)
						arg_1_1:RecordAudio("416111001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416111", "416111001", "story_v_out_416111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416111", "416111001", "story_v_out_416111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.29933333333333,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416111002
		arg_9_1.duration_ = 4.9

		local var_9_0 = {
			zh = 4.9,
			ja = 3.433
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
				arg_9_0:Play416111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.5

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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(416111002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 20 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 20)

				if (20 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 20)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111002", "story_v_out_416111.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111002", "story_v_out_416111.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_416111", "416111002", "story_v_out_416111.awb")

						arg_9_1:RecordAudio("416111002", var_12_6)
						arg_9_1:RecordAudio("416111002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416111", "416111002", "story_v_out_416111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416111", "416111002", "story_v_out_416111.awb")
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
	Play416111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416111003
		arg_13_1.duration_ = 5.5

		local var_13_0 = {
			zh = 5.5,
			ja = 3.333
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
				arg_13_0:Play416111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(416111003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)

				if (21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111003", "story_v_out_416111.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111003", "story_v_out_416111.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_416111", "416111003", "story_v_out_416111.awb")

						arg_13_1:RecordAudio("416111003", var_16_6)
						arg_13_1:RecordAudio("416111003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416111", "416111003", "story_v_out_416111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416111", "416111003", "story_v_out_416111.awb")
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
	Play416111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416111004
		arg_17_1.duration_ = 6.57

		local var_17_0 = {
			zh = 5.933,
			ja = 6.566
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
				arg_17_0:Play416111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1148"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "1148"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["1148"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["1148"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1148 == nil then
				arg_17_1.var_.actorSpriteComps1148 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1148 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								iter_20_3.color = Color.New(Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_3.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_3.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1148 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_20_5 then
						iter_20_5.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1148 = nil
			end

			local var_20_5 = "10109"

			if arg_17_1.actors_["10109"] == nil then
				local var_20_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_20_6) then
					local var_20_7 = Object.Instantiate(var_20_6, arg_17_1.canvasGo_.transform)

					var_20_7.transform:SetSiblingIndex(1)

					var_20_7.name = var_20_5
					var_20_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_5] = var_20_7

					if arg_17_1.isInRecall_ then
						for iter_20_6, iter_20_7 in ipairs((var_20_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_8 = arg_17_1.actors_["10109"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10109 == nil then
				arg_17_1.var_.actorSpriteComps10109 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 and not isNil(var_20_8) then
				if arg_17_1.var_.actorSpriteComps10109 then
					for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_20_9 then
							if arg_17_1.isInRecall_ then
								iter_20_9.color = Color.New(Mathf.Lerp(iter_20_9.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_9), Mathf.Lerp(iter_20_9.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_9), (Mathf.Lerp(iter_20_9.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_9)))
							else
								local var_20_10 = Mathf.Lerp(iter_20_9.color.r, 1, (arg_17_1.time_ - 0) / var_20_9)

								iter_20_9.color = Color.New(var_20_10, var_20_10, var_20_10)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10109 then
				for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_20_11 then
						iter_20_11.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10109 = nil
			end

			local var_20_11 = 0
			local var_20_12 = 0.675

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(416111004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 27 <= 0 and var_20_12 or var_20_12 * (utf8.len(var_20_14) / 27)

				if (27 <= 0 and var_20_12 or var_20_12 * (utf8.len(var_20_14) / 27)) > 0 and var_20_12 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16

					if var_20_16 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111004", "story_v_out_416111.awb") ~= 0 then
					local var_20_17 = manager.audio:GetVoiceLength("story_v_out_416111", "416111004", "story_v_out_416111.awb") / 1000

					if var_20_17 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_11
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_416111", "416111004", "story_v_out_416111.awb")

						arg_17_1:RecordAudio("416111004", var_20_18)
						arg_17_1:RecordAudio("416111004", var_20_18)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416111", "416111004", "story_v_out_416111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416111", "416111004", "story_v_out_416111.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_19 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_19

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_19 and arg_17_1.time_ < var_20_11 + var_20_19 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416111005
		arg_21_1.duration_ = 6.03

		local var_21_0 = {
			zh = 6.033,
			ja = 5
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
				arg_21_0:Play416111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1148"]) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = arg_21_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1148"]) then
				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1148"]) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_2 = arg_21_1.actors_["10109"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10109 == nil then
				arg_21_1.var_.actorSpriteComps10109 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10109 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10109 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10109 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_7 = arg_21_1:GetWordFromCfg(416111005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 14 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 14)

				if (14 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 14)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111005", "story_v_out_416111.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_416111", "416111005", "story_v_out_416111.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_416111", "416111005", "story_v_out_416111.awb")

						arg_21_1:RecordAudio("416111005", var_24_12)
						arg_21_1:RecordAudio("416111005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416111", "416111005", "story_v_out_416111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416111", "416111005", "story_v_out_416111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416111006
		arg_25_1.duration_ = 6

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play416111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = arg_25_1.actors_["1148"].transform.localPosition
				arg_25_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 7)

				for iter_28_0 = 0, arg_25_1.actors_["1148"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1148"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_2 = arg_25_1.actors_["10109"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10109 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				for iter_28_1 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_1)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10109, Vector3.New(0, 2000, 0), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, 2000, 0)
			end

			local var_28_5 = arg_25_1.bgs_.SS1604.transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS1604 = var_28_5.localPosition
			end

			local var_28_6 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS1604, Vector3.New(0, 1, 7), (arg_25_1.time_ - 0) / var_28_6)
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, 1, 7)
			end

			local var_28_7 = arg_25_1.bgs_.SS1604.transform

			if 0.0339999999999999 < arg_25_1.time_ and arg_25_1.time_ <= 0.0339999999999999 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS1604 = var_28_7.localPosition
			end

			local var_28_8 = 0.966

			if 0.0339999999999999 <= arg_25_1.time_ and arg_25_1.time_ < 0.0339999999999999 + var_28_8 then
				var_28_7.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS1604, Vector3.New(0, 1, 5), (arg_25_1.time_ - 0.0339999999999999) / var_28_8)
			end

			if arg_25_1.time_ >= 0.0339999999999999 + var_28_8 and arg_25_1.time_ < 0.0339999999999999 + var_28_8 + arg_28_0 then
				var_28_7.localPosition = Vector3.New(0, 1, 5)
			end

			if 0.9 < arg_25_1.time_ and arg_25_1.time_ <= 0.9 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_10 = 1
			local var_28_11 = 1.2

			if 1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_12 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_12:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(416111006).content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 48 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 48)

				if (48 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 48)) > 0 and var_28_11 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15
					var_28_10 = var_28_10 + 0.3

					if var_28_15 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = var_28_10 + 0.3
			local var_28_17 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
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
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play416111007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416111007
		arg_31_1.duration_ = 9.27

		local var_31_0 = {
			zh = 9.266,
			ja = 5.533
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
				arg_31_0:Play416111008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.6

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:GetWordFromCfg(416111007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 24 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 24)

				if (24 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 24)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111007", "story_v_out_416111.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111007", "story_v_out_416111.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_416111", "416111007", "story_v_out_416111.awb")

						arg_31_1:RecordAudio("416111007", var_34_6)
						arg_31_1:RecordAudio("416111007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_416111", "416111007", "story_v_out_416111.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_416111", "416111007", "story_v_out_416111.awb")
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
	Play416111008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 416111008
		arg_35_1.duration_ = 5.83

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play416111009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_9003
			local var_38_9002
			local var_38_9001
			local var_38_9000

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_38_0 = 0.0666666666666667

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				local var_38_1, var_38_2 = math.modf((arg_35_1.time_ - 0) / 0.033)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_38_2 * 0.3, var_38_2 * 0.3, var_38_2 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				manager.ui.mainCamera.transform.localPosition = arg_35_1.var_.shakeOldPos
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_3 = arg_35_1.var_.effect1102

				if not arg_35_1.var_.effect1102 then
					var_38_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_38_3.name = "1102"
					arg_35_1.var_.effect1102 = var_38_3
				else
					var_38_3.transform:SetParent(var_38_9003)
				end

				var_38_3.transform.localPosition = Vector3.New(0.06, 0, 1)
				var_38_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.33333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 1.33333333333333 + arg_38_0 then
				if arg_35_1.var_.effect1102 then
					Object.Destroy(arg_35_1.var_.effect1102)

					arg_35_1.var_.effect1102 = nil
				end
			end

			local var_38_6 = manager.ui.mainCamera.transform

			if 0.133333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 0.133333333333333 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_6.localPosition
			end

			local var_38_7 = 0.0666666666666667

			if 0.133333333333333 <= arg_35_1.time_ and arg_35_1.time_ < 0.133333333333333 + var_38_7 then
				local var_38_8, var_38_9 = math.modf((arg_35_1.time_ - 0.133333333333333) / 0.033)

				var_38_6.localPosition = Vector3.New(var_38_9 * 0.3, var_38_9 * 0.3, var_38_9 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= 0.133333333333333 + var_38_7 and arg_35_1.time_ < 0.133333333333333 + var_38_7 + arg_38_0 then
				var_38_6.localPosition = arg_35_1.var_.shakeOldPos
			end

			if 0.133333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 0.133333333333333 + arg_38_0 then
				local var_38_10 = arg_35_1.var_.effect1103

				if not arg_35_1.var_.effect1103 then
					var_38_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_38_10.name = "1103"
					arg_35_1.var_.effect1103 = var_38_10
				else
					var_38_10.transform:SetParent(var_38_9002)
				end

				var_38_10.transform.localPosition = Vector3.New(-0.82, -0.4, 1.1)
				var_38_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.33333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 1.33333333333333 + arg_38_0 then
				if arg_35_1.var_.effect1103 then
					Object.Destroy(arg_35_1.var_.effect1103)

					arg_35_1.var_.effect1103 = nil
				end
			end

			local var_38_13 = manager.ui.mainCamera.transform

			if 0.266666666666667 < arg_35_1.time_ and arg_35_1.time_ <= 0.266666666666667 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_13.localPosition
			end

			local var_38_14 = 0.0666666666666667

			if 0.266666666666667 <= arg_35_1.time_ and arg_35_1.time_ < 0.266666666666667 + var_38_14 then
				local var_38_15, var_38_16 = math.modf((arg_35_1.time_ - 0.266666666666667) / 0.033)

				var_38_13.localPosition = Vector3.New(var_38_16 * 0.3, var_38_16 * 0.3, var_38_16 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= 0.266666666666667 + var_38_14 and arg_35_1.time_ < 0.266666666666667 + var_38_14 + arg_38_0 then
				var_38_13.localPosition = arg_35_1.var_.shakeOldPos
			end

			if 0.266666666666667 < arg_35_1.time_ and arg_35_1.time_ <= 0.266666666666667 + arg_38_0 then
				local var_38_17 = arg_35_1.var_.effect1104

				if not arg_35_1.var_.effect1104 then
					var_38_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_38_17.name = "1104"
					arg_35_1.var_.effect1104 = var_38_17
				else
					var_38_17.transform:SetParent(var_38_9001)
				end

				var_38_17.transform.localPosition = Vector3.New(0.05, 0.21, 1)
				var_38_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.33333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 1.33333333333333 + arg_38_0 then
				if arg_35_1.var_.effect1104 then
					Object.Destroy(arg_35_1.var_.effect1104)

					arg_35_1.var_.effect1104 = nil
				end
			end

			local var_38_20 = manager.ui.mainCamera.transform

			if 0.4 < arg_35_1.time_ and arg_35_1.time_ <= 0.4 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_20.localPosition
			end

			local var_38_21 = 0.0666666666666667

			if 0.4 <= arg_35_1.time_ and arg_35_1.time_ < 0.4 + var_38_21 then
				local var_38_22, var_38_23 = math.modf((arg_35_1.time_ - 0.4) / 0.033)

				var_38_20.localPosition = Vector3.New(var_38_23 * 0.3, var_38_23 * 0.3, var_38_23 * 0.3) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= 0.4 + var_38_21 and arg_35_1.time_ < 0.4 + var_38_21 + arg_38_0 then
				var_38_20.localPosition = arg_35_1.var_.shakeOldPos
			end

			if 0.4 < arg_35_1.time_ and arg_35_1.time_ <= 0.4 + arg_38_0 then
				local var_38_24 = arg_35_1.var_.effect1105

				if not arg_35_1.var_.effect1105 then
					var_38_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_38_24.name = "1105"
					arg_35_1.var_.effect1105 = var_38_24
				else
					var_38_24.transform:SetParent(var_38_9000)
				end

				var_38_24.transform.localPosition = Vector3.New(0.36, -0.37, 1.5)
				var_38_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.33333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 1.33333333333333 + arg_38_0 then
				if arg_35_1.var_.effect1105 then
					Object.Destroy(arg_35_1.var_.effect1105)

					arg_35_1.var_.effect1105 = nil
				end
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			if 0.5 < arg_35_1.time_ and arg_35_1.time_ <= 0.5 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_29 = 0.833333333333333
			local var_38_30 = 1.3

			if 0.833333333333333 < arg_35_1.time_ and arg_35_1.time_ <= var_38_29 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_31 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_31:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_32 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(416111008).content)

				arg_35_1.text_.text = var_38_32

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_34 = 52 <= 0 and var_38_30 or var_38_30 * (utf8.len(var_38_32) / 52)

				if (52 <= 0 and var_38_30 or var_38_30 * (utf8.len(var_38_32) / 52)) > 0 and var_38_30 < var_38_34 then
					arg_35_1.talkMaxDuration = var_38_34
					var_38_29 = var_38_29 + 0.3

					if var_38_34 + var_38_29 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_34 + var_38_29
					end
				end

				arg_35_1.text_.text = var_38_32
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_35 = var_38_29 + 0.3
			local var_38_36 = math.max(var_38_30, arg_35_1.talkMaxDuration)

			if var_38_29 + 0.3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_35 + var_38_36 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_35) / var_38_36

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_35 + var_38_36 and arg_35_1.time_ < var_38_35 + var_38_36 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play416111009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416111009
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play416111010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(416111009).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 66 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 66)

				if (66 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 66)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416111010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416111010
		arg_45_1.duration_ = 5.37

		local var_45_0 = {
			zh = 4.333,
			ja = 5.366
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
				arg_45_0:Play416111011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(416111010)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 14 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 14)

				if (14 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 14)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111010", "story_v_out_416111.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111010", "story_v_out_416111.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_416111", "416111010", "story_v_out_416111.awb")

						arg_45_1:RecordAudio("416111010", var_48_6)
						arg_45_1:RecordAudio("416111010", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416111", "416111010", "story_v_out_416111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416111", "416111010", "story_v_out_416111.awb")
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
	Play416111011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416111011
		arg_49_1.duration_ = 4.5

		local var_49_0 = {
			zh = 4.5,
			ja = 3.3
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
				arg_49_0:Play416111012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_4")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(416111011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 24 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 24)

				if (24 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 24)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111011", "story_v_out_416111.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111011", "story_v_out_416111.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_416111", "416111011", "story_v_out_416111.awb")

						arg_49_1:RecordAudio("416111011", var_52_6)
						arg_49_1:RecordAudio("416111011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416111", "416111011", "story_v_out_416111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416111", "416111011", "story_v_out_416111.awb")
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
	Play416111012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416111012
		arg_53_1.duration_ = 3.97

		local var_53_0 = {
			zh = 3.833,
			ja = 3.966
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
				arg_53_0:Play416111013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(416111012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 19 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 19)

				if (19 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 19)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111012", "story_v_out_416111.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111012", "story_v_out_416111.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_416111", "416111012", "story_v_out_416111.awb")

						arg_53_1:RecordAudio("416111012", var_56_6)
						arg_53_1:RecordAudio("416111012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416111", "416111012", "story_v_out_416111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416111", "416111012", "story_v_out_416111.awb")
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
	Play416111013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416111013
		arg_57_1.duration_ = 6.13

		local var_57_0 = {
			zh = 3.733,
			ja = 6.133
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
				arg_57_0:Play416111014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(416111013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 20 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 20)

				if (20 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 20)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111013", "story_v_out_416111.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111013", "story_v_out_416111.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_416111", "416111013", "story_v_out_416111.awb")

						arg_57_1:RecordAudio("416111013", var_60_6)
						arg_57_1:RecordAudio("416111013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416111", "416111013", "story_v_out_416111.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416111", "416111013", "story_v_out_416111.awb")
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
	Play416111014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416111014
		arg_61_1.duration_ = 5.77

		local var_61_0 = {
			zh = 3.5,
			ja = 5.766
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
				arg_61_0:Play416111015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(416111014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 10 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 10)

				if (10 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 10)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111014", "story_v_out_416111.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111014", "story_v_out_416111.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_416111", "416111014", "story_v_out_416111.awb")

						arg_61_1:RecordAudio("416111014", var_64_6)
						arg_61_1:RecordAudio("416111014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416111", "416111014", "story_v_out_416111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416111", "416111014", "story_v_out_416111.awb")
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
	Play416111015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416111015
		arg_65_1.duration_ = 3.07

		local var_65_0 = {
			zh = 2.766,
			ja = 3.066
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
				arg_65_0:Play416111016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.225

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_3")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(416111015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 9 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 9)

				if (9 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 9)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111015", "story_v_out_416111.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111015", "story_v_out_416111.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_416111", "416111015", "story_v_out_416111.awb")

						arg_65_1:RecordAudio("416111015", var_68_6)
						arg_65_1:RecordAudio("416111015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416111", "416111015", "story_v_out_416111.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416111", "416111015", "story_v_out_416111.awb")
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
	Play416111016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416111016
		arg_69_1.duration_ = 5.67

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play416111017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_0 = arg_69_1.var_.effect1106

				if not arg_69_1.var_.effect1106 then
					var_72_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_72_0.name = "1106"
					arg_69_1.var_.effect1106 = var_72_0
				else
					var_72_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_72_0.transform.localPosition = Vector3.New(-0.09, -0.31, 0)
				var_72_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.03333333333333 < arg_69_1.time_ and arg_69_1.time_ <= 2.03333333333333 + arg_72_0 then
				if arg_69_1.var_.effect1106 then
					Object.Destroy(arg_69_1.var_.effect1106)

					arg_69_1.var_.effect1106 = nil
				end
			end

			local var_72_3 = manager.ui.mainCamera.transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.shakeOldPos = var_72_3.localPosition
			end

			local var_72_4 = 0.6

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				local var_72_5, var_72_6 = math.modf((arg_69_1.time_ - 0) / 0.066)

				var_72_3.localPosition = Vector3.New(var_72_6 * 0.13, var_72_6 * 0.13, var_72_6 * 0.13) + arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = arg_69_1.var_.shakeOldPos
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_131", "se_story_131__explosion", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_8 = 0.666666666666667
			local var_72_9 = 1.6

			if 0.666666666666667 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_10 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_10:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(416111016).content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 64 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 64)

				if (64 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 64)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13
					var_72_8 = var_72_8 + 0.3

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = var_72_8 + 0.3
			local var_72_15 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play416111017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416111017
		arg_75_1.duration_ = 7.53

		local var_75_0 = {
			zh = 6.266,
			ja = 7.533
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
				arg_75_0:Play416111018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.425

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(416111017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 17 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 17)

				if (17 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 17)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111017", "story_v_out_416111.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111017", "story_v_out_416111.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_416111", "416111017", "story_v_out_416111.awb")

						arg_75_1:RecordAudio("416111017", var_78_6)
						arg_75_1:RecordAudio("416111017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416111", "416111017", "story_v_out_416111.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416111", "416111017", "story_v_out_416111.awb")
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
	Play416111018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416111018
		arg_79_1.duration_ = 9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416111019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 4 < arg_79_1.time_ and arg_79_1.time_ <= 4 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= 4 + 0.3 and arg_79_1.time_ < 4 + 0.3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_0 = "I13f"

			if arg_79_1.bgs_.I13f == nil then
				local var_82_1 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_82_0)
				var_82_1.name = var_82_0
				var_82_1.transform.parent = arg_79_1.stage_.transform
				var_82_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_[var_82_0] = var_82_1
			end

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= 2 + arg_82_0 then
				local var_82_2 = arg_79_1.bgs_.I13f

				arg_79_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_3 = var_82_2:GetComponent("SpriteRenderer")

				if var_82_3 and var_82_3.sprite then
					local var_82_4 = 2 * (var_82_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_2.transform.localScale = Vector3.New(var_82_4 / var_82_3.sprite.bounds.size.y < var_82_4 * manager.ui.mainCameraCom_.aspect / var_82_3.sprite.bounds.size.x and var_82_4 * manager.ui.mainCameraCom_.aspect / var_82_3.sprite.bounds.size.x or var_82_4 / var_82_3.sprite.bounds.size.y, var_82_4 / var_82_3.sprite.bounds.size.y < var_82_4 * manager.ui.mainCameraCom_.aspect / var_82_3.sprite.bounds.size.x and var_82_4 * manager.ui.mainCameraCom_.aspect / var_82_3.sprite.bounds.size.x or var_82_4 / var_82_3.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "I13f" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_5 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_6 = 2

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 then
				local var_82_7 = Color.New(0, 0, 0)

				var_82_7.a = Mathf.Lerp(0, 1, (arg_79_1.time_ - var_82_5) / var_82_6)
				arg_79_1.mask_.color = var_82_7
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 then
				local var_82_8 = Color.New(0, 0, 0)

				var_82_8.a = 1
				arg_79_1.mask_.color = var_82_8
			end

			local var_82_9 = 2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_10 = 2

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 then
				local var_82_11 = Color.New(0, 0, 0)

				var_82_11.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_9) / var_82_10)
				arg_79_1.mask_.color = var_82_11
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 then
				local var_82_12 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_12.a = 0
				arg_79_1.mask_.color = var_82_12
			end

			if 1.83333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 1.83333333333333 + arg_82_0 then
				if arg_79_1.var_.effect1101 then
					Object.Destroy(arg_79_1.var_.effect1101)

					arg_79_1.var_.effect1101 = nil
				end
			end

			if 3.8 < arg_79_1.time_ and arg_79_1.time_ <= 3.8 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_shield", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_15 = 4
			local var_82_16 = 1.575

			if 4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_17 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_17:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_18 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(416111018).content)

				arg_79_1.text_.text = var_82_18

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_20 = 63 <= 0 and var_82_16 or var_82_16 * (utf8.len(var_82_18) / 63)

				if (63 <= 0 and var_82_16 or var_82_16 * (utf8.len(var_82_18) / 63)) > 0 and var_82_16 < var_82_20 then
					arg_79_1.talkMaxDuration = var_82_20
					var_82_15 = var_82_15 + 0.3

					if var_82_20 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_18
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_21 = var_82_15 + 0.3
			local var_82_22 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_22 and arg_79_1.time_ < var_82_21 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play416111019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416111019
		arg_85_1.duration_ = 8.3

		local var_85_0 = {
			zh = 5.266,
			ja = 8.3
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
				arg_85_0:Play416111020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10109 = arg_85_1.actors_["10109"].transform.localPosition
				arg_85_1.actors_["10109"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10109", 3)

				for iter_88_0 = 0, arg_85_1.actors_["10109"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10109"].transform:GetChild(iter_88_0)

					if var_88_0.name == "" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10109"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10109"].transform.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_88_2 = arg_85_1.actors_["10109"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10109 == nil then
				arg_85_1.var_.actorSpriteComps10109 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10109 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								iter_88_2.color = Color.New(Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_2.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_2.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10109 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10109 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(416111019)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 17 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 17)

				if (17 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 17)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111019", "story_v_out_416111.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_416111", "416111019", "story_v_out_416111.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416111", "416111019", "story_v_out_416111.awb")

						arg_85_1:RecordAudio("416111019", var_88_12)
						arg_85_1:RecordAudio("416111019", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416111", "416111019", "story_v_out_416111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416111", "416111019", "story_v_out_416111.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
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
	Play416111020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416111020
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			zh = 4.4,
			ja = 3.7
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
				arg_89_0:Play416111021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10109 = arg_89_1.actors_["10109"].transform.localPosition
				arg_89_1.actors_["10109"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10109", 2)

				for iter_92_0 = 0, arg_89_1.actors_["10109"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10109"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10109"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10109, Vector3.New(-390, -346.2, -395), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10109"].transform.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_92_2 = arg_89_1.actors_["10109"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10109 == nil then
				arg_89_1.var_.actorSpriteComps10109 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10109 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								iter_92_2.color = Color.New(Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_2.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_2.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10109 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10109 = nil
			end

			local var_92_5 = arg_89_1.actors_["1148"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1148 == nil then
				arg_89_1.var_.actorSpriteComps1148 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps1148 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								iter_92_6.color = Color.New(Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_6.color.r, 1, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_6.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1148 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_92_8 then
						iter_92_8.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1148 = nil
			end

			local var_92_8 = arg_89_1.actors_["1148"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1148 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1148", 4)

				for iter_92_9 = 0, var_92_8.childCount - 1 do
					local var_92_9 = var_92_8:GetChild(iter_92_9)

					if var_92_9.name == "split_5" or not string.find(var_92_9.name, "split") then
						var_92_9.gameObject:SetActive(true)
					else
						var_92_9.gameObject:SetActive(false)
					end
				end
			end

			local var_92_10 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 then
				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_89_1.time_ - 0) / var_92_10)
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_92_11 = 0
			local var_92_12 = 0.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(416111020)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 14 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 14)

				if (14 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 14)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111020", "story_v_out_416111.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_416111", "416111020", "story_v_out_416111.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_416111", "416111020", "story_v_out_416111.awb")

						arg_89_1:RecordAudio("416111020", var_92_18)
						arg_89_1:RecordAudio("416111020", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416111", "416111020", "story_v_out_416111.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416111", "416111020", "story_v_out_416111.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_89_1:InitPlayNodeList()
	end,
	Play416111021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416111021
		arg_93_1.duration_ = 4.17

		local var_93_0 = {
			zh = 4.166,
			ja = 3.666
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
				arg_93_0:Play416111022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(416111021)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 13 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 13)

				if (13 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 13)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111021", "story_v_out_416111.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111021", "story_v_out_416111.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_416111", "416111021", "story_v_out_416111.awb")

						arg_93_1:RecordAudio("416111021", var_96_6)
						arg_93_1:RecordAudio("416111021", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416111", "416111021", "story_v_out_416111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416111", "416111021", "story_v_out_416111.awb")
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
	Play416111022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416111022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416111023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1148 = arg_97_1.actors_["1148"].transform.localPosition
				arg_97_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1148", 7)

				for iter_100_0 = 0, arg_97_1.actors_["1148"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["1148"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_2 = arg_97_1.actors_["10109"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10109 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				for iter_100_1 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_1)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10109, Vector3.New(0, 2000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, 2000, 0)
			end

			local var_100_5 = 0
			local var_100_6 = 1.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(416111022).content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 56 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 56)

				if (56 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 56)) > 0 and var_100_6 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_10 and arg_97_1.time_ < var_100_5 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play416111023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416111023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play416111024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(416111023).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 51 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 51)

				if (51 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 51)) > 0 and var_104_0 < var_104_3 then
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
	Play416111024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416111024
		arg_105_1.duration_ = 5.67

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play416111025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_9000

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_108_0 = 0.266666666666667

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				local var_108_1, var_108_2 = math.modf((arg_105_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_108_2 * 0.13, var_108_2 * 0.13, var_108_2 * 0.13) + arg_105_1.var_.shakeOldPos
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				manager.ui.mainCamera.transform.localPosition = arg_105_1.var_.shakeOldPos
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				local var_108_3 = arg_105_1.var_.effect1102

				if not arg_105_1.var_.effect1102 then
					var_108_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_108_3.name = "1102"
					arg_105_1.var_.effect1102 = var_108_3
				else
					var_108_3.transform:SetParent(var_108_9000)
				end

				var_108_3.transform.localPosition = Vector3.New(0.06, -0.18, 1)
				var_108_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.3 < arg_105_1.time_ and arg_105_1.time_ <= 1.3 + arg_108_0 then
				if arg_105_1.var_.effect1102 then
					Object.Destroy(arg_105_1.var_.effect1102)

					arg_105_1.var_.effect1102 = nil
				end
			end

			if 0.133333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 0.133333333333333 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_7 = 0.666666666666667
			local var_108_8 = 1.975

			if 0.666666666666667 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_9 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_9:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(416111024).content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_12 = 79 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 79)

				if (79 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 79)) > 0 and var_108_8 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12
					var_108_7 = var_108_7 + 0.3

					if var_108_12 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = var_108_7 + 0.3
			local var_108_14 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_7 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_13 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_13) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_13 + var_108_14 and arg_105_1.time_ < var_108_13 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play416111025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416111025
		arg_111_1.duration_ = 4.5

		local var_111_0 = {
			zh = 4.5,
			ja = 3.733
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
				arg_111_0:Play416111026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10109"]) and arg_111_1.var_.actorSpriteComps10109 == nil then
				arg_111_1.var_.actorSpriteComps10109 = arg_111_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.125

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10109"]) then
				if arg_111_1.var_.actorSpriteComps10109 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 1, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10109"]) and arg_111_1.var_.actorSpriteComps10109 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10109 = nil
			end

			local var_114_2 = arg_111_1.actors_["10109"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10109 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10109", 3)

				for iter_114_4 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_4)

					if var_114_3.name == "" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_111_1.time_ - 0) / var_114_4)
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_114_5 = arg_111_1.actors_["1148"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps1148 == nil then
				arg_111_1.var_.actorSpriteComps1148 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 0.125

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps1148 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_114_6 then
							if arg_111_1.isInRecall_ then
								iter_114_6.color = Color.New(Mathf.Lerp(iter_114_6.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_6.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_6.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_6.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_6.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps1148 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_114_8 then
						iter_114_8.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps1148 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 0.325

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(416111025)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 13 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 13)

				if (13 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 13)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111025", "story_v_out_416111.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_416111", "416111025", "story_v_out_416111.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_416111", "416111025", "story_v_out_416111.awb")

						arg_111_1:RecordAudio("416111025", var_114_15)
						arg_111_1:RecordAudio("416111025", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416111", "416111025", "story_v_out_416111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416111", "416111025", "story_v_out_416111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play416111026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416111026
		arg_115_1.duration_ = 5.2

		local var_115_0 = {
			zh = 4.133,
			ja = 5.2
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play416111027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10109 = arg_115_1.actors_["10109"].transform.localPosition
				arg_115_1.actors_["10109"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10109", 2)

				for iter_118_0 = 0, arg_115_1.actors_["10109"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["10109"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["10109"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10109, Vector3.New(-390, -346.2, -395), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["10109"].transform.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_118_2 = "10108"

			if arg_115_1.actors_["10108"] == nil then
				local var_118_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_118_3) then
					local var_118_4 = Object.Instantiate(var_118_3, arg_115_1.canvasGo_.transform)

					var_118_4.transform:SetSiblingIndex(1)

					var_118_4.name = var_118_2
					var_118_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_2] = var_118_4

					if arg_115_1.isInRecall_ then
						for iter_118_1, iter_118_2 in ipairs((var_118_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_118_2.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_5 = arg_115_1.actors_["10108"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10108 = var_118_5.localPosition
				var_118_5.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10108", 4)

				for iter_118_3 = 0, var_118_5.childCount - 1 do
					local var_118_6 = var_118_5:GetChild(iter_118_3)

					if var_118_6.name == "split_3" or not string.find(var_118_6.name, "split") then
						var_118_6.gameObject:SetActive(true)
					else
						var_118_6.gameObject:SetActive(false)
					end
				end
			end

			local var_118_7 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_115_1.time_ - 0) / var_118_7)
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_118_8 = arg_115_1.actors_["10108"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10108 == nil then
				arg_115_1.var_.actorSpriteComps10108 = var_118_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 0.125

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_9 and not isNil(var_118_8) then
				if arg_115_1.var_.actorSpriteComps10108 then
					for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_118_5 then
							if arg_115_1.isInRecall_ then
								iter_118_5.color = Color.New(Mathf.Lerp(iter_118_5.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_9), Mathf.Lerp(iter_118_5.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_9), (Mathf.Lerp(iter_118_5.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_9)))
							else
								local var_118_10 = Mathf.Lerp(iter_118_5.color.r, 1, (arg_115_1.time_ - 0) / var_118_9)

								iter_118_5.color = Color.New(var_118_10, var_118_10, var_118_10)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_9 and arg_115_1.time_ < 0 + var_118_9 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10108 then
				for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_118_7 then
						iter_118_7.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10108 = nil
			end

			local var_118_11 = arg_115_1.actors_["10109"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10109 == nil then
				arg_115_1.var_.actorSpriteComps10109 = var_118_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_12 = 0.125

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_12 and not isNil(var_118_11) then
				if arg_115_1.var_.actorSpriteComps10109 then
					for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_118_9 then
							if arg_115_1.isInRecall_ then
								iter_118_9.color = Color.New(Mathf.Lerp(iter_118_9.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_12), Mathf.Lerp(iter_118_9.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_12), (Mathf.Lerp(iter_118_9.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_12)))
							else
								local var_118_13 = Mathf.Lerp(iter_118_9.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_12)

								iter_118_9.color = Color.New(var_118_13, var_118_13, var_118_13)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_12 and arg_115_1.time_ < 0 + var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10109 then
				for iter_118_10, iter_118_11 in pairs(arg_115_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_118_11 then
						iter_118_11.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10109 = nil
			end

			local var_118_14 = arg_115_1.actors_["1148"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_14.localPosition
				var_118_14.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 7)

				for iter_118_12 = 0, var_118_14.childCount - 1 do
					local var_118_15 = var_118_14:GetChild(iter_118_12)

					if var_118_15.name == "" or not string.find(var_118_15.name, "split") then
						var_118_15.gameObject:SetActive(true)
					else
						var_118_15.gameObject:SetActive(false)
					end
				end
			end

			local var_118_16 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_16 then
				var_118_14.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_115_1.time_ - 0) / var_118_16)
			end

			if arg_115_1.time_ >= 0 + var_118_16 and arg_115_1.time_ < 0 + var_118_16 + arg_118_0 then
				var_118_14.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_17 = 0
			local var_118_18 = 0.4

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_19 = arg_115_1:GetWordFromCfg(416111026)
				local var_118_20 = arg_115_1:FormatText(var_118_19.content)

				arg_115_1.text_.text = var_118_20

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_22 = 16 <= 0 and var_118_18 or var_118_18 * (utf8.len(var_118_20) / 16)

				if (16 <= 0 and var_118_18 or var_118_18 * (utf8.len(var_118_20) / 16)) > 0 and var_118_18 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_17 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_17
					end
				end

				arg_115_1.text_.text = var_118_20
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111026", "story_v_out_416111.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_416111", "416111026", "story_v_out_416111.awb") / 1000

					if var_118_23 + var_118_17 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_17
					end

					if var_118_19.prefab_name ~= "" and arg_115_1.actors_[var_118_19.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_19.prefab_name].transform, "story_v_out_416111", "416111026", "story_v_out_416111.awb")

						arg_115_1:RecordAudio("416111026", var_118_24)
						arg_115_1:RecordAudio("416111026", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416111", "416111026", "story_v_out_416111.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416111", "416111026", "story_v_out_416111.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_18, arg_115_1.talkMaxDuration)

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_17) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_17 + var_118_25 and arg_115_1.time_ < var_118_17 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
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
			},
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
	Play416111027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416111027
		arg_119_1.duration_ = 5.73

		local var_119_0 = {
			zh = 4.766,
			ja = 5.733
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
				arg_119_0:Play416111028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.45

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(416111027)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 18 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 18)

				if (18 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 18)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111027", "story_v_out_416111.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111027", "story_v_out_416111.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_416111", "416111027", "story_v_out_416111.awb")

						arg_119_1:RecordAudio("416111027", var_122_6)
						arg_119_1:RecordAudio("416111027", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416111", "416111027", "story_v_out_416111.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416111", "416111027", "story_v_out_416111.awb")
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
	Play416111028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416111028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416111029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10108 = arg_123_1.actors_["10108"].transform.localPosition
				arg_123_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10108", 7)

				for iter_126_0 = 0, arg_123_1.actors_["10108"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10108"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_2 = arg_123_1.actors_["10109"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10109 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				for iter_126_1 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_1)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10109, Vector3.New(0, 2000, 0), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(0, 2000, 0)
			end

			local var_126_5 = 0
			local var_126_6 = 1.925

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(416111028).content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 77 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_7) / 77)

				if (77 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_7) / 77)) > 0 and var_126_6 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_10 and arg_123_1.time_ < var_126_5 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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
				actorName = "10109",
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
	Play416111029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416111029
		arg_127_1.duration_ = 10.97

		local var_127_0 = {
			zh = 7.933,
			ja = 10.966
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
				arg_127_0:Play416111030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10109"]) and arg_127_1.var_.actorSpriteComps10109 == nil then
				arg_127_1.var_.actorSpriteComps10109 = arg_127_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.125

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10109"]) then
				if arg_127_1.var_.actorSpriteComps10109 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10109"]) and arg_127_1.var_.actorSpriteComps10109 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10109 = nil
			end

			local var_130_2 = arg_127_1.actors_["10109"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10109 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10109", 3)

				for iter_130_4 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_4)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_130_5 = 0
			local var_130_6 = 0.375

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(416111029)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 15 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 15)

				if (15 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 15)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111029", "story_v_out_416111.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_416111", "416111029", "story_v_out_416111.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_416111", "416111029", "story_v_out_416111.awb")

						arg_127_1:RecordAudio("416111029", var_130_12)
						arg_127_1:RecordAudio("416111029", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416111", "416111029", "story_v_out_416111.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416111", "416111029", "story_v_out_416111.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play416111030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416111030
		arg_131_1.duration_ = 6.03

		local var_131_0 = {
			zh = 6.033,
			ja = 3.933
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
				arg_131_0:Play416111031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.4

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(416111030)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 16)

				if (16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 16)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111030", "story_v_out_416111.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111030", "story_v_out_416111.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_416111", "416111030", "story_v_out_416111.awb")

						arg_131_1:RecordAudio("416111030", var_134_6)
						arg_131_1:RecordAudio("416111030", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416111", "416111030", "story_v_out_416111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416111", "416111030", "story_v_out_416111.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play416111031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416111031
		arg_135_1.duration_ = 2.5

		local var_135_0 = {
			zh = 2.133,
			ja = 2.5
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play416111032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10109 = arg_135_1.actors_["10109"].transform.localPosition
				arg_135_1.actors_["10109"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10109", 2)

				for iter_138_0 = 0, arg_135_1.actors_["10109"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10109"].transform:GetChild(iter_138_0)

					if var_138_0.name == "" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10109"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10109, Vector3.New(-390, -346.2, -395), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10109"].transform.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_138_2 = arg_135_1.actors_["1148"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1148 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1148", 4)

				for iter_138_1 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_1)

					if var_138_3.name == "split_3" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(390, -429, -180)
			end

			local var_138_5 = arg_135_1.actors_["1148"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps1148 == nil then
				arg_135_1.var_.actorSpriteComps1148 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 0.125

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps1148 then
					for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_138_3 then
							if arg_135_1.isInRecall_ then
								iter_138_3.color = Color.New(Mathf.Lerp(iter_138_3.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_3.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_3.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_3.color.r, 1, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_3.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps1148 then
				for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_138_5 then
						iter_138_5.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1148 = nil
			end

			local var_138_8 = arg_135_1.actors_["10109"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10109 == nil then
				arg_135_1.var_.actorSpriteComps10109 = var_138_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.125

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 and not isNil(var_138_8) then
				if arg_135_1.var_.actorSpriteComps10109 then
					for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_138_7 then
							if arg_135_1.isInRecall_ then
								iter_138_7.color = Color.New(Mathf.Lerp(iter_138_7.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_9), Mathf.Lerp(iter_138_7.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_9), (Mathf.Lerp(iter_138_7.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_9)))
							else
								local var_138_10 = Mathf.Lerp(iter_138_7.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_9)

								iter_138_7.color = Color.New(var_138_10, var_138_10, var_138_10)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10109 then
				for iter_138_8, iter_138_9 in pairs(arg_135_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_138_9 then
						iter_138_9.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10109 = nil
			end

			local var_138_11 = 0
			local var_138_12 = 0.125

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(416111031)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 5 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 5)

				if (5 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 5)) > 0 and var_138_12 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111031", "story_v_out_416111.awb") ~= 0 then
					local var_138_17 = manager.audio:GetVoiceLength("story_v_out_416111", "416111031", "story_v_out_416111.awb") / 1000

					if var_138_17 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_11
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_416111", "416111031", "story_v_out_416111.awb")

						arg_135_1:RecordAudio("416111031", var_138_18)
						arg_135_1:RecordAudio("416111031", var_138_18)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416111", "416111031", "story_v_out_416111.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416111", "416111031", "story_v_out_416111.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_19 and arg_135_1.time_ < var_138_11 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_135_1:InitPlayNodeList()
	end,
	Play416111032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416111032
		arg_139_1.duration_ = 5.4

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play416111033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_9000

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1148"]) and arg_139_1.var_.actorSpriteComps1148 == nil then
				arg_139_1.var_.actorSpriteComps1148 = arg_139_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.125

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1148"]) then
				if arg_139_1.var_.actorSpriteComps1148 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1148"]) and arg_139_1.var_.actorSpriteComps1148 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1148 = nil
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_2 = arg_139_1.var_.effect11032

				if not arg_139_1.var_.effect11032 then
					var_142_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_142_2.name = "11032"
					arg_139_1.var_.effect11032 = var_142_2
				else
					var_142_2.transform:SetParent(var_142_9000)
				end

				var_142_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_142_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_142_4 = manager.ui.mainCamera.transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_4.localPosition
			end

			local var_142_5 = 0.4

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				local var_142_6, var_142_7 = math.modf((arg_139_1.time_ - 0) / 0.066)

				var_142_4.localPosition = Vector3.New(var_142_7 * 0.13, var_142_7 * 0.13, var_142_7 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_8 = arg_139_1.actors_["10109"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10109 = var_142_8.localPosition
				var_142_8.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10109", 7)

				for iter_142_4 = 0, var_142_8.childCount - 1 do
					local var_142_9 = var_142_8:GetChild(iter_142_4)

					if var_142_9.name == "" or not string.find(var_142_9.name, "split") then
						var_142_9.gameObject:SetActive(true)
					else
						var_142_9.gameObject:SetActive(false)
					end
				end
			end

			local var_142_10 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_10 then
				var_142_8.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_10)
			end

			if arg_139_1.time_ >= 0 + var_142_10 and arg_139_1.time_ < 0 + var_142_10 + arg_142_0 then
				var_142_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_11 = arg_139_1.actors_["1148"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1148 = var_142_11.localPosition
				var_142_11.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1148", 7)

				for iter_142_5 = 0, var_142_11.childCount - 1 do
					local var_142_12 = var_142_11:GetChild(iter_142_5)

					if var_142_12.name == "split_3" or not string.find(var_142_12.name, "split") then
						var_142_12.gameObject:SetActive(true)
					else
						var_142_12.gameObject:SetActive(false)
					end
				end
			end

			local var_142_13 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_13 then
				var_142_11.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_13)
			end

			if arg_139_1.time_ >= 0 + var_142_13 and arg_139_1.time_ < 0 + var_142_13 + arg_142_0 then
				var_142_11.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.43333333333333 < arg_139_1.time_ and arg_139_1.time_ <= 2.43333333333333 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_power", "")
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_15 = 0.4
			local var_142_16 = 1.775

			if 0.4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_17 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_17:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(416111032).content)

				arg_139_1.text_.text = var_142_18

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 71 <= 0 and var_142_16 or var_142_16 * (utf8.len(var_142_18) / 71)

				if (71 <= 0 and var_142_16 or var_142_16 * (utf8.len(var_142_18) / 71)) > 0 and var_142_16 < var_142_20 then
					arg_139_1.talkMaxDuration = var_142_20
					var_142_15 = var_142_15 + 0.3

					if var_142_20 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_20 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_18
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_21 = var_142_15 + 0.3
			local var_142_22 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_22 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_21) / var_142_22

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_21 + var_142_22 and arg_139_1.time_ < var_142_21 + var_142_22 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_139_1:InitPlayNodeList()
	end,
	Play416111033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416111033
		arg_145_1.duration_ = 6.1

		local var_145_0 = {
			zh = 3.466,
			ja = 6.1
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
				arg_145_0:Play416111034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1148 = arg_145_1.actors_["1148"].transform.localPosition
				arg_145_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1148", 3)

				for iter_148_0 = 0, arg_145_1.actors_["1148"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1148"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_3" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_148_2 = arg_145_1.actors_["1148"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1148 == nil then
				arg_145_1.var_.actorSpriteComps1148 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.125

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1148 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1148 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1148 = nil
			end

			local var_148_5 = 0
			local var_148_6 = 0.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
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

				local var_148_7 = arg_145_1:GetWordFromCfg(416111033)
				local var_148_8 = arg_145_1:FormatText(var_148_7.content)

				arg_145_1.text_.text = var_148_8

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 12 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 12)

				if (12 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 12)) > 0 and var_148_6 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_8
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111033", "story_v_out_416111.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_416111", "416111033", "story_v_out_416111.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_416111", "416111033", "story_v_out_416111.awb")

						arg_145_1:RecordAudio("416111033", var_148_12)
						arg_145_1:RecordAudio("416111033", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416111", "416111033", "story_v_out_416111.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416111", "416111033", "story_v_out_416111.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_13 and arg_145_1.time_ < var_148_5 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play416111034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416111034
		arg_149_1.duration_ = 8.67

		local var_149_0 = {
			zh = 6.066,
			ja = 8.666
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
				arg_149_0:Play416111035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10109"]) and arg_149_1.var_.actorSpriteComps10109 == nil then
				arg_149_1.var_.actorSpriteComps10109 = arg_149_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.125

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10109"]) then
				if arg_149_1.var_.actorSpriteComps10109 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 1, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10109"]) and arg_149_1.var_.actorSpriteComps10109 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10109 = nil
			end

			local var_152_2 = arg_149_1.actors_["1148"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1148 = var_152_2.localPosition
				var_152_2.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1148", 7)

				for iter_152_4 = 0, var_152_2.childCount - 1 do
					local var_152_3 = var_152_2:GetChild(iter_152_4)

					if var_152_3.name == "split_3" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_2.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_149_1.time_ - 0) / var_152_4)
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_5 = arg_149_1.actors_["10109"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10109 = var_152_5.localPosition
				var_152_5.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10109", 3)

				for iter_152_5 = 0, var_152_5.childCount - 1 do
					local var_152_6 = var_152_5:GetChild(iter_152_5)

					if var_152_6.name == "" or not string.find(var_152_6.name, "split") then
						var_152_6.gameObject:SetActive(true)
					else
						var_152_6.gameObject:SetActive(false)
					end
				end
			end

			local var_152_7 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				var_152_5.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_149_1.time_ - 0) / var_152_7)
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				var_152_5.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_152_8 = 0
			local var_152_9 = 0.55

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(416111034)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 22 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 22)

				if (22 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 22)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111034", "story_v_out_416111.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_416111", "416111034", "story_v_out_416111.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_416111", "416111034", "story_v_out_416111.awb")

						arg_149_1:RecordAudio("416111034", var_152_15)
						arg_149_1:RecordAudio("416111034", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416111", "416111034", "story_v_out_416111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416111", "416111034", "story_v_out_416111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play416111035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416111035
		arg_153_1.duration_ = 5.53

		local var_153_0 = {
			zh = 5,
			ja = 5.533
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
				arg_153_0:Play416111036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1148 = arg_153_1.actors_["1148"].transform.localPosition
				arg_153_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1148", 3)

				for iter_156_0 = 0, arg_153_1.actors_["1148"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1148"].transform:GetChild(iter_156_0)

					if var_156_0.name == "split_3" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_156_2 = arg_153_1.actors_["1148"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1148 == nil then
				arg_153_1.var_.actorSpriteComps1148 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.125

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1148 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1148 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1148 = nil
			end

			local var_156_5 = arg_153_1.actors_["10109"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10109 == nil then
				arg_153_1.var_.actorSpriteComps10109 = var_156_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 0.125

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.actorSpriteComps10109 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								iter_156_6.color = Color.New(Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_6), Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_6), (Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_6)))
							else
								local var_156_7 = Mathf.Lerp(iter_156_6.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_6)

								iter_156_6.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10109 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_156_8 then
						iter_156_8.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10109 = nil
			end

			local var_156_8 = arg_153_1.actors_["10109"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10109 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10109", 7)

				for iter_156_9 = 0, var_156_8.childCount - 1 do
					local var_156_9 = var_156_8:GetChild(iter_156_9)

					if var_156_9.name == "" or not string.find(var_156_9.name, "split") then
						var_156_9.gameObject:SetActive(true)
					else
						var_156_9.gameObject:SetActive(false)
					end
				end
			end

			local var_156_10 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_10 then
				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_153_1.time_ - 0) / var_156_10)
			end

			if arg_153_1.time_ >= 0 + var_156_10 and arg_153_1.time_ < 0 + var_156_10 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_11 = 0
			local var_156_12 = 0.45

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
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

				local var_156_13 = arg_153_1:GetWordFromCfg(416111035)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 18 <= 0 and var_156_12 or var_156_12 * (utf8.len(var_156_14) / 18)

				if (18 <= 0 and var_156_12 or var_156_12 * (utf8.len(var_156_14) / 18)) > 0 and var_156_12 < var_156_16 then
					arg_153_1.talkMaxDuration = var_156_16

					if var_156_16 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111035", "story_v_out_416111.awb") ~= 0 then
					local var_156_17 = manager.audio:GetVoiceLength("story_v_out_416111", "416111035", "story_v_out_416111.awb") / 1000

					if var_156_17 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_11
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_416111", "416111035", "story_v_out_416111.awb")

						arg_153_1:RecordAudio("416111035", var_156_18)
						arg_153_1:RecordAudio("416111035", var_156_18)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416111", "416111035", "story_v_out_416111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416111", "416111035", "story_v_out_416111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_19 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_19 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_19

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_19 and arg_153_1.time_ < var_156_11 + var_156_19 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play416111036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416111036
		arg_157_1.duration_ = 6.7

		local var_157_0 = {
			zh = 4.466,
			ja = 6.7
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
				arg_157_0:Play416111037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.525

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

				local var_160_1 = arg_157_1:GetWordFromCfg(416111036)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 21 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 21)

				if (21 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 21)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111036", "story_v_out_416111.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111036", "story_v_out_416111.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_416111", "416111036", "story_v_out_416111.awb")

						arg_157_1:RecordAudio("416111036", var_160_6)
						arg_157_1:RecordAudio("416111036", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416111", "416111036", "story_v_out_416111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416111", "416111036", "story_v_out_416111.awb")
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
	Play416111037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416111037
		arg_161_1.duration_ = 5.2

		local var_161_0 = {
			zh = 4.766,
			ja = 5.2
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
				arg_161_0:Play416111038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.5

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(416111037)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 20 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 20)

				if (20 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 20)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111037", "story_v_out_416111.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111037", "story_v_out_416111.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_416111", "416111037", "story_v_out_416111.awb")

						arg_161_1:RecordAudio("416111037", var_164_6)
						arg_161_1:RecordAudio("416111037", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416111", "416111037", "story_v_out_416111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416111", "416111037", "story_v_out_416111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play416111038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416111038
		arg_165_1.duration_ = 7.77

		local var_165_0 = {
			zh = 4.2,
			ja = 7.766
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
				arg_165_0:Play416111039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10109"]) and arg_165_1.var_.actorSpriteComps10109 == nil then
				arg_165_1.var_.actorSpriteComps10109 = arg_165_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.125

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10109"]) then
				if arg_165_1.var_.actorSpriteComps10109 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10109"]) and arg_165_1.var_.actorSpriteComps10109 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10109 = nil
			end

			local var_168_2 = arg_165_1.actors_["1148"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1148 == nil then
				arg_165_1.var_.actorSpriteComps1148 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.125

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1148 then
					for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_168_5 then
							if arg_165_1.isInRecall_ then
								iter_168_5.color = Color.New(Mathf.Lerp(iter_168_5.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_5.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_5.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_5.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_5.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1148 then
				for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_168_7 then
						iter_168_7.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1148 = nil
			end

			local var_168_5 = 0
			local var_168_6 = 0.375

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_7 = arg_165_1:GetWordFromCfg(416111038)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 15 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 15)

				if (15 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 15)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111038", "story_v_out_416111.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_416111", "416111038", "story_v_out_416111.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_416111", "416111038", "story_v_out_416111.awb")

						arg_165_1:RecordAudio("416111038", var_168_12)
						arg_165_1:RecordAudio("416111038", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416111", "416111038", "story_v_out_416111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416111", "416111038", "story_v_out_416111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play416111039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416111039
		arg_169_1.duration_ = 3.87

		local var_169_0 = {
			zh = 3.866,
			ja = 2.933
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
				arg_169_0:Play416111040(arg_169_1)
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
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 1, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1148"]) and arg_169_1.var_.actorSpriteComps1148 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps1148 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(416111039)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 15 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 15)

				if (15 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 15)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111039", "story_v_out_416111.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111039", "story_v_out_416111.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_416111", "416111039", "story_v_out_416111.awb")

						arg_169_1:RecordAudio("416111039", var_172_9)
						arg_169_1:RecordAudio("416111039", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416111", "416111039", "story_v_out_416111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416111", "416111039", "story_v_out_416111.awb")
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
	Play416111040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416111040
		arg_173_1.duration_ = 5.67

		local var_173_0 = {
			zh = 4.333,
			ja = 5.666
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
				arg_173_0:Play416111041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.525

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
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

				local var_176_1 = arg_173_1:GetWordFromCfg(416111040)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 21 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 21)

				if (21 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 21)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111040", "story_v_out_416111.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111040", "story_v_out_416111.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_416111", "416111040", "story_v_out_416111.awb")

						arg_173_1:RecordAudio("416111040", var_176_6)
						arg_173_1:RecordAudio("416111040", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416111", "416111040", "story_v_out_416111.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416111", "416111040", "story_v_out_416111.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416111041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416111041
		arg_177_1.duration_ = 4.5

		local var_177_0 = {
			zh = 3.733,
			ja = 4.5
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play416111042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.375

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(416111041)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 15 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 15)

				if (15 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 15)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111041", "story_v_out_416111.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111041", "story_v_out_416111.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_416111", "416111041", "story_v_out_416111.awb")

						arg_177_1:RecordAudio("416111041", var_180_6)
						arg_177_1:RecordAudio("416111041", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416111", "416111041", "story_v_out_416111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416111", "416111041", "story_v_out_416111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416111042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416111042
		arg_181_1.duration_ = 7.37

		local var_181_0 = {
			zh = 4.933,
			ja = 7.366
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
				arg_181_0:Play416111043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.425

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
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

				local var_184_1 = arg_181_1:GetWordFromCfg(416111042)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 17 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 17)

				if (17 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 17)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111042", "story_v_out_416111.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111042", "story_v_out_416111.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_416111", "416111042", "story_v_out_416111.awb")

						arg_181_1:RecordAudio("416111042", var_184_6)
						arg_181_1:RecordAudio("416111042", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416111", "416111042", "story_v_out_416111.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416111", "416111042", "story_v_out_416111.awb")
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
	Play416111043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416111043
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416111044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1148 = arg_185_1.actors_["1148"].transform.localPosition
				arg_185_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1148", 7)

				for iter_188_0 = 0, arg_185_1.actors_["1148"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["1148"].transform:GetChild(iter_188_0)

					if var_188_0.name == "" or not string.find(var_188_0.name, "split") then
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

			if 0.233333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 0.233333333333333 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_188_3 = 0
			local var_188_4 = 1.95

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_5 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(416111043).content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 78 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 78)

				if (78 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 78)) > 0 and var_188_4 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_8 and arg_185_1.time_ < var_188_3 + var_188_8 + arg_188_0 then
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
	Play416111044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416111044
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416111045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.8

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(416111044).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 72 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 72)

				if (72 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 72)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play416111045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416111045
		arg_193_1.duration_ = 6.8

		local var_193_0 = {
			zh = 6.8,
			ja = 5.6
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
				arg_193_0:Play416111046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1148 = arg_193_1.actors_["1148"].transform.localPosition
				arg_193_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1148", 3)

				for iter_196_0 = 0, arg_193_1.actors_["1148"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["1148"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_6" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_196_2 = arg_193_1.actors_["1148"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1148 == nil then
				arg_193_1.var_.actorSpriteComps1148 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.125

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps1148 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1148 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1148 = nil
			end

			local var_196_5 = 0
			local var_196_6 = 0.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
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

				local var_196_7 = arg_193_1:GetWordFromCfg(416111045)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 15 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 15)

				if (15 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 15)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111045", "story_v_out_416111.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_416111", "416111045", "story_v_out_416111.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_416111", "416111045", "story_v_out_416111.awb")

						arg_193_1:RecordAudio("416111045", var_196_12)
						arg_193_1:RecordAudio("416111045", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416111", "416111045", "story_v_out_416111.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416111", "416111045", "story_v_out_416111.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play416111046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416111046
		arg_197_1.duration_ = 8.43

		local var_197_0 = {
			zh = 8.2,
			ja = 8.433
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
				arg_197_0:Play416111047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if arg_197_1.bgs_.STwhite == nil then
				local var_200_0 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_200_0.name = "STwhite"
				var_200_0.transform.parent = arg_197_1.stage_.transform
				var_200_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_.STwhite = var_200_0
			end

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= 2 + arg_200_0 then
				local var_200_1 = arg_197_1.bgs_.STwhite

				arg_197_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_2 = var_200_1:GetComponent("SpriteRenderer")

				if var_200_2 and var_200_2.sprite then
					local var_200_3 = 2 * (var_200_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_1.transform.localScale = Vector3.New(var_200_3 / var_200_2.sprite.bounds.size.y < var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x and var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x or var_200_3 / var_200_2.sprite.bounds.size.y, var_200_3 / var_200_2.sprite.bounds.size.y < var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x and var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x or var_200_3 / var_200_2.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "STwhite" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_4 = 4

			if 4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			if arg_197_1.time_ >= var_200_4 + 0.0666666666666669 and arg_197_1.time_ < var_200_4 + 0.0666666666666669 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_5 = 0

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_6 = 2

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_6 then
				local var_200_7 = Color.New(0, 0, 0)

				var_200_7.a = Mathf.Lerp(0, 1, (arg_197_1.time_ - var_200_5) / var_200_6)
				arg_197_1.mask_.color = var_200_7
			end

			if arg_197_1.time_ >= var_200_5 + var_200_6 and arg_197_1.time_ < var_200_5 + var_200_6 + arg_200_0 then
				local var_200_8 = Color.New(0, 0, 0)

				var_200_8.a = 1
				arg_197_1.mask_.color = var_200_8
			end

			local var_200_9 = 2

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_10 = 2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 then
				local var_200_11 = Color.New(0, 0, 0)

				var_200_11.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - var_200_9) / var_200_10)
				arg_197_1.mask_.color = var_200_11
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 then
				local var_200_12 = Color.New(0, 0, 0)

				arg_197_1.mask_.enabled = false
				var_200_12.a = 0
				arg_197_1.mask_.color = var_200_12
			end

			local var_200_13 = arg_197_1.actors_["1148"].transform

			if 1.966 < arg_197_1.time_ and arg_197_1.time_ <= 1.966 + arg_200_0 then
				arg_197_1.var_.moveOldPos1148 = var_200_13.localPosition
				var_200_13.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1148", 7)

				for iter_200_2 = 0, var_200_13.childCount - 1 do
					local var_200_14 = var_200_13:GetChild(iter_200_2)

					if var_200_14.name == "" or not string.find(var_200_14.name, "split") then
						var_200_14.gameObject:SetActive(true)
					else
						var_200_14.gameObject:SetActive(false)
					end
				end
			end

			local var_200_15 = 0.001

			if 1.966 <= arg_197_1.time_ and arg_197_1.time_ < 1.966 + var_200_15 then
				var_200_13.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_197_1.time_ - 1.966) / var_200_15)
			end

			if arg_197_1.time_ >= 1.966 + var_200_15 and arg_197_1.time_ < 1.966 + var_200_15 + arg_200_0 then
				var_200_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_16 = 4
			local var_200_17 = 0.175

			if 4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_18 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_18:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1092].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_19 = arg_197_1:GetWordFromCfg(416111046)
				local var_200_20 = arg_197_1:FormatText(var_200_19.content)

				arg_197_1.text_.text = var_200_20

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_22 = 7 <= 0 and var_200_17 or var_200_17 * (utf8.len(var_200_20) / 7)

				if (7 <= 0 and var_200_17 or var_200_17 * (utf8.len(var_200_20) / 7)) > 0 and var_200_17 < var_200_22 then
					arg_197_1.talkMaxDuration = var_200_22
					var_200_16 = var_200_16 + 0.3

					if var_200_22 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_20
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111046", "story_v_out_416111.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_out_416111", "416111046", "story_v_out_416111.awb") / 1000

					if var_200_23 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_16
					end

					if var_200_19.prefab_name ~= "" and arg_197_1.actors_[var_200_19.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_19.prefab_name].transform, "story_v_out_416111", "416111046", "story_v_out_416111.awb")

						arg_197_1:RecordAudio("416111046", var_200_24)
						arg_197_1:RecordAudio("416111046", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416111", "416111046", "story_v_out_416111.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416111", "416111046", "story_v_out_416111.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_25 = var_200_16 + 0.3
			local var_200_26 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_25 + var_200_26 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_25) / var_200_26

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_25 + var_200_26 and arg_197_1.time_ < var_200_25 + var_200_26 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play416111047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416111047
		arg_203_1.duration_ = 7.69

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416111048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_9000

			if arg_203_1.bgs_.SS1605 == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1605")
				var_206_0.name = "SS1605"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.SS1605 = var_206_0
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.SS1605

				arg_203_1.bgs_.SS1605.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "SS1605" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_5 = 1

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_5 then
				local var_206_6 = Color.New(1, 1, 1)

				var_206_6.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_4) / var_206_5)
				arg_203_1.mask_.color = var_206_6
			end

			if arg_203_1.time_ >= var_206_4 + var_206_5 and arg_203_1.time_ < var_206_4 + var_206_5 + arg_206_0 then
				local var_206_7 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_7.a = 0
				arg_203_1.mask_.color = var_206_7
			end

			local var_206_8 = 2.034

			if 2.034 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_8 + 0.766666666666667 and arg_203_1.time_ < var_206_8 + 0.766666666666667 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_9 = arg_203_1.actors_["1148"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1148 = var_206_9.localPosition
				var_206_9.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1148", 7)

				for iter_206_2 = 0, var_206_9.childCount - 1 do
					local var_206_10 = var_206_9:GetChild(iter_206_2)

					if var_206_10.name == "" or not string.find(var_206_10.name, "split") then
						var_206_10.gameObject:SetActive(true)
					else
						var_206_10.gameObject:SetActive(false)
					end
				end
			end

			local var_206_11 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_11 then
				var_206_9.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_203_1.time_ - 0) / var_206_11)
			end

			if arg_203_1.time_ >= 0 + var_206_11 and arg_203_1.time_ < 0 + var_206_11 + arg_206_0 then
				var_206_9.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_12 = arg_203_1.bgs_.SS1605.transform

			if 0.0339999999999999 < arg_203_1.time_ and arg_203_1.time_ <= 0.0339999999999999 + arg_206_0 then
				arg_203_1.var_.moveOldPosSS1605 = var_206_12.localPosition
			end

			local var_206_13 = 0.001

			if 0.0339999999999999 <= arg_203_1.time_ and arg_203_1.time_ < 0.0339999999999999 + var_206_13 then
				var_206_12.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosSS1605, Vector3.New(0, 1, 10), (arg_203_1.time_ - 0.0339999999999999) / var_206_13)
			end

			if arg_203_1.time_ >= 0.0339999999999999 + var_206_13 and arg_203_1.time_ < 0.0339999999999999 + var_206_13 + arg_206_0 then
				var_206_12.localPosition = Vector3.New(0, 1, 10)
			end

			local var_206_14 = arg_203_1.bgs_.SS1605.transform

			if 0.0679999999999998 < arg_203_1.time_ and arg_203_1.time_ <= 0.0679999999999998 + arg_206_0 then
				arg_203_1.var_.moveOldPosSS1605 = var_206_14.localPosition
			end

			local var_206_15 = 1.966

			if 0.0679999999999998 <= arg_203_1.time_ and arg_203_1.time_ < 0.0679999999999998 + var_206_15 then
				var_206_14.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosSS1605, Vector3.New(0, 1, 9), (arg_203_1.time_ - 0.0679999999999998) / var_206_15)
			end

			if arg_203_1.time_ >= 0.0679999999999998 + var_206_15 and arg_203_1.time_ < 0.0679999999999998 + var_206_15 + arg_206_0 then
				var_206_14.localPosition = Vector3.New(0, 1, 9)
			end

			if 1.70066666666667 < arg_203_1.time_ and arg_203_1.time_ <= 1.70066666666667 + arg_206_0 then
				local var_206_16 = arg_203_1.var_.effect1047

				if not arg_203_1.var_.effect1047 then
					var_206_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_206_16.name = "1047"
					arg_203_1.var_.effect1047 = var_206_16
				else
					var_206_16.transform:SetParent(var_206_9000)
				end

				var_206_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_206_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_206_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_206_19 = var_206_16.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_206_3, iter_206_4 in ipairs((var_206_19:ToTable())) do
					iter_206_4.transform.localScale = Vector3.New(iter_206_4.transform.localScale.x / var_206_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_206_19 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_206_4.transform.localScale.y / var_206_18, iter_206_4.transform.localScale.z)
				end
			end

			if 5.034 < arg_203_1.time_ and arg_203_1.time_ <= 5.034 + arg_206_0 then
				if arg_203_1.var_.effect1047 then
					Object.Destroy(arg_203_1.var_.effect1047)

					arg_203_1.var_.effect1047 = nil
				end
			end

			local var_206_22 = manager.ui.mainCamera.transform

			if 1.70066666666667 < arg_203_1.time_ and arg_203_1.time_ <= 1.70066666666667 + arg_206_0 then
				arg_203_1.var_.shakeOldPos = var_206_22.localPosition
			end

			local var_206_23 = 0.9

			if 1.70066666666667 <= arg_203_1.time_ and arg_203_1.time_ < 1.70066666666667 + var_206_23 then
				local var_206_24, var_206_25 = math.modf((arg_203_1.time_ - 1.70066666666667) / 0.066)

				var_206_22.localPosition = Vector3.New(var_206_25 * 0.13, var_206_25 * 0.13, var_206_25 * 0.13) + arg_203_1.var_.shakeOldPos
			end

			if arg_203_1.time_ >= 1.70066666666667 + var_206_23 and arg_203_1.time_ < 1.70066666666667 + var_206_23 + arg_206_0 then
				var_206_22.localPosition = arg_203_1.var_.shakeOldPos
			end

			if 1.83333333333333 < arg_203_1.time_ and arg_203_1.time_ <= 1.83333333333333 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_16", "se_story_16_archery", "")
			end

			if 3.33333333333333 < arg_203_1.time_ and arg_203_1.time_ <= 3.33333333333333 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_138", "se_story_138_thunderhit", "")
			end

			if 1.83333333333333 < arg_203_1.time_ and arg_203_1.time_ <= 1.83333333333333 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_deformation", "")
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_29 = 2.69319013655124
			local var_206_30 = 1.425

			if 2.69319013655124 < arg_203_1.time_ and arg_203_1.time_ <= var_206_29 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_31 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_31:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_32 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(416111047).content)

				arg_203_1.text_.text = var_206_32

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_34 = 57 <= 0 and var_206_30 or var_206_30 * (utf8.len(var_206_32) / 57)

				if (57 <= 0 and var_206_30 or var_206_30 * (utf8.len(var_206_32) / 57)) > 0 and var_206_30 < var_206_34 then
					arg_203_1.talkMaxDuration = var_206_34
					var_206_29 = var_206_29 + 0.3

					if var_206_34 + var_206_29 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_34 + var_206_29
					end
				end

				arg_203_1.text_.text = var_206_32
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_35 = var_206_29 + 0.3
			local var_206_36 = math.max(var_206_30, arg_203_1.talkMaxDuration)

			if var_206_29 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_35 + var_206_36 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_35) / var_206_36

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_35 + var_206_36 and arg_203_1.time_ < var_206_35 + var_206_36 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 0.0679999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play416111048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416111048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play416111049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.425

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(416111048).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 57 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 57)

				if (57 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 57)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play416111049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 416111049
		arg_213_1.duration_ = 4.93

		local var_213_0 = {
			zh = 4.233,
			ja = 4.933
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play416111050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:AudioAction("stop", "effect", "se_story_5", "se_story_5_heartbeat", "")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_5", "se_story_5_heartbeat_stop", "")
			end

			local var_216_2 = 0
			local var_216_3 = 0.45

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(416111049)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 18 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 18)

				if (18 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 18)) > 0 and var_216_3 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111049", "story_v_out_416111.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_416111", "416111049", "story_v_out_416111.awb") / 1000

					if var_216_8 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_2
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_out_416111", "416111049", "story_v_out_416111.awb")

						arg_213_1:RecordAudio("416111049", var_216_9)
						arg_213_1:RecordAudio("416111049", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_416111", "416111049", "story_v_out_416111.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_416111", "416111049", "story_v_out_416111.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_10 and arg_213_1.time_ < var_216_2 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play416111050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 416111050
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play416111051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.075

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(416111050).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 43 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 43)

				if (43 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 43)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play416111051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 416111051
		arg_221_1.duration_ = 6.3

		local var_221_0 = {
			zh = 4.933,
			ja = 6.3
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play416111052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.5

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(416111051)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 20 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 20)

				if (20 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 20)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111051", "story_v_out_416111.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111051", "story_v_out_416111.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_416111", "416111051", "story_v_out_416111.awb")

						arg_221_1:RecordAudio("416111051", var_224_6)
						arg_221_1:RecordAudio("416111051", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_416111", "416111051", "story_v_out_416111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_416111", "416111051", "story_v_out_416111.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play416111052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 416111052
		arg_225_1.duration_ = 4.63

		local var_225_0 = {
			zh = 4.366,
			ja = 4.633
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play416111053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPosSS1605 = arg_225_1.bgs_.SS1605.transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.bgs_.SS1605.transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPosSS1605, Vector3.New(0, 1, 9), (arg_225_1.time_ - 0) / var_228_0)
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.bgs_.SS1605.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_228_1 = arg_225_1.bgs_.SS1605.transform

			if 0.0339999999999998 < arg_225_1.time_ and arg_225_1.time_ <= 0.0339999999999998 + arg_228_0 then
				arg_225_1.var_.moveOldPosSS1605 = var_228_1.localPosition
			end

			local var_228_2 = 0.966

			if 0.0339999999999998 <= arg_225_1.time_ and arg_225_1.time_ < 0.0339999999999998 + var_228_2 then
				var_228_1.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPosSS1605, Vector3.New(0, 0.9, 8.5), (arg_225_1.time_ - 0.0339999999999998) / var_228_2)
			end

			if arg_225_1.time_ >= 0.0339999999999998 + var_228_2 and arg_225_1.time_ < 0.0339999999999998 + var_228_2 + arg_228_0 then
				var_228_1.localPosition = Vector3.New(0, 0.9, 8.5)
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_3 = 1
			local var_228_4 = 0.325

			if 1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_5 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_5:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(416111052)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 13 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_7) / 13)

				if (13 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_7) / 13)) > 0 and var_228_4 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9
					var_228_3 = var_228_3 + 0.3

					if var_228_9 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_3
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111052", "story_v_out_416111.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_416111", "416111052", "story_v_out_416111.awb") / 1000

					if var_228_10 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_3
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_416111", "416111052", "story_v_out_416111.awb")

						arg_225_1:RecordAudio("416111052", var_228_11)
						arg_225_1:RecordAudio("416111052", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_416111", "416111052", "story_v_out_416111.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_416111", "416111052", "story_v_out_416111.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = var_228_3 + 0.3
			local var_228_13 = math.max(var_228_4, arg_225_1.talkMaxDuration)

			if var_228_3 + 0.3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_12) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_12 + var_228_13 and arg_225_1.time_ < var_228_12 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play416111053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416111053
		arg_231_1.duration_ = 8.9

		local var_231_0 = {
			zh = 5.966,
			ja = 8.9
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
				arg_231_0:Play416111054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.5

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(416111053)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 20 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 20)

				if (20 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 20)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111053", "story_v_out_416111.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111053", "story_v_out_416111.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_416111", "416111053", "story_v_out_416111.awb")

						arg_231_1:RecordAudio("416111053", var_234_6)
						arg_231_1:RecordAudio("416111053", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416111", "416111053", "story_v_out_416111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416111", "416111053", "story_v_out_416111.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416111054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416111054
		arg_235_1.duration_ = 7.07

		local var_235_0 = {
			zh = 4.2,
			ja = 7.066
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
				arg_235_0:Play416111055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.375

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(416111054)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 15 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 15)

				if (15 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 15)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111054", "story_v_out_416111.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111054", "story_v_out_416111.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_416111", "416111054", "story_v_out_416111.awb")

						arg_235_1:RecordAudio("416111054", var_238_6)
						arg_235_1:RecordAudio("416111054", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416111", "416111054", "story_v_out_416111.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416111", "416111054", "story_v_out_416111.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416111055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416111055
		arg_239_1.duration_ = 5.5

		local var_239_0 = {
			zh = 4.933,
			ja = 5.5
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
				arg_239_0:Play416111056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.575

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(416111055)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 23 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 23)

				if (23 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 23)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111055", "story_v_out_416111.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111055", "story_v_out_416111.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_416111", "416111055", "story_v_out_416111.awb")

						arg_239_1:RecordAudio("416111055", var_242_6)
						arg_239_1:RecordAudio("416111055", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416111", "416111055", "story_v_out_416111.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416111", "416111055", "story_v_out_416111.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416111056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416111056
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play416111057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1148 = arg_243_1.actors_["1148"].transform.localPosition
				arg_243_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1148", 7)

				for iter_246_0 = 0, arg_243_1.actors_["1148"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["1148"].transform:GetChild(iter_246_0)

					if var_246_0.name == "" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_246_2 = 0
			local var_246_3 = 1.525

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(416111056).content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 61 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 61)

				if (61 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 61)) > 0 and var_246_3 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_7 and arg_243_1.time_ < var_246_2 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play416111057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416111057
		arg_247_1.duration_ = 7.03

		local var_247_0 = {
			zh = 4.333,
			ja = 7.033
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
				arg_247_0:Play416111058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.475

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(416111057)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 19 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 19)

				if (19 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 19)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111057", "story_v_out_416111.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111057", "story_v_out_416111.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_416111", "416111057", "story_v_out_416111.awb")

						arg_247_1:RecordAudio("416111057", var_250_6)
						arg_247_1:RecordAudio("416111057", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416111", "416111057", "story_v_out_416111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416111", "416111057", "story_v_out_416111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play416111058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416111058
		arg_251_1.duration_ = 5.83

		local var_251_0 = {
			zh = 4.233,
			ja = 5.833
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
				arg_251_0:Play416111059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.45

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(416111058)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 18 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 18)

				if (18 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 18)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111058", "story_v_out_416111.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_416111", "416111058", "story_v_out_416111.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_416111", "416111058", "story_v_out_416111.awb")

						arg_251_1:RecordAudio("416111058", var_254_6)
						arg_251_1:RecordAudio("416111058", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416111", "416111058", "story_v_out_416111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416111", "416111058", "story_v_out_416111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416111059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416111059
		arg_255_1.duration_ = 4.13

		local var_255_0 = {
			zh = 3.2,
			ja = 4.133
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
			arg_255_1.auto_ = false
		end

		function arg_255_1.playNext_(arg_257_0)
			arg_255_1.onStoryFinished_()
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPosSS1605 = arg_255_1.bgs_.SS1605.transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.bgs_.SS1605.transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPosSS1605, Vector3.New(0, 0.9, 8.5), (arg_255_1.time_ - 0) / var_258_0)
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.bgs_.SS1605.transform.localPosition = Vector3.New(0, 0.9, 8.5)
			end

			local var_258_1 = arg_255_1.bgs_.SS1605.transform

			if 0.0339999999999998 < arg_255_1.time_ and arg_255_1.time_ <= 0.0339999999999998 + arg_258_0 then
				arg_255_1.var_.moveOldPosSS1605 = var_258_1.localPosition
			end

			local var_258_2 = 0.466

			if 0.0339999999999998 <= arg_255_1.time_ and arg_255_1.time_ < 0.0339999999999998 + var_258_2 then
				var_258_1.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPosSS1605, Vector3.New(0, 0.95, 9), (arg_255_1.time_ - 0.0339999999999998) / var_258_2)
			end

			if arg_255_1.time_ >= 0.0339999999999998 + var_258_2 and arg_255_1.time_ < 0.0339999999999998 + var_258_2 + arg_258_0 then
				var_258_1.localPosition = Vector3.New(0, 0.95, 9)
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_3 = 0.5
			local var_258_4 = 0.25

			if 0.5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_5 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_5:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(416111059)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 10 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_7) / 10)

				if (10 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_7) / 10)) > 0 and var_258_4 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9
					var_258_3 = var_258_3 + 0.3

					if var_258_9 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_3
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416111", "416111059", "story_v_out_416111.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_out_416111", "416111059", "story_v_out_416111.awb") / 1000

					if var_258_10 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_3
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_out_416111", "416111059", "story_v_out_416111.awb")

						arg_255_1:RecordAudio("416111059", var_258_11)
						arg_255_1:RecordAudio("416111059", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416111", "416111059", "story_v_out_416111.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416111", "416111059", "story_v_out_416111.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = var_258_3 + 0.3
			local var_258_13 = math.max(var_258_4, arg_255_1.talkMaxDuration)

			if var_258_3 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_12 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_12) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_12 + var_258_13 and arg_255_1.time_ < var_258_12 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1605",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.466,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS1604",
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1605"
	},
	voices = {
		"story_v_out_416111.awb"
	}
}
