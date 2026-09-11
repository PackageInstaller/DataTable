return {
	Play322131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.MS2203 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2203")
				var_4_0.name = "MS2203"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.MS2203 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.MS2203

				arg_1_1.bgs_.MS2203.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2203" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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

			local var_4_16 = arg_1_1.bgs_.MS2203.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2203 = var_4_16.localPosition
			end

			local var_4_17 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2203, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0) / var_4_17)
			end

			if arg_1_1.time_ >= 0 + var_4_17 and arg_1_1.time_ < 0 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_18 = arg_1_1.var_.effect1001

				if not arg_1_1.var_.effect1001 then
					var_4_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), manager.ui.mainCamera.transform)
					var_4_18.name = "1001"
					arg_1_1.var_.effect1001 = var_4_18
				else
					var_4_18.transform:SetParent(var_4_9000)
				end

				var_4_18.transform.localPosition = Vector3.New(0, 0, -2.5)
				var_4_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.55

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(322131001).content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 22 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 22)

				if (22 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 22)) > 0 and var_4_21 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_20 = var_4_20 + 0.3

					if var_4_25 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_20 + 0.3
			local var_4_27 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2203",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322131002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.75

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(322131002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 30 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 30)

				if (30 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 30)) > 0 and var_12_0 < var_12_3 then
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
	Play322131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322131003
		arg_13_1.duration_ = 7.63

		local var_13_0 = {
			zh = 6.566,
			ja = 7.633
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
				arg_13_0:Play322131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPosMS2203 = arg_13_1.bgs_.MS2203.transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.bgs_.MS2203.transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPosMS2203, Vector3.New(0, 1, 10), (arg_13_1.time_ - 0) / var_16_0)
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.bgs_.MS2203.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_16_1 = arg_13_1.bgs_.MS2203.transform

			if 0.0340000000000001 < arg_13_1.time_ and arg_13_1.time_ <= 0.0340000000000001 + arg_16_0 then
				arg_13_1.var_.moveOldPosMS2203 = var_16_1.localPosition
			end

			local var_16_2 = 0.966

			if 0.0340000000000001 <= arg_13_1.time_ and arg_13_1.time_ < 0.0340000000000001 + var_16_2 then
				var_16_1.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPosMS2203, Vector3.New(-0.3, 0.9, 9.5), (arg_13_1.time_ - 0.0340000000000001) / var_16_2)
			end

			if arg_13_1.time_ >= 0.0340000000000001 + var_16_2 and arg_13_1.time_ < 0.0340000000000001 + var_16_2 + arg_16_0 then
				var_16_1.localPosition = Vector3.New(-0.3, 0.9, 9.5)
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_3 = 1
			local var_16_4 = 0.6

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_5 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_5:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(322131003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 24 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_7) / 24)

				if (24 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_7) / 24)) > 0 and var_16_4 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9
					var_16_3 = var_16_3 + 0.3

					if var_16_9 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131003", "story_v_out_322131.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131003", "story_v_out_322131.awb") / 1000

					if var_16_10 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_3
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_322131", "322131003", "story_v_out_322131.awb")

						arg_13_1:RecordAudio("322131003", var_16_11)
						arg_13_1:RecordAudio("322131003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322131", "322131003", "story_v_out_322131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322131", "322131003", "story_v_out_322131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = var_16_3 + 0.3
			local var_16_13 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.966,
				className = "StoryMoveNode",
				startTime = 0.0340000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play322131004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 322131004
		arg_19_1.duration_ = 7.5

		local var_19_0 = {
			zh = 2.833,
			ja = 7.5
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
				arg_19_0:Play322131005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.2

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:GetWordFromCfg(322131004)
				local var_22_2 = arg_19_1:FormatText(var_22_1.content)

				arg_19_1.text_.text = var_22_2

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 8 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_2) / 8)

				if (8 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_2) / 8)) > 0 and var_22_0 < var_22_4 then
					arg_19_1.talkMaxDuration = var_22_4

					if var_22_4 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_4 + 0
					end
				end

				arg_19_1.text_.text = var_22_2
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131004", "story_v_out_322131.awb") ~= 0 then
					local var_22_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131004", "story_v_out_322131.awb") / 1000

					if var_22_5 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + 0
					end

					if var_22_1.prefab_name ~= "" and arg_19_1.actors_[var_22_1.prefab_name] ~= nil then
						local var_22_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_1.prefab_name].transform, "story_v_out_322131", "322131004", "story_v_out_322131.awb")

						arg_19_1:RecordAudio("322131004", var_22_6)
						arg_19_1:RecordAudio("322131004", var_22_6)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322131", "322131004", "story_v_out_322131.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322131", "322131004", "story_v_out_322131.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play322131005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322131005
		arg_23_1.duration_ = 9.23

		local var_23_0 = {
			zh = 7.4,
			ja = 9.233
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
				arg_23_0:Play322131006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.7

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(322131005)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 28 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 28)

				if (28 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 28)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131005", "story_v_out_322131.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131005", "story_v_out_322131.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_322131", "322131005", "story_v_out_322131.awb")

						arg_23_1:RecordAudio("322131005", var_26_6)
						arg_23_1:RecordAudio("322131005", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322131", "322131005", "story_v_out_322131.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322131", "322131005", "story_v_out_322131.awb")
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
	Play322131006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322131006
		arg_27_1.duration_ = 3.2

		local var_27_0 = {
			zh = 2.166,
			ja = 3.2
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
				arg_27_0:Play322131007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			if arg_27_1.time_ >= 0 + 0.166666666666667 and arg_27_1.time_ < 0 + 0.166666666666667 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			local var_30_0 = 0
			local var_30_1 = 0.075

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_2 = arg_27_1:GetWordFromCfg(322131006)
				local var_30_3 = arg_27_1:FormatText(var_30_2.content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 3 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 3)

				if (3 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 3)) > 0 and var_30_1 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131006", "story_v_out_322131.awb") ~= 0 then
					local var_30_6 = manager.audio:GetVoiceLength("story_v_out_322131", "322131006", "story_v_out_322131.awb") / 1000

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end

					if var_30_2.prefab_name ~= "" and arg_27_1.actors_[var_30_2.prefab_name] ~= nil then
						local var_30_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_2.prefab_name].transform, "story_v_out_322131", "322131006", "story_v_out_322131.awb")

						arg_27_1:RecordAudio("322131006", var_30_7)
						arg_27_1:RecordAudio("322131006", var_30_7)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322131", "322131006", "story_v_out_322131.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322131", "322131006", "story_v_out_322131.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play322131007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322131007
		arg_31_1.duration_ = 9.57

		local var_31_0 = {
			zh = 8.2,
			ja = 9.566
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
				arg_31_0:Play322131008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.bgs_.L14f == nil then
				local var_34_0 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_34_0.name = "L14f"
				var_34_0.transform.parent = arg_31_1.stage_.transform
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_.L14f = var_34_0
			end

			if 2.00000000298023 < arg_31_1.time_ and arg_31_1.time_ <= 2.00000000298023 + arg_34_0 then
				local var_34_1 = arg_31_1.bgs_.L14f

				arg_31_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_34_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_2 = var_34_1:GetComponent("SpriteRenderer")

				if var_34_2 and var_34_2.sprite then
					local var_34_3 = 2 * (var_34_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_34_1.transform.localScale = Vector3.New(var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "L14f" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_4 = 4.00000000298023

			if 4.00000000298023 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			if arg_31_1.time_ >= var_34_4 + 0.3 and arg_31_1.time_ < var_34_4 + 0.3 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			local var_34_5 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_6 = 2

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 then
				local var_34_7 = Color.New(0, 0, 0)

				var_34_7.a = Mathf.Lerp(0, 1, (arg_31_1.time_ - var_34_5) / var_34_6)
				arg_31_1.mask_.color = var_34_7
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 then
				local var_34_8 = Color.New(0, 0, 0)

				var_34_8.a = 1
				arg_31_1.mask_.color = var_34_8
			end

			local var_34_9 = 2

			if 2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_10 = 2

			if var_34_9 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_10 then
				local var_34_11 = Color.New(0, 0, 0)

				var_34_11.a = Mathf.Lerp(1, 0, (arg_31_1.time_ - var_34_9) / var_34_10)
				arg_31_1.mask_.color = var_34_11
			end

			if arg_31_1.time_ >= var_34_9 + var_34_10 and arg_31_1.time_ < var_34_9 + var_34_10 + arg_34_0 then
				local var_34_12 = Color.New(0, 0, 0)

				arg_31_1.mask_.enabled = false
				var_34_12.a = 0
				arg_31_1.mask_.color = var_34_12
			end

			local var_34_13 = "1284ui_story"

			if arg_31_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_34_14 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_31_1.stage_.transform)

				var_34_14.name = var_34_13
				var_34_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_[var_34_13] = var_34_14

				local var_34_15 = var_34_14:GetComponentInChildren(typeof(CharacterEffect))

				var_34_15.enabled = true

				local var_34_16 = GameObjectTools.GetOrAddComponent(var_34_14, typeof(DynamicBoneHelper))

				if var_34_16 then
					var_34_16:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_15.transform, false)

				arg_31_1.var_[var_34_13 .. "Animator"] = var_34_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_[var_34_13 .. "Animator"].applyRootMotion = true
				arg_31_1.var_[var_34_13 .. "LipSync"] = var_34_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_17 = arg_31_1.actors_["1284ui_story"].transform

			if 3.8 < arg_31_1.time_ and arg_31_1.time_ <= 3.8 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = var_34_17.localPosition

				arg_31_1:ShowWeapon(arg_31_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_34_18 = 0.001

			if 3.8 <= arg_31_1.time_ and arg_31_1.time_ < 3.8 + var_34_18 then
				var_34_17.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_31_1.time_ - 3.8) / var_34_18)
				var_34_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_17.position).x, (manager.ui.mainCamera.transform.position - var_34_17.position).y, (manager.ui.mainCamera.transform.position - var_34_17.position).z)
				var_34_17.localEulerAngles.z = 0
				var_34_17.localEulerAngles.x = 0
				var_34_17.localEulerAngles = var_34_17.localEulerAngles
			end

			if arg_31_1.time_ >= 3.8 + var_34_18 and arg_31_1.time_ < 3.8 + var_34_18 + arg_34_0 then
				var_34_17.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_34_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_17.position).x, (manager.ui.mainCamera.transform.position - var_34_17.position).y, (manager.ui.mainCamera.transform.position - var_34_17.position).z)
				var_34_17.localEulerAngles.z = 0
				var_34_17.localEulerAngles.x = 0
				var_34_17.localEulerAngles = var_34_17.localEulerAngles
			end

			local var_34_19 = arg_31_1.actors_["1284ui_story"]

			if 3.8 < arg_31_1.time_ and arg_31_1.time_ <= 3.8 + arg_34_0 and not isNil(var_34_19) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_20 = 0.200000002980232

			if 3.8 <= arg_31_1.time_ and arg_31_1.time_ < 3.8 + var_34_20 and not isNil(var_34_19) then
				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_19) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 3.8 + var_34_20 and arg_31_1.time_ < 3.8 + var_34_20 + arg_34_0 and not isNil(var_34_19) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 3.8 < arg_31_1.time_ and arg_31_1.time_ <= 3.8 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 3.8 < arg_31_1.time_ and arg_31_1.time_ <= 3.8 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.166666666666667 < arg_31_1.time_ and arg_31_1.time_ <= 0.166666666666667 + arg_34_0 then
				arg_31_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.53333333333333 < arg_31_1.time_ and arg_31_1.time_ <= 1.53333333333333 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 2 < arg_31_1.time_ and arg_31_1.time_ <= 2 + arg_34_0 then
				if arg_31_1.var_.effect1001 then
					Object.Destroy(arg_31_1.var_.effect1001)

					arg_31_1.var_.effect1001 = nil
				end
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_25 = 4
			local var_34_26 = 0.45

			if 4 < arg_31_1.time_ and arg_31_1.time_ <= var_34_25 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_27 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_27:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_28 = arg_31_1:GetWordFromCfg(322131007)
				local var_34_29 = arg_31_1:FormatText(var_34_28.content)

				arg_31_1.text_.text = var_34_29

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_31 = 18 <= 0 and var_34_26 or var_34_26 * (utf8.len(var_34_29) / 18)

				if (18 <= 0 and var_34_26 or var_34_26 * (utf8.len(var_34_29) / 18)) > 0 and var_34_26 < var_34_31 then
					arg_31_1.talkMaxDuration = var_34_31
					var_34_25 = var_34_25 + 0.3

					if var_34_31 + var_34_25 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_31 + var_34_25
					end
				end

				arg_31_1.text_.text = var_34_29
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131007", "story_v_out_322131.awb") ~= 0 then
					local var_34_32 = manager.audio:GetVoiceLength("story_v_out_322131", "322131007", "story_v_out_322131.awb") / 1000

					if var_34_32 + var_34_25 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_32 + var_34_25
					end

					if var_34_28.prefab_name ~= "" and arg_31_1.actors_[var_34_28.prefab_name] ~= nil then
						local var_34_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_28.prefab_name].transform, "story_v_out_322131", "322131007", "story_v_out_322131.awb")

						arg_31_1:RecordAudio("322131007", var_34_33)
						arg_31_1:RecordAudio("322131007", var_34_33)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322131", "322131007", "story_v_out_322131.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322131", "322131007", "story_v_out_322131.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_34 = var_34_25 + 0.3
			local var_34_35 = math.max(var_34_26, arg_31_1.talkMaxDuration)

			if var_34_25 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_34 + var_34_35 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_34) / var_34_35

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_34 + var_34_35 and arg_31_1.time_ < var_34_34 + var_34_35 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play322131008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322131008
		arg_37_1.duration_ = 5.4

		local var_37_0 = {
			zh = 3.833,
			ja = 5.4
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
				arg_37_0:Play322131009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "1043ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1043ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["1043ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["1043ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["1043ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1043ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["1043ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1043ui_story == nil then
				arg_37_1.var_.characterEffect1043ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect1043ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1043ui_story then
				arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_40_8 = arg_37_1.actors_["1284ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = var_40_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_9 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.characterEffect1284ui_story and not isNil(var_40_8) then
					arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_9)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.characterEffect1284ui_story then
				arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				if arg_37_1.var_.characterEffect1043ui_story == nil then
					arg_37_1.var_.characterEffect1043ui_story = arg_37_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_40_10 = arg_37_1.var_.characterEffect1043ui_story

				arg_37_1.var_.characterEffect1043ui_story.imageEffect:turnOff()

				var_40_10.interferenceEffect.enabled = true
				var_40_10.interferenceEffect.noise = 0
				var_40_10.interferenceEffect.simTimeScale = 1
				var_40_10.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				if arg_37_1.var_.characterEffect1043ui_story == nil then
					arg_37_1.var_.characterEffect1043ui_story = arg_37_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_37_1.var_.characterEffect1043ui_story.imageEffect:turnOn(false)
			end

			local var_40_12 = 0
			local var_40_13 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(322131008)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 19 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 19)

				if (19 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 19)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131008", "story_v_out_322131.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_322131", "322131008", "story_v_out_322131.awb") / 1000

					if var_40_18 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_12
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_322131", "322131008", "story_v_out_322131.awb")

						arg_37_1:RecordAudio("322131008", var_40_19)
						arg_37_1:RecordAudio("322131008", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322131", "322131008", "story_v_out_322131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322131", "322131008", "story_v_out_322131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_20 and arg_37_1.time_ < var_40_12 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play322131009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322131009
		arg_41_1.duration_ = 6.97

		local var_41_0 = {
			zh = 5.233,
			ja = 6.966
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
				arg_41_0:Play322131010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				if arg_41_1.var_.characterEffect1043ui_story == nil then
					arg_41_1.var_.characterEffect1043ui_story = arg_41_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_44_0 = arg_41_1.var_.characterEffect1043ui_story

				arg_41_1.var_.characterEffect1043ui_story.imageEffect:turnOff()

				var_44_0.interferenceEffect.enabled = true
				var_44_0.interferenceEffect.noise = 0
				var_44_0.interferenceEffect.simTimeScale = 1
				var_44_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				if arg_41_1.var_.characterEffect1043ui_story == nil then
					arg_41_1.var_.characterEffect1043ui_story = arg_41_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_41_1.var_.characterEffect1043ui_story.imageEffect:turnOn(false)
			end

			local var_44_2 = 0
			local var_44_3 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(322131009)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 27 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 27)

				if (27 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 27)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131009", "story_v_out_322131.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131009", "story_v_out_322131.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_322131", "322131009", "story_v_out_322131.awb")

						arg_41_1:RecordAudio("322131009", var_44_9)
						arg_41_1:RecordAudio("322131009", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322131", "322131009", "story_v_out_322131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322131", "322131009", "story_v_out_322131.awb")
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
	Play322131010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322131010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322131011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1043ui_story"]) and arg_45_1.var_.characterEffect1043ui_story == nil then
				arg_45_1.var_.characterEffect1043ui_story = arg_45_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1043ui_story"]) then
				if arg_45_1.var_.characterEffect1043ui_story and not isNil(arg_45_1.actors_["1043ui_story"]) then
					arg_45_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1043ui_story"]) and arg_45_1.var_.characterEffect1043ui_story then
				arg_45_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(322131010).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)

				if (11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322131011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322131011
		arg_49_1.duration_ = 3.5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322131012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1043ui_story"]) and arg_49_1.var_.characterEffect1043ui_story == nil then
				arg_49_1.var_.characterEffect1043ui_story = arg_49_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1043ui_story"]) then
				if arg_49_1.var_.characterEffect1043ui_story and not isNil(arg_49_1.actors_["1043ui_story"]) then
					arg_49_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1043ui_story"]) and arg_49_1.var_.characterEffect1043ui_story then
				arg_49_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				if arg_49_1.var_.characterEffect1043ui_story == nil then
					arg_49_1.var_.characterEffect1043ui_story = arg_49_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_52_2 = arg_49_1.var_.characterEffect1043ui_story

				arg_49_1.var_.characterEffect1043ui_story.imageEffect:turnOff()

				var_52_2.interferenceEffect.enabled = true
				var_52_2.interferenceEffect.noise = 0
				var_52_2.interferenceEffect.simTimeScale = 1
				var_52_2.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				if arg_49_1.var_.characterEffect1043ui_story == nil then
					arg_49_1.var_.characterEffect1043ui_story = arg_49_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_49_1.var_.characterEffect1043ui_story.imageEffect:turnOn(false)
			end

			local var_52_4 = 0
			local var_52_5 = 0.2

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(322131011)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 8 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 8)

				if (8 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 8)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131011", "story_v_out_322131.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131011", "story_v_out_322131.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_322131", "322131011", "story_v_out_322131.awb")

						arg_49_1:RecordAudio("322131011", var_52_11)
						arg_49_1:RecordAudio("322131011", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322131", "322131011", "story_v_out_322131.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322131", "322131011", "story_v_out_322131.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322131012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322131012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322131013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1043ui_story = arg_53_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1043ui_story"].transform.position).z)
				arg_53_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1043ui_story"].transform.localEulerAngles = arg_53_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1043ui_story"].transform.position).z)
				arg_53_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1043ui_story"].transform.localEulerAngles = arg_53_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1284ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1284ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(0, 100, 0)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				if arg_53_1.var_.characterEffect1043ui_story == nil then
					arg_53_1.var_.characterEffect1043ui_story = arg_53_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_56_3 = arg_53_1.var_.characterEffect1043ui_story

				arg_53_1.var_.characterEffect1043ui_story.imageEffect:turnOff()

				var_56_3.interferenceEffect.enabled = false
				var_56_3.interferenceEffect.noise = 0
				var_56_3.interferenceEffect.simTimeScale = 1
				var_56_3.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				if arg_53_1.var_.characterEffect1043ui_story == nil then
					arg_53_1.var_.characterEffect1043ui_story = arg_53_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_53_1.var_.characterEffect1043ui_story.imageEffect:turnOff()
			end

			local var_56_5 = 0
			local var_56_6 = 1.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(322131012).content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 58 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_7) / 58)

				if (58 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_7) / 58)) > 0 and var_56_6 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_10 and arg_53_1.time_ < var_56_5 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play322131013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322131013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322131014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.175

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

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(322131013).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 7 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 7)

				if (7 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 7)) > 0 and var_60_0 < var_60_3 then
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
	Play322131014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322131014
		arg_61_1.duration_ = 12.3

		local var_61_0 = {
			zh = 9.6,
			ja = 12.3
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
				arg_61_0:Play322131015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				local var_64_0 = arg_61_1.bgs_.MS2203

				arg_61_1.bgs_.MS2203.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_1 = var_64_0:GetComponent("SpriteRenderer")

				if var_64_1 and var_64_1.sprite then
					local var_64_2 = 2 * (var_64_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_0.transform.localScale = Vector3.New(var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "MS2203" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_3 = 3.999999999999

			if 3.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_3 + 0.3 and arg_61_1.time_ < var_64_3 + 0.3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_4 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_5 = 2

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_5 then
				local var_64_6 = Color.New(0, 0, 0)

				var_64_6.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_4) / var_64_5)
				arg_61_1.mask_.color = var_64_6
			end

			if arg_61_1.time_ >= var_64_4 + var_64_5 and arg_61_1.time_ < var_64_4 + var_64_5 + arg_64_0 then
				local var_64_7 = Color.New(0, 0, 0)

				var_64_7.a = 1
				arg_61_1.mask_.color = var_64_7
			end

			local var_64_8 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_9 = 2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 then
				local var_64_10 = Color.New(0, 0, 0)

				var_64_10.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_8) / var_64_9)
				arg_61_1.mask_.color = var_64_10
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 then
				local var_64_11 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_11.a = 0
				arg_61_1.mask_.color = var_64_11
			end

			if 0.1 < arg_61_1.time_ and arg_61_1.time_ <= 0.1 + arg_64_0 then
				arg_61_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1.6 < arg_61_1.time_ and arg_61_1.time_ <= 1.6 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_64_14 = arg_61_1.bgs_.MS2203.transform

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				arg_61_1.var_.moveOldPosMS2203 = var_64_14.localPosition
			end

			local var_64_15 = 0.001

			if 2 <= arg_61_1.time_ and arg_61_1.time_ < 2 + var_64_15 then
				var_64_14.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosMS2203, Vector3.New(-0.3, 0.9, 6), (arg_61_1.time_ - 2) / var_64_15)
			end

			if arg_61_1.time_ >= 2 + var_64_15 and arg_61_1.time_ < 2 + var_64_15 + arg_64_0 then
				var_64_14.localPosition = Vector3.New(-0.3, 0.9, 6)
			end

			local var_64_16 = arg_61_1.bgs_.MS2203.transform

			if 2.01666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 2.01666666666667 + arg_64_0 then
				arg_61_1.var_.moveOldPosMS2203 = var_64_16.localPosition
			end

			local var_64_17 = 1.98333333333233

			if 2.01666666666667 <= arg_61_1.time_ and arg_61_1.time_ < 2.01666666666667 + var_64_17 then
				var_64_16.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosMS2203, Vector3.New(0, 1, 9), (arg_61_1.time_ - 2.01666666666667) / var_64_17)
			end

			if arg_61_1.time_ >= 2.01666666666667 + var_64_17 and arg_61_1.time_ < 2.01666666666667 + var_64_17 + arg_64_0 then
				var_64_16.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_18 = 4
			local var_64_19 = 0.5

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_20 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_20:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_21 = arg_61_1:GetWordFromCfg(322131014)
				local var_64_22 = arg_61_1:FormatText(var_64_21.content)

				arg_61_1.text_.text = var_64_22

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_24 = 20 <= 0 and var_64_19 or var_64_19 * (utf8.len(var_64_22) / 20)

				if (20 <= 0 and var_64_19 or var_64_19 * (utf8.len(var_64_22) / 20)) > 0 and var_64_19 < var_64_24 then
					arg_61_1.talkMaxDuration = var_64_24
					var_64_18 = var_64_18 + 0.3

					if var_64_24 + var_64_18 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_18
					end
				end

				arg_61_1.text_.text = var_64_22
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131014", "story_v_out_322131.awb") ~= 0 then
					local var_64_25 = manager.audio:GetVoiceLength("story_v_out_322131", "322131014", "story_v_out_322131.awb") / 1000

					if var_64_25 + var_64_18 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_25 + var_64_18
					end

					if var_64_21.prefab_name ~= "" and arg_61_1.actors_[var_64_21.prefab_name] ~= nil then
						local var_64_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_21.prefab_name].transform, "story_v_out_322131", "322131014", "story_v_out_322131.awb")

						arg_61_1:RecordAudio("322131014", var_64_26)
						arg_61_1:RecordAudio("322131014", var_64_26)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322131", "322131014", "story_v_out_322131.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322131", "322131014", "story_v_out_322131.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_27 = var_64_18 + 0.3
			local var_64_28 = math.max(var_64_19, arg_61_1.talkMaxDuration)

			if var_64_18 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_27 + var_64_28 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_27) / var_64_28

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_27 + var_64_28 and arg_61_1.time_ < var_64_27 + var_64_28 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2203",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.98333333333233,
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play322131015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322131015
		arg_67_1.duration_ = 5.73

		local var_67_0 = {
			zh = 2.2,
			ja = 5.733
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
				arg_67_0:Play322131016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.125

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(322131015)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 5 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 5)

				if (5 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 5)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131015", "story_v_out_322131.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131015", "story_v_out_322131.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_322131", "322131015", "story_v_out_322131.awb")

						arg_67_1:RecordAudio("322131015", var_70_6)
						arg_67_1:RecordAudio("322131015", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322131", "322131015", "story_v_out_322131.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322131", "322131015", "story_v_out_322131.awb")
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
	Play322131016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322131016
		arg_71_1.duration_ = 6.03

		local var_71_0 = {
			zh = 6.033,
			ja = 5.1
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
				arg_71_0:Play322131017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.525

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(322131016)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 21 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 21)

				if (21 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 21)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131016", "story_v_out_322131.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131016", "story_v_out_322131.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_322131", "322131016", "story_v_out_322131.awb")

						arg_71_1:RecordAudio("322131016", var_74_6)
						arg_71_1:RecordAudio("322131016", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322131", "322131016", "story_v_out_322131.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322131", "322131016", "story_v_out_322131.awb")
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
	Play322131017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322131017
		arg_75_1.duration_ = 18.5

		local var_75_0 = {
			zh = 7.666,
			ja = 18.5
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
				arg_75_0:Play322131018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(322131017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 27)

				if (27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 27)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131017", "story_v_out_322131.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131017", "story_v_out_322131.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_322131", "322131017", "story_v_out_322131.awb")

						arg_75_1:RecordAudio("322131017", var_78_6)
						arg_75_1:RecordAudio("322131017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322131", "322131017", "story_v_out_322131.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322131", "322131017", "story_v_out_322131.awb")
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
	Play322131018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322131018
		arg_79_1.duration_ = 12.9

		local var_79_0 = {
			zh = 4.333,
			ja = 12.9
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
				arg_79_0:Play322131019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.35

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:GetWordFromCfg(322131018)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 14 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 14)

				if (14 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 14)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131018", "story_v_out_322131.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131018", "story_v_out_322131.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_322131", "322131018", "story_v_out_322131.awb")

						arg_79_1:RecordAudio("322131018", var_82_6)
						arg_79_1:RecordAudio("322131018", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322131", "322131018", "story_v_out_322131.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322131", "322131018", "story_v_out_322131.awb")
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
	Play322131019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322131019
		arg_83_1.duration_ = 2.37

		local var_83_0 = {
			zh = 2.366,
			ja = 1.833
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322131020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.2

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(322131019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 8 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 8)

				if (8 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 8)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131019", "story_v_out_322131.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131019", "story_v_out_322131.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_322131", "322131019", "story_v_out_322131.awb")

						arg_83_1:RecordAudio("322131019", var_86_6)
						arg_83_1:RecordAudio("322131019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322131", "322131019", "story_v_out_322131.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322131", "322131019", "story_v_out_322131.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322131020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322131020
		arg_87_1.duration_ = 28.17

		local var_87_0 = {
			zh = 11.533,
			ja = 28.166
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
				arg_87_0:Play322131021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.95

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(322131020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 38 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 38)

				if (38 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 38)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131020", "story_v_out_322131.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131020", "story_v_out_322131.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_322131", "322131020", "story_v_out_322131.awb")

						arg_87_1:RecordAudio("322131020", var_90_6)
						arg_87_1:RecordAudio("322131020", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322131", "322131020", "story_v_out_322131.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322131", "322131020", "story_v_out_322131.awb")
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
	Play322131021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322131021
		arg_91_1.duration_ = 17.8

		local var_91_0 = {
			zh = 4.5,
			ja = 17.8
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
				arg_91_0:Play322131022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.325

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(322131021)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 13 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 13)

				if (13 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 13)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131021", "story_v_out_322131.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131021", "story_v_out_322131.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_322131", "322131021", "story_v_out_322131.awb")

						arg_91_1:RecordAudio("322131021", var_94_6)
						arg_91_1:RecordAudio("322131021", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322131", "322131021", "story_v_out_322131.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322131", "322131021", "story_v_out_322131.awb")
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
	Play322131022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322131022
		arg_95_1.duration_ = 5.97

		local var_95_0 = {
			zh = 5.966,
			ja = 5.733
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
				arg_95_0:Play322131023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.5

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(322131022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 20 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 20)

				if (20 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 20)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131022", "story_v_out_322131.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131022", "story_v_out_322131.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_322131", "322131022", "story_v_out_322131.awb")

						arg_95_1:RecordAudio("322131022", var_98_6)
						arg_95_1:RecordAudio("322131022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322131", "322131022", "story_v_out_322131.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322131", "322131022", "story_v_out_322131.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play322131023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322131023
		arg_99_1.duration_ = 8.17

		local var_99_0 = {
			zh = 6.7,
			ja = 8.166
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
				arg_99_0:Play322131024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.bgs_.L10j == nil then
				local var_102_0 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10j")
				var_102_0.name = "L10j"
				var_102_0.transform.parent = arg_99_1.stage_.transform
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_.L10j = var_102_0
			end

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				local var_102_1 = arg_99_1.bgs_.L10j

				arg_99_1.bgs_.L10j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_2 = var_102_1:GetComponent("SpriteRenderer")

				if var_102_2 and var_102_2.sprite then
					local var_102_3 = 2 * (var_102_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_1.transform.localScale = Vector3.New(var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "L10j" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_4 = 4

			if 4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_4 + 0.3 and arg_99_1.time_ < var_102_4 + 0.3 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_5 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_6 = 2

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 then
				local var_102_7 = Color.New(0, 0, 0)

				var_102_7.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - var_102_5) / var_102_6)
				arg_99_1.mask_.color = var_102_7
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 then
				local var_102_8 = Color.New(0, 0, 0)

				var_102_8.a = 1
				arg_99_1.mask_.color = var_102_8
			end

			local var_102_9 = 2

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_10 = 2

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_10 then
				local var_102_11 = Color.New(0, 0, 0)

				var_102_11.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_9) / var_102_10)
				arg_99_1.mask_.color = var_102_11
			end

			if arg_99_1.time_ >= var_102_9 + var_102_10 and arg_99_1.time_ < var_102_9 + var_102_10 + arg_102_0 then
				local var_102_12 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_12.a = 0
				arg_99_1.mask_.color = var_102_12
			end

			local var_102_13 = "1211ui_story"

			if arg_99_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_102_14 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_99_1.stage_.transform)

				var_102_14.name = var_102_13
				var_102_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_[var_102_13] = var_102_14

				local var_102_15 = var_102_14:GetComponentInChildren(typeof(CharacterEffect))

				var_102_15.enabled = true

				local var_102_16 = GameObjectTools.GetOrAddComponent(var_102_14, typeof(DynamicBoneHelper))

				if var_102_16 then
					var_102_16:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_15.transform, false)

				arg_99_1.var_[var_102_13 .. "Animator"] = var_102_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_[var_102_13 .. "Animator"].applyRootMotion = true
				arg_99_1.var_[var_102_13 .. "LipSync"] = var_102_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_17 = arg_99_1.actors_["1211ui_story"].transform

			if 3.8 < arg_99_1.time_ and arg_99_1.time_ <= 3.8 + arg_102_0 then
				arg_99_1.var_.moveOldPos1211ui_story = var_102_17.localPosition
			end

			local var_102_18 = 0.001

			if 3.8 <= arg_99_1.time_ and arg_99_1.time_ < 3.8 + var_102_18 then
				var_102_17.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_99_1.time_ - 3.8) / var_102_18)
				var_102_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_17.position).x, (manager.ui.mainCamera.transform.position - var_102_17.position).y, (manager.ui.mainCamera.transform.position - var_102_17.position).z)
				var_102_17.localEulerAngles.z = 0
				var_102_17.localEulerAngles.x = 0
				var_102_17.localEulerAngles = var_102_17.localEulerAngles
			end

			if arg_99_1.time_ >= 3.8 + var_102_18 and arg_99_1.time_ < 3.8 + var_102_18 + arg_102_0 then
				var_102_17.localPosition = Vector3.New(0, -0.67, -6.07)
				var_102_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_17.position).x, (manager.ui.mainCamera.transform.position - var_102_17.position).y, (manager.ui.mainCamera.transform.position - var_102_17.position).z)
				var_102_17.localEulerAngles.z = 0
				var_102_17.localEulerAngles.x = 0
				var_102_17.localEulerAngles = var_102_17.localEulerAngles
			end

			local var_102_19 = arg_99_1.actors_["1211ui_story"]

			if 3.8 < arg_99_1.time_ and arg_99_1.time_ <= 3.8 + arg_102_0 and not isNil(var_102_19) and arg_99_1.var_.characterEffect1211ui_story == nil then
				arg_99_1.var_.characterEffect1211ui_story = var_102_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_20 = 0.200000002980232

			if 3.8 <= arg_99_1.time_ and arg_99_1.time_ < 3.8 + var_102_20 and not isNil(var_102_19) then
				if arg_99_1.var_.characterEffect1211ui_story and not isNil(var_102_19) then
					arg_99_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 3.8 + var_102_20 and arg_99_1.time_ < 3.8 + var_102_20 + arg_102_0 and not isNil(var_102_19) and arg_99_1.var_.characterEffect1211ui_story then
				arg_99_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 3.8 < arg_99_1.time_ and arg_99_1.time_ <= 3.8 + arg_102_0 then
				arg_99_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 3.8 < arg_99_1.time_ and arg_99_1.time_ <= 3.8 + arg_102_0 then
				arg_99_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_99_1.time_ and arg_99_1.time_ <= 0.1 + arg_102_0 then
				arg_99_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.6 < arg_99_1.time_ and arg_99_1.time_ <= 1.6 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_24 = 4
			local var_102_25 = 0.175

			if 4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_24 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_26 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_26:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_27 = arg_99_1:GetWordFromCfg(322131023)
				local var_102_28 = arg_99_1:FormatText(var_102_27.content)

				arg_99_1.text_.text = var_102_28

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_30 = 7 <= 0 and var_102_25 or var_102_25 * (utf8.len(var_102_28) / 7)

				if (7 <= 0 and var_102_25 or var_102_25 * (utf8.len(var_102_28) / 7)) > 0 and var_102_25 < var_102_30 then
					arg_99_1.talkMaxDuration = var_102_30
					var_102_24 = var_102_24 + 0.3

					if var_102_30 + var_102_24 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_30 + var_102_24
					end
				end

				arg_99_1.text_.text = var_102_28
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131023", "story_v_out_322131.awb") ~= 0 then
					local var_102_31 = manager.audio:GetVoiceLength("story_v_out_322131", "322131023", "story_v_out_322131.awb") / 1000

					if var_102_31 + var_102_24 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_31 + var_102_24
					end

					if var_102_27.prefab_name ~= "" and arg_99_1.actors_[var_102_27.prefab_name] ~= nil then
						local var_102_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_27.prefab_name].transform, "story_v_out_322131", "322131023", "story_v_out_322131.awb")

						arg_99_1:RecordAudio("322131023", var_102_32)
						arg_99_1:RecordAudio("322131023", var_102_32)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_322131", "322131023", "story_v_out_322131.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_322131", "322131023", "story_v_out_322131.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_33 = var_102_24 + 0.3
			local var_102_34 = math.max(var_102_25, arg_99_1.talkMaxDuration)

			if var_102_24 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_33 + var_102_34 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_33) / var_102_34

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_33 + var_102_34 and arg_99_1.time_ < var_102_33 + var_102_34 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play322131024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322131024
		arg_105_1.duration_ = 4

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322131025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.L17f == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L17f")
				var_108_0.name = "L17f"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.L17f = var_108_0
			end

			if 1 < arg_105_1.time_ and arg_105_1.time_ <= 1 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.L17f

				arg_105_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "L17f" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= var_108_4 + 0.3 and arg_105_1.time_ < var_108_4 + 0.3 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_5 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_6 = 1

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_5) / var_108_6)
				arg_105_1.mask_.color = var_108_7
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 then
				local var_108_8 = Color.New(0, 0, 0)

				var_108_8.a = 1
				arg_105_1.mask_.color = var_108_8
			end

			local var_108_9 = 1

			if 1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_10 = 1

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 then
				local var_108_11 = Color.New(0, 0, 0)

				var_108_11.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_9) / var_108_10)
				arg_105_1.mask_.color = var_108_11
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 then
				local var_108_12 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_12.a = 0
				arg_105_1.mask_.color = var_108_12
			end

			local var_108_13 = arg_105_1.actors_["1211ui_story"].transform

			if 0.95 < arg_105_1.time_ and arg_105_1.time_ <= 0.95 + arg_108_0 then
				arg_105_1.var_.moveOldPos1211ui_story = var_108_13.localPosition
			end

			local var_108_14 = 0.001

			if 0.95 <= arg_105_1.time_ and arg_105_1.time_ < 0.95 + var_108_14 then
				var_108_13.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0.95) / var_108_14)
				var_108_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_13.position).x, (manager.ui.mainCamera.transform.position - var_108_13.position).y, (manager.ui.mainCamera.transform.position - var_108_13.position).z)
				var_108_13.localEulerAngles.z = 0
				var_108_13.localEulerAngles.x = 0
				var_108_13.localEulerAngles = var_108_13.localEulerAngles
			end

			if arg_105_1.time_ >= 0.95 + var_108_14 and arg_105_1.time_ < 0.95 + var_108_14 + arg_108_0 then
				var_108_13.localPosition = Vector3.New(0, 100, 0)
				var_108_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_13.position).x, (manager.ui.mainCamera.transform.position - var_108_13.position).y, (manager.ui.mainCamera.transform.position - var_108_13.position).z)
				var_108_13.localEulerAngles.z = 0
				var_108_13.localEulerAngles.x = 0
				var_108_13.localEulerAngles = var_108_13.localEulerAngles
			end

			local var_108_15 = arg_105_1.actors_["1043ui_story"].transform

			if 1.8 < arg_105_1.time_ and arg_105_1.time_ <= 1.8 + arg_108_0 then
				arg_105_1.var_.moveOldPos1043ui_story = var_108_15.localPosition
			end

			local var_108_16 = 0.001

			if 1.8 <= arg_105_1.time_ and arg_105_1.time_ < 1.8 + var_108_16 then
				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_105_1.time_ - 1.8) / var_108_16)
				var_108_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_15.position).x, (manager.ui.mainCamera.transform.position - var_108_15.position).y, (manager.ui.mainCamera.transform.position - var_108_15.position).z)
				var_108_15.localEulerAngles.z = 0
				var_108_15.localEulerAngles.x = 0
				var_108_15.localEulerAngles = var_108_15.localEulerAngles
			end

			if arg_105_1.time_ >= 1.8 + var_108_16 and arg_105_1.time_ < 1.8 + var_108_16 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_108_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_15.position).x, (manager.ui.mainCamera.transform.position - var_108_15.position).y, (manager.ui.mainCamera.transform.position - var_108_15.position).z)
				var_108_15.localEulerAngles.z = 0
				var_108_15.localEulerAngles.x = 0
				var_108_15.localEulerAngles = var_108_15.localEulerAngles
			end

			local var_108_17 = arg_105_1.actors_["1043ui_story"]

			if 0.95 < arg_105_1.time_ and arg_105_1.time_ <= 0.95 + arg_108_0 and not isNil(var_108_17) and arg_105_1.var_.characterEffect1043ui_story == nil then
				arg_105_1.var_.characterEffect1043ui_story = var_108_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_18 = 0.05

			if 0.95 <= arg_105_1.time_ and arg_105_1.time_ < 0.95 + var_108_18 and not isNil(var_108_17) then
				if arg_105_1.var_.characterEffect1043ui_story and not isNil(var_108_17) then
					arg_105_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0.95 + var_108_18 and arg_105_1.time_ < 0.95 + var_108_18 + arg_108_0 and not isNil(var_108_17) and arg_105_1.var_.characterEffect1043ui_story then
				arg_105_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_108_20 = arg_105_1.actors_["1211ui_story"]

			if 1.8 < arg_105_1.time_ and arg_105_1.time_ <= 1.8 + arg_108_0 and not isNil(var_108_20) and arg_105_1.var_.characterEffect1211ui_story == nil then
				arg_105_1.var_.characterEffect1211ui_story = var_108_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_21 = 0.200000002980232

			if 1.8 <= arg_105_1.time_ and arg_105_1.time_ < 1.8 + var_108_21 and not isNil(var_108_20) then
				if arg_105_1.var_.characterEffect1211ui_story and not isNil(var_108_20) then
					arg_105_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 1.8) / var_108_21)
				end
			end

			if arg_105_1.time_ >= 1.8 + var_108_21 and arg_105_1.time_ < 1.8 + var_108_21 + arg_108_0 and not isNil(var_108_20) and arg_105_1.var_.characterEffect1211ui_story then
				arg_105_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 1.8 < arg_105_1.time_ and arg_105_1.time_ <= 1.8 + arg_108_0 then
				arg_105_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 1.8 < arg_105_1.time_ and arg_105_1.time_ <= 1.8 + arg_108_0 then
				arg_105_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_105_1.time_ and arg_105_1.time_ <= 0.1 + arg_108_0 then
				arg_105_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if 1.1 < arg_105_1.time_ and arg_105_1.time_ <= 1.1 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_24 = 2
			local var_108_25 = 0.05

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_26 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_26:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_27 = arg_105_1:GetWordFromCfg(322131024)
				local var_108_28 = arg_105_1:FormatText(var_108_27.content)

				arg_105_1.text_.text = var_108_28

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_30 = 2 <= 0 and var_108_25 or var_108_25 * (utf8.len(var_108_28) / 2)

				if (2 <= 0 and var_108_25 or var_108_25 * (utf8.len(var_108_28) / 2)) > 0 and var_108_25 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30
					var_108_24 = var_108_24 + 0.3

					if var_108_30 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_24
					end
				end

				arg_105_1.text_.text = var_108_28
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131024", "story_v_out_322131.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_322131", "322131024", "story_v_out_322131.awb") / 1000

					if var_108_31 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_24
					end

					if var_108_27.prefab_name ~= "" and arg_105_1.actors_[var_108_27.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_27.prefab_name].transform, "story_v_out_322131", "322131024", "story_v_out_322131.awb")

						arg_105_1:RecordAudio("322131024", var_108_32)
						arg_105_1:RecordAudio("322131024", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322131", "322131024", "story_v_out_322131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322131", "322131024", "story_v_out_322131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = var_108_24 + 0.3
			local var_108_34 = math.max(var_108_25, arg_105_1.talkMaxDuration)

			if var_108_24 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_33 + var_108_34 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_33) / var_108_34

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_33 + var_108_34 and arg_105_1.time_ < var_108_33 + var_108_34 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.95,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play322131025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322131025
		arg_111_1.duration_ = 8.13

		local var_111_0 = {
			zh = 6.866,
			ja = 8.133
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
				arg_111_0:Play322131026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.bgs_.L10k == nil then
				local var_114_0 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10k")
				var_114_0.name = "L10k"
				var_114_0.transform.parent = arg_111_1.stage_.transform
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_.L10k = var_114_0
			end

			if 1 < arg_111_1.time_ and arg_111_1.time_ <= 1 + arg_114_0 then
				local var_114_1 = arg_111_1.bgs_.L10k

				arg_111_1.bgs_.L10k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_114_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_2 = var_114_1:GetComponent("SpriteRenderer")

				if var_114_2 and var_114_2.sprite then
					local var_114_3 = 2 * (var_114_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_114_1.transform.localScale = Vector3.New(var_114_3 / var_114_2.sprite.bounds.size.y < var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x and var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x or var_114_3 / var_114_2.sprite.bounds.size.y, var_114_3 / var_114_2.sprite.bounds.size.y < var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x and var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x or var_114_3 / var_114_2.sprite.bounds.size.y, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "L10k" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_4 = 3

			if 3 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= var_114_4 + 0.3 and arg_111_1.time_ < var_114_4 + 0.3 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_5 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_6 = 1

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 then
				local var_114_7 = Color.New(0, 0, 0)

				var_114_7.a = Mathf.Lerp(0, 1, (arg_111_1.time_ - var_114_5) / var_114_6)
				arg_111_1.mask_.color = var_114_7
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 then
				local var_114_8 = Color.New(0, 0, 0)

				var_114_8.a = 1
				arg_111_1.mask_.color = var_114_8
			end

			local var_114_9 = 1

			if 1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_10 = 2

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 then
				local var_114_11 = Color.New(0, 0, 0)

				var_114_11.a = Mathf.Lerp(1, 0, (arg_111_1.time_ - var_114_9) / var_114_10)
				arg_111_1.mask_.color = var_114_11
			end

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 then
				local var_114_12 = Color.New(0, 0, 0)

				arg_111_1.mask_.enabled = false
				var_114_12.a = 0
				arg_111_1.mask_.color = var_114_12
			end

			local var_114_13 = arg_111_1.actors_["1043ui_story"].transform

			if 0.965999998152256 < arg_111_1.time_ and arg_111_1.time_ <= 0.965999998152256 + arg_114_0 then
				arg_111_1.var_.moveOldPos1043ui_story = var_114_13.localPosition
			end

			local var_114_14 = 0.001

			if 0.965999998152256 <= arg_111_1.time_ and arg_111_1.time_ < 0.965999998152256 + var_114_14 then
				var_114_13.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0.965999998152256) / var_114_14)
				var_114_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_13.position).x, (manager.ui.mainCamera.transform.position - var_114_13.position).y, (manager.ui.mainCamera.transform.position - var_114_13.position).z)
				var_114_13.localEulerAngles.z = 0
				var_114_13.localEulerAngles.x = 0
				var_114_13.localEulerAngles = var_114_13.localEulerAngles
			end

			if arg_111_1.time_ >= 0.965999998152256 + var_114_14 and arg_111_1.time_ < 0.965999998152256 + var_114_14 + arg_114_0 then
				var_114_13.localPosition = Vector3.New(0, 100, 0)
				var_114_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_13.position).x, (manager.ui.mainCamera.transform.position - var_114_13.position).y, (manager.ui.mainCamera.transform.position - var_114_13.position).z)
				var_114_13.localEulerAngles.z = 0
				var_114_13.localEulerAngles.x = 0
				var_114_13.localEulerAngles = var_114_13.localEulerAngles
			end

			local var_114_15 = arg_111_1.actors_["1043ui_story"]

			if 0.965999998152256 < arg_111_1.time_ and arg_111_1.time_ <= 0.965999998152256 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.characterEffect1043ui_story == nil then
				arg_111_1.var_.characterEffect1043ui_story = var_114_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_16 = 0.034000001847744

			if 0.965999998152256 <= arg_111_1.time_ and arg_111_1.time_ < 0.965999998152256 + var_114_16 and not isNil(var_114_15) then
				if arg_111_1.var_.characterEffect1043ui_story and not isNil(var_114_15) then
					arg_111_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0.965999998152256) / var_114_16)
				end
			end

			if arg_111_1.time_ >= 0.965999998152256 + var_114_16 and arg_111_1.time_ < 0.965999998152256 + var_114_16 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.characterEffect1043ui_story then
				arg_111_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_114_17 = "1044ui_story"

			if arg_111_1.actors_["1044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1044ui_story"))) then
				local var_114_18 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_111_1.stage_.transform)

				var_114_18.name = var_114_17
				var_114_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_[var_114_17] = var_114_18

				local var_114_19 = var_114_18:GetComponentInChildren(typeof(CharacterEffect))

				var_114_19.enabled = true

				local var_114_20 = GameObjectTools.GetOrAddComponent(var_114_18, typeof(DynamicBoneHelper))

				if var_114_20 then
					var_114_20:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_19.transform, false)

				arg_111_1.var_[var_114_17 .. "Animator"] = var_114_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_[var_114_17 .. "Animator"].applyRootMotion = true
				arg_111_1.var_[var_114_17 .. "LipSync"] = var_114_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_21 = arg_111_1.actors_["1044ui_story"].transform

			if 2.8 < arg_111_1.time_ and arg_111_1.time_ <= 2.8 + arg_114_0 then
				arg_111_1.var_.moveOldPos1044ui_story = var_114_21.localPosition
			end

			local var_114_22 = 0.001

			if 2.8 <= arg_111_1.time_ and arg_111_1.time_ < 2.8 + var_114_22 then
				var_114_21.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_111_1.time_ - 2.8) / var_114_22)
				var_114_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_21.position).x, (manager.ui.mainCamera.transform.position - var_114_21.position).y, (manager.ui.mainCamera.transform.position - var_114_21.position).z)
				var_114_21.localEulerAngles.z = 0
				var_114_21.localEulerAngles.x = 0
				var_114_21.localEulerAngles = var_114_21.localEulerAngles
			end

			if arg_111_1.time_ >= 2.8 + var_114_22 and arg_111_1.time_ < 2.8 + var_114_22 + arg_114_0 then
				var_114_21.localPosition = Vector3.New(0, -1, -5.93)
				var_114_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_21.position).x, (manager.ui.mainCamera.transform.position - var_114_21.position).y, (manager.ui.mainCamera.transform.position - var_114_21.position).z)
				var_114_21.localEulerAngles.z = 0
				var_114_21.localEulerAngles.x = 0
				var_114_21.localEulerAngles = var_114_21.localEulerAngles
			end

			local var_114_23 = arg_111_1.actors_["1044ui_story"]

			if 2.79999999701977 < arg_111_1.time_ and arg_111_1.time_ <= 2.79999999701977 + arg_114_0 and not isNil(var_114_23) and arg_111_1.var_.characterEffect1044ui_story == nil then
				arg_111_1.var_.characterEffect1044ui_story = var_114_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_24 = 0.200000002980232

			if 2.79999999701977 <= arg_111_1.time_ and arg_111_1.time_ < 2.79999999701977 + var_114_24 and not isNil(var_114_23) then
				if arg_111_1.var_.characterEffect1044ui_story and not isNil(var_114_23) then
					arg_111_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 2.79999999701977 + var_114_24 and arg_111_1.time_ < 2.79999999701977 + var_114_24 + arg_114_0 and not isNil(var_114_23) and arg_111_1.var_.characterEffect1044ui_story then
				arg_111_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 2.8 < arg_111_1.time_ and arg_111_1.time_ <= 2.8 + arg_114_0 then
				arg_111_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			if 2.8 < arg_111_1.time_ and arg_111_1.time_ <= 2.8 + arg_114_0 then
				arg_111_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			if 0.166666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.166666666666667 + arg_114_0 then
				arg_111_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.5 < arg_111_1.time_ and arg_111_1.time_ <= 1.5 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_28 = 3
			local var_114_29 = 0.3

			if 3 < arg_111_1.time_ and arg_111_1.time_ <= var_114_28 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_30 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_30:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_31 = arg_111_1:GetWordFromCfg(322131025)
				local var_114_32 = arg_111_1:FormatText(var_114_31.content)

				arg_111_1.text_.text = var_114_32

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_34 = 12 <= 0 and var_114_29 or var_114_29 * (utf8.len(var_114_32) / 12)

				if (12 <= 0 and var_114_29 or var_114_29 * (utf8.len(var_114_32) / 12)) > 0 and var_114_29 < var_114_34 then
					arg_111_1.talkMaxDuration = var_114_34
					var_114_28 = var_114_28 + 0.3

					if var_114_34 + var_114_28 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_34 + var_114_28
					end
				end

				arg_111_1.text_.text = var_114_32
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131025", "story_v_out_322131.awb") ~= 0 then
					local var_114_35 = manager.audio:GetVoiceLength("story_v_out_322131", "322131025", "story_v_out_322131.awb") / 1000

					if var_114_35 + var_114_28 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_35 + var_114_28
					end

					if var_114_31.prefab_name ~= "" and arg_111_1.actors_[var_114_31.prefab_name] ~= nil then
						local var_114_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_31.prefab_name].transform, "story_v_out_322131", "322131025", "story_v_out_322131.awb")

						arg_111_1:RecordAudio("322131025", var_114_36)
						arg_111_1:RecordAudio("322131025", var_114_36)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322131", "322131025", "story_v_out_322131.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322131", "322131025", "story_v_out_322131.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_37 = var_114_28 + 0.3
			local var_114_38 = math.max(var_114_29, arg_111_1.talkMaxDuration)

			if var_114_28 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_37 + var_114_38 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_37) / var_114_38

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_37 + var_114_38 and arg_111_1.time_ < var_114_37 + var_114_38 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play322131026 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322131026
		arg_117_1.duration_ = 5.07

		local var_117_0 = {
			zh = 4.066,
			ja = 5.066
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
				arg_117_0:Play322131027(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action9_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_120_0 = 0
			local var_120_1 = 0.375

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(322131026)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 15 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 15)

				if (15 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 15)) > 0 and var_120_1 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131026", "story_v_out_322131.awb") ~= 0 then
					local var_120_6 = manager.audio:GetVoiceLength("story_v_out_322131", "322131026", "story_v_out_322131.awb") / 1000

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end

					if var_120_2.prefab_name ~= "" and arg_117_1.actors_[var_120_2.prefab_name] ~= nil then
						local var_120_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_2.prefab_name].transform, "story_v_out_322131", "322131026", "story_v_out_322131.awb")

						arg_117_1:RecordAudio("322131026", var_120_7)
						arg_117_1:RecordAudio("322131026", var_120_7)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322131", "322131026", "story_v_out_322131.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322131", "322131026", "story_v_out_322131.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322131027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322131027
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play322131028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_9000

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1044ui_story = arg_121_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1044ui_story"].transform.position).z)
				arg_121_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1044ui_story"].transform.localEulerAngles = arg_121_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1044ui_story"].transform.position).z)
				arg_121_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1044ui_story"].transform.localEulerAngles = arg_121_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1044ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1044ui_story == nil then
				arg_121_1.var_.characterEffect1044ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1044ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1044ui_story then
				arg_121_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_121_1.time_ and arg_121_1.time_ <= 0.200000002980232 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_142", "se_story_142_monster02", "")
			end

			if 0.3 < arg_121_1.time_ and arg_121_1.time_ <= 0.3 + arg_124_0 then
				local var_124_4 = arg_121_1.var_.effect1027

				if not arg_121_1.var_.effect1027 then
					var_124_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_greentwister_out"), manager.ui.mainCamera.transform)
					var_124_4.name = "1027"
					arg_121_1.var_.effect1027 = var_124_4
				else
					var_124_4.transform:SetParent(var_124_9000)
				end

				var_124_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_124_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.06666666666667 < arg_121_1.time_ and arg_121_1.time_ <= 2.06666666666667 + arg_124_0 then
				if arg_121_1.var_.effect1027 then
					Object.Destroy(arg_121_1.var_.effect1027)

					arg_121_1.var_.effect1027 = nil
				end
			end

			local var_124_7 = manager.ui.mainCamera.transform

			if 0.3 < arg_121_1.time_ and arg_121_1.time_ <= 0.3 + arg_124_0 then
				arg_121_1.var_.shakeOldPos = var_124_7.localPosition
			end

			local var_124_8 = 0.566666666666667

			if 0.3 <= arg_121_1.time_ and arg_121_1.time_ < 0.3 + var_124_8 then
				local var_124_9, var_124_10 = math.modf((arg_121_1.time_ - 0.3) / 0.066)

				var_124_7.localPosition = Vector3.New(var_124_10 * 0.15, var_124_10 * 0.15, var_124_10 * 0.15) + arg_121_1.var_.shakeOldPos
			end

			if arg_121_1.time_ >= 0.3 + var_124_8 and arg_121_1.time_ < 0.3 + var_124_8 + arg_124_0 then
				var_124_7.localPosition = arg_121_1.var_.shakeOldPos
			end

			local var_124_11 = 0
			local var_124_12 = 1.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(322131027).content)

				arg_121_1.text_.text = var_124_13

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 46 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_13) / 46)

				if (46 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_13) / 46)) > 0 and var_124_12 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15

					if var_124_15 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_13
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_12, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_16 and arg_121_1.time_ < var_124_11 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322131028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322131028
		arg_125_1.duration_ = 7.77

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322131029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_9000

			if 0.1 < arg_125_1.time_ and arg_125_1.time_ <= 0.1 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_143", "se_story_143_5270201Talk2_2", "")
			end

			local var_128_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_125_1.time_ and arg_125_1.time_ <= 0.1 + arg_128_0 then
				arg_125_1.var_.shakeOldPos = var_128_1.localPosition
			end

			local var_128_2 = 0.4

			if 0.1 <= arg_125_1.time_ and arg_125_1.time_ < 0.1 + var_128_2 then
				local var_128_3, var_128_4 = math.modf((arg_125_1.time_ - 0.1) / 0.132)

				var_128_1.localPosition = Vector3.New(var_128_4 * 0.13, var_128_4 * 0.13, var_128_4 * 0.13) + arg_125_1.var_.shakeOldPos
			end

			if arg_125_1.time_ >= 0.1 + var_128_2 and arg_125_1.time_ < 0.1 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = arg_125_1.var_.shakeOldPos
			end

			if 0.1 < arg_125_1.time_ and arg_125_1.time_ <= 0.1 + arg_128_0 then
				local var_128_5 = arg_125_1.var_.effect1028

				if not arg_125_1.var_.effect1028 then
					var_128_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_128_5.name = "1028"
					arg_125_1.var_.effect1028 = var_128_5
				else
					var_128_5.transform:SetParent(var_128_9000)
				end

				var_128_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_128_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.13333333333333 < arg_125_1.time_ and arg_125_1.time_ <= 4.13333333333333 + arg_128_0 then
				if arg_125_1.var_.effect1028 then
					Object.Destroy(arg_125_1.var_.effect1028)

					arg_125_1.var_.effect1028 = nil
				end
			end

			local var_128_8 = 0
			local var_128_9 = 1.7

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(322131028).content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_12 = 68 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_10) / 68)

				if (68 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_10) / 68)) > 0 and var_128_9 < var_128_12 then
					arg_125_1.talkMaxDuration = var_128_12

					if var_128_12 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_13 and arg_125_1.time_ < var_128_8 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play322131029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322131029
		arg_129_1.duration_ = 16.4

		local var_129_0 = {
			zh = 6,
			ja = 16.4
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
				arg_129_0:Play322131030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.actors_["10130ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10130ui_story"))) then
				local var_132_0 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_129_1.stage_.transform)

				var_132_0.name = "10130ui_story"
				var_132_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["10130ui_story"] = var_132_0

				local var_132_1 = var_132_0:GetComponentInChildren(typeof(CharacterEffect))

				var_132_1.enabled = true

				local var_132_2 = GameObjectTools.GetOrAddComponent(var_132_0, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(false)
				end

				arg_129_1:ShowWeapon(var_132_1.transform, false)

				arg_129_1.var_["10130ui_story" .. "Animator"] = var_132_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_129_1.var_["10130ui_story" .. "Animator"].applyRootMotion = true
				arg_129_1.var_["10130ui_story" .. "LipSync"] = var_132_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_132_3 = arg_129_1.actors_["10130ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10130ui_story = var_132_3.localPosition
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_3.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10130ui_story, Vector3.New(-0.94, -1.02, -5.81), (arg_129_1.time_ - 0) / var_132_4)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_3.localPosition = Vector3.New(-0.94, -1.02, -5.81)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			local var_132_5 = arg_129_1.actors_["10130ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect10130ui_story == nil then
				arg_129_1.var_.characterEffect10130ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.characterEffect10130ui_story and not isNil(var_132_5) then
					arg_129_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect10130ui_story then
				arg_129_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action8_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_8 = 0
			local var_132_9 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(322131029)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 14 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 14)

				if (14 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 14)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131029", "story_v_out_322131.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_322131", "322131029", "story_v_out_322131.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_322131", "322131029", "story_v_out_322131.awb")

						arg_129_1:RecordAudio("322131029", var_132_15)
						arg_129_1:RecordAudio("322131029", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322131", "322131029", "story_v_out_322131.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322131", "322131029", "story_v_out_322131.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play322131030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322131030
		arg_133_1.duration_ = 3.57

		local var_133_0 = {
			zh = 3.2,
			ja = 3.566
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
				arg_133_0:Play322131031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1044ui_story = arg_133_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1044ui_story"].transform.position).z)
				arg_133_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1044ui_story"].transform.localEulerAngles = arg_133_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_133_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1044ui_story"].transform.position).z)
				arg_133_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1044ui_story"].transform.localEulerAngles = arg_133_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1044ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1044ui_story == nil then
				arg_133_1.var_.characterEffect1044ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1044ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1044ui_story then
				arg_133_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["10130ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10130ui_story == nil then
				arg_133_1.var_.characterEffect10130ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_5 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 and not isNil(var_136_4) then
				if arg_133_1.var_.characterEffect10130ui_story and not isNil(var_136_4) then
					arg_133_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_5)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10130ui_story then
				arg_133_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_136_6 = 0
			local var_136_7 = 0.375

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(322131030)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 15 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 15)

				if (15 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 15)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131030", "story_v_out_322131.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_322131", "322131030", "story_v_out_322131.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_322131", "322131030", "story_v_out_322131.awb")

						arg_133_1:RecordAudio("322131030", var_136_13)
						arg_133_1:RecordAudio("322131030", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322131", "322131030", "story_v_out_322131.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322131", "322131030", "story_v_out_322131.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play322131031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322131031
		arg_137_1.duration_ = 9.07

		local var_137_0 = {
			zh = 8.133,
			ja = 9.066
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
				arg_137_0:Play322131032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.875

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(322131031)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 35 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 35)

				if (35 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 35)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131031", "story_v_out_322131.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131031", "story_v_out_322131.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_322131", "322131031", "story_v_out_322131.awb")

						arg_137_1:RecordAudio("322131031", var_140_6)
						arg_137_1:RecordAudio("322131031", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_322131", "322131031", "story_v_out_322131.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_322131", "322131031", "story_v_out_322131.awb")
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
	Play322131032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322131032
		arg_141_1.duration_ = 4.27

		local var_141_0 = {
			zh = 4.266,
			ja = 4.166
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
				arg_141_0:Play322131033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10130ui_story"]) and arg_141_1.var_.characterEffect10130ui_story == nil then
				arg_141_1.var_.characterEffect10130ui_story = arg_141_1.actors_["10130ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10130ui_story"]) then
				if arg_141_1.var_.characterEffect10130ui_story and not isNil(arg_141_1.actors_["10130ui_story"]) then
					arg_141_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10130ui_story"]) and arg_141_1.var_.characterEffect10130ui_story then
				arg_141_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_144_1 = 0
			local var_144_2 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(322131032)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 18 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 18)

				if (18 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 18)) > 0 and var_144_2 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131032", "story_v_out_322131.awb") ~= 0 then
					local var_144_7 = manager.audio:GetVoiceLength("story_v_out_322131", "322131032", "story_v_out_322131.awb") / 1000

					if var_144_7 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_1
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_322131", "322131032", "story_v_out_322131.awb")

						arg_141_1:RecordAudio("322131032", var_144_8)
						arg_141_1:RecordAudio("322131032", var_144_8)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322131", "322131032", "story_v_out_322131.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322131", "322131032", "story_v_out_322131.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_9 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_9 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_9

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_9 and arg_141_1.time_ < var_144_1 + var_144_9 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play322131033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322131033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play322131034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1044ui_story = arg_145_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1044ui_story"].transform.position).z)
				arg_145_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1044ui_story"].transform.localEulerAngles = arg_145_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1044ui_story"].transform.position).z)
				arg_145_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1044ui_story"].transform.localEulerAngles = arg_145_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10130ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10130ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = 0
			local var_148_4 = 0.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(322131033).content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 3 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 3)

				if (3 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 3)) > 0 and var_148_4 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_3
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_4, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_3) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_8 and arg_145_1.time_ < var_148_3 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play322131034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322131034
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play322131035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_9000

			if 0.1 < arg_149_1.time_ and arg_149_1.time_ <= 0.1 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_141", "se_story_141_1211_bullet2", "")
			end

			if 0.1 < arg_149_1.time_ and arg_149_1.time_ <= 0.1 + arg_152_0 then
				local var_152_1 = arg_149_1.var_.effect1033

				if not arg_149_1.var_.effect1033 then
					var_152_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_152_1.name = "1033"
					arg_149_1.var_.effect1033 = var_152_1
				else
					var_152_1.transform:SetParent(var_152_9000)
				end

				var_152_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_152_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.9 < arg_149_1.time_ and arg_149_1.time_ <= 3.9 + arg_152_0 then
				if arg_149_1.var_.effect1033 then
					Object.Destroy(arg_149_1.var_.effect1033)

					arg_149_1.var_.effect1033 = nil
				end
			end

			local var_152_4 = manager.ui.mainCamera.transform

			if 0.1 < arg_149_1.time_ and arg_149_1.time_ <= 0.1 + arg_152_0 then
				arg_149_1.var_.shakeOldPos = var_152_4.localPosition
			end

			local var_152_5 = 0.766666663686434

			if 0.1 <= arg_149_1.time_ and arg_149_1.time_ < 0.1 + var_152_5 then
				local var_152_6, var_152_7 = math.modf((arg_149_1.time_ - 0.1) / 0.132)

				var_152_4.localPosition = Vector3.New(var_152_7 * 0.13, var_152_7 * 0.13, var_152_7 * 0.13) + arg_149_1.var_.shakeOldPos
			end

			if arg_149_1.time_ >= 0.1 + var_152_5 and arg_149_1.time_ < 0.1 + var_152_5 + arg_152_0 then
				var_152_4.localPosition = arg_149_1.var_.shakeOldPos
			end

			local var_152_8 = 0
			local var_152_9 = 0.925

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(322131034).content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_12 = 37 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_10) / 37)

				if (37 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_10) / 37)) > 0 and var_152_9 < var_152_12 then
					arg_149_1.talkMaxDuration = var_152_12

					if var_152_12 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_13 and arg_149_1.time_ < var_152_8 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play322131035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322131035
		arg_153_1.duration_ = 5.9

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322131036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0.333333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 0.333333333333333 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_145", "se_story_145_blast", "")
			end

			local var_156_1 = manager.ui.mainCamera.transform

			if 0.333333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 0.333333333333333 + arg_156_0 then
				arg_153_1.var_.shakeOldPos = var_156_1.localPosition
			end

			local var_156_2 = 0.566666666666667

			if 0.333333333333333 <= arg_153_1.time_ and arg_153_1.time_ < 0.333333333333333 + var_156_2 then
				local var_156_3, var_156_4 = math.modf((arg_153_1.time_ - 0.333333333333333) / 0.198)

				var_156_1.localPosition = Vector3.New(var_156_4 * 0.13, var_156_4 * 0.13, var_156_4 * 0.13) + arg_153_1.var_.shakeOldPos
			end

			if arg_153_1.time_ >= 0.333333333333333 + var_156_2 and arg_153_1.time_ < 0.333333333333333 + var_156_2 + arg_156_0 then
				var_156_1.localPosition = arg_153_1.var_.shakeOldPos
			end

			local var_156_5 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = false

				arg_153_1:SetGaussion(false)
			end

			local var_156_6 = 0.333333333333333

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 then
				local var_156_7 = Color.New(1, 1, 1)

				var_156_7.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_5) / var_156_6)
				arg_153_1.mask_.color = var_156_7
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 then
				local var_156_8 = Color.New(1, 1, 1)

				arg_153_1.mask_.enabled = false
				var_156_8.a = 0
				arg_153_1.mask_.color = var_156_8
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_9 = 0.9
			local var_156_10 = 1.3

			if 0.9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_11 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_11:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_12 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(322131035).content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_14 = 52 <= 0 and var_156_10 or var_156_10 * (utf8.len(var_156_12) / 52)

				if (52 <= 0 and var_156_10 or var_156_10 * (utf8.len(var_156_12) / 52)) > 0 and var_156_10 < var_156_14 then
					arg_153_1.talkMaxDuration = var_156_14
					var_156_9 = var_156_9 + 0.3

					if var_156_14 + var_156_9 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_9
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_15 = var_156_9 + 0.3
			local var_156_16 = math.max(var_156_10, arg_153_1.talkMaxDuration)

			if var_156_9 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_16 and arg_153_1.time_ < var_156_15 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play322131036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322131036
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322131037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1211ui_story = arg_159_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1211ui_story"].transform.position).z)
				arg_159_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1211ui_story"].transform.localEulerAngles = arg_159_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_159_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1211ui_story"].transform.position).z)
				arg_159_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1211ui_story"].transform.localEulerAngles = arg_159_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1211ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1211ui_story == nil then
				arg_159_1.var_.characterEffect1211ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1211ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1211ui_story then
				arg_159_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.075

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(322131036)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 3 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 3)

				if (3 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 3)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131036", "story_v_out_322131.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131036", "story_v_out_322131.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_322131", "322131036", "story_v_out_322131.awb")

						arg_159_1:RecordAudio("322131036", var_162_11)
						arg_159_1:RecordAudio("322131036", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322131", "322131036", "story_v_out_322131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322131", "322131036", "story_v_out_322131.awb")
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

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play322131037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322131037
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play322131038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1211ui_story = arg_163_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1211ui_story"].transform.position).z)
				arg_163_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1211ui_story"].transform.localEulerAngles = arg_163_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1211ui_story"].transform.position).z)
				arg_163_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1211ui_story"].transform.localEulerAngles = arg_163_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_166_1 = 0
			local var_166_2 = 1.25

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

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(322131037).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 50 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 50)

				if (50 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 50)) > 0 and var_166_2 < var_166_5 then
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
				actorName = "1211ui_story",
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
	Play322131038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322131038
		arg_167_1.duration_ = 5.03

		local var_167_0 = {
			zh = 3.3,
			ja = 5.033
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
				arg_167_0:Play322131039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1044ui_story = arg_167_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1044ui_story"].transform.position).z)
				arg_167_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1044ui_story"].transform.localEulerAngles = arg_167_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_167_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1044ui_story"].transform.position).z)
				arg_167_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1044ui_story"].transform.localEulerAngles = arg_167_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1044ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1044ui_story == nil then
				arg_167_1.var_.characterEffect1044ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1044ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1044ui_story then
				arg_167_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_170_4 = 0
			local var_170_5 = 0.4

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(322131038)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 16 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 16)

				if (16 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 16)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131038", "story_v_out_322131.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131038", "story_v_out_322131.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_322131", "322131038", "story_v_out_322131.awb")

						arg_167_1:RecordAudio("322131038", var_170_11)
						arg_167_1:RecordAudio("322131038", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_322131", "322131038", "story_v_out_322131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_322131", "322131038", "story_v_out_322131.awb")
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
				actorName = "1044ui_story",
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
	Play322131039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322131039
		arg_171_1.duration_ = 3.23

		local var_171_0 = {
			zh = 2.7,
			ja = 3.233
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
				arg_171_0:Play322131040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1211ui_story = arg_171_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1211ui_story"].transform.position).z)
				arg_171_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1211ui_story"].transform.localEulerAngles = arg_171_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_171_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1211ui_story"].transform.position).z)
				arg_171_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1211ui_story"].transform.localEulerAngles = arg_171_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1044ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1044ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = arg_171_1.actors_["1211ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1211ui_story == nil then
				arg_171_1.var_.characterEffect1211ui_story = var_174_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 and not isNil(var_174_3) then
				if arg_171_1.var_.characterEffect1211ui_story and not isNil(var_174_3) then
					arg_171_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1211ui_story then
				arg_171_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_174_6 = arg_171_1.actors_["1044ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1044ui_story == nil then
				arg_171_1.var_.characterEffect1044ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_7 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 and not isNil(var_174_6) then
				if arg_171_1.var_.characterEffect1044ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1044ui_story then
				arg_171_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_2")
			end

			local var_174_8 = 0
			local var_174_9 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(322131039)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 13 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 13)

				if (13 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 13)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131039", "story_v_out_322131.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_322131", "322131039", "story_v_out_322131.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_322131", "322131039", "story_v_out_322131.awb")

						arg_171_1:RecordAudio("322131039", var_174_15)
						arg_171_1:RecordAudio("322131039", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_322131", "322131039", "story_v_out_322131.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_322131", "322131039", "story_v_out_322131.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play322131040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322131040
		arg_175_1.duration_ = 3.7

		local var_175_0 = {
			zh = 3.3,
			ja = 3.7
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
				arg_175_0:Play322131041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1044ui_story = arg_175_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1044ui_story"].transform.position).z)
				arg_175_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1044ui_story"].transform.localEulerAngles = arg_175_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_175_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1044ui_story"].transform.position).z)
				arg_175_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1044ui_story"].transform.localEulerAngles = arg_175_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1044ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1044ui_story == nil then
				arg_175_1.var_.characterEffect1044ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1044ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1044ui_story then
				arg_175_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_178_4 = arg_175_1.actors_["1211ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1211ui_story == nil then
				arg_175_1.var_.characterEffect1211ui_story = var_178_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_5 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 and not isNil(var_178_4) then
				if arg_175_1.var_.characterEffect1211ui_story and not isNil(var_178_4) then
					arg_175_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_5)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1211ui_story then
				arg_175_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_2")
			end

			local var_178_6 = 0
			local var_178_7 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(322131040)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 12 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 12)

				if (12 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 12)) > 0 and var_178_7 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131040", "story_v_out_322131.awb") ~= 0 then
					local var_178_12 = manager.audio:GetVoiceLength("story_v_out_322131", "322131040", "story_v_out_322131.awb") / 1000

					if var_178_12 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_6
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_out_322131", "322131040", "story_v_out_322131.awb")

						arg_175_1:RecordAudio("322131040", var_178_13)
						arg_175_1:RecordAudio("322131040", var_178_13)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322131", "322131040", "story_v_out_322131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322131", "322131040", "story_v_out_322131.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322131041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322131041
		arg_179_1.duration_ = 5.33

		local var_179_0 = {
			zh = 5.333,
			ja = 4.666
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
				arg_179_0:Play322131042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.4

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(322131041)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 16 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 16)

				if (16 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 16)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131041", "story_v_out_322131.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131041", "story_v_out_322131.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_322131", "322131041", "story_v_out_322131.awb")

						arg_179_1:RecordAudio("322131041", var_182_6)
						arg_179_1:RecordAudio("322131041", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_322131", "322131041", "story_v_out_322131.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_322131", "322131041", "story_v_out_322131.awb")
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
	Play322131042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322131042
		arg_183_1.duration_ = 5.6

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322131043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_9000

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1044ui_story = arg_183_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1044ui_story"].transform.position).z)
				arg_183_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1044ui_story"].transform.localEulerAngles = arg_183_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1044ui_story"].transform.position).z)
				arg_183_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1044ui_story"].transform.localEulerAngles = arg_183_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1211ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1211ui_story = var_186_1.localPosition
			end

			local var_186_2 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 then
				var_186_1.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_2)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 then
				var_186_1.localPosition = Vector3.New(0, 100, 0)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			local var_186_3 = arg_183_1.actors_["1044ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect1044ui_story == nil then
				arg_183_1.var_.characterEffect1044ui_story = var_186_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_4 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 and not isNil(var_186_3) then
				if arg_183_1.var_.characterEffect1044ui_story and not isNil(var_186_3) then
					arg_183_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_4)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect1044ui_story then
				arg_183_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_183_1.time_ and arg_183_1.time_ <= 0.1 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ring", "")
			end

			local var_186_6 = manager.ui.mainCamera.transform

			if 0.1 < arg_183_1.time_ and arg_183_1.time_ <= 0.1 + arg_186_0 then
				arg_183_1.var_.shakeOldPos = var_186_6.localPosition
			end

			local var_186_7 = 0.5

			if 0.1 <= arg_183_1.time_ and arg_183_1.time_ < 0.1 + var_186_7 then
				local var_186_8, var_186_9 = math.modf((arg_183_1.time_ - 0.1) / 0.066)

				var_186_6.localPosition = Vector3.New(var_186_9 * 0.13, var_186_9 * 0.13, var_186_9 * 0.13) + arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.time_ >= 0.1 + var_186_7 and arg_183_1.time_ < 0.1 + var_186_7 + arg_186_0 then
				var_186_6.localPosition = arg_183_1.var_.shakeOldPos
			end

			if 0.1 < arg_183_1.time_ and arg_183_1.time_ <= 0.1 + arg_186_0 then
				local var_186_10 = arg_183_1.var_.effect1042

				if not arg_183_1.var_.effect1042 then
					var_186_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_186_10.name = "1042"
					arg_183_1.var_.effect1042 = var_186_10
				else
					var_186_10.transform:SetParent(var_186_9000)
				end

				var_186_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_186_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_12 = 0.6
			local var_186_13 = 1.15

			if 0.6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_14 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_14:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_15 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(322131042).content)

				arg_183_1.text_.text = var_186_15

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_17 = 46 <= 0 and var_186_13 or var_186_13 * (utf8.len(var_186_15) / 46)

				if (46 <= 0 and var_186_13 or var_186_13 * (utf8.len(var_186_15) / 46)) > 0 and var_186_13 < var_186_17 then
					arg_183_1.talkMaxDuration = var_186_17
					var_186_12 = var_186_12 + 0.3

					if var_186_17 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_17 + var_186_12
					end
				end

				arg_183_1.text_.text = var_186_15
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_18 = var_186_12 + 0.3
			local var_186_19 = math.max(var_186_13, arg_183_1.talkMaxDuration)

			if var_186_12 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_18 + var_186_19 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_18) / var_186_19

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_18 + var_186_19 and arg_183_1.time_ < var_186_18 + var_186_19 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322131043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322131043
		arg_189_1.duration_ = 4

		local var_189_0 = {
			zh = 3.733,
			ja = 4
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
				arg_189_0:Play322131044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_192_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_189_1.stage_.transform)

				var_192_0.name = "404001ui_story"
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["404001ui_story"] = var_192_0

				local var_192_1 = var_192_0:GetComponentInChildren(typeof(CharacterEffect))

				var_192_1.enabled = true

				local var_192_2 = GameObjectTools.GetOrAddComponent(var_192_0, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(false)
				end

				arg_189_1:ShowWeapon(var_192_1.transform, false)

				arg_189_1.var_["404001ui_story" .. "Animator"] = var_192_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_189_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_189_1.var_["404001ui_story" .. "LipSync"] = var_192_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_192_3 = arg_189_1.actors_["404001ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos404001ui_story = var_192_3.localPosition
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_3.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_189_1.time_ - 0) / var_192_4)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			local var_192_5 = arg_189_1.actors_["404001ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect404001ui_story == nil then
				arg_189_1.var_.characterEffect404001ui_story = var_192_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.characterEffect404001ui_story and not isNil(var_192_5) then
					arg_189_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect404001ui_story then
				arg_189_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_192_8 = 0
			local var_192_9 = 0.4

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(322131043)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 16 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 16)

				if (16 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 16)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131043", "story_v_out_322131.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_322131", "322131043", "story_v_out_322131.awb") / 1000

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_322131", "322131043", "story_v_out_322131.awb")

						arg_189_1:RecordAudio("322131043", var_192_15)
						arg_189_1:RecordAudio("322131043", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322131", "322131043", "story_v_out_322131.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322131", "322131043", "story_v_out_322131.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play322131044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322131044
		arg_193_1.duration_ = 3.17

		local var_193_0 = {
			zh = 3.166,
			ja = 2.966
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
				arg_193_0:Play322131045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = arg_193_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).z)
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles = arg_193_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_193_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).z)
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles = arg_193_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1211ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = var_196_1.localPosition
			end

			local var_196_2 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 then
				var_196_1.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_193_1.time_ - 0) / var_196_2)
				var_196_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_1.position).x, (manager.ui.mainCamera.transform.position - var_196_1.position).y, (manager.ui.mainCamera.transform.position - var_196_1.position).z)
				var_196_1.localEulerAngles.z = 0
				var_196_1.localEulerAngles.x = 0
				var_196_1.localEulerAngles = var_196_1.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 then
				var_196_1.localPosition = Vector3.New(0, -0.67, -6.07)
				var_196_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_1.position).x, (manager.ui.mainCamera.transform.position - var_196_1.position).y, (manager.ui.mainCamera.transform.position - var_196_1.position).z)
				var_196_1.localEulerAngles.z = 0
				var_196_1.localEulerAngles.x = 0
				var_196_1.localEulerAngles = var_196_1.localEulerAngles
			end

			local var_196_3 = arg_193_1.actors_["404001ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos404001ui_story = var_196_3.localPosition
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_3.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_4)
				var_196_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_3.position).x, (manager.ui.mainCamera.transform.position - var_196_3.position).y, (manager.ui.mainCamera.transform.position - var_196_3.position).z)
				var_196_3.localEulerAngles.z = 0
				var_196_3.localEulerAngles.x = 0
				var_196_3.localEulerAngles = var_196_3.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_3.localPosition = Vector3.New(0, 100, 0)
				var_196_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_3.position).x, (manager.ui.mainCamera.transform.position - var_196_3.position).y, (manager.ui.mainCamera.transform.position - var_196_3.position).z)
				var_196_3.localEulerAngles.z = 0
				var_196_3.localEulerAngles.x = 0
				var_196_3.localEulerAngles = var_196_3.localEulerAngles
			end

			local var_196_5 = arg_193_1.actors_["1211ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1211ui_story == nil then
				arg_193_1.var_.characterEffect1211ui_story = var_196_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_6 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.characterEffect1211ui_story and not isNil(var_196_5) then
					arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1211ui_story then
				arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_196_8 = arg_193_1.actors_["404001ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.characterEffect404001ui_story == nil then
				arg_193_1.var_.characterEffect404001ui_story = var_196_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_9 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_9 and not isNil(var_196_8) then
				if arg_193_1.var_.characterEffect404001ui_story and not isNil(var_196_8) then
					arg_193_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_193_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_9)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_9 and arg_193_1.time_ < 0 + var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.characterEffect404001ui_story then
				arg_193_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_193_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_196_10 = 0
			local var_196_11 = 0.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_12 = arg_193_1:GetWordFromCfg(322131044)
				local var_196_13 = arg_193_1:FormatText(var_196_12.content)

				arg_193_1.text_.text = var_196_13

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_15 = 15 <= 0 and var_196_11 or var_196_11 * (utf8.len(var_196_13) / 15)

				if (15 <= 0 and var_196_11 or var_196_11 * (utf8.len(var_196_13) / 15)) > 0 and var_196_11 < var_196_15 then
					arg_193_1.talkMaxDuration = var_196_15

					if var_196_15 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_15 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_13
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131044", "story_v_out_322131.awb") ~= 0 then
					local var_196_16 = manager.audio:GetVoiceLength("story_v_out_322131", "322131044", "story_v_out_322131.awb") / 1000

					if var_196_16 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_10
					end

					if var_196_12.prefab_name ~= "" and arg_193_1.actors_[var_196_12.prefab_name] ~= nil then
						local var_196_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_12.prefab_name].transform, "story_v_out_322131", "322131044", "story_v_out_322131.awb")

						arg_193_1:RecordAudio("322131044", var_196_17)
						arg_193_1:RecordAudio("322131044", var_196_17)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322131", "322131044", "story_v_out_322131.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322131", "322131044", "story_v_out_322131.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_18 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_18 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_10) / var_196_18

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_10 + var_196_18 and arg_193_1.time_ < var_196_10 + var_196_18 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play322131045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322131045
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322131046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1211ui_story"]) and arg_197_1.var_.characterEffect1211ui_story == nil then
				arg_197_1.var_.characterEffect1211ui_story = arg_197_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1211ui_story"]) then
				if arg_197_1.var_.characterEffect1211ui_story and not isNil(arg_197_1.actors_["1211ui_story"]) then
					arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1211ui_story"]) and arg_197_1.var_.characterEffect1211ui_story then
				arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.575

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(322131045).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 23 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 23)

				if (23 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 23)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play322131046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322131046
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play322131047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.175

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(322131046).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 7 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 7)

				if (7 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 7)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play322131047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322131047
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play322131048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1211ui_story = arg_205_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1211ui_story"].transform.position).z)
				arg_205_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1211ui_story"].transform.localEulerAngles = arg_205_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1211ui_story"].transform.position).z)
				arg_205_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1211ui_story"].transform.localEulerAngles = arg_205_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_208_1 = 0
			local var_208_2 = 1.1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(322131047).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 44 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 44)

				if (44 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 44)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play322131048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322131048
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322131049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_0 = arg_209_1.bgs_.L17f

				arg_209_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_1 = var_212_0:GetComponent("SpriteRenderer")

				if var_212_1 and var_212_1.sprite then
					local var_212_2 = 2 * (var_212_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_0.transform.localScale = Vector3.New(var_212_2 / var_212_1.sprite.bounds.size.y < var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x and var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x or var_212_2 / var_212_1.sprite.bounds.size.y, var_212_2 / var_212_1.sprite.bounds.size.y < var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x and var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x or var_212_2 / var_212_1.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "L17f" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_3 = 3.999999999999

			if 3.999999999999 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			if arg_209_1.time_ >= var_212_3 + 0.3 and arg_209_1.time_ < var_212_3 + 0.3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_5 = 2

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_5 then
				local var_212_6 = Color.New(0, 0, 0)

				var_212_6.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_4) / var_212_5)
				arg_209_1.mask_.color = var_212_6
			end

			if arg_209_1.time_ >= var_212_4 + var_212_5 and arg_209_1.time_ < var_212_4 + var_212_5 + arg_212_0 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = 1
				arg_209_1.mask_.color = var_212_7
			end

			local var_212_8 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 then
				local var_212_10 = Color.New(0, 0, 0)

				var_212_10.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_8) / var_212_9)
				arg_209_1.mask_.color = var_212_10
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 then
				local var_212_11 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_11.a = 0
				arg_209_1.mask_.color = var_212_11
			end

			if 0.1 < arg_209_1.time_ and arg_209_1.time_ <= 0.1 + arg_212_0 then
				arg_209_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if 1.56666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 1.56666666666667 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_212_14 = manager.ui.mainCamera.transform

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= 4 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_14.localPosition
			end

			local var_212_15 = 0.0999999999999996

			if 4 <= arg_209_1.time_ and arg_209_1.time_ < 4 + var_212_15 then
				local var_212_16, var_212_17 = math.modf((arg_209_1.time_ - 4) / 0.066)

				var_212_14.localPosition = Vector3.New(var_212_17 * 0.13, var_212_17 * 0.13, var_212_17 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= 4 + var_212_15 and arg_209_1.time_ < 4 + var_212_15 + arg_212_0 then
				var_212_14.localPosition = arg_209_1.var_.shakeOldPos
			end

			local var_212_18 = manager.ui.mainCamera.transform

			if 4.2 < arg_209_1.time_ and arg_209_1.time_ <= 4.2 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_18.localPosition
			end

			local var_212_19 = 0.0666666666666664

			if 4.2 <= arg_209_1.time_ and arg_209_1.time_ < 4.2 + var_212_19 then
				local var_212_20, var_212_21 = math.modf((arg_209_1.time_ - 4.2) / 0.066)

				var_212_18.localPosition = Vector3.New(var_212_21 * 0.13, var_212_21 * 0.13, var_212_21 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= 4.2 + var_212_19 and arg_209_1.time_ < 4.2 + var_212_19 + arg_212_0 then
				var_212_18.localPosition = arg_209_1.var_.shakeOldPos
			end

			if 3.999999999999 < arg_209_1.time_ and arg_209_1.time_ <= 3.999999999999 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_7", "se_story_7_monster", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_23 = 4
			local var_212_24 = 0.15

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_25 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_25:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2142")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_26 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(322131048).content)

				arg_209_1.text_.text = var_212_26

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_28 = 6 <= 0 and var_212_24 or var_212_24 * (utf8.len(var_212_26) / 6)

				if (6 <= 0 and var_212_24 or var_212_24 * (utf8.len(var_212_26) / 6)) > 0 and var_212_24 < var_212_28 then
					arg_209_1.talkMaxDuration = var_212_28
					var_212_23 = var_212_23 + 0.3

					if var_212_28 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_28 + var_212_23
					end
				end

				arg_209_1.text_.text = var_212_26
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_29 = var_212_23 + 0.3
			local var_212_30 = math.max(var_212_24, arg_209_1.talkMaxDuration)

			if var_212_23 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_29 + var_212_30 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_29) / var_212_30

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_29 + var_212_30 and arg_209_1.time_ < var_212_29 + var_212_30 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play322131049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322131049
		arg_215_1.duration_ = 3.1

		local var_215_0 = {
			zh = 2.9,
			ja = 3.1
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play322131050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1044ui_story = arg_215_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1044ui_story"].transform.position).z)
				arg_215_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1044ui_story"].transform.localEulerAngles = arg_215_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_215_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1044ui_story"].transform.position).z)
				arg_215_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1044ui_story"].transform.localEulerAngles = arg_215_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1044ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1044ui_story == nil then
				arg_215_1.var_.characterEffect1044ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1044ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1044ui_story then
				arg_215_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action9_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_218_4 = 0
			local var_218_5 = 0.225

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(322131049)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 9 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 9)

				if (9 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 9)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131049", "story_v_out_322131.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131049", "story_v_out_322131.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_322131", "322131049", "story_v_out_322131.awb")

						arg_215_1:RecordAudio("322131049", var_218_11)
						arg_215_1:RecordAudio("322131049", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322131", "322131049", "story_v_out_322131.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322131", "322131049", "story_v_out_322131.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play322131050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322131050
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play322131051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1044ui_story = arg_219_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1044ui_story"].transform.position).z)
				arg_219_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1044ui_story"].transform.localEulerAngles = arg_219_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1044ui_story"].transform.position).z)
				arg_219_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1044ui_story"].transform.localEulerAngles = arg_219_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_222_1 = 0
			local var_222_2 = 0.725

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(322131050).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 29 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 29)

				if (29 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 29)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322131051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322131051
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play322131052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.875

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(322131051).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 35 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 35)

				if (35 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 35)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play322131052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322131052
		arg_227_1.duration_ = 3.73

		local var_227_0 = {
			zh = 2.766,
			ja = 3.733
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
				arg_227_0:Play322131053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1044ui_story = arg_227_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1044ui_story"].transform.position).z)
				arg_227_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1044ui_story"].transform.localEulerAngles = arg_227_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_227_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1044ui_story"].transform.position).z)
				arg_227_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1044ui_story"].transform.localEulerAngles = arg_227_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1044ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1044ui_story == nil then
				arg_227_1.var_.characterEffect1044ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1044ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1044ui_story then
				arg_227_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_4 = 0
			local var_230_5 = 0.35

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(322131052)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 14 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 14)

				if (14 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 14)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131052", "story_v_out_322131.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131052", "story_v_out_322131.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_322131", "322131052", "story_v_out_322131.awb")

						arg_227_1:RecordAudio("322131052", var_230_11)
						arg_227_1:RecordAudio("322131052", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322131", "322131052", "story_v_out_322131.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322131", "322131052", "story_v_out_322131.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322131053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322131053
		arg_231_1.duration_ = 2

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322131054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_234_0 = 0
			local var_234_1 = 0.15

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(322131053)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 6 <= 0 and var_234_1 or var_234_1 * (utf8.len(var_234_3) / 6)

				if (6 <= 0 and var_234_1 or var_234_1 * (utf8.len(var_234_3) / 6)) > 0 and var_234_1 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131053", "story_v_out_322131.awb") ~= 0 then
					local var_234_6 = manager.audio:GetVoiceLength("story_v_out_322131", "322131053", "story_v_out_322131.awb") / 1000

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end

					if var_234_2.prefab_name ~= "" and arg_231_1.actors_[var_234_2.prefab_name] ~= nil then
						local var_234_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_2.prefab_name].transform, "story_v_out_322131", "322131053", "story_v_out_322131.awb")

						arg_231_1:RecordAudio("322131053", var_234_7)
						arg_231_1:RecordAudio("322131053", var_234_7)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_322131", "322131053", "story_v_out_322131.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_322131", "322131053", "story_v_out_322131.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_8 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_8 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_8

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_8 and arg_231_1.time_ < var_234_0 + var_234_8 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play322131054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322131054
		arg_235_1.duration_ = 8.87

		local var_235_0 = {
			zh = 7.266,
			ja = 8.866
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
				arg_235_0:Play322131055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if arg_235_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_238_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_235_1.stage_.transform)

				var_238_0.name = "10131ui_story"
				var_238_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["10131ui_story"] = var_238_0

				local var_238_1 = var_238_0:GetComponentInChildren(typeof(CharacterEffect))

				var_238_1.enabled = true

				local var_238_2 = GameObjectTools.GetOrAddComponent(var_238_0, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(false)
				end

				arg_235_1:ShowWeapon(var_238_1.transform, false)

				arg_235_1.var_["10131ui_story" .. "Animator"] = var_238_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_235_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_235_1.var_["10131ui_story" .. "LipSync"] = var_238_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_238_3 = arg_235_1.actors_["10131ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10131ui_story = var_238_3.localPosition
			end

			local var_238_4 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				var_238_3.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_235_1.time_ - 0) / var_238_4)
				var_238_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_3.position).x, (manager.ui.mainCamera.transform.position - var_238_3.position).y, (manager.ui.mainCamera.transform.position - var_238_3.position).z)
				var_238_3.localEulerAngles.z = 0
				var_238_3.localEulerAngles.x = 0
				var_238_3.localEulerAngles = var_238_3.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				var_238_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_238_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_3.position).x, (manager.ui.mainCamera.transform.position - var_238_3.position).y, (manager.ui.mainCamera.transform.position - var_238_3.position).z)
				var_238_3.localEulerAngles.z = 0
				var_238_3.localEulerAngles.x = 0
				var_238_3.localEulerAngles = var_238_3.localEulerAngles
			end

			local var_238_5 = arg_235_1.actors_["1044ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1044ui_story = var_238_5.localPosition
			end

			local var_238_6 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_6 then
				var_238_5.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_235_1.time_ - 0) / var_238_6)
				var_238_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_5.position).x, (manager.ui.mainCamera.transform.position - var_238_5.position).y, (manager.ui.mainCamera.transform.position - var_238_5.position).z)
				var_238_5.localEulerAngles.z = 0
				var_238_5.localEulerAngles.x = 0
				var_238_5.localEulerAngles = var_238_5.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_6 and arg_235_1.time_ < 0 + var_238_6 + arg_238_0 then
				var_238_5.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_238_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_5.position).x, (manager.ui.mainCamera.transform.position - var_238_5.position).y, (manager.ui.mainCamera.transform.position - var_238_5.position).z)
				var_238_5.localEulerAngles.z = 0
				var_238_5.localEulerAngles.x = 0
				var_238_5.localEulerAngles = var_238_5.localEulerAngles
			end

			local var_238_7 = arg_235_1.actors_["10131ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.characterEffect10131ui_story == nil then
				arg_235_1.var_.characterEffect10131ui_story = var_238_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_8 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_8 and not isNil(var_238_7) then
				if arg_235_1.var_.characterEffect10131ui_story and not isNil(var_238_7) then
					arg_235_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_8 and arg_235_1.time_ < 0 + var_238_8 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.characterEffect10131ui_story then
				arg_235_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_238_10 = arg_235_1.actors_["1044ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_10) and arg_235_1.var_.characterEffect1044ui_story == nil then
				arg_235_1.var_.characterEffect1044ui_story = var_238_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_11 and not isNil(var_238_10) then
				if arg_235_1.var_.characterEffect1044ui_story and not isNil(var_238_10) then
					arg_235_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_11)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_11 and arg_235_1.time_ < 0 + var_238_11 + arg_238_0 and not isNil(var_238_10) and arg_235_1.var_.characterEffect1044ui_story then
				arg_235_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_238_12 = 0
			local var_238_13 = 0.85

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_14 = arg_235_1:GetWordFromCfg(322131054)
				local var_238_15 = arg_235_1:FormatText(var_238_14.content)

				arg_235_1.text_.text = var_238_15

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_17 = 34 <= 0 and var_238_13 or var_238_13 * (utf8.len(var_238_15) / 34)

				if (34 <= 0 and var_238_13 or var_238_13 * (utf8.len(var_238_15) / 34)) > 0 and var_238_13 < var_238_17 then
					arg_235_1.talkMaxDuration = var_238_17

					if var_238_17 + var_238_12 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_17 + var_238_12
					end
				end

				arg_235_1.text_.text = var_238_15
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131054", "story_v_out_322131.awb") ~= 0 then
					local var_238_18 = manager.audio:GetVoiceLength("story_v_out_322131", "322131054", "story_v_out_322131.awb") / 1000

					if var_238_18 + var_238_12 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_12
					end

					if var_238_14.prefab_name ~= "" and arg_235_1.actors_[var_238_14.prefab_name] ~= nil then
						local var_238_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_14.prefab_name].transform, "story_v_out_322131", "322131054", "story_v_out_322131.awb")

						arg_235_1:RecordAudio("322131054", var_238_19)
						arg_235_1:RecordAudio("322131054", var_238_19)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_322131", "322131054", "story_v_out_322131.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_322131", "322131054", "story_v_out_322131.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_20 = math.max(var_238_13, arg_235_1.talkMaxDuration)

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_20 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_12) / var_238_20

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_12 + var_238_20 and arg_235_1.time_ < var_238_12 + var_238_20 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322131055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322131055
		arg_239_1.duration_ = 2.77

		local var_239_0 = {
			zh = 2.066,
			ja = 2.766
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
				arg_239_0:Play322131056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1044ui_story = arg_239_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1044ui_story"].transform.position).z)
				arg_239_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1044ui_story"].transform.localEulerAngles = arg_239_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_239_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1044ui_story"].transform.position).z)
				arg_239_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1044ui_story"].transform.localEulerAngles = arg_239_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1044ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1044ui_story == nil then
				arg_239_1.var_.characterEffect1044ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1044ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1044ui_story then
				arg_239_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_242_4 = arg_239_1.actors_["10131ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect10131ui_story == nil then
				arg_239_1.var_.characterEffect10131ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_5 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_5 and not isNil(var_242_4) then
				if arg_239_1.var_.characterEffect10131ui_story and not isNil(var_242_4) then
					arg_239_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_5)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_5 and arg_239_1.time_ < 0 + var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect10131ui_story then
				arg_239_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_242_6 = 0
			local var_242_7 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(322131055)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 10 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 10)

				if (10 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 10)) > 0 and var_242_7 < var_242_11 then
					arg_239_1.talkMaxDuration = var_242_11

					if var_242_11 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131055", "story_v_out_322131.awb") ~= 0 then
					local var_242_12 = manager.audio:GetVoiceLength("story_v_out_322131", "322131055", "story_v_out_322131.awb") / 1000

					if var_242_12 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_6
					end

					if var_242_8.prefab_name ~= "" and arg_239_1.actors_[var_242_8.prefab_name] ~= nil then
						local var_242_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_8.prefab_name].transform, "story_v_out_322131", "322131055", "story_v_out_322131.awb")

						arg_239_1:RecordAudio("322131055", var_242_13)
						arg_239_1:RecordAudio("322131055", var_242_13)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322131", "322131055", "story_v_out_322131.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322131", "322131055", "story_v_out_322131.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322131056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322131056
		arg_243_1.duration_ = 4.63

		local var_243_0 = {
			zh = 2.233,
			ja = 4.633
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
				arg_243_0:Play322131057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10131ui_story"]) and arg_243_1.var_.characterEffect10131ui_story == nil then
				arg_243_1.var_.characterEffect10131ui_story = arg_243_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10131ui_story"]) then
				if arg_243_1.var_.characterEffect10131ui_story and not isNil(arg_243_1.actors_["10131ui_story"]) then
					arg_243_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10131ui_story"]) and arg_243_1.var_.characterEffect10131ui_story then
				arg_243_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_246_2 = arg_243_1.actors_["1044ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.characterEffect1044ui_story == nil then
				arg_243_1.var_.characterEffect1044ui_story = var_246_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_3 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.characterEffect1044ui_story and not isNil(var_246_2) then
					arg_243_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_3)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.characterEffect1044ui_story then
				arg_243_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_4 = 0
			local var_246_5 = 0.35

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1366].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(322131056)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 14 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 14)

				if (14 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 14)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131056", "story_v_out_322131.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131056", "story_v_out_322131.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_322131", "322131056", "story_v_out_322131.awb")

						arg_243_1:RecordAudio("322131056", var_246_11)
						arg_243_1:RecordAudio("322131056", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_322131", "322131056", "story_v_out_322131.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_322131", "322131056", "story_v_out_322131.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play322131057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 322131057
		arg_247_1.duration_ = 2

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play322131058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1044ui_story"]) and arg_247_1.var_.characterEffect1044ui_story == nil then
				arg_247_1.var_.characterEffect1044ui_story = arg_247_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1044ui_story"]) then
				if arg_247_1.var_.characterEffect1044ui_story and not isNil(arg_247_1.actors_["1044ui_story"]) then
					arg_247_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1044ui_story"]) and arg_247_1.var_.characterEffect1044ui_story then
				arg_247_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_250_2 = arg_247_1.actors_["10131ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect10131ui_story == nil then
				arg_247_1.var_.characterEffect10131ui_story = var_250_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_3 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.characterEffect10131ui_story and not isNil(var_250_2) then
					arg_247_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_3)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect10131ui_story then
				arg_247_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_250_4 = 0
			local var_250_5 = 0.05

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(322131057)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 2 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 2)

				if (2 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 2)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131057", "story_v_out_322131.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131057", "story_v_out_322131.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_322131", "322131057", "story_v_out_322131.awb")

						arg_247_1:RecordAudio("322131057", var_250_11)
						arg_247_1:RecordAudio("322131057", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_322131", "322131057", "story_v_out_322131.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_322131", "322131057", "story_v_out_322131.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play322131058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 322131058
		arg_251_1.duration_ = 5.73

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play322131059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_9000

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1044ui_story = arg_251_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1044ui_story"].transform.position).z)
				arg_251_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1044ui_story"].transform.localEulerAngles = arg_251_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1044ui_story"].transform.position).z)
				arg_251_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1044ui_story"].transform.localEulerAngles = arg_251_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["10131ui_story"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10131ui_story = var_254_1.localPosition
			end

			local var_254_2 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 then
				var_254_1.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_2)
				var_254_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_1.position).x, (manager.ui.mainCamera.transform.position - var_254_1.position).y, (manager.ui.mainCamera.transform.position - var_254_1.position).z)
				var_254_1.localEulerAngles.z = 0
				var_254_1.localEulerAngles.x = 0
				var_254_1.localEulerAngles = var_254_1.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 then
				var_254_1.localPosition = Vector3.New(0, 100, 0)
				var_254_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_1.position).x, (manager.ui.mainCamera.transform.position - var_254_1.position).y, (manager.ui.mainCamera.transform.position - var_254_1.position).z)
				var_254_1.localEulerAngles.z = 0
				var_254_1.localEulerAngles.x = 0
				var_254_1.localEulerAngles = var_254_1.localEulerAngles
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_3 = arg_251_1.var_.effect1058

				if not arg_251_1.var_.effect1058 then
					var_254_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_254_3.name = "1058"
					arg_251_1.var_.effect1058 = var_254_3
				else
					var_254_3.transform:SetParent(var_254_9000)
				end

				var_254_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_254_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.33333333333333 < arg_251_1.time_ and arg_251_1.time_ <= 2.33333333333333 + arg_254_0 then
				if arg_251_1.var_.effect1058 then
					Object.Destroy(arg_251_1.var_.effect1058)

					arg_251_1.var_.effect1058 = nil
				end
			end

			local var_254_6 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_251_1.time_ and arg_251_1.time_ <= 0.034000001847744 + arg_254_0 then
				arg_251_1.var_.shakeOldPos = var_254_6.localPosition
			end

			local var_254_7 = 0.566666666666667

			if 0.034000001847744 <= arg_251_1.time_ and arg_251_1.time_ < 0.034000001847744 + var_254_7 then
				local var_254_8, var_254_9 = math.modf((arg_251_1.time_ - 0.034000001847744) / 0.099)

				var_254_6.localPosition = Vector3.New(var_254_9 * 0.1, var_254_9 * 0.1, var_254_9 * 0.1) + arg_251_1.var_.shakeOldPos
			end

			if arg_251_1.time_ >= 0.034000001847744 + var_254_7 and arg_251_1.time_ < 0.034000001847744 + var_254_7 + arg_254_0 then
				var_254_6.localPosition = arg_251_1.var_.shakeOldPos
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:AudioAction("play", "effect", "se_story_145", "se_story_145_attack", "")
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_11 = 0.733333333333333
			local var_254_12 = 1.1

			if 0.733333333333333 < arg_251_1.time_ and arg_251_1.time_ <= var_254_11 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_13 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_13:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_14 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(322131058).content)

				arg_251_1.text_.text = var_254_14

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_16 = 44 <= 0 and var_254_12 or var_254_12 * (utf8.len(var_254_14) / 44)

				if (44 <= 0 and var_254_12 or var_254_12 * (utf8.len(var_254_14) / 44)) > 0 and var_254_12 < var_254_16 then
					arg_251_1.talkMaxDuration = var_254_16
					var_254_11 = var_254_11 + 0.3

					if var_254_16 + var_254_11 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_16 + var_254_11
					end
				end

				arg_251_1.text_.text = var_254_14
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_17 = var_254_11 + 0.3
			local var_254_18 = math.max(var_254_12, arg_251_1.talkMaxDuration)

			if var_254_11 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_18 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_17) / var_254_18

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_17 + var_254_18 and arg_251_1.time_ < var_254_17 + var_254_18 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play322131059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322131059
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322131060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(322131059).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 47 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 47)

				if (47 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 47)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play322131060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322131060
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322131061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.225

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(322131060).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 49 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 49)

				if (49 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 49)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322131061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322131061
		arg_265_1.duration_ = 5.77

		local var_265_0 = {
			zh = 3.733,
			ja = 5.766
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322131062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1044ui_story = arg_265_1.actors_["1044ui_story"].transform.localPosition

				arg_265_1:ShowWeapon(arg_265_1.var_["1044ui_story" .. "Animator"].transform, false)
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1044ui_story"].transform.position).z)
				arg_265_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1044ui_story"].transform.localEulerAngles = arg_265_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_265_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1044ui_story"].transform.position).z)
				arg_265_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1044ui_story"].transform.localEulerAngles = arg_265_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1044ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1044ui_story == nil then
				arg_265_1.var_.characterEffect1044ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1044ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1044ui_story then
				arg_265_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_268_4 = 0
			local var_268_5 = 0.525

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(322131061)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 21 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 21)

				if (21 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 21)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131061", "story_v_out_322131.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131061", "story_v_out_322131.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_322131", "322131061", "story_v_out_322131.awb")

						arg_265_1:RecordAudio("322131061", var_268_11)
						arg_265_1:RecordAudio("322131061", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322131", "322131061", "story_v_out_322131.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322131", "322131061", "story_v_out_322131.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play322131062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322131062
		arg_269_1.duration_ = 2

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322131063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1043ui_story = arg_269_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1043ui_story"].transform.position).z)
				arg_269_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1043ui_story"].transform.localEulerAngles = arg_269_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_269_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1043ui_story"].transform.position).z)
				arg_269_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1043ui_story"].transform.localEulerAngles = arg_269_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1043ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1043ui_story == nil then
				arg_269_1.var_.characterEffect1043ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1043ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1043ui_story then
				arg_269_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_272_4 = arg_269_1.actors_["1044ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect1044ui_story == nil then
				arg_269_1.var_.characterEffect1044ui_story = var_272_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_5 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_5 and not isNil(var_272_4) then
				if arg_269_1.var_.characterEffect1044ui_story and not isNil(var_272_4) then
					arg_269_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_5)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_5 and arg_269_1.time_ < 0 + var_272_5 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect1044ui_story then
				arg_269_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_6 = 0
			local var_272_7 = 0.175

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(322131062)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 7 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 7)

				if (7 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 7)) > 0 and var_272_7 < var_272_11 then
					arg_269_1.talkMaxDuration = var_272_11

					if var_272_11 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131062", "story_v_out_322131.awb") ~= 0 then
					local var_272_12 = manager.audio:GetVoiceLength("story_v_out_322131", "322131062", "story_v_out_322131.awb") / 1000

					if var_272_12 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_6
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_out_322131", "322131062", "story_v_out_322131.awb")

						arg_269_1:RecordAudio("322131062", var_272_13)
						arg_269_1:RecordAudio("322131062", var_272_13)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322131", "322131062", "story_v_out_322131.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322131", "322131062", "story_v_out_322131.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play322131063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322131063
		arg_273_1.duration_ = 4.3

		local var_273_0 = {
			zh = 4.066,
			ja = 4.3
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322131064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1044ui_story"]) and arg_273_1.var_.characterEffect1044ui_story == nil then
				arg_273_1.var_.characterEffect1044ui_story = arg_273_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1044ui_story"]) then
				if arg_273_1.var_.characterEffect1044ui_story and not isNil(arg_273_1.actors_["1044ui_story"]) then
					arg_273_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1044ui_story"]) and arg_273_1.var_.characterEffect1044ui_story then
				arg_273_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_276_2 = arg_273_1.actors_["1043ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect1043ui_story == nil then
				arg_273_1.var_.characterEffect1043ui_story = var_276_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_3 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.characterEffect1043ui_story and not isNil(var_276_2) then
					arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_3)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect1043ui_story then
				arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_276_4 = 0
			local var_276_5 = 0.425

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(322131063)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 17 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 17)

				if (17 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 17)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131063", "story_v_out_322131.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131063", "story_v_out_322131.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_322131", "322131063", "story_v_out_322131.awb")

						arg_273_1:RecordAudio("322131063", var_276_11)
						arg_273_1:RecordAudio("322131063", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322131", "322131063", "story_v_out_322131.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322131", "322131063", "story_v_out_322131.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322131064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322131064
		arg_277_1.duration_ = 3.5

		local var_277_0 = {
			zh = 3.1,
			ja = 3.5
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322131065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1043ui_story"]) and arg_277_1.var_.characterEffect1043ui_story == nil then
				arg_277_1.var_.characterEffect1043ui_story = arg_277_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1043ui_story"]) then
				if arg_277_1.var_.characterEffect1043ui_story and not isNil(arg_277_1.actors_["1043ui_story"]) then
					arg_277_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1043ui_story"]) and arg_277_1.var_.characterEffect1043ui_story then
				arg_277_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_280_2 = arg_277_1.actors_["1044ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect1044ui_story == nil then
				arg_277_1.var_.characterEffect1044ui_story = var_280_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_3 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.characterEffect1044ui_story and not isNil(var_280_2) then
					arg_277_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_3)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect1044ui_story then
				arg_277_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_4 = 0
			local var_280_5 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(322131064)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 15 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 15)

				if (15 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 15)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131064", "story_v_out_322131.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131064", "story_v_out_322131.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_322131", "322131064", "story_v_out_322131.awb")

						arg_277_1:RecordAudio("322131064", var_280_11)
						arg_277_1:RecordAudio("322131064", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322131", "322131064", "story_v_out_322131.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322131", "322131064", "story_v_out_322131.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322131065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322131065
		arg_281_1.duration_ = 5.5

		local var_281_0 = {
			zh = 3.733,
			ja = 5.5
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
				arg_281_0:Play322131066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.45

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(322131065)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 18 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 18)

				if (18 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 18)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131065", "story_v_out_322131.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_322131", "322131065", "story_v_out_322131.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_322131", "322131065", "story_v_out_322131.awb")

						arg_281_1:RecordAudio("322131065", var_284_6)
						arg_281_1:RecordAudio("322131065", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322131", "322131065", "story_v_out_322131.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322131", "322131065", "story_v_out_322131.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322131066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322131066
		arg_285_1.duration_ = 6.8

		local var_285_0 = {
			zh = 4.966,
			ja = 6.8
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322131067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1044ui_story"]) and arg_285_1.var_.characterEffect1044ui_story == nil then
				arg_285_1.var_.characterEffect1044ui_story = arg_285_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1044ui_story"]) then
				if arg_285_1.var_.characterEffect1044ui_story and not isNil(arg_285_1.actors_["1044ui_story"]) then
					arg_285_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1044ui_story"]) and arg_285_1.var_.characterEffect1044ui_story then
				arg_285_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["1043ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1043ui_story == nil then
				arg_285_1.var_.characterEffect1043ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1043ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1043ui_story then
				arg_285_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			local var_288_4 = 0
			local var_288_5 = 0.475

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(322131066)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 19 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 19)

				if (19 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 19)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131066", "story_v_out_322131.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131066", "story_v_out_322131.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_322131", "322131066", "story_v_out_322131.awb")

						arg_285_1:RecordAudio("322131066", var_288_11)
						arg_285_1:RecordAudio("322131066", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322131", "322131066", "story_v_out_322131.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322131", "322131066", "story_v_out_322131.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322131067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322131067
		arg_289_1.duration_ = 4.1

		local var_289_0 = {
			zh = 4,
			ja = 4.1
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
				arg_289_0:Play322131068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_292_0 = 0
			local var_292_1 = 0.425

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(322131067)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 17 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 17)

				if (17 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 17)) > 0 and var_292_1 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131067", "story_v_out_322131.awb") ~= 0 then
					local var_292_6 = manager.audio:GetVoiceLength("story_v_out_322131", "322131067", "story_v_out_322131.awb") / 1000

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end

					if var_292_2.prefab_name ~= "" and arg_289_1.actors_[var_292_2.prefab_name] ~= nil then
						local var_292_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_2.prefab_name].transform, "story_v_out_322131", "322131067", "story_v_out_322131.awb")

						arg_289_1:RecordAudio("322131067", var_292_7)
						arg_289_1:RecordAudio("322131067", var_292_7)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322131", "322131067", "story_v_out_322131.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322131", "322131067", "story_v_out_322131.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322131068 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322131068
		arg_293_1.duration_ = 3.13

		local var_293_0 = {
			zh = 2.6,
			ja = 3.133
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
				arg_293_0:Play322131069(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1043ui_story"]) and arg_293_1.var_.characterEffect1043ui_story == nil then
				arg_293_1.var_.characterEffect1043ui_story = arg_293_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1043ui_story"]) then
				if arg_293_1.var_.characterEffect1043ui_story and not isNil(arg_293_1.actors_["1043ui_story"]) then
					arg_293_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1043ui_story"]) and arg_293_1.var_.characterEffect1043ui_story then
				arg_293_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_296_2 = arg_293_1.actors_["1044ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect1044ui_story == nil then
				arg_293_1.var_.characterEffect1044ui_story = var_296_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_3 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.characterEffect1044ui_story and not isNil(var_296_2) then
					arg_293_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_3)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect1044ui_story then
				arg_293_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_296_4 = 0
			local var_296_5 = 0.225

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(322131068)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 9 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 9)

				if (9 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 9)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131068", "story_v_out_322131.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131068", "story_v_out_322131.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_out_322131", "322131068", "story_v_out_322131.awb")

						arg_293_1:RecordAudio("322131068", var_296_11)
						arg_293_1:RecordAudio("322131068", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322131", "322131068", "story_v_out_322131.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322131", "322131068", "story_v_out_322131.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322131069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322131069
		arg_297_1.duration_ = 7.43

		local var_297_0 = {
			zh = 3.9,
			ja = 7.433
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
				arg_297_0:Play322131070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_300_0 = 0
			local var_300_1 = 0.55

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(322131069)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 22 <= 0 and var_300_1 or var_300_1 * (utf8.len(var_300_3) / 22)

				if (22 <= 0 and var_300_1 or var_300_1 * (utf8.len(var_300_3) / 22)) > 0 and var_300_1 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131069", "story_v_out_322131.awb") ~= 0 then
					local var_300_6 = manager.audio:GetVoiceLength("story_v_out_322131", "322131069", "story_v_out_322131.awb") / 1000

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end

					if var_300_2.prefab_name ~= "" and arg_297_1.actors_[var_300_2.prefab_name] ~= nil then
						local var_300_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_2.prefab_name].transform, "story_v_out_322131", "322131069", "story_v_out_322131.awb")

						arg_297_1:RecordAudio("322131069", var_300_7)
						arg_297_1:RecordAudio("322131069", var_300_7)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322131", "322131069", "story_v_out_322131.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322131", "322131069", "story_v_out_322131.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play322131070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322131070
		arg_301_1.duration_ = 13.07

		local var_301_0 = {
			zh = 8.6,
			ja = 13.066
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322131071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1044ui_story"]) and arg_301_1.var_.characterEffect1044ui_story == nil then
				arg_301_1.var_.characterEffect1044ui_story = arg_301_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1044ui_story"]) then
				if arg_301_1.var_.characterEffect1044ui_story and not isNil(arg_301_1.actors_["1044ui_story"]) then
					arg_301_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1044ui_story"]) and arg_301_1.var_.characterEffect1044ui_story then
				arg_301_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_304_2 = arg_301_1.actors_["1043ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect1043ui_story == nil then
				arg_301_1.var_.characterEffect1043ui_story = var_304_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_3 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.characterEffect1043ui_story and not isNil(var_304_2) then
					arg_301_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_3)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect1043ui_story then
				arg_301_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_304_4 = 0
			local var_304_5 = 0.75

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(322131070)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 30 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 30)

				if (30 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 30)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131070", "story_v_out_322131.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131070", "story_v_out_322131.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_322131", "322131070", "story_v_out_322131.awb")

						arg_301_1:RecordAudio("322131070", var_304_11)
						arg_301_1:RecordAudio("322131070", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322131", "322131070", "story_v_out_322131.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322131", "322131070", "story_v_out_322131.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322131071 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322131071
		arg_305_1.duration_ = 10

		local var_305_0 = {
			zh = 7.333,
			ja = 10
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
				arg_305_0:Play322131072(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if arg_305_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_308_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_305_1.stage_.transform)

				var_308_0.name = "1111ui_story"
				var_308_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_["1111ui_story"] = var_308_0

				local var_308_1 = var_308_0:GetComponentInChildren(typeof(CharacterEffect))

				var_308_1.enabled = true

				local var_308_2 = GameObjectTools.GetOrAddComponent(var_308_0, typeof(DynamicBoneHelper))

				if var_308_2 then
					var_308_2:EnableDynamicBone(false)
				end

				arg_305_1:ShowWeapon(var_308_1.transform, false)

				arg_305_1.var_["1111ui_story" .. "Animator"] = var_308_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_305_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_305_1.var_["1111ui_story" .. "LipSync"] = var_308_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_308_3 = 0
			local var_308_4 = 0.85

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:GetWordFromCfg(322131071)
				local var_308_6 = arg_305_1:FormatText(var_308_5.content)

				arg_305_1.text_.text = var_308_6

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_8 = 34 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_6) / 34)

				if (34 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_6) / 34)) > 0 and var_308_4 < var_308_8 then
					arg_305_1.talkMaxDuration = var_308_8

					if var_308_8 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_3
					end
				end

				arg_305_1.text_.text = var_308_6
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131071", "story_v_out_322131.awb") ~= 0 then
					local var_308_9 = manager.audio:GetVoiceLength("story_v_out_322131", "322131071", "story_v_out_322131.awb") / 1000

					if var_308_9 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_3
					end

					if var_308_5.prefab_name ~= "" and arg_305_1.actors_[var_308_5.prefab_name] ~= nil then
						local var_308_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_5.prefab_name].transform, "story_v_out_322131", "322131071", "story_v_out_322131.awb")

						arg_305_1:RecordAudio("322131071", var_308_10)
						arg_305_1:RecordAudio("322131071", var_308_10)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322131", "322131071", "story_v_out_322131.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322131", "322131071", "story_v_out_322131.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_11 = math.max(var_308_4, arg_305_1.talkMaxDuration)

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_11 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_3) / var_308_11

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_3 + var_308_11 and arg_305_1.time_ < var_308_3 + var_308_11 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play322131072 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322131072
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322131073(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_9000

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1044ui_story = arg_309_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1044ui_story"].transform.position).z)
				arg_309_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1044ui_story"].transform.localEulerAngles = arg_309_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1044ui_story"].transform.position).z)
				arg_309_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1044ui_story"].transform.localEulerAngles = arg_309_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1043ui_story"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1043ui_story = var_312_1.localPosition
			end

			local var_312_2 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 then
				var_312_1.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 0) / var_312_2)
				var_312_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_1.position).x, (manager.ui.mainCamera.transform.position - var_312_1.position).y, (manager.ui.mainCamera.transform.position - var_312_1.position).z)
				var_312_1.localEulerAngles.z = 0
				var_312_1.localEulerAngles.x = 0
				var_312_1.localEulerAngles = var_312_1.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 then
				var_312_1.localPosition = Vector3.New(0, 100, 0)
				var_312_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_1.position).x, (manager.ui.mainCamera.transform.position - var_312_1.position).y, (manager.ui.mainCamera.transform.position - var_312_1.position).z)
				var_312_1.localEulerAngles.z = 0
				var_312_1.localEulerAngles.x = 0
				var_312_1.localEulerAngles = var_312_1.localEulerAngles
			end

			if 0.1 < arg_309_1.time_ and arg_309_1.time_ <= 0.1 + arg_312_0 then
				arg_309_1:AudioAction("play", "effect", "c_1043", "c_1043_attack2", "")
			end

			local var_312_4 = manager.ui.mainCamera.transform

			if 0.1 < arg_309_1.time_ and arg_309_1.time_ <= 0.1 + arg_312_0 then
				arg_309_1.var_.shakeOldPos = var_312_4.localPosition
			end

			local var_312_5 = 0.733333330353101

			if 0.1 <= arg_309_1.time_ and arg_309_1.time_ < 0.1 + var_312_5 then
				local var_312_6, var_312_7 = math.modf((arg_309_1.time_ - 0.1) / 0.132)

				var_312_4.localPosition = Vector3.New(var_312_7 * 0.13, var_312_7 * 0.13, var_312_7 * 0.13) + arg_309_1.var_.shakeOldPos
			end

			if arg_309_1.time_ >= 0.1 + var_312_5 and arg_309_1.time_ < 0.1 + var_312_5 + arg_312_0 then
				var_312_4.localPosition = arg_309_1.var_.shakeOldPos
			end

			if 0.1 < arg_309_1.time_ and arg_309_1.time_ <= 0.1 + arg_312_0 then
				local var_312_8 = arg_309_1.var_.effect1072

				if not arg_309_1.var_.effect1072 then
					var_312_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_312_8.name = "1072"
					arg_309_1.var_.effect1072 = var_312_8
				else
					var_312_8.transform:SetParent(var_312_9000)
				end

				var_312_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_312_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.06666666666667 < arg_309_1.time_ and arg_309_1.time_ <= 2.06666666666667 + arg_312_0 then
				if arg_309_1.var_.effect1072 then
					Object.Destroy(arg_309_1.var_.effect1072)

					arg_309_1.var_.effect1072 = nil
				end
			end

			local var_312_11 = 0
			local var_312_12 = 1.45

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_11 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_13 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(322131072).content)

				arg_309_1.text_.text = var_312_13

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_15 = 58 <= 0 and var_312_12 or var_312_12 * (utf8.len(var_312_13) / 58)

				if (58 <= 0 and var_312_12 or var_312_12 * (utf8.len(var_312_13) / 58)) > 0 and var_312_12 < var_312_15 then
					arg_309_1.talkMaxDuration = var_312_15

					if var_312_15 + var_312_11 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_15 + var_312_11
					end
				end

				arg_309_1.text_.text = var_312_13
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_12, arg_309_1.talkMaxDuration)

			if var_312_11 <= arg_309_1.time_ and arg_309_1.time_ < var_312_11 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_11) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_11 + var_312_16 and arg_309_1.time_ < var_312_11 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play322131073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322131073
		arg_313_1.duration_ = 2.27

		local var_313_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322131074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = arg_313_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).z)
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles = arg_313_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_313_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).z)
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles = arg_313_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1043ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_4 = 0
			local var_316_5 = 0.2

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(322131073)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 8 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 8)

				if (8 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 8)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131073", "story_v_out_322131.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131073", "story_v_out_322131.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_out_322131", "322131073", "story_v_out_322131.awb")

						arg_313_1:RecordAudio("322131073", var_316_11)
						arg_313_1:RecordAudio("322131073", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322131", "322131073", "story_v_out_322131.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322131", "322131073", "story_v_out_322131.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play322131074 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322131074
		arg_317_1.duration_ = 6.83

		local var_317_0 = {
			zh = 5.2,
			ja = 6.833
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322131075(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1044ui_story = arg_317_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1044ui_story"].transform.position).z)
				arg_317_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1044ui_story"].transform.localEulerAngles = arg_317_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_317_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1044ui_story"].transform.position).z)
				arg_317_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1044ui_story"].transform.localEulerAngles = arg_317_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1044ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1044ui_story == nil then
				arg_317_1.var_.characterEffect1044ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1044ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1044ui_story then
				arg_317_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_320_4 = arg_317_1.actors_["1043ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect1043ui_story == nil then
				arg_317_1.var_.characterEffect1043ui_story = var_320_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_5 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_5 and not isNil(var_320_4) then
				if arg_317_1.var_.characterEffect1043ui_story and not isNil(var_320_4) then
					arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_5)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_5 and arg_317_1.time_ < 0 + var_320_5 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect1043ui_story then
				arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_320_6 = 0
			local var_320_7 = 0.575

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_8 = arg_317_1:GetWordFromCfg(322131074)
				local var_320_9 = arg_317_1:FormatText(var_320_8.content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 23 <= 0 and var_320_7 or var_320_7 * (utf8.len(var_320_9) / 23)

				if (23 <= 0 and var_320_7 or var_320_7 * (utf8.len(var_320_9) / 23)) > 0 and var_320_7 < var_320_11 then
					arg_317_1.talkMaxDuration = var_320_11

					if var_320_11 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131074", "story_v_out_322131.awb") ~= 0 then
					local var_320_12 = manager.audio:GetVoiceLength("story_v_out_322131", "322131074", "story_v_out_322131.awb") / 1000

					if var_320_12 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_6
					end

					if var_320_8.prefab_name ~= "" and arg_317_1.actors_[var_320_8.prefab_name] ~= nil then
						local var_320_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_8.prefab_name].transform, "story_v_out_322131", "322131074", "story_v_out_322131.awb")

						arg_317_1:RecordAudio("322131074", var_320_13)
						arg_317_1:RecordAudio("322131074", var_320_13)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322131", "322131074", "story_v_out_322131.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322131", "322131074", "story_v_out_322131.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play322131075 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322131075
		arg_321_1.duration_ = 2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322131076(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_324_0 = 0
			local var_324_1 = 0.125

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(322131075)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 5 <= 0 and var_324_1 or var_324_1 * (utf8.len(var_324_3) / 5)

				if (5 <= 0 and var_324_1 or var_324_1 * (utf8.len(var_324_3) / 5)) > 0 and var_324_1 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131075", "story_v_out_322131.awb") ~= 0 then
					local var_324_6 = manager.audio:GetVoiceLength("story_v_out_322131", "322131075", "story_v_out_322131.awb") / 1000

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end

					if var_324_2.prefab_name ~= "" and arg_321_1.actors_[var_324_2.prefab_name] ~= nil then
						local var_324_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_2.prefab_name].transform, "story_v_out_322131", "322131075", "story_v_out_322131.awb")

						arg_321_1:RecordAudio("322131075", var_324_7)
						arg_321_1:RecordAudio("322131075", var_324_7)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322131", "322131075", "story_v_out_322131.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322131", "322131075", "story_v_out_322131.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322131076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322131076
		arg_325_1.duration_ = 5.5

		local var_325_0 = {
			zh = 4.3,
			ja = 5.5
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
			arg_325_1.auto_ = false
		end

		function arg_325_1.playNext_(arg_327_0)
			arg_325_1.onStoryFinished_()
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1043ui_story = arg_325_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1043ui_story"].transform.position).z)
				arg_325_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1043ui_story"].transform.localEulerAngles = arg_325_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_325_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1043ui_story"].transform.position).z)
				arg_325_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1043ui_story"].transform.localEulerAngles = arg_325_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1043ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1043ui_story == nil then
				arg_325_1.var_.characterEffect1043ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1043ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1043ui_story then
				arg_325_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["1044ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect1044ui_story == nil then
				arg_325_1.var_.characterEffect1044ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_5 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 and not isNil(var_328_4) then
				if arg_325_1.var_.characterEffect1044ui_story and not isNil(var_328_4) then
					arg_325_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_5)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect1044ui_story then
				arg_325_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_6 = 0
			local var_328_7 = 0.55

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(322131076)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 22 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 22)

				if (22 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 22)) > 0 and var_328_7 < var_328_11 then
					arg_325_1.talkMaxDuration = var_328_11

					if var_328_11 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131076", "story_v_out_322131.awb") ~= 0 then
					local var_328_12 = manager.audio:GetVoiceLength("story_v_out_322131", "322131076", "story_v_out_322131.awb") / 1000

					if var_328_12 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_6
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_out_322131", "322131076", "story_v_out_322131.awb")

						arg_325_1:RecordAudio("322131076", var_328_13)
						arg_325_1:RecordAudio("322131076", var_328_13)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322131", "322131076", "story_v_out_322131.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322131", "322131076", "story_v_out_322131.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2203",
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L10j",
		"TextureConfig/Background/L17f",
		"TextureConfig/Background/L10k"
	},
	voices = {
		"story_v_out_322131.awb"
	}
}
