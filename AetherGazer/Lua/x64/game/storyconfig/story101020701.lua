return {
	Play102071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = 0
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story", "se_story_fight_metal", "")
			end

			local var_4_14 = 0

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 2

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_14) / var_4_15
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)
				local var_4_19 = 0

				arg_1_1.mask_.enabled = false
				var_4_18.a = var_4_19
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_20 = "S0202"

			if arg_1_1.bgs_[var_4_20] == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)
				var_4_21.name = var_4_20
				var_4_21.transform.parent = arg_1_1.stage_.transform
				var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_20] = var_4_21
			end

			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = manager.ui.mainCamera.transform.localPosition
				local var_4_24 = Vector3.New(0, 0, 10) + Vector3.New(var_4_23.x, var_4_23.y, 0)
				local var_4_25 = arg_1_1.bgs_.S0202

				var_4_25.transform.localPosition = var_4_24
				var_4_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_26 = var_4_25:GetComponent("SpriteRenderer")

				if var_4_26 and var_4_26.sprite then
					local var_4_27 = (var_4_25.transform.localPosition - var_4_23).z
					local var_4_28 = manager.ui.mainCameraCom_
					local var_4_29 = 2 * var_4_27 * Mathf.Tan(var_4_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_30 = var_4_29 * var_4_28.aspect
					local var_4_31 = var_4_26.sprite.bounds.size.x
					local var_4_32 = var_4_26.sprite.bounds.size.y
					local var_4_33 = var_4_30 / var_4_31
					local var_4_34 = var_4_29 / var_4_32
					local var_4_35 = var_4_34 < var_4_33 and var_4_33 or var_4_34

					var_4_25.transform.localScale = Vector3.New(var_4_35, var_4_35, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0202" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_36 = manager.ui.mainCamera.transform
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.shakeOldPosMainCamera = var_4_36.localPosition
			end

			local var_4_38 = 0.600000023841858

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / 0.066
				local var_4_40, var_4_41 = math.modf(var_4_39)

				var_4_36.localPosition = Vector3.New(var_4_41 * 0.13, var_4_41 * 0.13, var_4_41 * 0.13) + arg_1_1.var_.shakeOldPosMainCamera
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				var_4_36.localPosition = arg_1_1.var_.shakeOldPosMainCamera
			end

			local var_4_42 = 2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_43 = 0.400000023841858

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 2
			local var_4_45 = 0.1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_47 = arg_1_1:GetWordFromCfg(102071001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 6
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

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play102071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play102071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story", "se_story_fight_metal", "")
			end

			local var_11_4 = manager.ui.mainCamera.transform
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				local var_11_6 = arg_8_1.var_.effectMainCamera1048镜头前特效
				local var_11_7
				local var_11_8 = var_11_4

				if not var_11_6 then
					var_11_6 = Object.Instantiate(Asset.Load("Effect/Hero/1048/fx_1048_ui_001"), var_11_8)
					var_11_6.name = "1048镜头前特效"
					arg_8_1.var_.effectMainCamera1048镜头前特效 = var_11_6
				else
					var_11_6.transform:SetParent(var_11_8)
				end

				var_11_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_11_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_11_9 = 0
			local var_11_10 = 0.2

			if var_11_9 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_11 = arg_8_1:GetWordFromCfg(102071002)
				local var_11_12 = arg_8_1:FormatText(var_11_11.content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 8
				local var_11_14 = utf8.len(var_11_12)
				local var_11_15 = var_11_13 <= 0 and var_11_10 or var_11_10 * (var_11_14 / var_11_13)

				if var_11_15 > 0 and var_11_10 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_9
					end
				end

				arg_8_1.text_.text = var_11_12
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_10, arg_8_1.talkMaxDuration)

			if var_11_9 <= arg_8_1.time_ and arg_8_1.time_ < var_11_9 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_9) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_9 + var_11_16 and arg_8_1.time_ < var_11_9 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play102071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102071003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play102071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.625

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(102071003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 25
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play102071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102071004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play102071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = manager.ui.mainCamera.transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.shakeOldPosMainCamera = var_19_0.localPosition
			end

			local var_19_2 = 0.600000023841858

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / 0.066
				local var_19_4, var_19_5 = math.modf(var_19_3)

				var_19_0.localPosition = Vector3.New(var_19_5 * 0.13, var_19_5 * 0.13, var_19_5 * 0.13) + arg_16_1.var_.shakeOldPosMainCamera
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = arg_16_1.var_.shakeOldPosMainCamera
			end

			local var_19_6 = 0
			local var_19_7 = 1.025

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(102071004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 41
				local var_19_11 = utf8.len(var_19_9)
				local var_19_12 = var_19_10 <= 0 and var_19_7 or var_19_7 * (var_19_11 / var_19_10)

				if var_19_12 > 0 and var_19_7 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_13 and arg_16_1.time_ < var_19_6 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play102071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102071005
		arg_20_1.duration_ = 2.63

		local var_20_0 = {
			ja = 2.633,
			ko = 1.733,
			zh = 2.266,
			en = 1.3
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play102071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.15

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[20].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(102071005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 6
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071005", "story_v_out_102071.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071005", "story_v_out_102071.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_102071", "102071005", "story_v_out_102071.awb")

						arg_20_1:RecordAudio("102071005", var_23_9)
						arg_20_1:RecordAudio("102071005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102071", "102071005", "story_v_out_102071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102071", "102071005", "story_v_out_102071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102071006
		arg_24_1.duration_ = 2.5

		local var_24_0 = {
			ja = 2.5,
			ko = 1.933,
			zh = 2.166,
			en = 2.3
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play102071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1084ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_27_6 = 0
			local var_27_7 = 0.15

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[6].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(102071006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 6
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071006", "story_v_out_102071.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_102071", "102071006", "story_v_out_102071.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_102071", "102071006", "story_v_out_102071.awb")

						arg_24_1:RecordAudio("102071006", var_27_15)
						arg_24_1:RecordAudio("102071006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102071", "102071006", "story_v_out_102071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102071", "102071006", "story_v_out_102071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play102071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102071007
		arg_28_1.duration_ = 3.8

		local var_28_0 = {
			ja = 3.4,
			ko = 3.1,
			zh = 3.1,
			en = 3.8
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play102071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1019ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_6 = 0
			local var_31_7 = 0.4

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(102071007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 16
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071007", "story_v_out_102071.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_102071", "102071007", "story_v_out_102071.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_102071", "102071007", "story_v_out_102071.awb")

						arg_28_1:RecordAudio("102071007", var_31_15)
						arg_28_1:RecordAudio("102071007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102071", "102071007", "story_v_out_102071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102071", "102071007", "story_v_out_102071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play102071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102071008
		arg_32_1.duration_ = 3.9

		local var_32_0 = {
			ja = 3.9,
			ko = 3.7,
			zh = 3.8,
			en = 2.066
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play102071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_35_1 = 0
			local var_35_2 = 0.325

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_3 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_4 = arg_32_1:GetWordFromCfg(102071008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 13
				local var_35_7 = utf8.len(var_35_5)
				local var_35_8 = var_35_6 <= 0 and var_35_2 or var_35_2 * (var_35_7 / var_35_6)

				if var_35_8 > 0 and var_35_2 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071008", "story_v_out_102071.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_102071", "102071008", "story_v_out_102071.awb") / 1000

					if var_35_9 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_1
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_102071", "102071008", "story_v_out_102071.awb")

						arg_32_1:RecordAudio("102071008", var_35_10)
						arg_32_1:RecordAudio("102071008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102071", "102071008", "story_v_out_102071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102071", "102071008", "story_v_out_102071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_11 and arg_32_1.time_ < var_35_1 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play102071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102071009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play102071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.4

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(102071009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 16
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play102071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102071010
		arg_40_1.duration_ = 5.13

		local var_40_0 = {
			ja = 5.133,
			ko = 3.466,
			zh = 4.1,
			en = 3.766
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play102071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.3

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[20].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(102071010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 12
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071010", "story_v_out_102071.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071010", "story_v_out_102071.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_102071", "102071010", "story_v_out_102071.awb")

						arg_40_1:RecordAudio("102071010", var_43_9)
						arg_40_1:RecordAudio("102071010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102071", "102071010", "story_v_out_102071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102071", "102071010", "story_v_out_102071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play102071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102071011
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play102071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "B02a"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 2

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.B02a

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "B02a" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_17 = 2

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Color.New(0, 0, 0)

				var_47_19.a = Mathf.Lerp(0, 1, var_47_18)
				arg_44_1.mask_.color = var_47_19
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				local var_47_20 = Color.New(0, 0, 0)

				var_47_20.a = 1
				arg_44_1.mask_.color = var_47_20
			end

			local var_47_21 = 2

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_22 = 2

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22
				local var_47_24 = Color.New(0, 0, 0)

				var_47_24.a = Mathf.Lerp(1, 0, var_47_23)
				arg_44_1.mask_.color = var_47_24
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 then
				local var_47_25 = Color.New(0, 0, 0)
				local var_47_26 = 0

				arg_44_1.mask_.enabled = false
				var_47_25.a = var_47_26
				arg_44_1.mask_.color = var_47_25
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_27 = 4
			local var_47_28 = 0.95

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_29 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_29:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(102071011)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 38
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34
					var_47_27 = var_47_27 + 0.3

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_35 = var_47_27 + 0.3
			local var_47_36 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_35 <= arg_44_1.time_ and arg_44_1.time_ < var_47_35 + var_47_36 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_35) / var_47_36

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_35 + var_47_36 and arg_44_1.time_ < var_47_35 + var_47_36 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play102071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 102071012
		arg_50_1.duration_ = 9.57

		local var_50_0 = {
			ja = 9.566,
			ko = 6.5,
			zh = 8.633,
			en = 7.3
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
				arg_50_0:Play102071014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "3008ui_story"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_50_1.stage_.transform)

					var_53_2.name = var_53_0
					var_53_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_50_1.actors_[var_53_0] = var_53_2

					local var_53_3 = var_53_2:GetComponentInChildren(typeof(CharacterEffect))

					var_53_3.enabled = true

					local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_2, typeof(DynamicBoneHelper))

					if var_53_4 then
						var_53_4:EnableDynamicBone(false)
					end

					arg_50_1:ShowWeapon(var_53_3.transform, false)

					arg_50_1.var_[var_53_0 .. "Animator"] = var_53_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_50_1.var_[var_53_0 .. "Animator"].applyRootMotion = true
					arg_50_1.var_[var_53_0 .. "LipSync"] = var_53_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_53_5 = arg_50_1.actors_["3008ui_story"]
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect3008ui_story == nil then
				arg_50_1.var_.characterEffect3008ui_story = var_53_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_7 = 0.1

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_7 and not isNil(var_53_5) then
				local var_53_8 = (arg_50_1.time_ - var_53_6) / var_53_7

				if arg_50_1.var_.characterEffect3008ui_story and not isNil(var_53_5) then
					arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_6 + var_53_7 and arg_50_1.time_ < var_53_6 + var_53_7 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect3008ui_story then
				arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_53_9 = arg_50_1.actors_["3008ui_story"].transform
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1.var_.moveOldPos3008ui_story = var_53_9.localPosition
			end

			local var_53_11 = 0.001

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_11 then
				local var_53_12 = (arg_50_1.time_ - var_53_10) / var_53_11
				local var_53_13 = Vector3.New(0, -1.51, -4.3)

				var_53_9.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos3008ui_story, var_53_13, var_53_12)

				local var_53_14 = manager.ui.mainCamera.transform.position - var_53_9.position

				var_53_9.forward = Vector3.New(var_53_14.x, var_53_14.y, var_53_14.z)

				local var_53_15 = var_53_9.localEulerAngles

				var_53_15.z = 0
				var_53_15.x = 0
				var_53_9.localEulerAngles = var_53_15
			end

			if arg_50_1.time_ >= var_53_10 + var_53_11 and arg_50_1.time_ < var_53_10 + var_53_11 + arg_53_0 then
				var_53_9.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_53_16 = manager.ui.mainCamera.transform.position - var_53_9.position

				var_53_9.forward = Vector3.New(var_53_16.x, var_53_16.y, var_53_16.z)

				local var_53_17 = var_53_9.localEulerAngles

				var_53_17.z = 0
				var_53_17.x = 0
				var_53_9.localEulerAngles = var_53_17
			end

			local var_53_18 = 0

			if var_53_18 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_53_19 = 0

			if var_53_19 < arg_50_1.time_ and arg_50_1.time_ <= var_53_19 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_53_20 = 0
			local var_53_21 = 0.825

			if var_53_20 < arg_50_1.time_ and arg_50_1.time_ <= var_53_20 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_22 = arg_50_1:FormatText(StoryNameCfg[20].name)

				arg_50_1.leftNameTxt_.text = var_53_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_23 = arg_50_1:GetWordFromCfg(102071012)
				local var_53_24 = arg_50_1:FormatText(var_53_23.content)

				arg_50_1.text_.text = var_53_24

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_25 = 33
				local var_53_26 = utf8.len(var_53_24)
				local var_53_27 = var_53_25 <= 0 and var_53_21 or var_53_21 * (var_53_26 / var_53_25)

				if var_53_27 > 0 and var_53_21 < var_53_27 then
					arg_50_1.talkMaxDuration = var_53_27

					if var_53_27 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_27 + var_53_20
					end
				end

				arg_50_1.text_.text = var_53_24
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071012", "story_v_out_102071.awb") ~= 0 then
					local var_53_28 = manager.audio:GetVoiceLength("story_v_out_102071", "102071012", "story_v_out_102071.awb") / 1000

					if var_53_28 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_28 + var_53_20
					end

					if var_53_23.prefab_name ~= "" and arg_50_1.actors_[var_53_23.prefab_name] ~= nil then
						local var_53_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_23.prefab_name].transform, "story_v_out_102071", "102071012", "story_v_out_102071.awb")

						arg_50_1:RecordAudio("102071012", var_53_29)
						arg_50_1:RecordAudio("102071012", var_53_29)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_102071", "102071012", "story_v_out_102071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_102071", "102071012", "story_v_out_102071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_30 = math.max(var_53_21, arg_50_1.talkMaxDuration)

			if var_53_20 <= arg_50_1.time_ and arg_50_1.time_ < var_53_20 + var_53_30 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_20) / var_53_30

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_20 + var_53_30 and arg_50_1.time_ < var_53_20 + var_53_30 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play102071014 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 102071014
		arg_54_1.duration_ = 7.57

		local var_54_0 = {
			ja = 7.566,
			ko = 4.9,
			zh = 4.8,
			en = 5.366
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
				arg_54_0:Play102071015(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "1011ui_story"

			if arg_54_1.actors_[var_57_0] == nil then
				local var_57_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_57_1) then
					local var_57_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_54_1.stage_.transform)

					var_57_2.name = var_57_0
					var_57_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_54_1.actors_[var_57_0] = var_57_2

					local var_57_3 = var_57_2:GetComponentInChildren(typeof(CharacterEffect))

					var_57_3.enabled = true

					local var_57_4 = GameObjectTools.GetOrAddComponent(var_57_2, typeof(DynamicBoneHelper))

					if var_57_4 then
						var_57_4:EnableDynamicBone(false)
					end

					arg_54_1:ShowWeapon(var_57_3.transform, false)

					arg_54_1.var_[var_57_0 .. "Animator"] = var_57_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_54_1.var_[var_57_0 .. "Animator"].applyRootMotion = true
					arg_54_1.var_[var_57_0 .. "LipSync"] = var_57_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_57_5 = arg_54_1.actors_["1011ui_story"]
			local var_57_6 = 0

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect1011ui_story == nil then
				arg_54_1.var_.characterEffect1011ui_story = var_57_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_7 = 0.1

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_7 and not isNil(var_57_5) then
				local var_57_8 = (arg_54_1.time_ - var_57_6) / var_57_7

				if arg_54_1.var_.characterEffect1011ui_story and not isNil(var_57_5) then
					arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_6 + var_57_7 and arg_54_1.time_ < var_57_6 + var_57_7 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect1011ui_story then
				arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_57_9 = arg_54_1.actors_["3008ui_story"]
			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect3008ui_story == nil then
				arg_54_1.var_.characterEffect3008ui_story = var_57_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_11 = 0.1

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_11 and not isNil(var_57_9) then
				local var_57_12 = (arg_54_1.time_ - var_57_10) / var_57_11

				if arg_54_1.var_.characterEffect3008ui_story and not isNil(var_57_9) then
					local var_57_13 = Mathf.Lerp(0, 0.5, var_57_12)

					arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_54_1.var_.characterEffect3008ui_story.fillRatio = var_57_13
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect3008ui_story then
				local var_57_14 = 0.5

				arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_54_1.var_.characterEffect3008ui_story.fillRatio = var_57_14
			end

			local var_57_15 = arg_54_1.actors_["3008ui_story"].transform
			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.var_.moveOldPos3008ui_story = var_57_15.localPosition
			end

			local var_57_17 = 0.001

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_17 then
				local var_57_18 = (arg_54_1.time_ - var_57_16) / var_57_17
				local var_57_19 = Vector3.New(0, 100, 0)

				var_57_15.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos3008ui_story, var_57_19, var_57_18)

				local var_57_20 = manager.ui.mainCamera.transform.position - var_57_15.position

				var_57_15.forward = Vector3.New(var_57_20.x, var_57_20.y, var_57_20.z)

				local var_57_21 = var_57_15.localEulerAngles

				var_57_21.z = 0
				var_57_21.x = 0
				var_57_15.localEulerAngles = var_57_21
			end

			if arg_54_1.time_ >= var_57_16 + var_57_17 and arg_54_1.time_ < var_57_16 + var_57_17 + arg_57_0 then
				var_57_15.localPosition = Vector3.New(0, 100, 0)

				local var_57_22 = manager.ui.mainCamera.transform.position - var_57_15.position

				var_57_15.forward = Vector3.New(var_57_22.x, var_57_22.y, var_57_22.z)

				local var_57_23 = var_57_15.localEulerAngles

				var_57_23.z = 0
				var_57_23.x = 0
				var_57_15.localEulerAngles = var_57_23
			end

			local var_57_24 = arg_54_1.actors_["1011ui_story"].transform
			local var_57_25 = 0

			if var_57_25 < arg_54_1.time_ and arg_54_1.time_ <= var_57_25 + arg_57_0 then
				arg_54_1.var_.moveOldPos1011ui_story = var_57_24.localPosition
			end

			local var_57_26 = 0.001

			if var_57_25 <= arg_54_1.time_ and arg_54_1.time_ < var_57_25 + var_57_26 then
				local var_57_27 = (arg_54_1.time_ - var_57_25) / var_57_26
				local var_57_28 = Vector3.New(0, -0.71, -6)

				var_57_24.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1011ui_story, var_57_28, var_57_27)

				local var_57_29 = manager.ui.mainCamera.transform.position - var_57_24.position

				var_57_24.forward = Vector3.New(var_57_29.x, var_57_29.y, var_57_29.z)

				local var_57_30 = var_57_24.localEulerAngles

				var_57_30.z = 0
				var_57_30.x = 0
				var_57_24.localEulerAngles = var_57_30
			end

			if arg_54_1.time_ >= var_57_25 + var_57_26 and arg_54_1.time_ < var_57_25 + var_57_26 + arg_57_0 then
				var_57_24.localPosition = Vector3.New(0, -0.71, -6)

				local var_57_31 = manager.ui.mainCamera.transform.position - var_57_24.position

				var_57_24.forward = Vector3.New(var_57_31.x, var_57_31.y, var_57_31.z)

				local var_57_32 = var_57_24.localEulerAngles

				var_57_32.z = 0
				var_57_32.x = 0
				var_57_24.localEulerAngles = var_57_32
			end

			local var_57_33 = 0

			if var_57_33 < arg_54_1.time_ and arg_54_1.time_ <= var_57_33 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_57_34 = 0

			if var_57_34 < arg_54_1.time_ and arg_54_1.time_ <= var_57_34 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_57_35 = 0
			local var_57_36 = 0.525

			if var_57_35 < arg_54_1.time_ and arg_54_1.time_ <= var_57_35 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_37 = arg_54_1:FormatText(StoryNameCfg[37].name)

				arg_54_1.leftNameTxt_.text = var_57_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_38 = arg_54_1:GetWordFromCfg(102071014)
				local var_57_39 = arg_54_1:FormatText(var_57_38.content)

				arg_54_1.text_.text = var_57_39

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_40 = 21
				local var_57_41 = utf8.len(var_57_39)
				local var_57_42 = var_57_40 <= 0 and var_57_36 or var_57_36 * (var_57_41 / var_57_40)

				if var_57_42 > 0 and var_57_36 < var_57_42 then
					arg_54_1.talkMaxDuration = var_57_42

					if var_57_42 + var_57_35 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_42 + var_57_35
					end
				end

				arg_54_1.text_.text = var_57_39
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071014", "story_v_out_102071.awb") ~= 0 then
					local var_57_43 = manager.audio:GetVoiceLength("story_v_out_102071", "102071014", "story_v_out_102071.awb") / 1000

					if var_57_43 + var_57_35 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_43 + var_57_35
					end

					if var_57_38.prefab_name ~= "" and arg_54_1.actors_[var_57_38.prefab_name] ~= nil then
						local var_57_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_38.prefab_name].transform, "story_v_out_102071", "102071014", "story_v_out_102071.awb")

						arg_54_1:RecordAudio("102071014", var_57_44)
						arg_54_1:RecordAudio("102071014", var_57_44)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_102071", "102071014", "story_v_out_102071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_102071", "102071014", "story_v_out_102071.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_45 = math.max(var_57_36, arg_54_1.talkMaxDuration)

			if var_57_35 <= arg_54_1.time_ and arg_54_1.time_ < var_57_35 + var_57_45 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_35) / var_57_45

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_35 + var_57_45 and arg_54_1.time_ < var_57_35 + var_57_45 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play102071015 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 102071015
		arg_58_1.duration_ = 17.1

		local var_58_0 = {
			ja = 17.1,
			ko = 12.733,
			zh = 10.4,
			en = 13.2
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
				arg_58_0:Play102071016(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["3008ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect3008ui_story == nil then
				arg_58_1.var_.characterEffect3008ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.1

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect3008ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect3008ui_story then
				arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["1011ui_story"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1011ui_story == nil then
				arg_58_1.var_.characterEffect1011ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.1

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect1011ui_story and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1011ui_story.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1011ui_story then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1011ui_story.fillRatio = var_61_9
			end

			local var_61_10 = arg_58_1.actors_["1011ui_story"].transform
			local var_61_11 = 0

			if var_61_11 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1.var_.moveOldPos1011ui_story = var_61_10.localPosition
			end

			local var_61_12 = 0.001

			if var_61_11 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_12 then
				local var_61_13 = (arg_58_1.time_ - var_61_11) / var_61_12
				local var_61_14 = Vector3.New(0, 100, 0)

				var_61_10.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1011ui_story, var_61_14, var_61_13)

				local var_61_15 = manager.ui.mainCamera.transform.position - var_61_10.position

				var_61_10.forward = Vector3.New(var_61_15.x, var_61_15.y, var_61_15.z)

				local var_61_16 = var_61_10.localEulerAngles

				var_61_16.z = 0
				var_61_16.x = 0
				var_61_10.localEulerAngles = var_61_16
			end

			if arg_58_1.time_ >= var_61_11 + var_61_12 and arg_58_1.time_ < var_61_11 + var_61_12 + arg_61_0 then
				var_61_10.localPosition = Vector3.New(0, 100, 0)

				local var_61_17 = manager.ui.mainCamera.transform.position - var_61_10.position

				var_61_10.forward = Vector3.New(var_61_17.x, var_61_17.y, var_61_17.z)

				local var_61_18 = var_61_10.localEulerAngles

				var_61_18.z = 0
				var_61_18.x = 0
				var_61_10.localEulerAngles = var_61_18
			end

			local var_61_19 = arg_58_1.actors_["3008ui_story"].transform
			local var_61_20 = 0

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1.var_.moveOldPos3008ui_story = var_61_19.localPosition
			end

			local var_61_21 = 0.001

			if var_61_20 <= arg_58_1.time_ and arg_58_1.time_ < var_61_20 + var_61_21 then
				local var_61_22 = (arg_58_1.time_ - var_61_20) / var_61_21
				local var_61_23 = Vector3.New(0, -1.51, -4.3)

				var_61_19.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos3008ui_story, var_61_23, var_61_22)

				local var_61_24 = manager.ui.mainCamera.transform.position - var_61_19.position

				var_61_19.forward = Vector3.New(var_61_24.x, var_61_24.y, var_61_24.z)

				local var_61_25 = var_61_19.localEulerAngles

				var_61_25.z = 0
				var_61_25.x = 0
				var_61_19.localEulerAngles = var_61_25
			end

			if arg_58_1.time_ >= var_61_20 + var_61_21 and arg_58_1.time_ < var_61_20 + var_61_21 + arg_61_0 then
				var_61_19.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_61_26 = manager.ui.mainCamera.transform.position - var_61_19.position

				var_61_19.forward = Vector3.New(var_61_26.x, var_61_26.y, var_61_26.z)

				local var_61_27 = var_61_19.localEulerAngles

				var_61_27.z = 0
				var_61_27.x = 0
				var_61_19.localEulerAngles = var_61_27
			end

			local var_61_28 = 0

			if var_61_28 < arg_58_1.time_ and arg_58_1.time_ <= var_61_28 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_61_29 = 0

			if var_61_29 < arg_58_1.time_ and arg_58_1.time_ <= var_61_29 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_61_30 = 0
			local var_61_31 = 1.35

			if var_61_30 < arg_58_1.time_ and arg_58_1.time_ <= var_61_30 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_32 = arg_58_1:FormatText(StoryNameCfg[20].name)

				arg_58_1.leftNameTxt_.text = var_61_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_33 = arg_58_1:GetWordFromCfg(102071015)
				local var_61_34 = arg_58_1:FormatText(var_61_33.content)

				arg_58_1.text_.text = var_61_34

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_35 = 54
				local var_61_36 = utf8.len(var_61_34)
				local var_61_37 = var_61_35 <= 0 and var_61_31 or var_61_31 * (var_61_36 / var_61_35)

				if var_61_37 > 0 and var_61_31 < var_61_37 then
					arg_58_1.talkMaxDuration = var_61_37

					if var_61_37 + var_61_30 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_37 + var_61_30
					end
				end

				arg_58_1.text_.text = var_61_34
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071015", "story_v_out_102071.awb") ~= 0 then
					local var_61_38 = manager.audio:GetVoiceLength("story_v_out_102071", "102071015", "story_v_out_102071.awb") / 1000

					if var_61_38 + var_61_30 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_38 + var_61_30
					end

					if var_61_33.prefab_name ~= "" and arg_58_1.actors_[var_61_33.prefab_name] ~= nil then
						local var_61_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_33.prefab_name].transform, "story_v_out_102071", "102071015", "story_v_out_102071.awb")

						arg_58_1:RecordAudio("102071015", var_61_39)
						arg_58_1:RecordAudio("102071015", var_61_39)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_102071", "102071015", "story_v_out_102071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_102071", "102071015", "story_v_out_102071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_40 = math.max(var_61_31, arg_58_1.talkMaxDuration)

			if var_61_30 <= arg_58_1.time_ and arg_58_1.time_ < var_61_30 + var_61_40 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_30) / var_61_40

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_30 + var_61_40 and arg_58_1.time_ < var_61_30 + var_61_40 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play102071016 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 102071016
		arg_62_1.duration_ = 6.07

		local var_62_0 = {
			ja = 6.066,
			ko = 2.933,
			zh = 3.266,
			en = 4
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
				arg_62_0:Play102071017(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1019ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1019ui_story == nil then
				arg_62_1.var_.characterEffect1019ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1019ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1019ui_story then
				arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["3008ui_story"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.1

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_62_1.var_.characterEffect3008ui_story.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect3008ui_story then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_62_1.var_.characterEffect3008ui_story.fillRatio = var_65_9
			end

			local var_65_10 = arg_62_1.actors_["3008ui_story"].transform
			local var_65_11 = 0

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.var_.moveOldPos3008ui_story = var_65_10.localPosition
			end

			local var_65_12 = 0.5

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_11) / var_65_12
				local var_65_14 = Vector3.New(0.7, -1.51, -4.3)

				var_65_10.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos3008ui_story, var_65_14, var_65_13)

				local var_65_15 = manager.ui.mainCamera.transform.position - var_65_10.position

				var_65_10.forward = Vector3.New(var_65_15.x, var_65_15.y, var_65_15.z)

				local var_65_16 = var_65_10.localEulerAngles

				var_65_16.z = 0
				var_65_16.x = 0
				var_65_10.localEulerAngles = var_65_16
			end

			if arg_62_1.time_ >= var_65_11 + var_65_12 and arg_62_1.time_ < var_65_11 + var_65_12 + arg_65_0 then
				var_65_10.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_65_17 = manager.ui.mainCamera.transform.position - var_65_10.position

				var_65_10.forward = Vector3.New(var_65_17.x, var_65_17.y, var_65_17.z)

				local var_65_18 = var_65_10.localEulerAngles

				var_65_18.z = 0
				var_65_18.x = 0
				var_65_10.localEulerAngles = var_65_18
			end

			local var_65_19 = arg_62_1.actors_["1019ui_story"].transform
			local var_65_20 = 0

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1.var_.moveOldPos1019ui_story = var_65_19.localPosition
			end

			local var_65_21 = 0.001

			if var_65_20 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_21 then
				local var_65_22 = (arg_62_1.time_ - var_65_20) / var_65_21
				local var_65_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_65_19.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1019ui_story, var_65_23, var_65_22)

				local var_65_24 = manager.ui.mainCamera.transform.position - var_65_19.position

				var_65_19.forward = Vector3.New(var_65_24.x, var_65_24.y, var_65_24.z)

				local var_65_25 = var_65_19.localEulerAngles

				var_65_25.z = 0
				var_65_25.x = 0
				var_65_19.localEulerAngles = var_65_25
			end

			if arg_62_1.time_ >= var_65_20 + var_65_21 and arg_62_1.time_ < var_65_20 + var_65_21 + arg_65_0 then
				var_65_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_65_26 = manager.ui.mainCamera.transform.position - var_65_19.position

				var_65_19.forward = Vector3.New(var_65_26.x, var_65_26.y, var_65_26.z)

				local var_65_27 = var_65_19.localEulerAngles

				var_65_27.z = 0
				var_65_27.x = 0
				var_65_19.localEulerAngles = var_65_27
			end

			local var_65_28 = 0

			if var_65_28 < arg_62_1.time_ and arg_62_1.time_ <= var_65_28 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_65_29 = 0
			local var_65_30 = 0.425

			if var_65_29 < arg_62_1.time_ and arg_62_1.time_ <= var_65_29 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_31 = arg_62_1:FormatText(StoryNameCfg[13].name)

				arg_62_1.leftNameTxt_.text = var_65_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_32 = arg_62_1:GetWordFromCfg(102071016)
				local var_65_33 = arg_62_1:FormatText(var_65_32.content)

				arg_62_1.text_.text = var_65_33

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_34 = 17
				local var_65_35 = utf8.len(var_65_33)
				local var_65_36 = var_65_34 <= 0 and var_65_30 or var_65_30 * (var_65_35 / var_65_34)

				if var_65_36 > 0 and var_65_30 < var_65_36 then
					arg_62_1.talkMaxDuration = var_65_36

					if var_65_36 + var_65_29 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_36 + var_65_29
					end
				end

				arg_62_1.text_.text = var_65_33
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071016", "story_v_out_102071.awb") ~= 0 then
					local var_65_37 = manager.audio:GetVoiceLength("story_v_out_102071", "102071016", "story_v_out_102071.awb") / 1000

					if var_65_37 + var_65_29 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_37 + var_65_29
					end

					if var_65_32.prefab_name ~= "" and arg_62_1.actors_[var_65_32.prefab_name] ~= nil then
						local var_65_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_32.prefab_name].transform, "story_v_out_102071", "102071016", "story_v_out_102071.awb")

						arg_62_1:RecordAudio("102071016", var_65_38)
						arg_62_1:RecordAudio("102071016", var_65_38)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_102071", "102071016", "story_v_out_102071.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_102071", "102071016", "story_v_out_102071.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_39 = math.max(var_65_30, arg_62_1.talkMaxDuration)

			if var_65_29 <= arg_62_1.time_ and arg_62_1.time_ < var_65_29 + var_65_39 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_29) / var_65_39

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_29 + var_65_39 and arg_62_1.time_ < var_65_29 + var_65_39 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play102071017 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 102071017
		arg_66_1.duration_ = 4.6

		local var_66_0 = {
			ja = 4.6,
			ko = 3.766,
			zh = 3.966,
			en = 4.166
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
				arg_66_0:Play102071018(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["3008ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect3008ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story then
				arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["1019ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.1

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1019ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1019ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1019ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_69_12 = 0
			local var_69_13 = 0.375

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_14 = arg_66_1:FormatText(StoryNameCfg[20].name)

				arg_66_1.leftNameTxt_.text = var_69_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_15 = arg_66_1:GetWordFromCfg(102071017)
				local var_69_16 = arg_66_1:FormatText(var_69_15.content)

				arg_66_1.text_.text = var_69_16

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 15
				local var_69_18 = utf8.len(var_69_16)
				local var_69_19 = var_69_17 <= 0 and var_69_13 or var_69_13 * (var_69_18 / var_69_17)

				if var_69_19 > 0 and var_69_13 < var_69_19 then
					arg_66_1.talkMaxDuration = var_69_19

					if var_69_19 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_16
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071017", "story_v_out_102071.awb") ~= 0 then
					local var_69_20 = manager.audio:GetVoiceLength("story_v_out_102071", "102071017", "story_v_out_102071.awb") / 1000

					if var_69_20 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_12
					end

					if var_69_15.prefab_name ~= "" and arg_66_1.actors_[var_69_15.prefab_name] ~= nil then
						local var_69_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_15.prefab_name].transform, "story_v_out_102071", "102071017", "story_v_out_102071.awb")

						arg_66_1:RecordAudio("102071017", var_69_21)
						arg_66_1:RecordAudio("102071017", var_69_21)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_102071", "102071017", "story_v_out_102071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_102071", "102071017", "story_v_out_102071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_22 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_12) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_12 + var_69_22 and arg_66_1.time_ < var_69_12 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play102071018 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 102071018
		arg_70_1.duration_ = 3.67

		local var_70_0 = {
			ja = 2.4,
			ko = 3.666,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_70_0:Play102071019(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1084ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["3008ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.1

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect3008ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_70_1.var_.characterEffect3008ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect3008ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_70_1.var_.characterEffect3008ui_story.fillRatio = var_73_9
			end

			local var_73_10 = arg_70_1.actors_["1019ui_story"].transform
			local var_73_11 = 0

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1.var_.moveOldPos1019ui_story = var_73_10.localPosition
			end

			local var_73_12 = 0.001

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_12 then
				local var_73_13 = (arg_70_1.time_ - var_73_11) / var_73_12
				local var_73_14 = Vector3.New(0, 100, 0)

				var_73_10.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1019ui_story, var_73_14, var_73_13)

				local var_73_15 = manager.ui.mainCamera.transform.position - var_73_10.position

				var_73_10.forward = Vector3.New(var_73_15.x, var_73_15.y, var_73_15.z)

				local var_73_16 = var_73_10.localEulerAngles

				var_73_16.z = 0
				var_73_16.x = 0
				var_73_10.localEulerAngles = var_73_16
			end

			if arg_70_1.time_ >= var_73_11 + var_73_12 and arg_70_1.time_ < var_73_11 + var_73_12 + arg_73_0 then
				var_73_10.localPosition = Vector3.New(0, 100, 0)

				local var_73_17 = manager.ui.mainCamera.transform.position - var_73_10.position

				var_73_10.forward = Vector3.New(var_73_17.x, var_73_17.y, var_73_17.z)

				local var_73_18 = var_73_10.localEulerAngles

				var_73_18.z = 0
				var_73_18.x = 0
				var_73_10.localEulerAngles = var_73_18
			end

			local var_73_19 = arg_70_1.actors_["1084ui_story"].transform
			local var_73_20 = 0

			if var_73_20 < arg_70_1.time_ and arg_70_1.time_ <= var_73_20 + arg_73_0 then
				arg_70_1.var_.moveOldPos1084ui_story = var_73_19.localPosition

				local var_73_21 = "1084ui_story"

				arg_70_1:ShowWeapon(arg_70_1.var_[var_73_21 .. "Animator"].transform, true)
			end

			local var_73_22 = 0.001

			if var_73_20 <= arg_70_1.time_ and arg_70_1.time_ < var_73_20 + var_73_22 then
				local var_73_23 = (arg_70_1.time_ - var_73_20) / var_73_22
				local var_73_24 = Vector3.New(-0.7, -0.97, -6)

				var_73_19.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1084ui_story, var_73_24, var_73_23)

				local var_73_25 = manager.ui.mainCamera.transform.position - var_73_19.position

				var_73_19.forward = Vector3.New(var_73_25.x, var_73_25.y, var_73_25.z)

				local var_73_26 = var_73_19.localEulerAngles

				var_73_26.z = 0
				var_73_26.x = 0
				var_73_19.localEulerAngles = var_73_26
			end

			if arg_70_1.time_ >= var_73_20 + var_73_22 and arg_70_1.time_ < var_73_20 + var_73_22 + arg_73_0 then
				var_73_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_73_27 = manager.ui.mainCamera.transform.position - var_73_19.position

				var_73_19.forward = Vector3.New(var_73_27.x, var_73_27.y, var_73_27.z)

				local var_73_28 = var_73_19.localEulerAngles

				var_73_28.z = 0
				var_73_28.x = 0
				var_73_19.localEulerAngles = var_73_28
			end

			local var_73_29 = 0

			if var_73_29 < arg_70_1.time_ and arg_70_1.time_ <= var_73_29 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_73_30 = 0

			if var_73_30 < arg_70_1.time_ and arg_70_1.time_ <= var_73_30 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_73_31 = 0
			local var_73_32 = 0.15

			if var_73_31 < arg_70_1.time_ and arg_70_1.time_ <= var_73_31 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_33 = arg_70_1:FormatText(StoryNameCfg[6].name)

				arg_70_1.leftNameTxt_.text = var_73_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_34 = arg_70_1:GetWordFromCfg(102071018)
				local var_73_35 = arg_70_1:FormatText(var_73_34.content)

				arg_70_1.text_.text = var_73_35

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_36 = 6
				local var_73_37 = utf8.len(var_73_35)
				local var_73_38 = var_73_36 <= 0 and var_73_32 or var_73_32 * (var_73_37 / var_73_36)

				if var_73_38 > 0 and var_73_32 < var_73_38 then
					arg_70_1.talkMaxDuration = var_73_38

					if var_73_38 + var_73_31 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_38 + var_73_31
					end
				end

				arg_70_1.text_.text = var_73_35
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071018", "story_v_out_102071.awb") ~= 0 then
					local var_73_39 = manager.audio:GetVoiceLength("story_v_out_102071", "102071018", "story_v_out_102071.awb") / 1000

					if var_73_39 + var_73_31 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_39 + var_73_31
					end

					if var_73_34.prefab_name ~= "" and arg_70_1.actors_[var_73_34.prefab_name] ~= nil then
						local var_73_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_34.prefab_name].transform, "story_v_out_102071", "102071018", "story_v_out_102071.awb")

						arg_70_1:RecordAudio("102071018", var_73_40)
						arg_70_1:RecordAudio("102071018", var_73_40)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_102071", "102071018", "story_v_out_102071.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_102071", "102071018", "story_v_out_102071.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_41 = math.max(var_73_32, arg_70_1.talkMaxDuration)

			if var_73_31 <= arg_70_1.time_ and arg_70_1.time_ < var_73_31 + var_73_41 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_31) / var_73_41

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_31 + var_73_41 and arg_70_1.time_ < var_73_31 + var_73_41 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play102071019 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 102071019
		arg_74_1.duration_ = 3.5

		local var_74_0 = {
			ja = 1.999999999999,
			ko = 2.366,
			zh = 3.1,
			en = 3.5
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
				arg_74_0:Play102071020(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["3008ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect3008ui_story == nil then
				arg_74_1.var_.characterEffect3008ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect3008ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect3008ui_story then
				arg_74_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["1084ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1084ui_story == nil then
				arg_74_1.var_.characterEffect1084ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.1

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect1084ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1084ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1084ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1084ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_77_11 = 0

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_77_12 = 0
			local var_77_13 = 0.3

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_14 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_14:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_15 = arg_74_1:FormatText(StoryNameCfg[20].name)

				arg_74_1.leftNameTxt_.text = var_77_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_16 = arg_74_1:GetWordFromCfg(102071019)
				local var_77_17 = arg_74_1:FormatText(var_77_16.content)

				arg_74_1.text_.text = var_77_17

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_18 = 12
				local var_77_19 = utf8.len(var_77_17)
				local var_77_20 = var_77_18 <= 0 and var_77_13 or var_77_13 * (var_77_19 / var_77_18)

				if var_77_20 > 0 and var_77_13 < var_77_20 then
					arg_74_1.talkMaxDuration = var_77_20
					var_77_12 = var_77_12 + 0.3

					if var_77_20 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_20 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_17
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071019", "story_v_out_102071.awb") ~= 0 then
					local var_77_21 = manager.audio:GetVoiceLength("story_v_out_102071", "102071019", "story_v_out_102071.awb") / 1000

					if var_77_21 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_21 + var_77_12
					end

					if var_77_16.prefab_name ~= "" and arg_74_1.actors_[var_77_16.prefab_name] ~= nil then
						local var_77_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_16.prefab_name].transform, "story_v_out_102071", "102071019", "story_v_out_102071.awb")

						arg_74_1:RecordAudio("102071019", var_77_22)
						arg_74_1:RecordAudio("102071019", var_77_22)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_102071", "102071019", "story_v_out_102071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_102071", "102071019", "story_v_out_102071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_23 = var_77_12 + 0.3
			local var_77_24 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_23 <= arg_74_1.time_ and arg_74_1.time_ < var_77_23 + var_77_24 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_23) / var_77_24

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_23 + var_77_24 and arg_74_1.time_ < var_77_23 + var_77_24 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play102071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102071020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play102071023(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["3008ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect3008ui_story == nil then
				arg_80_1.var_.characterEffect3008ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect3008ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_80_1.var_.characterEffect3008ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect3008ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_80_1.var_.characterEffect3008ui_story.fillRatio = var_83_5
			end

			local var_83_6 = arg_80_1.actors_["1084ui_story"].transform
			local var_83_7 = 0

			if var_83_7 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_6.localPosition
			end

			local var_83_8 = 0.001

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_8 then
				local var_83_9 = (arg_80_1.time_ - var_83_7) / var_83_8
				local var_83_10 = Vector3.New(0, 100, 0)

				var_83_6.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, var_83_10, var_83_9)

				local var_83_11 = manager.ui.mainCamera.transform.position - var_83_6.position

				var_83_6.forward = Vector3.New(var_83_11.x, var_83_11.y, var_83_11.z)

				local var_83_12 = var_83_6.localEulerAngles

				var_83_12.z = 0
				var_83_12.x = 0
				var_83_6.localEulerAngles = var_83_12
			end

			if arg_80_1.time_ >= var_83_7 + var_83_8 and arg_80_1.time_ < var_83_7 + var_83_8 + arg_83_0 then
				var_83_6.localPosition = Vector3.New(0, 100, 0)

				local var_83_13 = manager.ui.mainCamera.transform.position - var_83_6.position

				var_83_6.forward = Vector3.New(var_83_13.x, var_83_13.y, var_83_13.z)

				local var_83_14 = var_83_6.localEulerAngles

				var_83_14.z = 0
				var_83_14.x = 0
				var_83_6.localEulerAngles = var_83_14
			end

			local var_83_15 = arg_80_1.actors_["3008ui_story"].transform
			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.var_.moveOldPos3008ui_story = var_83_15.localPosition
			end

			local var_83_17 = 0.001

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_16) / var_83_17
				local var_83_19 = Vector3.New(0, 100, 0)

				var_83_15.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos3008ui_story, var_83_19, var_83_18)

				local var_83_20 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_20.x, var_83_20.y, var_83_20.z)

				local var_83_21 = var_83_15.localEulerAngles

				var_83_21.z = 0
				var_83_21.x = 0
				var_83_15.localEulerAngles = var_83_21
			end

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				var_83_15.localPosition = Vector3.New(0, 100, 0)

				local var_83_22 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_22.x, var_83_22.y, var_83_22.z)

				local var_83_23 = var_83_15.localEulerAngles

				var_83_23.z = 0
				var_83_23.x = 0
				var_83_15.localEulerAngles = var_83_23
			end

			local var_83_24 = 0
			local var_83_25 = 0.575

			if var_83_24 < arg_80_1.time_ and arg_80_1.time_ <= var_83_24 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_26 = arg_80_1:GetWordFromCfg(102071020)
				local var_83_27 = arg_80_1:FormatText(var_83_26.content)

				arg_80_1.text_.text = var_83_27

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_28 = 23
				local var_83_29 = utf8.len(var_83_27)
				local var_83_30 = var_83_28 <= 0 and var_83_25 or var_83_25 * (var_83_29 / var_83_28)

				if var_83_30 > 0 and var_83_25 < var_83_30 then
					arg_80_1.talkMaxDuration = var_83_30

					if var_83_30 + var_83_24 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_30 + var_83_24
					end
				end

				arg_80_1.text_.text = var_83_27
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_31 = math.max(var_83_25, arg_80_1.talkMaxDuration)

			if var_83_24 <= arg_80_1.time_ and arg_80_1.time_ < var_83_24 + var_83_31 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_24) / var_83_31

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_24 + var_83_31 and arg_80_1.time_ < var_83_24 + var_83_31 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play102071023 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102071023
		arg_84_1.duration_ = 6.5

		local var_84_0 = {
			ja = 6.5,
			ko = 4.8,
			zh = 4,
			en = 5.2
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102071024(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_1 = 0.5

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_1 then
				local var_87_2 = (arg_84_1.time_ - var_87_0) / var_87_1
				local var_87_3 = Color.New(1, 1, 1)

				var_87_3.a = Mathf.Lerp(1, 0, var_87_2)
				arg_84_1.mask_.color = var_87_3
			end

			if arg_84_1.time_ >= var_87_0 + var_87_1 and arg_84_1.time_ < var_87_0 + var_87_1 + arg_87_0 then
				local var_87_4 = Color.New(1, 1, 1)
				local var_87_5 = 0

				arg_84_1.mask_.enabled = false
				var_87_4.a = var_87_5
				arg_84_1.mask_.color = var_87_4
			end

			local var_87_6 = manager.ui.mainCamera.transform
			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.var_.shakeOldPosMainCamera = var_87_6.localPosition
			end

			local var_87_8 = 0.600000023841858

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_8 then
				local var_87_9 = (arg_84_1.time_ - var_87_7) / 0.066
				local var_87_10, var_87_11 = math.modf(var_87_9)

				var_87_6.localPosition = Vector3.New(var_87_11 * 0.13, var_87_11 * 0.13, var_87_11 * 0.13) + arg_84_1.var_.shakeOldPosMainCamera
			end

			if arg_84_1.time_ >= var_87_7 + var_87_8 and arg_84_1.time_ < var_87_7 + var_87_8 + arg_87_0 then
				var_87_6.localPosition = arg_84_1.var_.shakeOldPosMainCamera
			end

			local var_87_12 = 0
			local var_87_13 = 0.5

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_14 = arg_84_1:FormatText(StoryNameCfg[20].name)

				arg_84_1.leftNameTxt_.text = var_87_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_15 = arg_84_1:GetWordFromCfg(102071023)
				local var_87_16 = arg_84_1:FormatText(var_87_15.content)

				arg_84_1.text_.text = var_87_16

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 20
				local var_87_18 = utf8.len(var_87_16)
				local var_87_19 = var_87_17 <= 0 and var_87_13 or var_87_13 * (var_87_18 / var_87_17)

				if var_87_19 > 0 and var_87_13 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19

					if var_87_19 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_16
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071023", "story_v_out_102071.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_102071", "102071023", "story_v_out_102071.awb") / 1000

					if var_87_20 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_12
					end

					if var_87_15.prefab_name ~= "" and arg_84_1.actors_[var_87_15.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_15.prefab_name].transform, "story_v_out_102071", "102071023", "story_v_out_102071.awb")

						arg_84_1:RecordAudio("102071023", var_87_21)
						arg_84_1:RecordAudio("102071023", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_102071", "102071023", "story_v_out_102071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_102071", "102071023", "story_v_out_102071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_12) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_12 + var_87_22 and arg_84_1.time_ < var_87_12 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play102071024 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102071024
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play102071025(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_2 = "play"
				local var_91_3 = "effect"

				arg_88_1:AudioAction(var_91_2, var_91_3, "se_story_2", "se_story_2_stun", "")
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = false

				arg_88_1:SetGaussion(false)
			end

			local var_91_5 = 1.5

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_5 then
				local var_91_6 = (arg_88_1.time_ - var_91_4) / var_91_5
				local var_91_7 = Color.New(1, 1, 1)

				var_91_7.a = Mathf.Lerp(0, 1, var_91_6)
				arg_88_1.mask_.color = var_91_7
			end

			if arg_88_1.time_ >= var_91_4 + var_91_5 and arg_88_1.time_ < var_91_4 + var_91_5 + arg_91_0 then
				local var_91_8 = Color.New(1, 1, 1)

				var_91_8.a = 1
				arg_88_1.mask_.color = var_91_8
			end

			local var_91_9 = "S0203"

			if arg_88_1.bgs_[var_91_9] == nil then
				local var_91_10 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_9)
				var_91_10.name = var_91_9
				var_91_10.transform.parent = arg_88_1.stage_.transform
				var_91_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_9] = var_91_10
			end

			local var_91_11 = arg_88_1.bgs_.S0203.transform
			local var_91_12 = 1.5

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.var_.moveOldPosS0203 = var_91_11.localPosition
			end

			local var_91_13 = 0.001

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13
				local var_91_15 = Vector3.New(0, -100, 10)

				var_91_11.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosS0203, var_91_15, var_91_14)
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 then
				var_91_11.localPosition = Vector3.New(0, -100, 10)
			end

			local var_91_16 = 1.5

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = false

				arg_88_1:SetGaussion(false)
			end

			local var_91_17 = 1.5

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_17 then
				local var_91_18 = (arg_88_1.time_ - var_91_16) / var_91_17
				local var_91_19 = Color.New(1, 1, 1)

				var_91_19.a = Mathf.Lerp(1, 0, var_91_18)
				arg_88_1.mask_.color = var_91_19
			end

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 then
				local var_91_20 = Color.New(1, 1, 1)
				local var_91_21 = 0

				arg_88_1.mask_.enabled = false
				var_91_20.a = var_91_21
				arg_88_1.mask_.color = var_91_20
			end

			local var_91_22 = "STwhite"

			if arg_88_1.bgs_[var_91_22] == nil then
				local var_91_23 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_23:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_22)
				var_91_23.name = var_91_22
				var_91_23.transform.parent = arg_88_1.stage_.transform
				var_91_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_22] = var_91_23
			end

			local var_91_24 = arg_88_1.bgs_.STwhite.transform
			local var_91_25 = 1.5

			if var_91_25 < arg_88_1.time_ and arg_88_1.time_ <= var_91_25 + arg_91_0 then
				arg_88_1.var_.moveOldPosSTwhite = var_91_24.localPosition
				var_91_24.localScale = Vector3.New(20, 20, 20)
			end

			local var_91_26 = 0.001

			if var_91_25 <= arg_88_1.time_ and arg_88_1.time_ < var_91_25 + var_91_26 then
				local var_91_27 = (arg_88_1.time_ - var_91_25) / var_91_26
				local var_91_28 = Vector3.New(0, 0, 0)

				var_91_24.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosSTwhite, var_91_28, var_91_27)
			end

			if arg_88_1.time_ >= var_91_25 + var_91_26 and arg_88_1.time_ < var_91_25 + var_91_26 + arg_91_0 then
				var_91_24.localPosition = Vector3.New(0, 0, 0)
			end

			local var_91_29 = 0

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_30 = 1.534

			if arg_88_1.time_ >= var_91_29 + var_91_30 and arg_88_1.time_ < var_91_29 + var_91_30 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_31 = 0
			local var_91_32 = 0.125

			if var_91_31 < arg_88_1.time_ and arg_88_1.time_ <= var_91_31 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_33 = arg_88_1:GetWordFromCfg(102071024)
				local var_91_34 = arg_88_1:FormatText(var_91_33.content)

				arg_88_1.text_.text = var_91_34

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_35 = 5
				local var_91_36 = utf8.len(var_91_34)
				local var_91_37 = var_91_35 <= 0 and var_91_32 or var_91_32 * (var_91_36 / var_91_35)

				if var_91_37 > 0 and var_91_32 < var_91_37 then
					arg_88_1.talkMaxDuration = var_91_37

					if var_91_37 + var_91_31 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_31
					end
				end

				arg_88_1.text_.text = var_91_34
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_38 = math.max(var_91_32, arg_88_1.talkMaxDuration)

			if var_91_31 <= arg_88_1.time_ and arg_88_1.time_ < var_91_31 + var_91_38 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_31) / var_91_38

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_31 + var_91_38 and arg_88_1.time_ < var_91_31 + var_91_38 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play102071025 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102071025
		arg_92_1.duration_ = 4.1

		local var_92_0 = {
			ja = 2.933,
			ko = 4.1,
			zh = 3.366,
			en = 3.466
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play102071026(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.325

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(102071025)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 13
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071025", "story_v_out_102071.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071025", "story_v_out_102071.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_102071", "102071025", "story_v_out_102071.awb")

						arg_92_1:RecordAudio("102071025", var_95_9)
						arg_92_1:RecordAudio("102071025", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102071", "102071025", "story_v_out_102071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102071", "102071025", "story_v_out_102071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play102071026 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102071026
		arg_96_1.duration_ = 2.8

		local var_96_0 = {
			ja = 2.8,
			ko = 2.666,
			zh = 2.366,
			en = 2.633
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play102071027(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.275

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[13].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(102071026)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 11
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071026", "story_v_out_102071.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071026", "story_v_out_102071.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_102071", "102071026", "story_v_out_102071.awb")

						arg_96_1:RecordAudio("102071026", var_99_9)
						arg_96_1:RecordAudio("102071026", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102071", "102071026", "story_v_out_102071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102071", "102071026", "story_v_out_102071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play102071027 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102071027
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play102071028(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.425

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(102071027)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 17
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play102071028 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102071028
		arg_104_1.duration_ = 6.8

		local var_104_0 = {
			ja = 6.8,
			ko = 3.466,
			zh = 3.033,
			en = 4.3
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play102071029(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.475

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[10].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(102071028)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 15
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071028", "story_v_out_102071.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071028", "story_v_out_102071.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_102071", "102071028", "story_v_out_102071.awb")

						arg_104_1:RecordAudio("102071028", var_107_9)
						arg_104_1:RecordAudio("102071028", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102071", "102071028", "story_v_out_102071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102071", "102071028", "story_v_out_102071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play102071029 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102071029
		arg_108_1.duration_ = 7.53

		local var_108_0 = {
			ja = 6.2,
			ko = 7.533,
			zh = 5.7,
			en = 6.033
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play102071030(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.bgs_.STwhite.transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPosSTwhite = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, -100, 10)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPosSTwhite, var_111_4, var_111_3)
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_6 = 1.5

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6
				local var_111_8 = Color.New(1, 1, 1)

				var_111_8.a = Mathf.Lerp(1, 0, var_111_7)
				arg_108_1.mask_.color = var_111_8
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 then
				local var_111_9 = Color.New(1, 1, 1)
				local var_111_10 = 0

				arg_108_1.mask_.enabled = false
				var_111_9.a = var_111_10
				arg_108_1.mask_.color = var_111_9
			end

			local var_111_11 = 1.5

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				local var_111_12 = manager.ui.mainCamera.transform.localPosition
				local var_111_13 = Vector3.New(0, 0, 10) + Vector3.New(var_111_12.x, var_111_12.y, 0)
				local var_111_14 = arg_108_1.bgs_.B02a

				var_111_14.transform.localPosition = var_111_13
				var_111_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_15 = var_111_14:GetComponent("SpriteRenderer")

				if var_111_15 and var_111_15.sprite then
					local var_111_16 = (var_111_14.transform.localPosition - var_111_12).z
					local var_111_17 = manager.ui.mainCameraCom_
					local var_111_18 = 2 * var_111_16 * Mathf.Tan(var_111_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_111_19 = var_111_18 * var_111_17.aspect
					local var_111_20 = var_111_15.sprite.bounds.size.x
					local var_111_21 = var_111_15.sprite.bounds.size.y
					local var_111_22 = var_111_19 / var_111_20
					local var_111_23 = var_111_18 / var_111_21
					local var_111_24 = var_111_23 < var_111_22 and var_111_22 or var_111_23

					var_111_14.transform.localScale = Vector3.New(var_111_24, var_111_24, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "B02a" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_25 = 0

			if var_111_25 < arg_108_1.time_ and arg_108_1.time_ <= var_111_25 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			local var_111_26 = 2

			if arg_108_1.time_ >= var_111_25 + var_111_26 and arg_108_1.time_ < var_111_25 + var_111_26 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			local var_111_27 = 2
			local var_111_28 = 0.45

			if var_111_27 < arg_108_1.time_ and arg_108_1.time_ <= var_111_27 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_29 = arg_108_1:FormatText(StoryNameCfg[20].name)

				arg_108_1.leftNameTxt_.text = var_111_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_30 = arg_108_1:GetWordFromCfg(102071029)
				local var_111_31 = arg_108_1:FormatText(var_111_30.content)

				arg_108_1.text_.text = var_111_31

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_32 = 18
				local var_111_33 = utf8.len(var_111_31)
				local var_111_34 = var_111_32 <= 0 and var_111_28 or var_111_28 * (var_111_33 / var_111_32)

				if var_111_34 > 0 and var_111_28 < var_111_34 then
					arg_108_1.talkMaxDuration = var_111_34

					if var_111_34 + var_111_27 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_34 + var_111_27
					end
				end

				arg_108_1.text_.text = var_111_31
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071029", "story_v_out_102071.awb") ~= 0 then
					local var_111_35 = manager.audio:GetVoiceLength("story_v_out_102071", "102071029", "story_v_out_102071.awb") / 1000

					if var_111_35 + var_111_27 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_35 + var_111_27
					end

					if var_111_30.prefab_name ~= "" and arg_108_1.actors_[var_111_30.prefab_name] ~= nil then
						local var_111_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_30.prefab_name].transform, "story_v_out_102071", "102071029", "story_v_out_102071.awb")

						arg_108_1:RecordAudio("102071029", var_111_36)
						arg_108_1:RecordAudio("102071029", var_111_36)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102071", "102071029", "story_v_out_102071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102071", "102071029", "story_v_out_102071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_37 = math.max(var_111_28, arg_108_1.talkMaxDuration)

			if var_111_27 <= arg_108_1.time_ and arg_108_1.time_ < var_111_27 + var_111_37 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_27) / var_111_37

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_27 + var_111_37 and arg_108_1.time_ < var_111_27 + var_111_37 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play102071030 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102071030
		arg_112_1.duration_ = 3.07

		local var_112_0 = {
			ja = 2.5,
			ko = 2.3,
			zh = 3.066,
			en = 2.5
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play102071031(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.375

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[20].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(102071030)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 15
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071030", "story_v_out_102071.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071030", "story_v_out_102071.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_102071", "102071030", "story_v_out_102071.awb")

						arg_112_1:RecordAudio("102071030", var_115_9)
						arg_112_1:RecordAudio("102071030", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102071", "102071030", "story_v_out_102071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102071", "102071030", "story_v_out_102071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play102071031 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 102071031
		arg_116_1.duration_ = 2.43

		local var_116_0 = {
			ja = 2,
			ko = 2.366,
			zh = 2.133,
			en = 2.433
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play102071032(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.2

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[19].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(102071031)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 8
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071031", "story_v_out_102071.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071031", "story_v_out_102071.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_102071", "102071031", "story_v_out_102071.awb")

						arg_116_1:RecordAudio("102071031", var_119_9)
						arg_116_1:RecordAudio("102071031", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_102071", "102071031", "story_v_out_102071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_102071", "102071031", "story_v_out_102071.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play102071032 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 102071032
		arg_120_1.duration_ = 4.8

		local var_120_0 = {
			ja = 4.8,
			ko = 3.533,
			zh = 4.033,
			en = 4.633
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play102071033(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.425

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[19].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(102071032)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 17
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071032", "story_v_out_102071.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071032", "story_v_out_102071.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_102071", "102071032", "story_v_out_102071.awb")

						arg_120_1:RecordAudio("102071032", var_123_9)
						arg_120_1:RecordAudio("102071032", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_102071", "102071032", "story_v_out_102071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_102071", "102071032", "story_v_out_102071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play102071033 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 102071033
		arg_124_1.duration_ = 4.63

		local var_124_0 = {
			ja = 4.433,
			ko = 3.733,
			zh = 3.133,
			en = 4.633
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play102071034(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.375

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[33].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(102071033)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 15
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071033", "story_v_out_102071.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071033", "story_v_out_102071.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_102071", "102071033", "story_v_out_102071.awb")

						arg_124_1:RecordAudio("102071033", var_127_9)
						arg_124_1:RecordAudio("102071033", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_102071", "102071033", "story_v_out_102071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_102071", "102071033", "story_v_out_102071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play102071034 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 102071034
		arg_128_1.duration_ = 2.9

		local var_128_0 = {
			ja = 1.633,
			ko = 2.9,
			zh = 2.433,
			en = 1.966
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play102071035(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.3

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[20].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(102071034)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 11
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071034", "story_v_out_102071.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071034", "story_v_out_102071.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_102071", "102071034", "story_v_out_102071.awb")

						arg_128_1:RecordAudio("102071034", var_131_9)
						arg_128_1:RecordAudio("102071034", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_102071", "102071034", "story_v_out_102071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_102071", "102071034", "story_v_out_102071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play102071035 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 102071035
		arg_132_1.duration_ = 6.7

		local var_132_0 = {
			ja = 4.733,
			ko = 5.033,
			zh = 6.666,
			en = 6.7
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play102071036(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				local var_135_2 = "play"
				local var_135_3 = "effect"

				arg_132_1:AudioAction(var_135_2, var_135_3, "se_story", "se_story_loop_stop", "")
			end

			local var_135_4 = 0
			local var_135_5 = 0.5

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_6 = arg_132_1:FormatText(StoryNameCfg[6].name)

				arg_132_1.leftNameTxt_.text = var_135_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_7 = arg_132_1:GetWordFromCfg(102071035)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 20
				local var_135_10 = utf8.len(var_135_8)
				local var_135_11 = var_135_9 <= 0 and var_135_5 or var_135_5 * (var_135_10 / var_135_9)

				if var_135_11 > 0 and var_135_5 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071035", "story_v_out_102071.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_102071", "102071035", "story_v_out_102071.awb") / 1000

					if var_135_12 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_4
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_102071", "102071035", "story_v_out_102071.awb")

						arg_132_1:RecordAudio("102071035", var_135_13)
						arg_132_1:RecordAudio("102071035", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_102071", "102071035", "story_v_out_102071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_102071", "102071035", "story_v_out_102071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_14 and arg_132_1.time_ < var_135_4 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play102071036 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 102071036
		arg_136_1.duration_ = 3.57

		local var_136_0 = {
			ja = 3.566,
			ko = 2.966,
			zh = 2.366,
			en = 2.766
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play102071037(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.275

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[13].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(102071036)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 11
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071036", "story_v_out_102071.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_102071", "102071036", "story_v_out_102071.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_102071", "102071036", "story_v_out_102071.awb")

						arg_136_1:RecordAudio("102071036", var_139_9)
						arg_136_1:RecordAudio("102071036", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_102071", "102071036", "story_v_out_102071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_102071", "102071036", "story_v_out_102071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play102071037 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 102071037
		arg_140_1.duration_ = 5.9

		local var_140_0 = {
			ja = 5.9,
			ko = 3.233,
			zh = 4.166,
			en = 3.8
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play102071038(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				local var_143_2 = "play"
				local var_143_3 = "effect"

				arg_140_1:AudioAction(var_143_2, var_143_3, "se_story", "se_story_robot_short", "")
			end

			local var_143_4 = "2022_tpose"

			if arg_140_1.actors_[var_143_4] == nil then
				local var_143_5 = Asset.Load("Char/" .. "2022_tpose")

				if not isNil(var_143_5) then
					local var_143_6 = Object.Instantiate(Asset.Load("Char/" .. "2022_tpose"), arg_140_1.stage_.transform)

					var_143_6.name = var_143_4
					var_143_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_140_1.actors_[var_143_4] = var_143_6

					local var_143_7 = var_143_6:GetComponentInChildren(typeof(CharacterEffect))

					var_143_7.enabled = true

					local var_143_8 = GameObjectTools.GetOrAddComponent(var_143_6, typeof(DynamicBoneHelper))

					if var_143_8 then
						var_143_8:EnableDynamicBone(false)
					end

					arg_140_1:ShowWeapon(var_143_7.transform, false)

					arg_140_1.var_[var_143_4 .. "Animator"] = var_143_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_140_1.var_[var_143_4 .. "Animator"].applyRootMotion = true
					arg_140_1.var_[var_143_4 .. "LipSync"] = var_143_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_143_9 = arg_140_1.actors_["2022_tpose"]
			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 and not isNil(var_143_9) and arg_140_1.var_.characterEffect2022_tpose == nil then
				arg_140_1.var_.characterEffect2022_tpose = var_143_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_11 = 0.1

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_11 and not isNil(var_143_9) then
				local var_143_12 = (arg_140_1.time_ - var_143_10) / var_143_11

				if arg_140_1.var_.characterEffect2022_tpose and not isNil(var_143_9) then
					arg_140_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_10 + var_143_11 and arg_140_1.time_ < var_143_10 + var_143_11 + arg_143_0 and not isNil(var_143_9) and arg_140_1.var_.characterEffect2022_tpose then
				arg_140_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_143_13 = 0

			if var_143_13 < arg_140_1.time_ and arg_140_1.time_ <= var_143_13 + arg_143_0 then
				arg_140_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_143_14 = arg_140_1.actors_["2022_tpose"].transform
			local var_143_15 = 0

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1.var_.moveOldPos2022_tpose = var_143_14.localPosition

				local var_143_16 = GameObjectTools.GetOrAddComponent(var_143_14.gameObject, typeof(DynamicBoneHelper))

				if var_143_16 then
					var_143_16:EnableDynamicBone(false)
				end
			end

			local var_143_17 = 0.001

			if var_143_15 <= arg_140_1.time_ and arg_140_1.time_ < var_143_15 + var_143_17 then
				local var_143_18 = (arg_140_1.time_ - var_143_15) / var_143_17
				local var_143_19 = Vector3.New(-0.7, -0.55, -0.3)

				var_143_14.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos2022_tpose, var_143_19, var_143_18)

				local var_143_20 = manager.ui.mainCamera.transform.position - var_143_14.position

				var_143_14.forward = Vector3.New(var_143_20.x, var_143_20.y, var_143_20.z)

				local var_143_21 = var_143_14.localEulerAngles

				var_143_21.z = 0
				var_143_21.x = 0
				var_143_14.localEulerAngles = var_143_21
			end

			if arg_140_1.time_ >= var_143_15 + var_143_17 and arg_140_1.time_ < var_143_15 + var_143_17 + arg_143_0 then
				var_143_14.localPosition = Vector3.New(-0.7, -0.55, -0.3)

				local var_143_22 = manager.ui.mainCamera.transform.position - var_143_14.position

				var_143_14.forward = Vector3.New(var_143_22.x, var_143_22.y, var_143_22.z)

				local var_143_23 = var_143_14.localEulerAngles

				var_143_23.z = 0
				var_143_23.x = 0
				var_143_14.localEulerAngles = var_143_23

				local var_143_24 = GameObjectTools.GetOrAddComponent(var_143_14.gameObject, typeof(DynamicBoneHelper))

				if var_143_24 then
					var_143_24:EnableDynamicBone(true)
				end
			end

			local var_143_25 = 0
			local var_143_26 = 0.4

			if var_143_25 < arg_140_1.time_ and arg_140_1.time_ <= var_143_25 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_27 = arg_140_1:FormatText(StoryNameCfg[46].name)

				arg_140_1.leftNameTxt_.text = var_143_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_28 = arg_140_1:GetWordFromCfg(102071037)
				local var_143_29 = arg_140_1:FormatText(var_143_28.content)

				arg_140_1.text_.text = var_143_29

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_30 = 15
				local var_143_31 = utf8.len(var_143_29)
				local var_143_32 = var_143_30 <= 0 and var_143_26 or var_143_26 * (var_143_31 / var_143_30)

				if var_143_32 > 0 and var_143_26 < var_143_32 then
					arg_140_1.talkMaxDuration = var_143_32

					if var_143_32 + var_143_25 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_32 + var_143_25
					end
				end

				arg_140_1.text_.text = var_143_29
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071037", "story_v_out_102071.awb") ~= 0 then
					local var_143_33 = manager.audio:GetVoiceLength("story_v_out_102071", "102071037", "story_v_out_102071.awb") / 1000

					if var_143_33 + var_143_25 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_33 + var_143_25
					end

					if var_143_28.prefab_name ~= "" and arg_140_1.actors_[var_143_28.prefab_name] ~= nil then
						local var_143_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_28.prefab_name].transform, "story_v_out_102071", "102071037", "story_v_out_102071.awb")

						arg_140_1:RecordAudio("102071037", var_143_34)
						arg_140_1:RecordAudio("102071037", var_143_34)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_102071", "102071037", "story_v_out_102071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_102071", "102071037", "story_v_out_102071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_35 = math.max(var_143_26, arg_140_1.talkMaxDuration)

			if var_143_25 <= arg_140_1.time_ and arg_140_1.time_ < var_143_25 + var_143_35 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_25) / var_143_35

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_25 + var_143_35 and arg_140_1.time_ < var_143_25 + var_143_35 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play102071038 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 102071038
		arg_144_1.duration_ = 5.67

		local var_144_0 = {
			ja = 5.666,
			ko = 3.3,
			zh = 4.3,
			en = 4.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play102071039(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				local var_147_2 = "play"
				local var_147_3 = "effect"

				arg_144_1:AudioAction(var_147_2, var_147_3, "se_story", "se_story_robot_short", "")
			end

			local var_147_4 = "2021_tpose"

			if arg_144_1.actors_[var_147_4] == nil then
				local var_147_5 = Asset.Load("Char/" .. "2021_tpose")

				if not isNil(var_147_5) then
					local var_147_6 = Object.Instantiate(Asset.Load("Char/" .. "2021_tpose"), arg_144_1.stage_.transform)

					var_147_6.name = var_147_4
					var_147_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_144_1.actors_[var_147_4] = var_147_6

					local var_147_7 = var_147_6:GetComponentInChildren(typeof(CharacterEffect))

					var_147_7.enabled = true

					local var_147_8 = GameObjectTools.GetOrAddComponent(var_147_6, typeof(DynamicBoneHelper))

					if var_147_8 then
						var_147_8:EnableDynamicBone(false)
					end

					arg_144_1:ShowWeapon(var_147_7.transform, false)

					arg_144_1.var_[var_147_4 .. "Animator"] = var_147_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_144_1.var_[var_147_4 .. "Animator"].applyRootMotion = true
					arg_144_1.var_[var_147_4 .. "LipSync"] = var_147_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_147_9 = arg_144_1.actors_["2021_tpose"]
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect2021_tpose == nil then
				arg_144_1.var_.characterEffect2021_tpose = var_147_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_11 = 0.1

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 and not isNil(var_147_9) then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11

				if arg_144_1.var_.characterEffect2021_tpose and not isNil(var_147_9) then
					arg_144_1.var_.characterEffect2021_tpose.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect2021_tpose then
				arg_144_1.var_.characterEffect2021_tpose.fillFlat = false
			end

			local var_147_13 = arg_144_1.actors_["2021_tpose"].transform
			local var_147_14 = 0

			if var_147_14 < arg_144_1.time_ and arg_144_1.time_ <= var_147_14 + arg_147_0 then
				arg_144_1.var_.moveOldPos2021_tpose = var_147_13.localPosition

				local var_147_15 = GameObjectTools.GetOrAddComponent(var_147_13.gameObject, typeof(DynamicBoneHelper))

				if var_147_15 then
					var_147_15:EnableDynamicBone(false)
				end
			end

			local var_147_16 = 0.001

			if var_147_14 <= arg_144_1.time_ and arg_144_1.time_ < var_147_14 + var_147_16 then
				local var_147_17 = (arg_144_1.time_ - var_147_14) / var_147_16
				local var_147_18 = Vector3.New(1.92, -0.6, 0.2)

				var_147_13.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos2021_tpose, var_147_18, var_147_17)

				local var_147_19 = manager.ui.mainCamera.transform.position - var_147_13.position

				var_147_13.forward = Vector3.New(var_147_19.x, var_147_19.y, var_147_19.z)

				local var_147_20 = var_147_13.localEulerAngles

				var_147_20.z = 0
				var_147_20.x = 0
				var_147_13.localEulerAngles = var_147_20
			end

			if arg_144_1.time_ >= var_147_14 + var_147_16 and arg_144_1.time_ < var_147_14 + var_147_16 + arg_147_0 then
				var_147_13.localPosition = Vector3.New(1.92, -0.6, 0.2)

				local var_147_21 = manager.ui.mainCamera.transform.position - var_147_13.position

				var_147_13.forward = Vector3.New(var_147_21.x, var_147_21.y, var_147_21.z)

				local var_147_22 = var_147_13.localEulerAngles

				var_147_22.z = 0
				var_147_22.x = 0
				var_147_13.localEulerAngles = var_147_22

				local var_147_23 = GameObjectTools.GetOrAddComponent(var_147_13.gameObject, typeof(DynamicBoneHelper))

				if var_147_23 then
					var_147_23:EnableDynamicBone(true)
				end
			end

			local var_147_24 = 0

			if var_147_24 < arg_144_1.time_ and arg_144_1.time_ <= var_147_24 + arg_147_0 then
				arg_144_1:PlayTimeline("2021_tpose", "StoryTimeline/CharAction/story2021/story2021action/2021action1_1")
			end

			local var_147_25 = 0
			local var_147_26 = 0.4

			if var_147_25 < arg_144_1.time_ and arg_144_1.time_ <= var_147_25 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_27 = arg_144_1:FormatText(StoryNameCfg[46].name)

				arg_144_1.leftNameTxt_.text = var_147_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_28 = arg_144_1:GetWordFromCfg(102071038)
				local var_147_29 = arg_144_1:FormatText(var_147_28.content)

				arg_144_1.text_.text = var_147_29

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_30 = 15
				local var_147_31 = utf8.len(var_147_29)
				local var_147_32 = var_147_30 <= 0 and var_147_26 or var_147_26 * (var_147_31 / var_147_30)

				if var_147_32 > 0 and var_147_26 < var_147_32 then
					arg_144_1.talkMaxDuration = var_147_32

					if var_147_32 + var_147_25 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_32 + var_147_25
					end
				end

				arg_144_1.text_.text = var_147_29
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071038", "story_v_out_102071.awb") ~= 0 then
					local var_147_33 = manager.audio:GetVoiceLength("story_v_out_102071", "102071038", "story_v_out_102071.awb") / 1000

					if var_147_33 + var_147_25 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_33 + var_147_25
					end

					if var_147_28.prefab_name ~= "" and arg_144_1.actors_[var_147_28.prefab_name] ~= nil then
						local var_147_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_28.prefab_name].transform, "story_v_out_102071", "102071038", "story_v_out_102071.awb")

						arg_144_1:RecordAudio("102071038", var_147_34)
						arg_144_1:RecordAudio("102071038", var_147_34)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_102071", "102071038", "story_v_out_102071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_102071", "102071038", "story_v_out_102071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_35 = math.max(var_147_26, arg_144_1.talkMaxDuration)

			if var_147_25 <= arg_144_1.time_ and arg_144_1.time_ < var_147_25 + var_147_35 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_25) / var_147_35

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_25 + var_147_35 and arg_144_1.time_ < var_147_25 + var_147_35 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2021_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play102071039 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 102071039
		arg_148_1.duration_ = 3.4

		local var_148_0 = {
			ja = 3.4,
			ko = 2.233,
			zh = 3.1,
			en = 2.1
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
			arg_148_1.auto_ = false
		end

		function arg_148_1.playNext_(arg_150_0)
			arg_148_1.onStoryFinished_()
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["2022_tpose"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect2022_tpose == nil then
				arg_148_1.var_.characterEffect2022_tpose = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect2022_tpose and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_148_1.var_.characterEffect2022_tpose.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect2022_tpose then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_148_1.var_.characterEffect2022_tpose.fillRatio = var_151_5
			end

			local var_151_6 = arg_148_1.actors_["2021_tpose"]
			local var_151_7 = 0

			if var_151_7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 and not isNil(var_151_6) and arg_148_1.var_.characterEffect2021_tpose == nil then
				arg_148_1.var_.characterEffect2021_tpose = var_151_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_8 = 0.1

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_8 and not isNil(var_151_6) then
				local var_151_9 = (arg_148_1.time_ - var_151_7) / var_151_8

				if arg_148_1.var_.characterEffect2021_tpose and not isNil(var_151_6) then
					local var_151_10 = Mathf.Lerp(0, 0.5, var_151_9)

					arg_148_1.var_.characterEffect2021_tpose.fillFlat = true
					arg_148_1.var_.characterEffect2021_tpose.fillRatio = var_151_10
				end
			end

			if arg_148_1.time_ >= var_151_7 + var_151_8 and arg_148_1.time_ < var_151_7 + var_151_8 + arg_151_0 and not isNil(var_151_6) and arg_148_1.var_.characterEffect2021_tpose then
				local var_151_11 = 0.5

				arg_148_1.var_.characterEffect2021_tpose.fillFlat = true
				arg_148_1.var_.characterEffect2021_tpose.fillRatio = var_151_11
			end

			local var_151_12 = 0
			local var_151_13 = 0.325

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_14 = arg_148_1:FormatText(StoryNameCfg[47].name)

				arg_148_1.leftNameTxt_.text = var_151_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_15 = arg_148_1:GetWordFromCfg(102071039)
				local var_151_16 = arg_148_1:FormatText(var_151_15.content)

				arg_148_1.text_.text = var_151_16

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_17 = 12
				local var_151_18 = utf8.len(var_151_16)
				local var_151_19 = var_151_17 <= 0 and var_151_13 or var_151_13 * (var_151_18 / var_151_17)

				if var_151_19 > 0 and var_151_13 < var_151_19 then
					arg_148_1.talkMaxDuration = var_151_19

					if var_151_19 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_12
					end
				end

				arg_148_1.text_.text = var_151_16
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071039", "story_v_out_102071.awb") ~= 0 then
					local var_151_20 = manager.audio:GetVoiceLength("story_v_out_102071", "102071039", "story_v_out_102071.awb") / 1000

					if var_151_20 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_20 + var_151_12
					end

					if var_151_15.prefab_name ~= "" and arg_148_1.actors_[var_151_15.prefab_name] ~= nil then
						local var_151_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_15.prefab_name].transform, "story_v_out_102071", "102071039", "story_v_out_102071.awb")

						arg_148_1:RecordAudio("102071039", var_151_21)
						arg_148_1:RecordAudio("102071039", var_151_21)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_102071", "102071039", "story_v_out_102071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_102071", "102071039", "story_v_out_102071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_22 = math.max(var_151_13, arg_148_1.talkMaxDuration)

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_22 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_12) / var_151_22

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_12 + var_151_22 and arg_148_1.time_ < var_151_12 + var_151_22 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0202",
		"TextureConfig/Background/B02a"
	},
	voices = {
		"story_v_out_102071.awb"
	}
}
