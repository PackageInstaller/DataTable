return {
	Play319001001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319001001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319001002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ML0101"

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
				local var_4_5 = arg_1_1.bgs_.ML0101

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
					if iter_4_0 ~= "ML0101" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_side_1055", "se_story_side_1055_rain", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 0.166666666666667
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = arg_1_1.bgs_.ML0101.transform
			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.moveOldPosML0101 = var_4_38.localPosition
			end

			local var_4_40 = 0.001

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Vector3.New(0, 1, 3)

				var_4_38.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosML0101, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = Vector3.New(0, 1, 3)
			end

			local var_4_43 = arg_1_1.bgs_.ML0101.transform
			local var_4_44 = 0.0166666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.var_.moveOldPosML0101 = var_4_43.localPosition
			end

			local var_4_45 = 4

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				local var_4_46 = (arg_1_1.time_ - var_4_44) / var_4_45
				local var_4_47 = Vector3.New(-0.5, 1, 3)

				var_4_43.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosML0101, var_4_47, var_4_46)
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				var_4_43.localPosition = Vector3.New(-0.5, 1, 3)
			end

			local var_4_48 = 2

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_49 = 2.01666666666667

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_50 = manager.ui.mainCamera.transform
			local var_4_51 = 0

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_52 = arg_1_1.var_.effect桂花雨
				local var_4_53
				local var_4_54 = var_4_50

				if not var_4_52 then
					var_4_52 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_4_54)
					var_4_52.name = "桂花雨"
					arg_1_1.var_.effect桂花雨 = var_4_52
				else
					var_4_52.transform:SetParent(var_4_54)
				end

				var_4_52.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_52.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_55 = 2
			local var_4_56 = 0.575

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_57 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_57:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(319001001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 23
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_56 or var_4_56 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_56 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_55 = var_4_55 + 0.3

					if var_4_62 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_55
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_55 + 0.3
			local var_4_64 = math.max(var_4_56, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319001002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319001002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319001003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.125

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

				local var_12_2 = arg_9_1:GetWordFromCfg(319001002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 45
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
	Play319001003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319001003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319001004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.6

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(319001003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 24
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319001004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319001004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319001005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.6

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(319001004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 64
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319001005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319001005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319001006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.875

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(319001005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 35
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319001006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319001006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319001007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.725

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(319001006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 29
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319001007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319001007
		arg_29_1.duration_ = 7

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319001008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "ST71"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 0

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.ST71

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST71" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = manager.ui.mainCamera.transform
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				local var_32_18 = arg_29_1.var_.effect桂花雨

				if var_32_18 then
					Object.Destroy(var_32_18)

					arg_29_1.var_.effect桂花雨 = nil
				end
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_20 = 2

			if var_32_19 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_20 then
				local var_32_21 = (arg_29_1.time_ - var_32_19) / var_32_20
				local var_32_22 = Color.New(1, 1, 1)

				var_32_22.a = Mathf.Lerp(1, 0, var_32_21)
				arg_29_1.mask_.color = var_32_22
			end

			if arg_29_1.time_ >= var_32_19 + var_32_20 and arg_29_1.time_ < var_32_19 + var_32_20 + arg_32_0 then
				local var_32_23 = Color.New(1, 1, 1)
				local var_32_24 = 0

				arg_29_1.mask_.enabled = false
				var_32_23.a = var_32_24
				arg_29_1.mask_.color = var_32_23
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_25 = 1.999999999999
			local var_32_26 = 1.2

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_27 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_27:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_28 = arg_29_1:GetWordFromCfg(319001007)
				local var_32_29 = arg_29_1:FormatText(var_32_28.content)

				arg_29_1.text_.text = var_32_29

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_30 = 48
				local var_32_31 = utf8.len(var_32_29)
				local var_32_32 = var_32_30 <= 0 and var_32_26 or var_32_26 * (var_32_31 / var_32_30)

				if var_32_32 > 0 and var_32_26 < var_32_32 then
					arg_29_1.talkMaxDuration = var_32_32
					var_32_25 = var_32_25 + 0.3

					if var_32_32 + var_32_25 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_32 + var_32_25
					end
				end

				arg_29_1.text_.text = var_32_29
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = var_32_25 + 0.3
			local var_32_34 = math.max(var_32_26, arg_29_1.talkMaxDuration)

			if var_32_33 <= arg_29_1.time_ and arg_29_1.time_ < var_32_33 + var_32_34 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_33) / var_32_34

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_33 + var_32_34 and arg_29_1.time_ < var_32_33 + var_32_34 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319001008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319001008
		arg_35_1.duration_ = 4.4

		local var_35_0 = {
			zh = 2.2,
			ja = 4.4
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
				arg_35_0:Play319001009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.25

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[692].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10050")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(319001008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 10
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001008", "story_v_out_319001.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_319001", "319001008", "story_v_out_319001.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_319001", "319001008", "story_v_out_319001.awb")

						arg_35_1:RecordAudio("319001008", var_38_9)
						arg_35_1:RecordAudio("319001008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319001", "319001008", "story_v_out_319001.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319001", "319001008", "story_v_out_319001.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319001009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319001009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319001010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.125

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_2 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_2:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(319001009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 45
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7
					var_42_0 = var_42_0 + 0.3

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = var_42_0 + 0.3
			local var_42_9 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_9 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_9

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_9 and arg_39_1.time_ < var_42_8 + var_42_9 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play319001010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319001010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319001011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_48_4 = 0
			local var_48_5 = 1

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(319001010)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 40
				local var_48_9 = utf8.len(var_48_7)
				local var_48_10 = var_48_8 <= 0 and var_48_5 or var_48_5 * (var_48_9 / var_48_8)

				if var_48_10 > 0 and var_48_5 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_11 and arg_45_1.time_ < var_48_4 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319001011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319001011
		arg_49_1.duration_ = 4.4

		local var_49_0 = {
			zh = 2.533,
			ja = 4.4
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
				arg_49_0:Play319001012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.275

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[36].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(319001011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 11
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001011", "story_v_out_319001.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_319001", "319001011", "story_v_out_319001.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_319001", "319001011", "story_v_out_319001.awb")

						arg_49_1:RecordAudio("319001011", var_52_9)
						arg_49_1:RecordAudio("319001011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319001", "319001011", "story_v_out_319001.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319001", "319001011", "story_v_out_319001.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319001012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319001012
		arg_53_1.duration_ = 7.23

		local var_53_0 = {
			zh = 2.433,
			ja = 7.233
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
				arg_53_0:Play319001013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "10075ui_story"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Char/" .. "10075ui_story")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_53_1.stage_.transform)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentInChildren(typeof(CharacterEffect))

					var_56_3.enabled = true

					local var_56_4 = GameObjectTools.GetOrAddComponent(var_56_2, typeof(DynamicBoneHelper))

					if var_56_4 then
						var_56_4:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_3.transform, false)

					arg_53_1.var_[var_56_0 .. "Animator"] = var_56_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_0 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_0 .. "LipSync"] = var_56_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_5 = arg_53_1.actors_["10075ui_story"].transform
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.var_.moveOldPos10075ui_story = var_56_5.localPosition
			end

			local var_56_7 = 0.001

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 then
				local var_56_8 = (arg_53_1.time_ - var_56_6) / var_56_7
				local var_56_9 = Vector3.New(0, -0.715, -6.15)

				var_56_5.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10075ui_story, var_56_9, var_56_8)

				local var_56_10 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_10.x, var_56_10.y, var_56_10.z)

				local var_56_11 = var_56_5.localEulerAngles

				var_56_11.z = 0
				var_56_11.x = 0
				var_56_5.localEulerAngles = var_56_11
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				var_56_5.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_56_12 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_12.x, var_56_12.y, var_56_12.z)

				local var_56_13 = var_56_5.localEulerAngles

				var_56_13.z = 0
				var_56_13.x = 0
				var_56_5.localEulerAngles = var_56_13
			end

			local var_56_14 = arg_53_1.actors_["10075ui_story"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect10075ui_story == nil then
				arg_53_1.var_.characterEffect10075ui_story = var_56_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_16 = 0.200000002980232

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 and not isNil(var_56_14) then
				local var_56_17 = (arg_53_1.time_ - var_56_15) / var_56_16

				if arg_53_1.var_.characterEffect10075ui_story and not isNil(var_56_14) then
					arg_53_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect10075ui_story then
				arg_53_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_56_18 = 0

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_20 = 0
			local var_56_21 = 0.225

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_22 = arg_53_1:FormatText(StoryNameCfg[692].name)

				arg_53_1.leftNameTxt_.text = var_56_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_23 = arg_53_1:GetWordFromCfg(319001012)
				local var_56_24 = arg_53_1:FormatText(var_56_23.content)

				arg_53_1.text_.text = var_56_24

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_25 = 9
				local var_56_26 = utf8.len(var_56_24)
				local var_56_27 = var_56_25 <= 0 and var_56_21 or var_56_21 * (var_56_26 / var_56_25)

				if var_56_27 > 0 and var_56_21 < var_56_27 then
					arg_53_1.talkMaxDuration = var_56_27

					if var_56_27 + var_56_20 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_27 + var_56_20
					end
				end

				arg_53_1.text_.text = var_56_24
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001012", "story_v_out_319001.awb") ~= 0 then
					local var_56_28 = manager.audio:GetVoiceLength("story_v_out_319001", "319001012", "story_v_out_319001.awb") / 1000

					if var_56_28 + var_56_20 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_20
					end

					if var_56_23.prefab_name ~= "" and arg_53_1.actors_[var_56_23.prefab_name] ~= nil then
						local var_56_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_23.prefab_name].transform, "story_v_out_319001", "319001012", "story_v_out_319001.awb")

						arg_53_1:RecordAudio("319001012", var_56_29)
						arg_53_1:RecordAudio("319001012", var_56_29)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319001", "319001012", "story_v_out_319001.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319001", "319001012", "story_v_out_319001.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_30 = math.max(var_56_21, arg_53_1.talkMaxDuration)

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_30 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_20) / var_56_30

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_20 + var_56_30 and arg_53_1.time_ < var_56_20 + var_56_30 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play319001013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319001013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play319001014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10075ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10075ui_story == nil then
				arg_57_1.var_.characterEffect10075ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10075ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10075ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10075ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10075ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 1.25

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(319001013)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 50
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_7 or var_60_7 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_13 and arg_57_1.time_ < var_60_6 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319001014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319001014
		arg_61_1.duration_ = 8.4

		local var_61_0 = {
			zh = 4.3,
			ja = 8.4
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
				arg_61_0:Play319001015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "10069ui_story"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["10069ui_story"].transform
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.var_.moveOldPos10069ui_story = var_64_5.localPosition
			end

			local var_64_7 = 0.001

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7
				local var_64_9 = Vector3.New(0.7, -1.08, -6.33)

				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10069ui_story, var_64_9, var_64_8)

				local var_64_10 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_10.x, var_64_10.y, var_64_10.z)

				local var_64_11 = var_64_5.localEulerAngles

				var_64_11.z = 0
				var_64_11.x = 0
				var_64_5.localEulerAngles = var_64_11
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_64_12 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_12.x, var_64_12.y, var_64_12.z)

				local var_64_13 = var_64_5.localEulerAngles

				var_64_13.z = 0
				var_64_13.x = 0
				var_64_5.localEulerAngles = var_64_13
			end

			local var_64_14 = arg_61_1.actors_["10069ui_story"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect10069ui_story == nil then
				arg_61_1.var_.characterEffect10069ui_story = var_64_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_16 = 0.200000002980232

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.characterEffect10069ui_story and not isNil(var_64_14) then
					arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect10069ui_story then
				arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_64_18 = 0

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_64_19 = 0

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_20 = arg_61_1.actors_["10075ui_story"].transform
			local var_64_21 = 0

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.var_.moveOldPos10075ui_story = var_64_20.localPosition
			end

			local var_64_22 = 0.001

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_22 then
				local var_64_23 = (arg_61_1.time_ - var_64_21) / var_64_22
				local var_64_24 = Vector3.New(-0.7, -0.715, -6.15)

				var_64_20.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10075ui_story, var_64_24, var_64_23)

				local var_64_25 = manager.ui.mainCamera.transform.position - var_64_20.position

				var_64_20.forward = Vector3.New(var_64_25.x, var_64_25.y, var_64_25.z)

				local var_64_26 = var_64_20.localEulerAngles

				var_64_26.z = 0
				var_64_26.x = 0
				var_64_20.localEulerAngles = var_64_26
			end

			if arg_61_1.time_ >= var_64_21 + var_64_22 and arg_61_1.time_ < var_64_21 + var_64_22 + arg_64_0 then
				var_64_20.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_64_27 = manager.ui.mainCamera.transform.position - var_64_20.position

				var_64_20.forward = Vector3.New(var_64_27.x, var_64_27.y, var_64_27.z)

				local var_64_28 = var_64_20.localEulerAngles

				var_64_28.z = 0
				var_64_28.x = 0
				var_64_20.localEulerAngles = var_64_28
			end

			local var_64_29 = arg_61_1.actors_["10075ui_story"]
			local var_64_30 = 0

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 and not isNil(var_64_29) and arg_61_1.var_.characterEffect10075ui_story == nil then
				arg_61_1.var_.characterEffect10075ui_story = var_64_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_31 = 0.200000002980232

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_31 and not isNil(var_64_29) then
				local var_64_32 = (arg_61_1.time_ - var_64_30) / var_64_31

				if arg_61_1.var_.characterEffect10075ui_story and not isNil(var_64_29) then
					local var_64_33 = Mathf.Lerp(0, 0.5, var_64_32)

					arg_61_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10075ui_story.fillRatio = var_64_33
				end
			end

			if arg_61_1.time_ >= var_64_30 + var_64_31 and arg_61_1.time_ < var_64_30 + var_64_31 + arg_64_0 and not isNil(var_64_29) and arg_61_1.var_.characterEffect10075ui_story then
				local var_64_34 = 0.5

				arg_61_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10075ui_story.fillRatio = var_64_34
			end

			local var_64_35 = 0
			local var_64_36 = 0.5

			if var_64_35 < arg_61_1.time_ and arg_61_1.time_ <= var_64_35 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_37 = arg_61_1:FormatText(StoryNameCfg[693].name)

				arg_61_1.leftNameTxt_.text = var_64_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_38 = arg_61_1:GetWordFromCfg(319001014)
				local var_64_39 = arg_61_1:FormatText(var_64_38.content)

				arg_61_1.text_.text = var_64_39

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_40 = 20
				local var_64_41 = utf8.len(var_64_39)
				local var_64_42 = var_64_40 <= 0 and var_64_36 or var_64_36 * (var_64_41 / var_64_40)

				if var_64_42 > 0 and var_64_36 < var_64_42 then
					arg_61_1.talkMaxDuration = var_64_42

					if var_64_42 + var_64_35 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_42 + var_64_35
					end
				end

				arg_61_1.text_.text = var_64_39
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001014", "story_v_out_319001.awb") ~= 0 then
					local var_64_43 = manager.audio:GetVoiceLength("story_v_out_319001", "319001014", "story_v_out_319001.awb") / 1000

					if var_64_43 + var_64_35 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_43 + var_64_35
					end

					if var_64_38.prefab_name ~= "" and arg_61_1.actors_[var_64_38.prefab_name] ~= nil then
						local var_64_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_38.prefab_name].transform, "story_v_out_319001", "319001014", "story_v_out_319001.awb")

						arg_61_1:RecordAudio("319001014", var_64_44)
						arg_61_1:RecordAudio("319001014", var_64_44)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319001", "319001014", "story_v_out_319001.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319001", "319001014", "story_v_out_319001.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_45 = math.max(var_64_36, arg_61_1.talkMaxDuration)

			if var_64_35 <= arg_61_1.time_ and arg_61_1.time_ < var_64_35 + var_64_45 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_35) / var_64_45

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_35 + var_64_45 and arg_61_1.time_ < var_64_35 + var_64_45 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319001015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319001015
		arg_65_1.duration_ = 10.1

		local var_65_0 = {
			zh = 2.2,
			ja = 10.1
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
				arg_65_0:Play319001016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10075ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10075ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10075ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["10075ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10075ui_story == nil then
				arg_65_1.var_.characterEffect10075ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect10075ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10075ui_story then
				arg_65_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_15 = arg_65_1.actors_["10069ui_story"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect10069ui_story == nil then
				arg_65_1.var_.characterEffect10069ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_17 = 0.200000002980232

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.characterEffect10069ui_story and not isNil(var_68_15) then
					local var_68_19 = Mathf.Lerp(0, 0.5, var_68_18)

					arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10069ui_story.fillRatio = var_68_19
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect10069ui_story then
				local var_68_20 = 0.5

				arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10069ui_story.fillRatio = var_68_20
			end

			local var_68_21 = 0
			local var_68_22 = 0.3

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_23 = arg_65_1:FormatText(StoryNameCfg[692].name)

				arg_65_1.leftNameTxt_.text = var_68_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(319001015)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 12
				local var_68_27 = utf8.len(var_68_25)
				local var_68_28 = var_68_26 <= 0 and var_68_22 or var_68_22 * (var_68_27 / var_68_26)

				if var_68_28 > 0 and var_68_22 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28

					if var_68_28 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_21
					end
				end

				arg_65_1.text_.text = var_68_25
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001015", "story_v_out_319001.awb") ~= 0 then
					local var_68_29 = manager.audio:GetVoiceLength("story_v_out_319001", "319001015", "story_v_out_319001.awb") / 1000

					if var_68_29 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_29 + var_68_21
					end

					if var_68_24.prefab_name ~= "" and arg_65_1.actors_[var_68_24.prefab_name] ~= nil then
						local var_68_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_24.prefab_name].transform, "story_v_out_319001", "319001015", "story_v_out_319001.awb")

						arg_65_1:RecordAudio("319001015", var_68_30)
						arg_65_1:RecordAudio("319001015", var_68_30)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319001", "319001015", "story_v_out_319001.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319001", "319001015", "story_v_out_319001.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = math.max(var_68_22, arg_65_1.talkMaxDuration)

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_31 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_21) / var_68_31

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_21 + var_68_31 and arg_65_1.time_ < var_68_21 + var_68_31 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play319001016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319001016
		arg_69_1.duration_ = 10.1

		local var_69_0 = {
			zh = 5.5,
			ja = 10.1
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
				arg_69_0:Play319001017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10075ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10075ui_story == nil then
				arg_69_1.var_.characterEffect10075ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10075ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10075ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10075ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10075ui_story.fillRatio = var_72_5
			end

			local var_72_6 = arg_69_1.actors_["10069ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10069ui_story == nil then
				arg_69_1.var_.characterEffect10069ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.200000002980232

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect10069ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10069ui_story then
				arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_72_10 = 0
			local var_72_11 = 0.525

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_12 = arg_69_1:FormatText(StoryNameCfg[693].name)

				arg_69_1.leftNameTxt_.text = var_72_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(319001016)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_15 = 21
				local var_72_16 = utf8.len(var_72_14)
				local var_72_17 = var_72_15 <= 0 and var_72_11 or var_72_11 * (var_72_16 / var_72_15)

				if var_72_17 > 0 and var_72_11 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_10
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001016", "story_v_out_319001.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_319001", "319001016", "story_v_out_319001.awb") / 1000

					if var_72_18 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_10
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_319001", "319001016", "story_v_out_319001.awb")

						arg_69_1:RecordAudio("319001016", var_72_19)
						arg_69_1:RecordAudio("319001016", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319001", "319001016", "story_v_out_319001.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319001", "319001016", "story_v_out_319001.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_10) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_10 + var_72_20 and arg_69_1.time_ < var_72_10 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319001017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319001017
		arg_73_1.duration_ = 9

		local var_73_0 = {
			zh = 4.6,
			ja = 9
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
				arg_73_0:Play319001018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10075ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10075ui_story == nil then
				arg_73_1.var_.characterEffect10075ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10075ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10075ui_story then
				arg_73_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["10069ui_story"]
			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10069ui_story == nil then
				arg_73_1.var_.characterEffect10069ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_6 and not isNil(var_76_4) then
				local var_76_7 = (arg_73_1.time_ - var_76_5) / var_76_6

				if arg_73_1.var_.characterEffect10069ui_story and not isNil(var_76_4) then
					local var_76_8 = Mathf.Lerp(0, 0.5, var_76_7)

					arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10069ui_story.fillRatio = var_76_8
				end
			end

			if arg_73_1.time_ >= var_76_5 + var_76_6 and arg_73_1.time_ < var_76_5 + var_76_6 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10069ui_story then
				local var_76_9 = 0.5

				arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10069ui_story.fillRatio = var_76_9
			end

			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			local var_76_11 = 0

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_76_12 = 0
			local var_76_13 = 0.425

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[692].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(319001017)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 17
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001017", "story_v_out_319001.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_319001", "319001017", "story_v_out_319001.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_319001", "319001017", "story_v_out_319001.awb")

						arg_73_1:RecordAudio("319001017", var_76_21)
						arg_73_1:RecordAudio("319001017", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319001", "319001017", "story_v_out_319001.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319001", "319001017", "story_v_out_319001.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319001018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319001018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319001019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10075ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10075ui_story == nil then
				arg_77_1.var_.characterEffect10075ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10075ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10075ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10075ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10075ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 1.425

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(319001018)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 57
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_7 or var_80_7 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_7 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_13 and arg_77_1.time_ < var_80_6 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319001019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319001019
		arg_81_1.duration_ = 10

		local var_81_0 = {
			zh = 3.8,
			ja = 10
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
				arg_81_0:Play319001020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10069ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10069ui_story == nil then
				arg_81_1.var_.characterEffect10069ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10069ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10069ui_story then
				arg_81_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.45

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_6 = arg_81_1:FormatText(StoryNameCfg[693].name)

				arg_81_1.leftNameTxt_.text = var_84_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(319001019)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 18
				local var_84_10 = utf8.len(var_84_8)
				local var_84_11 = var_84_9 <= 0 and var_84_5 or var_84_5 * (var_84_10 / var_84_9)

				if var_84_11 > 0 and var_84_5 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001019", "story_v_out_319001.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001019", "story_v_out_319001.awb") / 1000

					if var_84_12 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_4
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_319001", "319001019", "story_v_out_319001.awb")

						arg_81_1:RecordAudio("319001019", var_84_13)
						arg_81_1:RecordAudio("319001019", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319001", "319001019", "story_v_out_319001.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319001", "319001019", "story_v_out_319001.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_14 and arg_81_1.time_ < var_84_4 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319001020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319001020
		arg_85_1.duration_ = 7.53

		local var_85_0 = {
			zh = 5.333,
			ja = 7.533
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
				arg_85_0:Play319001021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10075ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10075ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10075ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["10075ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect10075ui_story == nil then
				arg_85_1.var_.characterEffect10075ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect10075ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect10075ui_story then
				arg_85_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = arg_85_1.actors_["10069ui_story"]
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.characterEffect10069ui_story == nil then
				arg_85_1.var_.characterEffect10069ui_story = var_88_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_17 = 0.200000002980232

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 and not isNil(var_88_15) then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17

				if arg_85_1.var_.characterEffect10069ui_story and not isNil(var_88_15) then
					local var_88_19 = Mathf.Lerp(0, 0.5, var_88_18)

					arg_85_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10069ui_story.fillRatio = var_88_19
				end
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.characterEffect10069ui_story then
				local var_88_20 = 0.5

				arg_85_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10069ui_story.fillRatio = var_88_20
			end

			local var_88_21 = 0
			local var_88_22 = 0.55

			if var_88_21 < arg_85_1.time_ and arg_85_1.time_ <= var_88_21 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_23 = arg_85_1:FormatText(StoryNameCfg[692].name)

				arg_85_1.leftNameTxt_.text = var_88_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_24 = arg_85_1:GetWordFromCfg(319001020)
				local var_88_25 = arg_85_1:FormatText(var_88_24.content)

				arg_85_1.text_.text = var_88_25

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_26 = 22
				local var_88_27 = utf8.len(var_88_25)
				local var_88_28 = var_88_26 <= 0 and var_88_22 or var_88_22 * (var_88_27 / var_88_26)

				if var_88_28 > 0 and var_88_22 < var_88_28 then
					arg_85_1.talkMaxDuration = var_88_28

					if var_88_28 + var_88_21 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_21
					end
				end

				arg_85_1.text_.text = var_88_25
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001020", "story_v_out_319001.awb") ~= 0 then
					local var_88_29 = manager.audio:GetVoiceLength("story_v_out_319001", "319001020", "story_v_out_319001.awb") / 1000

					if var_88_29 + var_88_21 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_29 + var_88_21
					end

					if var_88_24.prefab_name ~= "" and arg_85_1.actors_[var_88_24.prefab_name] ~= nil then
						local var_88_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_24.prefab_name].transform, "story_v_out_319001", "319001020", "story_v_out_319001.awb")

						arg_85_1:RecordAudio("319001020", var_88_30)
						arg_85_1:RecordAudio("319001020", var_88_30)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319001", "319001020", "story_v_out_319001.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319001", "319001020", "story_v_out_319001.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_31 = math.max(var_88_22, arg_85_1.talkMaxDuration)

			if var_88_21 <= arg_85_1.time_ and arg_85_1.time_ < var_88_21 + var_88_31 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_21) / var_88_31

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_21 + var_88_31 and arg_85_1.time_ < var_88_21 + var_88_31 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play319001021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319001021
		arg_89_1.duration_ = 14.07

		local var_89_0 = {
			zh = 5.566,
			ja = 14.066
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
				arg_89_0:Play319001022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10069ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10069ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0.7, -1.08, -6.33)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10069ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["10069ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10069ui_story == nil then
				arg_89_1.var_.characterEffect10069ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect10069ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10069ui_story then
				arg_89_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_15 = arg_89_1.actors_["10075ui_story"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect10075ui_story == nil then
				arg_89_1.var_.characterEffect10075ui_story = var_92_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_17 = 0.200000002980232

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.characterEffect10075ui_story and not isNil(var_92_15) then
					local var_92_19 = Mathf.Lerp(0, 0.5, var_92_18)

					arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10075ui_story.fillRatio = var_92_19
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect10075ui_story then
				local var_92_20 = 0.5

				arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10075ui_story.fillRatio = var_92_20
			end

			local var_92_21 = 0
			local var_92_22 = 0.625

			if var_92_21 < arg_89_1.time_ and arg_89_1.time_ <= var_92_21 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_23 = arg_89_1:FormatText(StoryNameCfg[693].name)

				arg_89_1.leftNameTxt_.text = var_92_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_24 = arg_89_1:GetWordFromCfg(319001021)
				local var_92_25 = arg_89_1:FormatText(var_92_24.content)

				arg_89_1.text_.text = var_92_25

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_26 = 25
				local var_92_27 = utf8.len(var_92_25)
				local var_92_28 = var_92_26 <= 0 and var_92_22 or var_92_22 * (var_92_27 / var_92_26)

				if var_92_28 > 0 and var_92_22 < var_92_28 then
					arg_89_1.talkMaxDuration = var_92_28

					if var_92_28 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_28 + var_92_21
					end
				end

				arg_89_1.text_.text = var_92_25
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001021", "story_v_out_319001.awb") ~= 0 then
					local var_92_29 = manager.audio:GetVoiceLength("story_v_out_319001", "319001021", "story_v_out_319001.awb") / 1000

					if var_92_29 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_29 + var_92_21
					end

					if var_92_24.prefab_name ~= "" and arg_89_1.actors_[var_92_24.prefab_name] ~= nil then
						local var_92_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_24.prefab_name].transform, "story_v_out_319001", "319001021", "story_v_out_319001.awb")

						arg_89_1:RecordAudio("319001021", var_92_30)
						arg_89_1:RecordAudio("319001021", var_92_30)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319001", "319001021", "story_v_out_319001.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319001", "319001021", "story_v_out_319001.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_31 = math.max(var_92_22, arg_89_1.talkMaxDuration)

			if var_92_21 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_31 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_21) / var_92_31

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_21 + var_92_31 and arg_89_1.time_ < var_92_21 + var_92_31 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play319001022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319001022
		arg_93_1.duration_ = 13.67

		local var_93_0 = {
			zh = 3.433,
			ja = 13.666
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
				arg_93_0:Play319001023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10069ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10069ui_story == nil then
				arg_93_1.var_.characterEffect10069ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10069ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10069ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10069ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10069ui_story.fillRatio = var_96_5
			end

			local var_96_6 = arg_93_1.actors_["10075ui_story"]
			local var_96_7 = 0

			if var_96_7 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect10075ui_story == nil then
				arg_93_1.var_.characterEffect10075ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_8 and not isNil(var_96_6) then
				local var_96_9 = (arg_93_1.time_ - var_96_7) / var_96_8

				if arg_93_1.var_.characterEffect10075ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_7 + var_96_8 and arg_93_1.time_ < var_96_7 + var_96_8 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect10075ui_story then
				arg_93_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			local var_96_11 = 0

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_12 = 0
			local var_96_13 = 0.45

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_14 = arg_93_1:FormatText(StoryNameCfg[692].name)

				arg_93_1.leftNameTxt_.text = var_96_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_15 = arg_93_1:GetWordFromCfg(319001022)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 18
				local var_96_18 = utf8.len(var_96_16)
				local var_96_19 = var_96_17 <= 0 and var_96_13 or var_96_13 * (var_96_18 / var_96_17)

				if var_96_19 > 0 and var_96_13 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19

					if var_96_19 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001022", "story_v_out_319001.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_out_319001", "319001022", "story_v_out_319001.awb") / 1000

					if var_96_20 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_12
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_out_319001", "319001022", "story_v_out_319001.awb")

						arg_93_1:RecordAudio("319001022", var_96_21)
						arg_93_1:RecordAudio("319001022", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319001", "319001022", "story_v_out_319001.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319001", "319001022", "story_v_out_319001.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_22 and arg_93_1.time_ < var_96_12 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319001023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319001023
		arg_97_1.duration_ = 11.83

		local var_97_0 = {
			zh = 9.8,
			ja = 11.833
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
				arg_97_0:Play319001024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10075ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10075ui_story == nil then
				arg_97_1.var_.characterEffect10075ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10075ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10075ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10075ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10075ui_story.fillRatio = var_100_5
			end

			local var_100_6 = arg_97_1.actors_["10069ui_story"]
			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10069ui_story == nil then
				arg_97_1.var_.characterEffect10069ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_8 = 0.200000002980232

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_8 and not isNil(var_100_6) then
				local var_100_9 = (arg_97_1.time_ - var_100_7) / var_100_8

				if arg_97_1.var_.characterEffect10069ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_7 + var_100_8 and arg_97_1.time_ < var_100_7 + var_100_8 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10069ui_story then
				arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_100_10 = 0
			local var_100_11 = 1.125

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_12 = arg_97_1:FormatText(StoryNameCfg[693].name)

				arg_97_1.leftNameTxt_.text = var_100_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(319001023)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_15 = 45
				local var_100_16 = utf8.len(var_100_14)
				local var_100_17 = var_100_15 <= 0 and var_100_11 or var_100_11 * (var_100_16 / var_100_15)

				if var_100_17 > 0 and var_100_11 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17

					if var_100_17 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_10
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001023", "story_v_out_319001.awb") ~= 0 then
					local var_100_18 = manager.audio:GetVoiceLength("story_v_out_319001", "319001023", "story_v_out_319001.awb") / 1000

					if var_100_18 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_10
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_319001", "319001023", "story_v_out_319001.awb")

						arg_97_1:RecordAudio("319001023", var_100_19)
						arg_97_1:RecordAudio("319001023", var_100_19)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319001", "319001023", "story_v_out_319001.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319001", "319001023", "story_v_out_319001.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_20 = math.max(var_100_11, arg_97_1.talkMaxDuration)

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_10) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_10 + var_100_20 and arg_97_1.time_ < var_100_10 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319001024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319001024
		arg_101_1.duration_ = 10.4

		local var_101_0 = {
			zh = 4.433,
			ja = 10.4
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
				arg_101_0:Play319001025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10075ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10075ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10075ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["10075ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect10075ui_story == nil then
				arg_101_1.var_.characterEffect10075ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect10075ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect10075ui_story then
				arg_101_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = arg_101_1.actors_["10069ui_story"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = var_104_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_17 = 0.200000002980232

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.characterEffect10069ui_story and not isNil(var_104_15) then
					local var_104_19 = Mathf.Lerp(0, 0.5, var_104_18)

					arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10069ui_story.fillRatio = var_104_19
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.characterEffect10069ui_story then
				local var_104_20 = 0.5

				arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10069ui_story.fillRatio = var_104_20
			end

			local var_104_21 = 0
			local var_104_22 = 0.5

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_23 = arg_101_1:FormatText(StoryNameCfg[692].name)

				arg_101_1.leftNameTxt_.text = var_104_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:GetWordFromCfg(319001024)
				local var_104_25 = arg_101_1:FormatText(var_104_24.content)

				arg_101_1.text_.text = var_104_25

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_26 = 20
				local var_104_27 = utf8.len(var_104_25)
				local var_104_28 = var_104_26 <= 0 and var_104_22 or var_104_22 * (var_104_27 / var_104_26)

				if var_104_28 > 0 and var_104_22 < var_104_28 then
					arg_101_1.talkMaxDuration = var_104_28

					if var_104_28 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_21
					end
				end

				arg_101_1.text_.text = var_104_25
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001024", "story_v_out_319001.awb") ~= 0 then
					local var_104_29 = manager.audio:GetVoiceLength("story_v_out_319001", "319001024", "story_v_out_319001.awb") / 1000

					if var_104_29 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_29 + var_104_21
					end

					if var_104_24.prefab_name ~= "" and arg_101_1.actors_[var_104_24.prefab_name] ~= nil then
						local var_104_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_24.prefab_name].transform, "story_v_out_319001", "319001024", "story_v_out_319001.awb")

						arg_101_1:RecordAudio("319001024", var_104_30)
						arg_101_1:RecordAudio("319001024", var_104_30)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319001", "319001024", "story_v_out_319001.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319001", "319001024", "story_v_out_319001.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_31 = math.max(var_104_22, arg_101_1.talkMaxDuration)

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_31 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_21) / var_104_31

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_21 + var_104_31 and arg_101_1.time_ < var_104_21 + var_104_31 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319001025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319001025
		arg_105_1.duration_ = 7.37

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play319001026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "STblack"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 0.0166666666666666

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.STblack

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
					if iter_108_0 ~= "STblack" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = arg_105_1.actors_["10075ui_story"].transform
			local var_108_17 = 0.0166666666666666

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 then
				arg_105_1.var_.moveOldPos10075ui_story = var_108_16.localPosition
			end

			local var_108_18 = 0.001

			if var_108_17 <= arg_105_1.time_ and arg_105_1.time_ < var_108_17 + var_108_18 then
				local var_108_19 = (arg_105_1.time_ - var_108_17) / var_108_18
				local var_108_20 = Vector3.New(0, 100, 0)

				var_108_16.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10075ui_story, var_108_20, var_108_19)

				local var_108_21 = manager.ui.mainCamera.transform.position - var_108_16.position

				var_108_16.forward = Vector3.New(var_108_21.x, var_108_21.y, var_108_21.z)

				local var_108_22 = var_108_16.localEulerAngles

				var_108_22.z = 0
				var_108_22.x = 0
				var_108_16.localEulerAngles = var_108_22
			end

			if arg_105_1.time_ >= var_108_17 + var_108_18 and arg_105_1.time_ < var_108_17 + var_108_18 + arg_108_0 then
				var_108_16.localPosition = Vector3.New(0, 100, 0)

				local var_108_23 = manager.ui.mainCamera.transform.position - var_108_16.position

				var_108_16.forward = Vector3.New(var_108_23.x, var_108_23.y, var_108_23.z)

				local var_108_24 = var_108_16.localEulerAngles

				var_108_24.z = 0
				var_108_24.x = 0
				var_108_16.localEulerAngles = var_108_24
			end

			local var_108_25 = arg_105_1.actors_["10069ui_story"].transform
			local var_108_26 = 0.0166666666666666

			if var_108_26 < arg_105_1.time_ and arg_105_1.time_ <= var_108_26 + arg_108_0 then
				arg_105_1.var_.moveOldPos10069ui_story = var_108_25.localPosition
			end

			local var_108_27 = 0.001

			if var_108_26 <= arg_105_1.time_ and arg_105_1.time_ < var_108_26 + var_108_27 then
				local var_108_28 = (arg_105_1.time_ - var_108_26) / var_108_27
				local var_108_29 = Vector3.New(0, 100, 0)

				var_108_25.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10069ui_story, var_108_29, var_108_28)

				local var_108_30 = manager.ui.mainCamera.transform.position - var_108_25.position

				var_108_25.forward = Vector3.New(var_108_30.x, var_108_30.y, var_108_30.z)

				local var_108_31 = var_108_25.localEulerAngles

				var_108_31.z = 0
				var_108_31.x = 0
				var_108_25.localEulerAngles = var_108_31
			end

			if arg_105_1.time_ >= var_108_26 + var_108_27 and arg_105_1.time_ < var_108_26 + var_108_27 + arg_108_0 then
				var_108_25.localPosition = Vector3.New(0, 100, 0)

				local var_108_32 = manager.ui.mainCamera.transform.position - var_108_25.position

				var_108_25.forward = Vector3.New(var_108_32.x, var_108_32.y, var_108_32.z)

				local var_108_33 = var_108_25.localEulerAngles

				var_108_33.z = 0
				var_108_33.x = 0
				var_108_25.localEulerAngles = var_108_33
			end

			local var_108_34 = 0

			if var_108_34 < arg_105_1.time_ and arg_105_1.time_ <= var_108_34 + arg_108_0 then
				arg_105_1.fswbg_:SetActive(true)
				arg_105_1.dialog_:SetActive(false)

				arg_105_1.fswtw_.percent = 0

				local var_108_35 = arg_105_1:GetWordFromCfg(319001025)
				local var_108_36 = arg_105_1:FormatText(var_108_35.content)

				arg_105_1.fswt_.text = var_108_36

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.fswt_)

				arg_105_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_105_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_105_1.fswtw_:SetDirty()

				arg_105_1.typewritterCharCountI18N = 0

				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			local var_108_37 = 0.766666666666668

			if var_108_37 < arg_105_1.time_ and arg_105_1.time_ <= var_108_37 + arg_108_0 then
				arg_105_1.var_.oldValueTypewriter = arg_105_1.fswtw_.percent

				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			local var_108_38 = 28
			local var_108_39 = 1.86666666666667
			local var_108_40 = arg_105_1:GetWordFromCfg(319001025)
			local var_108_41 = arg_105_1:FormatText(var_108_40.content)
			local var_108_42, var_108_43 = arg_105_1:GetPercentByPara(var_108_41, 1)

			if var_108_37 < arg_105_1.time_ and arg_105_1.time_ <= var_108_37 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				local var_108_44 = var_108_38 <= 0 and var_108_39 or var_108_39 * ((var_108_43 - arg_105_1.typewritterCharCountI18N) / var_108_38)

				if var_108_44 > 0 and var_108_39 < var_108_44 then
					arg_105_1.talkMaxDuration = var_108_44

					if var_108_44 + var_108_37 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_44 + var_108_37
					end
				end
			end

			local var_108_45 = 1.86666666666667
			local var_108_46 = math.max(var_108_45, arg_105_1.talkMaxDuration)

			if var_108_37 <= arg_105_1.time_ and arg_105_1.time_ < var_108_37 + var_108_46 then
				local var_108_47 = (arg_105_1.time_ - var_108_37) / var_108_46

				arg_105_1.fswtw_.percent = Mathf.Lerp(arg_105_1.var_.oldValueTypewriter, var_108_42, var_108_47)
				arg_105_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_105_1.fswtw_:SetDirty()
			end

			if arg_105_1.time_ >= var_108_37 + var_108_46 and arg_105_1.time_ < var_108_37 + var_108_46 + arg_108_0 then
				arg_105_1.fswtw_.percent = var_108_42

				arg_105_1.fswtw_:SetDirty()
				arg_105_1:ShowNextGo(true)

				arg_105_1.typewritterCharCountI18N = var_108_43
			end

			local var_108_48 = 0.750000000000001

			if var_108_48 < arg_105_1.time_ and arg_105_1.time_ <= var_108_48 + arg_108_0 then
				local var_108_49 = arg_105_1.fswbg_.transform:Find("textbox/adapt/content") or arg_105_1.fswbg_.transform:Find("textbox/content")
				local var_108_50 = arg_105_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_108_51 = var_108_49:GetComponent("Text")
				local var_108_52 = var_108_49:GetComponent("RectTransform")

				var_108_51.alignment = UnityEngine.TextAnchor.LowerCenter
				var_108_52.offsetMin = Vector2.New(0, 0)
				var_108_52.offsetMax = Vector2.New(0, 0)
			end

			local var_108_53 = 0.766666666666668
			local var_108_54 = 6.6
			local var_108_55 = manager.audio:GetVoiceLength("story_v_out_319001", "319001025", "story_v_out_319001.awb") / 1000

			if var_108_55 > 0 and var_108_54 < var_108_55 and var_108_55 + var_108_53 > arg_105_1.duration_ then
				local var_108_56 = var_108_55

				arg_105_1.duration_ = var_108_55 + var_108_53
			end

			if var_108_53 < arg_105_1.time_ and arg_105_1.time_ <= var_108_53 + arg_108_0 then
				local var_108_57 = "play"
				local var_108_58 = "voice"

				arg_105_1:AudioAction(var_108_57, var_108_58, "story_v_out_319001", "319001025", "story_v_out_319001.awb")
			end

			local var_108_59 = 0

			if var_108_59 < arg_105_1.time_ and arg_105_1.time_ <= var_108_59 + arg_108_0 then
				arg_105_1.cswbg_:SetActive(false)

				local var_108_60 = arg_105_1.cswt_:GetComponent("RectTransform")

				arg_105_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_108_60.offsetMin = Vector2.New(400, 105)
				var_108_60.offsetMax = Vector2.New(-400, -200)

				local var_108_61 = arg_105_1:GetWordFromCfg(419001)
				local var_108_62 = arg_105_1:FormatText(var_108_61.content)

				arg_105_1.cswt_.text = var_108_62

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.cswt_)

				arg_105_1.cswt_.fontSize = 108
				arg_105_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_105_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_105_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_105_1.cswbg_:SetActive(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play319001026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319001026
		arg_109_1.duration_ = 4.23

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play319001027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0

				local var_112_1 = arg_109_1:GetWordFromCfg(319001026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.fswt_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_3 = 0.0166666666666665

			if var_112_3 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_4 = 17
			local var_112_5 = 1.13333333333333
			local var_112_6 = arg_109_1:GetWordFromCfg(319001026)
			local var_112_7 = arg_109_1:FormatText(var_112_6.content)
			local var_112_8, var_112_9 = arg_109_1:GetPercentByPara(var_112_7, 1)

			if var_112_3 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				local var_112_10 = var_112_4 <= 0 and var_112_5 or var_112_5 * ((var_112_9 - arg_109_1.typewritterCharCountI18N) / var_112_4)

				if var_112_10 > 0 and var_112_5 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_3
					end
				end
			end

			local var_112_11 = 1.13333333333333
			local var_112_12 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_12 then
				local var_112_13 = (arg_109_1.time_ - var_112_3) / var_112_12

				arg_109_1.fswtw_.percent = Mathf.Lerp(arg_109_1.var_.oldValueTypewriter, var_112_8, var_112_13)
				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_109_1.fswtw_:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_12 and arg_109_1.time_ < var_112_3 + var_112_12 + arg_112_0 then
				arg_109_1.fswtw_.percent = var_112_8

				arg_109_1.fswtw_:SetDirty()
				arg_109_1:ShowNextGo(true)

				arg_109_1.typewritterCharCountI18N = var_112_9
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				local var_112_15 = arg_109_1.fswbg_.transform:Find("textbox/adapt/content") or arg_109_1.fswbg_.transform:Find("textbox/content")
				local var_112_16 = arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_112_17 = var_112_15:GetComponent("Text")
				local var_112_18 = var_112_15:GetComponent("RectTransform")

				var_112_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_112_18.offsetMin = Vector2.New(0, 0)
				var_112_18.offsetMax = Vector2.New(0, 0)
			end

			local var_112_19 = 0
			local var_112_20 = 4.233
			local var_112_21 = manager.audio:GetVoiceLength("story_v_out_319001", "319001026", "story_v_out_319001.awb") / 1000

			if var_112_21 > 0 and var_112_20 < var_112_21 and var_112_21 + var_112_19 > arg_109_1.duration_ then
				local var_112_22 = var_112_21

				arg_109_1.duration_ = var_112_21 + var_112_19
			end

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				local var_112_23 = "play"
				local var_112_24 = "voice"

				arg_109_1:AudioAction(var_112_23, var_112_24, "story_v_out_319001", "319001026", "story_v_out_319001.awb")
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319001027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319001027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319001028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				local var_116_1 = manager.ui.mainCamera.transform.localPosition
				local var_116_2 = Vector3.New(0, 0, 10) + Vector3.New(var_116_1.x, var_116_1.y, 0)
				local var_116_3 = arg_113_1.bgs_.ST71

				var_116_3.transform.localPosition = var_116_2
				var_116_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_4 = var_116_3:GetComponent("SpriteRenderer")

				if var_116_4 and var_116_4.sprite then
					local var_116_5 = (var_116_3.transform.localPosition - var_116_1).z
					local var_116_6 = manager.ui.mainCameraCom_
					local var_116_7 = 2 * var_116_5 * Mathf.Tan(var_116_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_8 = var_116_7 * var_116_6.aspect
					local var_116_9 = var_116_4.sprite.bounds.size.x
					local var_116_10 = var_116_4.sprite.bounds.size.y
					local var_116_11 = var_116_8 / var_116_9
					local var_116_12 = var_116_7 / var_116_10
					local var_116_13 = var_116_12 < var_116_11 and var_116_11 or var_116_12

					var_116_3.transform.localScale = Vector3.New(var_116_13, var_116_13, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST71" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(false)
				arg_113_1.dialog_:SetActive(false)
				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.cswbg_:SetActive(false)
			end

			local var_116_16 = 0
			local var_116_17 = 1.275

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_18 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_18:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_19 = arg_113_1:GetWordFromCfg(319001027)
				local var_116_20 = arg_113_1:FormatText(var_116_19.content)

				arg_113_1.text_.text = var_116_20

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_21 = 51
				local var_116_22 = utf8.len(var_116_20)
				local var_116_23 = var_116_21 <= 0 and var_116_17 or var_116_17 * (var_116_22 / var_116_21)

				if var_116_23 > 0 and var_116_17 < var_116_23 then
					arg_113_1.talkMaxDuration = var_116_23
					var_116_16 = var_116_16 + 0.3

					if var_116_23 + var_116_16 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_16
					end
				end

				arg_113_1.text_.text = var_116_20
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = var_116_16 + 0.3
			local var_116_25 = math.max(var_116_17, arg_113_1.talkMaxDuration)

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_24) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_24 + var_116_25 and arg_113_1.time_ < var_116_24 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319001028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319001028
		arg_119_1.duration_ = 1.5

		local var_119_0 = {
			zh = 1.5,
			ja = 1.433
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
				arg_119_0:Play319001029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10075ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10075ui_story == nil then
				arg_119_1.var_.characterEffect10075ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10075ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10075ui_story then
				arg_119_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["10075ui_story"].transform
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.var_.moveOldPos10075ui_story = var_122_4.localPosition
			end

			local var_122_6 = 0.001

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6
				local var_122_8 = Vector3.New(0, -0.715, -6.15)

				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10075ui_story, var_122_8, var_122_7)

				local var_122_9 = manager.ui.mainCamera.transform.position - var_122_4.position

				var_122_4.forward = Vector3.New(var_122_9.x, var_122_9.y, var_122_9.z)

				local var_122_10 = var_122_4.localEulerAngles

				var_122_10.z = 0
				var_122_10.x = 0
				var_122_4.localEulerAngles = var_122_10
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_122_11 = manager.ui.mainCamera.transform.position - var_122_4.position

				var_122_4.forward = Vector3.New(var_122_11.x, var_122_11.y, var_122_11.z)

				local var_122_12 = var_122_4.localEulerAngles

				var_122_12.z = 0
				var_122_12.x = 0
				var_122_4.localEulerAngles = var_122_12
			end

			local var_122_13 = 0
			local var_122_14 = 0.1

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_15 = arg_119_1:FormatText(StoryNameCfg[692].name)

				arg_119_1.leftNameTxt_.text = var_122_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_16 = arg_119_1:GetWordFromCfg(319001028)
				local var_122_17 = arg_119_1:FormatText(var_122_16.content)

				arg_119_1.text_.text = var_122_17

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_18 = 4
				local var_122_19 = utf8.len(var_122_17)
				local var_122_20 = var_122_18 <= 0 and var_122_14 or var_122_14 * (var_122_19 / var_122_18)

				if var_122_20 > 0 and var_122_14 < var_122_20 then
					arg_119_1.talkMaxDuration = var_122_20

					if var_122_20 + var_122_13 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_13
					end
				end

				arg_119_1.text_.text = var_122_17
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001028", "story_v_out_319001.awb") ~= 0 then
					local var_122_21 = manager.audio:GetVoiceLength("story_v_out_319001", "319001028", "story_v_out_319001.awb") / 1000

					if var_122_21 + var_122_13 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_21 + var_122_13
					end

					if var_122_16.prefab_name ~= "" and arg_119_1.actors_[var_122_16.prefab_name] ~= nil then
						local var_122_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_16.prefab_name].transform, "story_v_out_319001", "319001028", "story_v_out_319001.awb")

						arg_119_1:RecordAudio("319001028", var_122_22)
						arg_119_1:RecordAudio("319001028", var_122_22)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319001", "319001028", "story_v_out_319001.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319001", "319001028", "story_v_out_319001.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_23 = math.max(var_122_14, arg_119_1.talkMaxDuration)

			if var_122_13 <= arg_119_1.time_ and arg_119_1.time_ < var_122_13 + var_122_23 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_13) / var_122_23

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_13 + var_122_23 and arg_119_1.time_ < var_122_13 + var_122_23 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play319001029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319001029
		arg_123_1.duration_ = 7.63

		local var_123_0 = {
			zh = 6.133,
			ja = 7.633
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
				arg_123_0:Play319001030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10075ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10075ui_story == nil then
				arg_123_1.var_.characterEffect10075ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10075ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10075ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10075ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10075ui_story.fillRatio = var_126_5
			end

			local var_126_6 = arg_123_1.actors_["10069ui_story"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect10069ui_story == nil then
				arg_123_1.var_.characterEffect10069ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_8 and not isNil(var_126_6) then
				local var_126_9 = (arg_123_1.time_ - var_126_7) / var_126_8

				if arg_123_1.var_.characterEffect10069ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_8 and arg_123_1.time_ < var_126_7 + var_126_8 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect10069ui_story then
				arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_126_10 = arg_123_1.actors_["10069ui_story"].transform
			local var_126_11 = 0

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.var_.moveOldPos10069ui_story = var_126_10.localPosition
			end

			local var_126_12 = 0.001

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_11) / var_126_12
				local var_126_14 = Vector3.New(0.7, -1.08, -6.33)

				var_126_10.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10069ui_story, var_126_14, var_126_13)

				local var_126_15 = manager.ui.mainCamera.transform.position - var_126_10.position

				var_126_10.forward = Vector3.New(var_126_15.x, var_126_15.y, var_126_15.z)

				local var_126_16 = var_126_10.localEulerAngles

				var_126_16.z = 0
				var_126_16.x = 0
				var_126_10.localEulerAngles = var_126_16
			end

			if arg_123_1.time_ >= var_126_11 + var_126_12 and arg_123_1.time_ < var_126_11 + var_126_12 + arg_126_0 then
				var_126_10.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_126_17 = manager.ui.mainCamera.transform.position - var_126_10.position

				var_126_10.forward = Vector3.New(var_126_17.x, var_126_17.y, var_126_17.z)

				local var_126_18 = var_126_10.localEulerAngles

				var_126_18.z = 0
				var_126_18.x = 0
				var_126_10.localEulerAngles = var_126_18
			end

			local var_126_19 = arg_123_1.actors_["10075ui_story"].transform
			local var_126_20 = 0

			if var_126_20 < arg_123_1.time_ and arg_123_1.time_ <= var_126_20 + arg_126_0 then
				arg_123_1.var_.moveOldPos10075ui_story = var_126_19.localPosition
			end

			local var_126_21 = 0.001

			if var_126_20 <= arg_123_1.time_ and arg_123_1.time_ < var_126_20 + var_126_21 then
				local var_126_22 = (arg_123_1.time_ - var_126_20) / var_126_21
				local var_126_23 = Vector3.New(-0.7, -0.715, -6.15)

				var_126_19.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10075ui_story, var_126_23, var_126_22)

				local var_126_24 = manager.ui.mainCamera.transform.position - var_126_19.position

				var_126_19.forward = Vector3.New(var_126_24.x, var_126_24.y, var_126_24.z)

				local var_126_25 = var_126_19.localEulerAngles

				var_126_25.z = 0
				var_126_25.x = 0
				var_126_19.localEulerAngles = var_126_25
			end

			if arg_123_1.time_ >= var_126_20 + var_126_21 and arg_123_1.time_ < var_126_20 + var_126_21 + arg_126_0 then
				var_126_19.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_126_26 = manager.ui.mainCamera.transform.position - var_126_19.position

				var_126_19.forward = Vector3.New(var_126_26.x, var_126_26.y, var_126_26.z)

				local var_126_27 = var_126_19.localEulerAngles

				var_126_27.z = 0
				var_126_27.x = 0
				var_126_19.localEulerAngles = var_126_27
			end

			local var_126_28 = 0

			if var_126_28 < arg_123_1.time_ and arg_123_1.time_ <= var_126_28 + arg_126_0 then
				arg_123_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_2")
			end

			local var_126_29 = 0
			local var_126_30 = 0.625

			if var_126_29 < arg_123_1.time_ and arg_123_1.time_ <= var_126_29 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_31 = arg_123_1:FormatText(StoryNameCfg[693].name)

				arg_123_1.leftNameTxt_.text = var_126_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_32 = arg_123_1:GetWordFromCfg(319001029)
				local var_126_33 = arg_123_1:FormatText(var_126_32.content)

				arg_123_1.text_.text = var_126_33

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_34 = 25
				local var_126_35 = utf8.len(var_126_33)
				local var_126_36 = var_126_34 <= 0 and var_126_30 or var_126_30 * (var_126_35 / var_126_34)

				if var_126_36 > 0 and var_126_30 < var_126_36 then
					arg_123_1.talkMaxDuration = var_126_36

					if var_126_36 + var_126_29 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_36 + var_126_29
					end
				end

				arg_123_1.text_.text = var_126_33
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001029", "story_v_out_319001.awb") ~= 0 then
					local var_126_37 = manager.audio:GetVoiceLength("story_v_out_319001", "319001029", "story_v_out_319001.awb") / 1000

					if var_126_37 + var_126_29 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_37 + var_126_29
					end

					if var_126_32.prefab_name ~= "" and arg_123_1.actors_[var_126_32.prefab_name] ~= nil then
						local var_126_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_32.prefab_name].transform, "story_v_out_319001", "319001029", "story_v_out_319001.awb")

						arg_123_1:RecordAudio("319001029", var_126_38)
						arg_123_1:RecordAudio("319001029", var_126_38)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319001", "319001029", "story_v_out_319001.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319001", "319001029", "story_v_out_319001.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_39 = math.max(var_126_30, arg_123_1.talkMaxDuration)

			if var_126_29 <= arg_123_1.time_ and arg_123_1.time_ < var_126_29 + var_126_39 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_29) / var_126_39

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_29 + var_126_39 and arg_123_1.time_ < var_126_29 + var_126_39 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play319001030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319001030
		arg_127_1.duration_ = 9

		local var_127_0 = {
			zh = 4.8,
			ja = 9
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
				arg_127_0:Play319001031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10075ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10075ui_story == nil then
				arg_127_1.var_.characterEffect10075ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10075ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10075ui_story then
				arg_127_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["10069ui_story"]
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect10069ui_story == nil then
				arg_127_1.var_.characterEffect10069ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 and not isNil(var_130_4) then
				local var_130_7 = (arg_127_1.time_ - var_130_5) / var_130_6

				if arg_127_1.var_.characterEffect10069ui_story and not isNil(var_130_4) then
					local var_130_8 = Mathf.Lerp(0, 0.5, var_130_7)

					arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10069ui_story.fillRatio = var_130_8
				end
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect10069ui_story then
				local var_130_9 = 0.5

				arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10069ui_story.fillRatio = var_130_9
			end

			local var_130_10 = 0
			local var_130_11 = 0.45

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_12 = arg_127_1:FormatText(StoryNameCfg[692].name)

				arg_127_1.leftNameTxt_.text = var_130_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(319001030)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 18
				local var_130_16 = utf8.len(var_130_14)
				local var_130_17 = var_130_15 <= 0 and var_130_11 or var_130_11 * (var_130_16 / var_130_15)

				if var_130_17 > 0 and var_130_11 < var_130_17 then
					arg_127_1.talkMaxDuration = var_130_17

					if var_130_17 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001030", "story_v_out_319001.awb") ~= 0 then
					local var_130_18 = manager.audio:GetVoiceLength("story_v_out_319001", "319001030", "story_v_out_319001.awb") / 1000

					if var_130_18 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_10
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_319001", "319001030", "story_v_out_319001.awb")

						arg_127_1:RecordAudio("319001030", var_130_19)
						arg_127_1:RecordAudio("319001030", var_130_19)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319001", "319001030", "story_v_out_319001.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319001", "319001030", "story_v_out_319001.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_20 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_20 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_10) / var_130_20

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_10 + var_130_20 and arg_127_1.time_ < var_130_10 + var_130_20 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319001031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319001031
		arg_131_1.duration_ = 5.13

		local var_131_0 = {
			zh = 5.133,
			ja = 1.533
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
				arg_131_0:Play319001032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10075ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10075ui_story == nil then
				arg_131_1.var_.characterEffect10075ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect10075ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10075ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10075ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10075ui_story.fillRatio = var_134_5
			end

			local var_134_6 = arg_131_1.actors_["10069ui_story"]
			local var_134_7 = 0

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect10069ui_story == nil then
				arg_131_1.var_.characterEffect10069ui_story = var_134_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_8 = 0.200000002980232

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 and not isNil(var_134_6) then
				local var_134_9 = (arg_131_1.time_ - var_134_7) / var_134_8

				if arg_131_1.var_.characterEffect10069ui_story and not isNil(var_134_6) then
					arg_131_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect10069ui_story then
				arg_131_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_134_10 = 0
			local var_134_11 = 0.625

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_12 = arg_131_1:FormatText(StoryNameCfg[693].name)

				arg_131_1.leftNameTxt_.text = var_134_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(319001031)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_15 = 25
				local var_134_16 = utf8.len(var_134_14)
				local var_134_17 = var_134_15 <= 0 and var_134_11 or var_134_11 * (var_134_16 / var_134_15)

				if var_134_17 > 0 and var_134_11 < var_134_17 then
					arg_131_1.talkMaxDuration = var_134_17

					if var_134_17 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_10
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001031", "story_v_out_319001.awb") ~= 0 then
					local var_134_18 = manager.audio:GetVoiceLength("story_v_out_319001", "319001031", "story_v_out_319001.awb") / 1000

					if var_134_18 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_18 + var_134_10
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_out_319001", "319001031", "story_v_out_319001.awb")

						arg_131_1:RecordAudio("319001031", var_134_19)
						arg_131_1:RecordAudio("319001031", var_134_19)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319001", "319001031", "story_v_out_319001.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319001", "319001031", "story_v_out_319001.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_20 = math.max(var_134_11, arg_131_1.talkMaxDuration)

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_20 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_10) / var_134_20

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_10 + var_134_20 and arg_131_1.time_ < var_134_10 + var_134_20 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319001032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319001032
		arg_135_1.duration_ = 3.6

		local var_135_0 = {
			zh = 2.3,
			ja = 3.6
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
				arg_135_0:Play319001033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10075ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10075ui_story == nil then
				arg_135_1.var_.characterEffect10075ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10075ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10075ui_story then
				arg_135_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_138_4 = arg_135_1.actors_["10069ui_story"]
			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect10069ui_story == nil then
				arg_135_1.var_.characterEffect10069ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.200000002980232

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_6 and not isNil(var_138_4) then
				local var_138_7 = (arg_135_1.time_ - var_138_5) / var_138_6

				if arg_135_1.var_.characterEffect10069ui_story and not isNil(var_138_4) then
					local var_138_8 = Mathf.Lerp(0, 0.5, var_138_7)

					arg_135_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10069ui_story.fillRatio = var_138_8
				end
			end

			if arg_135_1.time_ >= var_138_5 + var_138_6 and arg_135_1.time_ < var_138_5 + var_138_6 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect10069ui_story then
				local var_138_9 = 0.5

				arg_135_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10069ui_story.fillRatio = var_138_9
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			local var_138_11 = 0

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_138_12 = 0
			local var_138_13 = 0.225

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[692].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(319001032)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 9
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001032", "story_v_out_319001.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_319001", "319001032", "story_v_out_319001.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_319001", "319001032", "story_v_out_319001.awb")

						arg_135_1:RecordAudio("319001032", var_138_21)
						arg_135_1:RecordAudio("319001032", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319001", "319001032", "story_v_out_319001.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319001", "319001032", "story_v_out_319001.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319001033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319001033
		arg_139_1.duration_ = 4.03

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_139_0:Play319001034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10069ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10069ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0.7, -1.08, -6.33)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10069ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10069ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10069ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10069ui_story then
				arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_14 = arg_139_1.actors_["10075ui_story"]
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect10075ui_story == nil then
				arg_139_1.var_.characterEffect10075ui_story = var_142_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_16 = 0.200000002980232

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 and not isNil(var_142_14) then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16

				if arg_139_1.var_.characterEffect10075ui_story and not isNil(var_142_14) then
					local var_142_18 = Mathf.Lerp(0, 0.5, var_142_17)

					arg_139_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10075ui_story.fillRatio = var_142_18
				end
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect10075ui_story then
				local var_142_19 = 0.5

				arg_139_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10075ui_story.fillRatio = var_142_19
			end

			local var_142_20 = 0
			local var_142_21 = 0.2

			if var_142_20 < arg_139_1.time_ and arg_139_1.time_ <= var_142_20 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_22 = arg_139_1:FormatText(StoryNameCfg[693].name)

				arg_139_1.leftNameTxt_.text = var_142_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_23 = arg_139_1:GetWordFromCfg(319001033)
				local var_142_24 = arg_139_1:FormatText(var_142_23.content)

				arg_139_1.text_.text = var_142_24

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_25 = 8
				local var_142_26 = utf8.len(var_142_24)
				local var_142_27 = var_142_25 <= 0 and var_142_21 or var_142_21 * (var_142_26 / var_142_25)

				if var_142_27 > 0 and var_142_21 < var_142_27 then
					arg_139_1.talkMaxDuration = var_142_27

					if var_142_27 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_27 + var_142_20
					end
				end

				arg_139_1.text_.text = var_142_24
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001033", "story_v_out_319001.awb") ~= 0 then
					local var_142_28 = manager.audio:GetVoiceLength("story_v_out_319001", "319001033", "story_v_out_319001.awb") / 1000

					if var_142_28 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_20
					end

					if var_142_23.prefab_name ~= "" and arg_139_1.actors_[var_142_23.prefab_name] ~= nil then
						local var_142_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_23.prefab_name].transform, "story_v_out_319001", "319001033", "story_v_out_319001.awb")

						arg_139_1:RecordAudio("319001033", var_142_29)
						arg_139_1:RecordAudio("319001033", var_142_29)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319001", "319001033", "story_v_out_319001.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319001", "319001033", "story_v_out_319001.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_30 = math.max(var_142_21, arg_139_1.talkMaxDuration)

			if var_142_20 <= arg_139_1.time_ and arg_139_1.time_ < var_142_20 + var_142_30 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_20) / var_142_30

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_20 + var_142_30 and arg_139_1.time_ < var_142_20 + var_142_30 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play319001034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319001034
		arg_143_1.duration_ = 8.9

		local var_143_0 = {
			zh = 4.966,
			ja = 8.9
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
				arg_143_0:Play319001035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10075ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10075ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10075ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["10075ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect10075ui_story == nil then
				arg_143_1.var_.characterEffect10075ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect10075ui_story and not isNil(var_146_9) then
					arg_143_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect10075ui_story then
				arg_143_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_146_13 = 0

			if var_146_13 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_15 = arg_143_1.actors_["10069ui_story"]
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 and not isNil(var_146_15) and arg_143_1.var_.characterEffect10069ui_story == nil then
				arg_143_1.var_.characterEffect10069ui_story = var_146_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_17 = 0.200000002980232

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 and not isNil(var_146_15) then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17

				if arg_143_1.var_.characterEffect10069ui_story and not isNil(var_146_15) then
					local var_146_19 = Mathf.Lerp(0, 0.5, var_146_18)

					arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10069ui_story.fillRatio = var_146_19
				end
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 and not isNil(var_146_15) and arg_143_1.var_.characterEffect10069ui_story then
				local var_146_20 = 0.5

				arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10069ui_story.fillRatio = var_146_20
			end

			local var_146_21 = 0
			local var_146_22 = 0.45

			if var_146_21 < arg_143_1.time_ and arg_143_1.time_ <= var_146_21 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_23 = arg_143_1:FormatText(StoryNameCfg[692].name)

				arg_143_1.leftNameTxt_.text = var_146_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_24 = arg_143_1:GetWordFromCfg(319001034)
				local var_146_25 = arg_143_1:FormatText(var_146_24.content)

				arg_143_1.text_.text = var_146_25

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_26 = 18
				local var_146_27 = utf8.len(var_146_25)
				local var_146_28 = var_146_26 <= 0 and var_146_22 or var_146_22 * (var_146_27 / var_146_26)

				if var_146_28 > 0 and var_146_22 < var_146_28 then
					arg_143_1.talkMaxDuration = var_146_28

					if var_146_28 + var_146_21 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_28 + var_146_21
					end
				end

				arg_143_1.text_.text = var_146_25
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001034", "story_v_out_319001.awb") ~= 0 then
					local var_146_29 = manager.audio:GetVoiceLength("story_v_out_319001", "319001034", "story_v_out_319001.awb") / 1000

					if var_146_29 + var_146_21 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_29 + var_146_21
					end

					if var_146_24.prefab_name ~= "" and arg_143_1.actors_[var_146_24.prefab_name] ~= nil then
						local var_146_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_24.prefab_name].transform, "story_v_out_319001", "319001034", "story_v_out_319001.awb")

						arg_143_1:RecordAudio("319001034", var_146_30)
						arg_143_1:RecordAudio("319001034", var_146_30)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319001", "319001034", "story_v_out_319001.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319001", "319001034", "story_v_out_319001.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_31 = math.max(var_146_22, arg_143_1.talkMaxDuration)

			if var_146_21 <= arg_143_1.time_ and arg_143_1.time_ < var_146_21 + var_146_31 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_21) / var_146_31

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_21 + var_146_31 and arg_143_1.time_ < var_146_21 + var_146_31 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play319001035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319001035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319001036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10075ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10075ui_story == nil then
				arg_147_1.var_.characterEffect10075ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10075ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10075ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10075ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10075ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 1.1

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(319001035)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 44
				local var_150_11 = utf8.len(var_150_9)
				local var_150_12 = var_150_10 <= 0 and var_150_7 or var_150_7 * (var_150_11 / var_150_10)

				if var_150_12 > 0 and var_150_7 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_13 and arg_147_1.time_ < var_150_6 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319001036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319001036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319001037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.55

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(319001036)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 62
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319001037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319001037
		arg_155_1.duration_ = 3.67

		local var_155_0 = {
			zh = 3.666,
			ja = 3.6
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
				arg_155_0:Play319001038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10075ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10075ui_story == nil then
				arg_155_1.var_.characterEffect10075ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10075ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10075ui_story then
				arg_155_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_158_4 = 0
			local var_158_5 = 0.325

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_6 = arg_155_1:FormatText(StoryNameCfg[692].name)

				arg_155_1.leftNameTxt_.text = var_158_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(319001037)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 13
				local var_158_10 = utf8.len(var_158_8)
				local var_158_11 = var_158_9 <= 0 and var_158_5 or var_158_5 * (var_158_10 / var_158_9)

				if var_158_11 > 0 and var_158_5 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001037", "story_v_out_319001.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001037", "story_v_out_319001.awb") / 1000

					if var_158_12 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_4
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_319001", "319001037", "story_v_out_319001.awb")

						arg_155_1:RecordAudio("319001037", var_158_13)
						arg_155_1:RecordAudio("319001037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319001", "319001037", "story_v_out_319001.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319001", "319001037", "story_v_out_319001.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_14 and arg_155_1.time_ < var_158_4 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319001038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319001038
		arg_159_1.duration_ = 6.3

		local var_159_0 = {
			zh = 3.066,
			ja = 6.3
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
				arg_159_0:Play319001039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10075ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10075ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10075ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_162_10 = 0
			local var_162_11 = 0.225

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_12 = arg_159_1:FormatText(StoryNameCfg[692].name)

				arg_159_1.leftNameTxt_.text = var_162_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:GetWordFromCfg(319001038)
				local var_162_14 = arg_159_1:FormatText(var_162_13.content)

				arg_159_1.text_.text = var_162_14

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 9
				local var_162_16 = utf8.len(var_162_14)
				local var_162_17 = var_162_15 <= 0 and var_162_11 or var_162_11 * (var_162_16 / var_162_15)

				if var_162_17 > 0 and var_162_11 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_10
					end
				end

				arg_159_1.text_.text = var_162_14
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001038", "story_v_out_319001.awb") ~= 0 then
					local var_162_18 = manager.audio:GetVoiceLength("story_v_out_319001", "319001038", "story_v_out_319001.awb") / 1000

					if var_162_18 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_10
					end

					if var_162_13.prefab_name ~= "" and arg_159_1.actors_[var_162_13.prefab_name] ~= nil then
						local var_162_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_13.prefab_name].transform, "story_v_out_319001", "319001038", "story_v_out_319001.awb")

						arg_159_1:RecordAudio("319001038", var_162_19)
						arg_159_1:RecordAudio("319001038", var_162_19)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319001", "319001038", "story_v_out_319001.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319001", "319001038", "story_v_out_319001.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_20 = math.max(var_162_11, arg_159_1.talkMaxDuration)

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_20 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_10) / var_162_20

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_10 + var_162_20 and arg_159_1.time_ < var_162_10 + var_162_20 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play319001039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319001039
		arg_163_1.duration_ = 8.97

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play319001040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10069ui_story"].transform
			local var_166_1 = 2

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10069ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10069ui_story, var_166_4, var_166_3)

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

			local var_166_9 = arg_163_1.actors_["10075ui_story"].transform
			local var_166_10 = 2

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.var_.moveOldPos10075ui_story = var_166_9.localPosition
			end

			local var_166_11 = 0.001

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11
				local var_166_13 = Vector3.New(0, 100, 0)

				var_166_9.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10075ui_story, var_166_13, var_166_12)

				local var_166_14 = manager.ui.mainCamera.transform.position - var_166_9.position

				var_166_9.forward = Vector3.New(var_166_14.x, var_166_14.y, var_166_14.z)

				local var_166_15 = var_166_9.localEulerAngles

				var_166_15.z = 0
				var_166_15.x = 0
				var_166_9.localEulerAngles = var_166_15
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 then
				var_166_9.localPosition = Vector3.New(0, 100, 0)

				local var_166_16 = manager.ui.mainCamera.transform.position - var_166_9.position

				var_166_9.forward = Vector3.New(var_166_16.x, var_166_16.y, var_166_16.z)

				local var_166_17 = var_166_9.localEulerAngles

				var_166_17.z = 0
				var_166_17.x = 0
				var_166_9.localEulerAngles = var_166_17
			end

			local var_166_18 = 0

			if var_166_18 < arg_163_1.time_ and arg_163_1.time_ <= var_166_18 + arg_166_0 then
				local var_166_19 = manager.ui.mainCamera.transform.localPosition
				local var_166_20 = Vector3.New(0, 0, 10) + Vector3.New(var_166_19.x, var_166_19.y, 0)
				local var_166_21 = arg_163_1.bgs_.ST71

				var_166_21.transform.localPosition = var_166_20
				var_166_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_22 = var_166_21:GetComponent("SpriteRenderer")

				if var_166_22 and var_166_22.sprite then
					local var_166_23 = (var_166_21.transform.localPosition - var_166_19).z
					local var_166_24 = manager.ui.mainCameraCom_
					local var_166_25 = 2 * var_166_23 * Mathf.Tan(var_166_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_166_26 = var_166_25 * var_166_24.aspect
					local var_166_27 = var_166_22.sprite.bounds.size.x
					local var_166_28 = var_166_22.sprite.bounds.size.y
					local var_166_29 = var_166_26 / var_166_27
					local var_166_30 = var_166_25 / var_166_28
					local var_166_31 = var_166_30 < var_166_29 and var_166_29 or var_166_30

					var_166_21.transform.localScale = Vector3.New(var_166_31, var_166_31, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "ST71" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_32 = 2

			if var_166_32 < arg_163_1.time_ and arg_163_1.time_ <= var_166_32 + arg_166_0 then
				local var_166_33 = manager.ui.mainCamera.transform.localPosition
				local var_166_34 = Vector3.New(0, 0, 10) + Vector3.New(var_166_33.x, var_166_33.y, 0)
				local var_166_35 = arg_163_1.bgs_.ST71

				var_166_35.transform.localPosition = var_166_34
				var_166_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_36 = var_166_35:GetComponent("SpriteRenderer")

				if var_166_36 and var_166_36.sprite then
					local var_166_37 = (var_166_35.transform.localPosition - var_166_33).z
					local var_166_38 = manager.ui.mainCameraCom_
					local var_166_39 = 2 * var_166_37 * Mathf.Tan(var_166_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_166_40 = var_166_39 * var_166_38.aspect
					local var_166_41 = var_166_36.sprite.bounds.size.x
					local var_166_42 = var_166_36.sprite.bounds.size.y
					local var_166_43 = var_166_40 / var_166_41
					local var_166_44 = var_166_39 / var_166_42
					local var_166_45 = var_166_44 < var_166_43 and var_166_43 or var_166_44

					var_166_35.transform.localScale = Vector3.New(var_166_45, var_166_45, 0)
				end

				for iter_166_2, iter_166_3 in pairs(arg_163_1.bgs_) do
					if iter_166_2 ~= "ST71" then
						iter_166_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_46 = 0

			if var_166_46 < arg_163_1.time_ and arg_163_1.time_ <= var_166_46 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_47 = 2

			if var_166_46 <= arg_163_1.time_ and arg_163_1.time_ < var_166_46 + var_166_47 then
				local var_166_48 = (arg_163_1.time_ - var_166_46) / var_166_47
				local var_166_49 = Color.New(0, 0, 0)

				var_166_49.a = Mathf.Lerp(0, 1, var_166_48)
				arg_163_1.mask_.color = var_166_49
			end

			if arg_163_1.time_ >= var_166_46 + var_166_47 and arg_163_1.time_ < var_166_46 + var_166_47 + arg_166_0 then
				local var_166_50 = Color.New(0, 0, 0)

				var_166_50.a = 1
				arg_163_1.mask_.color = var_166_50
			end

			local var_166_51 = 2

			if var_166_51 < arg_163_1.time_ and arg_163_1.time_ <= var_166_51 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_52 = 1.96666666666667

			if var_166_51 <= arg_163_1.time_ and arg_163_1.time_ < var_166_51 + var_166_52 then
				local var_166_53 = (arg_163_1.time_ - var_166_51) / var_166_52
				local var_166_54 = Color.New(0, 0, 0)

				var_166_54.a = Mathf.Lerp(1, 0, var_166_53)
				arg_163_1.mask_.color = var_166_54
			end

			if arg_163_1.time_ >= var_166_51 + var_166_52 and arg_163_1.time_ < var_166_51 + var_166_52 + arg_166_0 then
				local var_166_55 = Color.New(0, 0, 0)
				local var_166_56 = 0

				arg_163_1.mask_.enabled = false
				var_166_55.a = var_166_56
				arg_163_1.mask_.color = var_166_55
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_57 = 3.96666666666667
			local var_166_58 = 0.875

			if var_166_57 < arg_163_1.time_ and arg_163_1.time_ <= var_166_57 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_59 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_59:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_60 = arg_163_1:GetWordFromCfg(319001039)
				local var_166_61 = arg_163_1:FormatText(var_166_60.content)

				arg_163_1.text_.text = var_166_61

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_62 = 35
				local var_166_63 = utf8.len(var_166_61)
				local var_166_64 = var_166_62 <= 0 and var_166_58 or var_166_58 * (var_166_63 / var_166_62)

				if var_166_64 > 0 and var_166_58 < var_166_64 then
					arg_163_1.talkMaxDuration = var_166_64
					var_166_57 = var_166_57 + 0.3

					if var_166_64 + var_166_57 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_64 + var_166_57
					end
				end

				arg_163_1.text_.text = var_166_61
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_65 = var_166_57 + 0.3
			local var_166_66 = math.max(var_166_58, arg_163_1.talkMaxDuration)

			if var_166_65 <= arg_163_1.time_ and arg_163_1.time_ < var_166_65 + var_166_66 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_65) / var_166_66

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_65 + var_166_66 and arg_163_1.time_ < var_166_65 + var_166_66 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play319001040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319001040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319001041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.975

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(319001040)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 39
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319001041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319001041
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319001042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10075ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10075ui_story == nil then
				arg_173_1.var_.characterEffect10075ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect10075ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10075ui_story then
				arg_173_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["10075ui_story"].transform
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.var_.moveOldPos10075ui_story = var_176_4.localPosition
			end

			local var_176_6 = 0.001

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6
				local var_176_8 = Vector3.New(0, -0.715, -6.15)

				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10075ui_story, var_176_8, var_176_7)

				local var_176_9 = manager.ui.mainCamera.transform.position - var_176_4.position

				var_176_4.forward = Vector3.New(var_176_9.x, var_176_9.y, var_176_9.z)

				local var_176_10 = var_176_4.localEulerAngles

				var_176_10.z = 0
				var_176_10.x = 0
				var_176_4.localEulerAngles = var_176_10
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_176_11 = manager.ui.mainCamera.transform.position - var_176_4.position

				var_176_4.forward = Vector3.New(var_176_11.x, var_176_11.y, var_176_11.z)

				local var_176_12 = var_176_4.localEulerAngles

				var_176_12.z = 0
				var_176_12.x = 0
				var_176_4.localEulerAngles = var_176_12
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_15 = 0
			local var_176_16 = 0.125

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[692].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(319001041)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 5
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001041", "story_v_out_319001.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_out_319001", "319001041", "story_v_out_319001.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_out_319001", "319001041", "story_v_out_319001.awb")

						arg_173_1:RecordAudio("319001041", var_176_24)
						arg_173_1:RecordAudio("319001041", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319001", "319001041", "story_v_out_319001.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319001", "319001041", "story_v_out_319001.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319001042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319001042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319001043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10075ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10075ui_story == nil then
				arg_177_1.var_.characterEffect10075ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10075ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10075ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10075ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10075ui_story.fillRatio = var_180_5
			end

			local var_180_6 = 0
			local var_180_7 = 1

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(319001042)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 40
				local var_180_11 = utf8.len(var_180_9)
				local var_180_12 = var_180_10 <= 0 and var_180_7 or var_180_7 * (var_180_11 / var_180_10)

				if var_180_12 > 0 and var_180_7 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_13 and arg_177_1.time_ < var_180_6 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319001043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319001043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319001044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(319001043)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 40
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319001044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319001044
		arg_185_1.duration_ = 4

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319001045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 2

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_1 = manager.ui.mainCamera.transform.localPosition
				local var_188_2 = Vector3.New(0, 0, 10) + Vector3.New(var_188_1.x, var_188_1.y, 0)
				local var_188_3 = arg_185_1.bgs_.STblack

				var_188_3.transform.localPosition = var_188_2
				var_188_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_4 = var_188_3:GetComponent("SpriteRenderer")

				if var_188_4 and var_188_4.sprite then
					local var_188_5 = (var_188_3.transform.localPosition - var_188_1).z
					local var_188_6 = manager.ui.mainCameraCom_
					local var_188_7 = 2 * var_188_5 * Mathf.Tan(var_188_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_8 = var_188_7 * var_188_6.aspect
					local var_188_9 = var_188_4.sprite.bounds.size.x
					local var_188_10 = var_188_4.sprite.bounds.size.y
					local var_188_11 = var_188_8 / var_188_9
					local var_188_12 = var_188_7 / var_188_10
					local var_188_13 = var_188_12 < var_188_11 and var_188_11 or var_188_12

					var_188_3.transform.localScale = Vector3.New(var_188_13, var_188_13, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "STblack" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_15 = 2

			if var_188_14 <= arg_185_1.time_ and arg_185_1.time_ < var_188_14 + var_188_15 then
				local var_188_16 = (arg_185_1.time_ - var_188_14) / var_188_15
				local var_188_17 = Color.New(0, 0, 0)

				var_188_17.a = Mathf.Lerp(0, 1, var_188_16)
				arg_185_1.mask_.color = var_188_17
			end

			if arg_185_1.time_ >= var_188_14 + var_188_15 and arg_185_1.time_ < var_188_14 + var_188_15 + arg_188_0 then
				local var_188_18 = Color.New(0, 0, 0)

				var_188_18.a = 1
				arg_185_1.mask_.color = var_188_18
			end

			local var_188_19 = 2

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_20 = 2

			if var_188_19 <= arg_185_1.time_ and arg_185_1.time_ < var_188_19 + var_188_20 then
				local var_188_21 = (arg_185_1.time_ - var_188_19) / var_188_20
				local var_188_22 = Color.New(0, 0, 0)

				var_188_22.a = Mathf.Lerp(1, 0, var_188_21)
				arg_185_1.mask_.color = var_188_22
			end

			if arg_185_1.time_ >= var_188_19 + var_188_20 and arg_185_1.time_ < var_188_19 + var_188_20 + arg_188_0 then
				local var_188_23 = Color.New(0, 0, 0)
				local var_188_24 = 0

				arg_185_1.mask_.enabled = false
				var_188_23.a = var_188_24
				arg_185_1.mask_.color = var_188_23
			end

			local var_188_25 = 0
			local var_188_26 = 1

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 then
				local var_188_27 = "stop"
				local var_188_28 = "effect"

				arg_185_1:AudioAction(var_188_27, var_188_28, "se_story_side_1055", "se_story_side_1055_rain", "")
			end

			local var_188_29 = arg_185_1.actors_["10075ui_story"].transform
			local var_188_30 = 2

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.var_.moveOldPos10075ui_story = var_188_29.localPosition
			end

			local var_188_31 = 0.001

			if var_188_30 <= arg_185_1.time_ and arg_185_1.time_ < var_188_30 + var_188_31 then
				local var_188_32 = (arg_185_1.time_ - var_188_30) / var_188_31
				local var_188_33 = Vector3.New(0, 100, 0)

				var_188_29.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10075ui_story, var_188_33, var_188_32)

				local var_188_34 = manager.ui.mainCamera.transform.position - var_188_29.position

				var_188_29.forward = Vector3.New(var_188_34.x, var_188_34.y, var_188_34.z)

				local var_188_35 = var_188_29.localEulerAngles

				var_188_35.z = 0
				var_188_35.x = 0
				var_188_29.localEulerAngles = var_188_35
			end

			if arg_185_1.time_ >= var_188_30 + var_188_31 and arg_185_1.time_ < var_188_30 + var_188_31 + arg_188_0 then
				var_188_29.localPosition = Vector3.New(0, 100, 0)

				local var_188_36 = manager.ui.mainCamera.transform.position - var_188_29.position

				var_188_29.forward = Vector3.New(var_188_36.x, var_188_36.y, var_188_36.z)

				local var_188_37 = var_188_29.localEulerAngles

				var_188_37.z = 0
				var_188_37.x = 0
				var_188_29.localEulerAngles = var_188_37
			end

			local var_188_38 = 2

			if var_188_38 < arg_185_1.time_ and arg_185_1.time_ <= var_188_38 + arg_188_0 then
				arg_185_1.fswbg_:SetActive(true)
				arg_185_1.dialog_:SetActive(false)

				arg_185_1.fswtw_.percent = 0

				local var_188_39 = arg_185_1:GetWordFromCfg(319001044)
				local var_188_40 = arg_185_1:FormatText(var_188_39.content)

				arg_185_1.fswt_.text = var_188_40

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.fswt_)

				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_185_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_185_1.fswtw_:SetDirty()

				arg_185_1.typewritterCharCountI18N = 0

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_41 = 2.33333333333333

			if var_188_41 < arg_185_1.time_ and arg_185_1.time_ <= var_188_41 + arg_188_0 then
				arg_185_1.var_.oldValueTypewriter = arg_185_1.fswtw_.percent

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_42 = 5
			local var_188_43 = 0.333333333333333
			local var_188_44 = arg_185_1:GetWordFromCfg(319001044)
			local var_188_45 = arg_185_1:FormatText(var_188_44.content)
			local var_188_46, var_188_47 = arg_185_1:GetPercentByPara(var_188_45, 1)

			if var_188_41 < arg_185_1.time_ and arg_185_1.time_ <= var_188_41 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				local var_188_48 = var_188_42 <= 0 and var_188_43 or var_188_43 * ((var_188_47 - arg_185_1.typewritterCharCountI18N) / var_188_42)

				if var_188_48 > 0 and var_188_43 < var_188_48 then
					arg_185_1.talkMaxDuration = var_188_48

					if var_188_48 + var_188_41 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_48 + var_188_41
					end
				end
			end

			local var_188_49 = 0.333333333333333
			local var_188_50 = math.max(var_188_49, arg_185_1.talkMaxDuration)

			if var_188_41 <= arg_185_1.time_ and arg_185_1.time_ < var_188_41 + var_188_50 then
				local var_188_51 = (arg_185_1.time_ - var_188_41) / var_188_50

				arg_185_1.fswtw_.percent = Mathf.Lerp(arg_185_1.var_.oldValueTypewriter, var_188_46, var_188_51)
				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_185_1.fswtw_:SetDirty()
			end

			if arg_185_1.time_ >= var_188_41 + var_188_50 and arg_185_1.time_ < var_188_41 + var_188_50 + arg_188_0 then
				arg_185_1.fswtw_.percent = var_188_46

				arg_185_1.fswtw_:SetDirty()
				arg_185_1:ShowNextGo(true)

				arg_185_1.typewritterCharCountI18N = var_188_47
			end

			local var_188_52 = 2.33333333333333

			if var_188_52 < arg_185_1.time_ and arg_185_1.time_ <= var_188_52 + arg_188_0 then
				local var_188_53 = arg_185_1.fswbg_.transform:Find("textbox/adapt/content") or arg_185_1.fswbg_.transform:Find("textbox/content")
				local var_188_54 = arg_185_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_188_55 = var_188_53:GetComponent("Text")
				local var_188_56 = var_188_53:GetComponent("RectTransform")

				var_188_55.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_188_56.offsetMin = Vector2.New(0, 0)
				var_188_56.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play319001045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319001045
		arg_189_1.duration_ = 1

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319001046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.var_.oldValueTypewriter = arg_189_1.fswtw_.percent

				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_189_1:ShowNextGo(false)
			end

			local var_192_1 = 6
			local var_192_2 = 0.4
			local var_192_3 = arg_189_1:GetWordFromCfg(319001044)
			local var_192_4 = arg_189_1:FormatText(var_192_3.content)
			local var_192_5, var_192_6 = arg_189_1:GetPercentByPara(var_192_4, 2)

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				local var_192_7 = var_192_1 <= 0 and var_192_2 or var_192_2 * ((var_192_6 - arg_189_1.typewritterCharCountI18N) / var_192_1)

				if var_192_7 > 0 and var_192_2 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end
			end

			local var_192_8 = 0.4
			local var_192_9 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_9 then
				local var_192_10 = (arg_189_1.time_ - var_192_0) / var_192_9

				arg_189_1.fswtw_.percent = Mathf.Lerp(arg_189_1.var_.oldValueTypewriter, var_192_5, var_192_10)
				arg_189_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_189_1.fswtw_:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_9 and arg_189_1.time_ < var_192_0 + var_192_9 + arg_192_0 then
				arg_189_1.fswtw_.percent = var_192_5

				arg_189_1.fswtw_:SetDirty()
				arg_189_1:ShowNextGo(true)

				arg_189_1.typewritterCharCountI18N = var_192_6
			end

			local var_192_11 = 0

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				local var_192_12 = arg_189_1.fswbg_.transform:Find("textbox/adapt/content") or arg_189_1.fswbg_.transform:Find("textbox/content")
				local var_192_13 = arg_189_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_192_14 = var_192_12:GetComponent("Text")
				local var_192_15 = var_192_12:GetComponent("RectTransform")

				var_192_14.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_192_15.offsetMin = Vector2.New(0, 0)
				var_192_15.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319001046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319001046
		arg_193_1.duration_ = 1

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319001047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.var_.oldValueTypewriter = arg_193_1.fswtw_.percent

				SetActive(arg_193_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_193_1:ShowNextGo(false)
			end

			local var_196_1 = 9
			local var_196_2 = 0.6
			local var_196_3 = arg_193_1:GetWordFromCfg(319001044)
			local var_196_4 = arg_193_1:FormatText(var_196_3.content)
			local var_196_5, var_196_6 = arg_193_1:GetPercentByPara(var_196_4, 3)

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				local var_196_7 = var_196_1 <= 0 and var_196_2 or var_196_2 * ((var_196_6 - arg_193_1.typewritterCharCountI18N) / var_196_1)

				if var_196_7 > 0 and var_196_2 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end
			end

			local var_196_8 = 0.6
			local var_196_9 = math.max(var_196_8, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_9 then
				local var_196_10 = (arg_193_1.time_ - var_196_0) / var_196_9

				arg_193_1.fswtw_.percent = Mathf.Lerp(arg_193_1.var_.oldValueTypewriter, var_196_5, var_196_10)
				arg_193_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_193_1.fswtw_:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_9 and arg_193_1.time_ < var_196_0 + var_196_9 + arg_196_0 then
				arg_193_1.fswtw_.percent = var_196_5

				arg_193_1.fswtw_:SetDirty()
				arg_193_1:ShowNextGo(true)

				arg_193_1.typewritterCharCountI18N = var_196_6
			end

			local var_196_11 = 0

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				local var_196_12 = arg_193_1.fswbg_.transform:Find("textbox/adapt/content") or arg_193_1.fswbg_.transform:Find("textbox/content")
				local var_196_13 = arg_193_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_196_14 = var_196_12:GetComponent("Text")
				local var_196_15 = var_196_12:GetComponent("RectTransform")

				var_196_14.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_196_15.offsetMin = Vector2.New(0, 0)
				var_196_15.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319001047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319001047
		arg_197_1.duration_ = 7.03

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
			arg_197_1.auto_ = false
		end

		function arg_197_1.playNext_(arg_199_0)
			arg_197_1.onStoryFinished_()
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(false)
				arg_197_1.dialog_:SetActive(false)
				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				SetActive(arg_197_1.dialog_, false)
				SetActive(arg_197_1.allBtn_.gameObject, false)
				arg_197_1.hideBtnsController_:SetSelectedIndex(1)
				arg_197_1:PlayOnlyBgm()

				arg_197_1.marker = "stop222"

				manager.video:Play("SofdecAsset/story/story_1031900.usm", function(arg_201_0)
					arg_197_1:Skip(arg_201_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_202_0)
					if arg_202_0 then
						arg_197_1.state_ = "pause"
					else
						arg_197_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_200_2 = 7.03333333333333

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				-- block empty
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				arg_197_1.marker = ""
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ML0101",
		"TextureConfig/Background/ST71",
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1031900.usm"
	},
	voices = {
		"story_v_out_319001.awb"
	},
	skipMarkers = {
		319001047
	}
}
