return {
	Play418081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418081001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play418081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST1001a"

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
				local var_4_5 = arg_1_1.bgs_.ST1001a

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
					if iter_4_0 ~= "ST1001a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = arg_1_1.bgs_.ST1001a.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPosST1001a = var_4_24.localPosition
			end

			local var_4_26 = 0.0666666666666667

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Vector3.New(0, 1, 10)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST1001a, var_4_28, var_4_27)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_29 = arg_1_1.bgs_.ST1001a.transform
			local var_4_30 = 0.0666666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPosST1001a = var_4_29.localPosition
			end

			local var_4_31 = 1.9

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, 1, 9)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST1001a, var_4_33, var_4_32)
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 1, 9)
			end

			local var_4_34 = manager.ui.mainCamera.transform
			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_36 = arg_1_1.var_.effect111
				local var_4_37
				local var_4_38 = var_4_34

				if not var_4_36 then
					var_4_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax"), var_4_38)
					var_4_36.name = "111"
					arg_1_1.var_.effect111 = var_4_36
				else
					var_4_36.transform:SetParent(var_4_38)
				end

				var_4_36.transform.localPosition = Vector3.New(0, -0.58, 0)
				var_4_36.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_39 = manager.ui.mainCameraCom_
				local var_4_40 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_4_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_41 = var_4_36.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_4_42 = 15
				local var_4_43 = 2 * var_4_42 * Mathf.Tan(var_4_39.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_4_39.aspect
				local var_4_44 = 1
				local var_4_45 = 1.7777777777777777

				if var_4_45 < var_4_39.aspect then
					var_4_44 = var_4_43 / (2 * var_4_42 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_4_45)
				end

				for iter_4_2, iter_4_3 in ipairs(var_4_41) do
					local var_4_46 = iter_4_3.transform.localScale

					iter_4_3.transform.localScale = Vector3.New(var_4_46.x / var_4_40 * var_4_44, var_4_46.y / var_4_40, var_4_46.z)
				end
			end

			local var_4_47 = 0.05
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "effect"

				arg_1_1:AudioAction(var_4_49, var_4_50, "se_story_140", "se_story_140_amb_storm02", "")
			end

			local var_4_51 = 0.4
			local var_4_52 = 1

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "music"

				arg_1_1:AudioAction(var_4_53, var_4_54, "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_55 = ""
				local var_4_56 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if var_4_56 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_56 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_56

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_56
						arg_1_1.bgmTxt2_.text = var_4_56
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

			local var_4_57 = 1.8
			local var_4_58 = 0.975

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(418081001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 39
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_58 or var_4_58 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_58 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_57 = var_4_57 + 0.3

					if var_4_64 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_57 + 0.3
			local var_4_66 = math.max(var_4_58, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST1001a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST1001a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.9,
				className = "StoryMoveNode",
				startTime = 0.0666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play418081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418081002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play418081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.05
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_1311", "se_story_1311_thunder03", "")
			end

			local var_11_4 = 0
			local var_11_5 = 0.925

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(418081002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 37
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play418081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418081003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play418081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.475

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

				local var_15_2 = arg_12_1:GetWordFromCfg(418081003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 19
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
	Play418081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418081004
		arg_16_1.duration_ = 2.4

		local var_16_0 = {
			ja = 2.4,
			CriLanguages = 2.1,
			zh = 2.1
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "107301"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "107301")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(var_19_1, arg_16_1.canvasGo_.transform)

					var_19_2.transform:SetSiblingIndex(1)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_16_1.isInRecall_ then
						for iter_19_0, iter_19_1 in ipairs(var_19_3) do
							iter_19_1.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_19_4 = arg_16_1.actors_["107301"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.actorSpriteComps107301 == nil then
				arg_16_1.var_.actorSpriteComps107301 = var_19_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_6 = 0.2

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.actorSpriteComps107301 then
					for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_19_3 then
							if arg_16_1.isInRecall_ then
								local var_19_8 = Mathf.Lerp(iter_19_3.color.r, arg_16_1.hightColor1.r, var_19_7)
								local var_19_9 = Mathf.Lerp(iter_19_3.color.g, arg_16_1.hightColor1.g, var_19_7)
								local var_19_10 = Mathf.Lerp(iter_19_3.color.b, arg_16_1.hightColor1.b, var_19_7)

								iter_19_3.color = Color.New(var_19_8, var_19_9, var_19_10)
							else
								local var_19_11 = Mathf.Lerp(iter_19_3.color.r, 1, var_19_7)

								iter_19_3.color = Color.New(var_19_11, var_19_11, var_19_11)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.actorSpriteComps107301 then
				for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_19_5 then
						if arg_16_1.isInRecall_ then
							iter_19_5.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps107301 = nil
			end

			local var_19_12 = arg_16_1.actors_["107301"].transform
			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1.var_.moveOldPos107301 = var_19_12.localPosition
				var_19_12.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("107301", 2)

				local var_19_14 = var_19_12.childCount

				for iter_19_6 = 0, var_19_14 - 1 do
					local var_19_15 = var_19_12:GetChild(iter_19_6)

					if var_19_15.name == "split_1" or not string.find(var_19_15.name, "split") then
						var_19_15.gameObject:SetActive(true)
					else
						var_19_15.gameObject:SetActive(false)
					end
				end
			end

			local var_19_16 = 0.001

			if var_19_13 <= arg_16_1.time_ and arg_16_1.time_ < var_19_13 + var_19_16 then
				local var_19_17 = (arg_16_1.time_ - var_19_13) / var_19_16
				local var_19_18 = Vector3.New(-527.7, -367.6, -206)

				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos107301, var_19_18, var_19_17)
			end

			if arg_16_1.time_ >= var_19_13 + var_19_16 and arg_16_1.time_ < var_19_13 + var_19_16 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_19_19 = 0
			local var_19_20 = 0.25

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_21 = arg_16_1:FormatText(StoryNameCfg[380].name)

				arg_16_1.leftNameTxt_.text = var_19_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_22 = arg_16_1:GetWordFromCfg(418081004)
				local var_19_23 = arg_16_1:FormatText(var_19_22.content)

				arg_16_1.text_.text = var_19_23

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_24 = 10
				local var_19_25 = utf8.len(var_19_23)
				local var_19_26 = var_19_24 <= 0 and var_19_20 or var_19_20 * (var_19_25 / var_19_24)

				if var_19_26 > 0 and var_19_20 < var_19_26 then
					arg_16_1.talkMaxDuration = var_19_26

					if var_19_26 + var_19_19 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_26 + var_19_19
					end
				end

				arg_16_1.text_.text = var_19_23
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081004", "story_v_side_old_418081.awb") ~= 0 then
					local var_19_27 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081004", "story_v_side_old_418081.awb") / 1000

					if var_19_27 + var_19_19 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_19
					end

					if var_19_22.prefab_name ~= "" and arg_16_1.actors_[var_19_22.prefab_name] ~= nil then
						local var_19_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_22.prefab_name].transform, "story_v_side_old_418081", "418081004", "story_v_side_old_418081.awb")

						arg_16_1:RecordAudio("418081004", var_19_28)
						arg_16_1:RecordAudio("418081004", var_19_28)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081004", "story_v_side_old_418081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081004", "story_v_side_old_418081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_29 = math.max(var_19_20, arg_16_1.talkMaxDuration)

			if var_19_19 <= arg_16_1.time_ and arg_16_1.time_ < var_19_19 + var_19_29 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_19) / var_19_29

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_19 + var_19_29 and arg_16_1.time_ < var_19_19 + var_19_29 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play418081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418081005
		arg_20_1.duration_ = 6.6

		local var_20_0 = {
			ja = 6.6,
			CriLanguages = 6.366,
			zh = 6.366
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
				arg_20_0:Play418081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "10135"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(var_23_1, arg_20_1.canvasGo_.transform)

					var_23_2.transform:SetSiblingIndex(1)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs(var_23_3) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_4 = arg_20_1.actors_["10135"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_23_3 then
							if arg_20_1.isInRecall_ then
								local var_23_8 = Mathf.Lerp(iter_23_3.color.r, arg_20_1.hightColor1.r, var_23_7)
								local var_23_9 = Mathf.Lerp(iter_23_3.color.g, arg_20_1.hightColor1.g, var_23_7)
								local var_23_10 = Mathf.Lerp(iter_23_3.color.b, arg_20_1.hightColor1.b, var_23_7)

								iter_23_3.color = Color.New(var_23_8, var_23_9, var_23_10)
							else
								local var_23_11 = Mathf.Lerp(iter_23_3.color.r, 1, var_23_7)

								iter_23_3.color = Color.New(var_23_11, var_23_11, var_23_11)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_5 then
						if arg_20_1.isInRecall_ then
							iter_23_5.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_12 = arg_20_1.actors_["107301"]
			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 and not isNil(var_23_12) and arg_20_1.var_.actorSpriteComps107301 == nil then
				arg_20_1.var_.actorSpriteComps107301 = var_23_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_14 = 0.2

			if var_23_13 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_14 and not isNil(var_23_12) then
				local var_23_15 = (arg_20_1.time_ - var_23_13) / var_23_14

				if arg_20_1.var_.actorSpriteComps107301 then
					for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_23_7 then
							if arg_20_1.isInRecall_ then
								local var_23_16 = Mathf.Lerp(iter_23_7.color.r, arg_20_1.hightColor2.r, var_23_15)
								local var_23_17 = Mathf.Lerp(iter_23_7.color.g, arg_20_1.hightColor2.g, var_23_15)
								local var_23_18 = Mathf.Lerp(iter_23_7.color.b, arg_20_1.hightColor2.b, var_23_15)

								iter_23_7.color = Color.New(var_23_16, var_23_17, var_23_18)
							else
								local var_23_19 = Mathf.Lerp(iter_23_7.color.r, 0.5, var_23_15)

								iter_23_7.color = Color.New(var_23_19, var_23_19, var_23_19)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_13 + var_23_14 and arg_20_1.time_ < var_23_13 + var_23_14 + arg_23_0 and not isNil(var_23_12) and arg_20_1.var_.actorSpriteComps107301 then
				for iter_23_8, iter_23_9 in pairs(arg_20_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_23_9 then
						if arg_20_1.isInRecall_ then
							iter_23_9.color = arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_23_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps107301 = nil
			end

			local var_23_20 = arg_20_1.actors_["10135"].transform
			local var_23_21 = 0

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.var_.moveOldPos10135 = var_23_20.localPosition
				var_23_20.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10135", 4)

				local var_23_22 = var_23_20.childCount

				for iter_23_10 = 0, var_23_22 - 1 do
					local var_23_23 = var_23_20:GetChild(iter_23_10)

					if var_23_23.name == "" or not string.find(var_23_23.name, "split") then
						var_23_23.gameObject:SetActive(true)
					else
						var_23_23.gameObject:SetActive(false)
					end
				end
			end

			local var_23_24 = 0.001

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_24 then
				local var_23_25 = (arg_20_1.time_ - var_23_21) / var_23_24
				local var_23_26 = Vector3.New(432.72, -363.6, -305.9)

				var_23_20.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10135, var_23_26, var_23_25)
			end

			if arg_20_1.time_ >= var_23_21 + var_23_24 and arg_20_1.time_ < var_23_21 + var_23_24 + arg_23_0 then
				var_23_20.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_23_27 = 0
			local var_23_28 = 0.7

			if var_23_27 < arg_20_1.time_ and arg_20_1.time_ <= var_23_27 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_29 = arg_20_1:FormatText(StoryNameCfg[1187].name)

				arg_20_1.leftNameTxt_.text = var_23_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_30 = arg_20_1:GetWordFromCfg(418081005)
				local var_23_31 = arg_20_1:FormatText(var_23_30.content)

				arg_20_1.text_.text = var_23_31

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_32 = 28
				local var_23_33 = utf8.len(var_23_31)
				local var_23_34 = var_23_32 <= 0 and var_23_28 or var_23_28 * (var_23_33 / var_23_32)

				if var_23_34 > 0 and var_23_28 < var_23_34 then
					arg_20_1.talkMaxDuration = var_23_34

					if var_23_34 + var_23_27 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_34 + var_23_27
					end
				end

				arg_20_1.text_.text = var_23_31
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081005", "story_v_side_old_418081.awb") ~= 0 then
					local var_23_35 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081005", "story_v_side_old_418081.awb") / 1000

					if var_23_35 + var_23_27 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_35 + var_23_27
					end

					if var_23_30.prefab_name ~= "" and arg_20_1.actors_[var_23_30.prefab_name] ~= nil then
						local var_23_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_30.prefab_name].transform, "story_v_side_old_418081", "418081005", "story_v_side_old_418081.awb")

						arg_20_1:RecordAudio("418081005", var_23_36)
						arg_20_1:RecordAudio("418081005", var_23_36)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081005", "story_v_side_old_418081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081005", "story_v_side_old_418081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_37 = math.max(var_23_28, arg_20_1.talkMaxDuration)

			if var_23_27 <= arg_20_1.time_ and arg_20_1.time_ < var_23_27 + var_23_37 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_27) / var_23_37

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_27 + var_23_37 and arg_20_1.time_ < var_23_27 + var_23_37 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play418081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418081006
		arg_24_1.duration_ = 2.27

		local var_24_0 = {
			ja = 2.266,
			CriLanguages = 1.233,
			zh = 1.233
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
				arg_24_0:Play418081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["107301"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps107301 == nil then
				arg_24_1.var_.actorSpriteComps107301 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps107301 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor1.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor1.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor1.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 1, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps107301 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps107301 = nil
			end

			local var_27_8 = arg_24_1.actors_["10135"]
			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.actorSpriteComps10135 == nil then
				arg_24_1.var_.actorSpriteComps10135 = var_27_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_10 = 0.2

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_10 and not isNil(var_27_8) then
				local var_27_11 = (arg_24_1.time_ - var_27_9) / var_27_10

				if arg_24_1.var_.actorSpriteComps10135 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_27_5 then
							if arg_24_1.isInRecall_ then
								local var_27_12 = Mathf.Lerp(iter_27_5.color.r, arg_24_1.hightColor2.r, var_27_11)
								local var_27_13 = Mathf.Lerp(iter_27_5.color.g, arg_24_1.hightColor2.g, var_27_11)
								local var_27_14 = Mathf.Lerp(iter_27_5.color.b, arg_24_1.hightColor2.b, var_27_11)

								iter_27_5.color = Color.New(var_27_12, var_27_13, var_27_14)
							else
								local var_27_15 = Mathf.Lerp(iter_27_5.color.r, 0.5, var_27_11)

								iter_27_5.color = Color.New(var_27_15, var_27_15, var_27_15)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_9 + var_27_10 and arg_24_1.time_ < var_27_9 + var_27_10 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.actorSpriteComps10135 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_27_7 then
						if arg_24_1.isInRecall_ then
							iter_27_7.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10135 = nil
			end

			local var_27_16 = 0
			local var_27_17 = 0.125

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_18 = arg_24_1:FormatText(StoryNameCfg[380].name)

				arg_24_1.leftNameTxt_.text = var_27_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_19 = arg_24_1:GetWordFromCfg(418081006)
				local var_27_20 = arg_24_1:FormatText(var_27_19.content)

				arg_24_1.text_.text = var_27_20

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_21 = 5
				local var_27_22 = utf8.len(var_27_20)
				local var_27_23 = var_27_21 <= 0 and var_27_17 or var_27_17 * (var_27_22 / var_27_21)

				if var_27_23 > 0 and var_27_17 < var_27_23 then
					arg_24_1.talkMaxDuration = var_27_23

					if var_27_23 + var_27_16 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_23 + var_27_16
					end
				end

				arg_24_1.text_.text = var_27_20
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081006", "story_v_side_old_418081.awb") ~= 0 then
					local var_27_24 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081006", "story_v_side_old_418081.awb") / 1000

					if var_27_24 + var_27_16 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_24 + var_27_16
					end

					if var_27_19.prefab_name ~= "" and arg_24_1.actors_[var_27_19.prefab_name] ~= nil then
						local var_27_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_19.prefab_name].transform, "story_v_side_old_418081", "418081006", "story_v_side_old_418081.awb")

						arg_24_1:RecordAudio("418081006", var_27_25)
						arg_24_1:RecordAudio("418081006", var_27_25)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081006", "story_v_side_old_418081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081006", "story_v_side_old_418081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_26 = math.max(var_27_17, arg_24_1.talkMaxDuration)

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_26 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_16) / var_27_26

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_16 + var_27_26 and arg_24_1.time_ < var_27_16 + var_27_26 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play418081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418081007
		arg_28_1.duration_ = 5.67

		local var_28_0 = {
			ja = 5.666,
			CriLanguages = 4.833,
			zh = 4.833
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
				arg_28_0:Play418081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.65

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[380].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(418081007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 26
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081007", "story_v_side_old_418081.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081007", "story_v_side_old_418081.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_side_old_418081", "418081007", "story_v_side_old_418081.awb")

						arg_28_1:RecordAudio("418081007", var_31_9)
						arg_28_1:RecordAudio("418081007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081007", "story_v_side_old_418081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081007", "story_v_side_old_418081.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play418081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418081008
		arg_32_1.duration_ = 7.83

		local var_32_0 = {
			ja = 7.833,
			CriLanguages = 5.366,
			zh = 5.366
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
				arg_32_0:Play418081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10135"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10135 == nil then
				arg_32_1.var_.actorSpriteComps10135 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10135 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 1, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10135 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10135 = nil
			end

			local var_35_8 = arg_32_1.actors_["107301"]
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps107301 == nil then
				arg_32_1.var_.actorSpriteComps107301 = var_35_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.actorSpriteComps107301 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								local var_35_12 = Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor2.r, var_35_11)
								local var_35_13 = Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor2.g, var_35_11)
								local var_35_14 = Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor2.b, var_35_11)

								iter_35_5.color = Color.New(var_35_12, var_35_13, var_35_14)
							else
								local var_35_15 = Mathf.Lerp(iter_35_5.color.r, 0.5, var_35_11)

								iter_35_5.color = Color.New(var_35_15, var_35_15, var_35_15)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps107301 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_35_7 then
						if arg_32_1.isInRecall_ then
							iter_35_7.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps107301 = nil
			end

			local var_35_16 = arg_32_1.actors_["10135"].transform
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.var_.moveOldPos10135 = var_35_16.localPosition
				var_35_16.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10135", 4)

				local var_35_18 = var_35_16.childCount

				for iter_35_8 = 0, var_35_18 - 1 do
					local var_35_19 = var_35_16:GetChild(iter_35_8)

					if var_35_19.name == "split_6" or not string.find(var_35_19.name, "split") then
						var_35_19.gameObject:SetActive(true)
					else
						var_35_19.gameObject:SetActive(false)
					end
				end
			end

			local var_35_20 = 0.001

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_20 then
				local var_35_21 = (arg_32_1.time_ - var_35_17) / var_35_20
				local var_35_22 = Vector3.New(432.72, -363.6, -305.9)

				var_35_16.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10135, var_35_22, var_35_21)
			end

			if arg_32_1.time_ >= var_35_17 + var_35_20 and arg_32_1.time_ < var_35_17 + var_35_20 + arg_35_0 then
				var_35_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_35_23 = 0
			local var_35_24 = 0.725

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_25 = arg_32_1:FormatText(StoryNameCfg[1187].name)

				arg_32_1.leftNameTxt_.text = var_35_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_26 = arg_32_1:GetWordFromCfg(418081008)
				local var_35_27 = arg_32_1:FormatText(var_35_26.content)

				arg_32_1.text_.text = var_35_27

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_28 = 29
				local var_35_29 = utf8.len(var_35_27)
				local var_35_30 = var_35_28 <= 0 and var_35_24 or var_35_24 * (var_35_29 / var_35_28)

				if var_35_30 > 0 and var_35_24 < var_35_30 then
					arg_32_1.talkMaxDuration = var_35_30

					if var_35_30 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_30 + var_35_23
					end
				end

				arg_32_1.text_.text = var_35_27
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081008", "story_v_side_old_418081.awb") ~= 0 then
					local var_35_31 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081008", "story_v_side_old_418081.awb") / 1000

					if var_35_31 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_31 + var_35_23
					end

					if var_35_26.prefab_name ~= "" and arg_32_1.actors_[var_35_26.prefab_name] ~= nil then
						local var_35_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_26.prefab_name].transform, "story_v_side_old_418081", "418081008", "story_v_side_old_418081.awb")

						arg_32_1:RecordAudio("418081008", var_35_32)
						arg_32_1:RecordAudio("418081008", var_35_32)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081008", "story_v_side_old_418081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081008", "story_v_side_old_418081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_33 = math.max(var_35_24, arg_32_1.talkMaxDuration)

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_33 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_23) / var_35_33

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_23 + var_35_33 and arg_32_1.time_ < var_35_23 + var_35_33 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play418081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418081009
		arg_36_1.duration_ = 12.27

		local var_36_0 = {
			ja = 12.266,
			CriLanguages = 9.266,
			zh = 9.266
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play418081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["107301"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps107301 == nil then
				arg_36_1.var_.actorSpriteComps107301 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps107301 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								local var_39_4 = Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, var_39_3)
								local var_39_5 = Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, var_39_3)
								local var_39_6 = Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, var_39_3)

								iter_39_1.color = Color.New(var_39_4, var_39_5, var_39_6)
							else
								local var_39_7 = Mathf.Lerp(iter_39_1.color.r, 1, var_39_3)

								iter_39_1.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps107301 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps107301 = nil
			end

			local var_39_8 = arg_36_1.actors_["10135"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10135 == nil then
				arg_36_1.var_.actorSpriteComps10135 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps10135 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								local var_39_12 = Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, var_39_11)
								local var_39_13 = Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, var_39_11)
								local var_39_14 = Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, var_39_11)

								iter_39_5.color = Color.New(var_39_12, var_39_13, var_39_14)
							else
								local var_39_15 = Mathf.Lerp(iter_39_5.color.r, 0.5, var_39_11)

								iter_39_5.color = Color.New(var_39_15, var_39_15, var_39_15)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10135 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10135 = nil
			end

			local var_39_16 = arg_36_1.actors_["107301"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos107301 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("107301", 2)

				local var_39_18 = var_39_16.childCount

				for iter_39_8 = 0, var_39_18 - 1 do
					local var_39_19 = var_39_16:GetChild(iter_39_8)

					if var_39_19.name == "split_4" or not string.find(var_39_19.name, "split") then
						var_39_19.gameObject:SetActive(true)
					else
						var_39_19.gameObject:SetActive(false)
					end
				end
			end

			local var_39_20 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_17) / var_39_20
				local var_39_22 = Vector3.New(-527.7, -367.6, -206)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos107301, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_39_23 = 0
			local var_39_24 = 1.05

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_25 = arg_36_1:FormatText(StoryNameCfg[380].name)

				arg_36_1.leftNameTxt_.text = var_39_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(418081009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 42
				local var_39_29 = utf8.len(var_39_27)
				local var_39_30 = var_39_28 <= 0 and var_39_24 or var_39_24 * (var_39_29 / var_39_28)

				if var_39_30 > 0 and var_39_24 < var_39_30 then
					arg_36_1.talkMaxDuration = var_39_30

					if var_39_30 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_23
					end
				end

				arg_36_1.text_.text = var_39_27
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081009", "story_v_side_old_418081.awb") ~= 0 then
					local var_39_31 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081009", "story_v_side_old_418081.awb") / 1000

					if var_39_31 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_31 + var_39_23
					end

					if var_39_26.prefab_name ~= "" and arg_36_1.actors_[var_39_26.prefab_name] ~= nil then
						local var_39_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_26.prefab_name].transform, "story_v_side_old_418081", "418081009", "story_v_side_old_418081.awb")

						arg_36_1:RecordAudio("418081009", var_39_32)
						arg_36_1:RecordAudio("418081009", var_39_32)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081009", "story_v_side_old_418081.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081009", "story_v_side_old_418081.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_33 = math.max(var_39_24, arg_36_1.talkMaxDuration)

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_33 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_23) / var_39_33

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_23 + var_39_33 and arg_36_1.time_ < var_39_23 + var_39_33 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play418081010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418081010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play418081011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["107301"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps107301 == nil then
				arg_40_1.var_.actorSpriteComps107301 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps107301 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor2.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor2.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor2.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 0.5, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps107301 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps107301 = nil
			end

			local var_43_8 = arg_40_1.actors_["10135"].transform
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.var_.moveOldPos10135 = var_43_8.localPosition
				var_43_8.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10135", 7)

				local var_43_10 = var_43_8.childCount

				for iter_43_4 = 0, var_43_10 - 1 do
					local var_43_11 = var_43_8:GetChild(iter_43_4)

					if var_43_11.name == "" or not string.find(var_43_11.name, "split") then
						var_43_11.gameObject:SetActive(true)
					else
						var_43_11.gameObject:SetActive(false)
					end
				end
			end

			local var_43_12 = 0.001

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_9) / var_43_12
				local var_43_14 = Vector3.New(0, -2000, 0)

				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10135, var_43_14, var_43_13)
			end

			if arg_40_1.time_ >= var_43_9 + var_43_12 and arg_40_1.time_ < var_43_9 + var_43_12 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_15 = arg_40_1.actors_["107301"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos107301 = var_43_15.localPosition
				var_43_15.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("107301", 7)

				local var_43_17 = var_43_15.childCount

				for iter_43_5 = 0, var_43_17 - 1 do
					local var_43_18 = var_43_15:GetChild(iter_43_5)

					if var_43_18.name == "" or not string.find(var_43_18.name, "split") then
						var_43_18.gameObject:SetActive(true)
					else
						var_43_18.gameObject:SetActive(false)
					end
				end
			end

			local var_43_19 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_19 then
				local var_43_20 = (arg_40_1.time_ - var_43_16) / var_43_19
				local var_43_21 = Vector3.New(0, -2000, 0)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos107301, var_43_21, var_43_20)
			end

			if arg_40_1.time_ >= var_43_16 + var_43_19 and arg_40_1.time_ < var_43_16 + var_43_19 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_22 = 0
			local var_43_23 = 0.875

			if var_43_22 < arg_40_1.time_ and arg_40_1.time_ <= var_43_22 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_24 = arg_40_1:GetWordFromCfg(418081010)
				local var_43_25 = arg_40_1:FormatText(var_43_24.content)

				arg_40_1.text_.text = var_43_25

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_26 = 35
				local var_43_27 = utf8.len(var_43_25)
				local var_43_28 = var_43_26 <= 0 and var_43_23 or var_43_23 * (var_43_27 / var_43_26)

				if var_43_28 > 0 and var_43_23 < var_43_28 then
					arg_40_1.talkMaxDuration = var_43_28

					if var_43_28 + var_43_22 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_22
					end
				end

				arg_40_1.text_.text = var_43_25
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_29 = math.max(var_43_23, arg_40_1.talkMaxDuration)

			if var_43_22 <= arg_40_1.time_ and arg_40_1.time_ < var_43_22 + var_43_29 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_22) / var_43_29

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_22 + var_43_29 and arg_40_1.time_ < var_43_22 + var_43_29 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play418081011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418081011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play418081012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.45

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(418081011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 18
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play418081012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418081012
		arg_48_1.duration_ = 2.93

		local var_48_0 = {
			ja = 2.833,
			CriLanguages = 2.933,
			zh = 2.933
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play418081013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10135"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10135 == nil then
				arg_48_1.var_.actorSpriteComps10135 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps10135 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 1, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10135 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps10135 = nil
			end

			local var_51_8 = arg_48_1.actors_["10135"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos10135 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10135", 3)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "split_5" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10135, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_51_15 = 0
			local var_51_16 = 0.1

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[1187].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(418081012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 4
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081012", "story_v_side_old_418081.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081012", "story_v_side_old_418081.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_side_old_418081", "418081012", "story_v_side_old_418081.awb")

						arg_48_1:RecordAudio("418081012", var_51_24)
						arg_48_1:RecordAudio("418081012", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081012", "story_v_side_old_418081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081012", "story_v_side_old_418081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play418081013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418081013
		arg_52_1.duration_ = 3.33

		local var_52_0 = {
			ja = 3.333,
			CriLanguages = 3,
			zh = 3
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play418081014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.25

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1187].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(418081013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 10
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081013", "story_v_side_old_418081.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081013", "story_v_side_old_418081.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_side_old_418081", "418081013", "story_v_side_old_418081.awb")

						arg_52_1:RecordAudio("418081013", var_55_9)
						arg_52_1:RecordAudio("418081013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081013", "story_v_side_old_418081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081013", "story_v_side_old_418081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play418081014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418081014
		arg_56_1.duration_ = 3.37

		local var_56_0 = {
			ja = 3.366,
			CriLanguages = 2.4,
			zh = 2.4
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play418081015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["107301"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps107301 == nil then
				arg_56_1.var_.actorSpriteComps107301 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps107301 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 1, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps107301 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps107301 = nil
			end

			local var_59_8 = arg_56_1.actors_["10135"]
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps10135 == nil then
				arg_56_1.var_.actorSpriteComps10135 = var_59_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_10 = 0.2

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_10 and not isNil(var_59_8) then
				local var_59_11 = (arg_56_1.time_ - var_59_9) / var_59_10

				if arg_56_1.var_.actorSpriteComps10135 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								local var_59_12 = Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor2.r, var_59_11)
								local var_59_13 = Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor2.g, var_59_11)
								local var_59_14 = Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor2.b, var_59_11)

								iter_59_5.color = Color.New(var_59_12, var_59_13, var_59_14)
							else
								local var_59_15 = Mathf.Lerp(iter_59_5.color.r, 0.5, var_59_11)

								iter_59_5.color = Color.New(var_59_15, var_59_15, var_59_15)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps10135 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_59_7 then
						if arg_56_1.isInRecall_ then
							iter_59_7.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10135 = nil
			end

			local var_59_16 = arg_56_1.actors_["107301"].transform
			local var_59_17 = 0

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.var_.moveOldPos107301 = var_59_16.localPosition
				var_59_16.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("107301", 2)

				local var_59_18 = var_59_16.childCount

				for iter_59_8 = 0, var_59_18 - 1 do
					local var_59_19 = var_59_16:GetChild(iter_59_8)

					if var_59_19.name == "split_4" or not string.find(var_59_19.name, "split") then
						var_59_19.gameObject:SetActive(true)
					else
						var_59_19.gameObject:SetActive(false)
					end
				end
			end

			local var_59_20 = 0.001

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_20 then
				local var_59_21 = (arg_56_1.time_ - var_59_17) / var_59_20
				local var_59_22 = Vector3.New(-527.7, -367.6, -206)

				var_59_16.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos107301, var_59_22, var_59_21)
			end

			if arg_56_1.time_ >= var_59_17 + var_59_20 and arg_56_1.time_ < var_59_17 + var_59_20 + arg_59_0 then
				var_59_16.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_59_23 = arg_56_1.actors_["10135"].transform
			local var_59_24 = 0

			if var_59_24 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 then
				arg_56_1.var_.moveOldPos10135 = var_59_23.localPosition
				var_59_23.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10135", 4)

				local var_59_25 = var_59_23.childCount

				for iter_59_9 = 0, var_59_25 - 1 do
					local var_59_26 = var_59_23:GetChild(iter_59_9)

					if var_59_26.name == "split_5" or not string.find(var_59_26.name, "split") then
						var_59_26.gameObject:SetActive(true)
					else
						var_59_26.gameObject:SetActive(false)
					end
				end
			end

			local var_59_27 = 0.001

			if var_59_24 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_27 then
				local var_59_28 = (arg_56_1.time_ - var_59_24) / var_59_27
				local var_59_29 = Vector3.New(432.72, -363.6, -305.9)

				var_59_23.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10135, var_59_29, var_59_28)
			end

			if arg_56_1.time_ >= var_59_24 + var_59_27 and arg_56_1.time_ < var_59_24 + var_59_27 + arg_59_0 then
				var_59_23.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_59_30 = 0
			local var_59_31 = 0.225

			if var_59_30 < arg_56_1.time_ and arg_56_1.time_ <= var_59_30 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_32 = arg_56_1:FormatText(StoryNameCfg[380].name)

				arg_56_1.leftNameTxt_.text = var_59_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_33 = arg_56_1:GetWordFromCfg(418081014)
				local var_59_34 = arg_56_1:FormatText(var_59_33.content)

				arg_56_1.text_.text = var_59_34

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_35 = 9
				local var_59_36 = utf8.len(var_59_34)
				local var_59_37 = var_59_35 <= 0 and var_59_31 or var_59_31 * (var_59_36 / var_59_35)

				if var_59_37 > 0 and var_59_31 < var_59_37 then
					arg_56_1.talkMaxDuration = var_59_37

					if var_59_37 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_37 + var_59_30
					end
				end

				arg_56_1.text_.text = var_59_34
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081014", "story_v_side_old_418081.awb") ~= 0 then
					local var_59_38 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081014", "story_v_side_old_418081.awb") / 1000

					if var_59_38 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_38 + var_59_30
					end

					if var_59_33.prefab_name ~= "" and arg_56_1.actors_[var_59_33.prefab_name] ~= nil then
						local var_59_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_33.prefab_name].transform, "story_v_side_old_418081", "418081014", "story_v_side_old_418081.awb")

						arg_56_1:RecordAudio("418081014", var_59_39)
						arg_56_1:RecordAudio("418081014", var_59_39)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081014", "story_v_side_old_418081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081014", "story_v_side_old_418081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_40 = math.max(var_59_31, arg_56_1.talkMaxDuration)

			if var_59_30 <= arg_56_1.time_ and arg_56_1.time_ < var_59_30 + var_59_40 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_30) / var_59_40

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_30 + var_59_40 and arg_56_1.time_ < var_59_30 + var_59_40 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play418081015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418081015
		arg_60_1.duration_ = 6.83

		local var_60_0 = {
			ja = 6.833,
			CriLanguages = 5.633,
			zh = 5.633
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play418081016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10135"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps10135 == nil then
				arg_60_1.var_.actorSpriteComps10135 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps10135 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 1, var_63_3)

								iter_63_1.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps10135 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10135 = nil
			end

			local var_63_8 = arg_60_1.actors_["107301"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps107301 == nil then
				arg_60_1.var_.actorSpriteComps107301 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 0.2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps107301 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								local var_63_12 = Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, var_63_11)
								local var_63_13 = Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, var_63_11)
								local var_63_14 = Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, var_63_11)

								iter_63_5.color = Color.New(var_63_12, var_63_13, var_63_14)
							else
								local var_63_15 = Mathf.Lerp(iter_63_5.color.r, 0.5, var_63_11)

								iter_63_5.color = Color.New(var_63_15, var_63_15, var_63_15)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps107301 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps107301 = nil
			end

			local var_63_16 = 0
			local var_63_17 = 0.6

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_18 = arg_60_1:FormatText(StoryNameCfg[1187].name)

				arg_60_1.leftNameTxt_.text = var_63_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_19 = arg_60_1:GetWordFromCfg(418081015)
				local var_63_20 = arg_60_1:FormatText(var_63_19.content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 24
				local var_63_22 = utf8.len(var_63_20)
				local var_63_23 = var_63_21 <= 0 and var_63_17 or var_63_17 * (var_63_22 / var_63_21)

				if var_63_23 > 0 and var_63_17 < var_63_23 then
					arg_60_1.talkMaxDuration = var_63_23

					if var_63_23 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081015", "story_v_side_old_418081.awb") ~= 0 then
					local var_63_24 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081015", "story_v_side_old_418081.awb") / 1000

					if var_63_24 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_16
					end

					if var_63_19.prefab_name ~= "" and arg_60_1.actors_[var_63_19.prefab_name] ~= nil then
						local var_63_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_19.prefab_name].transform, "story_v_side_old_418081", "418081015", "story_v_side_old_418081.awb")

						arg_60_1:RecordAudio("418081015", var_63_25)
						arg_60_1:RecordAudio("418081015", var_63_25)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081015", "story_v_side_old_418081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081015", "story_v_side_old_418081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_26 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_26 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_16) / var_63_26

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_16 + var_63_26 and arg_60_1.time_ < var_63_16 + var_63_26 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play418081016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418081016
		arg_64_1.duration_ = 1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418081017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["107301"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps107301 == nil then
				arg_64_1.var_.actorSpriteComps107301 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps107301 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 1, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps107301 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps107301 = nil
			end

			local var_67_8 = arg_64_1.actors_["10135"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps10135 == nil then
				arg_64_1.var_.actorSpriteComps10135 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps10135 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								local var_67_12 = Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, var_67_11)
								local var_67_13 = Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, var_67_11)
								local var_67_14 = Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, var_67_11)

								iter_67_5.color = Color.New(var_67_12, var_67_13, var_67_14)
							else
								local var_67_15 = Mathf.Lerp(iter_67_5.color.r, 0.5, var_67_11)

								iter_67_5.color = Color.New(var_67_15, var_67_15, var_67_15)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps10135 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10135 = nil
			end

			local var_67_16 = arg_64_1.actors_["107301"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos107301 = var_67_16.localPosition
				var_67_16.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("107301", 2)

				local var_67_18 = var_67_16.childCount

				for iter_67_8 = 0, var_67_18 - 1 do
					local var_67_19 = var_67_16:GetChild(iter_67_8)

					if var_67_19.name == "split_4" or not string.find(var_67_19.name, "split") then
						var_67_19.gameObject:SetActive(true)
					else
						var_67_19.gameObject:SetActive(false)
					end
				end
			end

			local var_67_20 = 0.001

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_20 then
				local var_67_21 = (arg_64_1.time_ - var_67_17) / var_67_20
				local var_67_22 = Vector3.New(-527.7, -367.6, -206)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos107301, var_67_22, var_67_21)
			end

			if arg_64_1.time_ >= var_67_17 + var_67_20 and arg_64_1.time_ < var_67_17 + var_67_20 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_67_23 = 0
			local var_67_24 = 0.075

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_25 = arg_64_1:FormatText(StoryNameCfg[380].name)

				arg_64_1.leftNameTxt_.text = var_67_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_26 = arg_64_1:GetWordFromCfg(418081016)
				local var_67_27 = arg_64_1:FormatText(var_67_26.content)

				arg_64_1.text_.text = var_67_27

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_28 = 3
				local var_67_29 = utf8.len(var_67_27)
				local var_67_30 = var_67_28 <= 0 and var_67_24 or var_67_24 * (var_67_29 / var_67_28)

				if var_67_30 > 0 and var_67_24 < var_67_30 then
					arg_64_1.talkMaxDuration = var_67_30

					if var_67_30 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_30 + var_67_23
					end
				end

				arg_64_1.text_.text = var_67_27
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081016", "story_v_side_old_418081.awb") ~= 0 then
					local var_67_31 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081016", "story_v_side_old_418081.awb") / 1000

					if var_67_31 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_31 + var_67_23
					end

					if var_67_26.prefab_name ~= "" and arg_64_1.actors_[var_67_26.prefab_name] ~= nil then
						local var_67_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_26.prefab_name].transform, "story_v_side_old_418081", "418081016", "story_v_side_old_418081.awb")

						arg_64_1:RecordAudio("418081016", var_67_32)
						arg_64_1:RecordAudio("418081016", var_67_32)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081016", "story_v_side_old_418081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081016", "story_v_side_old_418081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_33 = math.max(var_67_24, arg_64_1.talkMaxDuration)

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_33 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_23) / var_67_33

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_23 + var_67_33 and arg_64_1.time_ < var_67_23 + var_67_33 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play418081017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418081017
		arg_68_1.duration_ = 5.07

		local var_68_0 = {
			ja = 5.066,
			CriLanguages = 4.5,
			zh = 4.5
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play418081018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10135"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10135 == nil then
				arg_68_1.var_.actorSpriteComps10135 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10135 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								local var_71_4 = Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, var_71_3)
								local var_71_5 = Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, var_71_3)
								local var_71_6 = Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, var_71_3)

								iter_71_1.color = Color.New(var_71_4, var_71_5, var_71_6)
							else
								local var_71_7 = Mathf.Lerp(iter_71_1.color.r, 1, var_71_3)

								iter_71_1.color = Color.New(var_71_7, var_71_7, var_71_7)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10135 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10135 = nil
			end

			local var_71_8 = arg_68_1.actors_["107301"]
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps107301 == nil then
				arg_68_1.var_.actorSpriteComps107301 = var_71_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_10 = 0.2

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_10 and not isNil(var_71_8) then
				local var_71_11 = (arg_68_1.time_ - var_71_9) / var_71_10

				if arg_68_1.var_.actorSpriteComps107301 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_71_5 then
							if arg_68_1.isInRecall_ then
								local var_71_12 = Mathf.Lerp(iter_71_5.color.r, arg_68_1.hightColor2.r, var_71_11)
								local var_71_13 = Mathf.Lerp(iter_71_5.color.g, arg_68_1.hightColor2.g, var_71_11)
								local var_71_14 = Mathf.Lerp(iter_71_5.color.b, arg_68_1.hightColor2.b, var_71_11)

								iter_71_5.color = Color.New(var_71_12, var_71_13, var_71_14)
							else
								local var_71_15 = Mathf.Lerp(iter_71_5.color.r, 0.5, var_71_11)

								iter_71_5.color = Color.New(var_71_15, var_71_15, var_71_15)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_9 + var_71_10 and arg_68_1.time_ < var_71_9 + var_71_10 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps107301 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_71_7 then
						if arg_68_1.isInRecall_ then
							iter_71_7.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps107301 = nil
			end

			local var_71_16 = 0
			local var_71_17 = 0.575

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_18 = arg_68_1:FormatText(StoryNameCfg[1187].name)

				arg_68_1.leftNameTxt_.text = var_71_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_19 = arg_68_1:GetWordFromCfg(418081017)
				local var_71_20 = arg_68_1:FormatText(var_71_19.content)

				arg_68_1.text_.text = var_71_20

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_21 = 23
				local var_71_22 = utf8.len(var_71_20)
				local var_71_23 = var_71_21 <= 0 and var_71_17 or var_71_17 * (var_71_22 / var_71_21)

				if var_71_23 > 0 and var_71_17 < var_71_23 then
					arg_68_1.talkMaxDuration = var_71_23

					if var_71_23 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_16
					end
				end

				arg_68_1.text_.text = var_71_20
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081017", "story_v_side_old_418081.awb") ~= 0 then
					local var_71_24 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081017", "story_v_side_old_418081.awb") / 1000

					if var_71_24 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_16
					end

					if var_71_19.prefab_name ~= "" and arg_68_1.actors_[var_71_19.prefab_name] ~= nil then
						local var_71_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_19.prefab_name].transform, "story_v_side_old_418081", "418081017", "story_v_side_old_418081.awb")

						arg_68_1:RecordAudio("418081017", var_71_25)
						arg_68_1:RecordAudio("418081017", var_71_25)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081017", "story_v_side_old_418081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081017", "story_v_side_old_418081.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_26 = math.max(var_71_17, arg_68_1.talkMaxDuration)

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_26 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_16) / var_71_26

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_16 + var_71_26 and arg_68_1.time_ < var_71_16 + var_71_26 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play418081018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418081018
		arg_72_1.duration_ = 7.27

		local var_72_0 = {
			ja = 7.266,
			CriLanguages = 6.6,
			zh = 6.6
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play418081019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10135"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos10135 = var_75_0.localPosition
				var_75_0.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10135", 4)

				local var_75_2 = var_75_0.childCount

				for iter_75_0 = 0, var_75_2 - 1 do
					local var_75_3 = var_75_0:GetChild(iter_75_0)

					if var_75_3.name == "" or not string.find(var_75_3.name, "split") then
						var_75_3.gameObject:SetActive(true)
					else
						var_75_3.gameObject:SetActive(false)
					end
				end
			end

			local var_75_4 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_4 then
				local var_75_5 = (arg_72_1.time_ - var_75_1) / var_75_4
				local var_75_6 = Vector3.New(432.72, -363.6, -305.9)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10135, var_75_6, var_75_5)
			end

			if arg_72_1.time_ >= var_75_1 + var_75_4 and arg_72_1.time_ < var_75_1 + var_75_4 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_75_7 = 0
			local var_75_8 = 0.75

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_9 = arg_72_1:FormatText(StoryNameCfg[1187].name)

				arg_72_1.leftNameTxt_.text = var_75_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(418081018)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_12 = 30
				local var_75_13 = utf8.len(var_75_11)
				local var_75_14 = var_75_12 <= 0 and var_75_8 or var_75_8 * (var_75_13 / var_75_12)

				if var_75_14 > 0 and var_75_8 < var_75_14 then
					arg_72_1.talkMaxDuration = var_75_14

					if var_75_14 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_7
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081018", "story_v_side_old_418081.awb") ~= 0 then
					local var_75_15 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081018", "story_v_side_old_418081.awb") / 1000

					if var_75_15 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_7
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_side_old_418081", "418081018", "story_v_side_old_418081.awb")

						arg_72_1:RecordAudio("418081018", var_75_16)
						arg_72_1:RecordAudio("418081018", var_75_16)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081018", "story_v_side_old_418081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081018", "story_v_side_old_418081.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_17 = math.max(var_75_8, arg_72_1.talkMaxDuration)

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_17 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_7) / var_75_17

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_7 + var_75_17 and arg_72_1.time_ < var_75_7 + var_75_17 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play418081019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418081019
		arg_76_1.duration_ = 4.6

		local var_76_0 = {
			ja = 4.6,
			CriLanguages = 4.233,
			zh = 4.233
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play418081020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["107301"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps107301 == nil then
				arg_76_1.var_.actorSpriteComps107301 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps107301 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 1, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps107301 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps107301 = nil
			end

			local var_79_8 = arg_76_1.actors_["10135"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps10135 == nil then
				arg_76_1.var_.actorSpriteComps10135 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 0.2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps10135 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								local var_79_12 = Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, var_79_11)
								local var_79_13 = Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, var_79_11)
								local var_79_14 = Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, var_79_11)

								iter_79_5.color = Color.New(var_79_12, var_79_13, var_79_14)
							else
								local var_79_15 = Mathf.Lerp(iter_79_5.color.r, 0.5, var_79_11)

								iter_79_5.color = Color.New(var_79_15, var_79_15, var_79_15)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps10135 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10135 = nil
			end

			local var_79_16 = arg_76_1.actors_["107301"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos107301 = var_79_16.localPosition
				var_79_16.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("107301", 2)

				local var_79_18 = var_79_16.childCount

				for iter_79_8 = 0, var_79_18 - 1 do
					local var_79_19 = var_79_16:GetChild(iter_79_8)

					if var_79_19.name == "" or not string.find(var_79_19.name, "split") then
						var_79_19.gameObject:SetActive(true)
					else
						var_79_19.gameObject:SetActive(false)
					end
				end
			end

			local var_79_20 = 0.001

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_20 then
				local var_79_21 = (arg_76_1.time_ - var_79_17) / var_79_20
				local var_79_22 = Vector3.New(-527.7, -367.6, -206)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos107301, var_79_22, var_79_21)
			end

			if arg_76_1.time_ >= var_79_17 + var_79_20 and arg_76_1.time_ < var_79_17 + var_79_20 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_79_23 = 0
			local var_79_24 = 0.475

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[380].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(418081019)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 19
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081019", "story_v_side_old_418081.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081019", "story_v_side_old_418081.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_side_old_418081", "418081019", "story_v_side_old_418081.awb")

						arg_76_1:RecordAudio("418081019", var_79_32)
						arg_76_1:RecordAudio("418081019", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081019", "story_v_side_old_418081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081019", "story_v_side_old_418081.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_33 and arg_76_1.time_ < var_79_23 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play418081020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418081020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play418081021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["107301"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps107301 == nil then
				arg_80_1.var_.actorSpriteComps107301 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps107301 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								local var_83_4 = Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor2.r, var_83_3)
								local var_83_5 = Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor2.g, var_83_3)
								local var_83_6 = Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor2.b, var_83_3)

								iter_83_1.color = Color.New(var_83_4, var_83_5, var_83_6)
							else
								local var_83_7 = Mathf.Lerp(iter_83_1.color.r, 0.5, var_83_3)

								iter_83_1.color = Color.New(var_83_7, var_83_7, var_83_7)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps107301 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps107301 = nil
			end

			local var_83_8 = 0
			local var_83_9 = 0.575

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_10 = arg_80_1:GetWordFromCfg(418081020)
				local var_83_11 = arg_80_1:FormatText(var_83_10.content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_12 = 23
				local var_83_13 = utf8.len(var_83_11)
				local var_83_14 = var_83_12 <= 0 and var_83_9 or var_83_9 * (var_83_13 / var_83_12)

				if var_83_14 > 0 and var_83_9 < var_83_14 then
					arg_80_1.talkMaxDuration = var_83_14

					if var_83_14 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_15 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_15 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_15

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_15 and arg_80_1.time_ < var_83_8 + var_83_15 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play418081021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418081021
		arg_84_1.duration_ = 2.53

		local var_84_0 = {
			ja = 2.533,
			CriLanguages = 2.3,
			zh = 2.3
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
				arg_84_0:Play418081022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["107301"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps107301 == nil then
				arg_84_1.var_.actorSpriteComps107301 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps107301 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 1, var_87_3)

								iter_87_1.color = Color.New(var_87_7, var_87_7, var_87_7)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps107301 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps107301 = nil
			end

			local var_87_8 = arg_84_1.actors_["107301"].transform
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.var_.moveOldPos107301 = var_87_8.localPosition
				var_87_8.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("107301", 2)

				local var_87_10 = var_87_8.childCount

				for iter_87_4 = 0, var_87_10 - 1 do
					local var_87_11 = var_87_8:GetChild(iter_87_4)

					if var_87_11.name == "" or not string.find(var_87_11.name, "split") then
						var_87_11.gameObject:SetActive(true)
					else
						var_87_11.gameObject:SetActive(false)
					end
				end
			end

			local var_87_12 = 0.001

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_9) / var_87_12
				local var_87_14 = Vector3.New(-527.7, -367.6, -206)

				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos107301, var_87_14, var_87_13)
			end

			if arg_84_1.time_ >= var_87_9 + var_87_12 and arg_84_1.time_ < var_87_9 + var_87_12 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_87_15 = 0
			local var_87_16 = 0.3

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[380].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(418081021)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 12
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081021", "story_v_side_old_418081.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081021", "story_v_side_old_418081.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_side_old_418081", "418081021", "story_v_side_old_418081.awb")

						arg_84_1:RecordAudio("418081021", var_87_24)
						arg_84_1:RecordAudio("418081021", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081021", "story_v_side_old_418081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081021", "story_v_side_old_418081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play418081022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418081022
		arg_88_1.duration_ = 5.63

		local var_88_0 = {
			ja = 4.6,
			CriLanguages = 5.633,
			zh = 5.633
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play418081023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10135"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10135 == nil then
				arg_88_1.var_.actorSpriteComps10135 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps10135 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 1, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10135 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10135 = nil
			end

			local var_91_8 = arg_88_1.actors_["107301"]
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps107301 == nil then
				arg_88_1.var_.actorSpriteComps107301 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_10 = 0.2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 and not isNil(var_91_8) then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10

				if arg_88_1.var_.actorSpriteComps107301 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								local var_91_12 = Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, var_91_11)
								local var_91_13 = Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, var_91_11)
								local var_91_14 = Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, var_91_11)

								iter_91_5.color = Color.New(var_91_12, var_91_13, var_91_14)
							else
								local var_91_15 = Mathf.Lerp(iter_91_5.color.r, 0.5, var_91_11)

								iter_91_5.color = Color.New(var_91_15, var_91_15, var_91_15)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps107301 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_91_7 then
						if arg_88_1.isInRecall_ then
							iter_91_7.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps107301 = nil
			end

			local var_91_16 = arg_88_1.actors_["10135"].transform
			local var_91_17 = 0

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.var_.moveOldPos10135 = var_91_16.localPosition
				var_91_16.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10135", 4)

				local var_91_18 = var_91_16.childCount

				for iter_91_8 = 0, var_91_18 - 1 do
					local var_91_19 = var_91_16:GetChild(iter_91_8)

					if var_91_19.name == "split_2" or not string.find(var_91_19.name, "split") then
						var_91_19.gameObject:SetActive(true)
					else
						var_91_19.gameObject:SetActive(false)
					end
				end
			end

			local var_91_20 = 0.001

			if var_91_17 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_17) / var_91_20
				local var_91_22 = Vector3.New(432.72, -363.6, -305.9)

				var_91_16.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10135, var_91_22, var_91_21)
			end

			if arg_88_1.time_ >= var_91_17 + var_91_20 and arg_88_1.time_ < var_91_17 + var_91_20 + arg_91_0 then
				var_91_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_91_23 = 0
			local var_91_24 = 0.25

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_25 = arg_88_1:FormatText(StoryNameCfg[1187].name)

				arg_88_1.leftNameTxt_.text = var_91_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_26 = arg_88_1:GetWordFromCfg(418081022)
				local var_91_27 = arg_88_1:FormatText(var_91_26.content)

				arg_88_1.text_.text = var_91_27

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_28 = 10
				local var_91_29 = utf8.len(var_91_27)
				local var_91_30 = var_91_28 <= 0 and var_91_24 or var_91_24 * (var_91_29 / var_91_28)

				if var_91_30 > 0 and var_91_24 < var_91_30 then
					arg_88_1.talkMaxDuration = var_91_30

					if var_91_30 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_30 + var_91_23
					end
				end

				arg_88_1.text_.text = var_91_27
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081022", "story_v_side_old_418081.awb") ~= 0 then
					local var_91_31 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081022", "story_v_side_old_418081.awb") / 1000

					if var_91_31 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_31 + var_91_23
					end

					if var_91_26.prefab_name ~= "" and arg_88_1.actors_[var_91_26.prefab_name] ~= nil then
						local var_91_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_26.prefab_name].transform, "story_v_side_old_418081", "418081022", "story_v_side_old_418081.awb")

						arg_88_1:RecordAudio("418081022", var_91_32)
						arg_88_1:RecordAudio("418081022", var_91_32)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081022", "story_v_side_old_418081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081022", "story_v_side_old_418081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_33 = math.max(var_91_24, arg_88_1.talkMaxDuration)

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_33 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_23) / var_91_33

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_23 + var_91_33 and arg_88_1.time_ < var_91_23 + var_91_33 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play418081023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418081023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play418081024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10135"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10135 == nil then
				arg_92_1.var_.actorSpriteComps10135 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps10135 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 0.5, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10135 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10135 = nil
			end

			local var_95_8 = arg_92_1.actors_["10135"].transform
			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.var_.moveOldPos10135 = var_95_8.localPosition
				var_95_8.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10135", 7)

				local var_95_10 = var_95_8.childCount

				for iter_95_4 = 0, var_95_10 - 1 do
					local var_95_11 = var_95_8:GetChild(iter_95_4)

					if var_95_11.name == "" or not string.find(var_95_11.name, "split") then
						var_95_11.gameObject:SetActive(true)
					else
						var_95_11.gameObject:SetActive(false)
					end
				end
			end

			local var_95_12 = 0.001

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_9) / var_95_12
				local var_95_14 = Vector3.New(0, -2000, 0)

				var_95_8.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10135, var_95_14, var_95_13)
			end

			if arg_92_1.time_ >= var_95_9 + var_95_12 and arg_92_1.time_ < var_95_9 + var_95_12 + arg_95_0 then
				var_95_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_15 = arg_92_1.actors_["107301"].transform
			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.var_.moveOldPos107301 = var_95_15.localPosition
				var_95_15.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("107301", 7)

				local var_95_17 = var_95_15.childCount

				for iter_95_5 = 0, var_95_17 - 1 do
					local var_95_18 = var_95_15:GetChild(iter_95_5)

					if var_95_18.name == "" or not string.find(var_95_18.name, "split") then
						var_95_18.gameObject:SetActive(true)
					else
						var_95_18.gameObject:SetActive(false)
					end
				end
			end

			local var_95_19 = 0.001

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_16) / var_95_19
				local var_95_21 = Vector3.New(0, -2000, 0)

				var_95_15.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos107301, var_95_21, var_95_20)
			end

			if arg_92_1.time_ >= var_95_16 + var_95_19 and arg_92_1.time_ < var_95_16 + var_95_19 + arg_95_0 then
				var_95_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_22 = 0
			local var_95_23 = 0.925

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_24 = arg_92_1:GetWordFromCfg(418081023)
				local var_95_25 = arg_92_1:FormatText(var_95_24.content)

				arg_92_1.text_.text = var_95_25

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_26 = 37
				local var_95_27 = utf8.len(var_95_25)
				local var_95_28 = var_95_26 <= 0 and var_95_23 or var_95_23 * (var_95_27 / var_95_26)

				if var_95_28 > 0 and var_95_23 < var_95_28 then
					arg_92_1.talkMaxDuration = var_95_28

					if var_95_28 + var_95_22 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_28 + var_95_22
					end
				end

				arg_92_1.text_.text = var_95_25
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_29 = math.max(var_95_23, arg_92_1.talkMaxDuration)

			if var_95_22 <= arg_92_1.time_ and arg_92_1.time_ < var_95_22 + var_95_29 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_22) / var_95_29

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_22 + var_95_29 and arg_92_1.time_ < var_95_22 + var_95_29 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play418081024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418081024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play418081025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.4

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(418081024)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 16
				local var_99_5 = utf8.len(var_99_3)
				local var_99_6 = var_99_4 <= 0 and var_99_1 or var_99_1 * (var_99_5 / var_99_4)

				if var_99_6 > 0 and var_99_1 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_7 and arg_96_1.time_ < var_99_0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play418081025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418081025
		arg_100_1.duration_ = 7.3

		local var_100_0 = {
			ja = 7.3,
			CriLanguages = 6.766,
			zh = 6.766
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play418081026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10135"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps10135 == nil then
				arg_100_1.var_.actorSpriteComps10135 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps10135 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 1, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps10135 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10135 = nil
			end

			local var_103_8 = arg_100_1.actors_["10135"].transform
			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 then
				arg_100_1.var_.moveOldPos10135 = var_103_8.localPosition
				var_103_8.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10135", 3)

				local var_103_10 = var_103_8.childCount

				for iter_103_4 = 0, var_103_10 - 1 do
					local var_103_11 = var_103_8:GetChild(iter_103_4)

					if var_103_11.name == "" or not string.find(var_103_11.name, "split") then
						var_103_11.gameObject:SetActive(true)
					else
						var_103_11.gameObject:SetActive(false)
					end
				end
			end

			local var_103_12 = 0.001

			if var_103_9 <= arg_100_1.time_ and arg_100_1.time_ < var_103_9 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_9) / var_103_12
				local var_103_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_103_8.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10135, var_103_14, var_103_13)
			end

			if arg_100_1.time_ >= var_103_9 + var_103_12 and arg_100_1.time_ < var_103_9 + var_103_12 + arg_103_0 then
				var_103_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_103_15 = 0
			local var_103_16 = 0.675

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[1187].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(418081025)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 27
				local var_103_21 = utf8.len(var_103_19)
				local var_103_22 = var_103_20 <= 0 and var_103_16 or var_103_16 * (var_103_21 / var_103_20)

				if var_103_22 > 0 and var_103_16 < var_103_22 then
					arg_100_1.talkMaxDuration = var_103_22

					if var_103_22 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081025", "story_v_side_old_418081.awb") ~= 0 then
					local var_103_23 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081025", "story_v_side_old_418081.awb") / 1000

					if var_103_23 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_15
					end

					if var_103_18.prefab_name ~= "" and arg_100_1.actors_[var_103_18.prefab_name] ~= nil then
						local var_103_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_18.prefab_name].transform, "story_v_side_old_418081", "418081025", "story_v_side_old_418081.awb")

						arg_100_1:RecordAudio("418081025", var_103_24)
						arg_100_1:RecordAudio("418081025", var_103_24)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081025", "story_v_side_old_418081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081025", "story_v_side_old_418081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_25 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_25 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_25

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_25 and arg_100_1.time_ < var_103_15 + var_103_25 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play418081026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418081026
		arg_104_1.duration_ = 6.33

		local var_104_0 = {
			ja = 6.333,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_104_0:Play418081027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.65

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[1187].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:GetWordFromCfg(418081026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081026", "story_v_side_old_418081.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081026", "story_v_side_old_418081.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_side_old_418081", "418081026", "story_v_side_old_418081.awb")

						arg_104_1:RecordAudio("418081026", var_107_9)
						arg_104_1:RecordAudio("418081026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081026", "story_v_side_old_418081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081026", "story_v_side_old_418081.awb")
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
	Play418081027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418081027
		arg_108_1.duration_ = 3.3

		local var_108_0 = {
			ja = 3.3,
			CriLanguages = 2.933,
			zh = 2.933
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
			arg_108_1.auto_ = false
		end

		function arg_108_1.playNext_(arg_110_0)
			arg_108_1.onStoryFinished_()
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10135"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos10135 = var_111_0.localPosition
				var_111_0.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("10135", 3)

				local var_111_2 = var_111_0.childCount

				for iter_111_0 = 0, var_111_2 - 1 do
					local var_111_3 = var_111_0:GetChild(iter_111_0)

					if var_111_3.name == "" or not string.find(var_111_3.name, "split") then
						var_111_3.gameObject:SetActive(true)
					else
						var_111_3.gameObject:SetActive(false)
					end
				end
			end

			local var_111_4 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_4 then
				local var_111_5 = (arg_108_1.time_ - var_111_1) / var_111_4
				local var_111_6 = Vector3.New(-12.7, -363.6, -305.9)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10135, var_111_6, var_111_5)
			end

			if arg_108_1.time_ >= var_111_1 + var_111_4 and arg_108_1.time_ < var_111_1 + var_111_4 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_111_7 = 0
			local var_111_8 = 0.225

			if var_111_7 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_9 = arg_108_1:FormatText(StoryNameCfg[1187].name)

				arg_108_1.leftNameTxt_.text = var_111_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_10 = arg_108_1:GetWordFromCfg(418081027)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_12 = 9
				local var_111_13 = utf8.len(var_111_11)
				local var_111_14 = var_111_12 <= 0 and var_111_8 or var_111_8 * (var_111_13 / var_111_12)

				if var_111_14 > 0 and var_111_8 < var_111_14 then
					arg_108_1.talkMaxDuration = var_111_14

					if var_111_14 + var_111_7 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_7
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418081", "418081027", "story_v_side_old_418081.awb") ~= 0 then
					local var_111_15 = manager.audio:GetVoiceLength("story_v_side_old_418081", "418081027", "story_v_side_old_418081.awb") / 1000

					if var_111_15 + var_111_7 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_7
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_side_old_418081", "418081027", "story_v_side_old_418081.awb")

						arg_108_1:RecordAudio("418081027", var_111_16)
						arg_108_1:RecordAudio("418081027", var_111_16)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418081", "418081027", "story_v_side_old_418081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418081", "418081027", "story_v_side_old_418081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_17 = math.max(var_111_8, arg_108_1.talkMaxDuration)

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_17 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_7) / var_111_17

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_7 + var_111_17 and arg_108_1.time_ < var_111_7 + var_111_17 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST1001a"
	},
	voices = {
		"story_v_side_old_418081.awb"
	}
}
