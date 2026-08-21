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
			local var_4_0 = "MS2203"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.MS2203

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2203" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 0.500666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = arg_1_1.bgs_.MS2203.transform
			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2203 = var_4_40.localPosition
			end

			local var_4_42 = 2

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42
				local var_4_44 = Vector3.New(0, 1, 10)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2203, var_4_44, var_4_43)
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_45 = manager.ui.mainCamera.transform
			local var_4_46 = 0

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_47 = arg_1_1.var_.effect1001
				local var_4_48
				local var_4_49 = var_4_45

				if not var_4_47 then
					var_4_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), var_4_49)
					var_4_47.name = "1001"
					arg_1_1.var_.effect1001 = var_4_47
				else
					var_4_47.transform:SetParent(var_4_49)
				end

				var_4_47.transform.localPosition = Vector3.New(0, 0, -2.5)
				var_4_47.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_50 = 2
			local var_4_51 = 0.55

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_52 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_52:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_53 = arg_1_1:GetWordFromCfg(322131001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 22
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_51 or var_4_51 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_51 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_50 = var_4_50 + 0.3

					if var_4_57 + var_4_50 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_50
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_50 + 0.3
			local var_4_59 = math.max(var_4_51, arg_1_1.talkMaxDuration)

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_59 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_58) / var_4_59

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
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
			local var_12_0 = 0
			local var_12_1 = 0.75

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(322131002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 30
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
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
			local var_16_0 = arg_13_1.bgs_.MS2203.transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPosMS2203 = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 1, 10)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPosMS2203, var_16_4, var_16_3)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_16_5 = arg_13_1.bgs_.MS2203.transform
			local var_16_6 = 0.0340000000000001

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPosMS2203 = var_16_5.localPosition
			end

			local var_16_7 = 0.966

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.3, 0.9, 9.5)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPosMS2203, var_16_9, var_16_8)
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.3, 0.9, 9.5)
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_10 = 1
			local var_16_11 = 0.6

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_12 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_12:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_13 = arg_13_1:FormatText(StoryNameCfg[67].name)

				arg_13_1.leftNameTxt_.text = var_16_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(322131003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 24
				local var_16_17 = utf8.len(var_16_15)
				local var_16_18 = var_16_16 <= 0 and var_16_11 or var_16_11 * (var_16_17 / var_16_16)

				if var_16_18 > 0 and var_16_11 < var_16_18 then
					arg_13_1.talkMaxDuration = var_16_18
					var_16_10 = var_16_10 + 0.3

					if var_16_18 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131003", "story_v_out_322131.awb") ~= 0 then
					local var_16_19 = manager.audio:GetVoiceLength("story_v_out_322131", "322131003", "story_v_out_322131.awb") / 1000

					if var_16_19 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_10
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_322131", "322131003", "story_v_out_322131.awb")

						arg_13_1:RecordAudio("322131003", var_16_20)
						arg_13_1:RecordAudio("322131003", var_16_20)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322131", "322131003", "story_v_out_322131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322131", "322131003", "story_v_out_322131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = var_16_10 + 0.3
			local var_16_22 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_21) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
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
			local var_22_0 = 0
			local var_22_1 = 0.2

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[1049].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:GetWordFromCfg(322131004)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 8
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131004", "story_v_out_322131.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131004", "story_v_out_322131.awb") / 1000

					if var_22_8 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_0
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_322131", "322131004", "story_v_out_322131.awb")

						arg_19_1:RecordAudio("322131004", var_22_9)
						arg_19_1:RecordAudio("322131004", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322131", "322131004", "story_v_out_322131.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322131", "322131004", "story_v_out_322131.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_10 and arg_19_1.time_ < var_22_0 + var_22_10 + arg_22_0 then
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
			local var_26_0 = 0
			local var_26_1 = 0.7

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[67].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_3 = arg_23_1:GetWordFromCfg(322131005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 28
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131005", "story_v_out_322131.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131005", "story_v_out_322131.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_322131", "322131005", "story_v_out_322131.awb")

						arg_23_1:RecordAudio("322131005", var_26_9)
						arg_23_1:RecordAudio("322131005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322131", "322131005", "story_v_out_322131.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322131", "322131005", "story_v_out_322131.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_10 and arg_23_1.time_ < var_26_0 + var_26_10 + arg_26_0 then
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
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			local var_30_1 = 0.166666666666667

			if arg_27_1.time_ >= var_30_0 + var_30_1 and arg_27_1.time_ < var_30_0 + var_30_1 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			local var_30_2 = 0
			local var_30_3 = 0.075

			if var_30_2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_4 = arg_27_1:FormatText(StoryNameCfg[1049].name)

				arg_27_1.leftNameTxt_.text = var_30_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_5 = arg_27_1:GetWordFromCfg(322131006)
				local var_30_6 = arg_27_1:FormatText(var_30_5.content)

				arg_27_1.text_.text = var_30_6

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 3
				local var_30_8 = utf8.len(var_30_6)
				local var_30_9 = var_30_7 <= 0 and var_30_3 or var_30_3 * (var_30_8 / var_30_7)

				if var_30_9 > 0 and var_30_3 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_6
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131006", "story_v_out_322131.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131006", "story_v_out_322131.awb") / 1000

					if var_30_10 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_2
					end

					if var_30_5.prefab_name ~= "" and arg_27_1.actors_[var_30_5.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_5.prefab_name].transform, "story_v_out_322131", "322131006", "story_v_out_322131.awb")

						arg_27_1:RecordAudio("322131006", var_30_11)
						arg_27_1:RecordAudio("322131006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322131", "322131006", "story_v_out_322131.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322131", "322131006", "story_v_out_322131.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_12 and arg_27_1.time_ < var_30_2 + var_30_12 + arg_30_0 then
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
			local var_34_0 = "L14f"

			if arg_31_1.bgs_[var_34_0] == nil then
				local var_34_1 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_34_0)
				var_34_1.name = var_34_0
				var_34_1.transform.parent = arg_31_1.stage_.transform
				var_34_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_[var_34_0] = var_34_1
			end

			local var_34_2 = 2.00000000298023

			if var_34_2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				local var_34_3 = manager.ui.mainCamera.transform.localPosition
				local var_34_4 = Vector3.New(0, 0, 10) + Vector3.New(var_34_3.x, var_34_3.y, 0)
				local var_34_5 = arg_31_1.bgs_.L14f

				var_34_5.transform.localPosition = var_34_4
				var_34_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_6 = var_34_5:GetComponent("SpriteRenderer")

				if var_34_6 and var_34_6.sprite then
					local var_34_7 = (var_34_5.transform.localPosition - var_34_3).z
					local var_34_8 = manager.ui.mainCameraCom_
					local var_34_9 = 2 * var_34_7 * Mathf.Tan(var_34_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_34_10 = var_34_9 * var_34_8.aspect
					local var_34_11 = var_34_6.sprite.bounds.size.x
					local var_34_12 = var_34_6.sprite.bounds.size.y
					local var_34_13 = var_34_10 / var_34_11
					local var_34_14 = var_34_9 / var_34_12
					local var_34_15 = var_34_14 < var_34_13 and var_34_13 or var_34_14

					var_34_5.transform.localScale = Vector3.New(var_34_15, var_34_15, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "L14f" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_16 = 4.00000000298023

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			local var_34_17 = 0.3

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			local var_34_18 = 0

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_19 = 2

			if var_34_18 <= arg_31_1.time_ and arg_31_1.time_ < var_34_18 + var_34_19 then
				local var_34_20 = (arg_31_1.time_ - var_34_18) / var_34_19
				local var_34_21 = Color.New(0, 0, 0)

				var_34_21.a = Mathf.Lerp(0, 1, var_34_20)
				arg_31_1.mask_.color = var_34_21
			end

			if arg_31_1.time_ >= var_34_18 + var_34_19 and arg_31_1.time_ < var_34_18 + var_34_19 + arg_34_0 then
				local var_34_22 = Color.New(0, 0, 0)

				var_34_22.a = 1
				arg_31_1.mask_.color = var_34_22
			end

			local var_34_23 = 2

			if var_34_23 < arg_31_1.time_ and arg_31_1.time_ <= var_34_23 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_24 = 2

			if var_34_23 <= arg_31_1.time_ and arg_31_1.time_ < var_34_23 + var_34_24 then
				local var_34_25 = (arg_31_1.time_ - var_34_23) / var_34_24
				local var_34_26 = Color.New(0, 0, 0)

				var_34_26.a = Mathf.Lerp(1, 0, var_34_25)
				arg_31_1.mask_.color = var_34_26
			end

			if arg_31_1.time_ >= var_34_23 + var_34_24 and arg_31_1.time_ < var_34_23 + var_34_24 + arg_34_0 then
				local var_34_27 = Color.New(0, 0, 0)
				local var_34_28 = 0

				arg_31_1.mask_.enabled = false
				var_34_27.a = var_34_28
				arg_31_1.mask_.color = var_34_27
			end

			local var_34_29 = "1284ui_story"

			if arg_31_1.actors_[var_34_29] == nil then
				local var_34_30 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_34_30) then
					local var_34_31 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_31_1.stage_.transform)

					var_34_31.name = var_34_29
					var_34_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_31_1.actors_[var_34_29] = var_34_31

					local var_34_32 = var_34_31:GetComponentInChildren(typeof(CharacterEffect))

					var_34_32.enabled = true

					local var_34_33 = GameObjectTools.GetOrAddComponent(var_34_31, typeof(DynamicBoneHelper))

					if var_34_33 then
						var_34_33:EnableDynamicBone(false)
					end

					arg_31_1:ShowWeapon(var_34_32.transform, false)

					arg_31_1.var_[var_34_29 .. "Animator"] = var_34_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_31_1.var_[var_34_29 .. "Animator"].applyRootMotion = true
					arg_31_1.var_[var_34_29 .. "LipSync"] = var_34_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_34_34 = arg_31_1.actors_["1284ui_story"].transform
			local var_34_35 = 3.8

			if var_34_35 < arg_31_1.time_ and arg_31_1.time_ <= var_34_35 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = var_34_34.localPosition

				local var_34_36 = "1284ui_story"

				arg_31_1:ShowWeapon(arg_31_1.var_[var_34_36 .. "Animator"].transform, false)
			end

			local var_34_37 = 0.001

			if var_34_35 <= arg_31_1.time_ and arg_31_1.time_ < var_34_35 + var_34_37 then
				local var_34_38 = (arg_31_1.time_ - var_34_35) / var_34_37
				local var_34_39 = Vector3.New(-0.7, -0.985, -6.22)

				var_34_34.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, var_34_39, var_34_38)

				local var_34_40 = manager.ui.mainCamera.transform.position - var_34_34.position

				var_34_34.forward = Vector3.New(var_34_40.x, var_34_40.y, var_34_40.z)

				local var_34_41 = var_34_34.localEulerAngles

				var_34_41.z = 0
				var_34_41.x = 0
				var_34_34.localEulerAngles = var_34_41
			end

			if arg_31_1.time_ >= var_34_35 + var_34_37 and arg_31_1.time_ < var_34_35 + var_34_37 + arg_34_0 then
				var_34_34.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_34_42 = manager.ui.mainCamera.transform.position - var_34_34.position

				var_34_34.forward = Vector3.New(var_34_42.x, var_34_42.y, var_34_42.z)

				local var_34_43 = var_34_34.localEulerAngles

				var_34_43.z = 0
				var_34_43.x = 0
				var_34_34.localEulerAngles = var_34_43
			end

			local var_34_44 = arg_31_1.actors_["1284ui_story"]
			local var_34_45 = 3.8

			if var_34_45 < arg_31_1.time_ and arg_31_1.time_ <= var_34_45 + arg_34_0 and not isNil(var_34_44) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_46 = 0.200000002980232

			if var_34_45 <= arg_31_1.time_ and arg_31_1.time_ < var_34_45 + var_34_46 and not isNil(var_34_44) then
				local var_34_47 = (arg_31_1.time_ - var_34_45) / var_34_46

				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_44) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_45 + var_34_46 and arg_31_1.time_ < var_34_45 + var_34_46 + arg_34_0 and not isNil(var_34_44) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_34_48 = 3.8

			if var_34_48 < arg_31_1.time_ and arg_31_1.time_ <= var_34_48 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_34_49 = 3.8

			if var_34_49 < arg_31_1.time_ and arg_31_1.time_ <= var_34_49 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_34_50 = 0.166666666666667
			local var_34_51 = 1

			if var_34_50 < arg_31_1.time_ and arg_31_1.time_ <= var_34_50 + arg_34_0 then
				local var_34_52 = "stop"
				local var_34_53 = "effect"

				arg_31_1:AudioAction(var_34_52, var_34_53, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_34_54 = 1.53333333333333
			local var_34_55 = 1

			if var_34_54 < arg_31_1.time_ and arg_31_1.time_ <= var_34_54 + arg_34_0 then
				local var_34_56 = "play"
				local var_34_57 = "effect"

				arg_31_1:AudioAction(var_34_56, var_34_57, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_34_58 = manager.ui.mainCamera.transform
			local var_34_59 = 2

			if var_34_59 < arg_31_1.time_ and arg_31_1.time_ <= var_34_59 + arg_34_0 then
				local var_34_60 = arg_31_1.var_.effect1001

				if var_34_60 then
					Object.Destroy(var_34_60)

					arg_31_1.var_.effect1001 = nil
				end
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_61 = 4
			local var_34_62 = 0.45

			if var_34_61 < arg_31_1.time_ and arg_31_1.time_ <= var_34_61 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_63 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_63:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_64 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_65 = arg_31_1:GetWordFromCfg(322131007)
				local var_34_66 = arg_31_1:FormatText(var_34_65.content)

				arg_31_1.text_.text = var_34_66

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_67 = 18
				local var_34_68 = utf8.len(var_34_66)
				local var_34_69 = var_34_67 <= 0 and var_34_62 or var_34_62 * (var_34_68 / var_34_67)

				if var_34_69 > 0 and var_34_62 < var_34_69 then
					arg_31_1.talkMaxDuration = var_34_69
					var_34_61 = var_34_61 + 0.3

					if var_34_69 + var_34_61 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_69 + var_34_61
					end
				end

				arg_31_1.text_.text = var_34_66
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131007", "story_v_out_322131.awb") ~= 0 then
					local var_34_70 = manager.audio:GetVoiceLength("story_v_out_322131", "322131007", "story_v_out_322131.awb") / 1000

					if var_34_70 + var_34_61 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_70 + var_34_61
					end

					if var_34_65.prefab_name ~= "" and arg_31_1.actors_[var_34_65.prefab_name] ~= nil then
						local var_34_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_65.prefab_name].transform, "story_v_out_322131", "322131007", "story_v_out_322131.awb")

						arg_31_1:RecordAudio("322131007", var_34_71)
						arg_31_1:RecordAudio("322131007", var_34_71)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322131", "322131007", "story_v_out_322131.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322131", "322131007", "story_v_out_322131.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_72 = var_34_61 + 0.3
			local var_34_73 = math.max(var_34_62, arg_31_1.talkMaxDuration)

			if var_34_72 <= arg_31_1.time_ and arg_31_1.time_ < var_34_72 + var_34_73 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_72) / var_34_73

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_72 + var_34_73 and arg_31_1.time_ < var_34_72 + var_34_73 + arg_34_0 then
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
			local var_40_0 = "1043ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["1043ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos1043ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(0.81, -1.01, -5.73)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1043ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["1043ui_story"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect1043ui_story == nil then
				arg_37_1.var_.characterEffect1043ui_story = var_40_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_16 = 0.200000002980232

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.characterEffect1043ui_story and not isNil(var_40_14) then
					arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect1043ui_story then
				arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_40_18 = arg_37_1.actors_["1284ui_story"]
			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 and not isNil(var_40_18) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = var_40_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_20 = 0.200000002980232

			if var_40_19 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_20 and not isNil(var_40_18) then
				local var_40_21 = (arg_37_1.time_ - var_40_19) / var_40_20

				if arg_37_1.var_.characterEffect1284ui_story and not isNil(var_40_18) then
					local var_40_22 = Mathf.Lerp(0, 0.5, var_40_21)

					arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1284ui_story.fillRatio = var_40_22
				end
			end

			if arg_37_1.time_ >= var_40_19 + var_40_20 and arg_37_1.time_ < var_40_19 + var_40_20 + arg_40_0 and not isNil(var_40_18) and arg_37_1.var_.characterEffect1284ui_story then
				local var_40_23 = 0.5

				arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1284ui_story.fillRatio = var_40_23
			end

			local var_40_24 = 0

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_40_25 = 0

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_26 = arg_37_1.actors_["1043ui_story"]
			local var_40_27 = 0

			if var_40_27 < arg_37_1.time_ and arg_37_1.time_ <= var_40_27 + arg_40_0 then
				if arg_37_1.var_.characterEffect1043ui_story == nil then
					arg_37_1.var_.characterEffect1043ui_story = var_40_26:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_40_28 = arg_37_1.var_.characterEffect1043ui_story

				var_40_28.imageEffect:turnOff()

				var_40_28.interferenceEffect.enabled = true
				var_40_28.interferenceEffect.noise = 0
				var_40_28.interferenceEffect.simTimeScale = 1
				var_40_28.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_40_29 = arg_37_1.actors_["1043ui_story"]
			local var_40_30 = 0
			local var_40_31 = 3.5

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				if arg_37_1.var_.characterEffect1043ui_story == nil then
					arg_37_1.var_.characterEffect1043ui_story = var_40_29:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_37_1.var_.characterEffect1043ui_story.imageEffect:turnOn(false)
			end

			local var_40_32 = 0
			local var_40_33 = 0.475

			if var_40_32 < arg_37_1.time_ and arg_37_1.time_ <= var_40_32 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_34 = arg_37_1:FormatText(StoryNameCfg[1156].name)

				arg_37_1.leftNameTxt_.text = var_40_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_35 = arg_37_1:GetWordFromCfg(322131008)
				local var_40_36 = arg_37_1:FormatText(var_40_35.content)

				arg_37_1.text_.text = var_40_36

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_37 = 19
				local var_40_38 = utf8.len(var_40_36)
				local var_40_39 = var_40_37 <= 0 and var_40_33 or var_40_33 * (var_40_38 / var_40_37)

				if var_40_39 > 0 and var_40_33 < var_40_39 then
					arg_37_1.talkMaxDuration = var_40_39

					if var_40_39 + var_40_32 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_39 + var_40_32
					end
				end

				arg_37_1.text_.text = var_40_36
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131008", "story_v_out_322131.awb") ~= 0 then
					local var_40_40 = manager.audio:GetVoiceLength("story_v_out_322131", "322131008", "story_v_out_322131.awb") / 1000

					if var_40_40 + var_40_32 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_40 + var_40_32
					end

					if var_40_35.prefab_name ~= "" and arg_37_1.actors_[var_40_35.prefab_name] ~= nil then
						local var_40_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_35.prefab_name].transform, "story_v_out_322131", "322131008", "story_v_out_322131.awb")

						arg_37_1:RecordAudio("322131008", var_40_41)
						arg_37_1:RecordAudio("322131008", var_40_41)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322131", "322131008", "story_v_out_322131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322131", "322131008", "story_v_out_322131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_42 = math.max(var_40_33, arg_37_1.talkMaxDuration)

			if var_40_32 <= arg_37_1.time_ and arg_37_1.time_ < var_40_32 + var_40_42 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_32) / var_40_42

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_32 + var_40_42 and arg_37_1.time_ < var_40_32 + var_40_42 + arg_40_0 then
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
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_2 = arg_41_1.actors_["1043ui_story"]
			local var_44_3 = 0

			if var_44_3 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				if arg_41_1.var_.characterEffect1043ui_story == nil then
					arg_41_1.var_.characterEffect1043ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_44_4 = arg_41_1.var_.characterEffect1043ui_story

				var_44_4.imageEffect:turnOff()

				var_44_4.interferenceEffect.enabled = true
				var_44_4.interferenceEffect.noise = 0
				var_44_4.interferenceEffect.simTimeScale = 1
				var_44_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_44_5 = arg_41_1.actors_["1043ui_story"]
			local var_44_6 = 0
			local var_44_7 = 3.5

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				if arg_41_1.var_.characterEffect1043ui_story == nil then
					arg_41_1.var_.characterEffect1043ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_41_1.var_.characterEffect1043ui_story.imageEffect:turnOn(false)
			end

			local var_44_8 = 0
			local var_44_9 = 0.675

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[1156].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_11 = arg_41_1:GetWordFromCfg(322131009)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 27
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131009", "story_v_out_322131.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_322131", "322131009", "story_v_out_322131.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_322131", "322131009", "story_v_out_322131.awb")

						arg_41_1:RecordAudio("322131009", var_44_17)
						arg_41_1:RecordAudio("322131009", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322131", "322131009", "story_v_out_322131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322131", "322131009", "story_v_out_322131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
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
			local var_48_0 = arg_45_1.actors_["1043ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1043ui_story == nil then
				arg_45_1.var_.characterEffect1043ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1043ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1043ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1043ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1043ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.275

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

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

				local var_48_9 = arg_45_1:GetWordFromCfg(322131010)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 11
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
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
			local var_52_0 = arg_49_1.actors_["1043ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1043ui_story == nil then
				arg_49_1.var_.characterEffect1043ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1043ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1043ui_story then
				arg_49_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1043ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				if arg_49_1.var_.characterEffect1043ui_story == nil then
					arg_49_1.var_.characterEffect1043ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_52_6 = arg_49_1.var_.characterEffect1043ui_story

				var_52_6.imageEffect:turnOff()

				var_52_6.interferenceEffect.enabled = true
				var_52_6.interferenceEffect.noise = 0
				var_52_6.interferenceEffect.simTimeScale = 1
				var_52_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_52_7 = arg_49_1.actors_["1043ui_story"]
			local var_52_8 = 0
			local var_52_9 = 3.5

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				if arg_49_1.var_.characterEffect1043ui_story == nil then
					arg_49_1.var_.characterEffect1043ui_story = var_52_7:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_49_1.var_.characterEffect1043ui_story.imageEffect:turnOn(false)
			end

			local var_52_10 = 0
			local var_52_11 = 0.2

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[1156].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(322131011)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 8
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_11 or var_52_11 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_11 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131011", "story_v_out_322131.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_322131", "322131011", "story_v_out_322131.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_322131", "322131011", "story_v_out_322131.awb")

						arg_49_1:RecordAudio("322131011", var_52_19)
						arg_49_1:RecordAudio("322131011", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322131", "322131011", "story_v_out_322131.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322131", "322131011", "story_v_out_322131.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_20 and arg_49_1.time_ < var_52_10 + var_52_20 + arg_52_0 then
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
			local var_56_0 = arg_53_1.actors_["1043ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1043ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1043ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1284ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos1284ui_story = var_56_9.localPosition
			end

			local var_56_11 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11
				local var_56_13 = Vector3.New(0, 100, 0)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1284ui_story, var_56_13, var_56_12)

				local var_56_14 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_14.x, var_56_14.y, var_56_14.z)

				local var_56_15 = var_56_9.localEulerAngles

				var_56_15.z = 0
				var_56_15.x = 0
				var_56_9.localEulerAngles = var_56_15
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(0, 100, 0)

				local var_56_16 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_16.x, var_56_16.y, var_56_16.z)

				local var_56_17 = var_56_9.localEulerAngles

				var_56_17.z = 0
				var_56_17.x = 0
				var_56_9.localEulerAngles = var_56_17
			end

			local var_56_18 = arg_53_1.actors_["1043ui_story"]
			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				if arg_53_1.var_.characterEffect1043ui_story == nil then
					arg_53_1.var_.characterEffect1043ui_story = var_56_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_56_20 = arg_53_1.var_.characterEffect1043ui_story

				var_56_20.imageEffect:turnOff()

				var_56_20.interferenceEffect.enabled = false
				var_56_20.interferenceEffect.noise = 0
				var_56_20.interferenceEffect.simTimeScale = 1
				var_56_20.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_56_21 = arg_53_1.actors_["1043ui_story"]
			local var_56_22 = 0
			local var_56_23 = 0.0166666666666667

			if var_56_22 < arg_53_1.time_ and arg_53_1.time_ <= var_56_22 + arg_56_0 then
				if arg_53_1.var_.characterEffect1043ui_story == nil then
					arg_53_1.var_.characterEffect1043ui_story = var_56_21:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_53_1.var_.characterEffect1043ui_story.imageEffect:turnOff()
			end

			local var_56_24 = 0
			local var_56_25 = 1.45

			if var_56_24 < arg_53_1.time_ and arg_53_1.time_ <= var_56_24 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(322131012)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 58
				local var_56_29 = utf8.len(var_56_27)
				local var_56_30 = var_56_28 <= 0 and var_56_25 or var_56_25 * (var_56_29 / var_56_28)

				if var_56_30 > 0 and var_56_25 < var_56_30 then
					arg_53_1.talkMaxDuration = var_56_30

					if var_56_30 + var_56_24 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_24
					end
				end

				arg_53_1.text_.text = var_56_27
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_31 = math.max(var_56_25, arg_53_1.talkMaxDuration)

			if var_56_24 <= arg_53_1.time_ and arg_53_1.time_ < var_56_24 + var_56_31 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_24) / var_56_31

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_24 + var_56_31 and arg_53_1.time_ < var_56_24 + var_56_31 + arg_56_0 then
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
			local var_60_0 = 0
			local var_60_1 = 0.175

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

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

				local var_60_3 = arg_57_1:GetWordFromCfg(322131013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 7
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
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
			local var_64_0 = 2

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				local var_64_1 = manager.ui.mainCamera.transform.localPosition
				local var_64_2 = Vector3.New(0, 0, 10) + Vector3.New(var_64_1.x, var_64_1.y, 0)
				local var_64_3 = arg_61_1.bgs_.MS2203

				var_64_3.transform.localPosition = var_64_2
				var_64_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_4 = var_64_3:GetComponent("SpriteRenderer")

				if var_64_4 and var_64_4.sprite then
					local var_64_5 = (var_64_3.transform.localPosition - var_64_1).z
					local var_64_6 = manager.ui.mainCameraCom_
					local var_64_7 = 2 * var_64_5 * Mathf.Tan(var_64_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_64_8 = var_64_7 * var_64_6.aspect
					local var_64_9 = var_64_4.sprite.bounds.size.x
					local var_64_10 = var_64_4.sprite.bounds.size.y
					local var_64_11 = var_64_8 / var_64_9
					local var_64_12 = var_64_7 / var_64_10
					local var_64_13 = var_64_12 < var_64_11 and var_64_11 or var_64_12

					var_64_3.transform.localScale = Vector3.New(var_64_13, var_64_13, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "MS2203" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_14 = 3.999999999999

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_15 = 0.3

			if arg_61_1.time_ >= var_64_14 + var_64_15 and arg_61_1.time_ < var_64_14 + var_64_15 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_17 = 2

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Color.New(0, 0, 0)

				var_64_19.a = Mathf.Lerp(0, 1, var_64_18)
				arg_61_1.mask_.color = var_64_19
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				local var_64_20 = Color.New(0, 0, 0)

				var_64_20.a = 1
				arg_61_1.mask_.color = var_64_20
			end

			local var_64_21 = 2

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_22 = 2

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_22 then
				local var_64_23 = (arg_61_1.time_ - var_64_21) / var_64_22
				local var_64_24 = Color.New(0, 0, 0)

				var_64_24.a = Mathf.Lerp(1, 0, var_64_23)
				arg_61_1.mask_.color = var_64_24
			end

			if arg_61_1.time_ >= var_64_21 + var_64_22 and arg_61_1.time_ < var_64_21 + var_64_22 + arg_64_0 then
				local var_64_25 = Color.New(0, 0, 0)
				local var_64_26 = 0

				arg_61_1.mask_.enabled = false
				var_64_25.a = var_64_26
				arg_61_1.mask_.color = var_64_25
			end

			local var_64_27 = 0.1
			local var_64_28 = 1

			if var_64_27 < arg_61_1.time_ and arg_61_1.time_ <= var_64_27 + arg_64_0 then
				local var_64_29 = "stop"
				local var_64_30 = "effect"

				arg_61_1:AudioAction(var_64_29, var_64_30, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_64_31 = 1.6
			local var_64_32 = 1

			if var_64_31 < arg_61_1.time_ and arg_61_1.time_ <= var_64_31 + arg_64_0 then
				local var_64_33 = "play"
				local var_64_34 = "effect"

				arg_61_1:AudioAction(var_64_33, var_64_34, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_64_35 = arg_61_1.bgs_.MS2203.transform
			local var_64_36 = 2

			if var_64_36 < arg_61_1.time_ and arg_61_1.time_ <= var_64_36 + arg_64_0 then
				arg_61_1.var_.moveOldPosMS2203 = var_64_35.localPosition
			end

			local var_64_37 = 0.001

			if var_64_36 <= arg_61_1.time_ and arg_61_1.time_ < var_64_36 + var_64_37 then
				local var_64_38 = (arg_61_1.time_ - var_64_36) / var_64_37
				local var_64_39 = Vector3.New(-0.3, 0.9, 6)

				var_64_35.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosMS2203, var_64_39, var_64_38)
			end

			if arg_61_1.time_ >= var_64_36 + var_64_37 and arg_61_1.time_ < var_64_36 + var_64_37 + arg_64_0 then
				var_64_35.localPosition = Vector3.New(-0.3, 0.9, 6)
			end

			local var_64_40 = arg_61_1.bgs_.MS2203.transform
			local var_64_41 = 2.01666666666667

			if var_64_41 < arg_61_1.time_ and arg_61_1.time_ <= var_64_41 + arg_64_0 then
				arg_61_1.var_.moveOldPosMS2203 = var_64_40.localPosition
			end

			local var_64_42 = 1.98333333333233

			if var_64_41 <= arg_61_1.time_ and arg_61_1.time_ < var_64_41 + var_64_42 then
				local var_64_43 = (arg_61_1.time_ - var_64_41) / var_64_42
				local var_64_44 = Vector3.New(0, 1, 9)

				var_64_40.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosMS2203, var_64_44, var_64_43)
			end

			if arg_61_1.time_ >= var_64_41 + var_64_42 and arg_61_1.time_ < var_64_41 + var_64_42 + arg_64_0 then
				var_64_40.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_45 = 4
			local var_64_46 = 0.5

			if var_64_45 < arg_61_1.time_ and arg_61_1.time_ <= var_64_45 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_47 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_47:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_48 = arg_61_1:FormatText(StoryNameCfg[67].name)

				arg_61_1.leftNameTxt_.text = var_64_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_49 = arg_61_1:GetWordFromCfg(322131014)
				local var_64_50 = arg_61_1:FormatText(var_64_49.content)

				arg_61_1.text_.text = var_64_50

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_51 = 20
				local var_64_52 = utf8.len(var_64_50)
				local var_64_53 = var_64_51 <= 0 and var_64_46 or var_64_46 * (var_64_52 / var_64_51)

				if var_64_53 > 0 and var_64_46 < var_64_53 then
					arg_61_1.talkMaxDuration = var_64_53
					var_64_45 = var_64_45 + 0.3

					if var_64_53 + var_64_45 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_53 + var_64_45
					end
				end

				arg_61_1.text_.text = var_64_50
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131014", "story_v_out_322131.awb") ~= 0 then
					local var_64_54 = manager.audio:GetVoiceLength("story_v_out_322131", "322131014", "story_v_out_322131.awb") / 1000

					if var_64_54 + var_64_45 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_54 + var_64_45
					end

					if var_64_49.prefab_name ~= "" and arg_61_1.actors_[var_64_49.prefab_name] ~= nil then
						local var_64_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_49.prefab_name].transform, "story_v_out_322131", "322131014", "story_v_out_322131.awb")

						arg_61_1:RecordAudio("322131014", var_64_55)
						arg_61_1:RecordAudio("322131014", var_64_55)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322131", "322131014", "story_v_out_322131.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322131", "322131014", "story_v_out_322131.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_56 = var_64_45 + 0.3
			local var_64_57 = math.max(var_64_46, arg_61_1.talkMaxDuration)

			if var_64_56 <= arg_61_1.time_ and arg_61_1.time_ < var_64_56 + var_64_57 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_56) / var_64_57

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_56 + var_64_57 and arg_61_1.time_ < var_64_56 + var_64_57 + arg_64_0 then
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
			local var_70_0 = 0
			local var_70_1 = 0.125

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[1049].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(322131015)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 5
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131015", "story_v_out_322131.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131015", "story_v_out_322131.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_322131", "322131015", "story_v_out_322131.awb")

						arg_67_1:RecordAudio("322131015", var_70_9)
						arg_67_1:RecordAudio("322131015", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322131", "322131015", "story_v_out_322131.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322131", "322131015", "story_v_out_322131.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
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
			local var_74_0 = 0
			local var_74_1 = 0.525

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[67].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(322131016)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 21
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131016", "story_v_out_322131.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131016", "story_v_out_322131.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_322131", "322131016", "story_v_out_322131.awb")

						arg_71_1:RecordAudio("322131016", var_74_9)
						arg_71_1:RecordAudio("322131016", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322131", "322131016", "story_v_out_322131.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322131", "322131016", "story_v_out_322131.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
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
			local var_78_0 = 0
			local var_78_1 = 0.675

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[1049].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(322131017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 27
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131017", "story_v_out_322131.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131017", "story_v_out_322131.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_322131", "322131017", "story_v_out_322131.awb")

						arg_75_1:RecordAudio("322131017", var_78_9)
						arg_75_1:RecordAudio("322131017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322131", "322131017", "story_v_out_322131.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322131", "322131017", "story_v_out_322131.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
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
			local var_82_0 = 0
			local var_82_1 = 0.35

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[1049].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(322131018)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 14
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131018", "story_v_out_322131.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131018", "story_v_out_322131.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_322131", "322131018", "story_v_out_322131.awb")

						arg_79_1:RecordAudio("322131018", var_82_9)
						arg_79_1:RecordAudio("322131018", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322131", "322131018", "story_v_out_322131.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322131", "322131018", "story_v_out_322131.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
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
			local var_86_0 = 0
			local var_86_1 = 0.2

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[67].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(322131019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 8
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131019", "story_v_out_322131.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131019", "story_v_out_322131.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_322131", "322131019", "story_v_out_322131.awb")

						arg_83_1:RecordAudio("322131019", var_86_9)
						arg_83_1:RecordAudio("322131019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322131", "322131019", "story_v_out_322131.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322131", "322131019", "story_v_out_322131.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
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
			local var_90_0 = 0
			local var_90_1 = 0.95

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[1049].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(322131020)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 38
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131020", "story_v_out_322131.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131020", "story_v_out_322131.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_322131", "322131020", "story_v_out_322131.awb")

						arg_87_1:RecordAudio("322131020", var_90_9)
						arg_87_1:RecordAudio("322131020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322131", "322131020", "story_v_out_322131.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322131", "322131020", "story_v_out_322131.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
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
			local var_94_0 = 0
			local var_94_1 = 0.325

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[1049].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(322131021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 13
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131021", "story_v_out_322131.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131021", "story_v_out_322131.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_322131", "322131021", "story_v_out_322131.awb")

						arg_91_1:RecordAudio("322131021", var_94_9)
						arg_91_1:RecordAudio("322131021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322131", "322131021", "story_v_out_322131.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322131", "322131021", "story_v_out_322131.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
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
			local var_98_0 = 0
			local var_98_1 = 0.5

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[67].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(322131022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 20
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131022", "story_v_out_322131.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131022", "story_v_out_322131.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_322131", "322131022", "story_v_out_322131.awb")

						arg_95_1:RecordAudio("322131022", var_98_9)
						arg_95_1:RecordAudio("322131022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322131", "322131022", "story_v_out_322131.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322131", "322131022", "story_v_out_322131.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
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
			local var_102_0 = "L10j"

			if arg_99_1.bgs_[var_102_0] == nil then
				local var_102_1 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_0)
				var_102_1.name = var_102_0
				var_102_1.transform.parent = arg_99_1.stage_.transform
				var_102_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_0] = var_102_1
			end

			local var_102_2 = 2

			if var_102_2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				local var_102_3 = manager.ui.mainCamera.transform.localPosition
				local var_102_4 = Vector3.New(0, 0, 10) + Vector3.New(var_102_3.x, var_102_3.y, 0)
				local var_102_5 = arg_99_1.bgs_.L10j

				var_102_5.transform.localPosition = var_102_4
				var_102_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_6 = var_102_5:GetComponent("SpriteRenderer")

				if var_102_6 and var_102_6.sprite then
					local var_102_7 = (var_102_5.transform.localPosition - var_102_3).z
					local var_102_8 = manager.ui.mainCameraCom_
					local var_102_9 = 2 * var_102_7 * Mathf.Tan(var_102_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_10 = var_102_9 * var_102_8.aspect
					local var_102_11 = var_102_6.sprite.bounds.size.x
					local var_102_12 = var_102_6.sprite.bounds.size.y
					local var_102_13 = var_102_10 / var_102_11
					local var_102_14 = var_102_9 / var_102_12
					local var_102_15 = var_102_14 < var_102_13 and var_102_13 or var_102_14

					var_102_5.transform.localScale = Vector3.New(var_102_15, var_102_15, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "L10j" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_16 = 4

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			local var_102_17 = 0.3

			if arg_99_1.time_ >= var_102_16 + var_102_17 and arg_99_1.time_ < var_102_16 + var_102_17 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_18 = 0

			if var_102_18 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_19 = 2

			if var_102_18 <= arg_99_1.time_ and arg_99_1.time_ < var_102_18 + var_102_19 then
				local var_102_20 = (arg_99_1.time_ - var_102_18) / var_102_19
				local var_102_21 = Color.New(0, 0, 0)

				var_102_21.a = Mathf.Lerp(0, 1, var_102_20)
				arg_99_1.mask_.color = var_102_21
			end

			if arg_99_1.time_ >= var_102_18 + var_102_19 and arg_99_1.time_ < var_102_18 + var_102_19 + arg_102_0 then
				local var_102_22 = Color.New(0, 0, 0)

				var_102_22.a = 1
				arg_99_1.mask_.color = var_102_22
			end

			local var_102_23 = 2

			if var_102_23 < arg_99_1.time_ and arg_99_1.time_ <= var_102_23 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_24 = 2

			if var_102_23 <= arg_99_1.time_ and arg_99_1.time_ < var_102_23 + var_102_24 then
				local var_102_25 = (arg_99_1.time_ - var_102_23) / var_102_24
				local var_102_26 = Color.New(0, 0, 0)

				var_102_26.a = Mathf.Lerp(1, 0, var_102_25)
				arg_99_1.mask_.color = var_102_26
			end

			if arg_99_1.time_ >= var_102_23 + var_102_24 and arg_99_1.time_ < var_102_23 + var_102_24 + arg_102_0 then
				local var_102_27 = Color.New(0, 0, 0)
				local var_102_28 = 0

				arg_99_1.mask_.enabled = false
				var_102_27.a = var_102_28
				arg_99_1.mask_.color = var_102_27
			end

			local var_102_29 = "1211ui_story"

			if arg_99_1.actors_[var_102_29] == nil then
				local var_102_30 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_102_30) then
					local var_102_31 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_99_1.stage_.transform)

					var_102_31.name = var_102_29
					var_102_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_99_1.actors_[var_102_29] = var_102_31

					local var_102_32 = var_102_31:GetComponentInChildren(typeof(CharacterEffect))

					var_102_32.enabled = true

					local var_102_33 = GameObjectTools.GetOrAddComponent(var_102_31, typeof(DynamicBoneHelper))

					if var_102_33 then
						var_102_33:EnableDynamicBone(false)
					end

					arg_99_1:ShowWeapon(var_102_32.transform, false)

					arg_99_1.var_[var_102_29 .. "Animator"] = var_102_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_99_1.var_[var_102_29 .. "Animator"].applyRootMotion = true
					arg_99_1.var_[var_102_29 .. "LipSync"] = var_102_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_102_34 = arg_99_1.actors_["1211ui_story"].transform
			local var_102_35 = 3.8

			if var_102_35 < arg_99_1.time_ and arg_99_1.time_ <= var_102_35 + arg_102_0 then
				arg_99_1.var_.moveOldPos1211ui_story = var_102_34.localPosition
			end

			local var_102_36 = 0.001

			if var_102_35 <= arg_99_1.time_ and arg_99_1.time_ < var_102_35 + var_102_36 then
				local var_102_37 = (arg_99_1.time_ - var_102_35) / var_102_36
				local var_102_38 = Vector3.New(0, -0.67, -6.07)

				var_102_34.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1211ui_story, var_102_38, var_102_37)

				local var_102_39 = manager.ui.mainCamera.transform.position - var_102_34.position

				var_102_34.forward = Vector3.New(var_102_39.x, var_102_39.y, var_102_39.z)

				local var_102_40 = var_102_34.localEulerAngles

				var_102_40.z = 0
				var_102_40.x = 0
				var_102_34.localEulerAngles = var_102_40
			end

			if arg_99_1.time_ >= var_102_35 + var_102_36 and arg_99_1.time_ < var_102_35 + var_102_36 + arg_102_0 then
				var_102_34.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_102_41 = manager.ui.mainCamera.transform.position - var_102_34.position

				var_102_34.forward = Vector3.New(var_102_41.x, var_102_41.y, var_102_41.z)

				local var_102_42 = var_102_34.localEulerAngles

				var_102_42.z = 0
				var_102_42.x = 0
				var_102_34.localEulerAngles = var_102_42
			end

			local var_102_43 = arg_99_1.actors_["1211ui_story"]
			local var_102_44 = 3.8

			if var_102_44 < arg_99_1.time_ and arg_99_1.time_ <= var_102_44 + arg_102_0 and not isNil(var_102_43) and arg_99_1.var_.characterEffect1211ui_story == nil then
				arg_99_1.var_.characterEffect1211ui_story = var_102_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_45 = 0.200000002980232

			if var_102_44 <= arg_99_1.time_ and arg_99_1.time_ < var_102_44 + var_102_45 and not isNil(var_102_43) then
				local var_102_46 = (arg_99_1.time_ - var_102_44) / var_102_45

				if arg_99_1.var_.characterEffect1211ui_story and not isNil(var_102_43) then
					arg_99_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_44 + var_102_45 and arg_99_1.time_ < var_102_44 + var_102_45 + arg_102_0 and not isNil(var_102_43) and arg_99_1.var_.characterEffect1211ui_story then
				arg_99_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_102_47 = 3.8

			if var_102_47 < arg_99_1.time_ and arg_99_1.time_ <= var_102_47 + arg_102_0 then
				arg_99_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_102_48 = 3.8

			if var_102_48 < arg_99_1.time_ and arg_99_1.time_ <= var_102_48 + arg_102_0 then
				arg_99_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_102_49 = 0.1
			local var_102_50 = 1

			if var_102_49 < arg_99_1.time_ and arg_99_1.time_ <= var_102_49 + arg_102_0 then
				local var_102_51 = "stop"
				local var_102_52 = "effect"

				arg_99_1:AudioAction(var_102_51, var_102_52, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_102_53 = 1.6
			local var_102_54 = 1

			if var_102_53 < arg_99_1.time_ and arg_99_1.time_ <= var_102_53 + arg_102_0 then
				local var_102_55 = "play"
				local var_102_56 = "effect"

				arg_99_1:AudioAction(var_102_55, var_102_56, "se_story_145", "se_story_145_fire", "")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_57 = 4
			local var_102_58 = 0.175

			if var_102_57 < arg_99_1.time_ and arg_99_1.time_ <= var_102_57 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_59 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_59:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_60 = arg_99_1:FormatText(StoryNameCfg[37].name)

				arg_99_1.leftNameTxt_.text = var_102_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_61 = arg_99_1:GetWordFromCfg(322131023)
				local var_102_62 = arg_99_1:FormatText(var_102_61.content)

				arg_99_1.text_.text = var_102_62

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_63 = 7
				local var_102_64 = utf8.len(var_102_62)
				local var_102_65 = var_102_63 <= 0 and var_102_58 or var_102_58 * (var_102_64 / var_102_63)

				if var_102_65 > 0 and var_102_58 < var_102_65 then
					arg_99_1.talkMaxDuration = var_102_65
					var_102_57 = var_102_57 + 0.3

					if var_102_65 + var_102_57 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_65 + var_102_57
					end
				end

				arg_99_1.text_.text = var_102_62
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131023", "story_v_out_322131.awb") ~= 0 then
					local var_102_66 = manager.audio:GetVoiceLength("story_v_out_322131", "322131023", "story_v_out_322131.awb") / 1000

					if var_102_66 + var_102_57 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_66 + var_102_57
					end

					if var_102_61.prefab_name ~= "" and arg_99_1.actors_[var_102_61.prefab_name] ~= nil then
						local var_102_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_61.prefab_name].transform, "story_v_out_322131", "322131023", "story_v_out_322131.awb")

						arg_99_1:RecordAudio("322131023", var_102_67)
						arg_99_1:RecordAudio("322131023", var_102_67)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_322131", "322131023", "story_v_out_322131.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_322131", "322131023", "story_v_out_322131.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_68 = var_102_57 + 0.3
			local var_102_69 = math.max(var_102_58, arg_99_1.talkMaxDuration)

			if var_102_68 <= arg_99_1.time_ and arg_99_1.time_ < var_102_68 + var_102_69 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_68) / var_102_69

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_68 + var_102_69 and arg_99_1.time_ < var_102_68 + var_102_69 + arg_102_0 then
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
			local var_108_0 = "L17f"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 1

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.L17f

				var_108_5.transform.localPosition = var_108_4
				var_108_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_6 = var_108_5:GetComponent("SpriteRenderer")

				if var_108_6 and var_108_6.sprite then
					local var_108_7 = (var_108_5.transform.localPosition - var_108_3).z
					local var_108_8 = manager.ui.mainCameraCom_
					local var_108_9 = 2 * var_108_7 * Mathf.Tan(var_108_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_10 = var_108_9 * var_108_8.aspect
					local var_108_11 = var_108_6.sprite.bounds.size.x
					local var_108_12 = var_108_6.sprite.bounds.size.y
					local var_108_13 = var_108_10 / var_108_11
					local var_108_14 = var_108_9 / var_108_12
					local var_108_15 = var_108_14 < var_108_13 and var_108_13 or var_108_14

					var_108_5.transform.localScale = Vector3.New(var_108_15, var_108_15, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "L17f" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = 2

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_17 = 0.3

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_18 = 0

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_19 = 1

			if var_108_18 <= arg_105_1.time_ and arg_105_1.time_ < var_108_18 + var_108_19 then
				local var_108_20 = (arg_105_1.time_ - var_108_18) / var_108_19
				local var_108_21 = Color.New(0, 0, 0)

				var_108_21.a = Mathf.Lerp(0, 1, var_108_20)
				arg_105_1.mask_.color = var_108_21
			end

			if arg_105_1.time_ >= var_108_18 + var_108_19 and arg_105_1.time_ < var_108_18 + var_108_19 + arg_108_0 then
				local var_108_22 = Color.New(0, 0, 0)

				var_108_22.a = 1
				arg_105_1.mask_.color = var_108_22
			end

			local var_108_23 = 1

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_24 = 1

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_24 then
				local var_108_25 = (arg_105_1.time_ - var_108_23) / var_108_24
				local var_108_26 = Color.New(0, 0, 0)

				var_108_26.a = Mathf.Lerp(1, 0, var_108_25)
				arg_105_1.mask_.color = var_108_26
			end

			if arg_105_1.time_ >= var_108_23 + var_108_24 and arg_105_1.time_ < var_108_23 + var_108_24 + arg_108_0 then
				local var_108_27 = Color.New(0, 0, 0)
				local var_108_28 = 0

				arg_105_1.mask_.enabled = false
				var_108_27.a = var_108_28
				arg_105_1.mask_.color = var_108_27
			end

			local var_108_29 = arg_105_1.actors_["1211ui_story"].transform
			local var_108_30 = 0.95

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1.var_.moveOldPos1211ui_story = var_108_29.localPosition
			end

			local var_108_31 = 0.001

			if var_108_30 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_31 then
				local var_108_32 = (arg_105_1.time_ - var_108_30) / var_108_31
				local var_108_33 = Vector3.New(0, 100, 0)

				var_108_29.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1211ui_story, var_108_33, var_108_32)

				local var_108_34 = manager.ui.mainCamera.transform.position - var_108_29.position

				var_108_29.forward = Vector3.New(var_108_34.x, var_108_34.y, var_108_34.z)

				local var_108_35 = var_108_29.localEulerAngles

				var_108_35.z = 0
				var_108_35.x = 0
				var_108_29.localEulerAngles = var_108_35
			end

			if arg_105_1.time_ >= var_108_30 + var_108_31 and arg_105_1.time_ < var_108_30 + var_108_31 + arg_108_0 then
				var_108_29.localPosition = Vector3.New(0, 100, 0)

				local var_108_36 = manager.ui.mainCamera.transform.position - var_108_29.position

				var_108_29.forward = Vector3.New(var_108_36.x, var_108_36.y, var_108_36.z)

				local var_108_37 = var_108_29.localEulerAngles

				var_108_37.z = 0
				var_108_37.x = 0
				var_108_29.localEulerAngles = var_108_37
			end

			local var_108_38 = arg_105_1.actors_["1043ui_story"].transform
			local var_108_39 = 1.8

			if var_108_39 < arg_105_1.time_ and arg_105_1.time_ <= var_108_39 + arg_108_0 then
				arg_105_1.var_.moveOldPos1043ui_story = var_108_38.localPosition
			end

			local var_108_40 = 0.001

			if var_108_39 <= arg_105_1.time_ and arg_105_1.time_ < var_108_39 + var_108_40 then
				local var_108_41 = (arg_105_1.time_ - var_108_39) / var_108_40
				local var_108_42 = Vector3.New(0.01, -1.01, -5.73)

				var_108_38.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1043ui_story, var_108_42, var_108_41)

				local var_108_43 = manager.ui.mainCamera.transform.position - var_108_38.position

				var_108_38.forward = Vector3.New(var_108_43.x, var_108_43.y, var_108_43.z)

				local var_108_44 = var_108_38.localEulerAngles

				var_108_44.z = 0
				var_108_44.x = 0
				var_108_38.localEulerAngles = var_108_44
			end

			if arg_105_1.time_ >= var_108_39 + var_108_40 and arg_105_1.time_ < var_108_39 + var_108_40 + arg_108_0 then
				var_108_38.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_108_45 = manager.ui.mainCamera.transform.position - var_108_38.position

				var_108_38.forward = Vector3.New(var_108_45.x, var_108_45.y, var_108_45.z)

				local var_108_46 = var_108_38.localEulerAngles

				var_108_46.z = 0
				var_108_46.x = 0
				var_108_38.localEulerAngles = var_108_46
			end

			local var_108_47 = arg_105_1.actors_["1043ui_story"]
			local var_108_48 = 0.95

			if var_108_48 < arg_105_1.time_ and arg_105_1.time_ <= var_108_48 + arg_108_0 and not isNil(var_108_47) and arg_105_1.var_.characterEffect1043ui_story == nil then
				arg_105_1.var_.characterEffect1043ui_story = var_108_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_49 = 0.05

			if var_108_48 <= arg_105_1.time_ and arg_105_1.time_ < var_108_48 + var_108_49 and not isNil(var_108_47) then
				local var_108_50 = (arg_105_1.time_ - var_108_48) / var_108_49

				if arg_105_1.var_.characterEffect1043ui_story and not isNil(var_108_47) then
					arg_105_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_48 + var_108_49 and arg_105_1.time_ < var_108_48 + var_108_49 + arg_108_0 and not isNil(var_108_47) and arg_105_1.var_.characterEffect1043ui_story then
				arg_105_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_108_51 = arg_105_1.actors_["1211ui_story"]
			local var_108_52 = 1.8

			if var_108_52 < arg_105_1.time_ and arg_105_1.time_ <= var_108_52 + arg_108_0 and not isNil(var_108_51) and arg_105_1.var_.characterEffect1211ui_story == nil then
				arg_105_1.var_.characterEffect1211ui_story = var_108_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_53 = 0.200000002980232

			if var_108_52 <= arg_105_1.time_ and arg_105_1.time_ < var_108_52 + var_108_53 and not isNil(var_108_51) then
				local var_108_54 = (arg_105_1.time_ - var_108_52) / var_108_53

				if arg_105_1.var_.characterEffect1211ui_story and not isNil(var_108_51) then
					local var_108_55 = Mathf.Lerp(0, 0.5, var_108_54)

					arg_105_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1211ui_story.fillRatio = var_108_55
				end
			end

			if arg_105_1.time_ >= var_108_52 + var_108_53 and arg_105_1.time_ < var_108_52 + var_108_53 + arg_108_0 and not isNil(var_108_51) and arg_105_1.var_.characterEffect1211ui_story then
				local var_108_56 = 0.5

				arg_105_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1211ui_story.fillRatio = var_108_56
			end

			local var_108_57 = 1.8

			if var_108_57 < arg_105_1.time_ and arg_105_1.time_ <= var_108_57 + arg_108_0 then
				arg_105_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_108_58 = 1.8

			if var_108_58 < arg_105_1.time_ and arg_105_1.time_ <= var_108_58 + arg_108_0 then
				arg_105_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_59 = 0.1
			local var_108_60 = 1

			if var_108_59 < arg_105_1.time_ and arg_105_1.time_ <= var_108_59 + arg_108_0 then
				local var_108_61 = "stop"
				local var_108_62 = "effect"

				arg_105_1:AudioAction(var_108_61, var_108_62, "se_story_145", "se_story_145_fire", "")
			end

			local var_108_63 = 1.1
			local var_108_64 = 1

			if var_108_63 < arg_105_1.time_ and arg_105_1.time_ <= var_108_63 + arg_108_0 then
				local var_108_65 = "play"
				local var_108_66 = "effect"

				arg_105_1:AudioAction(var_108_65, var_108_66, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_67 = 2
			local var_108_68 = 0.05

			if var_108_67 < arg_105_1.time_ and arg_105_1.time_ <= var_108_67 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_69 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_69:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_70 = arg_105_1:FormatText(StoryNameCfg[1156].name)

				arg_105_1.leftNameTxt_.text = var_108_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_71 = arg_105_1:GetWordFromCfg(322131024)
				local var_108_72 = arg_105_1:FormatText(var_108_71.content)

				arg_105_1.text_.text = var_108_72

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_73 = 2
				local var_108_74 = utf8.len(var_108_72)
				local var_108_75 = var_108_73 <= 0 and var_108_68 or var_108_68 * (var_108_74 / var_108_73)

				if var_108_75 > 0 and var_108_68 < var_108_75 then
					arg_105_1.talkMaxDuration = var_108_75
					var_108_67 = var_108_67 + 0.3

					if var_108_75 + var_108_67 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_75 + var_108_67
					end
				end

				arg_105_1.text_.text = var_108_72
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131024", "story_v_out_322131.awb") ~= 0 then
					local var_108_76 = manager.audio:GetVoiceLength("story_v_out_322131", "322131024", "story_v_out_322131.awb") / 1000

					if var_108_76 + var_108_67 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_76 + var_108_67
					end

					if var_108_71.prefab_name ~= "" and arg_105_1.actors_[var_108_71.prefab_name] ~= nil then
						local var_108_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_71.prefab_name].transform, "story_v_out_322131", "322131024", "story_v_out_322131.awb")

						arg_105_1:RecordAudio("322131024", var_108_77)
						arg_105_1:RecordAudio("322131024", var_108_77)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322131", "322131024", "story_v_out_322131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322131", "322131024", "story_v_out_322131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_78 = var_108_67 + 0.3
			local var_108_79 = math.max(var_108_68, arg_105_1.talkMaxDuration)

			if var_108_78 <= arg_105_1.time_ and arg_105_1.time_ < var_108_78 + var_108_79 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_78) / var_108_79

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_78 + var_108_79 and arg_105_1.time_ < var_108_78 + var_108_79 + arg_108_0 then
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
			local var_114_0 = "L10k"

			if arg_111_1.bgs_[var_114_0] == nil then
				local var_114_1 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_114_0)
				var_114_1.name = var_114_0
				var_114_1.transform.parent = arg_111_1.stage_.transform
				var_114_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_[var_114_0] = var_114_1
			end

			local var_114_2 = 1

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				local var_114_3 = manager.ui.mainCamera.transform.localPosition
				local var_114_4 = Vector3.New(0, 0, 10) + Vector3.New(var_114_3.x, var_114_3.y, 0)
				local var_114_5 = arg_111_1.bgs_.L10k

				var_114_5.transform.localPosition = var_114_4
				var_114_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_6 = var_114_5:GetComponent("SpriteRenderer")

				if var_114_6 and var_114_6.sprite then
					local var_114_7 = (var_114_5.transform.localPosition - var_114_3).z
					local var_114_8 = manager.ui.mainCameraCom_
					local var_114_9 = 2 * var_114_7 * Mathf.Tan(var_114_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_114_10 = var_114_9 * var_114_8.aspect
					local var_114_11 = var_114_6.sprite.bounds.size.x
					local var_114_12 = var_114_6.sprite.bounds.size.y
					local var_114_13 = var_114_10 / var_114_11
					local var_114_14 = var_114_9 / var_114_12
					local var_114_15 = var_114_14 < var_114_13 and var_114_13 or var_114_14

					var_114_5.transform.localScale = Vector3.New(var_114_15, var_114_15, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "L10k" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_16 = 3

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_17 = 0.3

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_18 = 0

			if var_114_18 < arg_111_1.time_ and arg_111_1.time_ <= var_114_18 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_19 = 1

			if var_114_18 <= arg_111_1.time_ and arg_111_1.time_ < var_114_18 + var_114_19 then
				local var_114_20 = (arg_111_1.time_ - var_114_18) / var_114_19
				local var_114_21 = Color.New(0, 0, 0)

				var_114_21.a = Mathf.Lerp(0, 1, var_114_20)
				arg_111_1.mask_.color = var_114_21
			end

			if arg_111_1.time_ >= var_114_18 + var_114_19 and arg_111_1.time_ < var_114_18 + var_114_19 + arg_114_0 then
				local var_114_22 = Color.New(0, 0, 0)

				var_114_22.a = 1
				arg_111_1.mask_.color = var_114_22
			end

			local var_114_23 = 1

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_24 = 2

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 then
				local var_114_25 = (arg_111_1.time_ - var_114_23) / var_114_24
				local var_114_26 = Color.New(0, 0, 0)

				var_114_26.a = Mathf.Lerp(1, 0, var_114_25)
				arg_111_1.mask_.color = var_114_26
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 then
				local var_114_27 = Color.New(0, 0, 0)
				local var_114_28 = 0

				arg_111_1.mask_.enabled = false
				var_114_27.a = var_114_28
				arg_111_1.mask_.color = var_114_27
			end

			local var_114_29 = arg_111_1.actors_["1043ui_story"].transform
			local var_114_30 = 0.965999998152256

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.var_.moveOldPos1043ui_story = var_114_29.localPosition
			end

			local var_114_31 = 0.001

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_31 then
				local var_114_32 = (arg_111_1.time_ - var_114_30) / var_114_31
				local var_114_33 = Vector3.New(0, 100, 0)

				var_114_29.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1043ui_story, var_114_33, var_114_32)

				local var_114_34 = manager.ui.mainCamera.transform.position - var_114_29.position

				var_114_29.forward = Vector3.New(var_114_34.x, var_114_34.y, var_114_34.z)

				local var_114_35 = var_114_29.localEulerAngles

				var_114_35.z = 0
				var_114_35.x = 0
				var_114_29.localEulerAngles = var_114_35
			end

			if arg_111_1.time_ >= var_114_30 + var_114_31 and arg_111_1.time_ < var_114_30 + var_114_31 + arg_114_0 then
				var_114_29.localPosition = Vector3.New(0, 100, 0)

				local var_114_36 = manager.ui.mainCamera.transform.position - var_114_29.position

				var_114_29.forward = Vector3.New(var_114_36.x, var_114_36.y, var_114_36.z)

				local var_114_37 = var_114_29.localEulerAngles

				var_114_37.z = 0
				var_114_37.x = 0
				var_114_29.localEulerAngles = var_114_37
			end

			local var_114_38 = arg_111_1.actors_["1043ui_story"]
			local var_114_39 = 0.965999998152256

			if var_114_39 < arg_111_1.time_ and arg_111_1.time_ <= var_114_39 + arg_114_0 and not isNil(var_114_38) and arg_111_1.var_.characterEffect1043ui_story == nil then
				arg_111_1.var_.characterEffect1043ui_story = var_114_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_40 = 0.034000001847744

			if var_114_39 <= arg_111_1.time_ and arg_111_1.time_ < var_114_39 + var_114_40 and not isNil(var_114_38) then
				local var_114_41 = (arg_111_1.time_ - var_114_39) / var_114_40

				if arg_111_1.var_.characterEffect1043ui_story and not isNil(var_114_38) then
					local var_114_42 = Mathf.Lerp(0, 0.5, var_114_41)

					arg_111_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1043ui_story.fillRatio = var_114_42
				end
			end

			if arg_111_1.time_ >= var_114_39 + var_114_40 and arg_111_1.time_ < var_114_39 + var_114_40 + arg_114_0 and not isNil(var_114_38) and arg_111_1.var_.characterEffect1043ui_story then
				local var_114_43 = 0.5

				arg_111_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1043ui_story.fillRatio = var_114_43
			end

			local var_114_44 = "1044ui_story"

			if arg_111_1.actors_[var_114_44] == nil then
				local var_114_45 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_114_45) then
					local var_114_46 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_111_1.stage_.transform)

					var_114_46.name = var_114_44
					var_114_46.transform.localPosition = Vector3.New(0, 100, 0)
					arg_111_1.actors_[var_114_44] = var_114_46

					local var_114_47 = var_114_46:GetComponentInChildren(typeof(CharacterEffect))

					var_114_47.enabled = true

					local var_114_48 = GameObjectTools.GetOrAddComponent(var_114_46, typeof(DynamicBoneHelper))

					if var_114_48 then
						var_114_48:EnableDynamicBone(false)
					end

					arg_111_1:ShowWeapon(var_114_47.transform, false)

					arg_111_1.var_[var_114_44 .. "Animator"] = var_114_47.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_111_1.var_[var_114_44 .. "Animator"].applyRootMotion = true
					arg_111_1.var_[var_114_44 .. "LipSync"] = var_114_47.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_114_49 = arg_111_1.actors_["1044ui_story"].transform
			local var_114_50 = 2.8

			if var_114_50 < arg_111_1.time_ and arg_111_1.time_ <= var_114_50 + arg_114_0 then
				arg_111_1.var_.moveOldPos1044ui_story = var_114_49.localPosition
			end

			local var_114_51 = 0.001

			if var_114_50 <= arg_111_1.time_ and arg_111_1.time_ < var_114_50 + var_114_51 then
				local var_114_52 = (arg_111_1.time_ - var_114_50) / var_114_51
				local var_114_53 = Vector3.New(0, -1, -5.93)

				var_114_49.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1044ui_story, var_114_53, var_114_52)

				local var_114_54 = manager.ui.mainCamera.transform.position - var_114_49.position

				var_114_49.forward = Vector3.New(var_114_54.x, var_114_54.y, var_114_54.z)

				local var_114_55 = var_114_49.localEulerAngles

				var_114_55.z = 0
				var_114_55.x = 0
				var_114_49.localEulerAngles = var_114_55
			end

			if arg_111_1.time_ >= var_114_50 + var_114_51 and arg_111_1.time_ < var_114_50 + var_114_51 + arg_114_0 then
				var_114_49.localPosition = Vector3.New(0, -1, -5.93)

				local var_114_56 = manager.ui.mainCamera.transform.position - var_114_49.position

				var_114_49.forward = Vector3.New(var_114_56.x, var_114_56.y, var_114_56.z)

				local var_114_57 = var_114_49.localEulerAngles

				var_114_57.z = 0
				var_114_57.x = 0
				var_114_49.localEulerAngles = var_114_57
			end

			local var_114_58 = arg_111_1.actors_["1044ui_story"]
			local var_114_59 = 2.79999999701977

			if var_114_59 < arg_111_1.time_ and arg_111_1.time_ <= var_114_59 + arg_114_0 and not isNil(var_114_58) and arg_111_1.var_.characterEffect1044ui_story == nil then
				arg_111_1.var_.characterEffect1044ui_story = var_114_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_60 = 0.200000002980232

			if var_114_59 <= arg_111_1.time_ and arg_111_1.time_ < var_114_59 + var_114_60 and not isNil(var_114_58) then
				local var_114_61 = (arg_111_1.time_ - var_114_59) / var_114_60

				if arg_111_1.var_.characterEffect1044ui_story and not isNil(var_114_58) then
					arg_111_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_59 + var_114_60 and arg_111_1.time_ < var_114_59 + var_114_60 + arg_114_0 and not isNil(var_114_58) and arg_111_1.var_.characterEffect1044ui_story then
				arg_111_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_114_62 = 2.8

			if var_114_62 < arg_111_1.time_ and arg_111_1.time_ <= var_114_62 + arg_114_0 then
				arg_111_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_114_63 = 2.8

			if var_114_63 < arg_111_1.time_ and arg_111_1.time_ <= var_114_63 + arg_114_0 then
				arg_111_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_114_64 = 0.166666666666667
			local var_114_65 = 1

			if var_114_64 < arg_111_1.time_ and arg_111_1.time_ <= var_114_64 + arg_114_0 then
				local var_114_66 = "stop"
				local var_114_67 = "effect"

				arg_111_1:AudioAction(var_114_66, var_114_67, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_114_68 = 1.5
			local var_114_69 = 1

			if var_114_68 < arg_111_1.time_ and arg_111_1.time_ <= var_114_68 + arg_114_0 then
				local var_114_70 = "play"
				local var_114_71 = "effect"

				arg_111_1:AudioAction(var_114_70, var_114_71, "se_story_145", "se_story_145_fire", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_72 = 3
			local var_114_73 = 0.3

			if var_114_72 < arg_111_1.time_ and arg_111_1.time_ <= var_114_72 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_74 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_74:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_75 = arg_111_1:FormatText(StoryNameCfg[67].name)

				arg_111_1.leftNameTxt_.text = var_114_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_76 = arg_111_1:GetWordFromCfg(322131025)
				local var_114_77 = arg_111_1:FormatText(var_114_76.content)

				arg_111_1.text_.text = var_114_77

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_78 = 12
				local var_114_79 = utf8.len(var_114_77)
				local var_114_80 = var_114_78 <= 0 and var_114_73 or var_114_73 * (var_114_79 / var_114_78)

				if var_114_80 > 0 and var_114_73 < var_114_80 then
					arg_111_1.talkMaxDuration = var_114_80
					var_114_72 = var_114_72 + 0.3

					if var_114_80 + var_114_72 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_80 + var_114_72
					end
				end

				arg_111_1.text_.text = var_114_77
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131025", "story_v_out_322131.awb") ~= 0 then
					local var_114_81 = manager.audio:GetVoiceLength("story_v_out_322131", "322131025", "story_v_out_322131.awb") / 1000

					if var_114_81 + var_114_72 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_81 + var_114_72
					end

					if var_114_76.prefab_name ~= "" and arg_111_1.actors_[var_114_76.prefab_name] ~= nil then
						local var_114_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_76.prefab_name].transform, "story_v_out_322131", "322131025", "story_v_out_322131.awb")

						arg_111_1:RecordAudio("322131025", var_114_82)
						arg_111_1:RecordAudio("322131025", var_114_82)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322131", "322131025", "story_v_out_322131.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322131", "322131025", "story_v_out_322131.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_83 = var_114_72 + 0.3
			local var_114_84 = math.max(var_114_73, arg_111_1.talkMaxDuration)

			if var_114_83 <= arg_111_1.time_ and arg_111_1.time_ < var_114_83 + var_114_84 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_83) / var_114_84

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_83 + var_114_84 and arg_111_1.time_ < var_114_83 + var_114_84 + arg_114_0 then
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
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action9_1")
			end

			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_120_2 = 0
			local var_120_3 = 0.375

			if var_120_2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_4 = arg_117_1:FormatText(StoryNameCfg[67].name)

				arg_117_1.leftNameTxt_.text = var_120_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:GetWordFromCfg(322131026)
				local var_120_6 = arg_117_1:FormatText(var_120_5.content)

				arg_117_1.text_.text = var_120_6

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 15
				local var_120_8 = utf8.len(var_120_6)
				local var_120_9 = var_120_7 <= 0 and var_120_3 or var_120_3 * (var_120_8 / var_120_7)

				if var_120_9 > 0 and var_120_3 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_6
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131026", "story_v_out_322131.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131026", "story_v_out_322131.awb") / 1000

					if var_120_10 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_2
					end

					if var_120_5.prefab_name ~= "" and arg_117_1.actors_[var_120_5.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_5.prefab_name].transform, "story_v_out_322131", "322131026", "story_v_out_322131.awb")

						arg_117_1:RecordAudio("322131026", var_120_11)
						arg_117_1:RecordAudio("322131026", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322131", "322131026", "story_v_out_322131.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322131", "322131026", "story_v_out_322131.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_12 and arg_117_1.time_ < var_120_2 + var_120_12 + arg_120_0 then
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
			local var_124_0 = arg_121_1.actors_["1044ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1044ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1044ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1044ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1044ui_story == nil then
				arg_121_1.var_.characterEffect1044ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1044ui_story and not isNil(var_124_9) then
					local var_124_13 = Mathf.Lerp(0, 0.5, var_124_12)

					arg_121_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1044ui_story.fillRatio = var_124_13
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1044ui_story then
				local var_124_14 = 0.5

				arg_121_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1044ui_story.fillRatio = var_124_14
			end

			local var_124_15 = 0.200000002980232
			local var_124_16 = 1

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				local var_124_17 = "play"
				local var_124_18 = "effect"

				arg_121_1:AudioAction(var_124_17, var_124_18, "se_story_142", "se_story_142_monster02", "")
			end

			local var_124_19 = manager.ui.mainCamera.transform
			local var_124_20 = 0.3

			if var_124_20 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				local var_124_21 = arg_121_1.var_.effect1027
				local var_124_22
				local var_124_23 = var_124_19

				if not var_124_21 then
					var_124_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_greentwister_out"), var_124_23)
					var_124_21.name = "1027"
					arg_121_1.var_.effect1027 = var_124_21
				else
					var_124_21.transform:SetParent(var_124_23)
				end

				var_124_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_124_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_124_24 = manager.ui.mainCamera.transform
			local var_124_25 = 2.06666666666667

			if var_124_25 < arg_121_1.time_ and arg_121_1.time_ <= var_124_25 + arg_124_0 then
				local var_124_26 = arg_121_1.var_.effect1027

				if var_124_26 then
					Object.Destroy(var_124_26)

					arg_121_1.var_.effect1027 = nil
				end
			end

			local var_124_27 = manager.ui.mainCamera.transform
			local var_124_28 = 0.3

			if var_124_28 < arg_121_1.time_ and arg_121_1.time_ <= var_124_28 + arg_124_0 then
				arg_121_1.var_.shakeOldPos = var_124_27.localPosition
			end

			local var_124_29 = 0.566666666666667

			if var_124_28 <= arg_121_1.time_ and arg_121_1.time_ < var_124_28 + var_124_29 then
				local var_124_30 = (arg_121_1.time_ - var_124_28) / 0.066
				local var_124_31, var_124_32 = math.modf(var_124_30)

				var_124_27.localPosition = Vector3.New(var_124_32 * 0.15, var_124_32 * 0.15, var_124_32 * 0.15) + arg_121_1.var_.shakeOldPos
			end

			if arg_121_1.time_ >= var_124_28 + var_124_29 and arg_121_1.time_ < var_124_28 + var_124_29 + arg_124_0 then
				var_124_27.localPosition = arg_121_1.var_.shakeOldPos
			end

			local var_124_33 = 0
			local var_124_34 = 1.15

			if var_124_33 < arg_121_1.time_ and arg_121_1.time_ <= var_124_33 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_35 = arg_121_1:GetWordFromCfg(322131027)
				local var_124_36 = arg_121_1:FormatText(var_124_35.content)

				arg_121_1.text_.text = var_124_36

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_37 = 46
				local var_124_38 = utf8.len(var_124_36)
				local var_124_39 = var_124_37 <= 0 and var_124_34 or var_124_34 * (var_124_38 / var_124_37)

				if var_124_39 > 0 and var_124_34 < var_124_39 then
					arg_121_1.talkMaxDuration = var_124_39

					if var_124_39 + var_124_33 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_39 + var_124_33
					end
				end

				arg_121_1.text_.text = var_124_36
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_34, arg_121_1.talkMaxDuration)

			if var_124_33 <= arg_121_1.time_ and arg_121_1.time_ < var_124_33 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_33) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_33 + var_124_40 and arg_121_1.time_ < var_124_33 + var_124_40 + arg_124_0 then
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
			local var_128_0 = 0.1
			local var_128_1 = 1

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				local var_128_2 = "play"
				local var_128_3 = "effect"

				arg_125_1:AudioAction(var_128_2, var_128_3, "se_story_143", "se_story_143_5270201Talk2_2", "")
			end

			local var_128_4 = manager.ui.mainCamera.transform
			local var_128_5 = 0.1

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.var_.shakeOldPos = var_128_4.localPosition
			end

			local var_128_6 = 0.4

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / 0.132
				local var_128_8, var_128_9 = math.modf(var_128_7)

				var_128_4.localPosition = Vector3.New(var_128_9 * 0.13, var_128_9 * 0.13, var_128_9 * 0.13) + arg_125_1.var_.shakeOldPos
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				var_128_4.localPosition = arg_125_1.var_.shakeOldPos
			end

			local var_128_10 = manager.ui.mainCamera.transform
			local var_128_11 = 0.1

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				local var_128_12 = arg_125_1.var_.effect1028
				local var_128_13
				local var_128_14 = var_128_10

				if not var_128_12 then
					var_128_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_128_14)
					var_128_12.name = "1028"
					arg_125_1.var_.effect1028 = var_128_12
				else
					var_128_12.transform:SetParent(var_128_14)
				end

				var_128_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_128_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_128_15 = manager.ui.mainCamera.transform
			local var_128_16 = 4.13333333333333

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				local var_128_17 = arg_125_1.var_.effect1028

				if var_128_17 then
					Object.Destroy(var_128_17)

					arg_125_1.var_.effect1028 = nil
				end
			end

			local var_128_18 = 0
			local var_128_19 = 1.7

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_20 = arg_125_1:GetWordFromCfg(322131028)
				local var_128_21 = arg_125_1:FormatText(var_128_20.content)

				arg_125_1.text_.text = var_128_21

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_22 = 68
				local var_128_23 = utf8.len(var_128_21)
				local var_128_24 = var_128_22 <= 0 and var_128_19 or var_128_19 * (var_128_23 / var_128_22)

				if var_128_24 > 0 and var_128_19 < var_128_24 then
					arg_125_1.talkMaxDuration = var_128_24

					if var_128_24 + var_128_18 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_24 + var_128_18
					end
				end

				arg_125_1.text_.text = var_128_21
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_19, arg_125_1.talkMaxDuration)

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_18) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_18 + var_128_25 and arg_125_1.time_ < var_128_18 + var_128_25 + arg_128_0 then
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
			local var_132_0 = "10130ui_story"

			if arg_129_1.actors_[var_132_0] == nil then
				local var_132_1 = Asset.Load("Char/" .. "10130ui_story")

				if not isNil(var_132_1) then
					local var_132_2 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_129_1.stage_.transform)

					var_132_2.name = var_132_0
					var_132_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_129_1.actors_[var_132_0] = var_132_2

					local var_132_3 = var_132_2:GetComponentInChildren(typeof(CharacterEffect))

					var_132_3.enabled = true

					local var_132_4 = GameObjectTools.GetOrAddComponent(var_132_2, typeof(DynamicBoneHelper))

					if var_132_4 then
						var_132_4:EnableDynamicBone(false)
					end

					arg_129_1:ShowWeapon(var_132_3.transform, false)

					arg_129_1.var_[var_132_0 .. "Animator"] = var_132_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_129_1.var_[var_132_0 .. "Animator"].applyRootMotion = true
					arg_129_1.var_[var_132_0 .. "LipSync"] = var_132_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_132_5 = arg_129_1.actors_["10130ui_story"].transform
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.var_.moveOldPos10130ui_story = var_132_5.localPosition
			end

			local var_132_7 = 0.001

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7
				local var_132_9 = Vector3.New(-0.94, -1.02, -5.81)

				var_132_5.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10130ui_story, var_132_9, var_132_8)

				local var_132_10 = manager.ui.mainCamera.transform.position - var_132_5.position

				var_132_5.forward = Vector3.New(var_132_10.x, var_132_10.y, var_132_10.z)

				local var_132_11 = var_132_5.localEulerAngles

				var_132_11.z = 0
				var_132_11.x = 0
				var_132_5.localEulerAngles = var_132_11
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 then
				var_132_5.localPosition = Vector3.New(-0.94, -1.02, -5.81)

				local var_132_12 = manager.ui.mainCamera.transform.position - var_132_5.position

				var_132_5.forward = Vector3.New(var_132_12.x, var_132_12.y, var_132_12.z)

				local var_132_13 = var_132_5.localEulerAngles

				var_132_13.z = 0
				var_132_13.x = 0
				var_132_5.localEulerAngles = var_132_13
			end

			local var_132_14 = arg_129_1.actors_["10130ui_story"]
			local var_132_15 = 0

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.characterEffect10130ui_story == nil then
				arg_129_1.var_.characterEffect10130ui_story = var_132_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_16 = 0.200000002980232

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_16 and not isNil(var_132_14) then
				local var_132_17 = (arg_129_1.time_ - var_132_15) / var_132_16

				if arg_129_1.var_.characterEffect10130ui_story and not isNil(var_132_14) then
					arg_129_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_15 + var_132_16 and arg_129_1.time_ < var_132_15 + var_132_16 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.characterEffect10130ui_story then
				arg_129_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_132_18 = 0

			if var_132_18 < arg_129_1.time_ and arg_129_1.time_ <= var_132_18 + arg_132_0 then
				arg_129_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action8_1")
			end

			local var_132_19 = 0

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_20 = 0
			local var_132_21 = 0.35

			if var_132_20 < arg_129_1.time_ and arg_129_1.time_ <= var_132_20 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_22 = arg_129_1:FormatText(StoryNameCfg[1049].name)

				arg_129_1.leftNameTxt_.text = var_132_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_23 = arg_129_1:GetWordFromCfg(322131029)
				local var_132_24 = arg_129_1:FormatText(var_132_23.content)

				arg_129_1.text_.text = var_132_24

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_25 = 14
				local var_132_26 = utf8.len(var_132_24)
				local var_132_27 = var_132_25 <= 0 and var_132_21 or var_132_21 * (var_132_26 / var_132_25)

				if var_132_27 > 0 and var_132_21 < var_132_27 then
					arg_129_1.talkMaxDuration = var_132_27

					if var_132_27 + var_132_20 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_27 + var_132_20
					end
				end

				arg_129_1.text_.text = var_132_24
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131029", "story_v_out_322131.awb") ~= 0 then
					local var_132_28 = manager.audio:GetVoiceLength("story_v_out_322131", "322131029", "story_v_out_322131.awb") / 1000

					if var_132_28 + var_132_20 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_28 + var_132_20
					end

					if var_132_23.prefab_name ~= "" and arg_129_1.actors_[var_132_23.prefab_name] ~= nil then
						local var_132_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_23.prefab_name].transform, "story_v_out_322131", "322131029", "story_v_out_322131.awb")

						arg_129_1:RecordAudio("322131029", var_132_29)
						arg_129_1:RecordAudio("322131029", var_132_29)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322131", "322131029", "story_v_out_322131.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322131", "322131029", "story_v_out_322131.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_30 = math.max(var_132_21, arg_129_1.talkMaxDuration)

			if var_132_20 <= arg_129_1.time_ and arg_129_1.time_ < var_132_20 + var_132_30 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_20) / var_132_30

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_20 + var_132_30 and arg_129_1.time_ < var_132_20 + var_132_30 + arg_132_0 then
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
			local var_136_0 = arg_133_1.actors_["1044ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1044ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0.7, -1, -5.93)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1044ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1044ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1044ui_story == nil then
				arg_133_1.var_.characterEffect1044ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1044ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1044ui_story then
				arg_133_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_136_13 = arg_133_1.actors_["10130ui_story"]
			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect10130ui_story == nil then
				arg_133_1.var_.characterEffect10130ui_story = var_136_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_15 = 0.200000002980232

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 and not isNil(var_136_13) then
				local var_136_16 = (arg_133_1.time_ - var_136_14) / var_136_15

				if arg_133_1.var_.characterEffect10130ui_story and not isNil(var_136_13) then
					local var_136_17 = Mathf.Lerp(0, 0.5, var_136_16)

					arg_133_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10130ui_story.fillRatio = var_136_17
				end
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect10130ui_story then
				local var_136_18 = 0.5

				arg_133_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10130ui_story.fillRatio = var_136_18
			end

			local var_136_19 = 0

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_136_20 = 0
			local var_136_21 = 0.375

			if var_136_20 < arg_133_1.time_ and arg_133_1.time_ <= var_136_20 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_22 = arg_133_1:FormatText(StoryNameCfg[67].name)

				arg_133_1.leftNameTxt_.text = var_136_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_23 = arg_133_1:GetWordFromCfg(322131030)
				local var_136_24 = arg_133_1:FormatText(var_136_23.content)

				arg_133_1.text_.text = var_136_24

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_25 = 15
				local var_136_26 = utf8.len(var_136_24)
				local var_136_27 = var_136_25 <= 0 and var_136_21 or var_136_21 * (var_136_26 / var_136_25)

				if var_136_27 > 0 and var_136_21 < var_136_27 then
					arg_133_1.talkMaxDuration = var_136_27

					if var_136_27 + var_136_20 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_27 + var_136_20
					end
				end

				arg_133_1.text_.text = var_136_24
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131030", "story_v_out_322131.awb") ~= 0 then
					local var_136_28 = manager.audio:GetVoiceLength("story_v_out_322131", "322131030", "story_v_out_322131.awb") / 1000

					if var_136_28 + var_136_20 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_28 + var_136_20
					end

					if var_136_23.prefab_name ~= "" and arg_133_1.actors_[var_136_23.prefab_name] ~= nil then
						local var_136_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_23.prefab_name].transform, "story_v_out_322131", "322131030", "story_v_out_322131.awb")

						arg_133_1:RecordAudio("322131030", var_136_29)
						arg_133_1:RecordAudio("322131030", var_136_29)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322131", "322131030", "story_v_out_322131.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322131", "322131030", "story_v_out_322131.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_30 = math.max(var_136_21, arg_133_1.talkMaxDuration)

			if var_136_20 <= arg_133_1.time_ and arg_133_1.time_ < var_136_20 + var_136_30 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_20) / var_136_30

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_20 + var_136_30 and arg_133_1.time_ < var_136_20 + var_136_30 + arg_136_0 then
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
			local var_140_0 = 0
			local var_140_1 = 0.875

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[67].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(322131031)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 35
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131031", "story_v_out_322131.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131031", "story_v_out_322131.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_322131", "322131031", "story_v_out_322131.awb")

						arg_137_1:RecordAudio("322131031", var_140_9)
						arg_137_1:RecordAudio("322131031", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_322131", "322131031", "story_v_out_322131.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_322131", "322131031", "story_v_out_322131.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
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
			local var_144_0 = arg_141_1.actors_["10130ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10130ui_story == nil then
				arg_141_1.var_.characterEffect10130ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10130ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10130ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10130ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10130ui_story.fillRatio = var_144_5
			end

			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_144_7 = 0
			local var_144_8 = 0.45

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_9 = arg_141_1:FormatText(StoryNameCfg[67].name)

				arg_141_1.leftNameTxt_.text = var_144_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(322131032)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 18
				local var_144_13 = utf8.len(var_144_11)
				local var_144_14 = var_144_12 <= 0 and var_144_8 or var_144_8 * (var_144_13 / var_144_12)

				if var_144_14 > 0 and var_144_8 < var_144_14 then
					arg_141_1.talkMaxDuration = var_144_14

					if var_144_14 + var_144_7 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_7
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131032", "story_v_out_322131.awb") ~= 0 then
					local var_144_15 = manager.audio:GetVoiceLength("story_v_out_322131", "322131032", "story_v_out_322131.awb") / 1000

					if var_144_15 + var_144_7 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_7
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_322131", "322131032", "story_v_out_322131.awb")

						arg_141_1:RecordAudio("322131032", var_144_16)
						arg_141_1:RecordAudio("322131032", var_144_16)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322131", "322131032", "story_v_out_322131.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322131", "322131032", "story_v_out_322131.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_17 = math.max(var_144_8, arg_141_1.talkMaxDuration)

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_17 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_7) / var_144_17

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_7 + var_144_17 and arg_141_1.time_ < var_144_7 + var_144_17 + arg_144_0 then
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
			local var_148_0 = arg_145_1.actors_["1044ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1044ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1044ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["10130ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos10130ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(0, 100, 0)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10130ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = 0
			local var_148_19 = 0.075

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_20 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_21 = arg_145_1:GetWordFromCfg(322131033)
				local var_148_22 = arg_145_1:FormatText(var_148_21.content)

				arg_145_1.text_.text = var_148_22

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_23 = 3
				local var_148_24 = utf8.len(var_148_22)
				local var_148_25 = var_148_23 <= 0 and var_148_19 or var_148_19 * (var_148_24 / var_148_23)

				if var_148_25 > 0 and var_148_19 < var_148_25 then
					arg_145_1.talkMaxDuration = var_148_25

					if var_148_25 + var_148_18 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_25 + var_148_18
					end
				end

				arg_145_1.text_.text = var_148_22
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_26 = math.max(var_148_19, arg_145_1.talkMaxDuration)

			if var_148_18 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_18) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_18 + var_148_26 and arg_145_1.time_ < var_148_18 + var_148_26 + arg_148_0 then
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
			local var_152_0 = 0.1
			local var_152_1 = 1

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				local var_152_2 = "play"
				local var_152_3 = "effect"

				arg_149_1:AudioAction(var_152_2, var_152_3, "se_story_141", "se_story_141_1211_bullet2", "")
			end

			local var_152_4 = manager.ui.mainCamera.transform
			local var_152_5 = 0.1

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				local var_152_6 = arg_149_1.var_.effect1033
				local var_152_7
				local var_152_8 = var_152_4

				if not var_152_6 then
					var_152_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_152_8)
					var_152_6.name = "1033"
					arg_149_1.var_.effect1033 = var_152_6
				else
					var_152_6.transform:SetParent(var_152_8)
				end

				var_152_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_152_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_152_9 = manager.ui.mainCamera.transform
			local var_152_10 = 3.9

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				local var_152_11 = arg_149_1.var_.effect1033

				if var_152_11 then
					Object.Destroy(var_152_11)

					arg_149_1.var_.effect1033 = nil
				end
			end

			local var_152_12 = manager.ui.mainCamera.transform
			local var_152_13 = 0.1

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1.var_.shakeOldPos = var_152_12.localPosition
			end

			local var_152_14 = 0.766666663686434

			if var_152_13 <= arg_149_1.time_ and arg_149_1.time_ < var_152_13 + var_152_14 then
				local var_152_15 = (arg_149_1.time_ - var_152_13) / 0.132
				local var_152_16, var_152_17 = math.modf(var_152_15)

				var_152_12.localPosition = Vector3.New(var_152_17 * 0.13, var_152_17 * 0.13, var_152_17 * 0.13) + arg_149_1.var_.shakeOldPos
			end

			if arg_149_1.time_ >= var_152_13 + var_152_14 and arg_149_1.time_ < var_152_13 + var_152_14 + arg_152_0 then
				var_152_12.localPosition = arg_149_1.var_.shakeOldPos
			end

			local var_152_18 = 0
			local var_152_19 = 0.925

			if var_152_18 < arg_149_1.time_ and arg_149_1.time_ <= var_152_18 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_20 = arg_149_1:GetWordFromCfg(322131034)
				local var_152_21 = arg_149_1:FormatText(var_152_20.content)

				arg_149_1.text_.text = var_152_21

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_22 = 37
				local var_152_23 = utf8.len(var_152_21)
				local var_152_24 = var_152_22 <= 0 and var_152_19 or var_152_19 * (var_152_23 / var_152_22)

				if var_152_24 > 0 and var_152_19 < var_152_24 then
					arg_149_1.talkMaxDuration = var_152_24

					if var_152_24 + var_152_18 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_24 + var_152_18
					end
				end

				arg_149_1.text_.text = var_152_21
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_25 = math.max(var_152_19, arg_149_1.talkMaxDuration)

			if var_152_18 <= arg_149_1.time_ and arg_149_1.time_ < var_152_18 + var_152_25 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_18) / var_152_25

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_18 + var_152_25 and arg_149_1.time_ < var_152_18 + var_152_25 + arg_152_0 then
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
			local var_156_0 = 0.333333333333333
			local var_156_1 = 1

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				local var_156_2 = "play"
				local var_156_3 = "effect"

				arg_153_1:AudioAction(var_156_2, var_156_3, "se_story_145", "se_story_145_blast", "")
			end

			local var_156_4 = manager.ui.mainCamera.transform
			local var_156_5 = 0.333333333333333

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.var_.shakeOldPos = var_156_4.localPosition
			end

			local var_156_6 = 0.566666666666667

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / 0.198
				local var_156_8, var_156_9 = math.modf(var_156_7)

				var_156_4.localPosition = Vector3.New(var_156_9 * 0.13, var_156_9 * 0.13, var_156_9 * 0.13) + arg_153_1.var_.shakeOldPos
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 then
				var_156_4.localPosition = arg_153_1.var_.shakeOldPos
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = false

				arg_153_1:SetGaussion(false)
			end

			local var_156_11 = 0.333333333333333

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11
				local var_156_13 = Color.New(1, 1, 1)

				var_156_13.a = Mathf.Lerp(1, 0, var_156_12)
				arg_153_1.mask_.color = var_156_13
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 then
				local var_156_14 = Color.New(1, 1, 1)
				local var_156_15 = 0

				arg_153_1.mask_.enabled = false
				var_156_14.a = var_156_15
				arg_153_1.mask_.color = var_156_14
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_16 = 0.9
			local var_156_17 = 1.3

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_18 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_18:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:GetWordFromCfg(322131035)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 52
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23
					var_156_16 = var_156_16 + 0.3

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_24 = var_156_16 + 0.3
			local var_156_25 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_24) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_24 + var_156_25 and arg_153_1.time_ < var_156_24 + var_156_25 + arg_156_0 then
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
			local var_162_0 = arg_159_1.actors_["1211ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1211ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -0.67, -6.07)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1211ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1211ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1211ui_story == nil then
				arg_159_1.var_.characterEffect1211ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1211ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1211ui_story then
				arg_159_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_162_15 = 0
			local var_162_16 = 0.075

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[37].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(322131036)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 3
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131036", "story_v_out_322131.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_322131", "322131036", "story_v_out_322131.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_322131", "322131036", "story_v_out_322131.awb")

						arg_159_1:RecordAudio("322131036", var_162_24)
						arg_159_1:RecordAudio("322131036", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322131", "322131036", "story_v_out_322131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322131", "322131036", "story_v_out_322131.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
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
			local var_166_0 = arg_163_1.actors_["1211ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1211ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1211ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = 0
			local var_166_10 = 1.25

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_11 = arg_163_1:GetWordFromCfg(322131037)
				local var_166_12 = arg_163_1:FormatText(var_166_11.content)

				arg_163_1.text_.text = var_166_12

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 50
				local var_166_14 = utf8.len(var_166_12)
				local var_166_15 = var_166_13 <= 0 and var_166_10 or var_166_10 * (var_166_14 / var_166_13)

				if var_166_15 > 0 and var_166_10 < var_166_15 then
					arg_163_1.talkMaxDuration = var_166_15

					if var_166_15 + var_166_9 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_15 + var_166_9
					end
				end

				arg_163_1.text_.text = var_166_12
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_10, arg_163_1.talkMaxDuration)

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_9) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_9 + var_166_16 and arg_163_1.time_ < var_166_9 + var_166_16 + arg_166_0 then
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
			local var_170_0 = arg_167_1.actors_["1044ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1044ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, -1, -5.93)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1044ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["1044ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect1044ui_story == nil then
				arg_167_1.var_.characterEffect1044ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 and not isNil(var_170_9) then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect1044ui_story and not isNil(var_170_9) then
					arg_167_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect1044ui_story then
				arg_167_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_170_15 = 0
			local var_170_16 = 0.4

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[67].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_18 = arg_167_1:GetWordFromCfg(322131038)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 16
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131038", "story_v_out_322131.awb") ~= 0 then
					local var_170_23 = manager.audio:GetVoiceLength("story_v_out_322131", "322131038", "story_v_out_322131.awb") / 1000

					if var_170_23 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_15
					end

					if var_170_18.prefab_name ~= "" and arg_167_1.actors_[var_170_18.prefab_name] ~= nil then
						local var_170_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_18.prefab_name].transform, "story_v_out_322131", "322131038", "story_v_out_322131.awb")

						arg_167_1:RecordAudio("322131038", var_170_24)
						arg_167_1:RecordAudio("322131038", var_170_24)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_322131", "322131038", "story_v_out_322131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_322131", "322131038", "story_v_out_322131.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_25 and arg_167_1.time_ < var_170_15 + var_170_25 + arg_170_0 then
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
			local var_174_0 = arg_171_1.actors_["1211ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1211ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0.7, -0.67, -6.07)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1211ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1044ui_story"].transform
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.var_.moveOldPos1044ui_story = var_174_9.localPosition
			end

			local var_174_11 = 0.001

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11
				local var_174_13 = Vector3.New(-0.7, -1, -5.93)

				var_174_9.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1044ui_story, var_174_13, var_174_12)

				local var_174_14 = manager.ui.mainCamera.transform.position - var_174_9.position

				var_174_9.forward = Vector3.New(var_174_14.x, var_174_14.y, var_174_14.z)

				local var_174_15 = var_174_9.localEulerAngles

				var_174_15.z = 0
				var_174_15.x = 0
				var_174_9.localEulerAngles = var_174_15
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 then
				var_174_9.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_174_16 = manager.ui.mainCamera.transform.position - var_174_9.position

				var_174_9.forward = Vector3.New(var_174_16.x, var_174_16.y, var_174_16.z)

				local var_174_17 = var_174_9.localEulerAngles

				var_174_17.z = 0
				var_174_17.x = 0
				var_174_9.localEulerAngles = var_174_17
			end

			local var_174_18 = arg_171_1.actors_["1211ui_story"]
			local var_174_19 = 0

			if var_174_19 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 and not isNil(var_174_18) and arg_171_1.var_.characterEffect1211ui_story == nil then
				arg_171_1.var_.characterEffect1211ui_story = var_174_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_20 = 0.200000002980232

			if var_174_19 <= arg_171_1.time_ and arg_171_1.time_ < var_174_19 + var_174_20 and not isNil(var_174_18) then
				local var_174_21 = (arg_171_1.time_ - var_174_19) / var_174_20

				if arg_171_1.var_.characterEffect1211ui_story and not isNil(var_174_18) then
					arg_171_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_19 + var_174_20 and arg_171_1.time_ < var_174_19 + var_174_20 + arg_174_0 and not isNil(var_174_18) and arg_171_1.var_.characterEffect1211ui_story then
				arg_171_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_174_22 = arg_171_1.actors_["1044ui_story"]
			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.characterEffect1044ui_story == nil then
				arg_171_1.var_.characterEffect1044ui_story = var_174_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_24 = 0.200000002980232

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 and not isNil(var_174_22) then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24

				if arg_171_1.var_.characterEffect1044ui_story and not isNil(var_174_22) then
					local var_174_26 = Mathf.Lerp(0, 0.5, var_174_25)

					arg_171_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1044ui_story.fillRatio = var_174_26
				end
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.characterEffect1044ui_story then
				local var_174_27 = 0.5

				arg_171_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1044ui_story.fillRatio = var_174_27
			end

			local var_174_28 = 0

			if var_174_28 < arg_171_1.time_ and arg_171_1.time_ <= var_174_28 + arg_174_0 then
				arg_171_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_174_29 = 0

			if var_174_29 < arg_171_1.time_ and arg_171_1.time_ <= var_174_29 + arg_174_0 then
				arg_171_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_2")
			end

			local var_174_30 = 0
			local var_174_31 = 0.325

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_32 = arg_171_1:FormatText(StoryNameCfg[37].name)

				arg_171_1.leftNameTxt_.text = var_174_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:GetWordFromCfg(322131039)
				local var_174_34 = arg_171_1:FormatText(var_174_33.content)

				arg_171_1.text_.text = var_174_34

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 13
				local var_174_36 = utf8.len(var_174_34)
				local var_174_37 = var_174_35 <= 0 and var_174_31 or var_174_31 * (var_174_36 / var_174_35)

				if var_174_37 > 0 and var_174_31 < var_174_37 then
					arg_171_1.talkMaxDuration = var_174_37

					if var_174_37 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_34
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131039", "story_v_out_322131.awb") ~= 0 then
					local var_174_38 = manager.audio:GetVoiceLength("story_v_out_322131", "322131039", "story_v_out_322131.awb") / 1000

					if var_174_38 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_38 + var_174_30
					end

					if var_174_33.prefab_name ~= "" and arg_171_1.actors_[var_174_33.prefab_name] ~= nil then
						local var_174_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_33.prefab_name].transform, "story_v_out_322131", "322131039", "story_v_out_322131.awb")

						arg_171_1:RecordAudio("322131039", var_174_39)
						arg_171_1:RecordAudio("322131039", var_174_39)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_322131", "322131039", "story_v_out_322131.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_322131", "322131039", "story_v_out_322131.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_40 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_40 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_30) / var_174_40

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_30 + var_174_40 and arg_171_1.time_ < var_174_30 + var_174_40 + arg_174_0 then
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
			local var_178_0 = arg_175_1.actors_["1044ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1044ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.7, -1, -5.93)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1044ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1044ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1044ui_story == nil then
				arg_175_1.var_.characterEffect1044ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1044ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1044ui_story then
				arg_175_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_178_13 = arg_175_1.actors_["1211ui_story"]
			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 and not isNil(var_178_13) and arg_175_1.var_.characterEffect1211ui_story == nil then
				arg_175_1.var_.characterEffect1211ui_story = var_178_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_15 = 0.200000002980232

			if var_178_14 <= arg_175_1.time_ and arg_175_1.time_ < var_178_14 + var_178_15 and not isNil(var_178_13) then
				local var_178_16 = (arg_175_1.time_ - var_178_14) / var_178_15

				if arg_175_1.var_.characterEffect1211ui_story and not isNil(var_178_13) then
					local var_178_17 = Mathf.Lerp(0, 0.5, var_178_16)

					arg_175_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1211ui_story.fillRatio = var_178_17
				end
			end

			if arg_175_1.time_ >= var_178_14 + var_178_15 and arg_175_1.time_ < var_178_14 + var_178_15 + arg_178_0 and not isNil(var_178_13) and arg_175_1.var_.characterEffect1211ui_story then
				local var_178_18 = 0.5

				arg_175_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1211ui_story.fillRatio = var_178_18
			end

			local var_178_19 = 0

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				arg_175_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_2")
			end

			local var_178_20 = 0
			local var_178_21 = 0.3

			if var_178_20 < arg_175_1.time_ and arg_175_1.time_ <= var_178_20 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_22 = arg_175_1:FormatText(StoryNameCfg[67].name)

				arg_175_1.leftNameTxt_.text = var_178_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_23 = arg_175_1:GetWordFromCfg(322131040)
				local var_178_24 = arg_175_1:FormatText(var_178_23.content)

				arg_175_1.text_.text = var_178_24

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_25 = 12
				local var_178_26 = utf8.len(var_178_24)
				local var_178_27 = var_178_25 <= 0 and var_178_21 or var_178_21 * (var_178_26 / var_178_25)

				if var_178_27 > 0 and var_178_21 < var_178_27 then
					arg_175_1.talkMaxDuration = var_178_27

					if var_178_27 + var_178_20 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_27 + var_178_20
					end
				end

				arg_175_1.text_.text = var_178_24
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131040", "story_v_out_322131.awb") ~= 0 then
					local var_178_28 = manager.audio:GetVoiceLength("story_v_out_322131", "322131040", "story_v_out_322131.awb") / 1000

					if var_178_28 + var_178_20 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_28 + var_178_20
					end

					if var_178_23.prefab_name ~= "" and arg_175_1.actors_[var_178_23.prefab_name] ~= nil then
						local var_178_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_23.prefab_name].transform, "story_v_out_322131", "322131040", "story_v_out_322131.awb")

						arg_175_1:RecordAudio("322131040", var_178_29)
						arg_175_1:RecordAudio("322131040", var_178_29)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322131", "322131040", "story_v_out_322131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322131", "322131040", "story_v_out_322131.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_30 = math.max(var_178_21, arg_175_1.talkMaxDuration)

			if var_178_20 <= arg_175_1.time_ and arg_175_1.time_ < var_178_20 + var_178_30 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_20) / var_178_30

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_20 + var_178_30 and arg_175_1.time_ < var_178_20 + var_178_30 + arg_178_0 then
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
			local var_182_0 = 0
			local var_182_1 = 0.4

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[67].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(322131041)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 16
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131041", "story_v_out_322131.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131041", "story_v_out_322131.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_322131", "322131041", "story_v_out_322131.awb")

						arg_179_1:RecordAudio("322131041", var_182_9)
						arg_179_1:RecordAudio("322131041", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_322131", "322131041", "story_v_out_322131.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_322131", "322131041", "story_v_out_322131.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
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
			local var_186_0 = arg_183_1.actors_["1044ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1044ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, 100, 0)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1044ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, 100, 0)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1211ui_story"].transform
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.var_.moveOldPos1211ui_story = var_186_9.localPosition
			end

			local var_186_11 = 0.001

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11
				local var_186_13 = Vector3.New(0, 100, 0)

				var_186_9.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1211ui_story, var_186_13, var_186_12)

				local var_186_14 = manager.ui.mainCamera.transform.position - var_186_9.position

				var_186_9.forward = Vector3.New(var_186_14.x, var_186_14.y, var_186_14.z)

				local var_186_15 = var_186_9.localEulerAngles

				var_186_15.z = 0
				var_186_15.x = 0
				var_186_9.localEulerAngles = var_186_15
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 then
				var_186_9.localPosition = Vector3.New(0, 100, 0)

				local var_186_16 = manager.ui.mainCamera.transform.position - var_186_9.position

				var_186_9.forward = Vector3.New(var_186_16.x, var_186_16.y, var_186_16.z)

				local var_186_17 = var_186_9.localEulerAngles

				var_186_17.z = 0
				var_186_17.x = 0
				var_186_9.localEulerAngles = var_186_17
			end

			local var_186_18 = arg_183_1.actors_["1044ui_story"]
			local var_186_19 = 0

			if var_186_19 < arg_183_1.time_ and arg_183_1.time_ <= var_186_19 + arg_186_0 and not isNil(var_186_18) and arg_183_1.var_.characterEffect1044ui_story == nil then
				arg_183_1.var_.characterEffect1044ui_story = var_186_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_20 = 0.200000002980232

			if var_186_19 <= arg_183_1.time_ and arg_183_1.time_ < var_186_19 + var_186_20 and not isNil(var_186_18) then
				local var_186_21 = (arg_183_1.time_ - var_186_19) / var_186_20

				if arg_183_1.var_.characterEffect1044ui_story and not isNil(var_186_18) then
					local var_186_22 = Mathf.Lerp(0, 0.5, var_186_21)

					arg_183_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1044ui_story.fillRatio = var_186_22
				end
			end

			if arg_183_1.time_ >= var_186_19 + var_186_20 and arg_183_1.time_ < var_186_19 + var_186_20 + arg_186_0 and not isNil(var_186_18) and arg_183_1.var_.characterEffect1044ui_story then
				local var_186_23 = 0.5

				arg_183_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1044ui_story.fillRatio = var_186_23
			end

			local var_186_24 = 0.1
			local var_186_25 = 1

			if var_186_24 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 then
				local var_186_26 = "play"
				local var_186_27 = "effect"

				arg_183_1:AudioAction(var_186_26, var_186_27, "se_story_141", "se_story_141_ring", "")
			end

			local var_186_28 = manager.ui.mainCamera.transform
			local var_186_29 = 0.1

			if var_186_29 < arg_183_1.time_ and arg_183_1.time_ <= var_186_29 + arg_186_0 then
				arg_183_1.var_.shakeOldPos = var_186_28.localPosition
			end

			local var_186_30 = 0.5

			if var_186_29 <= arg_183_1.time_ and arg_183_1.time_ < var_186_29 + var_186_30 then
				local var_186_31 = (arg_183_1.time_ - var_186_29) / 0.066
				local var_186_32, var_186_33 = math.modf(var_186_31)

				var_186_28.localPosition = Vector3.New(var_186_33 * 0.13, var_186_33 * 0.13, var_186_33 * 0.13) + arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.time_ >= var_186_29 + var_186_30 and arg_183_1.time_ < var_186_29 + var_186_30 + arg_186_0 then
				var_186_28.localPosition = arg_183_1.var_.shakeOldPos
			end

			local var_186_34 = manager.ui.mainCamera.transform
			local var_186_35 = 0.1

			if var_186_35 < arg_183_1.time_ and arg_183_1.time_ <= var_186_35 + arg_186_0 then
				local var_186_36 = arg_183_1.var_.effect1042
				local var_186_37
				local var_186_38 = var_186_34

				if not var_186_36 then
					var_186_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_186_38)
					var_186_36.name = "1042"
					arg_183_1.var_.effect1042 = var_186_36
				else
					var_186_36.transform:SetParent(var_186_38)
				end

				var_186_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_186_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_39 = 0.6
			local var_186_40 = 1.15

			if var_186_39 < arg_183_1.time_ and arg_183_1.time_ <= var_186_39 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_41 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_41:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_42 = arg_183_1:GetWordFromCfg(322131042)
				local var_186_43 = arg_183_1:FormatText(var_186_42.content)

				arg_183_1.text_.text = var_186_43

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_44 = 46
				local var_186_45 = utf8.len(var_186_43)
				local var_186_46 = var_186_44 <= 0 and var_186_40 or var_186_40 * (var_186_45 / var_186_44)

				if var_186_46 > 0 and var_186_40 < var_186_46 then
					arg_183_1.talkMaxDuration = var_186_46
					var_186_39 = var_186_39 + 0.3

					if var_186_46 + var_186_39 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_46 + var_186_39
					end
				end

				arg_183_1.text_.text = var_186_43
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_47 = var_186_39 + 0.3
			local var_186_48 = math.max(var_186_40, arg_183_1.talkMaxDuration)

			if var_186_47 <= arg_183_1.time_ and arg_183_1.time_ < var_186_47 + var_186_48 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_47) / var_186_48

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_47 + var_186_48 and arg_183_1.time_ < var_186_47 + var_186_48 + arg_186_0 then
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
			local var_192_0 = "404001ui_story"

			if arg_189_1.actors_[var_192_0] == nil then
				local var_192_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_192_1) then
					local var_192_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_189_1.stage_.transform)

					var_192_2.name = var_192_0
					var_192_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_189_1.actors_[var_192_0] = var_192_2

					local var_192_3 = var_192_2:GetComponentInChildren(typeof(CharacterEffect))

					var_192_3.enabled = true

					local var_192_4 = GameObjectTools.GetOrAddComponent(var_192_2, typeof(DynamicBoneHelper))

					if var_192_4 then
						var_192_4:EnableDynamicBone(false)
					end

					arg_189_1:ShowWeapon(var_192_3.transform, false)

					arg_189_1.var_[var_192_0 .. "Animator"] = var_192_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_189_1.var_[var_192_0 .. "Animator"].applyRootMotion = true
					arg_189_1.var_[var_192_0 .. "LipSync"] = var_192_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_192_5 = arg_189_1.actors_["404001ui_story"].transform
			local var_192_6 = 0

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.var_.moveOldPos404001ui_story = var_192_5.localPosition
			end

			local var_192_7 = 0.001

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_7 then
				local var_192_8 = (arg_189_1.time_ - var_192_6) / var_192_7
				local var_192_9 = Vector3.New(0, -1.55, -5.5)

				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos404001ui_story, var_192_9, var_192_8)

				local var_192_10 = manager.ui.mainCamera.transform.position - var_192_5.position

				var_192_5.forward = Vector3.New(var_192_10.x, var_192_10.y, var_192_10.z)

				local var_192_11 = var_192_5.localEulerAngles

				var_192_11.z = 0
				var_192_11.x = 0
				var_192_5.localEulerAngles = var_192_11
			end

			if arg_189_1.time_ >= var_192_6 + var_192_7 and arg_189_1.time_ < var_192_6 + var_192_7 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_192_12 = manager.ui.mainCamera.transform.position - var_192_5.position

				var_192_5.forward = Vector3.New(var_192_12.x, var_192_12.y, var_192_12.z)

				local var_192_13 = var_192_5.localEulerAngles

				var_192_13.z = 0
				var_192_13.x = 0
				var_192_5.localEulerAngles = var_192_13
			end

			local var_192_14 = arg_189_1.actors_["404001ui_story"]
			local var_192_15 = 0

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect404001ui_story == nil then
				arg_189_1.var_.characterEffect404001ui_story = var_192_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_16 = 0.200000002980232

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_16 and not isNil(var_192_14) then
				local var_192_17 = (arg_189_1.time_ - var_192_15) / var_192_16

				if arg_189_1.var_.characterEffect404001ui_story and not isNil(var_192_14) then
					arg_189_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_15 + var_192_16 and arg_189_1.time_ < var_192_15 + var_192_16 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect404001ui_story then
				arg_189_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_192_18 = 0

			if var_192_18 < arg_189_1.time_ and arg_189_1.time_ <= var_192_18 + arg_192_0 then
				arg_189_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_192_19 = 0

			if var_192_19 < arg_189_1.time_ and arg_189_1.time_ <= var_192_19 + arg_192_0 then
				arg_189_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_192_20 = 0
			local var_192_21 = 0.4

			if var_192_20 < arg_189_1.time_ and arg_189_1.time_ <= var_192_20 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_22 = arg_189_1:FormatText(StoryNameCfg[668].name)

				arg_189_1.leftNameTxt_.text = var_192_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_23 = arg_189_1:GetWordFromCfg(322131043)
				local var_192_24 = arg_189_1:FormatText(var_192_23.content)

				arg_189_1.text_.text = var_192_24

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_25 = 16
				local var_192_26 = utf8.len(var_192_24)
				local var_192_27 = var_192_25 <= 0 and var_192_21 or var_192_21 * (var_192_26 / var_192_25)

				if var_192_27 > 0 and var_192_21 < var_192_27 then
					arg_189_1.talkMaxDuration = var_192_27

					if var_192_27 + var_192_20 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_27 + var_192_20
					end
				end

				arg_189_1.text_.text = var_192_24
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131043", "story_v_out_322131.awb") ~= 0 then
					local var_192_28 = manager.audio:GetVoiceLength("story_v_out_322131", "322131043", "story_v_out_322131.awb") / 1000

					if var_192_28 + var_192_20 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_20
					end

					if var_192_23.prefab_name ~= "" and arg_189_1.actors_[var_192_23.prefab_name] ~= nil then
						local var_192_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_23.prefab_name].transform, "story_v_out_322131", "322131043", "story_v_out_322131.awb")

						arg_189_1:RecordAudio("322131043", var_192_29)
						arg_189_1:RecordAudio("322131043", var_192_29)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322131", "322131043", "story_v_out_322131.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322131", "322131043", "story_v_out_322131.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_30 = math.max(var_192_21, arg_189_1.talkMaxDuration)

			if var_192_20 <= arg_189_1.time_ and arg_189_1.time_ < var_192_20 + var_192_30 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_20) / var_192_30

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_20 + var_192_30 and arg_189_1.time_ < var_192_20 + var_192_30 + arg_192_0 then
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
			local var_196_0 = arg_193_1.actors_["1211ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.67, -6.07)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1211ui_story"].transform
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = var_196_9.localPosition
			end

			local var_196_11 = 0.001

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11
				local var_196_13 = Vector3.New(0, -0.67, -6.07)

				var_196_9.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, var_196_13, var_196_12)

				local var_196_14 = manager.ui.mainCamera.transform.position - var_196_9.position

				var_196_9.forward = Vector3.New(var_196_14.x, var_196_14.y, var_196_14.z)

				local var_196_15 = var_196_9.localEulerAngles

				var_196_15.z = 0
				var_196_15.x = 0
				var_196_9.localEulerAngles = var_196_15
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 then
				var_196_9.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_196_16 = manager.ui.mainCamera.transform.position - var_196_9.position

				var_196_9.forward = Vector3.New(var_196_16.x, var_196_16.y, var_196_16.z)

				local var_196_17 = var_196_9.localEulerAngles

				var_196_17.z = 0
				var_196_17.x = 0
				var_196_9.localEulerAngles = var_196_17
			end

			local var_196_18 = arg_193_1.actors_["404001ui_story"].transform
			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				arg_193_1.var_.moveOldPos404001ui_story = var_196_18.localPosition
			end

			local var_196_20 = 0.001

			if var_196_19 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 then
				local var_196_21 = (arg_193_1.time_ - var_196_19) / var_196_20
				local var_196_22 = Vector3.New(0, 100, 0)

				var_196_18.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos404001ui_story, var_196_22, var_196_21)

				local var_196_23 = manager.ui.mainCamera.transform.position - var_196_18.position

				var_196_18.forward = Vector3.New(var_196_23.x, var_196_23.y, var_196_23.z)

				local var_196_24 = var_196_18.localEulerAngles

				var_196_24.z = 0
				var_196_24.x = 0
				var_196_18.localEulerAngles = var_196_24
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 then
				var_196_18.localPosition = Vector3.New(0, 100, 0)

				local var_196_25 = manager.ui.mainCamera.transform.position - var_196_18.position

				var_196_18.forward = Vector3.New(var_196_25.x, var_196_25.y, var_196_25.z)

				local var_196_26 = var_196_18.localEulerAngles

				var_196_26.z = 0
				var_196_26.x = 0
				var_196_18.localEulerAngles = var_196_26
			end

			local var_196_27 = arg_193_1.actors_["1211ui_story"]
			local var_196_28 = 0

			if var_196_28 < arg_193_1.time_ and arg_193_1.time_ <= var_196_28 + arg_196_0 and not isNil(var_196_27) and arg_193_1.var_.characterEffect1211ui_story == nil then
				arg_193_1.var_.characterEffect1211ui_story = var_196_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_29 = 0.200000002980232

			if var_196_28 <= arg_193_1.time_ and arg_193_1.time_ < var_196_28 + var_196_29 and not isNil(var_196_27) then
				local var_196_30 = (arg_193_1.time_ - var_196_28) / var_196_29

				if arg_193_1.var_.characterEffect1211ui_story and not isNil(var_196_27) then
					arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_28 + var_196_29 and arg_193_1.time_ < var_196_28 + var_196_29 + arg_196_0 and not isNil(var_196_27) and arg_193_1.var_.characterEffect1211ui_story then
				arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_196_31 = arg_193_1.actors_["404001ui_story"]
			local var_196_32 = 0

			if var_196_32 < arg_193_1.time_ and arg_193_1.time_ <= var_196_32 + arg_196_0 and not isNil(var_196_31) and arg_193_1.var_.characterEffect404001ui_story == nil then
				arg_193_1.var_.characterEffect404001ui_story = var_196_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_33 = 0.200000002980232

			if var_196_32 <= arg_193_1.time_ and arg_193_1.time_ < var_196_32 + var_196_33 and not isNil(var_196_31) then
				local var_196_34 = (arg_193_1.time_ - var_196_32) / var_196_33

				if arg_193_1.var_.characterEffect404001ui_story and not isNil(var_196_31) then
					local var_196_35 = Mathf.Lerp(0, 0.5, var_196_34)

					arg_193_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_193_1.var_.characterEffect404001ui_story.fillRatio = var_196_35
				end
			end

			if arg_193_1.time_ >= var_196_32 + var_196_33 and arg_193_1.time_ < var_196_32 + var_196_33 + arg_196_0 and not isNil(var_196_31) and arg_193_1.var_.characterEffect404001ui_story then
				local var_196_36 = 0.5

				arg_193_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_193_1.var_.characterEffect404001ui_story.fillRatio = var_196_36
			end

			local var_196_37 = 0

			if var_196_37 < arg_193_1.time_ and arg_193_1.time_ <= var_196_37 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_196_38 = 0

			if var_196_38 < arg_193_1.time_ and arg_193_1.time_ <= var_196_38 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_196_39 = 0
			local var_196_40 = 0.375

			if var_196_39 < arg_193_1.time_ and arg_193_1.time_ <= var_196_39 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_41 = arg_193_1:FormatText(StoryNameCfg[37].name)

				arg_193_1.leftNameTxt_.text = var_196_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_42 = arg_193_1:GetWordFromCfg(322131044)
				local var_196_43 = arg_193_1:FormatText(var_196_42.content)

				arg_193_1.text_.text = var_196_43

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_44 = 15
				local var_196_45 = utf8.len(var_196_43)
				local var_196_46 = var_196_44 <= 0 and var_196_40 or var_196_40 * (var_196_45 / var_196_44)

				if var_196_46 > 0 and var_196_40 < var_196_46 then
					arg_193_1.talkMaxDuration = var_196_46

					if var_196_46 + var_196_39 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_46 + var_196_39
					end
				end

				arg_193_1.text_.text = var_196_43
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131044", "story_v_out_322131.awb") ~= 0 then
					local var_196_47 = manager.audio:GetVoiceLength("story_v_out_322131", "322131044", "story_v_out_322131.awb") / 1000

					if var_196_47 + var_196_39 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_47 + var_196_39
					end

					if var_196_42.prefab_name ~= "" and arg_193_1.actors_[var_196_42.prefab_name] ~= nil then
						local var_196_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_42.prefab_name].transform, "story_v_out_322131", "322131044", "story_v_out_322131.awb")

						arg_193_1:RecordAudio("322131044", var_196_48)
						arg_193_1:RecordAudio("322131044", var_196_48)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322131", "322131044", "story_v_out_322131.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322131", "322131044", "story_v_out_322131.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_49 = math.max(var_196_40, arg_193_1.talkMaxDuration)

			if var_196_39 <= arg_193_1.time_ and arg_193_1.time_ < var_196_39 + var_196_49 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_39) / var_196_49

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_39 + var_196_49 and arg_193_1.time_ < var_196_39 + var_196_49 + arg_196_0 then
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
			local var_200_0 = arg_197_1.actors_["1211ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1211ui_story == nil then
				arg_197_1.var_.characterEffect1211ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1211ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1211ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1211ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1211ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.575

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_8

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

				local var_200_9 = arg_197_1:GetWordFromCfg(322131045)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 23
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
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
			local var_204_0 = 0
			local var_204_1 = 0.175

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_2

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

				local var_204_3 = arg_201_1:GetWordFromCfg(322131046)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 7
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
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
			local var_208_0 = arg_205_1.actors_["1211ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1211ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 100, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1211ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 100, 0)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = 0
			local var_208_10 = 1.1

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_11 = arg_205_1:GetWordFromCfg(322131047)
				local var_208_12 = arg_205_1:FormatText(var_208_11.content)

				arg_205_1.text_.text = var_208_12

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 44
				local var_208_14 = utf8.len(var_208_12)
				local var_208_15 = var_208_13 <= 0 and var_208_10 or var_208_10 * (var_208_14 / var_208_13)

				if var_208_15 > 0 and var_208_10 < var_208_15 then
					arg_205_1.talkMaxDuration = var_208_15

					if var_208_15 + var_208_9 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_15 + var_208_9
					end
				end

				arg_205_1.text_.text = var_208_12
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_10, arg_205_1.talkMaxDuration)

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_9) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_9 + var_208_16 and arg_205_1.time_ < var_208_9 + var_208_16 + arg_208_0 then
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
			local var_212_0 = 2

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				local var_212_1 = manager.ui.mainCamera.transform.localPosition
				local var_212_2 = Vector3.New(0, 0, 10) + Vector3.New(var_212_1.x, var_212_1.y, 0)
				local var_212_3 = arg_209_1.bgs_.L17f

				var_212_3.transform.localPosition = var_212_2
				var_212_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_4 = var_212_3:GetComponent("SpriteRenderer")

				if var_212_4 and var_212_4.sprite then
					local var_212_5 = (var_212_3.transform.localPosition - var_212_1).z
					local var_212_6 = manager.ui.mainCameraCom_
					local var_212_7 = 2 * var_212_5 * Mathf.Tan(var_212_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_8 = var_212_7 * var_212_6.aspect
					local var_212_9 = var_212_4.sprite.bounds.size.x
					local var_212_10 = var_212_4.sprite.bounds.size.y
					local var_212_11 = var_212_8 / var_212_9
					local var_212_12 = var_212_7 / var_212_10
					local var_212_13 = var_212_12 < var_212_11 and var_212_11 or var_212_12

					var_212_3.transform.localScale = Vector3.New(var_212_13, var_212_13, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "L17f" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_14 = 3.999999999999

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_15 = 0.3

			if arg_209_1.time_ >= var_212_14 + var_212_15 and arg_209_1.time_ < var_212_14 + var_212_15 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_17 = 2

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Color.New(0, 0, 0)

				var_212_19.a = Mathf.Lerp(0, 1, var_212_18)
				arg_209_1.mask_.color = var_212_19
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				local var_212_20 = Color.New(0, 0, 0)

				var_212_20.a = 1
				arg_209_1.mask_.color = var_212_20
			end

			local var_212_21 = 2

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_22 = 2

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_22 then
				local var_212_23 = (arg_209_1.time_ - var_212_21) / var_212_22
				local var_212_24 = Color.New(0, 0, 0)

				var_212_24.a = Mathf.Lerp(1, 0, var_212_23)
				arg_209_1.mask_.color = var_212_24
			end

			if arg_209_1.time_ >= var_212_21 + var_212_22 and arg_209_1.time_ < var_212_21 + var_212_22 + arg_212_0 then
				local var_212_25 = Color.New(0, 0, 0)
				local var_212_26 = 0

				arg_209_1.mask_.enabled = false
				var_212_25.a = var_212_26
				arg_209_1.mask_.color = var_212_25
			end

			local var_212_27 = 0.1
			local var_212_28 = 1

			if var_212_27 < arg_209_1.time_ and arg_209_1.time_ <= var_212_27 + arg_212_0 then
				local var_212_29 = "stop"
				local var_212_30 = "effect"

				arg_209_1:AudioAction(var_212_29, var_212_30, "se_story_145", "se_story_145_fire", "")
			end

			local var_212_31 = 1.56666666666667
			local var_212_32 = 1

			if var_212_31 < arg_209_1.time_ and arg_209_1.time_ <= var_212_31 + arg_212_0 then
				local var_212_33 = "play"
				local var_212_34 = "effect"

				arg_209_1:AudioAction(var_212_33, var_212_34, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_212_35 = manager.ui.mainCamera.transform
			local var_212_36 = 4

			if var_212_36 < arg_209_1.time_ and arg_209_1.time_ <= var_212_36 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_35.localPosition
			end

			local var_212_37 = 0.0999999999999996

			if var_212_36 <= arg_209_1.time_ and arg_209_1.time_ < var_212_36 + var_212_37 then
				local var_212_38 = (arg_209_1.time_ - var_212_36) / 0.066
				local var_212_39, var_212_40 = math.modf(var_212_38)

				var_212_35.localPosition = Vector3.New(var_212_40 * 0.13, var_212_40 * 0.13, var_212_40 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= var_212_36 + var_212_37 and arg_209_1.time_ < var_212_36 + var_212_37 + arg_212_0 then
				var_212_35.localPosition = arg_209_1.var_.shakeOldPos
			end

			local var_212_41 = manager.ui.mainCamera.transform
			local var_212_42 = 4.2

			if var_212_42 < arg_209_1.time_ and arg_209_1.time_ <= var_212_42 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_41.localPosition
			end

			local var_212_43 = 0.0666666666666664

			if var_212_42 <= arg_209_1.time_ and arg_209_1.time_ < var_212_42 + var_212_43 then
				local var_212_44 = (arg_209_1.time_ - var_212_42) / 0.066
				local var_212_45, var_212_46 = math.modf(var_212_44)

				var_212_41.localPosition = Vector3.New(var_212_46 * 0.13, var_212_46 * 0.13, var_212_46 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= var_212_42 + var_212_43 and arg_209_1.time_ < var_212_42 + var_212_43 + arg_212_0 then
				var_212_41.localPosition = arg_209_1.var_.shakeOldPos
			end

			local var_212_47 = 3.999999999999
			local var_212_48 = 1

			if var_212_47 < arg_209_1.time_ and arg_209_1.time_ <= var_212_47 + arg_212_0 then
				local var_212_49 = "play"
				local var_212_50 = "effect"

				arg_209_1:AudioAction(var_212_49, var_212_50, "se_story_7", "se_story_7_monster", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_51 = 4
			local var_212_52 = 0.15

			if var_212_51 < arg_209_1.time_ and arg_209_1.time_ <= var_212_51 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_53 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_53:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_54 = arg_209_1:FormatText(StoryNameCfg[68].name)

				arg_209_1.leftNameTxt_.text = var_212_54

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

				local var_212_55 = arg_209_1:GetWordFromCfg(322131048)
				local var_212_56 = arg_209_1:FormatText(var_212_55.content)

				arg_209_1.text_.text = var_212_56

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_57 = 6
				local var_212_58 = utf8.len(var_212_56)
				local var_212_59 = var_212_57 <= 0 and var_212_52 or var_212_52 * (var_212_58 / var_212_57)

				if var_212_59 > 0 and var_212_52 < var_212_59 then
					arg_209_1.talkMaxDuration = var_212_59
					var_212_51 = var_212_51 + 0.3

					if var_212_59 + var_212_51 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_59 + var_212_51
					end
				end

				arg_209_1.text_.text = var_212_56
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_60 = var_212_51 + 0.3
			local var_212_61 = math.max(var_212_52, arg_209_1.talkMaxDuration)

			if var_212_60 <= arg_209_1.time_ and arg_209_1.time_ < var_212_60 + var_212_61 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_60) / var_212_61

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_60 + var_212_61 and arg_209_1.time_ < var_212_60 + var_212_61 + arg_212_0 then
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
			local var_218_0 = arg_215_1.actors_["1044ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1044ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -1, -5.93)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1044ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1044ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1044ui_story == nil then
				arg_215_1.var_.characterEffect1044ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1044ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1044ui_story then
				arg_215_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action9_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_218_15 = 0
			local var_218_16 = 0.225

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[67].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(322131049)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 9
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131049", "story_v_out_322131.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_322131", "322131049", "story_v_out_322131.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_322131", "322131049", "story_v_out_322131.awb")

						arg_215_1:RecordAudio("322131049", var_218_24)
						arg_215_1:RecordAudio("322131049", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322131", "322131049", "story_v_out_322131.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322131", "322131049", "story_v_out_322131.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
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
			local var_222_0 = arg_219_1.actors_["1044ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1044ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, 100, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1044ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, 100, 0)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = 0
			local var_222_10 = 0.725

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_11 = arg_219_1:GetWordFromCfg(322131050)
				local var_222_12 = arg_219_1:FormatText(var_222_11.content)

				arg_219_1.text_.text = var_222_12

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 29
				local var_222_14 = utf8.len(var_222_12)
				local var_222_15 = var_222_13 <= 0 and var_222_10 or var_222_10 * (var_222_14 / var_222_13)

				if var_222_15 > 0 and var_222_10 < var_222_15 then
					arg_219_1.talkMaxDuration = var_222_15

					if var_222_15 + var_222_9 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_15 + var_222_9
					end
				end

				arg_219_1.text_.text = var_222_12
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_10, arg_219_1.talkMaxDuration)

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_9) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_9 + var_222_16 and arg_219_1.time_ < var_222_9 + var_222_16 + arg_222_0 then
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
			local var_226_0 = 0
			local var_226_1 = 0.875

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(322131051)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 35
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
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
			local var_230_0 = arg_227_1.actors_["1044ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1044ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, -1, -5.93)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1044ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1044ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1044ui_story == nil then
				arg_227_1.var_.characterEffect1044ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1044ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1044ui_story then
				arg_227_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_15 = 0
			local var_230_16 = 0.35

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[67].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_18 = arg_227_1:GetWordFromCfg(322131052)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 14
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131052", "story_v_out_322131.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_322131", "322131052", "story_v_out_322131.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_322131", "322131052", "story_v_out_322131.awb")

						arg_227_1:RecordAudio("322131052", var_230_24)
						arg_227_1:RecordAudio("322131052", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322131", "322131052", "story_v_out_322131.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322131", "322131052", "story_v_out_322131.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
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
			local var_234_0 = 0

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_234_2 = 0
			local var_234_3 = 0.15

			if var_234_2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_4 = arg_231_1:FormatText(StoryNameCfg[67].name)

				arg_231_1.leftNameTxt_.text = var_234_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_5 = arg_231_1:GetWordFromCfg(322131053)
				local var_234_6 = arg_231_1:FormatText(var_234_5.content)

				arg_231_1.text_.text = var_234_6

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 6
				local var_234_8 = utf8.len(var_234_6)
				local var_234_9 = var_234_7 <= 0 and var_234_3 or var_234_3 * (var_234_8 / var_234_7)

				if var_234_9 > 0 and var_234_3 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_6
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131053", "story_v_out_322131.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_322131", "322131053", "story_v_out_322131.awb") / 1000

					if var_234_10 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_2
					end

					if var_234_5.prefab_name ~= "" and arg_231_1.actors_[var_234_5.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_5.prefab_name].transform, "story_v_out_322131", "322131053", "story_v_out_322131.awb")

						arg_231_1:RecordAudio("322131053", var_234_11)
						arg_231_1:RecordAudio("322131053", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_322131", "322131053", "story_v_out_322131.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_322131", "322131053", "story_v_out_322131.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_12 and arg_231_1.time_ < var_234_2 + var_234_12 + arg_234_0 then
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
			local var_238_0 = "10131ui_story"

			if arg_235_1.actors_[var_238_0] == nil then
				local var_238_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_238_1) then
					local var_238_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_235_1.stage_.transform)

					var_238_2.name = var_238_0
					var_238_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_235_1.actors_[var_238_0] = var_238_2

					local var_238_3 = var_238_2:GetComponentInChildren(typeof(CharacterEffect))

					var_238_3.enabled = true

					local var_238_4 = GameObjectTools.GetOrAddComponent(var_238_2, typeof(DynamicBoneHelper))

					if var_238_4 then
						var_238_4:EnableDynamicBone(false)
					end

					arg_235_1:ShowWeapon(var_238_3.transform, false)

					arg_235_1.var_[var_238_0 .. "Animator"] = var_238_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_235_1.var_[var_238_0 .. "Animator"].applyRootMotion = true
					arg_235_1.var_[var_238_0 .. "LipSync"] = var_238_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_238_5 = arg_235_1.actors_["10131ui_story"].transform
			local var_238_6 = 0

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.var_.moveOldPos10131ui_story = var_238_5.localPosition
			end

			local var_238_7 = 0.001

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_7 then
				local var_238_8 = (arg_235_1.time_ - var_238_6) / var_238_7
				local var_238_9 = Vector3.New(0.83, -0.96, -5.8)

				var_238_5.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10131ui_story, var_238_9, var_238_8)

				local var_238_10 = manager.ui.mainCamera.transform.position - var_238_5.position

				var_238_5.forward = Vector3.New(var_238_10.x, var_238_10.y, var_238_10.z)

				local var_238_11 = var_238_5.localEulerAngles

				var_238_11.z = 0
				var_238_11.x = 0
				var_238_5.localEulerAngles = var_238_11
			end

			if arg_235_1.time_ >= var_238_6 + var_238_7 and arg_235_1.time_ < var_238_6 + var_238_7 + arg_238_0 then
				var_238_5.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_238_12 = manager.ui.mainCamera.transform.position - var_238_5.position

				var_238_5.forward = Vector3.New(var_238_12.x, var_238_12.y, var_238_12.z)

				local var_238_13 = var_238_5.localEulerAngles

				var_238_13.z = 0
				var_238_13.x = 0
				var_238_5.localEulerAngles = var_238_13
			end

			local var_238_14 = arg_235_1.actors_["1044ui_story"].transform
			local var_238_15 = 0

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.var_.moveOldPos1044ui_story = var_238_14.localPosition
			end

			local var_238_16 = 0.001

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_16 then
				local var_238_17 = (arg_235_1.time_ - var_238_15) / var_238_16
				local var_238_18 = Vector3.New(-0.7, -1, -5.93)

				var_238_14.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1044ui_story, var_238_18, var_238_17)

				local var_238_19 = manager.ui.mainCamera.transform.position - var_238_14.position

				var_238_14.forward = Vector3.New(var_238_19.x, var_238_19.y, var_238_19.z)

				local var_238_20 = var_238_14.localEulerAngles

				var_238_20.z = 0
				var_238_20.x = 0
				var_238_14.localEulerAngles = var_238_20
			end

			if arg_235_1.time_ >= var_238_15 + var_238_16 and arg_235_1.time_ < var_238_15 + var_238_16 + arg_238_0 then
				var_238_14.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_238_21 = manager.ui.mainCamera.transform.position - var_238_14.position

				var_238_14.forward = Vector3.New(var_238_21.x, var_238_21.y, var_238_21.z)

				local var_238_22 = var_238_14.localEulerAngles

				var_238_22.z = 0
				var_238_22.x = 0
				var_238_14.localEulerAngles = var_238_22
			end

			local var_238_23 = arg_235_1.actors_["10131ui_story"]
			local var_238_24 = 0

			if var_238_24 < arg_235_1.time_ and arg_235_1.time_ <= var_238_24 + arg_238_0 and not isNil(var_238_23) and arg_235_1.var_.characterEffect10131ui_story == nil then
				arg_235_1.var_.characterEffect10131ui_story = var_238_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_25 = 0.200000002980232

			if var_238_24 <= arg_235_1.time_ and arg_235_1.time_ < var_238_24 + var_238_25 and not isNil(var_238_23) then
				local var_238_26 = (arg_235_1.time_ - var_238_24) / var_238_25

				if arg_235_1.var_.characterEffect10131ui_story and not isNil(var_238_23) then
					arg_235_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_24 + var_238_25 and arg_235_1.time_ < var_238_24 + var_238_25 + arg_238_0 and not isNil(var_238_23) and arg_235_1.var_.characterEffect10131ui_story then
				arg_235_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_238_27 = arg_235_1.actors_["1044ui_story"]
			local var_238_28 = 0

			if var_238_28 < arg_235_1.time_ and arg_235_1.time_ <= var_238_28 + arg_238_0 and not isNil(var_238_27) and arg_235_1.var_.characterEffect1044ui_story == nil then
				arg_235_1.var_.characterEffect1044ui_story = var_238_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_29 = 0.200000002980232

			if var_238_28 <= arg_235_1.time_ and arg_235_1.time_ < var_238_28 + var_238_29 and not isNil(var_238_27) then
				local var_238_30 = (arg_235_1.time_ - var_238_28) / var_238_29

				if arg_235_1.var_.characterEffect1044ui_story and not isNil(var_238_27) then
					local var_238_31 = Mathf.Lerp(0, 0.5, var_238_30)

					arg_235_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1044ui_story.fillRatio = var_238_31
				end
			end

			if arg_235_1.time_ >= var_238_28 + var_238_29 and arg_235_1.time_ < var_238_28 + var_238_29 + arg_238_0 and not isNil(var_238_27) and arg_235_1.var_.characterEffect1044ui_story then
				local var_238_32 = 0.5

				arg_235_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1044ui_story.fillRatio = var_238_32
			end

			local var_238_33 = 0

			if var_238_33 < arg_235_1.time_ and arg_235_1.time_ <= var_238_33 + arg_238_0 then
				arg_235_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_238_34 = 0

			if var_238_34 < arg_235_1.time_ and arg_235_1.time_ <= var_238_34 + arg_238_0 then
				arg_235_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_238_35 = 0
			local var_238_36 = 0.85

			if var_238_35 < arg_235_1.time_ and arg_235_1.time_ <= var_238_35 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_37 = arg_235_1:FormatText(StoryNameCfg[1366].name)

				arg_235_1.leftNameTxt_.text = var_238_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_38 = arg_235_1:GetWordFromCfg(322131054)
				local var_238_39 = arg_235_1:FormatText(var_238_38.content)

				arg_235_1.text_.text = var_238_39

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_40 = 34
				local var_238_41 = utf8.len(var_238_39)
				local var_238_42 = var_238_40 <= 0 and var_238_36 or var_238_36 * (var_238_41 / var_238_40)

				if var_238_42 > 0 and var_238_36 < var_238_42 then
					arg_235_1.talkMaxDuration = var_238_42

					if var_238_42 + var_238_35 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_42 + var_238_35
					end
				end

				arg_235_1.text_.text = var_238_39
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131054", "story_v_out_322131.awb") ~= 0 then
					local var_238_43 = manager.audio:GetVoiceLength("story_v_out_322131", "322131054", "story_v_out_322131.awb") / 1000

					if var_238_43 + var_238_35 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_43 + var_238_35
					end

					if var_238_38.prefab_name ~= "" and arg_235_1.actors_[var_238_38.prefab_name] ~= nil then
						local var_238_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_38.prefab_name].transform, "story_v_out_322131", "322131054", "story_v_out_322131.awb")

						arg_235_1:RecordAudio("322131054", var_238_44)
						arg_235_1:RecordAudio("322131054", var_238_44)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_322131", "322131054", "story_v_out_322131.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_322131", "322131054", "story_v_out_322131.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_45 = math.max(var_238_36, arg_235_1.talkMaxDuration)

			if var_238_35 <= arg_235_1.time_ and arg_235_1.time_ < var_238_35 + var_238_45 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_35) / var_238_45

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_35 + var_238_45 and arg_235_1.time_ < var_238_35 + var_238_45 + arg_238_0 then
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
			local var_242_0 = arg_239_1.actors_["1044ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1044ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(-0.7, -1, -5.93)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1044ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1044ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1044ui_story == nil then
				arg_239_1.var_.characterEffect1044ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1044ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1044ui_story then
				arg_239_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_242_13 = arg_239_1.actors_["10131ui_story"]
			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 and not isNil(var_242_13) and arg_239_1.var_.characterEffect10131ui_story == nil then
				arg_239_1.var_.characterEffect10131ui_story = var_242_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_15 = 0.200000002980232

			if var_242_14 <= arg_239_1.time_ and arg_239_1.time_ < var_242_14 + var_242_15 and not isNil(var_242_13) then
				local var_242_16 = (arg_239_1.time_ - var_242_14) / var_242_15

				if arg_239_1.var_.characterEffect10131ui_story and not isNil(var_242_13) then
					local var_242_17 = Mathf.Lerp(0, 0.5, var_242_16)

					arg_239_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10131ui_story.fillRatio = var_242_17
				end
			end

			if arg_239_1.time_ >= var_242_14 + var_242_15 and arg_239_1.time_ < var_242_14 + var_242_15 + arg_242_0 and not isNil(var_242_13) and arg_239_1.var_.characterEffect10131ui_story then
				local var_242_18 = 0.5

				arg_239_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10131ui_story.fillRatio = var_242_18
			end

			local var_242_19 = 0

			if var_242_19 < arg_239_1.time_ and arg_239_1.time_ <= var_242_19 + arg_242_0 then
				arg_239_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_242_20 = 0
			local var_242_21 = 0.25

			if var_242_20 < arg_239_1.time_ and arg_239_1.time_ <= var_242_20 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_22 = arg_239_1:FormatText(StoryNameCfg[67].name)

				arg_239_1.leftNameTxt_.text = var_242_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_23 = arg_239_1:GetWordFromCfg(322131055)
				local var_242_24 = arg_239_1:FormatText(var_242_23.content)

				arg_239_1.text_.text = var_242_24

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_25 = 10
				local var_242_26 = utf8.len(var_242_24)
				local var_242_27 = var_242_25 <= 0 and var_242_21 or var_242_21 * (var_242_26 / var_242_25)

				if var_242_27 > 0 and var_242_21 < var_242_27 then
					arg_239_1.talkMaxDuration = var_242_27

					if var_242_27 + var_242_20 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_27 + var_242_20
					end
				end

				arg_239_1.text_.text = var_242_24
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131055", "story_v_out_322131.awb") ~= 0 then
					local var_242_28 = manager.audio:GetVoiceLength("story_v_out_322131", "322131055", "story_v_out_322131.awb") / 1000

					if var_242_28 + var_242_20 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_28 + var_242_20
					end

					if var_242_23.prefab_name ~= "" and arg_239_1.actors_[var_242_23.prefab_name] ~= nil then
						local var_242_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_23.prefab_name].transform, "story_v_out_322131", "322131055", "story_v_out_322131.awb")

						arg_239_1:RecordAudio("322131055", var_242_29)
						arg_239_1:RecordAudio("322131055", var_242_29)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322131", "322131055", "story_v_out_322131.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322131", "322131055", "story_v_out_322131.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_30 = math.max(var_242_21, arg_239_1.talkMaxDuration)

			if var_242_20 <= arg_239_1.time_ and arg_239_1.time_ < var_242_20 + var_242_30 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_20) / var_242_30

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_20 + var_242_30 and arg_239_1.time_ < var_242_20 + var_242_30 + arg_242_0 then
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
			local var_246_0 = arg_243_1.actors_["10131ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect10131ui_story == nil then
				arg_243_1.var_.characterEffect10131ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect10131ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect10131ui_story then
				arg_243_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_246_4 = arg_243_1.actors_["1044ui_story"]
			local var_246_5 = 0

			if var_246_5 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect1044ui_story == nil then
				arg_243_1.var_.characterEffect1044ui_story = var_246_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_6 = 0.200000002980232

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_6 and not isNil(var_246_4) then
				local var_246_7 = (arg_243_1.time_ - var_246_5) / var_246_6

				if arg_243_1.var_.characterEffect1044ui_story and not isNil(var_246_4) then
					local var_246_8 = Mathf.Lerp(0, 0.5, var_246_7)

					arg_243_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1044ui_story.fillRatio = var_246_8
				end
			end

			if arg_243_1.time_ >= var_246_5 + var_246_6 and arg_243_1.time_ < var_246_5 + var_246_6 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect1044ui_story then
				local var_246_9 = 0.5

				arg_243_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1044ui_story.fillRatio = var_246_9
			end

			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			local var_246_11 = 0

			if var_246_11 < arg_243_1.time_ and arg_243_1.time_ <= var_246_11 + arg_246_0 then
				arg_243_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_12 = 0
			local var_246_13 = 0.35

			if var_246_12 < arg_243_1.time_ and arg_243_1.time_ <= var_246_12 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_14 = arg_243_1:FormatText(StoryNameCfg[1366].name)

				arg_243_1.leftNameTxt_.text = var_246_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_15 = arg_243_1:GetWordFromCfg(322131056)
				local var_246_16 = arg_243_1:FormatText(var_246_15.content)

				arg_243_1.text_.text = var_246_16

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_17 = 14
				local var_246_18 = utf8.len(var_246_16)
				local var_246_19 = var_246_17 <= 0 and var_246_13 or var_246_13 * (var_246_18 / var_246_17)

				if var_246_19 > 0 and var_246_13 < var_246_19 then
					arg_243_1.talkMaxDuration = var_246_19

					if var_246_19 + var_246_12 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_19 + var_246_12
					end
				end

				arg_243_1.text_.text = var_246_16
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131056", "story_v_out_322131.awb") ~= 0 then
					local var_246_20 = manager.audio:GetVoiceLength("story_v_out_322131", "322131056", "story_v_out_322131.awb") / 1000

					if var_246_20 + var_246_12 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_20 + var_246_12
					end

					if var_246_15.prefab_name ~= "" and arg_243_1.actors_[var_246_15.prefab_name] ~= nil then
						local var_246_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_15.prefab_name].transform, "story_v_out_322131", "322131056", "story_v_out_322131.awb")

						arg_243_1:RecordAudio("322131056", var_246_21)
						arg_243_1:RecordAudio("322131056", var_246_21)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_322131", "322131056", "story_v_out_322131.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_322131", "322131056", "story_v_out_322131.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_22 = math.max(var_246_13, arg_243_1.talkMaxDuration)

			if var_246_12 <= arg_243_1.time_ and arg_243_1.time_ < var_246_12 + var_246_22 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_12) / var_246_22

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_12 + var_246_22 and arg_243_1.time_ < var_246_12 + var_246_22 + arg_246_0 then
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
			local var_250_0 = arg_247_1.actors_["1044ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1044ui_story == nil then
				arg_247_1.var_.characterEffect1044ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1044ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1044ui_story then
				arg_247_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["10131ui_story"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect10131ui_story == nil then
				arg_247_1.var_.characterEffect10131ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.characterEffect10131ui_story and not isNil(var_250_4) then
					local var_250_8 = Mathf.Lerp(0, 0.5, var_250_7)

					arg_247_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10131ui_story.fillRatio = var_250_8
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect10131ui_story then
				local var_250_9 = 0.5

				arg_247_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10131ui_story.fillRatio = var_250_9
			end

			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_250_11 = 0
			local var_250_12 = 0.05

			if var_250_11 < arg_247_1.time_ and arg_247_1.time_ <= var_250_11 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_13 = arg_247_1:FormatText(StoryNameCfg[67].name)

				arg_247_1.leftNameTxt_.text = var_250_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_14 = arg_247_1:GetWordFromCfg(322131057)
				local var_250_15 = arg_247_1:FormatText(var_250_14.content)

				arg_247_1.text_.text = var_250_15

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_16 = 2
				local var_250_17 = utf8.len(var_250_15)
				local var_250_18 = var_250_16 <= 0 and var_250_12 or var_250_12 * (var_250_17 / var_250_16)

				if var_250_18 > 0 and var_250_12 < var_250_18 then
					arg_247_1.talkMaxDuration = var_250_18

					if var_250_18 + var_250_11 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_11
					end
				end

				arg_247_1.text_.text = var_250_15
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131057", "story_v_out_322131.awb") ~= 0 then
					local var_250_19 = manager.audio:GetVoiceLength("story_v_out_322131", "322131057", "story_v_out_322131.awb") / 1000

					if var_250_19 + var_250_11 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_19 + var_250_11
					end

					if var_250_14.prefab_name ~= "" and arg_247_1.actors_[var_250_14.prefab_name] ~= nil then
						local var_250_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_14.prefab_name].transform, "story_v_out_322131", "322131057", "story_v_out_322131.awb")

						arg_247_1:RecordAudio("322131057", var_250_20)
						arg_247_1:RecordAudio("322131057", var_250_20)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_322131", "322131057", "story_v_out_322131.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_322131", "322131057", "story_v_out_322131.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_21 = math.max(var_250_12, arg_247_1.talkMaxDuration)

			if var_250_11 <= arg_247_1.time_ and arg_247_1.time_ < var_250_11 + var_250_21 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_11) / var_250_21

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_11 + var_250_21 and arg_247_1.time_ < var_250_11 + var_250_21 + arg_250_0 then
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
			local var_254_0 = arg_251_1.actors_["1044ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1044ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0, 100, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1044ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, 100, 0)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["10131ui_story"].transform
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1.var_.moveOldPos10131ui_story = var_254_9.localPosition
			end

			local var_254_11 = 0.001

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11
				local var_254_13 = Vector3.New(0, 100, 0)

				var_254_9.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10131ui_story, var_254_13, var_254_12)

				local var_254_14 = manager.ui.mainCamera.transform.position - var_254_9.position

				var_254_9.forward = Vector3.New(var_254_14.x, var_254_14.y, var_254_14.z)

				local var_254_15 = var_254_9.localEulerAngles

				var_254_15.z = 0
				var_254_15.x = 0
				var_254_9.localEulerAngles = var_254_15
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 then
				var_254_9.localPosition = Vector3.New(0, 100, 0)

				local var_254_16 = manager.ui.mainCamera.transform.position - var_254_9.position

				var_254_9.forward = Vector3.New(var_254_16.x, var_254_16.y, var_254_16.z)

				local var_254_17 = var_254_9.localEulerAngles

				var_254_17.z = 0
				var_254_17.x = 0
				var_254_9.localEulerAngles = var_254_17
			end

			local var_254_18 = manager.ui.mainCamera.transform
			local var_254_19 = 0

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				local var_254_20 = arg_251_1.var_.effect1058
				local var_254_21
				local var_254_22 = var_254_18

				if not var_254_20 then
					var_254_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_254_22)
					var_254_20.name = "1058"
					arg_251_1.var_.effect1058 = var_254_20
				else
					var_254_20.transform:SetParent(var_254_22)
				end

				var_254_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_254_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_254_23 = manager.ui.mainCamera.transform
			local var_254_24 = 2.33333333333333

			if var_254_24 < arg_251_1.time_ and arg_251_1.time_ <= var_254_24 + arg_254_0 then
				local var_254_25 = arg_251_1.var_.effect1058

				if var_254_25 then
					Object.Destroy(var_254_25)

					arg_251_1.var_.effect1058 = nil
				end
			end

			local var_254_26 = manager.ui.mainCamera.transform
			local var_254_27 = 0.034000001847744

			if var_254_27 < arg_251_1.time_ and arg_251_1.time_ <= var_254_27 + arg_254_0 then
				arg_251_1.var_.shakeOldPos = var_254_26.localPosition
			end

			local var_254_28 = 0.566666666666667

			if var_254_27 <= arg_251_1.time_ and arg_251_1.time_ < var_254_27 + var_254_28 then
				local var_254_29 = (arg_251_1.time_ - var_254_27) / 0.099
				local var_254_30, var_254_31 = math.modf(var_254_29)

				var_254_26.localPosition = Vector3.New(var_254_31 * 0.1, var_254_31 * 0.1, var_254_31 * 0.1) + arg_251_1.var_.shakeOldPos
			end

			if arg_251_1.time_ >= var_254_27 + var_254_28 and arg_251_1.time_ < var_254_27 + var_254_28 + arg_254_0 then
				var_254_26.localPosition = arg_251_1.var_.shakeOldPos
			end

			local var_254_32 = 0
			local var_254_33 = 1

			if var_254_32 < arg_251_1.time_ and arg_251_1.time_ <= var_254_32 + arg_254_0 then
				local var_254_34 = "play"
				local var_254_35 = "effect"

				arg_251_1:AudioAction(var_254_34, var_254_35, "se_story_145", "se_story_145_attack", "")
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_36 = 0.733333333333333
			local var_254_37 = 1.1

			if var_254_36 < arg_251_1.time_ and arg_251_1.time_ <= var_254_36 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_38 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_38:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_39 = arg_251_1:GetWordFromCfg(322131058)
				local var_254_40 = arg_251_1:FormatText(var_254_39.content)

				arg_251_1.text_.text = var_254_40

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_41 = 44
				local var_254_42 = utf8.len(var_254_40)
				local var_254_43 = var_254_41 <= 0 and var_254_37 or var_254_37 * (var_254_42 / var_254_41)

				if var_254_43 > 0 and var_254_37 < var_254_43 then
					arg_251_1.talkMaxDuration = var_254_43
					var_254_36 = var_254_36 + 0.3

					if var_254_43 + var_254_36 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_43 + var_254_36
					end
				end

				arg_251_1.text_.text = var_254_40
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_44 = var_254_36 + 0.3
			local var_254_45 = math.max(var_254_37, arg_251_1.talkMaxDuration)

			if var_254_44 <= arg_251_1.time_ and arg_251_1.time_ < var_254_44 + var_254_45 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_44) / var_254_45

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_44 + var_254_45 and arg_251_1.time_ < var_254_44 + var_254_45 + arg_254_0 then
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
			local var_260_0 = 0
			local var_260_1 = 1.175

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(322131059)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 47
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
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
			local var_264_0 = 0
			local var_264_1 = 1.225

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_2 = arg_261_1:GetWordFromCfg(322131060)
				local var_264_3 = arg_261_1:FormatText(var_264_2.content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 49
				local var_264_5 = utf8.len(var_264_3)
				local var_264_6 = var_264_4 <= 0 and var_264_1 or var_264_1 * (var_264_5 / var_264_4)

				if var_264_6 > 0 and var_264_1 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_7 and arg_261_1.time_ < var_264_0 + var_264_7 + arg_264_0 then
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
			local var_268_0 = arg_265_1.actors_["1044ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1044ui_story = var_268_0.localPosition

				local var_268_2 = "1044ui_story"

				arg_265_1:ShowWeapon(arg_265_1.var_[var_268_2 .. "Animator"].transform, false)
			end

			local var_268_3 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_3 then
				local var_268_4 = (arg_265_1.time_ - var_268_1) / var_268_3
				local var_268_5 = Vector3.New(-0.7, -1, -5.93)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1044ui_story, var_268_5, var_268_4)

				local var_268_6 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_6.x, var_268_6.y, var_268_6.z)

				local var_268_7 = var_268_0.localEulerAngles

				var_268_7.z = 0
				var_268_7.x = 0
				var_268_0.localEulerAngles = var_268_7
			end

			if arg_265_1.time_ >= var_268_1 + var_268_3 and arg_265_1.time_ < var_268_1 + var_268_3 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_268_8 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_8.x, var_268_8.y, var_268_8.z)

				local var_268_9 = var_268_0.localEulerAngles

				var_268_9.z = 0
				var_268_9.x = 0
				var_268_0.localEulerAngles = var_268_9
			end

			local var_268_10 = arg_265_1.actors_["1044ui_story"]
			local var_268_11 = 0

			if var_268_11 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 and not isNil(var_268_10) and arg_265_1.var_.characterEffect1044ui_story == nil then
				arg_265_1.var_.characterEffect1044ui_story = var_268_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_12 = 0.200000002980232

			if var_268_11 <= arg_265_1.time_ and arg_265_1.time_ < var_268_11 + var_268_12 and not isNil(var_268_10) then
				local var_268_13 = (arg_265_1.time_ - var_268_11) / var_268_12

				if arg_265_1.var_.characterEffect1044ui_story and not isNil(var_268_10) then
					arg_265_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_11 + var_268_12 and arg_265_1.time_ < var_268_11 + var_268_12 + arg_268_0 and not isNil(var_268_10) and arg_265_1.var_.characterEffect1044ui_story then
				arg_265_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_268_15 = 0

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_268_16 = 0
			local var_268_17 = 0.525

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_18 = arg_265_1:FormatText(StoryNameCfg[67].name)

				arg_265_1.leftNameTxt_.text = var_268_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_19 = arg_265_1:GetWordFromCfg(322131061)
				local var_268_20 = arg_265_1:FormatText(var_268_19.content)

				arg_265_1.text_.text = var_268_20

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_21 = 21
				local var_268_22 = utf8.len(var_268_20)
				local var_268_23 = var_268_21 <= 0 and var_268_17 or var_268_17 * (var_268_22 / var_268_21)

				if var_268_23 > 0 and var_268_17 < var_268_23 then
					arg_265_1.talkMaxDuration = var_268_23

					if var_268_23 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_16
					end
				end

				arg_265_1.text_.text = var_268_20
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131061", "story_v_out_322131.awb") ~= 0 then
					local var_268_24 = manager.audio:GetVoiceLength("story_v_out_322131", "322131061", "story_v_out_322131.awb") / 1000

					if var_268_24 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_24 + var_268_16
					end

					if var_268_19.prefab_name ~= "" and arg_265_1.actors_[var_268_19.prefab_name] ~= nil then
						local var_268_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_19.prefab_name].transform, "story_v_out_322131", "322131061", "story_v_out_322131.awb")

						arg_265_1:RecordAudio("322131061", var_268_25)
						arg_265_1:RecordAudio("322131061", var_268_25)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322131", "322131061", "story_v_out_322131.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322131", "322131061", "story_v_out_322131.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_26 = math.max(var_268_17, arg_265_1.talkMaxDuration)

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_26 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_16) / var_268_26

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_16 + var_268_26 and arg_265_1.time_ < var_268_16 + var_268_26 + arg_268_0 then
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
			local var_272_0 = arg_269_1.actors_["1043ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1043ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0.81, -1.01, -5.73)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1043ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1043ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1043ui_story == nil then
				arg_269_1.var_.characterEffect1043ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1043ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1043ui_story then
				arg_269_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_272_13 = arg_269_1.actors_["1044ui_story"]
			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 and not isNil(var_272_13) and arg_269_1.var_.characterEffect1044ui_story == nil then
				arg_269_1.var_.characterEffect1044ui_story = var_272_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_15 = 0.200000002980232

			if var_272_14 <= arg_269_1.time_ and arg_269_1.time_ < var_272_14 + var_272_15 and not isNil(var_272_13) then
				local var_272_16 = (arg_269_1.time_ - var_272_14) / var_272_15

				if arg_269_1.var_.characterEffect1044ui_story and not isNil(var_272_13) then
					local var_272_17 = Mathf.Lerp(0, 0.5, var_272_16)

					arg_269_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1044ui_story.fillRatio = var_272_17
				end
			end

			if arg_269_1.time_ >= var_272_14 + var_272_15 and arg_269_1.time_ < var_272_14 + var_272_15 + arg_272_0 and not isNil(var_272_13) and arg_269_1.var_.characterEffect1044ui_story then
				local var_272_18 = 0.5

				arg_269_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1044ui_story.fillRatio = var_272_18
			end

			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			local var_272_20 = 0

			if var_272_20 < arg_269_1.time_ and arg_269_1.time_ <= var_272_20 + arg_272_0 then
				arg_269_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_21 = 0
			local var_272_22 = 0.175

			if var_272_21 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_23 = arg_269_1:FormatText(StoryNameCfg[1156].name)

				arg_269_1.leftNameTxt_.text = var_272_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_24 = arg_269_1:GetWordFromCfg(322131062)
				local var_272_25 = arg_269_1:FormatText(var_272_24.content)

				arg_269_1.text_.text = var_272_25

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_26 = 7
				local var_272_27 = utf8.len(var_272_25)
				local var_272_28 = var_272_26 <= 0 and var_272_22 or var_272_22 * (var_272_27 / var_272_26)

				if var_272_28 > 0 and var_272_22 < var_272_28 then
					arg_269_1.talkMaxDuration = var_272_28

					if var_272_28 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_28 + var_272_21
					end
				end

				arg_269_1.text_.text = var_272_25
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131062", "story_v_out_322131.awb") ~= 0 then
					local var_272_29 = manager.audio:GetVoiceLength("story_v_out_322131", "322131062", "story_v_out_322131.awb") / 1000

					if var_272_29 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_29 + var_272_21
					end

					if var_272_24.prefab_name ~= "" and arg_269_1.actors_[var_272_24.prefab_name] ~= nil then
						local var_272_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_24.prefab_name].transform, "story_v_out_322131", "322131062", "story_v_out_322131.awb")

						arg_269_1:RecordAudio("322131062", var_272_30)
						arg_269_1:RecordAudio("322131062", var_272_30)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322131", "322131062", "story_v_out_322131.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322131", "322131062", "story_v_out_322131.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_31 = math.max(var_272_22, arg_269_1.talkMaxDuration)

			if var_272_21 <= arg_269_1.time_ and arg_269_1.time_ < var_272_21 + var_272_31 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_21) / var_272_31

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_21 + var_272_31 and arg_269_1.time_ < var_272_21 + var_272_31 + arg_272_0 then
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
			local var_276_0 = arg_273_1.actors_["1044ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1044ui_story == nil then
				arg_273_1.var_.characterEffect1044ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1044ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1044ui_story then
				arg_273_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["1043ui_story"]
			local var_276_5 = 0

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1043ui_story == nil then
				arg_273_1.var_.characterEffect1043ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_6 = 0.200000002980232

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_6 and not isNil(var_276_4) then
				local var_276_7 = (arg_273_1.time_ - var_276_5) / var_276_6

				if arg_273_1.var_.characterEffect1043ui_story and not isNil(var_276_4) then
					local var_276_8 = Mathf.Lerp(0, 0.5, var_276_7)

					arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1043ui_story.fillRatio = var_276_8
				end
			end

			if arg_273_1.time_ >= var_276_5 + var_276_6 and arg_273_1.time_ < var_276_5 + var_276_6 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1043ui_story then
				local var_276_9 = 0.5

				arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1043ui_story.fillRatio = var_276_9
			end

			local var_276_10 = 0
			local var_276_11 = 0.425

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_12 = arg_273_1:FormatText(StoryNameCfg[67].name)

				arg_273_1.leftNameTxt_.text = var_276_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_13 = arg_273_1:GetWordFromCfg(322131063)
				local var_276_14 = arg_273_1:FormatText(var_276_13.content)

				arg_273_1.text_.text = var_276_14

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_15 = 17
				local var_276_16 = utf8.len(var_276_14)
				local var_276_17 = var_276_15 <= 0 and var_276_11 or var_276_11 * (var_276_16 / var_276_15)

				if var_276_17 > 0 and var_276_11 < var_276_17 then
					arg_273_1.talkMaxDuration = var_276_17

					if var_276_17 + var_276_10 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_17 + var_276_10
					end
				end

				arg_273_1.text_.text = var_276_14
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131063", "story_v_out_322131.awb") ~= 0 then
					local var_276_18 = manager.audio:GetVoiceLength("story_v_out_322131", "322131063", "story_v_out_322131.awb") / 1000

					if var_276_18 + var_276_10 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_18 + var_276_10
					end

					if var_276_13.prefab_name ~= "" and arg_273_1.actors_[var_276_13.prefab_name] ~= nil then
						local var_276_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_13.prefab_name].transform, "story_v_out_322131", "322131063", "story_v_out_322131.awb")

						arg_273_1:RecordAudio("322131063", var_276_19)
						arg_273_1:RecordAudio("322131063", var_276_19)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322131", "322131063", "story_v_out_322131.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322131", "322131063", "story_v_out_322131.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_20 = math.max(var_276_11, arg_273_1.talkMaxDuration)

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_20 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_10) / var_276_20

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_10 + var_276_20 and arg_273_1.time_ < var_276_10 + var_276_20 + arg_276_0 then
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
			local var_280_0 = arg_277_1.actors_["1043ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1043ui_story == nil then
				arg_277_1.var_.characterEffect1043ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1043ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1043ui_story then
				arg_277_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["1044ui_story"]
			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1044ui_story == nil then
				arg_277_1.var_.characterEffect1044ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_6 = 0.200000002980232

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_6 and not isNil(var_280_4) then
				local var_280_7 = (arg_277_1.time_ - var_280_5) / var_280_6

				if arg_277_1.var_.characterEffect1044ui_story and not isNil(var_280_4) then
					local var_280_8 = Mathf.Lerp(0, 0.5, var_280_7)

					arg_277_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1044ui_story.fillRatio = var_280_8
				end
			end

			if arg_277_1.time_ >= var_280_5 + var_280_6 and arg_277_1.time_ < var_280_5 + var_280_6 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1044ui_story then
				local var_280_9 = 0.5

				arg_277_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1044ui_story.fillRatio = var_280_9
			end

			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_280_11 = 0

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				arg_277_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_12 = 0
			local var_280_13 = 0.375

			if var_280_12 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_14 = arg_277_1:FormatText(StoryNameCfg[1156].name)

				arg_277_1.leftNameTxt_.text = var_280_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_15 = arg_277_1:GetWordFromCfg(322131064)
				local var_280_16 = arg_277_1:FormatText(var_280_15.content)

				arg_277_1.text_.text = var_280_16

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_17 = 15
				local var_280_18 = utf8.len(var_280_16)
				local var_280_19 = var_280_17 <= 0 and var_280_13 or var_280_13 * (var_280_18 / var_280_17)

				if var_280_19 > 0 and var_280_13 < var_280_19 then
					arg_277_1.talkMaxDuration = var_280_19

					if var_280_19 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_19 + var_280_12
					end
				end

				arg_277_1.text_.text = var_280_16
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131064", "story_v_out_322131.awb") ~= 0 then
					local var_280_20 = manager.audio:GetVoiceLength("story_v_out_322131", "322131064", "story_v_out_322131.awb") / 1000

					if var_280_20 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_20 + var_280_12
					end

					if var_280_15.prefab_name ~= "" and arg_277_1.actors_[var_280_15.prefab_name] ~= nil then
						local var_280_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_15.prefab_name].transform, "story_v_out_322131", "322131064", "story_v_out_322131.awb")

						arg_277_1:RecordAudio("322131064", var_280_21)
						arg_277_1:RecordAudio("322131064", var_280_21)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322131", "322131064", "story_v_out_322131.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322131", "322131064", "story_v_out_322131.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_22 = math.max(var_280_13, arg_277_1.talkMaxDuration)

			if var_280_12 <= arg_277_1.time_ and arg_277_1.time_ < var_280_12 + var_280_22 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_12) / var_280_22

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_12 + var_280_22 and arg_277_1.time_ < var_280_12 + var_280_22 + arg_280_0 then
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
			local var_284_0 = 0
			local var_284_1 = 0.45

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[1156].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(322131065)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 18
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131065", "story_v_out_322131.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_322131", "322131065", "story_v_out_322131.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_322131", "322131065", "story_v_out_322131.awb")

						arg_281_1:RecordAudio("322131065", var_284_9)
						arg_281_1:RecordAudio("322131065", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322131", "322131065", "story_v_out_322131.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322131", "322131065", "story_v_out_322131.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
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
			local var_288_0 = arg_285_1.actors_["1044ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1044ui_story == nil then
				arg_285_1.var_.characterEffect1044ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1044ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1044ui_story then
				arg_285_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["1043ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1043ui_story == nil then
				arg_285_1.var_.characterEffect1043ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect1043ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1043ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1043ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1043ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			local var_288_11 = 0
			local var_288_12 = 0.475

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_13 = arg_285_1:FormatText(StoryNameCfg[67].name)

				arg_285_1.leftNameTxt_.text = var_288_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_14 = arg_285_1:GetWordFromCfg(322131066)
				local var_288_15 = arg_285_1:FormatText(var_288_14.content)

				arg_285_1.text_.text = var_288_15

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_16 = 19
				local var_288_17 = utf8.len(var_288_15)
				local var_288_18 = var_288_16 <= 0 and var_288_12 or var_288_12 * (var_288_17 / var_288_16)

				if var_288_18 > 0 and var_288_12 < var_288_18 then
					arg_285_1.talkMaxDuration = var_288_18

					if var_288_18 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_11
					end
				end

				arg_285_1.text_.text = var_288_15
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131066", "story_v_out_322131.awb") ~= 0 then
					local var_288_19 = manager.audio:GetVoiceLength("story_v_out_322131", "322131066", "story_v_out_322131.awb") / 1000

					if var_288_19 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_19 + var_288_11
					end

					if var_288_14.prefab_name ~= "" and arg_285_1.actors_[var_288_14.prefab_name] ~= nil then
						local var_288_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_14.prefab_name].transform, "story_v_out_322131", "322131066", "story_v_out_322131.awb")

						arg_285_1:RecordAudio("322131066", var_288_20)
						arg_285_1:RecordAudio("322131066", var_288_20)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322131", "322131066", "story_v_out_322131.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322131", "322131066", "story_v_out_322131.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_21 = math.max(var_288_12, arg_285_1.talkMaxDuration)

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_21 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_11) / var_288_21

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_11 + var_288_21 and arg_285_1.time_ < var_288_11 + var_288_21 + arg_288_0 then
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
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_292_1 = 0
			local var_292_2 = 0.425

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_3 = arg_289_1:FormatText(StoryNameCfg[67].name)

				arg_289_1.leftNameTxt_.text = var_292_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(322131067)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_6 = 17
				local var_292_7 = utf8.len(var_292_5)
				local var_292_8 = var_292_6 <= 0 and var_292_2 or var_292_2 * (var_292_7 / var_292_6)

				if var_292_8 > 0 and var_292_2 < var_292_8 then
					arg_289_1.talkMaxDuration = var_292_8

					if var_292_8 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131067", "story_v_out_322131.awb") ~= 0 then
					local var_292_9 = manager.audio:GetVoiceLength("story_v_out_322131", "322131067", "story_v_out_322131.awb") / 1000

					if var_292_9 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_1
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_322131", "322131067", "story_v_out_322131.awb")

						arg_289_1:RecordAudio("322131067", var_292_10)
						arg_289_1:RecordAudio("322131067", var_292_10)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322131", "322131067", "story_v_out_322131.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322131", "322131067", "story_v_out_322131.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_11 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_11 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_11

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_11 and arg_289_1.time_ < var_292_1 + var_292_11 + arg_292_0 then
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
			local var_296_0 = arg_293_1.actors_["1043ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1043ui_story == nil then
				arg_293_1.var_.characterEffect1043ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1043ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1043ui_story then
				arg_293_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["1044ui_story"]
			local var_296_5 = 0

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1044ui_story == nil then
				arg_293_1.var_.characterEffect1044ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_6 = 0.200000002980232

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_6 and not isNil(var_296_4) then
				local var_296_7 = (arg_293_1.time_ - var_296_5) / var_296_6

				if arg_293_1.var_.characterEffect1044ui_story and not isNil(var_296_4) then
					local var_296_8 = Mathf.Lerp(0, 0.5, var_296_7)

					arg_293_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1044ui_story.fillRatio = var_296_8
				end
			end

			if arg_293_1.time_ >= var_296_5 + var_296_6 and arg_293_1.time_ < var_296_5 + var_296_6 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1044ui_story then
				local var_296_9 = 0.5

				arg_293_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1044ui_story.fillRatio = var_296_9
			end

			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_296_11 = 0
			local var_296_12 = 0.225

			if var_296_11 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_13 = arg_293_1:FormatText(StoryNameCfg[1156].name)

				arg_293_1.leftNameTxt_.text = var_296_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_14 = arg_293_1:GetWordFromCfg(322131068)
				local var_296_15 = arg_293_1:FormatText(var_296_14.content)

				arg_293_1.text_.text = var_296_15

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_16 = 9
				local var_296_17 = utf8.len(var_296_15)
				local var_296_18 = var_296_16 <= 0 and var_296_12 or var_296_12 * (var_296_17 / var_296_16)

				if var_296_18 > 0 and var_296_12 < var_296_18 then
					arg_293_1.talkMaxDuration = var_296_18

					if var_296_18 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_11
					end
				end

				arg_293_1.text_.text = var_296_15
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131068", "story_v_out_322131.awb") ~= 0 then
					local var_296_19 = manager.audio:GetVoiceLength("story_v_out_322131", "322131068", "story_v_out_322131.awb") / 1000

					if var_296_19 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_19 + var_296_11
					end

					if var_296_14.prefab_name ~= "" and arg_293_1.actors_[var_296_14.prefab_name] ~= nil then
						local var_296_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_14.prefab_name].transform, "story_v_out_322131", "322131068", "story_v_out_322131.awb")

						arg_293_1:RecordAudio("322131068", var_296_20)
						arg_293_1:RecordAudio("322131068", var_296_20)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322131", "322131068", "story_v_out_322131.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322131", "322131068", "story_v_out_322131.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_21 = math.max(var_296_12, arg_293_1.talkMaxDuration)

			if var_296_11 <= arg_293_1.time_ and arg_293_1.time_ < var_296_11 + var_296_21 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_11) / var_296_21

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_11 + var_296_21 and arg_293_1.time_ < var_296_11 + var_296_21 + arg_296_0 then
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
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_300_1 = 0
			local var_300_2 = 0.55

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_3 = arg_297_1:FormatText(StoryNameCfg[1156].name)

				arg_297_1.leftNameTxt_.text = var_300_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(322131069)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_6 = 22
				local var_300_7 = utf8.len(var_300_5)
				local var_300_8 = var_300_6 <= 0 and var_300_2 or var_300_2 * (var_300_7 / var_300_6)

				if var_300_8 > 0 and var_300_2 < var_300_8 then
					arg_297_1.talkMaxDuration = var_300_8

					if var_300_8 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131069", "story_v_out_322131.awb") ~= 0 then
					local var_300_9 = manager.audio:GetVoiceLength("story_v_out_322131", "322131069", "story_v_out_322131.awb") / 1000

					if var_300_9 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_1
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_322131", "322131069", "story_v_out_322131.awb")

						arg_297_1:RecordAudio("322131069", var_300_10)
						arg_297_1:RecordAudio("322131069", var_300_10)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322131", "322131069", "story_v_out_322131.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322131", "322131069", "story_v_out_322131.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_11 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_11 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_11

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_11 and arg_297_1.time_ < var_300_1 + var_300_11 + arg_300_0 then
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
			local var_304_0 = arg_301_1.actors_["1044ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1044ui_story == nil then
				arg_301_1.var_.characterEffect1044ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1044ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1044ui_story then
				arg_301_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_304_4 = arg_301_1.actors_["1043ui_story"]
			local var_304_5 = 0

			if var_304_5 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect1043ui_story == nil then
				arg_301_1.var_.characterEffect1043ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_6 = 0.200000002980232

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_6 and not isNil(var_304_4) then
				local var_304_7 = (arg_301_1.time_ - var_304_5) / var_304_6

				if arg_301_1.var_.characterEffect1043ui_story and not isNil(var_304_4) then
					local var_304_8 = Mathf.Lerp(0, 0.5, var_304_7)

					arg_301_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1043ui_story.fillRatio = var_304_8
				end
			end

			if arg_301_1.time_ >= var_304_5 + var_304_6 and arg_301_1.time_ < var_304_5 + var_304_6 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect1043ui_story then
				local var_304_9 = 0.5

				arg_301_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1043ui_story.fillRatio = var_304_9
			end

			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 then
				arg_301_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_304_11 = 0
			local var_304_12 = 0.75

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_13 = arg_301_1:FormatText(StoryNameCfg[67].name)

				arg_301_1.leftNameTxt_.text = var_304_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_14 = arg_301_1:GetWordFromCfg(322131070)
				local var_304_15 = arg_301_1:FormatText(var_304_14.content)

				arg_301_1.text_.text = var_304_15

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_16 = 30
				local var_304_17 = utf8.len(var_304_15)
				local var_304_18 = var_304_16 <= 0 and var_304_12 or var_304_12 * (var_304_17 / var_304_16)

				if var_304_18 > 0 and var_304_12 < var_304_18 then
					arg_301_1.talkMaxDuration = var_304_18

					if var_304_18 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_18 + var_304_11
					end
				end

				arg_301_1.text_.text = var_304_15
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131070", "story_v_out_322131.awb") ~= 0 then
					local var_304_19 = manager.audio:GetVoiceLength("story_v_out_322131", "322131070", "story_v_out_322131.awb") / 1000

					if var_304_19 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_11
					end

					if var_304_14.prefab_name ~= "" and arg_301_1.actors_[var_304_14.prefab_name] ~= nil then
						local var_304_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_14.prefab_name].transform, "story_v_out_322131", "322131070", "story_v_out_322131.awb")

						arg_301_1:RecordAudio("322131070", var_304_20)
						arg_301_1:RecordAudio("322131070", var_304_20)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322131", "322131070", "story_v_out_322131.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322131", "322131070", "story_v_out_322131.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_21 = math.max(var_304_12, arg_301_1.talkMaxDuration)

			if var_304_11 <= arg_301_1.time_ and arg_301_1.time_ < var_304_11 + var_304_21 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_11) / var_304_21

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_11 + var_304_21 and arg_301_1.time_ < var_304_11 + var_304_21 + arg_304_0 then
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
			local var_308_0 = "1111ui_story"

			if arg_305_1.actors_[var_308_0] == nil then
				local var_308_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_308_1) then
					local var_308_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_305_1.stage_.transform)

					var_308_2.name = var_308_0
					var_308_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_305_1.actors_[var_308_0] = var_308_2

					local var_308_3 = var_308_2:GetComponentInChildren(typeof(CharacterEffect))

					var_308_3.enabled = true

					local var_308_4 = GameObjectTools.GetOrAddComponent(var_308_2, typeof(DynamicBoneHelper))

					if var_308_4 then
						var_308_4:EnableDynamicBone(false)
					end

					arg_305_1:ShowWeapon(var_308_3.transform, false)

					arg_305_1.var_[var_308_0 .. "Animator"] = var_308_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_305_1.var_[var_308_0 .. "Animator"].applyRootMotion = true
					arg_305_1.var_[var_308_0 .. "LipSync"] = var_308_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_308_5 = 0

			if var_308_5 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_308_6 = 0
			local var_308_7 = 0.85

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[67].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_9 = arg_305_1:GetWordFromCfg(322131071)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 34
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131071", "story_v_out_322131.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_322131", "322131071", "story_v_out_322131.awb") / 1000

					if var_308_14 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_6
					end

					if var_308_9.prefab_name ~= "" and arg_305_1.actors_[var_308_9.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_9.prefab_name].transform, "story_v_out_322131", "322131071", "story_v_out_322131.awb")

						arg_305_1:RecordAudio("322131071", var_308_15)
						arg_305_1:RecordAudio("322131071", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322131", "322131071", "story_v_out_322131.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322131", "322131071", "story_v_out_322131.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_16 and arg_305_1.time_ < var_308_6 + var_308_16 + arg_308_0 then
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
			local var_312_0 = arg_309_1.actors_["1044ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1044ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, 100, 0)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1044ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, 100, 0)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1043ui_story"].transform
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1.var_.moveOldPos1043ui_story = var_312_9.localPosition
			end

			local var_312_11 = 0.001

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11
				local var_312_13 = Vector3.New(0, 100, 0)

				var_312_9.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1043ui_story, var_312_13, var_312_12)

				local var_312_14 = manager.ui.mainCamera.transform.position - var_312_9.position

				var_312_9.forward = Vector3.New(var_312_14.x, var_312_14.y, var_312_14.z)

				local var_312_15 = var_312_9.localEulerAngles

				var_312_15.z = 0
				var_312_15.x = 0
				var_312_9.localEulerAngles = var_312_15
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 then
				var_312_9.localPosition = Vector3.New(0, 100, 0)

				local var_312_16 = manager.ui.mainCamera.transform.position - var_312_9.position

				var_312_9.forward = Vector3.New(var_312_16.x, var_312_16.y, var_312_16.z)

				local var_312_17 = var_312_9.localEulerAngles

				var_312_17.z = 0
				var_312_17.x = 0
				var_312_9.localEulerAngles = var_312_17
			end

			local var_312_18 = 0.1
			local var_312_19 = 1

			if var_312_18 < arg_309_1.time_ and arg_309_1.time_ <= var_312_18 + arg_312_0 then
				local var_312_20 = "play"
				local var_312_21 = "effect"

				arg_309_1:AudioAction(var_312_20, var_312_21, "c_1043", "c_1043_attack2", "")
			end

			local var_312_22 = manager.ui.mainCamera.transform
			local var_312_23 = 0.1

			if var_312_23 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 then
				arg_309_1.var_.shakeOldPos = var_312_22.localPosition
			end

			local var_312_24 = 0.733333330353101

			if var_312_23 <= arg_309_1.time_ and arg_309_1.time_ < var_312_23 + var_312_24 then
				local var_312_25 = (arg_309_1.time_ - var_312_23) / 0.132
				local var_312_26, var_312_27 = math.modf(var_312_25)

				var_312_22.localPosition = Vector3.New(var_312_27 * 0.13, var_312_27 * 0.13, var_312_27 * 0.13) + arg_309_1.var_.shakeOldPos
			end

			if arg_309_1.time_ >= var_312_23 + var_312_24 and arg_309_1.time_ < var_312_23 + var_312_24 + arg_312_0 then
				var_312_22.localPosition = arg_309_1.var_.shakeOldPos
			end

			local var_312_28 = manager.ui.mainCamera.transform
			local var_312_29 = 0.1

			if var_312_29 < arg_309_1.time_ and arg_309_1.time_ <= var_312_29 + arg_312_0 then
				local var_312_30 = arg_309_1.var_.effect1072
				local var_312_31
				local var_312_32 = var_312_28

				if not var_312_30 then
					var_312_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_312_32)
					var_312_30.name = "1072"
					arg_309_1.var_.effect1072 = var_312_30
				else
					var_312_30.transform:SetParent(var_312_32)
				end

				var_312_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_312_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_312_33 = manager.ui.mainCamera.transform
			local var_312_34 = 2.06666666666667

			if var_312_34 < arg_309_1.time_ and arg_309_1.time_ <= var_312_34 + arg_312_0 then
				local var_312_35 = arg_309_1.var_.effect1072

				if var_312_35 then
					Object.Destroy(var_312_35)

					arg_309_1.var_.effect1072 = nil
				end
			end

			local var_312_36 = 0
			local var_312_37 = 1.45

			if var_312_36 < arg_309_1.time_ and arg_309_1.time_ <= var_312_36 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_38 = arg_309_1:GetWordFromCfg(322131072)
				local var_312_39 = arg_309_1:FormatText(var_312_38.content)

				arg_309_1.text_.text = var_312_39

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_40 = 58
				local var_312_41 = utf8.len(var_312_39)
				local var_312_42 = var_312_40 <= 0 and var_312_37 or var_312_37 * (var_312_41 / var_312_40)

				if var_312_42 > 0 and var_312_37 < var_312_42 then
					arg_309_1.talkMaxDuration = var_312_42

					if var_312_42 + var_312_36 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_42 + var_312_36
					end
				end

				arg_309_1.text_.text = var_312_39
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_43 = math.max(var_312_37, arg_309_1.talkMaxDuration)

			if var_312_36 <= arg_309_1.time_ and arg_309_1.time_ < var_312_36 + var_312_43 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_36) / var_312_43

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_36 + var_312_43 and arg_309_1.time_ < var_312_36 + var_312_43 + arg_312_0 then
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
			local var_316_0 = arg_313_1.actors_["1043ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0.81, -1.01, -5.73)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1043ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_9) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_316_13 = 0

			if var_316_13 < arg_313_1.time_ and arg_313_1.time_ <= var_316_13 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_15 = 0
			local var_316_16 = 0.2

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_17 = arg_313_1:FormatText(StoryNameCfg[1156].name)

				arg_313_1.leftNameTxt_.text = var_316_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_18 = arg_313_1:GetWordFromCfg(322131073)
				local var_316_19 = arg_313_1:FormatText(var_316_18.content)

				arg_313_1.text_.text = var_316_19

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_20 = 8
				local var_316_21 = utf8.len(var_316_19)
				local var_316_22 = var_316_20 <= 0 and var_316_16 or var_316_16 * (var_316_21 / var_316_20)

				if var_316_22 > 0 and var_316_16 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_19
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131073", "story_v_out_322131.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_out_322131", "322131073", "story_v_out_322131.awb") / 1000

					if var_316_23 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_15
					end

					if var_316_18.prefab_name ~= "" and arg_313_1.actors_[var_316_18.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_18.prefab_name].transform, "story_v_out_322131", "322131073", "story_v_out_322131.awb")

						arg_313_1:RecordAudio("322131073", var_316_24)
						arg_313_1:RecordAudio("322131073", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322131", "322131073", "story_v_out_322131.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322131", "322131073", "story_v_out_322131.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_25 and arg_313_1.time_ < var_316_15 + var_316_25 + arg_316_0 then
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
			local var_320_0 = arg_317_1.actors_["1044ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1044ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(-0.7, -1, -5.93)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1044ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1044ui_story"]
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1044ui_story == nil then
				arg_317_1.var_.characterEffect1044ui_story = var_320_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 and not isNil(var_320_9) then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11

				if arg_317_1.var_.characterEffect1044ui_story and not isNil(var_320_9) then
					arg_317_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1044ui_story then
				arg_317_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_320_13 = arg_317_1.actors_["1043ui_story"]
			local var_320_14 = 0

			if var_320_14 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 and not isNil(var_320_13) and arg_317_1.var_.characterEffect1043ui_story == nil then
				arg_317_1.var_.characterEffect1043ui_story = var_320_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_15 = 0.200000002980232

			if var_320_14 <= arg_317_1.time_ and arg_317_1.time_ < var_320_14 + var_320_15 and not isNil(var_320_13) then
				local var_320_16 = (arg_317_1.time_ - var_320_14) / var_320_15

				if arg_317_1.var_.characterEffect1043ui_story and not isNil(var_320_13) then
					local var_320_17 = Mathf.Lerp(0, 0.5, var_320_16)

					arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1043ui_story.fillRatio = var_320_17
				end
			end

			if arg_317_1.time_ >= var_320_14 + var_320_15 and arg_317_1.time_ < var_320_14 + var_320_15 + arg_320_0 and not isNil(var_320_13) and arg_317_1.var_.characterEffect1043ui_story then
				local var_320_18 = 0.5

				arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1043ui_story.fillRatio = var_320_18
			end

			local var_320_19 = 0

			if var_320_19 < arg_317_1.time_ and arg_317_1.time_ <= var_320_19 + arg_320_0 then
				arg_317_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_320_20 = 0
			local var_320_21 = 0.575

			if var_320_20 < arg_317_1.time_ and arg_317_1.time_ <= var_320_20 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_22 = arg_317_1:FormatText(StoryNameCfg[67].name)

				arg_317_1.leftNameTxt_.text = var_320_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_23 = arg_317_1:GetWordFromCfg(322131074)
				local var_320_24 = arg_317_1:FormatText(var_320_23.content)

				arg_317_1.text_.text = var_320_24

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_25 = 23
				local var_320_26 = utf8.len(var_320_24)
				local var_320_27 = var_320_25 <= 0 and var_320_21 or var_320_21 * (var_320_26 / var_320_25)

				if var_320_27 > 0 and var_320_21 < var_320_27 then
					arg_317_1.talkMaxDuration = var_320_27

					if var_320_27 + var_320_20 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_27 + var_320_20
					end
				end

				arg_317_1.text_.text = var_320_24
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131074", "story_v_out_322131.awb") ~= 0 then
					local var_320_28 = manager.audio:GetVoiceLength("story_v_out_322131", "322131074", "story_v_out_322131.awb") / 1000

					if var_320_28 + var_320_20 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_20
					end

					if var_320_23.prefab_name ~= "" and arg_317_1.actors_[var_320_23.prefab_name] ~= nil then
						local var_320_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_23.prefab_name].transform, "story_v_out_322131", "322131074", "story_v_out_322131.awb")

						arg_317_1:RecordAudio("322131074", var_320_29)
						arg_317_1:RecordAudio("322131074", var_320_29)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322131", "322131074", "story_v_out_322131.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322131", "322131074", "story_v_out_322131.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_30 = math.max(var_320_21, arg_317_1.talkMaxDuration)

			if var_320_20 <= arg_317_1.time_ and arg_317_1.time_ < var_320_20 + var_320_30 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_20) / var_320_30

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_20 + var_320_30 and arg_317_1.time_ < var_320_20 + var_320_30 + arg_320_0 then
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
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_324_1 = 0
			local var_324_2 = 0.125

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_3 = arg_321_1:FormatText(StoryNameCfg[67].name)

				arg_321_1.leftNameTxt_.text = var_324_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(322131075)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_6 = 5
				local var_324_7 = utf8.len(var_324_5)
				local var_324_8 = var_324_6 <= 0 and var_324_2 or var_324_2 * (var_324_7 / var_324_6)

				if var_324_8 > 0 and var_324_2 < var_324_8 then
					arg_321_1.talkMaxDuration = var_324_8

					if var_324_8 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131075", "story_v_out_322131.awb") ~= 0 then
					local var_324_9 = manager.audio:GetVoiceLength("story_v_out_322131", "322131075", "story_v_out_322131.awb") / 1000

					if var_324_9 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_1
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_out_322131", "322131075", "story_v_out_322131.awb")

						arg_321_1:RecordAudio("322131075", var_324_10)
						arg_321_1:RecordAudio("322131075", var_324_10)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322131", "322131075", "story_v_out_322131.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322131", "322131075", "story_v_out_322131.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_11 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_11 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_11

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_11 and arg_321_1.time_ < var_324_1 + var_324_11 + arg_324_0 then
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
			local var_328_0 = arg_325_1.actors_["1043ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1043ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0.81, -1.01, -5.73)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1043ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1043ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1043ui_story == nil then
				arg_325_1.var_.characterEffect1043ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1043ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1043ui_story then
				arg_325_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_328_13 = arg_325_1.actors_["1044ui_story"]
			local var_328_14 = 0

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 and not isNil(var_328_13) and arg_325_1.var_.characterEffect1044ui_story == nil then
				arg_325_1.var_.characterEffect1044ui_story = var_328_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_15 = 0.200000002980232

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_15 and not isNil(var_328_13) then
				local var_328_16 = (arg_325_1.time_ - var_328_14) / var_328_15

				if arg_325_1.var_.characterEffect1044ui_story and not isNil(var_328_13) then
					local var_328_17 = Mathf.Lerp(0, 0.5, var_328_16)

					arg_325_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1044ui_story.fillRatio = var_328_17
				end
			end

			if arg_325_1.time_ >= var_328_14 + var_328_15 and arg_325_1.time_ < var_328_14 + var_328_15 + arg_328_0 and not isNil(var_328_13) and arg_325_1.var_.characterEffect1044ui_story then
				local var_328_18 = 0.5

				arg_325_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1044ui_story.fillRatio = var_328_18
			end

			local var_328_19 = 0

			if var_328_19 < arg_325_1.time_ and arg_325_1.time_ <= var_328_19 + arg_328_0 then
				arg_325_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			local var_328_20 = 0

			if var_328_20 < arg_325_1.time_ and arg_325_1.time_ <= var_328_20 + arg_328_0 then
				arg_325_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_21 = 0
			local var_328_22 = 0.55

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_23 = arg_325_1:FormatText(StoryNameCfg[1156].name)

				arg_325_1.leftNameTxt_.text = var_328_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_24 = arg_325_1:GetWordFromCfg(322131076)
				local var_328_25 = arg_325_1:FormatText(var_328_24.content)

				arg_325_1.text_.text = var_328_25

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_26 = 22
				local var_328_27 = utf8.len(var_328_25)
				local var_328_28 = var_328_26 <= 0 and var_328_22 or var_328_22 * (var_328_27 / var_328_26)

				if var_328_28 > 0 and var_328_22 < var_328_28 then
					arg_325_1.talkMaxDuration = var_328_28

					if var_328_28 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_28 + var_328_21
					end
				end

				arg_325_1.text_.text = var_328_25
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322131", "322131076", "story_v_out_322131.awb") ~= 0 then
					local var_328_29 = manager.audio:GetVoiceLength("story_v_out_322131", "322131076", "story_v_out_322131.awb") / 1000

					if var_328_29 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_29 + var_328_21
					end

					if var_328_24.prefab_name ~= "" and arg_325_1.actors_[var_328_24.prefab_name] ~= nil then
						local var_328_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_24.prefab_name].transform, "story_v_out_322131", "322131076", "story_v_out_322131.awb")

						arg_325_1:RecordAudio("322131076", var_328_30)
						arg_325_1:RecordAudio("322131076", var_328_30)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322131", "322131076", "story_v_out_322131.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322131", "322131076", "story_v_out_322131.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_31 = math.max(var_328_22, arg_325_1.talkMaxDuration)

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_31 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_21) / var_328_31

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_21 + var_328_31 and arg_325_1.time_ < var_328_21 + var_328_31 + arg_328_0 then
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
