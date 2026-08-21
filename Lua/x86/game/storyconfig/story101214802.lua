return {
	Play121482001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121482001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121482002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "XH0304"

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
				local var_4_5 = arg_1_1.bgs_.XH0304

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
					if iter_4_0 ~= "XH0304" then
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
			local var_4_23 = 0.266666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.333333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_34 = arg_1_1.bgs_.XH0304.transform
			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0304 = var_4_34.localPosition
			end

			local var_4_36 = 0.001

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_35) / var_4_36
				local var_4_38 = Vector3.New(3.34, 0.92, 3.5)

				var_4_34.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0304, var_4_38, var_4_37)
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				var_4_34.localPosition = Vector3.New(3.34, 0.92, 3.5)
			end

			local var_4_39 = arg_1_1.bgs_.XH0304.transform
			local var_4_40 = 0.0166666666666667

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0304 = var_4_39.localPosition
			end

			local var_4_41 = 3.5

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41
				local var_4_43 = Vector3.New(3.34, 0.92, 3)

				var_4_39.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0304, var_4_43, var_4_42)
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				var_4_39.localPosition = Vector3.New(3.34, 0.92, 3)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 2
			local var_4_45 = 0.925

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(121482001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 37
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0304",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0304",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play121482002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121482002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121482003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.75

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

				local var_12_2 = arg_9_1:GetWordFromCfg(121482002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 70
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
	Play121482003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121482003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play121482004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.975

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

				local var_16_2 = arg_13_1:GetWordFromCfg(121482003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 39
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
	Play121482004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121482004
		arg_17_1.duration_ = 6.5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121482005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = manager.ui.mainCamera.transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.shakeOldPos = var_20_0.localPosition
			end

			local var_20_2 = 1.5

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / 0.066
				local var_20_4, var_20_5 = math.modf(var_20_3)

				var_20_0.localPosition = Vector3.New(var_20_5 * 0.13, var_20_5 * 0.13, var_20_5 * 0.13) + arg_17_1.var_.shakeOldPos
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = arg_17_1.var_.shakeOldPos
			end

			local var_20_6 = 0
			local var_20_7 = 0.433333333333333

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				local var_20_8 = "play"
				local var_20_9 = "effect"

				arg_17_1:AudioAction(var_20_8, var_20_9, "se_story_121_04", "se_story_121_04_metalhit", "")
			end

			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_11 = 1.5

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Color.New(1, 1, 1)

				var_20_13.a = Mathf.Lerp(1, 0, var_20_12)
				arg_17_1.mask_.color = var_20_13
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				local var_20_14 = Color.New(1, 1, 1)
				local var_20_15 = 0

				arg_17_1.mask_.enabled = false
				var_20_14.a = var_20_15
				arg_17_1.mask_.color = var_20_14
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				local var_20_17 = manager.ui.mainCamera.transform.localPosition
				local var_20_18 = Vector3.New(0, 0, 10) + Vector3.New(var_20_17.x, var_20_17.y, 0)
				local var_20_19 = arg_17_1.bgs_.XH0304

				var_20_19.transform.localPosition = var_20_18
				var_20_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_20 = var_20_19:GetComponent("SpriteRenderer")

				if var_20_20 and var_20_20.sprite then
					local var_20_21 = (var_20_19.transform.localPosition - var_20_17).z
					local var_20_22 = manager.ui.mainCameraCom_
					local var_20_23 = 2 * var_20_21 * Mathf.Tan(var_20_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_24 = var_20_23 * var_20_22.aspect
					local var_20_25 = var_20_20.sprite.bounds.size.x
					local var_20_26 = var_20_20.sprite.bounds.size.y
					local var_20_27 = var_20_24 / var_20_25
					local var_20_28 = var_20_23 / var_20_26
					local var_20_29 = var_20_28 < var_20_27 and var_20_27 or var_20_28

					var_20_19.transform.localScale = Vector3.New(var_20_29, var_20_29, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "XH0304" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_30 = 1.5
			local var_20_31 = 0.85

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_32 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_32:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(121482004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 34
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37
					var_20_30 = var_20_30 + 0.3

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_38 = var_20_30 + 0.3
			local var_20_39 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_38 <= arg_17_1.time_ and arg_17_1.time_ < var_20_38 + var_20_39 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_38) / var_20_39

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_38 + var_20_39 and arg_17_1.time_ < var_20_38 + var_20_39 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121482005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 121482005
		arg_23_1.duration_ = 3.87

		local var_23_0 = {
			ja = 3.033,
			ko = 3.866,
			zh = 3.866
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
				arg_23_0:Play121482006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.375

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[378].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_3 = arg_23_1:GetWordFromCfg(121482005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482005", "story_v_out_121482.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482005", "story_v_out_121482.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_121482", "121482005", "story_v_out_121482.awb")

						arg_23_1:RecordAudio("121482005", var_26_9)
						arg_23_1:RecordAudio("121482005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_121482", "121482005", "story_v_out_121482.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_121482", "121482005", "story_v_out_121482.awb")
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
	Play121482006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 121482006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play121482007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.433333333333333

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				local var_30_2 = "play"
				local var_30_3 = "effect"

				arg_27_1:AudioAction(var_30_2, var_30_3, "se_story_121_04", "se_story_121_04_bowhit2", "")
			end

			local var_30_4 = 0
			local var_30_5 = 1

			if var_30_4 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(121482006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_8 = 40
				local var_30_9 = utf8.len(var_30_7)
				local var_30_10 = var_30_8 <= 0 and var_30_5 or var_30_5 * (var_30_9 / var_30_8)

				if var_30_10 > 0 and var_30_5 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_11 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_11 and arg_27_1.time_ < var_30_4 + var_30_11 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play121482007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 121482007
		arg_31_1.duration_ = 4

		local var_31_0 = {
			ja = 4,
			ko = 3.733,
			zh = 3.733
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
				arg_31_0:Play121482008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.5

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[378].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(121482007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 20
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482007", "story_v_out_121482.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482007", "story_v_out_121482.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_121482", "121482007", "story_v_out_121482.awb")

						arg_31_1:RecordAudio("121482007", var_34_9)
						arg_31_1:RecordAudio("121482007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_121482", "121482007", "story_v_out_121482.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_121482", "121482007", "story_v_out_121482.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play121482008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 121482008
		arg_35_1.duration_ = 6.1

		local var_35_0 = {
			ja = 6.1,
			ko = 4.966,
			zh = 4.966
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
				arg_35_0:Play121482009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.375

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[412].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(121482008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482008", "story_v_out_121482.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482008", "story_v_out_121482.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_121482", "121482008", "story_v_out_121482.awb")

						arg_35_1:RecordAudio("121482008", var_38_9)
						arg_35_1:RecordAudio("121482008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_121482", "121482008", "story_v_out_121482.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_121482", "121482008", "story_v_out_121482.awb")
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
	Play121482009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 121482009
		arg_39_1.duration_ = 9.3

		local var_39_0 = {
			ja = 9.3,
			ko = 7,
			zh = 7
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
				arg_39_0:Play121482010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.725

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[412].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(121482009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 29
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482009", "story_v_out_121482.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482009", "story_v_out_121482.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_121482", "121482009", "story_v_out_121482.awb")

						arg_39_1:RecordAudio("121482009", var_42_9)
						arg_39_1:RecordAudio("121482009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_121482", "121482009", "story_v_out_121482.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_121482", "121482009", "story_v_out_121482.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play121482010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 121482010
		arg_43_1.duration_ = 4.93

		local var_43_0 = {
			ja = 4.933,
			ko = 4.566,
			zh = 4.566
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
				arg_43_0:Play121482011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.525

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[378].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(121482010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 21
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482010", "story_v_out_121482.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482010", "story_v_out_121482.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_121482", "121482010", "story_v_out_121482.awb")

						arg_43_1:RecordAudio("121482010", var_46_9)
						arg_43_1:RecordAudio("121482010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_121482", "121482010", "story_v_out_121482.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_121482", "121482010", "story_v_out_121482.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play121482011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 121482011
		arg_47_1.duration_ = 6.33

		local var_47_0 = {
			ja = 6.333,
			ko = 5.6,
			zh = 5.6
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
				arg_47_0:Play121482012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.675

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[378].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(121482011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 27
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482011", "story_v_out_121482.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482011", "story_v_out_121482.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_121482", "121482011", "story_v_out_121482.awb")

						arg_47_1:RecordAudio("121482011", var_50_9)
						arg_47_1:RecordAudio("121482011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_121482", "121482011", "story_v_out_121482.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_121482", "121482011", "story_v_out_121482.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play121482012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 121482012
		arg_51_1.duration_ = 2.1

		local var_51_0 = {
			ja = 1.733,
			ko = 2.1,
			zh = 2.1
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
				arg_51_0:Play121482013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.175

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[412].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(121482012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 7
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482012", "story_v_out_121482.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482012", "story_v_out_121482.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_121482", "121482012", "story_v_out_121482.awb")

						arg_51_1:RecordAudio("121482012", var_54_9)
						arg_51_1:RecordAudio("121482012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_121482", "121482012", "story_v_out_121482.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_121482", "121482012", "story_v_out_121482.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play121482013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 121482013
		arg_55_1.duration_ = 7.6

		local var_55_0 = {
			ja = 3.3,
			ko = 7.6,
			zh = 7.6
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
				arg_55_0:Play121482014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.775

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[378].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(121482013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 31
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482013", "story_v_out_121482.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482013", "story_v_out_121482.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_121482", "121482013", "story_v_out_121482.awb")

						arg_55_1:RecordAudio("121482013", var_58_9)
						arg_55_1:RecordAudio("121482013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_121482", "121482013", "story_v_out_121482.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_121482", "121482013", "story_v_out_121482.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play121482014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 121482014
		arg_59_1.duration_ = 2.27

		local var_59_0 = {
			ja = 1.6,
			ko = 2.266,
			zh = 2.266
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
				arg_59_0:Play121482015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.2

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[412].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(121482014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 8
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482014", "story_v_out_121482.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482014", "story_v_out_121482.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_121482", "121482014", "story_v_out_121482.awb")

						arg_59_1:RecordAudio("121482014", var_62_9)
						arg_59_1:RecordAudio("121482014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_121482", "121482014", "story_v_out_121482.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_121482", "121482014", "story_v_out_121482.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play121482015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 121482015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play121482016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.5

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(121482015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 20
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play121482016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 121482016
		arg_67_1.duration_ = 5

		local var_67_0 = {
			ja = 5,
			ko = 3,
			zh = 3
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
				arg_67_0:Play121482017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.25

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[378].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(121482016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482016", "story_v_out_121482.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482016", "story_v_out_121482.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_121482", "121482016", "story_v_out_121482.awb")

						arg_67_1:RecordAudio("121482016", var_70_9)
						arg_67_1:RecordAudio("121482016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_121482", "121482016", "story_v_out_121482.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_121482", "121482016", "story_v_out_121482.awb")
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
	Play121482017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 121482017
		arg_71_1.duration_ = 7.37

		local var_71_0 = {
			ja = 6.9,
			ko = 7.366,
			zh = 7.366
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
				arg_71_0:Play121482018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.725

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[412].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(121482017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482017", "story_v_out_121482.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482017", "story_v_out_121482.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_121482", "121482017", "story_v_out_121482.awb")

						arg_71_1:RecordAudio("121482017", var_74_9)
						arg_71_1:RecordAudio("121482017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_121482", "121482017", "story_v_out_121482.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_121482", "121482017", "story_v_out_121482.awb")
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
	Play121482018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 121482018
		arg_75_1.duration_ = 5.1

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play121482019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_1 = 2

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_1 then
				local var_78_2 = (arg_75_1.time_ - var_78_0) / var_78_1
				local var_78_3 = Color.New(1, 1, 1)

				var_78_3.a = Mathf.Lerp(0, 1, var_78_2)
				arg_75_1.mask_.color = var_78_3
			end

			if arg_75_1.time_ >= var_78_0 + var_78_1 and arg_75_1.time_ < var_78_0 + var_78_1 + arg_78_0 then
				local var_78_4 = Color.New(1, 1, 1)

				var_78_4.a = 1
				arg_75_1.mask_.color = var_78_4
			end

			local var_78_5 = 2

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_6 = 1

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 then
				local var_78_7 = (arg_75_1.time_ - var_78_5) / var_78_6
				local var_78_8 = Color.New(1, 1, 1)

				var_78_8.a = Mathf.Lerp(1, 0, var_78_7)
				arg_75_1.mask_.color = var_78_8
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 then
				local var_78_9 = Color.New(1, 1, 1)
				local var_78_10 = 0

				arg_75_1.mask_.enabled = false
				var_78_9.a = var_78_10
				arg_75_1.mask_.color = var_78_9
			end

			local var_78_11 = manager.ui.mainCamera.transform
			local var_78_12 = 1

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_11.localPosition
			end

			local var_78_13 = 1

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_13 then
				local var_78_14 = (arg_75_1.time_ - var_78_12) / 0.066
				local var_78_15, var_78_16 = math.modf(var_78_14)

				var_78_11.localPosition = Vector3.New(var_78_16 * 0.13, var_78_16 * 0.13, var_78_16 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= var_78_12 + var_78_13 and arg_75_1.time_ < var_78_12 + var_78_13 + arg_78_0 then
				var_78_11.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_17 = "STblack"

			if arg_75_1.bgs_[var_78_17] == nil then
				local var_78_18 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_78_17)
				var_78_18.name = var_78_17
				var_78_18.transform.parent = arg_75_1.stage_.transform
				var_78_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_[var_78_17] = var_78_18
			end

			local var_78_19 = 2

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				local var_78_20 = manager.ui.mainCamera.transform.localPosition
				local var_78_21 = Vector3.New(0, 0, 10) + Vector3.New(var_78_20.x, var_78_20.y, 0)
				local var_78_22 = arg_75_1.bgs_.STblack

				var_78_22.transform.localPosition = var_78_21
				var_78_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_23 = var_78_22:GetComponent("SpriteRenderer")

				if var_78_23 and var_78_23.sprite then
					local var_78_24 = (var_78_22.transform.localPosition - var_78_20).z
					local var_78_25 = manager.ui.mainCameraCom_
					local var_78_26 = 2 * var_78_24 * Mathf.Tan(var_78_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_78_27 = var_78_26 * var_78_25.aspect
					local var_78_28 = var_78_23.sprite.bounds.size.x
					local var_78_29 = var_78_23.sprite.bounds.size.y
					local var_78_30 = var_78_27 / var_78_28
					local var_78_31 = var_78_26 / var_78_29
					local var_78_32 = var_78_31 < var_78_30 and var_78_30 or var_78_31

					var_78_22.transform.localScale = Vector3.New(var_78_32, var_78_32, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "STblack" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_33 = 2

			if var_78_33 < arg_75_1.time_ and arg_75_1.time_ <= var_78_33 + arg_78_0 then
				arg_75_1.fswbg_:SetActive(true)
				arg_75_1.dialog_:SetActive(false)

				arg_75_1.fswtw_.percent = 0

				local var_78_34 = arg_75_1:GetWordFromCfg(121482018)
				local var_78_35 = arg_75_1:FormatText(var_78_34.content)

				arg_75_1.fswt_.text = var_78_35

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.fswt_)

				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_75_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_75_1.fswtw_:SetDirty()

				arg_75_1.typewritterCharCountI18N = 0

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_36 = 2.01666666666667

			if var_78_36 < arg_75_1.time_ and arg_75_1.time_ <= var_78_36 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_37 = 40
			local var_78_38 = 2.66666666666667
			local var_78_39 = arg_75_1:GetWordFromCfg(121482018)
			local var_78_40 = arg_75_1:FormatText(var_78_39.content)
			local var_78_41, var_78_42 = arg_75_1:GetPercentByPara(var_78_40, 1)

			if var_78_36 < arg_75_1.time_ and arg_75_1.time_ <= var_78_36 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_43 = var_78_37 <= 0 and var_78_38 or var_78_38 * ((var_78_42 - arg_75_1.typewritterCharCountI18N) / var_78_37)

				if var_78_43 > 0 and var_78_38 < var_78_43 then
					arg_75_1.talkMaxDuration = var_78_43

					if var_78_43 + var_78_36 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_43 + var_78_36
					end
				end
			end

			local var_78_44 = 2.66666666666667
			local var_78_45 = math.max(var_78_44, arg_75_1.talkMaxDuration)

			if var_78_36 <= arg_75_1.time_ and arg_75_1.time_ < var_78_36 + var_78_45 then
				local var_78_46 = (arg_75_1.time_ - var_78_36) / var_78_45

				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_41, var_78_46)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= var_78_36 + var_78_45 and arg_75_1.time_ < var_78_36 + var_78_45 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_41

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_42
			end

			local var_78_47 = 2

			if var_78_47 < arg_75_1.time_ and arg_75_1.time_ <= var_78_47 + arg_78_0 then
				local var_78_48 = arg_75_1.fswbg_.transform:Find("textbox/adapt/content") or arg_75_1.fswbg_.transform:Find("textbox/content")
				local var_78_49 = arg_75_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_78_50 = var_78_48:GetComponent("Text")
				local var_78_51 = var_78_48:GetComponent("RectTransform")

				var_78_50.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_78_51.offsetMin = Vector2.New(0, 0)
				var_78_51.offsetMax = Vector2.New(0, 0)
			end

			local var_78_52 = 0
			local var_78_53 = 0.433333333333333

			if var_78_52 < arg_75_1.time_ and arg_75_1.time_ <= var_78_52 + arg_78_0 then
				local var_78_54 = "play"
				local var_78_55 = "effect"

				arg_75_1:AudioAction(var_78_54, var_78_55, "se_story_121_04", "se_story_121_04_spaceclose", "")
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play121482019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 121482019
		arg_79_1.duration_ = 6.7

		local var_79_0 = {
			ja = 3.1,
			ko = 6.7,
			zh = 6.7
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
				arg_79_0:Play121482020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = "J02f"

			if arg_79_1.bgs_[var_82_0] == nil then
				local var_82_1 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_82_0)
				var_82_1.name = var_82_0
				var_82_1.transform.parent = arg_79_1.stage_.transform
				var_82_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_[var_82_0] = var_82_1
			end

			local var_82_2 = 0

			if var_82_2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				local var_82_3 = manager.ui.mainCamera.transform.localPosition
				local var_82_4 = Vector3.New(0, 0, 10) + Vector3.New(var_82_3.x, var_82_3.y, 0)
				local var_82_5 = arg_79_1.bgs_.J02f

				var_82_5.transform.localPosition = var_82_4
				var_82_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_6 = var_82_5:GetComponent("SpriteRenderer")

				if var_82_6 and var_82_6.sprite then
					local var_82_7 = (var_82_5.transform.localPosition - var_82_3).z
					local var_82_8 = manager.ui.mainCameraCom_
					local var_82_9 = 2 * var_82_7 * Mathf.Tan(var_82_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_10 = var_82_9 * var_82_8.aspect
					local var_82_11 = var_82_6.sprite.bounds.size.x
					local var_82_12 = var_82_6.sprite.bounds.size.y
					local var_82_13 = var_82_10 / var_82_11
					local var_82_14 = var_82_9 / var_82_12
					local var_82_15 = var_82_14 < var_82_13 and var_82_13 or var_82_14

					var_82_5.transform.localScale = Vector3.New(var_82_15, var_82_15, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "J02f" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_17 = 2

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 then
				local var_82_18 = (arg_79_1.time_ - var_82_16) / var_82_17
				local var_82_19 = Color.New(0, 0, 0)

				var_82_19.a = Mathf.Lerp(1, 0, var_82_18)
				arg_79_1.mask_.color = var_82_19
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
				local var_82_20 = Color.New(0, 0, 0)
				local var_82_21 = 0

				arg_79_1.mask_.enabled = false
				var_82_20.a = var_82_21
				arg_79_1.mask_.color = var_82_20
			end

			local var_82_22 = 0

			if var_82_22 < arg_79_1.time_ and arg_79_1.time_ <= var_82_22 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(false)
				arg_79_1.dialog_:SetActive(false)
				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_23 = 2
			local var_82_24 = 0.075

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_25 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_25:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_26 = arg_79_1:FormatText(StoryNameCfg[412].name)

				arg_79_1.leftNameTxt_.text = var_82_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_27 = arg_79_1:GetWordFromCfg(121482019)
				local var_82_28 = arg_79_1:FormatText(var_82_27.content)

				arg_79_1.text_.text = var_82_28

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_29 = 3
				local var_82_30 = utf8.len(var_82_28)
				local var_82_31 = var_82_29 <= 0 and var_82_24 or var_82_24 * (var_82_30 / var_82_29)

				if var_82_31 > 0 and var_82_24 < var_82_31 then
					arg_79_1.talkMaxDuration = var_82_31
					var_82_23 = var_82_23 + 0.3

					if var_82_31 + var_82_23 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_31 + var_82_23
					end
				end

				arg_79_1.text_.text = var_82_28
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482019", "story_v_out_121482.awb") ~= 0 then
					local var_82_32 = manager.audio:GetVoiceLength("story_v_out_121482", "121482019", "story_v_out_121482.awb") / 1000

					if var_82_32 + var_82_23 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_32 + var_82_23
					end

					if var_82_27.prefab_name ~= "" and arg_79_1.actors_[var_82_27.prefab_name] ~= nil then
						local var_82_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_27.prefab_name].transform, "story_v_out_121482", "121482019", "story_v_out_121482.awb")

						arg_79_1:RecordAudio("121482019", var_82_33)
						arg_79_1:RecordAudio("121482019", var_82_33)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_121482", "121482019", "story_v_out_121482.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_121482", "121482019", "story_v_out_121482.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_34 = var_82_23 + 0.3
			local var_82_35 = math.max(var_82_24, arg_79_1.talkMaxDuration)

			if var_82_34 <= arg_79_1.time_ and arg_79_1.time_ < var_82_34 + var_82_35 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_34) / var_82_35

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_34 + var_82_35 and arg_79_1.time_ < var_82_34 + var_82_35 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play121482020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121482020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121482021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.725

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(121482020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 29
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121482021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121482021
		arg_89_1.duration_ = 6.37

		local var_89_0 = {
			ja = 6.366,
			ko = 6,
			zh = 6
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
				arg_89_0:Play121482022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "10045ui_story"

			if arg_89_1.actors_[var_92_0] == nil then
				local var_92_1 = Asset.Load("Char/" .. "10045ui_story")

				if not isNil(var_92_1) then
					local var_92_2 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_89_1.stage_.transform)

					var_92_2.name = var_92_0
					var_92_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_89_1.actors_[var_92_0] = var_92_2

					local var_92_3 = var_92_2:GetComponentInChildren(typeof(CharacterEffect))

					var_92_3.enabled = true

					local var_92_4 = GameObjectTools.GetOrAddComponent(var_92_2, typeof(DynamicBoneHelper))

					if var_92_4 then
						var_92_4:EnableDynamicBone(false)
					end

					arg_89_1:ShowWeapon(var_92_3.transform, false)

					arg_89_1.var_[var_92_0 .. "Animator"] = var_92_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_89_1.var_[var_92_0 .. "Animator"].applyRootMotion = true
					arg_89_1.var_[var_92_0 .. "LipSync"] = var_92_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_92_5 = arg_89_1.actors_["10045ui_story"].transform
			local var_92_6 = 0

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.var_.moveOldPos10045ui_story = var_92_5.localPosition
			end

			local var_92_7 = 0.001

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_7 then
				local var_92_8 = (arg_89_1.time_ - var_92_6) / var_92_7
				local var_92_9 = Vector3.New(0, -1.18, -6.05)

				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10045ui_story, var_92_9, var_92_8)

				local var_92_10 = manager.ui.mainCamera.transform.position - var_92_5.position

				var_92_5.forward = Vector3.New(var_92_10.x, var_92_10.y, var_92_10.z)

				local var_92_11 = var_92_5.localEulerAngles

				var_92_11.z = 0
				var_92_11.x = 0
				var_92_5.localEulerAngles = var_92_11
			end

			if arg_89_1.time_ >= var_92_6 + var_92_7 and arg_89_1.time_ < var_92_6 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_92_12 = manager.ui.mainCamera.transform.position - var_92_5.position

				var_92_5.forward = Vector3.New(var_92_12.x, var_92_12.y, var_92_12.z)

				local var_92_13 = var_92_5.localEulerAngles

				var_92_13.z = 0
				var_92_13.x = 0
				var_92_5.localEulerAngles = var_92_13
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			local var_92_15 = 0

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_92_16 = arg_89_1.actors_["10045ui_story"]
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 and not isNil(var_92_16) and arg_89_1.var_.characterEffect10045ui_story == nil then
				arg_89_1.var_.characterEffect10045ui_story = var_92_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_18 = 0.2

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_18 and not isNil(var_92_16) then
				local var_92_19 = (arg_89_1.time_ - var_92_17) / var_92_18

				if arg_89_1.var_.characterEffect10045ui_story and not isNil(var_92_16) then
					arg_89_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_17 + var_92_18 and arg_89_1.time_ < var_92_17 + var_92_18 + arg_92_0 and not isNil(var_92_16) and arg_89_1.var_.characterEffect10045ui_story then
				arg_89_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_92_20 = 0
			local var_92_21 = 0.6

			if var_92_20 < arg_89_1.time_ and arg_89_1.time_ <= var_92_20 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_22 = arg_89_1:FormatText(StoryNameCfg[412].name)

				arg_89_1.leftNameTxt_.text = var_92_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_23 = arg_89_1:GetWordFromCfg(121482021)
				local var_92_24 = arg_89_1:FormatText(var_92_23.content)

				arg_89_1.text_.text = var_92_24

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_25 = 24
				local var_92_26 = utf8.len(var_92_24)
				local var_92_27 = var_92_25 <= 0 and var_92_21 or var_92_21 * (var_92_26 / var_92_25)

				if var_92_27 > 0 and var_92_21 < var_92_27 then
					arg_89_1.talkMaxDuration = var_92_27

					if var_92_27 + var_92_20 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_27 + var_92_20
					end
				end

				arg_89_1.text_.text = var_92_24
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482021", "story_v_out_121482.awb") ~= 0 then
					local var_92_28 = manager.audio:GetVoiceLength("story_v_out_121482", "121482021", "story_v_out_121482.awb") / 1000

					if var_92_28 + var_92_20 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_28 + var_92_20
					end

					if var_92_23.prefab_name ~= "" and arg_89_1.actors_[var_92_23.prefab_name] ~= nil then
						local var_92_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_23.prefab_name].transform, "story_v_out_121482", "121482021", "story_v_out_121482.awb")

						arg_89_1:RecordAudio("121482021", var_92_29)
						arg_89_1:RecordAudio("121482021", var_92_29)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121482", "121482021", "story_v_out_121482.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121482", "121482021", "story_v_out_121482.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_30 = math.max(var_92_21, arg_89_1.talkMaxDuration)

			if var_92_20 <= arg_89_1.time_ and arg_89_1.time_ < var_92_20 + var_92_30 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_20) / var_92_30

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_20 + var_92_30 and arg_89_1.time_ < var_92_20 + var_92_30 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
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
	Play121482022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121482022
		arg_93_1.duration_ = 7.83

		local var_93_0 = {
			ja = 5.533,
			ko = 7.833,
			zh = 7.833
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
				arg_93_0:Play121482023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.425

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[412].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(121482022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 17
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482022", "story_v_out_121482.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482022", "story_v_out_121482.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_121482", "121482022", "story_v_out_121482.awb")

						arg_93_1:RecordAudio("121482022", var_96_9)
						arg_93_1:RecordAudio("121482022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121482", "121482022", "story_v_out_121482.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121482", "121482022", "story_v_out_121482.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121482023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121482023
		arg_97_1.duration_ = 6.4

		local var_97_0 = {
			ja = 5.166,
			ko = 6.4,
			zh = 6.4
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
				arg_97_0:Play121482024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.325

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[412].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(121482023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 13
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482023", "story_v_out_121482.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_121482", "121482023", "story_v_out_121482.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_121482", "121482023", "story_v_out_121482.awb")

						arg_97_1:RecordAudio("121482023", var_100_9)
						arg_97_1:RecordAudio("121482023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121482", "121482023", "story_v_out_121482.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121482", "121482023", "story_v_out_121482.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121482024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121482024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121482025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10045ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10045ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, 100, 0)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10045ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, 100, 0)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = 0
			local var_104_10 = 0.725

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_11 = arg_101_1:GetWordFromCfg(121482024)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 29
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_10 or var_104_10 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_10 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_9 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_9
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_10, arg_101_1.talkMaxDuration)

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_9) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_9 + var_104_16 and arg_101_1.time_ < var_104_9 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play121482025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121482025
		arg_105_1.duration_ = 4.93

		local var_105_0 = {
			ja = 2.9,
			ko = 4.933,
			zh = 4.933
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121482026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10045ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10045ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, -1.18, -6.05)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10045ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action1_1")
			end

			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_108_11 = arg_105_1.actors_["10045ui_story"]
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect10045ui_story == nil then
				arg_105_1.var_.characterEffect10045ui_story = var_108_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_13 = 0.2

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_13 and not isNil(var_108_11) then
				local var_108_14 = (arg_105_1.time_ - var_108_12) / var_108_13

				if arg_105_1.var_.characterEffect10045ui_story and not isNil(var_108_11) then
					arg_105_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_12 + var_108_13 and arg_105_1.time_ < var_108_12 + var_108_13 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect10045ui_story then
				arg_105_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_108_15 = 0
			local var_108_16 = 0.3

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[412].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(121482025)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 12
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482025", "story_v_out_121482.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_121482", "121482025", "story_v_out_121482.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_121482", "121482025", "story_v_out_121482.awb")

						arg_105_1:RecordAudio("121482025", var_108_24)
						arg_105_1:RecordAudio("121482025", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_121482", "121482025", "story_v_out_121482.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_121482", "121482025", "story_v_out_121482.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play121482026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121482026
		arg_109_1.duration_ = 4.7

		local var_109_0 = {
			ja = 3.266,
			ko = 4.7,
			zh = 4.7
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
			arg_109_1.auto_ = false
		end

		function arg_109_1.playNext_(arg_111_0)
			arg_109_1.onStoryFinished_()
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_112_1 = 0
			local var_112_2 = 0.15

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_3 = arg_109_1:FormatText(StoryNameCfg[412].name)

				arg_109_1.leftNameTxt_.text = var_112_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(121482026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 6
				local var_112_7 = utf8.len(var_112_5)
				local var_112_8 = var_112_6 <= 0 and var_112_2 or var_112_2 * (var_112_7 / var_112_6)

				if var_112_8 > 0 and var_112_2 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121482", "121482026", "story_v_out_121482.awb") ~= 0 then
					local var_112_9 = manager.audio:GetVoiceLength("story_v_out_121482", "121482026", "story_v_out_121482.awb") / 1000

					if var_112_9 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_1
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_121482", "121482026", "story_v_out_121482.awb")

						arg_109_1:RecordAudio("121482026", var_112_10)
						arg_109_1:RecordAudio("121482026", var_112_10)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121482", "121482026", "story_v_out_121482.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121482", "121482026", "story_v_out_121482.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_11 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_11 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_11

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_11 and arg_109_1.time_ < var_112_1 + var_112_11 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0304",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J02f"
	},
	voices = {
		"story_v_out_121482.awb"
	}
}
