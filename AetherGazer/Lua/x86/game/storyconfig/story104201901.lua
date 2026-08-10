return {
	Play420191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420191001
		arg_1_1.duration_ = 7.17

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "SS2005"

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
				local var_4_5 = arg_1_1.bgs_.SS2005

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
					if iter_4_0 ~= "SS2005" then
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
			local var_4_23 = 0.2

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

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_4_0_story_found", "bgm_activity_4_0_story_found", "bgm_activity_4_0_story_found.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_0_story_found", "bgm_activity_4_0_story_found")

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

			local var_4_34 = arg_1_1.bgs_.SS2005.transform
			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS2005 = var_4_34.localPosition
			end

			local var_4_36 = 0.1

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_35) / var_4_36
				local var_4_38 = Vector3.New(0, 1, 9)

				var_4_34.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS2005, var_4_38, var_4_37)
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				var_4_34.localPosition = Vector3.New(0, 1, 9)
			end

			local var_4_39 = arg_1_1.bgs_.SS2005.transform
			local var_4_40 = 0.2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS2005 = var_4_39.localPosition
			end

			local var_4_41 = 1.966666666666

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41
				local var_4_43 = Vector3.New(0, 1, 10)

				var_4_39.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS2005, var_4_43, var_4_42)
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				var_4_39.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_44 = manager.ui.mainCamera.transform
			local var_4_45 = 0

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_46 = arg_1_1.var_.effect1001
				local var_4_47
				local var_4_48 = var_4_44

				if not var_4_46 then
					var_4_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), var_4_48)
					var_4_46.name = "1001"
					arg_1_1.var_.effect1001 = var_4_46
				else
					var_4_46.transform:SetParent(var_4_48)
				end

				var_4_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_46.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2.166666666666
			local var_4_50 = 0.05

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_53 = arg_1_1:GetWordFromCfg(420191001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 2
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_50 or var_4_50 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_50 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_49 = var_4_49 + 0.3

					if var_4_57 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_49 + 0.3
			local var_4_59 = math.max(var_4_50, arg_1_1.talkMaxDuration)

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
				actorName = "SS2005",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2005",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966666666666,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420191002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.7

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

				local var_12_2 = arg_9_1:GetWordFromCfg(420191002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 28
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
	Play420191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420191003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.2

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

				local var_16_2 = arg_13_1:GetWordFromCfg(420191003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 48
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
	Play420191004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420191004
		arg_17_1.duration_ = 7

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420191005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "ST76"

			if arg_17_1.bgs_[var_20_0] == nil then
				local var_20_1 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_0)
				var_20_1.name = var_20_0
				var_20_1.transform.parent = arg_17_1.stage_.transform
				var_20_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_0] = var_20_1
			end

			local var_20_2 = 1

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				local var_20_3 = manager.ui.mainCamera.transform.localPosition
				local var_20_4 = Vector3.New(0, 0, 10) + Vector3.New(var_20_3.x, var_20_3.y, 0)
				local var_20_5 = arg_17_1.bgs_.ST76

				var_20_5.transform.localPosition = var_20_4
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = (var_20_5.transform.localPosition - var_20_3).z
					local var_20_8 = manager.ui.mainCameraCom_
					local var_20_9 = 2 * var_20_7 * Mathf.Tan(var_20_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_10 = var_20_9 * var_20_8.aspect
					local var_20_11 = var_20_6.sprite.bounds.size.x
					local var_20_12 = var_20_6.sprite.bounds.size.y
					local var_20_13 = var_20_10 / var_20_11
					local var_20_14 = var_20_9 / var_20_12
					local var_20_15 = var_20_14 < var_20_13 and var_20_13 or var_20_14

					var_20_5.transform.localScale = Vector3.New(var_20_15, var_20_15, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST76" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_17 = 1

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Color.New(0, 0, 0)

				var_20_19.a = Mathf.Lerp(0, 1, var_20_18)
				arg_17_1.mask_.color = var_20_19
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				local var_20_20 = Color.New(0, 0, 0)

				var_20_20.a = 1
				arg_17_1.mask_.color = var_20_20
			end

			local var_20_21 = 1

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_22 = 1

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Color.New(0, 0, 0)

				var_20_24.a = Mathf.Lerp(1, 0, var_20_23)
				arg_17_1.mask_.color = var_20_24
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				local var_20_25 = Color.New(0, 0, 0)
				local var_20_26 = 0

				arg_17_1.mask_.enabled = false
				var_20_25.a = var_20_26
				arg_17_1.mask_.color = var_20_25
			end

			local var_20_27 = manager.ui.mainCamera.transform
			local var_20_28 = 0.983333333333333

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 then
				local var_20_29 = arg_17_1.var_.effect1001

				if var_20_29 then
					Object.Destroy(var_20_29)

					arg_17_1.var_.effect1001 = nil
				end
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_30 = 2
			local var_20_31 = 0.175

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

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_33 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_34 = arg_17_1:GetWordFromCfg(420191004)
				local var_20_35 = arg_17_1:FormatText(var_20_34.content)

				arg_17_1.text_.text = var_20_35

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_36 = 7
				local var_20_37 = utf8.len(var_20_35)
				local var_20_38 = var_20_36 <= 0 and var_20_31 or var_20_31 * (var_20_37 / var_20_36)

				if var_20_38 > 0 and var_20_31 < var_20_38 then
					arg_17_1.talkMaxDuration = var_20_38
					var_20_30 = var_20_30 + 0.3

					if var_20_38 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_35
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_39 = var_20_30 + 0.3
			local var_20_40 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_39 <= arg_17_1.time_ and arg_17_1.time_ < var_20_39 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_39) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_39 + var_20_40 and arg_17_1.time_ < var_20_39 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play420191005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 420191005
		arg_23_1.duration_ = 14.77

		local var_23_0 = {
			zh = 8.133,
			ja = 14.766
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
				arg_23_0:Play420191006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "1085ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_23_1.stage_.transform)

					var_26_2.name = var_26_0
					var_26_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_23_1.actors_[var_26_0] = var_26_2

					local var_26_3 = var_26_2:GetComponentInChildren(typeof(CharacterEffect))

					var_26_3.enabled = true

					local var_26_4 = GameObjectTools.GetOrAddComponent(var_26_2, typeof(DynamicBoneHelper))

					if var_26_4 then
						var_26_4:EnableDynamicBone(false)
					end

					arg_23_1:ShowWeapon(var_26_3.transform, false)

					arg_23_1.var_[var_26_0 .. "Animator"] = var_26_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_23_1.var_[var_26_0 .. "Animator"].applyRootMotion = true
					arg_23_1.var_[var_26_0 .. "LipSync"] = var_26_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_26_5 = arg_23_1.actors_["1085ui_story"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos1085ui_story = var_26_5.localPosition
			end

			local var_26_7 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_7 then
				local var_26_8 = (arg_23_1.time_ - var_26_6) / var_26_7
				local var_26_9 = Vector3.New(0, -1.01, -5.83)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1085ui_story, var_26_9, var_26_8)

				local var_26_10 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_10.x, var_26_10.y, var_26_10.z)

				local var_26_11 = var_26_5.localEulerAngles

				var_26_11.z = 0
				var_26_11.x = 0
				var_26_5.localEulerAngles = var_26_11
			end

			if arg_23_1.time_ >= var_26_6 + var_26_7 and arg_23_1.time_ < var_26_6 + var_26_7 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_26_12 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_12.x, var_26_12.y, var_26_12.z)

				local var_26_13 = var_26_5.localEulerAngles

				var_26_13.z = 0
				var_26_13.x = 0
				var_26_5.localEulerAngles = var_26_13
			end

			local var_26_14 = arg_23_1.actors_["1085ui_story"]
			local var_26_15 = 0

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect1085ui_story == nil then
				arg_23_1.var_.characterEffect1085ui_story = var_26_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_16 = 0.200000002980232

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_16 and not isNil(var_26_14) then
				local var_26_17 = (arg_23_1.time_ - var_26_15) / var_26_16

				if arg_23_1.var_.characterEffect1085ui_story and not isNil(var_26_14) then
					arg_23_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_15 + var_26_16 and arg_23_1.time_ < var_26_15 + var_26_16 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect1085ui_story then
				arg_23_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_26_18 = 0

			if var_26_18 < arg_23_1.time_ and arg_23_1.time_ <= var_26_18 + arg_26_0 then
				arg_23_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_26_20 = 0
			local var_26_21 = 0.7

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_22 = arg_23_1:FormatText(StoryNameCfg[328].name)

				arg_23_1.leftNameTxt_.text = var_26_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_23 = arg_23_1:GetWordFromCfg(420191005)
				local var_26_24 = arg_23_1:FormatText(var_26_23.content)

				arg_23_1.text_.text = var_26_24

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_25 = 28
				local var_26_26 = utf8.len(var_26_24)
				local var_26_27 = var_26_25 <= 0 and var_26_21 or var_26_21 * (var_26_26 / var_26_25)

				if var_26_27 > 0 and var_26_21 < var_26_27 then
					arg_23_1.talkMaxDuration = var_26_27

					if var_26_27 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_27 + var_26_20
					end
				end

				arg_23_1.text_.text = var_26_24
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191005", "story_v_out_420191.awb") ~= 0 then
					local var_26_28 = manager.audio:GetVoiceLength("story_v_out_420191", "420191005", "story_v_out_420191.awb") / 1000

					if var_26_28 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_20
					end

					if var_26_23.prefab_name ~= "" and arg_23_1.actors_[var_26_23.prefab_name] ~= nil then
						local var_26_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_23.prefab_name].transform, "story_v_out_420191", "420191005", "story_v_out_420191.awb")

						arg_23_1:RecordAudio("420191005", var_26_29)
						arg_23_1:RecordAudio("420191005", var_26_29)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_420191", "420191005", "story_v_out_420191.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_420191", "420191005", "story_v_out_420191.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_30 = math.max(var_26_21, arg_23_1.talkMaxDuration)

			if var_26_20 <= arg_23_1.time_ and arg_23_1.time_ < var_26_20 + var_26_30 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_20) / var_26_30

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_20 + var_26_30 and arg_23_1.time_ < var_26_20 + var_26_30 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play420191006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 420191006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play420191007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1085ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1085ui_story == nil then
				arg_27_1.var_.characterEffect1085ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1085ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1085ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1085ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1085ui_story.fillRatio = var_30_5
			end

			local var_30_6 = 0
			local var_30_7 = 0.2

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_8 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_9 = arg_27_1:GetWordFromCfg(420191006)
				local var_30_10 = arg_27_1:FormatText(var_30_9.content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 8
				local var_30_12 = utf8.len(var_30_10)
				local var_30_13 = var_30_11 <= 0 and var_30_7 or var_30_7 * (var_30_12 / var_30_11)

				if var_30_13 > 0 and var_30_7 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play420191007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 420191007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play420191008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.55

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[7].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:GetWordFromCfg(420191007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 22
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
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_8 and arg_31_1.time_ < var_34_0 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play420191008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 420191008
		arg_35_1.duration_ = 11.1

		local var_35_0 = {
			zh = 8.2,
			ja = 11.1
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
				arg_35_0:Play420191009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1085ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1085ui_story == nil then
				arg_35_1.var_.characterEffect1085ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1085ui_story and not isNil(var_38_0) then
					arg_35_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1085ui_story then
				arg_35_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_38_4 = 0

			if var_38_4 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_38_5 = 0
			local var_38_6 = 0.725

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_7 = arg_35_1:FormatText(StoryNameCfg[328].name)

				arg_35_1.leftNameTxt_.text = var_38_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(420191008)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 29
				local var_38_11 = utf8.len(var_38_9)
				local var_38_12 = var_38_10 <= 0 and var_38_6 or var_38_6 * (var_38_11 / var_38_10)

				if var_38_12 > 0 and var_38_6 < var_38_12 then
					arg_35_1.talkMaxDuration = var_38_12

					if var_38_12 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191008", "story_v_out_420191.awb") ~= 0 then
					local var_38_13 = manager.audio:GetVoiceLength("story_v_out_420191", "420191008", "story_v_out_420191.awb") / 1000

					if var_38_13 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_5
					end

					if var_38_8.prefab_name ~= "" and arg_35_1.actors_[var_38_8.prefab_name] ~= nil then
						local var_38_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_8.prefab_name].transform, "story_v_out_420191", "420191008", "story_v_out_420191.awb")

						arg_35_1:RecordAudio("420191008", var_38_14)
						arg_35_1:RecordAudio("420191008", var_38_14)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_420191", "420191008", "story_v_out_420191.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_420191", "420191008", "story_v_out_420191.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_15 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_15 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_15

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_15 and arg_35_1.time_ < var_38_5 + var_38_15 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play420191009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 420191009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play420191010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1085ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1085ui_story == nil then
				arg_39_1.var_.characterEffect1085ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1085ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1085ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1085ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1085ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.325

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(420191009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 13
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play420191010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 420191010
		arg_43_1.duration_ = 13

		local var_43_0 = {
			zh = 12.833,
			ja = 13
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
				arg_43_0:Play420191011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1085ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1085ui_story == nil then
				arg_43_1.var_.characterEffect1085ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1085ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1085ui_story then
				arg_43_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 1.15

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_6 = arg_43_1:FormatText(StoryNameCfg[328].name)

				arg_43_1.leftNameTxt_.text = var_46_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:GetWordFromCfg(420191010)
				local var_46_8 = arg_43_1:FormatText(var_46_7.content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 46
				local var_46_10 = utf8.len(var_46_8)
				local var_46_11 = var_46_9 <= 0 and var_46_5 or var_46_5 * (var_46_10 / var_46_9)

				if var_46_11 > 0 and var_46_5 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191010", "story_v_out_420191.awb") ~= 0 then
					local var_46_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191010", "story_v_out_420191.awb") / 1000

					if var_46_12 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_4
					end

					if var_46_7.prefab_name ~= "" and arg_43_1.actors_[var_46_7.prefab_name] ~= nil then
						local var_46_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_7.prefab_name].transform, "story_v_out_420191", "420191010", "story_v_out_420191.awb")

						arg_43_1:RecordAudio("420191010", var_46_13)
						arg_43_1:RecordAudio("420191010", var_46_13)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_420191", "420191010", "story_v_out_420191.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_420191", "420191010", "story_v_out_420191.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_14 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_14

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_14 and arg_43_1.time_ < var_46_4 + var_46_14 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play420191011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 420191011
		arg_47_1.duration_ = 13.7

		local var_47_0 = {
			zh = 9.8,
			ja = 13.7
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
				arg_47_0:Play420191012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.875

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[328].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(420191011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191011", "story_v_out_420191.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191011", "story_v_out_420191.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_420191", "420191011", "story_v_out_420191.awb")

						arg_47_1:RecordAudio("420191011", var_50_9)
						arg_47_1:RecordAudio("420191011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_420191", "420191011", "story_v_out_420191.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_420191", "420191011", "story_v_out_420191.awb")
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
	Play420191012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 420191012
		arg_51_1.duration_ = 5.87

		local var_51_0 = {
			zh = 3.433,
			ja = 5.866
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
				arg_51_0:Play420191013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_54_1 = 0
			local var_54_2 = 0.45

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_3 = arg_51_1:FormatText(StoryNameCfg[328].name)

				arg_51_1.leftNameTxt_.text = var_54_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(420191012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 18
				local var_54_7 = utf8.len(var_54_5)
				local var_54_8 = var_54_6 <= 0 and var_54_2 or var_54_2 * (var_54_7 / var_54_6)

				if var_54_8 > 0 and var_54_2 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191012", "story_v_out_420191.awb") ~= 0 then
					local var_54_9 = manager.audio:GetVoiceLength("story_v_out_420191", "420191012", "story_v_out_420191.awb") / 1000

					if var_54_9 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_1
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_420191", "420191012", "story_v_out_420191.awb")

						arg_51_1:RecordAudio("420191012", var_54_10)
						arg_51_1:RecordAudio("420191012", var_54_10)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_420191", "420191012", "story_v_out_420191.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_420191", "420191012", "story_v_out_420191.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_11 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_11

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_11 and arg_51_1.time_ < var_54_1 + var_54_11 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play420191013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 420191013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play420191014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1085ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1085ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1085ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = 0
			local var_58_10 = 1.05

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_11 = arg_55_1:GetWordFromCfg(420191013)
				local var_58_12 = arg_55_1:FormatText(var_58_11.content)

				arg_55_1.text_.text = var_58_12

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 42
				local var_58_14 = utf8.len(var_58_12)
				local var_58_15 = var_58_13 <= 0 and var_58_10 or var_58_10 * (var_58_14 / var_58_13)

				if var_58_15 > 0 and var_58_10 < var_58_15 then
					arg_55_1.talkMaxDuration = var_58_15

					if var_58_15 + var_58_9 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_15 + var_58_9
					end
				end

				arg_55_1.text_.text = var_58_12
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_10, arg_55_1.talkMaxDuration)

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_9) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_9 + var_58_16 and arg_55_1.time_ < var_58_9 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play420191014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 420191014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play420191015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.925

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(420191014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 37
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play420191015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 420191015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play420191016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.25

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_2

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

				local var_66_3 = arg_63_1:GetWordFromCfg(420191015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 10
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play420191016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 420191016
		arg_67_1.duration_ = 6.13

		local var_67_0 = {
			zh = 5.8,
			ja = 6.133
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
				arg_67_0:Play420191017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1085ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1085ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -1.01, -5.83)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1085ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1085ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1085ui_story == nil then
				arg_67_1.var_.characterEffect1085ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1085ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1085ui_story then
				arg_67_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_70_13 = 0

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			local var_70_15 = 0
			local var_70_16 = 0.375

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_17 = arg_67_1:FormatText(StoryNameCfg[328].name)

				arg_67_1.leftNameTxt_.text = var_70_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(420191016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 15
				local var_70_21 = utf8.len(var_70_19)
				local var_70_22 = var_70_20 <= 0 and var_70_16 or var_70_16 * (var_70_21 / var_70_20)

				if var_70_22 > 0 and var_70_16 < var_70_22 then
					arg_67_1.talkMaxDuration = var_70_22

					if var_70_22 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191016", "story_v_out_420191.awb") ~= 0 then
					local var_70_23 = manager.audio:GetVoiceLength("story_v_out_420191", "420191016", "story_v_out_420191.awb") / 1000

					if var_70_23 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_15
					end

					if var_70_18.prefab_name ~= "" and arg_67_1.actors_[var_70_18.prefab_name] ~= nil then
						local var_70_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_18.prefab_name].transform, "story_v_out_420191", "420191016", "story_v_out_420191.awb")

						arg_67_1:RecordAudio("420191016", var_70_24)
						arg_67_1:RecordAudio("420191016", var_70_24)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_420191", "420191016", "story_v_out_420191.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_420191", "420191016", "story_v_out_420191.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_25 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_25 and arg_67_1.time_ < var_70_15 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play420191017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 420191017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play420191018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1085ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1085ui_story == nil then
				arg_71_1.var_.characterEffect1085ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1085ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1085ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1085ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1085ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.925

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(420191017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 37
				local var_74_11 = utf8.len(var_74_9)
				local var_74_12 = var_74_10 <= 0 and var_74_7 or var_74_7 * (var_74_11 / var_74_10)

				if var_74_12 > 0 and var_74_7 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_13 and arg_71_1.time_ < var_74_6 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play420191018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 420191018
		arg_75_1.duration_ = 7.7

		local var_75_0 = {
			zh = 7.7,
			ja = 7.366
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
				arg_75_0:Play420191019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1085ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1085ui_story == nil then
				arg_75_1.var_.characterEffect1085ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1085ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1085ui_story then
				arg_75_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_78_4 = 0
			local var_78_5 = 0.9

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_6 = arg_75_1:FormatText(StoryNameCfg[328].name)

				arg_75_1.leftNameTxt_.text = var_78_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(420191018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 31
				local var_78_10 = utf8.len(var_78_8)
				local var_78_11 = var_78_9 <= 0 and var_78_5 or var_78_5 * (var_78_10 / var_78_9)

				if var_78_11 > 0 and var_78_5 < var_78_11 then
					arg_75_1.talkMaxDuration = var_78_11

					if var_78_11 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191018", "story_v_out_420191.awb") ~= 0 then
					local var_78_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191018", "story_v_out_420191.awb") / 1000

					if var_78_12 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_4
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_420191", "420191018", "story_v_out_420191.awb")

						arg_75_1:RecordAudio("420191018", var_78_13)
						arg_75_1:RecordAudio("420191018", var_78_13)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_420191", "420191018", "story_v_out_420191.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_420191", "420191018", "story_v_out_420191.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_14 and arg_75_1.time_ < var_78_4 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play420191019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 420191019
		arg_79_1.duration_ = 12.13

		local var_79_0 = {
			zh = 6.566,
			ja = 12.133
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
				arg_79_0:Play420191020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_82_1 = 0
			local var_82_2 = 0.725

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_3 = arg_79_1:FormatText(StoryNameCfg[328].name)

				arg_79_1.leftNameTxt_.text = var_82_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(420191019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 29
				local var_82_7 = utf8.len(var_82_5)
				local var_82_8 = var_82_6 <= 0 and var_82_2 or var_82_2 * (var_82_7 / var_82_6)

				if var_82_8 > 0 and var_82_2 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191019", "story_v_out_420191.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_out_420191", "420191019", "story_v_out_420191.awb") / 1000

					if var_82_9 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_1
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_420191", "420191019", "story_v_out_420191.awb")

						arg_79_1:RecordAudio("420191019", var_82_10)
						arg_79_1:RecordAudio("420191019", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_420191", "420191019", "story_v_out_420191.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_420191", "420191019", "story_v_out_420191.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_11 and arg_79_1.time_ < var_82_1 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play420191020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 420191020
		arg_83_1.duration_ = 14.83

		local var_83_0 = {
			zh = 9.833,
			ja = 14.833
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
				arg_83_0:Play420191021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.9

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[328].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(420191020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191020", "story_v_out_420191.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191020", "story_v_out_420191.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_420191", "420191020", "story_v_out_420191.awb")

						arg_83_1:RecordAudio("420191020", var_86_9)
						arg_83_1:RecordAudio("420191020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_420191", "420191020", "story_v_out_420191.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_420191", "420191020", "story_v_out_420191.awb")
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
	Play420191021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 420191021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play420191022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1085ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1085ui_story == nil then
				arg_87_1.var_.characterEffect1085ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1085ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1085ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1085ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1085ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 0.225

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_8 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_9 = arg_87_1:GetWordFromCfg(420191021)
				local var_90_10 = arg_87_1:FormatText(var_90_9.content)

				arg_87_1.text_.text = var_90_10

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 9
				local var_90_12 = utf8.len(var_90_10)
				local var_90_13 = var_90_11 <= 0 and var_90_7 or var_90_7 * (var_90_12 / var_90_11)

				if var_90_13 > 0 and var_90_7 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_10
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_14 and arg_87_1.time_ < var_90_6 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play420191022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 420191022
		arg_91_1.duration_ = 1

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"

			SetActive(arg_91_1.choicesGo_, true)

			for iter_92_0, iter_92_1 in ipairs(arg_91_1.choices_) do
				local var_92_0 = iter_92_0 <= 1

				SetActive(iter_92_1.go, var_92_0)
			end

			arg_91_1.choices_[1].txt.text = arg_91_1:FormatText(StoryChoiceCfg[1238].name)
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play420191023(arg_91_1)
			end

			arg_91_1:RecordChoiceLog(420191022, 1238)
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			return
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play420191023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 420191023
		arg_95_1.duration_ = 10.63

		local var_95_0 = {
			zh = 10.632999999999,
			ja = 10.032999999999
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
				arg_95_0:Play420191024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "ST67"

			if arg_95_1.bgs_[var_98_0] == nil then
				local var_98_1 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_98_0)
				var_98_1.name = var_98_0
				var_98_1.transform.parent = arg_95_1.stage_.transform
				var_98_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_[var_98_0] = var_98_1
			end

			local var_98_2 = 1.999999999999

			if var_98_2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				local var_98_3 = manager.ui.mainCamera.transform.localPosition
				local var_98_4 = Vector3.New(0, 0, 10) + Vector3.New(var_98_3.x, var_98_3.y, 0)
				local var_98_5 = arg_95_1.bgs_.ST67

				var_98_5.transform.localPosition = var_98_4
				var_98_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_6 = var_98_5:GetComponent("SpriteRenderer")

				if var_98_6 and var_98_6.sprite then
					local var_98_7 = (var_98_5.transform.localPosition - var_98_3).z
					local var_98_8 = manager.ui.mainCameraCom_
					local var_98_9 = 2 * var_98_7 * Mathf.Tan(var_98_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_10 = var_98_9 * var_98_8.aspect
					local var_98_11 = var_98_6.sprite.bounds.size.x
					local var_98_12 = var_98_6.sprite.bounds.size.y
					local var_98_13 = var_98_10 / var_98_11
					local var_98_14 = var_98_9 / var_98_12
					local var_98_15 = var_98_14 < var_98_13 and var_98_13 or var_98_14

					var_98_5.transform.localScale = Vector3.New(var_98_15, var_98_15, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST67" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_16 = 4

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			local var_98_17 = 0.3

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_18 = 0

			if var_98_18 < arg_95_1.time_ and arg_95_1.time_ <= var_98_18 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_19 = 2

			if var_98_18 <= arg_95_1.time_ and arg_95_1.time_ < var_98_18 + var_98_19 then
				local var_98_20 = (arg_95_1.time_ - var_98_18) / var_98_19
				local var_98_21 = Color.New(0, 0, 0)

				var_98_21.a = Mathf.Lerp(0, 1, var_98_20)
				arg_95_1.mask_.color = var_98_21
			end

			if arg_95_1.time_ >= var_98_18 + var_98_19 and arg_95_1.time_ < var_98_18 + var_98_19 + arg_98_0 then
				local var_98_22 = Color.New(0, 0, 0)

				var_98_22.a = 1
				arg_95_1.mask_.color = var_98_22
			end

			local var_98_23 = 2

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_24 = 2

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_24 then
				local var_98_25 = (arg_95_1.time_ - var_98_23) / var_98_24
				local var_98_26 = Color.New(0, 0, 0)

				var_98_26.a = Mathf.Lerp(1, 0, var_98_25)
				arg_95_1.mask_.color = var_98_26
			end

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 then
				local var_98_27 = Color.New(0, 0, 0)
				local var_98_28 = 0

				arg_95_1.mask_.enabled = false
				var_98_27.a = var_98_28
				arg_95_1.mask_.color = var_98_27
			end

			local var_98_29 = 1.76666666666667
			local var_98_30 = 1

			if var_98_29 < arg_95_1.time_ and arg_95_1.time_ <= var_98_29 + arg_98_0 then
				local var_98_31 = "play"
				local var_98_32 = "effect"

				arg_95_1:AudioAction(var_98_31, var_98_32, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_98_33 = 0
			local var_98_34 = 0.2

			if var_98_33 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				local var_98_35 = "play"
				local var_98_36 = "music"

				arg_95_1:AudioAction(var_98_35, var_98_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_98_37 = ""
				local var_98_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_98_38 ~= "" then
					if arg_95_1.bgmTxt_.text ~= var_98_38 and arg_95_1.bgmTxt_.text ~= "" then
						if arg_95_1.bgmTxt2_.text ~= "" then
							arg_95_1.bgmTxt_.text = arg_95_1.bgmTxt2_.text
						end

						arg_95_1.bgmTxt2_.text = var_98_38

						arg_95_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_95_1.bgmTxt_.text = var_98_38
						arg_95_1.bgmTxt2_.text = var_98_38
					end

					if arg_95_1.bgmTimer then
						arg_95_1.bgmTimer:Stop()

						arg_95_1.bgmTimer = nil
					end

					if arg_95_1.settingData.show_music_name == 1 then
						arg_95_1.musicController:SetSelectedState("show")
						arg_95_1.musicAnimator_:Play("open", 0, 0)

						if arg_95_1.settingData.music_time ~= 0 then
							arg_95_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_95_1.settingData.music_time), function()
								if arg_95_1 == nil or isNil(arg_95_1.bgmTxt_) then
									return
								end

								arg_95_1.musicController:SetSelectedState("hide")
								arg_95_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_98_39 = manager.ui.mainCamera.transform
			local var_98_40 = 1.98333333333233

			if var_98_40 < arg_95_1.time_ and arg_95_1.time_ <= var_98_40 + arg_98_0 then
				local var_98_41 = arg_95_1.var_.effect1001

				if var_98_41 then
					Object.Destroy(var_98_41)

					arg_95_1.var_.effect1001 = nil
				end
			end

			local var_98_42 = arg_95_1.actors_["1085ui_story"].transform
			local var_98_43 = 1.96599999815126

			if var_98_43 < arg_95_1.time_ and arg_95_1.time_ <= var_98_43 + arg_98_0 then
				arg_95_1.var_.moveOldPos1085ui_story = var_98_42.localPosition
			end

			local var_98_44 = 0.001

			if var_98_43 <= arg_95_1.time_ and arg_95_1.time_ < var_98_43 + var_98_44 then
				local var_98_45 = (arg_95_1.time_ - var_98_43) / var_98_44
				local var_98_46 = Vector3.New(0, 100, 0)

				var_98_42.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1085ui_story, var_98_46, var_98_45)

				local var_98_47 = manager.ui.mainCamera.transform.position - var_98_42.position

				var_98_42.forward = Vector3.New(var_98_47.x, var_98_47.y, var_98_47.z)

				local var_98_48 = var_98_42.localEulerAngles

				var_98_48.z = 0
				var_98_48.x = 0
				var_98_42.localEulerAngles = var_98_48
			end

			if arg_95_1.time_ >= var_98_43 + var_98_44 and arg_95_1.time_ < var_98_43 + var_98_44 + arg_98_0 then
				var_98_42.localPosition = Vector3.New(0, 100, 0)

				local var_98_49 = manager.ui.mainCamera.transform.position - var_98_42.position

				var_98_42.forward = Vector3.New(var_98_49.x, var_98_49.y, var_98_49.z)

				local var_98_50 = var_98_42.localEulerAngles

				var_98_50.z = 0
				var_98_50.x = 0
				var_98_42.localEulerAngles = var_98_50
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_51 = 3.999999999999
			local var_98_52 = 0.45

			if var_98_51 < arg_95_1.time_ and arg_95_1.time_ <= var_98_51 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_53 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_53:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_95_1.dialogCg_.alpha = arg_100_0
				end))
				var_98_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_54 = arg_95_1:GetWordFromCfg(420191023)
				local var_98_55 = arg_95_1:FormatText(var_98_54.content)

				arg_95_1.text_.text = var_98_55

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_56 = 18
				local var_98_57 = utf8.len(var_98_55)
				local var_98_58 = var_98_56 <= 0 and var_98_52 or var_98_52 * (var_98_57 / var_98_56)

				if var_98_58 > 0 and var_98_52 < var_98_58 then
					arg_95_1.talkMaxDuration = var_98_58
					var_98_51 = var_98_51 + 0.3

					if var_98_58 + var_98_51 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_58 + var_98_51
					end
				end

				arg_95_1.text_.text = var_98_55
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191023", "story_v_out_420191.awb") ~= 0 then
					local var_98_59 = manager.audio:GetVoiceLength("story_v_out_420191", "420191023", "story_v_out_420191.awb") / 1000

					if var_98_59 + var_98_51 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_59 + var_98_51
					end

					if var_98_54.prefab_name ~= "" and arg_95_1.actors_[var_98_54.prefab_name] ~= nil then
						local var_98_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_54.prefab_name].transform, "story_v_out_420191", "420191023", "story_v_out_420191.awb")

						arg_95_1:RecordAudio("420191023", var_98_60)
						arg_95_1:RecordAudio("420191023", var_98_60)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_420191", "420191023", "story_v_out_420191.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_420191", "420191023", "story_v_out_420191.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_61 = var_98_51 + 0.3
			local var_98_62 = math.max(var_98_52, arg_95_1.talkMaxDuration)

			if var_98_61 <= arg_95_1.time_ and arg_95_1.time_ < var_98_61 + var_98_62 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_61) / var_98_62

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_61 + var_98_62 and arg_95_1.time_ < var_98_61 + var_98_62 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play420191024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420191024
		arg_102_1.duration_ = 7.43

		local var_102_0 = {
			zh = 6,
			ja = 7.433
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play420191025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.375

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(420191024)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 15
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191024", "story_v_out_420191.awb") ~= 0 then
					local var_105_7 = manager.audio:GetVoiceLength("story_v_out_420191", "420191024", "story_v_out_420191.awb") / 1000

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end

					if var_105_2.prefab_name ~= "" and arg_102_1.actors_[var_105_2.prefab_name] ~= nil then
						local var_105_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_2.prefab_name].transform, "story_v_out_420191", "420191024", "story_v_out_420191.awb")

						arg_102_1:RecordAudio("420191024", var_105_8)
						arg_102_1:RecordAudio("420191024", var_105_8)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_420191", "420191024", "story_v_out_420191.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_420191", "420191024", "story_v_out_420191.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_9 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_9 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_9

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_9 and arg_102_1.time_ < var_105_0 + var_105_9 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play420191025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420191025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play420191026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.875

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(420191025)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 35
				local var_109_5 = utf8.len(var_109_3)
				local var_109_6 = var_109_4 <= 0 and var_109_1 or var_109_1 * (var_109_5 / var_109_4)

				if var_109_6 > 0 and var_109_1 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_7 and arg_106_1.time_ < var_109_0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play420191026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420191026
		arg_110_1.duration_ = 14.9

		local var_110_0 = {
			zh = 12.533,
			ja = 14.9
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play420191027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				local var_113_2 = "play"
				local var_113_3 = "effect"

				arg_110_1:AudioAction(var_113_2, var_113_3, "se_story_140", "se_story_140_data03", "")
			end

			local var_113_4 = 0
			local var_113_5 = 1

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(420191026)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_8 = 40
				local var_113_9 = utf8.len(var_113_7)
				local var_113_10 = var_113_8 <= 0 and var_113_5 or var_113_5 * (var_113_9 / var_113_8)

				if var_113_10 > 0 and var_113_5 < var_113_10 then
					arg_110_1.talkMaxDuration = var_113_10

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191026", "story_v_out_420191.awb") ~= 0 then
					local var_113_11 = manager.audio:GetVoiceLength("story_v_out_420191", "420191026", "story_v_out_420191.awb") / 1000

					if var_113_11 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_420191", "420191026", "story_v_out_420191.awb")

						arg_110_1:RecordAudio("420191026", var_113_12)
						arg_110_1:RecordAudio("420191026", var_113_12)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_420191", "420191026", "story_v_out_420191.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_420191", "420191026", "story_v_out_420191.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_13 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_13 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_13

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_13 and arg_110_1.time_ < var_113_4 + var_113_13 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play420191027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420191027
		arg_114_1.duration_ = 2.27

		local var_114_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420191028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = "1061ui_story"

			if arg_114_1.actors_[var_117_0] == nil then
				local var_117_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_117_1) then
					local var_117_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_114_1.stage_.transform)

					var_117_2.name = var_117_0
					var_117_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_114_1.actors_[var_117_0] = var_117_2

					local var_117_3 = var_117_2:GetComponentInChildren(typeof(CharacterEffect))

					var_117_3.enabled = true

					local var_117_4 = GameObjectTools.GetOrAddComponent(var_117_2, typeof(DynamicBoneHelper))

					if var_117_4 then
						var_117_4:EnableDynamicBone(false)
					end

					arg_114_1:ShowWeapon(var_117_3.transform, false)

					arg_114_1.var_[var_117_0 .. "Animator"] = var_117_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_114_1.var_[var_117_0 .. "Animator"].applyRootMotion = true
					arg_114_1.var_[var_117_0 .. "LipSync"] = var_117_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_117_5 = arg_114_1.actors_["1061ui_story"].transform
			local var_117_6 = 0

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.var_.moveOldPos1061ui_story = var_117_5.localPosition
			end

			local var_117_7 = 0.001

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_7 then
				local var_117_8 = (arg_114_1.time_ - var_117_6) / var_117_7
				local var_117_9 = Vector3.New(0, -1.18, -6.15)

				var_117_5.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1061ui_story, var_117_9, var_117_8)

				local var_117_10 = manager.ui.mainCamera.transform.position - var_117_5.position

				var_117_5.forward = Vector3.New(var_117_10.x, var_117_10.y, var_117_10.z)

				local var_117_11 = var_117_5.localEulerAngles

				var_117_11.z = 0
				var_117_11.x = 0
				var_117_5.localEulerAngles = var_117_11
			end

			if arg_114_1.time_ >= var_117_6 + var_117_7 and arg_114_1.time_ < var_117_6 + var_117_7 + arg_117_0 then
				var_117_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_117_12 = manager.ui.mainCamera.transform.position - var_117_5.position

				var_117_5.forward = Vector3.New(var_117_12.x, var_117_12.y, var_117_12.z)

				local var_117_13 = var_117_5.localEulerAngles

				var_117_13.z = 0
				var_117_13.x = 0
				var_117_5.localEulerAngles = var_117_13
			end

			local var_117_14 = arg_114_1.actors_["1061ui_story"]
			local var_117_15 = 0

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 and not isNil(var_117_14) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_16 = 0.200000002980232

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_16 and not isNil(var_117_14) then
				local var_117_17 = (arg_114_1.time_ - var_117_15) / var_117_16

				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_14) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_15 + var_117_16 and arg_114_1.time_ < var_117_15 + var_117_16 + arg_117_0 and not isNil(var_117_14) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_117_18 = 0

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_117_19 = 0

			if var_117_19 < arg_114_1.time_ and arg_114_1.time_ <= var_117_19 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_20 = 0
			local var_117_21 = 0.275

			if var_117_20 < arg_114_1.time_ and arg_114_1.time_ <= var_117_20 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_22 = arg_114_1:FormatText(StoryNameCfg[612].name)

				arg_114_1.leftNameTxt_.text = var_117_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_23 = arg_114_1:GetWordFromCfg(420191027)
				local var_117_24 = arg_114_1:FormatText(var_117_23.content)

				arg_114_1.text_.text = var_117_24

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_25 = 11
				local var_117_26 = utf8.len(var_117_24)
				local var_117_27 = var_117_25 <= 0 and var_117_21 or var_117_21 * (var_117_26 / var_117_25)

				if var_117_27 > 0 and var_117_21 < var_117_27 then
					arg_114_1.talkMaxDuration = var_117_27

					if var_117_27 + var_117_20 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_27 + var_117_20
					end
				end

				arg_114_1.text_.text = var_117_24
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191027", "story_v_out_420191.awb") ~= 0 then
					local var_117_28 = manager.audio:GetVoiceLength("story_v_out_420191", "420191027", "story_v_out_420191.awb") / 1000

					if var_117_28 + var_117_20 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_28 + var_117_20
					end

					if var_117_23.prefab_name ~= "" and arg_114_1.actors_[var_117_23.prefab_name] ~= nil then
						local var_117_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_23.prefab_name].transform, "story_v_out_420191", "420191027", "story_v_out_420191.awb")

						arg_114_1:RecordAudio("420191027", var_117_29)
						arg_114_1:RecordAudio("420191027", var_117_29)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420191", "420191027", "story_v_out_420191.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420191", "420191027", "story_v_out_420191.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_30 = math.max(var_117_21, arg_114_1.talkMaxDuration)

			if var_117_20 <= arg_114_1.time_ and arg_114_1.time_ < var_117_20 + var_117_30 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_20) / var_117_30

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_20 + var_117_30 and arg_114_1.time_ < var_117_20 + var_117_30 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play420191028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420191028
		arg_118_1.duration_ = 8.9

		local var_118_0 = {
			zh = 5.233,
			ja = 8.9
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play420191029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.65

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[612].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_3 = arg_118_1:GetWordFromCfg(420191028)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 26
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191028", "story_v_out_420191.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191028", "story_v_out_420191.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_420191", "420191028", "story_v_out_420191.awb")

						arg_118_1:RecordAudio("420191028", var_121_9)
						arg_118_1:RecordAudio("420191028", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_420191", "420191028", "story_v_out_420191.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_420191", "420191028", "story_v_out_420191.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play420191029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420191029
		arg_122_1.duration_ = 6.07

		local var_122_0 = {
			zh = 5.5,
			ja = 6.066
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play420191030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.575

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[612].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:GetWordFromCfg(420191029)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 23
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191029", "story_v_out_420191.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191029", "story_v_out_420191.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_420191", "420191029", "story_v_out_420191.awb")

						arg_122_1:RecordAudio("420191029", var_125_9)
						arg_122_1:RecordAudio("420191029", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_420191", "420191029", "story_v_out_420191.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_420191", "420191029", "story_v_out_420191.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play420191030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420191030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play420191031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1061ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1061ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1061ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, 100, 0)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = 0
			local var_129_10 = 1.3

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_11 = arg_126_1:GetWordFromCfg(420191030)
				local var_129_12 = arg_126_1:FormatText(var_129_11.content)

				arg_126_1.text_.text = var_129_12

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 52
				local var_129_14 = utf8.len(var_129_12)
				local var_129_15 = var_129_13 <= 0 and var_129_10 or var_129_10 * (var_129_14 / var_129_13)

				if var_129_15 > 0 and var_129_10 < var_129_15 then
					arg_126_1.talkMaxDuration = var_129_15

					if var_129_15 + var_129_9 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_15 + var_129_9
					end
				end

				arg_126_1.text_.text = var_129_12
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_10, arg_126_1.talkMaxDuration)

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_9) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_9 + var_129_16 and arg_126_1.time_ < var_129_9 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play420191031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 420191031
		arg_130_1.duration_ = 9.1

		local var_130_0 = {
			zh = 7.6,
			ja = 9.1
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play420191032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.2

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				local var_133_2 = "play"
				local var_133_3 = "music"

				arg_130_1:AudioAction(var_133_2, var_133_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_133_4 = ""
				local var_133_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_133_5 ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_5 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_5

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_5
						arg_130_1.bgmTxt2_.text = var_133_5
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_133_6 = 0.333333333333333
			local var_133_7 = 1

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				local var_133_8 = "play"
				local var_133_9 = "music"

				arg_130_1:AudioAction(var_133_8, var_133_9, "bgm_login_4_0", "bgm_login_4_0", "bgm_login_4_0.awb")

				local var_133_10 = ""
				local var_133_11 = manager.audio:GetAudioName("bgm_login_4_0", "bgm_login_4_0")

				if var_133_11 ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_11 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_11

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_11
						arg_130_1.bgmTxt2_.text = var_133_11
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_133_12 = 0
			local var_133_13 = 0.6

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_14 = arg_130_1:GetWordFromCfg(420191031)
				local var_133_15 = arg_130_1:FormatText(var_133_14.content)

				arg_130_1.text_.text = var_133_15

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_16 = 24
				local var_133_17 = utf8.len(var_133_15)
				local var_133_18 = var_133_16 <= 0 and var_133_13 or var_133_13 * (var_133_17 / var_133_16)

				if var_133_18 > 0 and var_133_13 < var_133_18 then
					arg_130_1.talkMaxDuration = var_133_18

					if var_133_18 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_18 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_15
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191031", "story_v_out_420191.awb") ~= 0 then
					local var_133_19 = manager.audio:GetVoiceLength("story_v_out_420191", "420191031", "story_v_out_420191.awb") / 1000

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end

					if var_133_14.prefab_name ~= "" and arg_130_1.actors_[var_133_14.prefab_name] ~= nil then
						local var_133_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_14.prefab_name].transform, "story_v_out_420191", "420191031", "story_v_out_420191.awb")

						arg_130_1:RecordAudio("420191031", var_133_20)
						arg_130_1:RecordAudio("420191031", var_133_20)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_420191", "420191031", "story_v_out_420191.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_420191", "420191031", "story_v_out_420191.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_21 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_21 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_21

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_21 and arg_130_1.time_ < var_133_12 + var_133_21 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play420191032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 420191032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play420191033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = "STblack"

			if arg_136_1.bgs_[var_139_0] == nil then
				local var_139_1 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_139_0)
				var_139_1.name = var_139_0
				var_139_1.transform.parent = arg_136_1.stage_.transform
				var_139_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_[var_139_0] = var_139_1
			end

			local var_139_2 = 2

			if var_139_2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				local var_139_3 = manager.ui.mainCamera.transform.localPosition
				local var_139_4 = Vector3.New(0, 0, 10) + Vector3.New(var_139_3.x, var_139_3.y, 0)
				local var_139_5 = arg_136_1.bgs_.STblack

				var_139_5.transform.localPosition = var_139_4
				var_139_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_6 = var_139_5:GetComponent("SpriteRenderer")

				if var_139_6 and var_139_6.sprite then
					local var_139_7 = (var_139_5.transform.localPosition - var_139_3).z
					local var_139_8 = manager.ui.mainCameraCom_
					local var_139_9 = 2 * var_139_7 * Mathf.Tan(var_139_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_139_10 = var_139_9 * var_139_8.aspect
					local var_139_11 = var_139_6.sprite.bounds.size.x
					local var_139_12 = var_139_6.sprite.bounds.size.y
					local var_139_13 = var_139_10 / var_139_11
					local var_139_14 = var_139_9 / var_139_12
					local var_139_15 = var_139_14 < var_139_13 and var_139_13 or var_139_14

					var_139_5.transform.localScale = Vector3.New(var_139_15, var_139_15, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "STblack" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_16 = 4

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_17 = 0.3

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_18 = 0

			if var_139_18 < arg_136_1.time_ and arg_136_1.time_ <= var_139_18 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_19 = 2

			if var_139_18 <= arg_136_1.time_ and arg_136_1.time_ < var_139_18 + var_139_19 then
				local var_139_20 = (arg_136_1.time_ - var_139_18) / var_139_19
				local var_139_21 = Color.New(0, 0, 0)

				var_139_21.a = Mathf.Lerp(0, 1, var_139_20)
				arg_136_1.mask_.color = var_139_21
			end

			if arg_136_1.time_ >= var_139_18 + var_139_19 and arg_136_1.time_ < var_139_18 + var_139_19 + arg_139_0 then
				local var_139_22 = Color.New(0, 0, 0)

				var_139_22.a = 1
				arg_136_1.mask_.color = var_139_22
			end

			local var_139_23 = 2

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_24 = 2

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_24 then
				local var_139_25 = (arg_136_1.time_ - var_139_23) / var_139_24
				local var_139_26 = Color.New(0, 0, 0)

				var_139_26.a = Mathf.Lerp(1, 0, var_139_25)
				arg_136_1.mask_.color = var_139_26
			end

			if arg_136_1.time_ >= var_139_23 + var_139_24 and arg_136_1.time_ < var_139_23 + var_139_24 + arg_139_0 then
				local var_139_27 = Color.New(0, 0, 0)
				local var_139_28 = 0

				arg_136_1.mask_.enabled = false
				var_139_27.a = var_139_28
				arg_136_1.mask_.color = var_139_27
			end

			local var_139_29 = 0.233333333333333
			local var_139_30 = 1

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				local var_139_31 = "stop"
				local var_139_32 = "effect"

				arg_136_1:AudioAction(var_139_31, var_139_32, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_139_33 = 2

			if var_139_33 < arg_136_1.time_ and arg_136_1.time_ <= var_139_33 + arg_139_0 then
				arg_136_1.fswbg_:SetActive(true)
				arg_136_1.dialog_:SetActive(false)

				arg_136_1.fswtw_.percent = 0

				local var_139_34 = arg_136_1:GetWordFromCfg(420191032)
				local var_139_35 = arg_136_1:FormatText(var_139_34.content)

				arg_136_1.fswt_.text = var_139_35

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.fswt_)

				arg_136_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_136_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_136_1.fswtw_:SetDirty()

				arg_136_1.typewritterCharCountI18N = 0

				SetActive(arg_136_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_136_1:ShowNextGo(false)
			end

			local var_139_36 = 3.53333333333333

			if var_139_36 < arg_136_1.time_ and arg_136_1.time_ <= var_139_36 + arg_139_0 then
				arg_136_1.var_.oldValueTypewriter = arg_136_1.fswtw_.percent

				SetActive(arg_136_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_136_1:ShowNextGo(false)
			end

			local var_139_37 = 21
			local var_139_38 = 1.4
			local var_139_39 = arg_136_1:GetWordFromCfg(420191032)
			local var_139_40 = arg_136_1:FormatText(var_139_39.content)
			local var_139_41, var_139_42 = arg_136_1:GetPercentByPara(var_139_40, 1)

			if var_139_36 < arg_136_1.time_ and arg_136_1.time_ <= var_139_36 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				local var_139_43 = var_139_37 <= 0 and var_139_38 or var_139_38 * ((var_139_42 - arg_136_1.typewritterCharCountI18N) / var_139_37)

				if var_139_43 > 0 and var_139_38 < var_139_43 then
					arg_136_1.talkMaxDuration = var_139_43

					if var_139_43 + var_139_36 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_43 + var_139_36
					end
				end
			end

			local var_139_44 = 1.4
			local var_139_45 = math.max(var_139_44, arg_136_1.talkMaxDuration)

			if var_139_36 <= arg_136_1.time_ and arg_136_1.time_ < var_139_36 + var_139_45 then
				local var_139_46 = (arg_136_1.time_ - var_139_36) / var_139_45

				arg_136_1.fswtw_.percent = Mathf.Lerp(arg_136_1.var_.oldValueTypewriter, var_139_41, var_139_46)
				arg_136_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_136_1.fswtw_:SetDirty()
			end

			if arg_136_1.time_ >= var_139_36 + var_139_45 and arg_136_1.time_ < var_139_36 + var_139_45 + arg_139_0 then
				arg_136_1.fswtw_.percent = var_139_41

				arg_136_1.fswtw_:SetDirty()
				arg_136_1:ShowNextGo(true)

				arg_136_1.typewritterCharCountI18N = var_139_42
			end

			local var_139_47 = 2

			if var_139_47 < arg_136_1.time_ and arg_136_1.time_ <= var_139_47 + arg_139_0 then
				local var_139_48 = arg_136_1.fswbg_.transform:Find("textbox/adapt/content") or arg_136_1.fswbg_.transform:Find("textbox/content")
				local var_139_49 = arg_136_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_139_50 = var_139_48:GetComponent("Text")
				local var_139_51 = var_139_48:GetComponent("RectTransform")

				var_139_50.alignment = UnityEngine.TextAnchor.UpperLeft
				var_139_51.offsetMin = Vector2.New(0, 0)
				var_139_51.offsetMax = Vector2.New(0, 0)
			end

			local var_139_52 = 4
			local var_139_53 = 1

			if var_139_52 < arg_136_1.time_ and arg_136_1.time_ <= var_139_52 + arg_139_0 then
				local var_139_54 = "play"
				local var_139_55 = "effect"

				arg_136_1:AudioAction(var_139_54, var_139_55, "se_story_140", "se_story_140_data02", "")
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play420191033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 420191033
		arg_140_1.duration_ = 1.47

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play420191034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.var_.oldValueTypewriter = arg_140_1.fswtw_.percent

				SetActive(arg_140_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_140_1:ShowNextGo(false)
			end

			local var_143_1 = 22
			local var_143_2 = 1.46666666666667
			local var_143_3 = arg_140_1:GetWordFromCfg(420191032)
			local var_143_4 = arg_140_1:FormatText(var_143_3.content)
			local var_143_5, var_143_6 = arg_140_1:GetPercentByPara(var_143_4, 2)

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				local var_143_7 = var_143_1 <= 0 and var_143_2 or var_143_2 * ((var_143_6 - arg_140_1.typewritterCharCountI18N) / var_143_1)

				if var_143_7 > 0 and var_143_2 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end
			end

			local var_143_8 = 1.46666666666667
			local var_143_9 = math.max(var_143_8, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_9 then
				local var_143_10 = (arg_140_1.time_ - var_143_0) / var_143_9

				arg_140_1.fswtw_.percent = Mathf.Lerp(arg_140_1.var_.oldValueTypewriter, var_143_5, var_143_10)
				arg_140_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_140_1.fswtw_:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_9 and arg_140_1.time_ < var_143_0 + var_143_9 + arg_143_0 then
				arg_140_1.fswtw_.percent = var_143_5

				arg_140_1.fswtw_:SetDirty()
				arg_140_1:ShowNextGo(true)

				arg_140_1.typewritterCharCountI18N = var_143_6
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play420191034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 420191034
		arg_144_1.duration_ = 3.3

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play420191035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.var_.oldValueTypewriter = arg_144_1.fswtw_.percent

				SetActive(arg_144_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_144_1:ShowNextGo(false)
			end

			local var_147_1 = 28
			local var_147_2 = 1.86666666666667
			local var_147_3 = arg_144_1:GetWordFromCfg(420191032)
			local var_147_4 = arg_144_1:FormatText(var_147_3.content)
			local var_147_5, var_147_6 = arg_144_1:GetPercentByPara(var_147_4, 3)

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				local var_147_7 = var_147_1 <= 0 and var_147_2 or var_147_2 * ((var_147_6 - arg_144_1.typewritterCharCountI18N) / var_147_1)

				if var_147_7 > 0 and var_147_2 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end
			end

			local var_147_8 = 1.86666666666667
			local var_147_9 = math.max(var_147_8, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_9 then
				local var_147_10 = (arg_144_1.time_ - var_147_0) / var_147_9

				arg_144_1.fswtw_.percent = Mathf.Lerp(arg_144_1.var_.oldValueTypewriter, var_147_5, var_147_10)
				arg_144_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_144_1.fswtw_:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_9 and arg_144_1.time_ < var_147_0 + var_147_9 + arg_147_0 then
				arg_144_1.fswtw_.percent = var_147_5

				arg_144_1.fswtw_:SetDirty()
				arg_144_1:ShowNextGo(true)

				arg_144_1.typewritterCharCountI18N = var_147_6
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play420191035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 420191035
		arg_148_1.duration_ = 1.07

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play420191036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.var_.oldValueTypewriter = arg_148_1.fswtw_.percent

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_1 = 16
			local var_151_2 = 1.06666666666667
			local var_151_3 = arg_148_1:GetWordFromCfg(420191032)
			local var_151_4 = arg_148_1:FormatText(var_151_3.content)
			local var_151_5, var_151_6 = arg_148_1:GetPercentByPara(var_151_4, 4)

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				local var_151_7 = var_151_1 <= 0 and var_151_2 or var_151_2 * ((var_151_6 - arg_148_1.typewritterCharCountI18N) / var_151_1)

				if var_151_7 > 0 and var_151_2 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end
			end

			local var_151_8 = 1.06666666666667
			local var_151_9 = math.max(var_151_8, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_9 then
				local var_151_10 = (arg_148_1.time_ - var_151_0) / var_151_9

				arg_148_1.fswtw_.percent = Mathf.Lerp(arg_148_1.var_.oldValueTypewriter, var_151_5, var_151_10)
				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_148_1.fswtw_:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_9 and arg_148_1.time_ < var_151_0 + var_151_9 + arg_151_0 then
				arg_148_1.fswtw_.percent = var_151_5

				arg_148_1.fswtw_:SetDirty()
				arg_148_1:ShowNextGo(true)

				arg_148_1.typewritterCharCountI18N = var_151_6
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play420191036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 420191036
		arg_152_1.duration_ = 1.73

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play420191037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.var_.oldValueTypewriter = arg_152_1.fswtw_.percent

				SetActive(arg_152_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_152_1:ShowNextGo(false)
			end

			local var_155_1 = 26
			local var_155_2 = 1.73333333333333
			local var_155_3 = arg_152_1:GetWordFromCfg(420191032)
			local var_155_4 = arg_152_1:FormatText(var_155_3.content)
			local var_155_5, var_155_6 = arg_152_1:GetPercentByPara(var_155_4, 5)

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				local var_155_7 = var_155_1 <= 0 and var_155_2 or var_155_2 * ((var_155_6 - arg_152_1.typewritterCharCountI18N) / var_155_1)

				if var_155_7 > 0 and var_155_2 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end
			end

			local var_155_8 = 1.73333333333333
			local var_155_9 = math.max(var_155_8, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_9 then
				local var_155_10 = (arg_152_1.time_ - var_155_0) / var_155_9

				arg_152_1.fswtw_.percent = Mathf.Lerp(arg_152_1.var_.oldValueTypewriter, var_155_5, var_155_10)
				arg_152_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_152_1.fswtw_:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_9 and arg_152_1.time_ < var_155_0 + var_155_9 + arg_155_0 then
				arg_152_1.fswtw_.percent = var_155_5

				arg_152_1.fswtw_:SetDirty()
				arg_152_1:ShowNextGo(true)

				arg_152_1.typewritterCharCountI18N = var_155_6
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play420191037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 420191037
		arg_156_1.duration_ = 1.33

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play420191038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.var_.oldValueTypewriter = arg_156_1.fswtw_.percent

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_1 = 20
			local var_159_2 = 1.33333333333333
			local var_159_3 = arg_156_1:GetWordFromCfg(420191032)
			local var_159_4 = arg_156_1:FormatText(var_159_3.content)
			local var_159_5, var_159_6 = arg_156_1:GetPercentByPara(var_159_4, 6)

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				local var_159_7 = var_159_1 <= 0 and var_159_2 or var_159_2 * ((var_159_6 - arg_156_1.typewritterCharCountI18N) / var_159_1)

				if var_159_7 > 0 and var_159_2 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end
			end

			local var_159_8 = 1.33333333333333
			local var_159_9 = math.max(var_159_8, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_9 then
				local var_159_10 = (arg_156_1.time_ - var_159_0) / var_159_9

				arg_156_1.fswtw_.percent = Mathf.Lerp(arg_156_1.var_.oldValueTypewriter, var_159_5, var_159_10)
				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_156_1.fswtw_:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_9 and arg_156_1.time_ < var_159_0 + var_159_9 + arg_159_0 then
				arg_156_1.fswtw_.percent = var_159_5

				arg_156_1.fswtw_:SetDirty()
				arg_156_1:ShowNextGo(true)

				arg_156_1.typewritterCharCountI18N = var_159_6
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play420191038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 420191038
		arg_160_1.duration_ = 1.53

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play420191039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_1 = 23
			local var_163_2 = 1.53333333333333
			local var_163_3 = arg_160_1:GetWordFromCfg(420191032)
			local var_163_4 = arg_160_1:FormatText(var_163_3.content)
			local var_163_5, var_163_6 = arg_160_1:GetPercentByPara(var_163_4, 7)

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_7 = var_163_1 <= 0 and var_163_2 or var_163_2 * ((var_163_6 - arg_160_1.typewritterCharCountI18N) / var_163_1)

				if var_163_7 > 0 and var_163_2 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end
			end

			local var_163_8 = 1.53333333333333
			local var_163_9 = math.max(var_163_8, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_9 then
				local var_163_10 = (arg_160_1.time_ - var_163_0) / var_163_9

				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_5, var_163_10)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_9 and arg_160_1.time_ < var_163_0 + var_163_9 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_5

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_6
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play420191039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 420191039
		arg_164_1.duration_ = 1.2

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play420191040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.var_.oldValueTypewriter = arg_164_1.fswtw_.percent

				SetActive(arg_164_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_164_1:ShowNextGo(false)
			end

			local var_167_1 = 18
			local var_167_2 = 1.2
			local var_167_3 = arg_164_1:GetWordFromCfg(420191032)
			local var_167_4 = arg_164_1:FormatText(var_167_3.content)
			local var_167_5, var_167_6 = arg_164_1:GetPercentByPara(var_167_4, 8)

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				local var_167_7 = var_167_1 <= 0 and var_167_2 or var_167_2 * ((var_167_6 - arg_164_1.typewritterCharCountI18N) / var_167_1)

				if var_167_7 > 0 and var_167_2 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end
			end

			local var_167_8 = 1.2
			local var_167_9 = math.max(var_167_8, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_9 then
				local var_167_10 = (arg_164_1.time_ - var_167_0) / var_167_9

				arg_164_1.fswtw_.percent = Mathf.Lerp(arg_164_1.var_.oldValueTypewriter, var_167_5, var_167_10)
				arg_164_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_164_1.fswtw_:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_9 and arg_164_1.time_ < var_167_0 + var_167_9 + arg_167_0 then
				arg_164_1.fswtw_.percent = var_167_5

				arg_164_1.fswtw_:SetDirty()
				arg_164_1:ShowNextGo(true)

				arg_164_1.typewritterCharCountI18N = var_167_6
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play420191040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 420191040
		arg_168_1.duration_ = 2.33

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play420191041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.var_.oldValueTypewriter = arg_168_1.fswtw_.percent

				SetActive(arg_168_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_168_1:ShowNextGo(false)
			end

			local var_171_1 = 0
			local var_171_2 = -6.9
			local var_171_3 = arg_168_1:GetWordFromCfg(420191032)
			local var_171_4 = arg_168_1:FormatText(var_171_3.content)
			local var_171_5, var_171_6 = arg_168_1:GetPercentByPara(var_171_4, 5)

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				local var_171_7 = var_171_1 <= 0 and var_171_2 or var_171_2 * ((var_171_6 - arg_168_1.typewritterCharCountI18N) / var_171_1)

				if var_171_7 > 0 and var_171_2 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end
			end

			local var_171_8 = -6.9
			local var_171_9 = math.max(var_171_8, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_9 then
				local var_171_10 = (arg_168_1.time_ - var_171_0) / var_171_9

				arg_168_1.fswtw_.percent = Mathf.Lerp(arg_168_1.var_.oldValueTypewriter, var_171_5, var_171_10)
				arg_168_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_168_1.fswtw_:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_9 and arg_168_1.time_ < var_171_0 + var_171_9 + arg_171_0 then
				arg_168_1.fswtw_.percent = var_171_5

				arg_168_1.fswtw_:SetDirty()
				arg_168_1:ShowNextGo(true)

				arg_168_1.typewritterCharCountI18N = var_171_6
			end

			local var_171_11 = 0

			if var_171_11 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1.fswbg_:SetActive(true)
				arg_168_1.dialog_:SetActive(false)

				arg_168_1.fswtw_.percent = 0

				local var_171_12 = arg_168_1:GetWordFromCfg(420191039)
				local var_171_13 = arg_168_1:FormatText(var_171_12.content)

				arg_168_1.fswt_.text = var_171_13

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.fswt_)

				arg_168_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_168_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_168_1.fswtw_:SetDirty()

				arg_168_1.typewritterCharCountI18N = 0

				SetActive(arg_168_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_168_1:ShowNextGo(false)
			end

			local var_171_14 = 0.0666666666666667

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1.var_.oldValueTypewriter = arg_168_1.fswtw_.percent

				SetActive(arg_168_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_168_1:ShowNextGo(false)
			end

			local var_171_15 = 34
			local var_171_16 = 2.26666666666667
			local var_171_17 = arg_168_1:GetWordFromCfg(420191039)
			local var_171_18 = arg_168_1:FormatText(var_171_17.content)
			local var_171_19, var_171_20 = arg_168_1:GetPercentByPara(var_171_18, 1)

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				local var_171_21 = var_171_15 <= 0 and var_171_16 or var_171_16 * ((var_171_20 - arg_168_1.typewritterCharCountI18N) / var_171_15)

				if var_171_21 > 0 and var_171_16 < var_171_21 then
					arg_168_1.talkMaxDuration = var_171_21

					if var_171_21 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_21 + var_171_14
					end
				end
			end

			local var_171_22 = 2.26666666666667
			local var_171_23 = math.max(var_171_22, arg_168_1.talkMaxDuration)

			if var_171_14 <= arg_168_1.time_ and arg_168_1.time_ < var_171_14 + var_171_23 then
				local var_171_24 = (arg_168_1.time_ - var_171_14) / var_171_23

				arg_168_1.fswtw_.percent = Mathf.Lerp(arg_168_1.var_.oldValueTypewriter, var_171_19, var_171_24)
				arg_168_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_168_1.fswtw_:SetDirty()
			end

			if arg_168_1.time_ >= var_171_14 + var_171_23 and arg_168_1.time_ < var_171_14 + var_171_23 + arg_171_0 then
				arg_168_1.fswtw_.percent = var_171_19

				arg_168_1.fswtw_:SetDirty()
				arg_168_1:ShowNextGo(true)

				arg_168_1.typewritterCharCountI18N = var_171_20
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play420191041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 420191041
		arg_172_1.duration_ = 1.4

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play420191042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.var_.oldValueTypewriter = arg_172_1.fswtw_.percent

				SetActive(arg_172_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_172_1:ShowNextGo(false)
			end

			local var_175_1 = 0
			local var_175_2 = -6.9
			local var_175_3 = arg_172_1:GetWordFromCfg(420191039)
			local var_175_4 = arg_172_1:FormatText(var_175_3.content)
			local var_175_5, var_175_6 = arg_172_1:GetPercentByPara(var_175_4, 4)

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				local var_175_7 = var_175_1 <= 0 and var_175_2 or var_175_2 * ((var_175_6 - arg_172_1.typewritterCharCountI18N) / var_175_1)

				if var_175_7 > 0 and var_175_2 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end
			end

			local var_175_8 = -6.9
			local var_175_9 = math.max(var_175_8, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_9 then
				local var_175_10 = (arg_172_1.time_ - var_175_0) / var_175_9

				arg_172_1.fswtw_.percent = Mathf.Lerp(arg_172_1.var_.oldValueTypewriter, var_175_5, var_175_10)
				arg_172_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_172_1.fswtw_:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_9 and arg_172_1.time_ < var_175_0 + var_175_9 + arg_175_0 then
				arg_172_1.fswtw_.percent = var_175_5

				arg_172_1.fswtw_:SetDirty()
				arg_172_1:ShowNextGo(true)

				arg_172_1.typewritterCharCountI18N = var_175_6
			end

			local var_175_11 = 0

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.var_.oldValueTypewriter = arg_172_1.fswtw_.percent

				SetActive(arg_172_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_172_1:ShowNextGo(false)
			end

			local var_175_12 = 21
			local var_175_13 = 1.4
			local var_175_14 = arg_172_1:GetWordFromCfg(420191039)
			local var_175_15 = arg_172_1:FormatText(var_175_14.content)
			local var_175_16, var_175_17 = arg_172_1:GetPercentByPara(var_175_15, 2)

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				local var_175_18 = var_175_12 <= 0 and var_175_13 or var_175_13 * ((var_175_17 - arg_172_1.typewritterCharCountI18N) / var_175_12)

				if var_175_18 > 0 and var_175_13 < var_175_18 then
					arg_172_1.talkMaxDuration = var_175_18

					if var_175_18 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_11
					end
				end
			end

			local var_175_19 = 1.4
			local var_175_20 = math.max(var_175_19, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_20 then
				local var_175_21 = (arg_172_1.time_ - var_175_11) / var_175_20

				arg_172_1.fswtw_.percent = Mathf.Lerp(arg_172_1.var_.oldValueTypewriter, var_175_16, var_175_21)
				arg_172_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_172_1.fswtw_:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_20 and arg_172_1.time_ < var_175_11 + var_175_20 + arg_175_0 then
				arg_172_1.fswtw_.percent = var_175_16

				arg_172_1.fswtw_:SetDirty()
				arg_172_1:ShowNextGo(true)

				arg_172_1.typewritterCharCountI18N = var_175_17
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play420191042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 420191042
		arg_176_1.duration_ = 1.6

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play420191043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.var_.oldValueTypewriter = arg_176_1.fswtw_.percent

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_1 = 0
			local var_179_2 = -6.9
			local var_179_3 = arg_176_1:GetWordFromCfg(420191039)
			local var_179_4 = arg_176_1:FormatText(var_179_3.content)
			local var_179_5, var_179_6 = arg_176_1:GetPercentByPara(var_179_4, 4)

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				local var_179_7 = var_179_1 <= 0 and var_179_2 or var_179_2 * ((var_179_6 - arg_176_1.typewritterCharCountI18N) / var_179_1)

				if var_179_7 > 0 and var_179_2 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end
			end

			local var_179_8 = -6.9
			local var_179_9 = math.max(var_179_8, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_9 then
				local var_179_10 = (arg_176_1.time_ - var_179_0) / var_179_9

				arg_176_1.fswtw_.percent = Mathf.Lerp(arg_176_1.var_.oldValueTypewriter, var_179_5, var_179_10)
				arg_176_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_176_1.fswtw_:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_9 and arg_176_1.time_ < var_179_0 + var_179_9 + arg_179_0 then
				arg_176_1.fswtw_.percent = var_179_5

				arg_176_1.fswtw_:SetDirty()
				arg_176_1:ShowNextGo(true)

				arg_176_1.typewritterCharCountI18N = var_179_6
			end

			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.var_.oldValueTypewriter = arg_176_1.fswtw_.percent

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_12 = 24
			local var_179_13 = 1.6
			local var_179_14 = arg_176_1:GetWordFromCfg(420191039)
			local var_179_15 = arg_176_1:FormatText(var_179_14.content)
			local var_179_16, var_179_17 = arg_176_1:GetPercentByPara(var_179_15, 3)

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				local var_179_18 = var_179_12 <= 0 and var_179_13 or var_179_13 * ((var_179_17 - arg_176_1.typewritterCharCountI18N) / var_179_12)

				if var_179_18 > 0 and var_179_13 < var_179_18 then
					arg_176_1.talkMaxDuration = var_179_18

					if var_179_18 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_18 + var_179_11
					end
				end
			end

			local var_179_19 = 1.6
			local var_179_20 = math.max(var_179_19, arg_176_1.talkMaxDuration)

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_20 then
				local var_179_21 = (arg_176_1.time_ - var_179_11) / var_179_20

				arg_176_1.fswtw_.percent = Mathf.Lerp(arg_176_1.var_.oldValueTypewriter, var_179_16, var_179_21)
				arg_176_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_176_1.fswtw_:SetDirty()
			end

			if arg_176_1.time_ >= var_179_11 + var_179_20 and arg_176_1.time_ < var_179_11 + var_179_20 + arg_179_0 then
				arg_176_1.fswtw_.percent = var_179_16

				arg_176_1.fswtw_:SetDirty()
				arg_176_1:ShowNextGo(true)

				arg_176_1.typewritterCharCountI18N = var_179_17
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play420191043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 420191043
		arg_180_1.duration_ = 1.8

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play420191044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.var_.oldValueTypewriter = arg_180_1.fswtw_.percent

				SetActive(arg_180_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_180_1:ShowNextGo(false)
			end

			local var_183_1 = 0
			local var_183_2 = -6.9
			local var_183_3 = arg_180_1:GetWordFromCfg(420191039)
			local var_183_4 = arg_180_1:FormatText(var_183_3.content)
			local var_183_5, var_183_6 = arg_180_1:GetPercentByPara(var_183_4, 4)

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				local var_183_7 = var_183_1 <= 0 and var_183_2 or var_183_2 * ((var_183_6 - arg_180_1.typewritterCharCountI18N) / var_183_1)

				if var_183_7 > 0 and var_183_2 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end
			end

			local var_183_8 = -6.9
			local var_183_9 = math.max(var_183_8, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_9 then
				local var_183_10 = (arg_180_1.time_ - var_183_0) / var_183_9

				arg_180_1.fswtw_.percent = Mathf.Lerp(arg_180_1.var_.oldValueTypewriter, var_183_5, var_183_10)
				arg_180_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_180_1.fswtw_:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_9 and arg_180_1.time_ < var_183_0 + var_183_9 + arg_183_0 then
				arg_180_1.fswtw_.percent = var_183_5

				arg_180_1.fswtw_:SetDirty()
				arg_180_1:ShowNextGo(true)

				arg_180_1.typewritterCharCountI18N = var_183_6
			end

			local var_183_11 = 0

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1.var_.oldValueTypewriter = arg_180_1.fswtw_.percent

				SetActive(arg_180_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_180_1:ShowNextGo(false)
			end

			local var_183_12 = 27
			local var_183_13 = 1.8
			local var_183_14 = arg_180_1:GetWordFromCfg(420191039)
			local var_183_15 = arg_180_1:FormatText(var_183_14.content)
			local var_183_16, var_183_17 = arg_180_1:GetPercentByPara(var_183_15, 4)

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				local var_183_18 = var_183_12 <= 0 and var_183_13 or var_183_13 * ((var_183_17 - arg_180_1.typewritterCharCountI18N) / var_183_12)

				if var_183_18 > 0 and var_183_13 < var_183_18 then
					arg_180_1.talkMaxDuration = var_183_18

					if var_183_18 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_18 + var_183_11
					end
				end
			end

			local var_183_19 = 1.8
			local var_183_20 = math.max(var_183_19, arg_180_1.talkMaxDuration)

			if var_183_11 <= arg_180_1.time_ and arg_180_1.time_ < var_183_11 + var_183_20 then
				local var_183_21 = (arg_180_1.time_ - var_183_11) / var_183_20

				arg_180_1.fswtw_.percent = Mathf.Lerp(arg_180_1.var_.oldValueTypewriter, var_183_16, var_183_21)
				arg_180_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_180_1.fswtw_:SetDirty()
			end

			if arg_180_1.time_ >= var_183_11 + var_183_20 and arg_180_1.time_ < var_183_11 + var_183_20 + arg_183_0 then
				arg_180_1.fswtw_.percent = var_183_16

				arg_180_1.fswtw_:SetDirty()
				arg_180_1:ShowNextGo(true)

				arg_180_1.typewritterCharCountI18N = var_183_17
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play420191044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 420191044
		arg_184_1.duration_ = 1.13

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play420191045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_1 = 0
			local var_187_2 = -6.9
			local var_187_3 = arg_184_1:GetWordFromCfg(420191039)
			local var_187_4 = arg_184_1:FormatText(var_187_3.content)
			local var_187_5, var_187_6 = arg_184_1:GetPercentByPara(var_187_4, 4)

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_7 = var_187_1 <= 0 and var_187_2 or var_187_2 * ((var_187_6 - arg_184_1.typewritterCharCountI18N) / var_187_1)

				if var_187_7 > 0 and var_187_2 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end
			end

			local var_187_8 = -6.9
			local var_187_9 = math.max(var_187_8, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_9 then
				local var_187_10 = (arg_184_1.time_ - var_187_0) / var_187_9

				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_5, var_187_10)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_9 and arg_184_1.time_ < var_187_0 + var_187_9 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_5

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_6
			end

			local var_187_11 = 0

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_12 = 17
			local var_187_13 = 1.13333333333333
			local var_187_14 = arg_184_1:GetWordFromCfg(420191039)
			local var_187_15 = arg_184_1:FormatText(var_187_14.content)
			local var_187_16, var_187_17 = arg_184_1:GetPercentByPara(var_187_15, 5)

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_18 = var_187_12 <= 0 and var_187_13 or var_187_13 * ((var_187_17 - arg_184_1.typewritterCharCountI18N) / var_187_12)

				if var_187_18 > 0 and var_187_13 < var_187_18 then
					arg_184_1.talkMaxDuration = var_187_18

					if var_187_18 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_18 + var_187_11
					end
				end
			end

			local var_187_19 = 1.13333333333333
			local var_187_20 = math.max(var_187_19, arg_184_1.talkMaxDuration)

			if var_187_11 <= arg_184_1.time_ and arg_184_1.time_ < var_187_11 + var_187_20 then
				local var_187_21 = (arg_184_1.time_ - var_187_11) / var_187_20

				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_16, var_187_21)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= var_187_11 + var_187_20 and arg_184_1.time_ < var_187_11 + var_187_20 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_16

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_17
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play420191045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 420191045
		arg_188_1.duration_ = 1.53

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play420191046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.var_.oldValueTypewriter = arg_188_1.fswtw_.percent

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_1 = 0
			local var_191_2 = -6.9
			local var_191_3 = arg_188_1:GetWordFromCfg(420191039)
			local var_191_4 = arg_188_1:FormatText(var_191_3.content)
			local var_191_5, var_191_6 = arg_188_1:GetPercentByPara(var_191_4, 4)

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				local var_191_7 = var_191_1 <= 0 and var_191_2 or var_191_2 * ((var_191_6 - arg_188_1.typewritterCharCountI18N) / var_191_1)

				if var_191_7 > 0 and var_191_2 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end
			end

			local var_191_8 = -6.9
			local var_191_9 = math.max(var_191_8, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_9 then
				local var_191_10 = (arg_188_1.time_ - var_191_0) / var_191_9

				arg_188_1.fswtw_.percent = Mathf.Lerp(arg_188_1.var_.oldValueTypewriter, var_191_5, var_191_10)
				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_188_1.fswtw_:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_9 and arg_188_1.time_ < var_191_0 + var_191_9 + arg_191_0 then
				arg_188_1.fswtw_.percent = var_191_5

				arg_188_1.fswtw_:SetDirty()
				arg_188_1:ShowNextGo(true)

				arg_188_1.typewritterCharCountI18N = var_191_6
			end

			local var_191_11 = 0

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.var_.oldValueTypewriter = arg_188_1.fswtw_.percent

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_12 = 24
			local var_191_13 = 1.53333333333333
			local var_191_14 = arg_188_1:GetWordFromCfg(420191039)
			local var_191_15 = arg_188_1:FormatText(var_191_14.content)
			local var_191_16, var_191_17 = arg_188_1:GetPercentByPara(var_191_15, 6)

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				local var_191_18 = var_191_12 <= 0 and var_191_13 or var_191_13 * ((var_191_17 - arg_188_1.typewritterCharCountI18N) / var_191_12)

				if var_191_18 > 0 and var_191_13 < var_191_18 then
					arg_188_1.talkMaxDuration = var_191_18

					if var_191_18 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_11
					end
				end
			end

			local var_191_19 = 1.53333333333333
			local var_191_20 = math.max(var_191_19, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_20 then
				local var_191_21 = (arg_188_1.time_ - var_191_11) / var_191_20

				arg_188_1.fswtw_.percent = Mathf.Lerp(arg_188_1.var_.oldValueTypewriter, var_191_16, var_191_21)
				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_188_1.fswtw_:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_20 and arg_188_1.time_ < var_191_11 + var_191_20 + arg_191_0 then
				arg_188_1.fswtw_.percent = var_191_16

				arg_188_1.fswtw_:SetDirty()
				arg_188_1:ShowNextGo(true)

				arg_188_1.typewritterCharCountI18N = var_191_17
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play420191046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 420191046
		arg_192_1.duration_ = 1.05

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play420191047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.05
			local var_195_1 = 1

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				local var_195_2 = "play"
				local var_195_3 = "effect"

				arg_192_1:AudioAction(var_195_2, var_195_3, "se_story_140", "se_story_140_data04", "")
			end

			local var_195_4 = 0

			if var_195_4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.var_.oldValueTypewriter = arg_192_1.fswtw_.percent

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_5 = 0
			local var_195_6 = -6.9
			local var_195_7 = arg_192_1:GetWordFromCfg(420191039)
			local var_195_8 = arg_192_1:FormatText(var_195_7.content)
			local var_195_9, var_195_10 = arg_192_1:GetPercentByPara(var_195_8, 4)

			if var_195_4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				local var_195_11 = var_195_5 <= 0 and var_195_6 or var_195_6 * ((var_195_10 - arg_192_1.typewritterCharCountI18N) / var_195_5)

				if var_195_11 > 0 and var_195_6 < var_195_11 then
					arg_192_1.talkMaxDuration = var_195_11

					if var_195_11 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_4
					end
				end
			end

			local var_195_12 = -6.9
			local var_195_13 = math.max(var_195_12, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_13 then
				local var_195_14 = (arg_192_1.time_ - var_195_4) / var_195_13

				arg_192_1.fswtw_.percent = Mathf.Lerp(arg_192_1.var_.oldValueTypewriter, var_195_9, var_195_14)
				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_192_1.fswtw_:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_13 and arg_192_1.time_ < var_195_4 + var_195_13 + arg_195_0 then
				arg_192_1.fswtw_.percent = var_195_9

				arg_192_1.fswtw_:SetDirty()
				arg_192_1:ShowNextGo(true)

				arg_192_1.typewritterCharCountI18N = var_195_10
			end

			local var_195_15 = 0

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.var_.oldValueTypewriter = arg_192_1.fswtw_.percent

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_16 = 14
			local var_195_17 = 0.933333333333333
			local var_195_18 = arg_192_1:GetWordFromCfg(420191039)
			local var_195_19 = arg_192_1:FormatText(var_195_18.content)
			local var_195_20, var_195_21 = arg_192_1:GetPercentByPara(var_195_19, 7)

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				local var_195_22 = var_195_16 <= 0 and var_195_17 or var_195_17 * ((var_195_21 - arg_192_1.typewritterCharCountI18N) / var_195_16)

				if var_195_22 > 0 and var_195_17 < var_195_22 then
					arg_192_1.talkMaxDuration = var_195_22

					if var_195_22 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_22 + var_195_15
					end
				end
			end

			local var_195_23 = 0.933333333333333
			local var_195_24 = math.max(var_195_23, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_24 then
				local var_195_25 = (arg_192_1.time_ - var_195_15) / var_195_24

				arg_192_1.fswtw_.percent = Mathf.Lerp(arg_192_1.var_.oldValueTypewriter, var_195_20, var_195_25)
				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_192_1.fswtw_:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_24 and arg_192_1.time_ < var_195_15 + var_195_24 + arg_195_0 then
				arg_192_1.fswtw_.percent = var_195_20

				arg_192_1.fswtw_:SetDirty()
				arg_192_1:ShowNextGo(true)

				arg_192_1.typewritterCharCountI18N = var_195_21
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play420191047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 420191047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play420191048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.fswbg_:SetActive(false)
				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_1 = 0
			local var_199_2 = 0.675

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_3 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_4 = arg_196_1:GetWordFromCfg(420191047)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 27
				local var_199_7 = utf8.len(var_199_5)
				local var_199_8 = var_199_6 <= 0 and var_199_2 or var_199_2 * (var_199_7 / var_199_6)

				if var_199_8 > 0 and var_199_2 < var_199_8 then
					arg_196_1.talkMaxDuration = var_199_8

					if var_199_8 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_9 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_9 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_9

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_9 and arg_196_1.time_ < var_199_1 + var_199_9 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play420191048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 420191048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play420191049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.45

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(420191048)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 18
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_8 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_8 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_8

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_8 and arg_200_1.time_ < var_203_0 + var_203_8 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play420191049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 420191049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play420191050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.8

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[7].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(420191049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 32
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_8 and arg_204_1.time_ < var_207_0 + var_207_8 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play420191050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 420191050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play420191051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.2

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				local var_211_2 = "play"
				local var_211_3 = "music"

				arg_208_1:AudioAction(var_211_2, var_211_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_211_4 = ""
				local var_211_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_211_5 ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_5 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_5

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_5
						arg_208_1.bgmTxt2_.text = var_211_5
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_211_6 = 0
			local var_211_7 = 0.125

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_8 = arg_208_1:GetWordFromCfg(420191050)
				local var_211_9 = arg_208_1:FormatText(var_211_8.content)

				arg_208_1.text_.text = var_211_9

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 5
				local var_211_11 = utf8.len(var_211_9)
				local var_211_12 = var_211_10 <= 0 and var_211_7 or var_211_7 * (var_211_11 / var_211_10)

				if var_211_12 > 0 and var_211_7 < var_211_12 then
					arg_208_1.talkMaxDuration = var_211_12

					if var_211_12 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_12 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_9
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_13 and arg_208_1.time_ < var_211_6 + var_211_13 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play420191051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 420191051
		arg_213_1.duration_ = 8.9

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play420191052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = "L16I"

			if arg_213_1.bgs_[var_216_0] == nil then
				local var_216_1 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_216_0)
				var_216_1.name = var_216_0
				var_216_1.transform.parent = arg_213_1.stage_.transform
				var_216_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_[var_216_0] = var_216_1
			end

			local var_216_2 = 2

			if var_216_2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				local var_216_3 = manager.ui.mainCamera.transform.localPosition
				local var_216_4 = Vector3.New(0, 0, 10) + Vector3.New(var_216_3.x, var_216_3.y, 0)
				local var_216_5 = arg_213_1.bgs_.L16I

				var_216_5.transform.localPosition = var_216_4
				var_216_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_6 = var_216_5:GetComponent("SpriteRenderer")

				if var_216_6 and var_216_6.sprite then
					local var_216_7 = (var_216_5.transform.localPosition - var_216_3).z
					local var_216_8 = manager.ui.mainCameraCom_
					local var_216_9 = 2 * var_216_7 * Mathf.Tan(var_216_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_216_10 = var_216_9 * var_216_8.aspect
					local var_216_11 = var_216_6.sprite.bounds.size.x
					local var_216_12 = var_216_6.sprite.bounds.size.y
					local var_216_13 = var_216_10 / var_216_11
					local var_216_14 = var_216_9 / var_216_12
					local var_216_15 = var_216_14 < var_216_13 and var_216_13 or var_216_14

					var_216_5.transform.localScale = Vector3.New(var_216_15, var_216_15, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "L16I" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_16 = 4

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			local var_216_17 = 0.3

			if arg_213_1.time_ >= var_216_16 + var_216_17 and arg_213_1.time_ < var_216_16 + var_216_17 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_18 = 0

			if var_216_18 < arg_213_1.time_ and arg_213_1.time_ <= var_216_18 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_19 = 2

			if var_216_18 <= arg_213_1.time_ and arg_213_1.time_ < var_216_18 + var_216_19 then
				local var_216_20 = (arg_213_1.time_ - var_216_18) / var_216_19
				local var_216_21 = Color.New(0, 0, 0)

				var_216_21.a = Mathf.Lerp(0, 1, var_216_20)
				arg_213_1.mask_.color = var_216_21
			end

			if arg_213_1.time_ >= var_216_18 + var_216_19 and arg_213_1.time_ < var_216_18 + var_216_19 + arg_216_0 then
				local var_216_22 = Color.New(0, 0, 0)

				var_216_22.a = 1
				arg_213_1.mask_.color = var_216_22
			end

			local var_216_23 = 2

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_24 = 2

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_24 then
				local var_216_25 = (arg_213_1.time_ - var_216_23) / var_216_24
				local var_216_26 = Color.New(0, 0, 0)

				var_216_26.a = Mathf.Lerp(1, 0, var_216_25)
				arg_213_1.mask_.color = var_216_26
			end

			if arg_213_1.time_ >= var_216_23 + var_216_24 and arg_213_1.time_ < var_216_23 + var_216_24 + arg_216_0 then
				local var_216_27 = Color.New(0, 0, 0)
				local var_216_28 = 0

				arg_213_1.mask_.enabled = false
				var_216_27.a = var_216_28
				arg_213_1.mask_.color = var_216_27
			end

			local var_216_29 = "1056ui_story"

			if arg_213_1.actors_[var_216_29] == nil then
				local var_216_30 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_216_30) then
					local var_216_31 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_213_1.stage_.transform)

					var_216_31.name = var_216_29
					var_216_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_213_1.actors_[var_216_29] = var_216_31

					local var_216_32 = var_216_31:GetComponentInChildren(typeof(CharacterEffect))

					var_216_32.enabled = true

					local var_216_33 = GameObjectTools.GetOrAddComponent(var_216_31, typeof(DynamicBoneHelper))

					if var_216_33 then
						var_216_33:EnableDynamicBone(false)
					end

					arg_213_1:ShowWeapon(var_216_32.transform, false)

					arg_213_1.var_[var_216_29 .. "Animator"] = var_216_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_213_1.var_[var_216_29 .. "Animator"].applyRootMotion = true
					arg_213_1.var_[var_216_29 .. "LipSync"] = var_216_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_216_34 = arg_213_1.actors_["1056ui_story"].transform
			local var_216_35 = 3.9

			if var_216_35 < arg_213_1.time_ and arg_213_1.time_ <= var_216_35 + arg_216_0 then
				arg_213_1.var_.moveOldPos1056ui_story = var_216_34.localPosition
			end

			local var_216_36 = 0.001

			if var_216_35 <= arg_213_1.time_ and arg_213_1.time_ < var_216_35 + var_216_36 then
				local var_216_37 = (arg_213_1.time_ - var_216_35) / var_216_36
				local var_216_38 = Vector3.New(0, -1, -5.75)

				var_216_34.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1056ui_story, var_216_38, var_216_37)

				local var_216_39 = manager.ui.mainCamera.transform.position - var_216_34.position

				var_216_34.forward = Vector3.New(var_216_39.x, var_216_39.y, var_216_39.z)

				local var_216_40 = var_216_34.localEulerAngles

				var_216_40.z = 0
				var_216_40.x = 0
				var_216_34.localEulerAngles = var_216_40
			end

			if arg_213_1.time_ >= var_216_35 + var_216_36 and arg_213_1.time_ < var_216_35 + var_216_36 + arg_216_0 then
				var_216_34.localPosition = Vector3.New(0, -1, -5.75)

				local var_216_41 = manager.ui.mainCamera.transform.position - var_216_34.position

				var_216_34.forward = Vector3.New(var_216_41.x, var_216_41.y, var_216_41.z)

				local var_216_42 = var_216_34.localEulerAngles

				var_216_42.z = 0
				var_216_42.x = 0
				var_216_34.localEulerAngles = var_216_42
			end

			local var_216_43 = arg_213_1.actors_["1056ui_story"]
			local var_216_44 = 3.9

			if var_216_44 < arg_213_1.time_ and arg_213_1.time_ <= var_216_44 + arg_216_0 and not isNil(var_216_43) and arg_213_1.var_.characterEffect1056ui_story == nil then
				arg_213_1.var_.characterEffect1056ui_story = var_216_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_45 = 0.200000002980232

			if var_216_44 <= arg_213_1.time_ and arg_213_1.time_ < var_216_44 + var_216_45 and not isNil(var_216_43) then
				local var_216_46 = (arg_213_1.time_ - var_216_44) / var_216_45

				if arg_213_1.var_.characterEffect1056ui_story and not isNil(var_216_43) then
					arg_213_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_44 + var_216_45 and arg_213_1.time_ < var_216_44 + var_216_45 + arg_216_0 and not isNil(var_216_43) and arg_213_1.var_.characterEffect1056ui_story then
				arg_213_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_216_47 = 3.9

			if var_216_47 < arg_213_1.time_ and arg_213_1.time_ <= var_216_47 + arg_216_0 then
				arg_213_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_216_48 = 3.9

			if var_216_48 < arg_213_1.time_ and arg_213_1.time_ <= var_216_48 + arg_216_0 then
				arg_213_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_216_49 = arg_213_1.actors_["1056ui_story"]
			local var_216_50 = 3.9

			if var_216_50 < arg_213_1.time_ and arg_213_1.time_ <= var_216_50 + arg_216_0 then
				if arg_213_1.var_.characterEffect1056ui_story == nil then
					arg_213_1.var_.characterEffect1056ui_story = var_216_49:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_216_51 = arg_213_1.var_.characterEffect1056ui_story

				var_216_51.imageEffect:turnOff()

				var_216_51.interferenceEffect.enabled = true
				var_216_51.interferenceEffect.noise = 0.001
				var_216_51.interferenceEffect.simTimeScale = 1
				var_216_51.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_216_52 = arg_213_1.actors_["1056ui_story"]
			local var_216_53 = 3.9
			local var_216_54 = 5

			if var_216_53 < arg_213_1.time_ and arg_213_1.time_ <= var_216_53 + arg_216_0 then
				if arg_213_1.var_.characterEffect1056ui_story == nil then
					arg_213_1.var_.characterEffect1056ui_story = var_216_52:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_213_1.var_.characterEffect1056ui_story.imageEffect:turnOn(false)
			end

			local var_216_55 = 0
			local var_216_56 = 0.2

			if var_216_55 < arg_213_1.time_ and arg_213_1.time_ <= var_216_55 + arg_216_0 then
				local var_216_57 = "play"
				local var_216_58 = "music"

				arg_213_1:AudioAction(var_216_57, var_216_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_216_59 = ""
				local var_216_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_216_60 ~= "" then
					if arg_213_1.bgmTxt_.text ~= var_216_60 and arg_213_1.bgmTxt_.text ~= "" then
						if arg_213_1.bgmTxt2_.text ~= "" then
							arg_213_1.bgmTxt_.text = arg_213_1.bgmTxt2_.text
						end

						arg_213_1.bgmTxt2_.text = var_216_60

						arg_213_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_213_1.bgmTxt_.text = var_216_60
						arg_213_1.bgmTxt2_.text = var_216_60
					end

					if arg_213_1.bgmTimer then
						arg_213_1.bgmTimer:Stop()

						arg_213_1.bgmTimer = nil
					end

					if arg_213_1.settingData.show_music_name == 1 then
						arg_213_1.musicController:SetSelectedState("show")
						arg_213_1.musicAnimator_:Play("open", 0, 0)

						if arg_213_1.settingData.music_time ~= 0 then
							arg_213_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_213_1.settingData.music_time), function()
								if arg_213_1 == nil or isNil(arg_213_1.bgmTxt_) then
									return
								end

								arg_213_1.musicController:SetSelectedState("hide")
								arg_213_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_216_61 = 1.5
			local var_216_62 = 1

			if var_216_61 < arg_213_1.time_ and arg_213_1.time_ <= var_216_61 + arg_216_0 then
				local var_216_63 = "play"
				local var_216_64 = "music"

				arg_213_1:AudioAction(var_216_63, var_216_64, "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_216_65 = ""
				local var_216_66 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if var_216_66 ~= "" then
					if arg_213_1.bgmTxt_.text ~= var_216_66 and arg_213_1.bgmTxt_.text ~= "" then
						if arg_213_1.bgmTxt2_.text ~= "" then
							arg_213_1.bgmTxt_.text = arg_213_1.bgmTxt2_.text
						end

						arg_213_1.bgmTxt2_.text = var_216_66

						arg_213_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_213_1.bgmTxt_.text = var_216_66
						arg_213_1.bgmTxt2_.text = var_216_66
					end

					if arg_213_1.bgmTimer then
						arg_213_1.bgmTimer:Stop()

						arg_213_1.bgmTimer = nil
					end

					if arg_213_1.settingData.show_music_name == 1 then
						arg_213_1.musicController:SetSelectedState("show")
						arg_213_1.musicAnimator_:Play("open", 0, 0)

						if arg_213_1.settingData.music_time ~= 0 then
							arg_213_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_213_1.settingData.music_time), function()
								if arg_213_1 == nil or isNil(arg_213_1.bgmTxt_) then
									return
								end

								arg_213_1.musicController:SetSelectedState("hide")
								arg_213_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_216_67 = 1.5
			local var_216_68 = 1

			if var_216_67 < arg_213_1.time_ and arg_213_1.time_ <= var_216_67 + arg_216_0 then
				local var_216_69 = "play"
				local var_216_70 = "effect"

				arg_213_1:AudioAction(var_216_69, var_216_70, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_216_71 = 1.83333333333333

			if var_216_71 < arg_213_1.time_ and arg_213_1.time_ <= var_216_71 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(false)
				arg_213_1.dialog_:SetActive(false)
				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_213_1:ShowNextGo(false)
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_72 = 4
			local var_216_73 = 0.4

			if var_216_72 < arg_213_1.time_ and arg_213_1.time_ <= var_216_72 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_74 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_74:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_213_1.dialogCg_.alpha = arg_219_0
				end))
				var_216_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_75 = arg_213_1:FormatText(StoryNameCfg[605].name)

				arg_213_1.leftNameTxt_.text = var_216_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_76 = arg_213_1:GetWordFromCfg(420191051)
				local var_216_77 = arg_213_1:FormatText(var_216_76.content)

				arg_213_1.text_.text = var_216_77

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_78 = 16
				local var_216_79 = utf8.len(var_216_77)
				local var_216_80 = var_216_78 <= 0 and var_216_73 or var_216_73 * (var_216_79 / var_216_78)

				if var_216_80 > 0 and var_216_73 < var_216_80 then
					arg_213_1.talkMaxDuration = var_216_80
					var_216_72 = var_216_72 + 0.3

					if var_216_80 + var_216_72 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_80 + var_216_72
					end
				end

				arg_213_1.text_.text = var_216_77
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191051", "story_v_out_420191.awb") ~= 0 then
					local var_216_81 = manager.audio:GetVoiceLength("story_v_out_420191", "420191051", "story_v_out_420191.awb") / 1000

					if var_216_81 + var_216_72 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_81 + var_216_72
					end

					if var_216_76.prefab_name ~= "" and arg_213_1.actors_[var_216_76.prefab_name] ~= nil then
						local var_216_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_76.prefab_name].transform, "story_v_out_420191", "420191051", "story_v_out_420191.awb")

						arg_213_1:RecordAudio("420191051", var_216_82)
						arg_213_1:RecordAudio("420191051", var_216_82)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_420191", "420191051", "story_v_out_420191.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_420191", "420191051", "story_v_out_420191.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_83 = var_216_72 + 0.3
			local var_216_84 = math.max(var_216_73, arg_213_1.talkMaxDuration)

			if var_216_83 <= arg_213_1.time_ and arg_213_1.time_ < var_216_83 + var_216_84 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_83) / var_216_84

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_83 + var_216_84 and arg_213_1.time_ < var_216_83 + var_216_84 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play420191052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 420191052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play420191053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1056ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1056ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 then
				if arg_221_1.var_.characterEffect1056ui_story == nil then
					arg_221_1.var_.characterEffect1056ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_224_11 = arg_221_1.var_.characterEffect1056ui_story

				var_224_11.imageEffect:turnOff()

				var_224_11.interferenceEffect.enabled = false
				var_224_11.interferenceEffect.noise = 0.001
				var_224_11.interferenceEffect.simTimeScale = 1
				var_224_11.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_224_12 = arg_221_1.actors_["1056ui_story"]
			local var_224_13 = 0
			local var_224_14 = 0.034000001847744

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				if arg_221_1.var_.characterEffect1056ui_story == nil then
					arg_221_1.var_.characterEffect1056ui_story = var_224_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_221_1.var_.characterEffect1056ui_story.imageEffect:turnOff()
			end

			local var_224_15 = 0
			local var_224_16 = 1.1

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_17 = arg_221_1:GetWordFromCfg(420191052)
				local var_224_18 = arg_221_1:FormatText(var_224_17.content)

				arg_221_1.text_.text = var_224_18

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 44
				local var_224_20 = utf8.len(var_224_18)
				local var_224_21 = var_224_19 <= 0 and var_224_16 or var_224_16 * (var_224_20 / var_224_19)

				if var_224_21 > 0 and var_224_16 < var_224_21 then
					arg_221_1.talkMaxDuration = var_224_21

					if var_224_21 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_21 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_18
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_22 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_22

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_22 and arg_221_1.time_ < var_224_15 + var_224_22 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play420191053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 420191053
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play420191054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.35
			local var_228_1 = 1

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_2 = "play"
				local var_228_3 = "effect"

				arg_225_1:AudioAction(var_228_2, var_228_3, "se_story_140", "se_story_140_foley_down", "")
			end

			local var_228_4 = 0
			local var_228_5 = 0.35

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(420191053)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_8 = 14
				local var_228_9 = utf8.len(var_228_7)
				local var_228_10 = var_228_8 <= 0 and var_228_5 or var_228_5 * (var_228_9 / var_228_8)

				if var_228_10 > 0 and var_228_5 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_11 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_11 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_11

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_11 and arg_225_1.time_ < var_228_4 + var_228_11 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play420191054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 420191054
		arg_229_1.duration_ = 12.43

		local var_229_0 = {
			zh = 9.1,
			ja = 12.433
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play420191055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.1

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[1160].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(420191054)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 44
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191054", "story_v_out_420191.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191054", "story_v_out_420191.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_420191", "420191054", "story_v_out_420191.awb")

						arg_229_1:RecordAudio("420191054", var_232_9)
						arg_229_1:RecordAudio("420191054", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_420191", "420191054", "story_v_out_420191.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_420191", "420191054", "story_v_out_420191.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play420191055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 420191055
		arg_233_1.duration_ = 7.5

		local var_233_0 = {
			zh = 4.766,
			ja = 7.5
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play420191056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.525

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1160].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(420191055)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 21
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191055", "story_v_out_420191.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191055", "story_v_out_420191.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_420191", "420191055", "story_v_out_420191.awb")

						arg_233_1:RecordAudio("420191055", var_236_9)
						arg_233_1:RecordAudio("420191055", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_420191", "420191055", "story_v_out_420191.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_420191", "420191055", "story_v_out_420191.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play420191056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 420191056
		arg_237_1.duration_ = 10.5

		local var_237_0 = {
			zh = 6.366,
			ja = 10.5
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
				arg_237_0:Play420191057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1056ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1056ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, -1, -5.75)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1056ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1056ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1056ui_story == nil then
				arg_237_1.var_.characterEffect1056ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect1056ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1056ui_story then
				arg_237_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_240_14 = arg_237_1.actors_["1056ui_story"]
			local var_240_15 = 0

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				if arg_237_1.var_.characterEffect1056ui_story == nil then
					arg_237_1.var_.characterEffect1056ui_story = var_240_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_240_16 = arg_237_1.var_.characterEffect1056ui_story

				var_240_16.imageEffect:turnOff()

				var_240_16.interferenceEffect.enabled = false
				var_240_16.interferenceEffect.noise = 0.001
				var_240_16.interferenceEffect.simTimeScale = 1
				var_240_16.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_240_17 = arg_237_1.actors_["1056ui_story"]
			local var_240_18 = 0
			local var_240_19 = 5

			if var_240_18 < arg_237_1.time_ and arg_237_1.time_ <= var_240_18 + arg_240_0 then
				if arg_237_1.var_.characterEffect1056ui_story == nil then
					arg_237_1.var_.characterEffect1056ui_story = var_240_17:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_237_1.var_.characterEffect1056ui_story.imageEffect:turnOff()
			end

			local var_240_20 = 0
			local var_240_21 = 0.8

			if var_240_20 < arg_237_1.time_ and arg_237_1.time_ <= var_240_20 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_22 = arg_237_1:FormatText(StoryNameCfg[605].name)

				arg_237_1.leftNameTxt_.text = var_240_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_23 = arg_237_1:GetWordFromCfg(420191056)
				local var_240_24 = arg_237_1:FormatText(var_240_23.content)

				arg_237_1.text_.text = var_240_24

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_25 = 32
				local var_240_26 = utf8.len(var_240_24)
				local var_240_27 = var_240_25 <= 0 and var_240_21 or var_240_21 * (var_240_26 / var_240_25)

				if var_240_27 > 0 and var_240_21 < var_240_27 then
					arg_237_1.talkMaxDuration = var_240_27

					if var_240_27 + var_240_20 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_27 + var_240_20
					end
				end

				arg_237_1.text_.text = var_240_24
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191056", "story_v_out_420191.awb") ~= 0 then
					local var_240_28 = manager.audio:GetVoiceLength("story_v_out_420191", "420191056", "story_v_out_420191.awb") / 1000

					if var_240_28 + var_240_20 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_28 + var_240_20
					end

					if var_240_23.prefab_name ~= "" and arg_237_1.actors_[var_240_23.prefab_name] ~= nil then
						local var_240_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_23.prefab_name].transform, "story_v_out_420191", "420191056", "story_v_out_420191.awb")

						arg_237_1:RecordAudio("420191056", var_240_29)
						arg_237_1:RecordAudio("420191056", var_240_29)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_420191", "420191056", "story_v_out_420191.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_420191", "420191056", "story_v_out_420191.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_30 = math.max(var_240_21, arg_237_1.talkMaxDuration)

			if var_240_20 <= arg_237_1.time_ and arg_237_1.time_ < var_240_20 + var_240_30 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_20) / var_240_30

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_20 + var_240_30 and arg_237_1.time_ < var_240_20 + var_240_30 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play420191057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 420191057
		arg_241_1.duration_ = 8.87

		local var_241_0 = {
			zh = 6.533,
			ja = 8.866
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play420191058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1056ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1056ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1056ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = "10102ui_story"

			if arg_241_1.actors_[var_244_9] == nil then
				local var_244_10 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_244_10) then
					local var_244_11 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_241_1.stage_.transform)

					var_244_11.name = var_244_9
					var_244_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_241_1.actors_[var_244_9] = var_244_11

					local var_244_12 = var_244_11:GetComponentInChildren(typeof(CharacterEffect))

					var_244_12.enabled = true

					local var_244_13 = GameObjectTools.GetOrAddComponent(var_244_11, typeof(DynamicBoneHelper))

					if var_244_13 then
						var_244_13:EnableDynamicBone(false)
					end

					arg_241_1:ShowWeapon(var_244_12.transform, false)

					arg_241_1.var_[var_244_9 .. "Animator"] = var_244_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_241_1.var_[var_244_9 .. "Animator"].applyRootMotion = true
					arg_241_1.var_[var_244_9 .. "LipSync"] = var_244_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_244_14 = arg_241_1.actors_["10102ui_story"].transform
			local var_244_15 = 0

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.var_.moveOldPos10102ui_story = var_244_14.localPosition
			end

			local var_244_16 = 0.001

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_16 then
				local var_244_17 = (arg_241_1.time_ - var_244_15) / var_244_16
				local var_244_18 = Vector3.New(0, -0.985, -6.275)

				var_244_14.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10102ui_story, var_244_18, var_244_17)

				local var_244_19 = manager.ui.mainCamera.transform.position - var_244_14.position

				var_244_14.forward = Vector3.New(var_244_19.x, var_244_19.y, var_244_19.z)

				local var_244_20 = var_244_14.localEulerAngles

				var_244_20.z = 0
				var_244_20.x = 0
				var_244_14.localEulerAngles = var_244_20
			end

			if arg_241_1.time_ >= var_244_15 + var_244_16 and arg_241_1.time_ < var_244_15 + var_244_16 + arg_244_0 then
				var_244_14.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_244_21 = manager.ui.mainCamera.transform.position - var_244_14.position

				var_244_14.forward = Vector3.New(var_244_21.x, var_244_21.y, var_244_21.z)

				local var_244_22 = var_244_14.localEulerAngles

				var_244_22.z = 0
				var_244_22.x = 0
				var_244_14.localEulerAngles = var_244_22
			end

			local var_244_23 = arg_241_1.actors_["10102ui_story"]
			local var_244_24 = 0

			if var_244_24 < arg_241_1.time_ and arg_241_1.time_ <= var_244_24 + arg_244_0 and not isNil(var_244_23) and arg_241_1.var_.characterEffect10102ui_story == nil then
				arg_241_1.var_.characterEffect10102ui_story = var_244_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_25 = 0.200000002980232

			if var_244_24 <= arg_241_1.time_ and arg_241_1.time_ < var_244_24 + var_244_25 and not isNil(var_244_23) then
				local var_244_26 = (arg_241_1.time_ - var_244_24) / var_244_25

				if arg_241_1.var_.characterEffect10102ui_story and not isNil(var_244_23) then
					arg_241_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_24 + var_244_25 and arg_241_1.time_ < var_244_24 + var_244_25 + arg_244_0 and not isNil(var_244_23) and arg_241_1.var_.characterEffect10102ui_story then
				arg_241_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_244_27 = 0

			if var_244_27 < arg_241_1.time_ and arg_241_1.time_ <= var_244_27 + arg_244_0 then
				arg_241_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_244_28 = 0

			if var_244_28 < arg_241_1.time_ and arg_241_1.time_ <= var_244_28 + arg_244_0 then
				arg_241_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_29 = 0
			local var_244_30 = 0.825

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_31 = arg_241_1:FormatText(StoryNameCfg[6].name)

				arg_241_1.leftNameTxt_.text = var_244_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_32 = arg_241_1:GetWordFromCfg(420191057)
				local var_244_33 = arg_241_1:FormatText(var_244_32.content)

				arg_241_1.text_.text = var_244_33

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_34 = 33
				local var_244_35 = utf8.len(var_244_33)
				local var_244_36 = var_244_34 <= 0 and var_244_30 or var_244_30 * (var_244_35 / var_244_34)

				if var_244_36 > 0 and var_244_30 < var_244_36 then
					arg_241_1.talkMaxDuration = var_244_36

					if var_244_36 + var_244_29 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_36 + var_244_29
					end
				end

				arg_241_1.text_.text = var_244_33
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191057", "story_v_out_420191.awb") ~= 0 then
					local var_244_37 = manager.audio:GetVoiceLength("story_v_out_420191", "420191057", "story_v_out_420191.awb") / 1000

					if var_244_37 + var_244_29 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_37 + var_244_29
					end

					if var_244_32.prefab_name ~= "" and arg_241_1.actors_[var_244_32.prefab_name] ~= nil then
						local var_244_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_32.prefab_name].transform, "story_v_out_420191", "420191057", "story_v_out_420191.awb")

						arg_241_1:RecordAudio("420191057", var_244_38)
						arg_241_1:RecordAudio("420191057", var_244_38)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_420191", "420191057", "story_v_out_420191.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_420191", "420191057", "story_v_out_420191.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_39 = math.max(var_244_30, arg_241_1.talkMaxDuration)

			if var_244_29 <= arg_241_1.time_ and arg_241_1.time_ < var_244_29 + var_244_39 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_29) / var_244_39

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_29 + var_244_39 and arg_241_1.time_ < var_244_29 + var_244_39 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play420191058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 420191058
		arg_245_1.duration_ = 7.6

		local var_245_0 = {
			zh = 6.4,
			ja = 7.6
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
				arg_245_0:Play420191059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10102ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect10102ui_story == nil then
				arg_245_1.var_.characterEffect10102ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect10102ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10102ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect10102ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10102ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.625

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[1160].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_9 = arg_245_1:GetWordFromCfg(420191058)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 25
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191058", "story_v_out_420191.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_420191", "420191058", "story_v_out_420191.awb") / 1000

					if var_248_14 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_6
					end

					if var_248_9.prefab_name ~= "" and arg_245_1.actors_[var_248_9.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_9.prefab_name].transform, "story_v_out_420191", "420191058", "story_v_out_420191.awb")

						arg_245_1:RecordAudio("420191058", var_248_15)
						arg_245_1:RecordAudio("420191058", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_420191", "420191058", "story_v_out_420191.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_420191", "420191058", "story_v_out_420191.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_16 and arg_245_1.time_ < var_248_6 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play420191059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 420191059
		arg_249_1.duration_ = 7.97

		local var_249_0 = {
			zh = 6.733,
			ja = 7.966
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play420191060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.875

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[1160].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(420191059)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 35
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191059", "story_v_out_420191.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191059", "story_v_out_420191.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_420191", "420191059", "story_v_out_420191.awb")

						arg_249_1:RecordAudio("420191059", var_252_9)
						arg_249_1:RecordAudio("420191059", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_420191", "420191059", "story_v_out_420191.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_420191", "420191059", "story_v_out_420191.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play420191060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 420191060
		arg_253_1.duration_ = 6.8

		local var_253_0 = {
			zh = 6.233,
			ja = 6.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play420191061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.75

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[1160].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(420191060)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 30
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191060", "story_v_out_420191.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191060", "story_v_out_420191.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_420191", "420191060", "story_v_out_420191.awb")

						arg_253_1:RecordAudio("420191060", var_256_9)
						arg_253_1:RecordAudio("420191060", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_420191", "420191060", "story_v_out_420191.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_420191", "420191060", "story_v_out_420191.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play420191061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 420191061
		arg_257_1.duration_ = 3

		local var_257_0 = {
			zh = 2.533,
			ja = 3
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play420191062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10102ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10102ui_story == nil then
				arg_257_1.var_.characterEffect10102ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect10102ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10102ui_story then
				arg_257_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_260_4 = 0

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action452")
			end

			local var_260_6 = 0
			local var_260_7 = 0.175

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[6].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_9 = arg_257_1:GetWordFromCfg(420191061)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 7
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191061", "story_v_out_420191.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_420191", "420191061", "story_v_out_420191.awb") / 1000

					if var_260_14 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_6
					end

					if var_260_9.prefab_name ~= "" and arg_257_1.actors_[var_260_9.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_9.prefab_name].transform, "story_v_out_420191", "420191061", "story_v_out_420191.awb")

						arg_257_1:RecordAudio("420191061", var_260_15)
						arg_257_1:RecordAudio("420191061", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_420191", "420191061", "story_v_out_420191.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_420191", "420191061", "story_v_out_420191.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_16 and arg_257_1.time_ < var_260_6 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play420191062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 420191062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play420191063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10102ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10102ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, 100, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10102ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, 100, 0)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = 0
			local var_264_10 = 0.9

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_11 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_12 = arg_261_1:GetWordFromCfg(420191062)
				local var_264_13 = arg_261_1:FormatText(var_264_12.content)

				arg_261_1.text_.text = var_264_13

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_14 = 36
				local var_264_15 = utf8.len(var_264_13)
				local var_264_16 = var_264_14 <= 0 and var_264_10 or var_264_10 * (var_264_15 / var_264_14)

				if var_264_16 > 0 and var_264_10 < var_264_16 then
					arg_261_1.talkMaxDuration = var_264_16

					if var_264_16 + var_264_9 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_9
					end
				end

				arg_261_1.text_.text = var_264_13
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_17 = math.max(var_264_10, arg_261_1.talkMaxDuration)

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_17 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_9) / var_264_17

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_9 + var_264_17 and arg_261_1.time_ < var_264_9 + var_264_17 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play420191063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 420191063
		arg_265_1.duration_ = 2

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play420191064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1085ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1085ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, -1.01, -5.83)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1085ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1085ui_story"]
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1085ui_story == nil then
				arg_265_1.var_.characterEffect1085ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 and not isNil(var_268_9) then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11

				if arg_265_1.var_.characterEffect1085ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1085ui_story then
				arg_265_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_268_13 = 0

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_268_15 = 0
			local var_268_16 = 0.05

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[328].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(420191063)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 2
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_16 or var_268_16 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_16 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22

					if var_268_22 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191063", "story_v_out_420191.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_out_420191", "420191063", "story_v_out_420191.awb") / 1000

					if var_268_23 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_15
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_out_420191", "420191063", "story_v_out_420191.awb")

						arg_265_1:RecordAudio("420191063", var_268_24)
						arg_265_1:RecordAudio("420191063", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_420191", "420191063", "story_v_out_420191.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_420191", "420191063", "story_v_out_420191.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_25 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_25

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_25 and arg_265_1.time_ < var_268_15 + var_268_25 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420191064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 420191064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play420191065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1085ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1085ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1085ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, 100, 0)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = 0
			local var_272_10 = 0.575

			if var_272_9 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_11 = arg_269_1:GetWordFromCfg(420191064)
				local var_272_12 = arg_269_1:FormatText(var_272_11.content)

				arg_269_1.text_.text = var_272_12

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 23
				local var_272_14 = utf8.len(var_272_12)
				local var_272_15 = var_272_13 <= 0 and var_272_10 or var_272_10 * (var_272_14 / var_272_13)

				if var_272_15 > 0 and var_272_10 < var_272_15 then
					arg_269_1.talkMaxDuration = var_272_15

					if var_272_15 + var_272_9 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_9
					end
				end

				arg_269_1.text_.text = var_272_12
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_16 = math.max(var_272_10, arg_269_1.talkMaxDuration)

			if var_272_9 <= arg_269_1.time_ and arg_269_1.time_ < var_272_9 + var_272_16 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_9) / var_272_16

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_9 + var_272_16 and arg_269_1.time_ < var_272_9 + var_272_16 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420191065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 420191065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play420191066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.5
			local var_276_1 = 1

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				local var_276_2 = "play"
				local var_276_3 = "effect"

				arg_273_1:AudioAction(var_276_2, var_276_3, "se_story_side_1049", "se_story_side_1049_hug", "")
			end

			local var_276_4 = 0
			local var_276_5 = 0.825

			if var_276_4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(420191065)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_8 = 33
				local var_276_9 = utf8.len(var_276_7)
				local var_276_10 = var_276_8 <= 0 and var_276_5 or var_276_5 * (var_276_9 / var_276_8)

				if var_276_10 > 0 and var_276_5 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_11 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_11 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_11

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_11 and arg_273_1.time_ < var_276_4 + var_276_11 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play420191066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 420191066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play420191067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.775

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(420191066)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 31
				local var_280_5 = utf8.len(var_280_3)
				local var_280_6 = var_280_4 <= 0 and var_280_1 or var_280_1 * (var_280_5 / var_280_4)

				if var_280_6 > 0 and var_280_1 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_7 and arg_277_1.time_ < var_280_0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play420191067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 420191067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play420191068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.4

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(420191067)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 56
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play420191068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 420191068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play420191069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.275

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(420191068)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 11
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play420191069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 420191069
		arg_289_1.duration_ = 4.03

		local var_289_0 = {
			zh = 4.033,
			ja = 3.433
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
				arg_289_0:Play420191070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1085ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1085ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, -1.01, -5.83)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1085ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1085ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1085ui_story == nil then
				arg_289_1.var_.characterEffect1085ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect1085ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1085ui_story then
				arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_292_15 = 0
			local var_292_16 = 0.175

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[328].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(420191069)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 7
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191069", "story_v_out_420191.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_420191", "420191069", "story_v_out_420191.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_420191", "420191069", "story_v_out_420191.awb")

						arg_289_1:RecordAudio("420191069", var_292_24)
						arg_289_1:RecordAudio("420191069", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_420191", "420191069", "story_v_out_420191.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_420191", "420191069", "story_v_out_420191.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play420191070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 420191070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play420191071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1085ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1085ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, 100, 0)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1085ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, 100, 0)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = 0
			local var_296_10 = 1.55

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_11 = arg_293_1:GetWordFromCfg(420191070)
				local var_296_12 = arg_293_1:FormatText(var_296_11.content)

				arg_293_1.text_.text = var_296_12

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 62
				local var_296_14 = utf8.len(var_296_12)
				local var_296_15 = var_296_13 <= 0 and var_296_10 or var_296_10 * (var_296_14 / var_296_13)

				if var_296_15 > 0 and var_296_10 < var_296_15 then
					arg_293_1.talkMaxDuration = var_296_15

					if var_296_15 + var_296_9 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_15 + var_296_9
					end
				end

				arg_293_1.text_.text = var_296_12
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_10, arg_293_1.talkMaxDuration)

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_9) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_9 + var_296_16 and arg_293_1.time_ < var_296_9 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play420191071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 420191071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play420191072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.375

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(420191071)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 15
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
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
	Play420191072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 420191072
		arg_301_1.duration_ = 4.67

		local var_301_0 = {
			zh = 3.633,
			ja = 4.666
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
				arg_301_0:Play420191073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1085ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1085ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1085ui_story then
				arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_304_4 = arg_301_1.actors_["1085ui_story"].transform
			local var_304_5 = 0

			if var_304_5 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.var_.moveOldPos1085ui_story = var_304_4.localPosition
			end

			local var_304_6 = 0.001

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_6 then
				local var_304_7 = (arg_301_1.time_ - var_304_5) / var_304_6
				local var_304_8 = Vector3.New(0, -1.01, -5.83)

				var_304_4.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1085ui_story, var_304_8, var_304_7)

				local var_304_9 = manager.ui.mainCamera.transform.position - var_304_4.position

				var_304_4.forward = Vector3.New(var_304_9.x, var_304_9.y, var_304_9.z)

				local var_304_10 = var_304_4.localEulerAngles

				var_304_10.z = 0
				var_304_10.x = 0
				var_304_4.localEulerAngles = var_304_10
			end

			if arg_301_1.time_ >= var_304_5 + var_304_6 and arg_301_1.time_ < var_304_5 + var_304_6 + arg_304_0 then
				var_304_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_304_11 = manager.ui.mainCamera.transform.position - var_304_4.position

				var_304_4.forward = Vector3.New(var_304_11.x, var_304_11.y, var_304_11.z)

				local var_304_12 = var_304_4.localEulerAngles

				var_304_12.z = 0
				var_304_12.x = 0
				var_304_4.localEulerAngles = var_304_12
			end

			local var_304_13 = 0
			local var_304_14 = 0.25

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_15 = arg_301_1:FormatText(StoryNameCfg[328].name)

				arg_301_1.leftNameTxt_.text = var_304_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_16 = arg_301_1:GetWordFromCfg(420191072)
				local var_304_17 = arg_301_1:FormatText(var_304_16.content)

				arg_301_1.text_.text = var_304_17

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_18 = 10
				local var_304_19 = utf8.len(var_304_17)
				local var_304_20 = var_304_18 <= 0 and var_304_14 or var_304_14 * (var_304_19 / var_304_18)

				if var_304_20 > 0 and var_304_14 < var_304_20 then
					arg_301_1.talkMaxDuration = var_304_20

					if var_304_20 + var_304_13 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_20 + var_304_13
					end
				end

				arg_301_1.text_.text = var_304_17
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191072", "story_v_out_420191.awb") ~= 0 then
					local var_304_21 = manager.audio:GetVoiceLength("story_v_out_420191", "420191072", "story_v_out_420191.awb") / 1000

					if var_304_21 + var_304_13 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_21 + var_304_13
					end

					if var_304_16.prefab_name ~= "" and arg_301_1.actors_[var_304_16.prefab_name] ~= nil then
						local var_304_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_16.prefab_name].transform, "story_v_out_420191", "420191072", "story_v_out_420191.awb")

						arg_301_1:RecordAudio("420191072", var_304_22)
						arg_301_1:RecordAudio("420191072", var_304_22)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_420191", "420191072", "story_v_out_420191.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_420191", "420191072", "story_v_out_420191.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_23 = math.max(var_304_14, arg_301_1.talkMaxDuration)

			if var_304_13 <= arg_301_1.time_ and arg_301_1.time_ < var_304_13 + var_304_23 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_13) / var_304_23

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_13 + var_304_23 and arg_301_1.time_ < var_304_13 + var_304_23 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play420191073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 420191073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play420191074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1085ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1085ui_story == nil then
				arg_305_1.var_.characterEffect1085ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1085ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1085ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1085ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1085ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.25

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(420191073)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 10
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
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play420191074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 420191074
		arg_309_1.duration_ = 14.6

		local var_309_0 = {
			zh = 10.266,
			ja = 14.6
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play420191075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1085ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1085ui_story == nil then
				arg_309_1.var_.characterEffect1085ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1085ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1085ui_story then
				arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_312_4 = 0
			local var_312_5 = 0.95

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_6 = arg_309_1:FormatText(StoryNameCfg[328].name)

				arg_309_1.leftNameTxt_.text = var_312_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(420191074)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 38
				local var_312_10 = utf8.len(var_312_8)
				local var_312_11 = var_312_9 <= 0 and var_312_5 or var_312_5 * (var_312_10 / var_312_9)

				if var_312_11 > 0 and var_312_5 < var_312_11 then
					arg_309_1.talkMaxDuration = var_312_11

					if var_312_11 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191074", "story_v_out_420191.awb") ~= 0 then
					local var_312_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191074", "story_v_out_420191.awb") / 1000

					if var_312_12 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_12 + var_312_4
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_420191", "420191074", "story_v_out_420191.awb")

						arg_309_1:RecordAudio("420191074", var_312_13)
						arg_309_1:RecordAudio("420191074", var_312_13)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_420191", "420191074", "story_v_out_420191.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_420191", "420191074", "story_v_out_420191.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_14 and arg_309_1.time_ < var_312_4 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play420191075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 420191075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play420191076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1085ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1085ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, 100, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1085ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, 100, 0)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = 0
			local var_316_10 = 0.875

			if var_316_9 < arg_313_1.time_ and arg_313_1.time_ <= var_316_9 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_11 = arg_313_1:GetWordFromCfg(420191075)
				local var_316_12 = arg_313_1:FormatText(var_316_11.content)

				arg_313_1.text_.text = var_316_12

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 35
				local var_316_14 = utf8.len(var_316_12)
				local var_316_15 = var_316_13 <= 0 and var_316_10 or var_316_10 * (var_316_14 / var_316_13)

				if var_316_15 > 0 and var_316_10 < var_316_15 then
					arg_313_1.talkMaxDuration = var_316_15

					if var_316_15 + var_316_9 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_15 + var_316_9
					end
				end

				arg_313_1.text_.text = var_316_12
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_10, arg_313_1.talkMaxDuration)

			if var_316_9 <= arg_313_1.time_ and arg_313_1.time_ < var_316_9 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_9) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_9 + var_316_16 and arg_313_1.time_ < var_316_9 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420191076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 420191076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play420191077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.025

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(420191076)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 41
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play420191077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 420191077
		arg_321_1.duration_ = 12.53

		local var_321_0 = {
			zh = 7.566,
			ja = 12.533
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play420191078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1085ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1085ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, -1.01, -5.83)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1085ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1085ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1085ui_story == nil then
				arg_321_1.var_.characterEffect1085ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1085ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1085ui_story then
				arg_321_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_324_15 = 0
			local var_324_16 = 0.575

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[328].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(420191077)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 23
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191077", "story_v_out_420191.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_420191", "420191077", "story_v_out_420191.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_420191", "420191077", "story_v_out_420191.awb")

						arg_321_1:RecordAudio("420191077", var_324_24)
						arg_321_1:RecordAudio("420191077", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_420191", "420191077", "story_v_out_420191.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_420191", "420191077", "story_v_out_420191.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play420191078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 420191078
		arg_325_1.duration_ = 9.1

		local var_325_0 = {
			zh = 8.466,
			ja = 9.1
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
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play420191079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.75

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[328].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:GetWordFromCfg(420191078)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 30
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191078", "story_v_out_420191.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191078", "story_v_out_420191.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_420191", "420191078", "story_v_out_420191.awb")

						arg_325_1:RecordAudio("420191078", var_328_9)
						arg_325_1:RecordAudio("420191078", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_420191", "420191078", "story_v_out_420191.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_420191", "420191078", "story_v_out_420191.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play420191079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 420191079
		arg_329_1.duration_ = 6.3

		local var_329_0 = {
			zh = 5.433,
			ja = 6.3
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play420191080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.45

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[328].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:GetWordFromCfg(420191079)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 18
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191079", "story_v_out_420191.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191079", "story_v_out_420191.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_out_420191", "420191079", "story_v_out_420191.awb")

						arg_329_1:RecordAudio("420191079", var_332_9)
						arg_329_1:RecordAudio("420191079", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_420191", "420191079", "story_v_out_420191.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_420191", "420191079", "story_v_out_420191.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_10 and arg_329_1.time_ < var_332_0 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play420191080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 420191080
		arg_333_1.duration_ = 1

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"

			SetActive(arg_333_1.choicesGo_, true)

			for iter_334_0, iter_334_1 in ipairs(arg_333_1.choices_) do
				local var_334_0 = iter_334_0 <= 1

				SetActive(iter_334_1.go, var_334_0)
			end

			arg_333_1.choices_[1].txt.text = arg_333_1:FormatText(StoryChoiceCfg[1239].name)
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play420191081(arg_333_1)
			end

			arg_333_1:RecordChoiceLog(420191080, 1239)
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1085ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1085ui_story == nil then
				arg_333_1.var_.characterEffect1085ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1085ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1085ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1085ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1085ui_story.fillRatio = var_336_5
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play420191081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 420191081
		arg_337_1.duration_ = 14.63

		local var_337_0 = {
			zh = 14.633,
			ja = 10.033
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play420191082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1085ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1085ui_story == nil then
				arg_337_1.var_.characterEffect1085ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1085ui_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1085ui_story then
				arg_337_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_340_4 = 0

			if var_340_4 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_340_5 = 0
			local var_340_6 = 1

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_7 = arg_337_1:FormatText(StoryNameCfg[328].name)

				arg_337_1.leftNameTxt_.text = var_340_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_8 = arg_337_1:GetWordFromCfg(420191081)
				local var_340_9 = arg_337_1:FormatText(var_340_8.content)

				arg_337_1.text_.text = var_340_9

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 40
				local var_340_11 = utf8.len(var_340_9)
				local var_340_12 = var_340_10 <= 0 and var_340_6 or var_340_6 * (var_340_11 / var_340_10)

				if var_340_12 > 0 and var_340_6 < var_340_12 then
					arg_337_1.talkMaxDuration = var_340_12

					if var_340_12 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_12 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_9
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191081", "story_v_out_420191.awb") ~= 0 then
					local var_340_13 = manager.audio:GetVoiceLength("story_v_out_420191", "420191081", "story_v_out_420191.awb") / 1000

					if var_340_13 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_5
					end

					if var_340_8.prefab_name ~= "" and arg_337_1.actors_[var_340_8.prefab_name] ~= nil then
						local var_340_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_8.prefab_name].transform, "story_v_out_420191", "420191081", "story_v_out_420191.awb")

						arg_337_1:RecordAudio("420191081", var_340_14)
						arg_337_1:RecordAudio("420191081", var_340_14)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_420191", "420191081", "story_v_out_420191.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_420191", "420191081", "story_v_out_420191.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_15 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_15 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_15

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_15 and arg_337_1.time_ < var_340_5 + var_340_15 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play420191082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 420191082
		arg_341_1.duration_ = 10.03

		local var_341_0 = {
			zh = 10.033,
			ja = 8.3
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play420191083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.8

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[328].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(420191082)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 32
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191082", "story_v_out_420191.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191082", "story_v_out_420191.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_420191", "420191082", "story_v_out_420191.awb")

						arg_341_1:RecordAudio("420191082", var_344_9)
						arg_341_1:RecordAudio("420191082", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_420191", "420191082", "story_v_out_420191.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_420191", "420191082", "story_v_out_420191.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play420191083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 420191083
		arg_345_1.duration_ = 7.07

		local var_345_0 = {
			zh = 5.766,
			ja = 7.066
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play420191084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action429")
			end

			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_348_2 = 0
			local var_348_3 = 0.375

			if var_348_2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_4 = arg_345_1:FormatText(StoryNameCfg[328].name)

				arg_345_1.leftNameTxt_.text = var_348_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_5 = arg_345_1:GetWordFromCfg(420191083)
				local var_348_6 = arg_345_1:FormatText(var_348_5.content)

				arg_345_1.text_.text = var_348_6

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 15
				local var_348_8 = utf8.len(var_348_6)
				local var_348_9 = var_348_7 <= 0 and var_348_3 or var_348_3 * (var_348_8 / var_348_7)

				if var_348_9 > 0 and var_348_3 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_6
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191083", "story_v_out_420191.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191083", "story_v_out_420191.awb") / 1000

					if var_348_10 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_2
					end

					if var_348_5.prefab_name ~= "" and arg_345_1.actors_[var_348_5.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_5.prefab_name].transform, "story_v_out_420191", "420191083", "story_v_out_420191.awb")

						arg_345_1:RecordAudio("420191083", var_348_11)
						arg_345_1:RecordAudio("420191083", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_420191", "420191083", "story_v_out_420191.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_420191", "420191083", "story_v_out_420191.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_12 and arg_345_1.time_ < var_348_2 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play420191084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 420191084
		arg_349_1.duration_ = 5.03

		local var_349_0 = {
			zh = 5.033,
			ja = 4.1
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play420191085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.325

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[328].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:GetWordFromCfg(420191084)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 13
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191084", "story_v_out_420191.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191084", "story_v_out_420191.awb") / 1000

					if var_352_8 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_0
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_out_420191", "420191084", "story_v_out_420191.awb")

						arg_349_1:RecordAudio("420191084", var_352_9)
						arg_349_1:RecordAudio("420191084", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_420191", "420191084", "story_v_out_420191.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_420191", "420191084", "story_v_out_420191.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_10 and arg_349_1.time_ < var_352_0 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play420191085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 420191085
		arg_353_1.duration_ = 1

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"

			SetActive(arg_353_1.choicesGo_, true)

			for iter_354_0, iter_354_1 in ipairs(arg_353_1.choices_) do
				local var_354_0 = iter_354_0 <= 1

				SetActive(iter_354_1.go, var_354_0)
			end

			arg_353_1.choices_[1].txt.text = arg_353_1:FormatText(StoryChoiceCfg[1240].name)
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play420191086(arg_353_1)
			end

			arg_353_1:RecordChoiceLog(420191085, 1240)
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			return
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play420191086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 420191086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play420191087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1085ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1085ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1085ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = 0
			local var_360_10 = 1

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 then
				local var_360_11 = "play"
				local var_360_12 = "effect"

				arg_357_1:AudioAction(var_360_11, var_360_12, "se_story_140", "se_story_140_hug02", "")
			end

			local var_360_13 = 0
			local var_360_14 = 0.775

			if var_360_13 < arg_357_1.time_ and arg_357_1.time_ <= var_360_13 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_15 = arg_357_1:GetWordFromCfg(420191086)
				local var_360_16 = arg_357_1:FormatText(var_360_15.content)

				arg_357_1.text_.text = var_360_16

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_17 = 31
				local var_360_18 = utf8.len(var_360_16)
				local var_360_19 = var_360_17 <= 0 and var_360_14 or var_360_14 * (var_360_18 / var_360_17)

				if var_360_19 > 0 and var_360_14 < var_360_19 then
					arg_357_1.talkMaxDuration = var_360_19

					if var_360_19 + var_360_13 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_19 + var_360_13
					end
				end

				arg_357_1.text_.text = var_360_16
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_20 = math.max(var_360_14, arg_357_1.talkMaxDuration)

			if var_360_13 <= arg_357_1.time_ and arg_357_1.time_ < var_360_13 + var_360_20 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_13) / var_360_20

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_13 + var_360_20 and arg_357_1.time_ < var_360_13 + var_360_20 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play420191087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 420191087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play420191088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.5

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_2 = arg_361_1:GetWordFromCfg(420191087)
				local var_364_3 = arg_361_1:FormatText(var_364_2.content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 20
				local var_364_5 = utf8.len(var_364_3)
				local var_364_6 = var_364_4 <= 0 and var_364_1 or var_364_1 * (var_364_5 / var_364_4)

				if var_364_6 > 0 and var_364_1 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_7 and arg_361_1.time_ < var_364_0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play420191088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 420191088
		arg_365_1.duration_ = 1

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"

			SetActive(arg_365_1.choicesGo_, true)

			for iter_366_0, iter_366_1 in ipairs(arg_365_1.choices_) do
				local var_366_0 = iter_366_0 <= 1

				SetActive(iter_366_1.go, var_366_0)
			end

			arg_365_1.choices_[1].txt.text = arg_365_1:FormatText(StoryChoiceCfg[1241].name)
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play420191089(arg_365_1)
			end

			arg_365_1:RecordChoiceLog(420191088, 1241)
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			return
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play420191089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 420191089
		arg_369_1.duration_ = 2

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play420191090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.cswbg_:SetActive(true)

				local var_372_1 = arg_369_1.cswt_:GetComponent("RectTransform")

				arg_369_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_372_1.offsetMin = Vector2.New(0, 0)
				var_372_1.offsetMax = Vector2.New(0, 130)

				local var_372_2 = arg_369_1:GetWordFromCfg(420191089)
				local var_372_3 = arg_369_1:FormatText(var_372_2.content)

				arg_369_1.cswt_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.cswt_)

				arg_369_1.cswt_.fontSize = 120
				arg_369_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_369_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_369_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_372_4 = 0

			if var_372_4 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_5 = 2

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_5 then
				local var_372_6 = (arg_369_1.time_ - var_372_4) / var_372_5
				local var_372_7 = Color.New(0, 0, 0)

				var_372_7.a = Mathf.Lerp(1, 0, var_372_6)
				arg_369_1.mask_.color = var_372_7
			end

			if arg_369_1.time_ >= var_372_4 + var_372_5 and arg_369_1.time_ < var_372_4 + var_372_5 + arg_372_0 then
				local var_372_8 = Color.New(0, 0, 0)
				local var_372_9 = 0

				arg_369_1.mask_.enabled = false
				var_372_8.a = var_372_9
				arg_369_1.mask_.color = var_372_8
			end

			local var_372_10 = 0

			if var_372_10 < arg_369_1.time_ and arg_369_1.time_ <= var_372_10 + arg_372_0 then
				local var_372_11 = manager.ui.mainCamera.transform.localPosition
				local var_372_12 = Vector3.New(0, 0, 10) + Vector3.New(var_372_11.x, var_372_11.y, 0)
				local var_372_13 = arg_369_1.bgs_.STblack

				var_372_13.transform.localPosition = var_372_12
				var_372_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_14 = var_372_13:GetComponent("SpriteRenderer")

				if var_372_14 and var_372_14.sprite then
					local var_372_15 = (var_372_13.transform.localPosition - var_372_11).z
					local var_372_16 = manager.ui.mainCameraCom_
					local var_372_17 = 2 * var_372_15 * Mathf.Tan(var_372_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_372_18 = var_372_17 * var_372_16.aspect
					local var_372_19 = var_372_14.sprite.bounds.size.x
					local var_372_20 = var_372_14.sprite.bounds.size.y
					local var_372_21 = var_372_18 / var_372_19
					local var_372_22 = var_372_17 / var_372_20
					local var_372_23 = var_372_22 < var_372_21 and var_372_21 or var_372_22

					var_372_13.transform.localScale = Vector3.New(var_372_23, var_372_23, 0)
				end

				for iter_372_0, iter_372_1 in pairs(arg_369_1.bgs_) do
					if iter_372_0 ~= "STblack" then
						iter_372_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_372_24 = 0

			if var_372_24 < arg_369_1.time_ and arg_369_1.time_ <= var_372_24 + arg_372_0 then
				arg_369_1.fswbg_:SetActive(false)
				arg_369_1.dialog_:SetActive(false)
				SetActive(arg_369_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_369_1:ShowNextGo(false)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play420191090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 420191090
		arg_373_1.duration_ = 2

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play420191091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.cswbg_:SetActive(true)

				local var_376_1 = arg_373_1.cswt_:GetComponent("RectTransform")

				arg_373_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_376_1.offsetMin = Vector2.New(0, 0)
				var_376_1.offsetMax = Vector2.New(0, 130)

				local var_376_2 = arg_373_1:GetWordFromCfg(420191090)
				local var_376_3 = arg_373_1:FormatText(var_376_2.content)

				arg_373_1.cswt_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.cswt_)

				arg_373_1.cswt_.fontSize = 120
				arg_373_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_373_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_373_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play420191091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 420191091
		arg_377_1.duration_ = 2

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play420191092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.cswbg_:SetActive(true)

				local var_380_1 = arg_377_1.cswt_:GetComponent("RectTransform")

				arg_377_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_380_1.offsetMin = Vector2.New(0, 0)
				var_380_1.offsetMax = Vector2.New(0, 130)

				local var_380_2 = arg_377_1:GetWordFromCfg(420191091)
				local var_380_3 = arg_377_1:FormatText(var_380_2.content)

				arg_377_1.cswt_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.cswt_)

				arg_377_1.cswt_.fontSize = 108
				arg_377_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_377_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_377_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play420191092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 420191092
		arg_381_1.duration_ = 6

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play420191093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.cswbg_:SetActive(false)
			end

			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.mask_.enabled = true
				arg_381_1.mask_.raycastTarget = true

				arg_381_1:SetGaussion(false)
			end

			local var_384_2 = 1

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2
				local var_384_4 = Color.New(0, 0, 0)

				var_384_4.a = Mathf.Lerp(1, 0, var_384_3)
				arg_381_1.mask_.color = var_384_4
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 then
				local var_384_5 = Color.New(0, 0, 0)
				local var_384_6 = 0

				arg_381_1.mask_.enabled = false
				var_384_5.a = var_384_6
				arg_381_1.mask_.color = var_384_5
			end

			local var_384_7 = 0

			if var_384_7 < arg_381_1.time_ and arg_381_1.time_ <= var_384_7 + arg_384_0 then
				local var_384_8 = manager.ui.mainCamera.transform.localPosition
				local var_384_9 = Vector3.New(0, 0, 10) + Vector3.New(var_384_8.x, var_384_8.y, 0)
				local var_384_10 = arg_381_1.bgs_.L16I

				var_384_10.transform.localPosition = var_384_9
				var_384_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_384_11 = var_384_10:GetComponent("SpriteRenderer")

				if var_384_11 and var_384_11.sprite then
					local var_384_12 = (var_384_10.transform.localPosition - var_384_8).z
					local var_384_13 = manager.ui.mainCameraCom_
					local var_384_14 = 2 * var_384_12 * Mathf.Tan(var_384_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_384_15 = var_384_14 * var_384_13.aspect
					local var_384_16 = var_384_11.sprite.bounds.size.x
					local var_384_17 = var_384_11.sprite.bounds.size.y
					local var_384_18 = var_384_15 / var_384_16
					local var_384_19 = var_384_14 / var_384_17
					local var_384_20 = var_384_19 < var_384_18 and var_384_18 or var_384_19

					var_384_10.transform.localScale = Vector3.New(var_384_20, var_384_20, 0)
				end

				for iter_384_0, iter_384_1 in pairs(arg_381_1.bgs_) do
					if iter_384_0 ~= "L16I" then
						iter_384_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_381_1.frameCnt_ <= 1 then
				arg_381_1.dialog_:SetActive(false)
			end

			local var_384_21 = 1
			local var_384_22 = 0.525

			if var_384_21 < arg_381_1.time_ and arg_381_1.time_ <= var_384_21 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0

				arg_381_1.dialog_:SetActive(true)

				arg_381_1.dialogCg_.alpha = 0

				local var_384_23 = LeanTween.value(arg_381_1.dialog_, 0, 1, 0.3)

				var_384_23:setOnUpdate(LuaHelper.FloatAction(function(arg_385_0)
					arg_381_1.dialogCg_.alpha = arg_385_0
				end))
				var_384_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_381_1.dialog_)
					var_384_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_381_1.duration_ = arg_381_1.duration_ + 0.3

				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_24 = arg_381_1:GetWordFromCfg(420191092)
				local var_384_25 = arg_381_1:FormatText(var_384_24.content)

				arg_381_1.text_.text = var_384_25

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_26 = 21
				local var_384_27 = utf8.len(var_384_25)
				local var_384_28 = var_384_26 <= 0 and var_384_22 or var_384_22 * (var_384_27 / var_384_26)

				if var_384_28 > 0 and var_384_22 < var_384_28 then
					arg_381_1.talkMaxDuration = var_384_28
					var_384_21 = var_384_21 + 0.3

					if var_384_28 + var_384_21 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_28 + var_384_21
					end
				end

				arg_381_1.text_.text = var_384_25
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_29 = var_384_21 + 0.3
			local var_384_30 = math.max(var_384_22, arg_381_1.talkMaxDuration)

			if var_384_29 <= arg_381_1.time_ and arg_381_1.time_ < var_384_29 + var_384_30 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_29) / var_384_30

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_29 + var_384_30 and arg_381_1.time_ < var_384_29 + var_384_30 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play420191093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 420191093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play420191094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.725

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(420191093)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 29
				local var_390_5 = utf8.len(var_390_3)
				local var_390_6 = var_390_4 <= 0 and var_390_1 or var_390_1 * (var_390_5 / var_390_4)

				if var_390_6 > 0 and var_390_1 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_7 and arg_387_1.time_ < var_390_0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play420191094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 420191094
		arg_391_1.duration_ = 4.1

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play420191095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 1.05

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				local var_394_1 = manager.ui.mainCamera.transform.localPosition
				local var_394_2 = Vector3.New(0, 0, 10) + Vector3.New(var_394_1.x, var_394_1.y, 0)
				local var_394_3 = arg_391_1.bgs_.STblack

				var_394_3.transform.localPosition = var_394_2
				var_394_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_394_4 = var_394_3:GetComponent("SpriteRenderer")

				if var_394_4 and var_394_4.sprite then
					local var_394_5 = (var_394_3.transform.localPosition - var_394_1).z
					local var_394_6 = manager.ui.mainCameraCom_
					local var_394_7 = 2 * var_394_5 * Mathf.Tan(var_394_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_394_8 = var_394_7 * var_394_6.aspect
					local var_394_9 = var_394_4.sprite.bounds.size.x
					local var_394_10 = var_394_4.sprite.bounds.size.y
					local var_394_11 = var_394_8 / var_394_9
					local var_394_12 = var_394_7 / var_394_10
					local var_394_13 = var_394_12 < var_394_11 and var_394_11 or var_394_12

					var_394_3.transform.localScale = Vector3.New(var_394_13, var_394_13, 0)
				end

				for iter_394_0, iter_394_1 in pairs(arg_391_1.bgs_) do
					if iter_394_0 ~= "STblack" then
						iter_394_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_15 = 1.05

			if var_394_14 <= arg_391_1.time_ and arg_391_1.time_ < var_394_14 + var_394_15 then
				local var_394_16 = (arg_391_1.time_ - var_394_14) / var_394_15
				local var_394_17 = Color.New(0, 0, 0)

				var_394_17.a = Mathf.Lerp(0, 1, var_394_16)
				arg_391_1.mask_.color = var_394_17
			end

			if arg_391_1.time_ >= var_394_14 + var_394_15 and arg_391_1.time_ < var_394_14 + var_394_15 + arg_394_0 then
				local var_394_18 = Color.New(0, 0, 0)

				var_394_18.a = 1
				arg_391_1.mask_.color = var_394_18
			end

			local var_394_19 = 1.05

			if var_394_19 < arg_391_1.time_ and arg_391_1.time_ <= var_394_19 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_20 = 2

			if var_394_19 <= arg_391_1.time_ and arg_391_1.time_ < var_394_19 + var_394_20 then
				local var_394_21 = (arg_391_1.time_ - var_394_19) / var_394_20
				local var_394_22 = Color.New(0, 0, 0)

				var_394_22.a = Mathf.Lerp(1, 0, var_394_21)
				arg_391_1.mask_.color = var_394_22
			end

			if arg_391_1.time_ >= var_394_19 + var_394_20 and arg_391_1.time_ < var_394_19 + var_394_20 + arg_394_0 then
				local var_394_23 = Color.New(0, 0, 0)
				local var_394_24 = 0

				arg_391_1.mask_.enabled = false
				var_394_23.a = var_394_24
				arg_391_1.mask_.color = var_394_23
			end

			local var_394_25 = 0.05
			local var_394_26 = 1

			if var_394_25 < arg_391_1.time_ and arg_391_1.time_ <= var_394_25 + arg_394_0 then
				local var_394_27 = "stop"
				local var_394_28 = "effect"

				arg_391_1:AudioAction(var_394_27, var_394_28, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_394_29 = 0.05
			local var_394_30 = 0.2

			if var_394_29 < arg_391_1.time_ and arg_391_1.time_ <= var_394_29 + arg_394_0 then
				local var_394_31 = "play"
				local var_394_32 = "music"

				arg_391_1:AudioAction(var_394_31, var_394_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_394_33 = ""
				local var_394_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_394_34 ~= "" then
					if arg_391_1.bgmTxt_.text ~= var_394_34 and arg_391_1.bgmTxt_.text ~= "" then
						if arg_391_1.bgmTxt2_.text ~= "" then
							arg_391_1.bgmTxt_.text = arg_391_1.bgmTxt2_.text
						end

						arg_391_1.bgmTxt2_.text = var_394_34

						arg_391_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_391_1.bgmTxt_.text = var_394_34
						arg_391_1.bgmTxt2_.text = var_394_34
					end

					if arg_391_1.bgmTimer then
						arg_391_1.bgmTimer:Stop()

						arg_391_1.bgmTimer = nil
					end

					if arg_391_1.settingData.show_music_name == 1 then
						arg_391_1.musicController:SetSelectedState("show")
						arg_391_1.musicAnimator_:Play("open", 0, 0)

						if arg_391_1.settingData.music_time ~= 0 then
							arg_391_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_391_1.settingData.music_time), function()
								if arg_391_1 == nil or isNil(arg_391_1.bgmTxt_) then
									return
								end

								arg_391_1.musicController:SetSelectedState("hide")
								arg_391_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_394_35 = 1.05

			if var_394_35 < arg_391_1.time_ and arg_391_1.time_ <= var_394_35 + arg_394_0 then
				local var_394_36 = arg_391_1.fswbg_.transform:Find("textbox/adapt/content") or arg_391_1.fswbg_.transform:Find("textbox/content")
				local var_394_37 = arg_391_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_394_38 = var_394_36:GetComponent("Text")
				local var_394_39 = var_394_36:GetComponent("RectTransform")

				var_394_38.alignment = UnityEngine.TextAnchor.LowerCenter
				var_394_39.offsetMin = Vector2.New(0, -70)
				var_394_39.offsetMax = Vector2.New(0, 0)
			end

			local var_394_40 = 1.05

			if var_394_40 < arg_391_1.time_ and arg_391_1.time_ <= var_394_40 + arg_394_0 then
				arg_391_1.cswbg_:SetActive(true)

				local var_394_41 = arg_391_1.cswt_:GetComponent("RectTransform")

				arg_391_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_394_41.offsetMin = Vector2.New(0, 0)
				var_394_41.offsetMax = Vector2.New(0, 130)

				local var_394_42 = arg_391_1:GetWordFromCfg(419145)
				local var_394_43 = arg_391_1:FormatText(var_394_42.content)

				arg_391_1.cswt_.text = var_394_43

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.cswt_)

				arg_391_1.cswt_.fontSize = 120
				arg_391_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_391_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_391_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_394_44 = 1.06666666666667

			if var_394_44 < arg_391_1.time_ and arg_391_1.time_ <= var_394_44 + arg_394_0 then
				arg_391_1.fswbg_:SetActive(false)
				arg_391_1.dialog_:SetActive(false)
				SetActive(arg_391_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_391_1:ShowNextGo(false)
			end

			local var_394_45 = 0.933333333333333

			arg_391_1.isInRecall_ = false

			if var_394_45 < arg_391_1.time_ and arg_391_1.time_ <= var_394_45 + arg_394_0 then
				arg_391_1.screenFilterGo_:SetActive(false)

				for iter_394_2, iter_394_3 in pairs(arg_391_1.actors_) do
					local var_394_46 = iter_394_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_394_4, iter_394_5 in ipairs(var_394_46) do
						if iter_394_5.color.r > 0.51 then
							iter_394_5.color = Color.New(1, 1, 1)
						else
							iter_394_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_394_47 = 0.116666666666667

			if var_394_45 <= arg_391_1.time_ and arg_391_1.time_ < var_394_45 + var_394_47 then
				local var_394_48 = (arg_391_1.time_ - var_394_45) / var_394_47

				arg_391_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_394_48)
			end

			if arg_391_1.time_ >= var_394_45 + var_394_47 and arg_391_1.time_ < var_394_45 + var_394_47 + arg_394_0 then
				arg_391_1.screenFilterEffect_.weight = 0
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play420191095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 420191095
		arg_396_1.duration_ = 4.63

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play420191096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.fswbg_:SetActive(true)
				arg_396_1.dialog_:SetActive(false)

				arg_396_1.fswtw_.percent = 0

				local var_399_1 = arg_396_1:GetWordFromCfg(420191095)
				local var_399_2 = arg_396_1:FormatText(var_399_1.content)

				arg_396_1.fswt_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.fswt_)

				arg_396_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_396_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_396_1.fswtw_:SetDirty()

				arg_396_1.typewritterCharCountI18N = 0

				SetActive(arg_396_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_396_1:ShowNextGo(false)
			end

			local var_399_3 = 0.0166666666666667

			if var_399_3 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.var_.oldValueTypewriter = arg_396_1.fswtw_.percent

				SetActive(arg_396_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_396_1:ShowNextGo(false)
			end

			local var_399_4 = 7
			local var_399_5 = 0.7
			local var_399_6 = arg_396_1:GetWordFromCfg(420191095)
			local var_399_7 = arg_396_1:FormatText(var_399_6.content)
			local var_399_8, var_399_9 = arg_396_1:GetPercentByPara(var_399_7, 1)

			if var_399_3 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0

				local var_399_10 = var_399_4 <= 0 and var_399_5 or var_399_5 * ((var_399_9 - arg_396_1.typewritterCharCountI18N) / var_399_4)

				if var_399_10 > 0 and var_399_5 < var_399_10 then
					arg_396_1.talkMaxDuration = var_399_10

					if var_399_10 + var_399_3 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_10 + var_399_3
					end
				end
			end

			local var_399_11 = 0.7
			local var_399_12 = math.max(var_399_11, arg_396_1.talkMaxDuration)

			if var_399_3 <= arg_396_1.time_ and arg_396_1.time_ < var_399_3 + var_399_12 then
				local var_399_13 = (arg_396_1.time_ - var_399_3) / var_399_12

				arg_396_1.fswtw_.percent = Mathf.Lerp(arg_396_1.var_.oldValueTypewriter, var_399_8, var_399_13)
				arg_396_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_396_1.fswtw_:SetDirty()
			end

			if arg_396_1.time_ >= var_399_3 + var_399_12 and arg_396_1.time_ < var_399_3 + var_399_12 + arg_399_0 then
				arg_396_1.fswtw_.percent = var_399_8

				arg_396_1.fswtw_:SetDirty()
				arg_396_1:ShowNextGo(true)

				arg_396_1.typewritterCharCountI18N = var_399_9
			end

			local var_399_14 = 0
			local var_399_15 = 4.633
			local var_399_16 = manager.audio:GetVoiceLength("story_v_out_420191", "420191095", "story_v_out_420191.awb") / 1000

			if var_399_16 > 0 and var_399_15 < var_399_16 and var_399_16 + var_399_14 > arg_396_1.duration_ then
				local var_399_17 = var_399_16

				arg_396_1.duration_ = var_399_16 + var_399_14
			end

			if var_399_14 < arg_396_1.time_ and arg_396_1.time_ <= var_399_14 + arg_399_0 then
				local var_399_18 = "play"
				local var_399_19 = "voice"

				arg_396_1:AudioAction(var_399_18, var_399_19, "story_v_out_420191", "420191095", "story_v_out_420191.awb")
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play420191096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 420191096
		arg_400_1.duration_ = 10.27

		local var_400_0 = {
			zh = 8.9,
			ja = 10.266
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play420191097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 2

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			local var_403_1 = 0.3

			if arg_400_1.time_ >= var_403_0 + var_403_1 and arg_400_1.time_ < var_403_0 + var_403_1 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_2 = "ST0505"

			if arg_400_1.bgs_[var_403_2] == nil then
				local var_403_3 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_403_2)
				var_403_3.name = var_403_2
				var_403_3.transform.parent = arg_400_1.stage_.transform
				var_403_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_[var_403_2] = var_403_3
			end

			local var_403_4 = 0

			if var_403_4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				local var_403_5 = manager.ui.mainCamera.transform.localPosition
				local var_403_6 = Vector3.New(0, 0, 10) + Vector3.New(var_403_5.x, var_403_5.y, 0)
				local var_403_7 = arg_400_1.bgs_.ST0505

				var_403_7.transform.localPosition = var_403_6
				var_403_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_8 = var_403_7:GetComponent("SpriteRenderer")

				if var_403_8 and var_403_8.sprite then
					local var_403_9 = (var_403_7.transform.localPosition - var_403_5).z
					local var_403_10 = manager.ui.mainCameraCom_
					local var_403_11 = 2 * var_403_9 * Mathf.Tan(var_403_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_403_12 = var_403_11 * var_403_10.aspect
					local var_403_13 = var_403_8.sprite.bounds.size.x
					local var_403_14 = var_403_8.sprite.bounds.size.y
					local var_403_15 = var_403_12 / var_403_13
					local var_403_16 = var_403_11 / var_403_14
					local var_403_17 = var_403_16 < var_403_15 and var_403_15 or var_403_16

					var_403_7.transform.localScale = Vector3.New(var_403_17, var_403_17, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "ST0505" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_18 = 0

			if var_403_18 < arg_400_1.time_ and arg_400_1.time_ <= var_403_18 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_19 = 2

			if var_403_18 <= arg_400_1.time_ and arg_400_1.time_ < var_403_18 + var_403_19 then
				local var_403_20 = (arg_400_1.time_ - var_403_18) / var_403_19
				local var_403_21 = Color.New(0, 0, 0)

				var_403_21.a = Mathf.Lerp(1, 0, var_403_20)
				arg_400_1.mask_.color = var_403_21
			end

			if arg_400_1.time_ >= var_403_18 + var_403_19 and arg_400_1.time_ < var_403_18 + var_403_19 + arg_403_0 then
				local var_403_22 = Color.New(0, 0, 0)
				local var_403_23 = 0

				arg_400_1.mask_.enabled = false
				var_403_22.a = var_403_23
				arg_400_1.mask_.color = var_403_22
			end

			local var_403_24 = 0

			if var_403_24 < arg_400_1.time_ and arg_400_1.time_ <= var_403_24 + arg_403_0 then
				arg_400_1.cswbg_:SetActive(false)
			end

			local var_403_25 = 0

			if var_403_25 < arg_400_1.time_ and arg_400_1.time_ <= var_403_25 + arg_403_0 then
				arg_400_1.fswbg_:SetActive(false)
				arg_400_1.dialog_:SetActive(false)
				SetActive(arg_400_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_400_1:ShowNextGo(false)
			end

			local var_403_26 = "404001ui_story"

			if arg_400_1.actors_[var_403_26] == nil then
				local var_403_27 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_403_27) then
					local var_403_28 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_400_1.stage_.transform)

					var_403_28.name = var_403_26
					var_403_28.transform.localPosition = Vector3.New(0, 100, 0)
					arg_400_1.actors_[var_403_26] = var_403_28

					local var_403_29 = var_403_28:GetComponentInChildren(typeof(CharacterEffect))

					var_403_29.enabled = true

					local var_403_30 = GameObjectTools.GetOrAddComponent(var_403_28, typeof(DynamicBoneHelper))

					if var_403_30 then
						var_403_30:EnableDynamicBone(false)
					end

					arg_400_1:ShowWeapon(var_403_29.transform, false)

					arg_400_1.var_[var_403_26 .. "Animator"] = var_403_29.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_400_1.var_[var_403_26 .. "Animator"].applyRootMotion = true
					arg_400_1.var_[var_403_26 .. "LipSync"] = var_403_29.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_403_31 = arg_400_1.actors_["404001ui_story"].transform
			local var_403_32 = 2

			if var_403_32 < arg_400_1.time_ and arg_400_1.time_ <= var_403_32 + arg_403_0 then
				arg_400_1.var_.moveOldPos404001ui_story = var_403_31.localPosition
			end

			local var_403_33 = 0.001

			if var_403_32 <= arg_400_1.time_ and arg_400_1.time_ < var_403_32 + var_403_33 then
				local var_403_34 = (arg_400_1.time_ - var_403_32) / var_403_33
				local var_403_35 = Vector3.New(0, -1.55, -5.5)

				var_403_31.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos404001ui_story, var_403_35, var_403_34)

				local var_403_36 = manager.ui.mainCamera.transform.position - var_403_31.position

				var_403_31.forward = Vector3.New(var_403_36.x, var_403_36.y, var_403_36.z)

				local var_403_37 = var_403_31.localEulerAngles

				var_403_37.z = 0
				var_403_37.x = 0
				var_403_31.localEulerAngles = var_403_37
			end

			if arg_400_1.time_ >= var_403_32 + var_403_33 and arg_400_1.time_ < var_403_32 + var_403_33 + arg_403_0 then
				var_403_31.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_403_38 = manager.ui.mainCamera.transform.position - var_403_31.position

				var_403_31.forward = Vector3.New(var_403_38.x, var_403_38.y, var_403_38.z)

				local var_403_39 = var_403_31.localEulerAngles

				var_403_39.z = 0
				var_403_39.x = 0
				var_403_31.localEulerAngles = var_403_39
			end

			local var_403_40 = arg_400_1.actors_["404001ui_story"]
			local var_403_41 = 2

			if var_403_41 < arg_400_1.time_ and arg_400_1.time_ <= var_403_41 + arg_403_0 and not isNil(var_403_40) and arg_400_1.var_.characterEffect404001ui_story == nil then
				arg_400_1.var_.characterEffect404001ui_story = var_403_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_42 = 0.200000002980232

			if var_403_41 <= arg_400_1.time_ and arg_400_1.time_ < var_403_41 + var_403_42 and not isNil(var_403_40) then
				local var_403_43 = (arg_400_1.time_ - var_403_41) / var_403_42

				if arg_400_1.var_.characterEffect404001ui_story and not isNil(var_403_40) then
					arg_400_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_41 + var_403_42 and arg_400_1.time_ < var_403_41 + var_403_42 + arg_403_0 and not isNil(var_403_40) and arg_400_1.var_.characterEffect404001ui_story then
				arg_400_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_403_44 = 2

			if var_403_44 < arg_400_1.time_ and arg_400_1.time_ <= var_403_44 + arg_403_0 then
				arg_400_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_403_45 = 2

			if var_403_45 < arg_400_1.time_ and arg_400_1.time_ <= var_403_45 + arg_403_0 then
				arg_400_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_403_46 = 0
			local var_403_47 = 0.2

			if var_403_46 < arg_400_1.time_ and arg_400_1.time_ <= var_403_46 + arg_403_0 then
				local var_403_48 = "play"
				local var_403_49 = "music"

				arg_400_1:AudioAction(var_403_48, var_403_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_403_50 = ""
				local var_403_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_403_51 ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_51 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_51

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_51
						arg_400_1.bgmTxt2_.text = var_403_51
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_403_52 = 0.566666666666667
			local var_403_53 = 1

			if var_403_52 < arg_400_1.time_ and arg_400_1.time_ <= var_403_52 + arg_403_0 then
				local var_403_54 = "play"
				local var_403_55 = "music"

				arg_400_1:AudioAction(var_403_54, var_403_55, "bgm_activity_4_0_story_ui", "bgm_activity_4_0_story_ui", "bgm_activity_4_0_story_ui.awb")

				local var_403_56 = ""
				local var_403_57 = manager.audio:GetAudioName("bgm_activity_4_0_story_ui", "bgm_activity_4_0_story_ui")

				if var_403_57 ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_57 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_57

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_57
						arg_400_1.bgmTxt2_.text = var_403_57
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_403_58 = 0.57
			local var_403_59 = 1

			if var_403_58 < arg_400_1.time_ and arg_400_1.time_ <= var_403_58 + arg_403_0 then
				local var_403_60 = "play"
				local var_403_61 = "music"

				arg_400_1:AudioAction(var_403_60, var_403_61, "bgm_activity_4_0_story_ui", "inst", "bgm_activity_4_0_story_ui.awb")

				local var_403_62 = ""
				local var_403_63 = manager.audio:GetAudioName("bgm_activity_4_0_story_ui", "inst")

				if var_403_63 ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_63 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_63

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_63
						arg_400_1.bgmTxt2_.text = var_403_63
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_403_64 = 0.566666666666667
			local var_403_65 = 1

			if var_403_64 < arg_400_1.time_ and arg_400_1.time_ <= var_403_64 + arg_403_0 then
				local var_403_66 = "play"
				local var_403_67 = "effect"

				arg_400_1:AudioAction(var_403_66, var_403_67, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_403_68 = 2
			local var_403_69 = 1

			if var_403_68 < arg_400_1.time_ and arg_400_1.time_ <= var_403_68 + arg_403_0 then
				local var_403_70 = "play"
				local var_403_71 = "effect"

				arg_400_1:AudioAction(var_403_70, var_403_71, "se_story_140", "se_story_140_data01", "")
			end

			if arg_400_1.frameCnt_ <= 1 then
				arg_400_1.dialog_:SetActive(false)
			end

			local var_403_72 = 2
			local var_403_73 = 0.675

			if var_403_72 < arg_400_1.time_ and arg_400_1.time_ <= var_403_72 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				arg_400_1.dialog_:SetActive(true)

				arg_400_1.dialogCg_.alpha = 0

				local var_403_74 = LeanTween.value(arg_400_1.dialog_, 0, 1, 0.3)

				var_403_74:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_400_1.dialogCg_.alpha = arg_407_0
				end))
				var_403_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_400_1.dialog_)
					var_403_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_400_1.duration_ = arg_400_1.duration_ + 0.3

				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_75 = arg_400_1:FormatText(StoryNameCfg[668].name)

				arg_400_1.leftNameTxt_.text = var_403_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_76 = arg_400_1:GetWordFromCfg(420191096)
				local var_403_77 = arg_400_1:FormatText(var_403_76.content)

				arg_400_1.text_.text = var_403_77

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_78 = 27
				local var_403_79 = utf8.len(var_403_77)
				local var_403_80 = var_403_78 <= 0 and var_403_73 or var_403_73 * (var_403_79 / var_403_78)

				if var_403_80 > 0 and var_403_73 < var_403_80 then
					arg_400_1.talkMaxDuration = var_403_80
					var_403_72 = var_403_72 + 0.3

					if var_403_80 + var_403_72 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_80 + var_403_72
					end
				end

				arg_400_1.text_.text = var_403_77
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191096", "story_v_out_420191.awb") ~= 0 then
					local var_403_81 = manager.audio:GetVoiceLength("story_v_out_420191", "420191096", "story_v_out_420191.awb") / 1000

					if var_403_81 + var_403_72 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_81 + var_403_72
					end

					if var_403_76.prefab_name ~= "" and arg_400_1.actors_[var_403_76.prefab_name] ~= nil then
						local var_403_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_76.prefab_name].transform, "story_v_out_420191", "420191096", "story_v_out_420191.awb")

						arg_400_1:RecordAudio("420191096", var_403_82)
						arg_400_1:RecordAudio("420191096", var_403_82)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_420191", "420191096", "story_v_out_420191.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_420191", "420191096", "story_v_out_420191.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_83 = var_403_72 + 0.3
			local var_403_84 = math.max(var_403_73, arg_400_1.talkMaxDuration)

			if var_403_83 <= arg_400_1.time_ and arg_400_1.time_ < var_403_83 + var_403_84 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_83) / var_403_84

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_83 + var_403_84 and arg_400_1.time_ < var_403_83 + var_403_84 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play420191097 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 420191097
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play420191098(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["404001ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos404001ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, 100, 0)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos404001ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, 100, 0)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = 0
			local var_412_10 = 0.75

			if var_412_9 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_11 = arg_409_1:GetWordFromCfg(420191097)
				local var_412_12 = arg_409_1:FormatText(var_412_11.content)

				arg_409_1.text_.text = var_412_12

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_13 = 30
				local var_412_14 = utf8.len(var_412_12)
				local var_412_15 = var_412_13 <= 0 and var_412_10 or var_412_10 * (var_412_14 / var_412_13)

				if var_412_15 > 0 and var_412_10 < var_412_15 then
					arg_409_1.talkMaxDuration = var_412_15

					if var_412_15 + var_412_9 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_15 + var_412_9
					end
				end

				arg_409_1.text_.text = var_412_12
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = math.max(var_412_10, arg_409_1.talkMaxDuration)

			if var_412_9 <= arg_409_1.time_ and arg_409_1.time_ < var_412_9 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_9) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_9 + var_412_16 and arg_409_1.time_ < var_412_9 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play420191098 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 420191098
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play420191099(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.875

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_2 = arg_413_1:GetWordFromCfg(420191098)
				local var_416_3 = arg_413_1:FormatText(var_416_2.content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 35
				local var_416_5 = utf8.len(var_416_3)
				local var_416_6 = var_416_4 <= 0 and var_416_1 or var_416_1 * (var_416_5 / var_416_4)

				if var_416_6 > 0 and var_416_1 < var_416_6 then
					arg_413_1.talkMaxDuration = var_416_6

					if var_416_6 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_6 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_7 and arg_413_1.time_ < var_416_0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play420191099 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 420191099
		arg_417_1.duration_ = 4.17

		local var_417_0 = {
			zh = 4.166,
			ja = 3.5
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play420191100(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["404001ui_story"].transform
			local var_420_1 = 3.10862446895044e-15

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos404001ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(0, -1.55, -5.5)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos404001ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["404001ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect404001ui_story == nil then
				arg_417_1.var_.characterEffect404001ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect404001ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect404001ui_story then
				arg_417_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_420_13 = 3.10862446895044e-15

			if var_420_13 < arg_417_1.time_ and arg_417_1.time_ <= var_420_13 + arg_420_0 then
				arg_417_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_420_14 = 3.10862446895044e-15

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 then
				arg_417_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_420_15 = 0
			local var_420_16 = 0.375

			if var_420_15 < arg_417_1.time_ and arg_417_1.time_ <= var_420_15 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_17 = arg_417_1:FormatText(StoryNameCfg[668].name)

				arg_417_1.leftNameTxt_.text = var_420_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_18 = arg_417_1:GetWordFromCfg(420191099)
				local var_420_19 = arg_417_1:FormatText(var_420_18.content)

				arg_417_1.text_.text = var_420_19

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_20 = 15
				local var_420_21 = utf8.len(var_420_19)
				local var_420_22 = var_420_20 <= 0 and var_420_16 or var_420_16 * (var_420_21 / var_420_20)

				if var_420_22 > 0 and var_420_16 < var_420_22 then
					arg_417_1.talkMaxDuration = var_420_22

					if var_420_22 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_22 + var_420_15
					end
				end

				arg_417_1.text_.text = var_420_19
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191099", "story_v_out_420191.awb") ~= 0 then
					local var_420_23 = manager.audio:GetVoiceLength("story_v_out_420191", "420191099", "story_v_out_420191.awb") / 1000

					if var_420_23 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_23 + var_420_15
					end

					if var_420_18.prefab_name ~= "" and arg_417_1.actors_[var_420_18.prefab_name] ~= nil then
						local var_420_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_18.prefab_name].transform, "story_v_out_420191", "420191099", "story_v_out_420191.awb")

						arg_417_1:RecordAudio("420191099", var_420_24)
						arg_417_1:RecordAudio("420191099", var_420_24)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_420191", "420191099", "story_v_out_420191.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_420191", "420191099", "story_v_out_420191.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_25 = math.max(var_420_16, arg_417_1.talkMaxDuration)

			if var_420_15 <= arg_417_1.time_ and arg_417_1.time_ < var_420_15 + var_420_25 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_15) / var_420_25

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_15 + var_420_25 and arg_417_1.time_ < var_420_15 + var_420_25 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.10862446895044e-15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play420191100 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 420191100
		arg_421_1.duration_ = 4.13

		local var_421_0 = {
			zh = 3.433,
			ja = 4.133
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play420191101(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 0.45

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_2 = arg_421_1:FormatText(StoryNameCfg[668].name)

				arg_421_1.leftNameTxt_.text = var_424_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_3 = arg_421_1:GetWordFromCfg(420191100)
				local var_424_4 = arg_421_1:FormatText(var_424_3.content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 18
				local var_424_6 = utf8.len(var_424_4)
				local var_424_7 = var_424_5 <= 0 and var_424_1 or var_424_1 * (var_424_6 / var_424_5)

				if var_424_7 > 0 and var_424_1 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191100", "story_v_out_420191.awb") ~= 0 then
					local var_424_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191100", "story_v_out_420191.awb") / 1000

					if var_424_8 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_8 + var_424_0
					end

					if var_424_3.prefab_name ~= "" and arg_421_1.actors_[var_424_3.prefab_name] ~= nil then
						local var_424_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_3.prefab_name].transform, "story_v_out_420191", "420191100", "story_v_out_420191.awb")

						arg_421_1:RecordAudio("420191100", var_424_9)
						arg_421_1:RecordAudio("420191100", var_424_9)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_420191", "420191100", "story_v_out_420191.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_420191", "420191100", "story_v_out_420191.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_10 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_10 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_10

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_10 and arg_421_1.time_ < var_424_0 + var_424_10 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play420191101 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 420191101
		arg_425_1.duration_ = 2.73

		local var_425_0 = {
			zh = 2.2,
			ja = 2.733
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play420191102(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1085ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1085ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(0.75, -1.01, -5.83)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1085ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["1085ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1085ui_story == nil then
				arg_425_1.var_.characterEffect1085ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect1085ui_story and not isNil(var_428_9) then
					arg_425_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1085ui_story then
				arg_425_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_428_13 = 0

			if var_428_13 < arg_425_1.time_ and arg_425_1.time_ <= var_428_13 + arg_428_0 then
				arg_425_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_428_14 = 0

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 then
				arg_425_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_428_15 = arg_425_1.actors_["404001ui_story"].transform
			local var_428_16 = 3.10862446895044e-15

			if var_428_16 < arg_425_1.time_ and arg_425_1.time_ <= var_428_16 + arg_428_0 then
				arg_425_1.var_.moveOldPos404001ui_story = var_428_15.localPosition
			end

			local var_428_17 = 0.001

			if var_428_16 <= arg_425_1.time_ and arg_425_1.time_ < var_428_16 + var_428_17 then
				local var_428_18 = (arg_425_1.time_ - var_428_16) / var_428_17
				local var_428_19 = Vector3.New(-0.8, -1.55, -5.5)

				var_428_15.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos404001ui_story, var_428_19, var_428_18)

				local var_428_20 = manager.ui.mainCamera.transform.position - var_428_15.position

				var_428_15.forward = Vector3.New(var_428_20.x, var_428_20.y, var_428_20.z)

				local var_428_21 = var_428_15.localEulerAngles

				var_428_21.z = 0
				var_428_21.x = 0
				var_428_15.localEulerAngles = var_428_21
			end

			if arg_425_1.time_ >= var_428_16 + var_428_17 and arg_425_1.time_ < var_428_16 + var_428_17 + arg_428_0 then
				var_428_15.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_428_22 = manager.ui.mainCamera.transform.position - var_428_15.position

				var_428_15.forward = Vector3.New(var_428_22.x, var_428_22.y, var_428_22.z)

				local var_428_23 = var_428_15.localEulerAngles

				var_428_23.z = 0
				var_428_23.x = 0
				var_428_15.localEulerAngles = var_428_23
			end

			local var_428_24 = arg_425_1.actors_["404001ui_story"]
			local var_428_25 = 0

			if var_428_25 < arg_425_1.time_ and arg_425_1.time_ <= var_428_25 + arg_428_0 and not isNil(var_428_24) and arg_425_1.var_.characterEffect404001ui_story == nil then
				arg_425_1.var_.characterEffect404001ui_story = var_428_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_26 = 0.200000002980232

			if var_428_25 <= arg_425_1.time_ and arg_425_1.time_ < var_428_25 + var_428_26 and not isNil(var_428_24) then
				local var_428_27 = (arg_425_1.time_ - var_428_25) / var_428_26

				if arg_425_1.var_.characterEffect404001ui_story and not isNil(var_428_24) then
					local var_428_28 = Mathf.Lerp(0, 0.5, var_428_27)

					arg_425_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_425_1.var_.characterEffect404001ui_story.fillRatio = var_428_28
				end
			end

			if arg_425_1.time_ >= var_428_25 + var_428_26 and arg_425_1.time_ < var_428_25 + var_428_26 + arg_428_0 and not isNil(var_428_24) and arg_425_1.var_.characterEffect404001ui_story then
				local var_428_29 = 0.5

				arg_425_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_425_1.var_.characterEffect404001ui_story.fillRatio = var_428_29
			end

			local var_428_30 = 0
			local var_428_31 = 0.225

			if var_428_30 < arg_425_1.time_ and arg_425_1.time_ <= var_428_30 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_32 = arg_425_1:FormatText(StoryNameCfg[328].name)

				arg_425_1.leftNameTxt_.text = var_428_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_33 = arg_425_1:GetWordFromCfg(420191101)
				local var_428_34 = arg_425_1:FormatText(var_428_33.content)

				arg_425_1.text_.text = var_428_34

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_35 = 9
				local var_428_36 = utf8.len(var_428_34)
				local var_428_37 = var_428_35 <= 0 and var_428_31 or var_428_31 * (var_428_36 / var_428_35)

				if var_428_37 > 0 and var_428_31 < var_428_37 then
					arg_425_1.talkMaxDuration = var_428_37

					if var_428_37 + var_428_30 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_37 + var_428_30
					end
				end

				arg_425_1.text_.text = var_428_34
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191101", "story_v_out_420191.awb") ~= 0 then
					local var_428_38 = manager.audio:GetVoiceLength("story_v_out_420191", "420191101", "story_v_out_420191.awb") / 1000

					if var_428_38 + var_428_30 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_38 + var_428_30
					end

					if var_428_33.prefab_name ~= "" and arg_425_1.actors_[var_428_33.prefab_name] ~= nil then
						local var_428_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_33.prefab_name].transform, "story_v_out_420191", "420191101", "story_v_out_420191.awb")

						arg_425_1:RecordAudio("420191101", var_428_39)
						arg_425_1:RecordAudio("420191101", var_428_39)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_420191", "420191101", "story_v_out_420191.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_420191", "420191101", "story_v_out_420191.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_40 = math.max(var_428_31, arg_425_1.talkMaxDuration)

			if var_428_30 <= arg_425_1.time_ and arg_425_1.time_ < var_428_30 + var_428_40 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_30) / var_428_40

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_30 + var_428_40 and arg_425_1.time_ < var_428_30 + var_428_40 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
				startTime = 3.10862446895044e-15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play420191102 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 420191102
		arg_429_1.duration_ = 2.1

		local var_429_0 = {
			zh = 1.6,
			ja = 2.1
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play420191103(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["404001ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect404001ui_story == nil then
				arg_429_1.var_.characterEffect404001ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect404001ui_story and not isNil(var_432_0) then
					arg_429_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect404001ui_story then
				arg_429_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_432_4 = arg_429_1.actors_["1085ui_story"]
			local var_432_5 = 0

			if var_432_5 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 and not isNil(var_432_4) and arg_429_1.var_.characterEffect1085ui_story == nil then
				arg_429_1.var_.characterEffect1085ui_story = var_432_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_6 = 0.200000002980232

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_6 and not isNil(var_432_4) then
				local var_432_7 = (arg_429_1.time_ - var_432_5) / var_432_6

				if arg_429_1.var_.characterEffect1085ui_story and not isNil(var_432_4) then
					local var_432_8 = Mathf.Lerp(0, 0.5, var_432_7)

					arg_429_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1085ui_story.fillRatio = var_432_8
				end
			end

			if arg_429_1.time_ >= var_432_5 + var_432_6 and arg_429_1.time_ < var_432_5 + var_432_6 + arg_432_0 and not isNil(var_432_4) and arg_429_1.var_.characterEffect1085ui_story then
				local var_432_9 = 0.5

				arg_429_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1085ui_story.fillRatio = var_432_9
			end

			local var_432_10 = 0
			local var_432_11 = 0.2

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_12 = arg_429_1:FormatText(StoryNameCfg[668].name)

				arg_429_1.leftNameTxt_.text = var_432_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_13 = arg_429_1:GetWordFromCfg(420191102)
				local var_432_14 = arg_429_1:FormatText(var_432_13.content)

				arg_429_1.text_.text = var_432_14

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_15 = 8
				local var_432_16 = utf8.len(var_432_14)
				local var_432_17 = var_432_15 <= 0 and var_432_11 or var_432_11 * (var_432_16 / var_432_15)

				if var_432_17 > 0 and var_432_11 < var_432_17 then
					arg_429_1.talkMaxDuration = var_432_17

					if var_432_17 + var_432_10 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_17 + var_432_10
					end
				end

				arg_429_1.text_.text = var_432_14
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191102", "story_v_out_420191.awb") ~= 0 then
					local var_432_18 = manager.audio:GetVoiceLength("story_v_out_420191", "420191102", "story_v_out_420191.awb") / 1000

					if var_432_18 + var_432_10 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_18 + var_432_10
					end

					if var_432_13.prefab_name ~= "" and arg_429_1.actors_[var_432_13.prefab_name] ~= nil then
						local var_432_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_13.prefab_name].transform, "story_v_out_420191", "420191102", "story_v_out_420191.awb")

						arg_429_1:RecordAudio("420191102", var_432_19)
						arg_429_1:RecordAudio("420191102", var_432_19)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_420191", "420191102", "story_v_out_420191.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_420191", "420191102", "story_v_out_420191.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_20 = math.max(var_432_11, arg_429_1.talkMaxDuration)

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_20 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_10) / var_432_20

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_10 + var_432_20 and arg_429_1.time_ < var_432_10 + var_432_20 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play420191103 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 420191103
		arg_433_1.duration_ = 1.8

		local var_433_0 = {
			zh = 1.5,
			ja = 1.8
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play420191104(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1085ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1085ui_story == nil then
				arg_433_1.var_.characterEffect1085ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1085ui_story and not isNil(var_436_0) then
					arg_433_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1085ui_story then
				arg_433_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_436_4 = arg_433_1.actors_["404001ui_story"]
			local var_436_5 = 0

			if var_436_5 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect404001ui_story == nil then
				arg_433_1.var_.characterEffect404001ui_story = var_436_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_6 = 0.200000002980232

			if var_436_5 <= arg_433_1.time_ and arg_433_1.time_ < var_436_5 + var_436_6 and not isNil(var_436_4) then
				local var_436_7 = (arg_433_1.time_ - var_436_5) / var_436_6

				if arg_433_1.var_.characterEffect404001ui_story and not isNil(var_436_4) then
					local var_436_8 = Mathf.Lerp(0, 0.5, var_436_7)

					arg_433_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_433_1.var_.characterEffect404001ui_story.fillRatio = var_436_8
				end
			end

			if arg_433_1.time_ >= var_436_5 + var_436_6 and arg_433_1.time_ < var_436_5 + var_436_6 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect404001ui_story then
				local var_436_9 = 0.5

				arg_433_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_433_1.var_.characterEffect404001ui_story.fillRatio = var_436_9
			end

			local var_436_10 = 0
			local var_436_11 = 0.175

			if var_436_10 < arg_433_1.time_ and arg_433_1.time_ <= var_436_10 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_12 = arg_433_1:FormatText(StoryNameCfg[328].name)

				arg_433_1.leftNameTxt_.text = var_436_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_13 = arg_433_1:GetWordFromCfg(420191103)
				local var_436_14 = arg_433_1:FormatText(var_436_13.content)

				arg_433_1.text_.text = var_436_14

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_15 = 7
				local var_436_16 = utf8.len(var_436_14)
				local var_436_17 = var_436_15 <= 0 and var_436_11 or var_436_11 * (var_436_16 / var_436_15)

				if var_436_17 > 0 and var_436_11 < var_436_17 then
					arg_433_1.talkMaxDuration = var_436_17

					if var_436_17 + var_436_10 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_17 + var_436_10
					end
				end

				arg_433_1.text_.text = var_436_14
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191103", "story_v_out_420191.awb") ~= 0 then
					local var_436_18 = manager.audio:GetVoiceLength("story_v_out_420191", "420191103", "story_v_out_420191.awb") / 1000

					if var_436_18 + var_436_10 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_18 + var_436_10
					end

					if var_436_13.prefab_name ~= "" and arg_433_1.actors_[var_436_13.prefab_name] ~= nil then
						local var_436_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_13.prefab_name].transform, "story_v_out_420191", "420191103", "story_v_out_420191.awb")

						arg_433_1:RecordAudio("420191103", var_436_19)
						arg_433_1:RecordAudio("420191103", var_436_19)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_420191", "420191103", "story_v_out_420191.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_420191", "420191103", "story_v_out_420191.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_20 = math.max(var_436_11, arg_433_1.talkMaxDuration)

			if var_436_10 <= arg_433_1.time_ and arg_433_1.time_ < var_436_10 + var_436_20 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_10) / var_436_20

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_10 + var_436_20 and arg_433_1.time_ < var_436_10 + var_436_20 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play420191104 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 420191104
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play420191105(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1085ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1085ui_story == nil then
				arg_437_1.var_.characterEffect1085ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1085ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1085ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1085ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1085ui_story.fillRatio = var_440_5
			end

			local var_440_6 = 0
			local var_440_7 = 0.975

			if var_440_6 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_8 = arg_437_1:GetWordFromCfg(420191104)
				local var_440_9 = arg_437_1:FormatText(var_440_8.content)

				arg_437_1.text_.text = var_440_9

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_10 = 39
				local var_440_11 = utf8.len(var_440_9)
				local var_440_12 = var_440_10 <= 0 and var_440_7 or var_440_7 * (var_440_11 / var_440_10)

				if var_440_12 > 0 and var_440_7 < var_440_12 then
					arg_437_1.talkMaxDuration = var_440_12

					if var_440_12 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_12 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_9
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_13 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_13 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_13

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_13 and arg_437_1.time_ < var_440_6 + var_440_13 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play420191105 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 420191105
		arg_441_1.duration_ = 3.7

		local var_441_0 = {
			zh = 3.4,
			ja = 3.7
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play420191106(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1085ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1085ui_story == nil then
				arg_441_1.var_.characterEffect1085ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1085ui_story and not isNil(var_444_0) then
					arg_441_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1085ui_story then
				arg_441_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_444_4 = 0

			if var_444_4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_444_5 = 0

			if var_444_5 < arg_441_1.time_ and arg_441_1.time_ <= var_444_5 + arg_444_0 then
				arg_441_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_444_6 = 0
			local var_444_7 = 0.275

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[328].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_9 = arg_441_1:GetWordFromCfg(420191105)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 11
				local var_444_12 = utf8.len(var_444_10)
				local var_444_13 = var_444_11 <= 0 and var_444_7 or var_444_7 * (var_444_12 / var_444_11)

				if var_444_13 > 0 and var_444_7 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_10
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191105", "story_v_out_420191.awb") ~= 0 then
					local var_444_14 = manager.audio:GetVoiceLength("story_v_out_420191", "420191105", "story_v_out_420191.awb") / 1000

					if var_444_14 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_14 + var_444_6
					end

					if var_444_9.prefab_name ~= "" and arg_441_1.actors_[var_444_9.prefab_name] ~= nil then
						local var_444_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_9.prefab_name].transform, "story_v_out_420191", "420191105", "story_v_out_420191.awb")

						arg_441_1:RecordAudio("420191105", var_444_15)
						arg_441_1:RecordAudio("420191105", var_444_15)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_420191", "420191105", "story_v_out_420191.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_420191", "420191105", "story_v_out_420191.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_16 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_16

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_16 and arg_441_1.time_ < var_444_6 + var_444_16 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play420191106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 420191106
		arg_445_1.duration_ = 4.73

		local var_445_0 = {
			zh = 3.6,
			ja = 4.733
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play420191107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["404001ui_story"]
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect404001ui_story == nil then
				arg_445_1.var_.characterEffect404001ui_story = var_448_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 and not isNil(var_448_0) then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2

				if arg_445_1.var_.characterEffect404001ui_story and not isNil(var_448_0) then
					arg_445_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect404001ui_story then
				arg_445_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_448_4 = arg_445_1.actors_["1085ui_story"]
			local var_448_5 = 0

			if var_448_5 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 and not isNil(var_448_4) and arg_445_1.var_.characterEffect1085ui_story == nil then
				arg_445_1.var_.characterEffect1085ui_story = var_448_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_6 = 0.200000002980232

			if var_448_5 <= arg_445_1.time_ and arg_445_1.time_ < var_448_5 + var_448_6 and not isNil(var_448_4) then
				local var_448_7 = (arg_445_1.time_ - var_448_5) / var_448_6

				if arg_445_1.var_.characterEffect1085ui_story and not isNil(var_448_4) then
					local var_448_8 = Mathf.Lerp(0, 0.5, var_448_7)

					arg_445_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1085ui_story.fillRatio = var_448_8
				end
			end

			if arg_445_1.time_ >= var_448_5 + var_448_6 and arg_445_1.time_ < var_448_5 + var_448_6 + arg_448_0 and not isNil(var_448_4) and arg_445_1.var_.characterEffect1085ui_story then
				local var_448_9 = 0.5

				arg_445_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1085ui_story.fillRatio = var_448_9
			end

			local var_448_10 = 0
			local var_448_11 = 0.4

			if var_448_10 < arg_445_1.time_ and arg_445_1.time_ <= var_448_10 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_12 = arg_445_1:FormatText(StoryNameCfg[668].name)

				arg_445_1.leftNameTxt_.text = var_448_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_13 = arg_445_1:GetWordFromCfg(420191106)
				local var_448_14 = arg_445_1:FormatText(var_448_13.content)

				arg_445_1.text_.text = var_448_14

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_15 = 16
				local var_448_16 = utf8.len(var_448_14)
				local var_448_17 = var_448_15 <= 0 and var_448_11 or var_448_11 * (var_448_16 / var_448_15)

				if var_448_17 > 0 and var_448_11 < var_448_17 then
					arg_445_1.talkMaxDuration = var_448_17

					if var_448_17 + var_448_10 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_17 + var_448_10
					end
				end

				arg_445_1.text_.text = var_448_14
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191106", "story_v_out_420191.awb") ~= 0 then
					local var_448_18 = manager.audio:GetVoiceLength("story_v_out_420191", "420191106", "story_v_out_420191.awb") / 1000

					if var_448_18 + var_448_10 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_18 + var_448_10
					end

					if var_448_13.prefab_name ~= "" and arg_445_1.actors_[var_448_13.prefab_name] ~= nil then
						local var_448_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_13.prefab_name].transform, "story_v_out_420191", "420191106", "story_v_out_420191.awb")

						arg_445_1:RecordAudio("420191106", var_448_19)
						arg_445_1:RecordAudio("420191106", var_448_19)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_420191", "420191106", "story_v_out_420191.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_420191", "420191106", "story_v_out_420191.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_20 = math.max(var_448_11, arg_445_1.talkMaxDuration)

			if var_448_10 <= arg_445_1.time_ and arg_445_1.time_ < var_448_10 + var_448_20 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_10) / var_448_20

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_10 + var_448_20 and arg_445_1.time_ < var_448_10 + var_448_20 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play420191107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 420191107
		arg_449_1.duration_ = 5.6

		local var_449_0 = {
			zh = 4.7,
			ja = 5.6
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play420191108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.525

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[668].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_3 = arg_449_1:GetWordFromCfg(420191107)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 21
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191107", "story_v_out_420191.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191107", "story_v_out_420191.awb") / 1000

					if var_452_8 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_0
					end

					if var_452_3.prefab_name ~= "" and arg_449_1.actors_[var_452_3.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_3.prefab_name].transform, "story_v_out_420191", "420191107", "story_v_out_420191.awb")

						arg_449_1:RecordAudio("420191107", var_452_9)
						arg_449_1:RecordAudio("420191107", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_420191", "420191107", "story_v_out_420191.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_420191", "420191107", "story_v_out_420191.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_10 and arg_449_1.time_ < var_452_0 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play420191108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 420191108
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play420191109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["404001ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos404001ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, 100, 0)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos404001ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, 100, 0)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["1085ui_story"].transform
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 then
				arg_453_1.var_.moveOldPos1085ui_story = var_456_9.localPosition
			end

			local var_456_11 = 0.001

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11
				local var_456_13 = Vector3.New(0, 100, 0)

				var_456_9.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1085ui_story, var_456_13, var_456_12)

				local var_456_14 = manager.ui.mainCamera.transform.position - var_456_9.position

				var_456_9.forward = Vector3.New(var_456_14.x, var_456_14.y, var_456_14.z)

				local var_456_15 = var_456_9.localEulerAngles

				var_456_15.z = 0
				var_456_15.x = 0
				var_456_9.localEulerAngles = var_456_15
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 then
				var_456_9.localPosition = Vector3.New(0, 100, 0)

				local var_456_16 = manager.ui.mainCamera.transform.position - var_456_9.position

				var_456_9.forward = Vector3.New(var_456_16.x, var_456_16.y, var_456_16.z)

				local var_456_17 = var_456_9.localEulerAngles

				var_456_17.z = 0
				var_456_17.x = 0
				var_456_9.localEulerAngles = var_456_17
			end

			local var_456_18 = 0.05
			local var_456_19 = 1

			if var_456_18 < arg_453_1.time_ and arg_453_1.time_ <= var_456_18 + arg_456_0 then
				local var_456_20 = "play"
				local var_456_21 = "effect"

				arg_453_1:AudioAction(var_456_20, var_456_21, "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			local var_456_22 = 0
			local var_456_23 = 1.275

			if var_456_22 < arg_453_1.time_ and arg_453_1.time_ <= var_456_22 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_24 = arg_453_1:GetWordFromCfg(420191108)
				local var_456_25 = arg_453_1:FormatText(var_456_24.content)

				arg_453_1.text_.text = var_456_25

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_26 = 51
				local var_456_27 = utf8.len(var_456_25)
				local var_456_28 = var_456_26 <= 0 and var_456_23 or var_456_23 * (var_456_27 / var_456_26)

				if var_456_28 > 0 and var_456_23 < var_456_28 then
					arg_453_1.talkMaxDuration = var_456_28

					if var_456_28 + var_456_22 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_28 + var_456_22
					end
				end

				arg_453_1.text_.text = var_456_25
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_29 = math.max(var_456_23, arg_453_1.talkMaxDuration)

			if var_456_22 <= arg_453_1.time_ and arg_453_1.time_ < var_456_22 + var_456_29 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_22) / var_456_29

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_22 + var_456_29 and arg_453_1.time_ < var_456_22 + var_456_29 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play420191109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 420191109
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play420191110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.8

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(420191109)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 32
				local var_460_5 = utf8.len(var_460_3)
				local var_460_6 = var_460_4 <= 0 and var_460_1 or var_460_1 * (var_460_5 / var_460_4)

				if var_460_6 > 0 and var_460_1 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_7 and arg_457_1.time_ < var_460_0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play420191110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 420191110
		arg_461_1.duration_ = 6.77

		local var_461_0 = {
			zh = 4.633,
			ja = 6.766
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play420191111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["404001ui_story"].transform
			local var_464_1 = 3.10862446895044e-15

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos404001ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, -1.55, -5.5)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos404001ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["404001ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect404001ui_story == nil then
				arg_461_1.var_.characterEffect404001ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect404001ui_story and not isNil(var_464_9) then
					arg_461_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect404001ui_story then
				arg_461_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_464_13 = 3.10862446895044e-15

			if var_464_13 < arg_461_1.time_ and arg_461_1.time_ <= var_464_13 + arg_464_0 then
				arg_461_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_464_14 = 3.10862446895044e-15

			if var_464_14 < arg_461_1.time_ and arg_461_1.time_ <= var_464_14 + arg_464_0 then
				arg_461_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_464_15 = 0
			local var_464_16 = 0.425

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_17 = arg_461_1:FormatText(StoryNameCfg[668].name)

				arg_461_1.leftNameTxt_.text = var_464_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_18 = arg_461_1:GetWordFromCfg(420191110)
				local var_464_19 = arg_461_1:FormatText(var_464_18.content)

				arg_461_1.text_.text = var_464_19

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_20 = 17
				local var_464_21 = utf8.len(var_464_19)
				local var_464_22 = var_464_20 <= 0 and var_464_16 or var_464_16 * (var_464_21 / var_464_20)

				if var_464_22 > 0 and var_464_16 < var_464_22 then
					arg_461_1.talkMaxDuration = var_464_22

					if var_464_22 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_22 + var_464_15
					end
				end

				arg_461_1.text_.text = var_464_19
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191110", "story_v_out_420191.awb") ~= 0 then
					local var_464_23 = manager.audio:GetVoiceLength("story_v_out_420191", "420191110", "story_v_out_420191.awb") / 1000

					if var_464_23 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_23 + var_464_15
					end

					if var_464_18.prefab_name ~= "" and arg_461_1.actors_[var_464_18.prefab_name] ~= nil then
						local var_464_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_18.prefab_name].transform, "story_v_out_420191", "420191110", "story_v_out_420191.awb")

						arg_461_1:RecordAudio("420191110", var_464_24)
						arg_461_1:RecordAudio("420191110", var_464_24)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_420191", "420191110", "story_v_out_420191.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_420191", "420191110", "story_v_out_420191.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_25 = math.max(var_464_16, arg_461_1.talkMaxDuration)

			if var_464_15 <= arg_461_1.time_ and arg_461_1.time_ < var_464_15 + var_464_25 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_15) / var_464_25

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_15 + var_464_25 and arg_461_1.time_ < var_464_15 + var_464_25 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.10862446895044e-15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play420191111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 420191111
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play420191112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["404001ui_story"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect404001ui_story == nil then
				arg_465_1.var_.characterEffect404001ui_story = var_468_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.characterEffect404001ui_story and not isNil(var_468_0) then
					local var_468_4 = Mathf.Lerp(0, 0.5, var_468_3)

					arg_465_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_465_1.var_.characterEffect404001ui_story.fillRatio = var_468_4
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect404001ui_story then
				local var_468_5 = 0.5

				arg_465_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_465_1.var_.characterEffect404001ui_story.fillRatio = var_468_5
			end

			local var_468_6 = 0
			local var_468_7 = 0.65

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_8 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_9 = arg_465_1:GetWordFromCfg(420191111)
				local var_468_10 = arg_465_1:FormatText(var_468_9.content)

				arg_465_1.text_.text = var_468_10

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 26
				local var_468_12 = utf8.len(var_468_10)
				local var_468_13 = var_468_11 <= 0 and var_468_7 or var_468_7 * (var_468_12 / var_468_11)

				if var_468_13 > 0 and var_468_7 < var_468_13 then
					arg_465_1.talkMaxDuration = var_468_13

					if var_468_13 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_10
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_14 and arg_465_1.time_ < var_468_6 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play420191112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 420191112
		arg_469_1.duration_ = 7.23

		local var_469_0 = {
			zh = 7.233,
			ja = 7.166
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play420191113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["404001ui_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect404001ui_story == nil then
				arg_469_1.var_.characterEffect404001ui_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect404001ui_story and not isNil(var_472_0) then
					arg_469_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect404001ui_story then
				arg_469_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_472_4 = 0
			local var_472_5 = 0.85

			if var_472_4 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_6 = arg_469_1:FormatText(StoryNameCfg[668].name)

				arg_469_1.leftNameTxt_.text = var_472_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_7 = arg_469_1:GetWordFromCfg(420191112)
				local var_472_8 = arg_469_1:FormatText(var_472_7.content)

				arg_469_1.text_.text = var_472_8

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_9 = 34
				local var_472_10 = utf8.len(var_472_8)
				local var_472_11 = var_472_9 <= 0 and var_472_5 or var_472_5 * (var_472_10 / var_472_9)

				if var_472_11 > 0 and var_472_5 < var_472_11 then
					arg_469_1.talkMaxDuration = var_472_11

					if var_472_11 + var_472_4 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_4
					end
				end

				arg_469_1.text_.text = var_472_8
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191112", "story_v_out_420191.awb") ~= 0 then
					local var_472_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191112", "story_v_out_420191.awb") / 1000

					if var_472_12 + var_472_4 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_12 + var_472_4
					end

					if var_472_7.prefab_name ~= "" and arg_469_1.actors_[var_472_7.prefab_name] ~= nil then
						local var_472_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_7.prefab_name].transform, "story_v_out_420191", "420191112", "story_v_out_420191.awb")

						arg_469_1:RecordAudio("420191112", var_472_13)
						arg_469_1:RecordAudio("420191112", var_472_13)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_420191", "420191112", "story_v_out_420191.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_420191", "420191112", "story_v_out_420191.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_5, arg_469_1.talkMaxDuration)

			if var_472_4 <= arg_469_1.time_ and arg_469_1.time_ < var_472_4 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_4) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_4 + var_472_14 and arg_469_1.time_ < var_472_4 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play420191113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 420191113
		arg_473_1.duration_ = 6.07

		local var_473_0 = {
			zh = 4.333,
			ja = 6.066
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play420191114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.575

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[668].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_3 = arg_473_1:GetWordFromCfg(420191113)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 23
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191113", "story_v_out_420191.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191113", "story_v_out_420191.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_out_420191", "420191113", "story_v_out_420191.awb")

						arg_473_1:RecordAudio("420191113", var_476_9)
						arg_473_1:RecordAudio("420191113", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_420191", "420191113", "story_v_out_420191.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_420191", "420191113", "story_v_out_420191.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play420191114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 420191114
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play420191115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["404001ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect404001ui_story == nil then
				arg_477_1.var_.characterEffect404001ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect404001ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_477_1.var_.characterEffect404001ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect404001ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_477_1.var_.characterEffect404001ui_story.fillRatio = var_480_5
			end

			local var_480_6 = 0
			local var_480_7 = 0.825

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_9 = arg_477_1:GetWordFromCfg(420191114)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 33
				local var_480_12 = utf8.len(var_480_10)
				local var_480_13 = var_480_11 <= 0 and var_480_7 or var_480_7 * (var_480_12 / var_480_11)

				if var_480_13 > 0 and var_480_7 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_10
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play420191115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 420191115
		arg_481_1.duration_ = 9.1

		local var_481_0 = {
			zh = 7.533,
			ja = 9.1
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play420191116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["404001ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect404001ui_story == nil then
				arg_481_1.var_.characterEffect404001ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect404001ui_story and not isNil(var_484_0) then
					arg_481_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect404001ui_story then
				arg_481_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_484_4 = 0
			local var_484_5 = 0.725

			if var_484_4 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_6 = arg_481_1:FormatText(StoryNameCfg[668].name)

				arg_481_1.leftNameTxt_.text = var_484_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_7 = arg_481_1:GetWordFromCfg(420191115)
				local var_484_8 = arg_481_1:FormatText(var_484_7.content)

				arg_481_1.text_.text = var_484_8

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 29
				local var_484_10 = utf8.len(var_484_8)
				local var_484_11 = var_484_9 <= 0 and var_484_5 or var_484_5 * (var_484_10 / var_484_9)

				if var_484_11 > 0 and var_484_5 < var_484_11 then
					arg_481_1.talkMaxDuration = var_484_11

					if var_484_11 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_11 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_8
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191115", "story_v_out_420191.awb") ~= 0 then
					local var_484_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191115", "story_v_out_420191.awb") / 1000

					if var_484_12 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_12 + var_484_4
					end

					if var_484_7.prefab_name ~= "" and arg_481_1.actors_[var_484_7.prefab_name] ~= nil then
						local var_484_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_7.prefab_name].transform, "story_v_out_420191", "420191115", "story_v_out_420191.awb")

						arg_481_1:RecordAudio("420191115", var_484_13)
						arg_481_1:RecordAudio("420191115", var_484_13)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_420191", "420191115", "story_v_out_420191.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_420191", "420191115", "story_v_out_420191.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_14 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_14 and arg_481_1.time_ < var_484_4 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play420191116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 420191116
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play420191117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["404001ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos404001ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, 100, 0)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos404001ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, 100, 0)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = 0.05
			local var_488_10 = 1

			if var_488_9 < arg_485_1.time_ and arg_485_1.time_ <= var_488_9 + arg_488_0 then
				local var_488_11 = "play"
				local var_488_12 = "effect"

				arg_485_1:AudioAction(var_488_11, var_488_12, "se_story_side_1075", "se_story_side_1075_footstep_quiet", "")
			end

			local var_488_13 = 0
			local var_488_14 = 1.15

			if var_488_13 < arg_485_1.time_ and arg_485_1.time_ <= var_488_13 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_15 = arg_485_1:GetWordFromCfg(420191116)
				local var_488_16 = arg_485_1:FormatText(var_488_15.content)

				arg_485_1.text_.text = var_488_16

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_17 = 46
				local var_488_18 = utf8.len(var_488_16)
				local var_488_19 = var_488_17 <= 0 and var_488_14 or var_488_14 * (var_488_18 / var_488_17)

				if var_488_19 > 0 and var_488_14 < var_488_19 then
					arg_485_1.talkMaxDuration = var_488_19

					if var_488_19 + var_488_13 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_19 + var_488_13
					end
				end

				arg_485_1.text_.text = var_488_16
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_20 = math.max(var_488_14, arg_485_1.talkMaxDuration)

			if var_488_13 <= arg_485_1.time_ and arg_485_1.time_ < var_488_13 + var_488_20 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_13) / var_488_20

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_13 + var_488_20 and arg_485_1.time_ < var_488_13 + var_488_20 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play420191117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 420191117
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play420191118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.9
			local var_492_1 = 1

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				local var_492_2 = "play"
				local var_492_3 = "effect"

				arg_489_1:AudioAction(var_492_2, var_492_3, "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_492_4 = 0
			local var_492_5 = 0.55

			if var_492_4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_6 = arg_489_1:GetWordFromCfg(420191117)
				local var_492_7 = arg_489_1:FormatText(var_492_6.content)

				arg_489_1.text_.text = var_492_7

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_8 = 22
				local var_492_9 = utf8.len(var_492_7)
				local var_492_10 = var_492_8 <= 0 and var_492_5 or var_492_5 * (var_492_9 / var_492_8)

				if var_492_10 > 0 and var_492_5 < var_492_10 then
					arg_489_1.talkMaxDuration = var_492_10

					if var_492_10 + var_492_4 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_10 + var_492_4
					end
				end

				arg_489_1.text_.text = var_492_7
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_11 = math.max(var_492_5, arg_489_1.talkMaxDuration)

			if var_492_4 <= arg_489_1.time_ and arg_489_1.time_ < var_492_4 + var_492_11 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_4) / var_492_11

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_4 + var_492_11 and arg_489_1.time_ < var_492_4 + var_492_11 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play420191118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 420191118
		arg_493_1.duration_ = 9

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play420191119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 4

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			local var_496_1 = 0.633333333333333

			if arg_493_1.time_ >= var_496_0 + var_496_1 and arg_493_1.time_ < var_496_0 + var_496_1 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			local var_496_2 = 0

			if var_496_2 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_3 = 2

			if var_496_2 <= arg_493_1.time_ and arg_493_1.time_ < var_496_2 + var_496_3 then
				local var_496_4 = (arg_493_1.time_ - var_496_2) / var_496_3
				local var_496_5 = Color.New(0, 0, 0)

				var_496_5.a = Mathf.Lerp(0, 1, var_496_4)
				arg_493_1.mask_.color = var_496_5
			end

			if arg_493_1.time_ >= var_496_2 + var_496_3 and arg_493_1.time_ < var_496_2 + var_496_3 + arg_496_0 then
				local var_496_6 = Color.New(0, 0, 0)

				var_496_6.a = 1
				arg_493_1.mask_.color = var_496_6
			end

			local var_496_7 = 2

			if var_496_7 < arg_493_1.time_ and arg_493_1.time_ <= var_496_7 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_8 = 2

			if var_496_7 <= arg_493_1.time_ and arg_493_1.time_ < var_496_7 + var_496_8 then
				local var_496_9 = (arg_493_1.time_ - var_496_7) / var_496_8
				local var_496_10 = Color.New(0, 0, 0)

				var_496_10.a = Mathf.Lerp(1, 0, var_496_9)
				arg_493_1.mask_.color = var_496_10
			end

			if arg_493_1.time_ >= var_496_7 + var_496_8 and arg_493_1.time_ < var_496_7 + var_496_8 + arg_496_0 then
				local var_496_11 = Color.New(0, 0, 0)
				local var_496_12 = 0

				arg_493_1.mask_.enabled = false
				var_496_11.a = var_496_12
				arg_493_1.mask_.color = var_496_11
			end

			local var_496_13 = 1.83333333333333
			local var_496_14 = 1

			if var_496_13 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				local var_496_15 = "stop"
				local var_496_16 = "effect"

				arg_493_1:AudioAction(var_496_15, var_496_16, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_496_17 = 2
			local var_496_18 = 1

			if var_496_17 < arg_493_1.time_ and arg_493_1.time_ <= var_496_17 + arg_496_0 then
				local var_496_19 = "play"
				local var_496_20 = "music"

				arg_493_1:AudioAction(var_496_19, var_496_20, "bgm_activity_4_0_story_ui", "vocal", "bgm_activity_4_0_story_ui.awb")

				local var_496_21 = ""
				local var_496_22 = manager.audio:GetAudioName("bgm_activity_4_0_story_ui", "vocal")

				if var_496_22 ~= "" then
					if arg_493_1.bgmTxt_.text ~= var_496_22 and arg_493_1.bgmTxt_.text ~= "" then
						if arg_493_1.bgmTxt2_.text ~= "" then
							arg_493_1.bgmTxt_.text = arg_493_1.bgmTxt2_.text
						end

						arg_493_1.bgmTxt2_.text = var_496_22

						arg_493_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_493_1.bgmTxt_.text = var_496_22
						arg_493_1.bgmTxt2_.text = var_496_22
					end

					if arg_493_1.bgmTimer then
						arg_493_1.bgmTimer:Stop()

						arg_493_1.bgmTimer = nil
					end

					if arg_493_1.settingData.show_music_name == 1 then
						arg_493_1.musicController:SetSelectedState("show")
						arg_493_1.musicAnimator_:Play("open", 0, 0)

						if arg_493_1.settingData.music_time ~= 0 then
							arg_493_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_493_1.settingData.music_time), function()
								if arg_493_1 == nil or isNil(arg_493_1.bgmTxt_) then
									return
								end

								arg_493_1.musicController:SetSelectedState("hide")
								arg_493_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_496_23 = "SS2004"

			if arg_493_1.bgs_[var_496_23] == nil then
				local var_496_24 = Object.Instantiate(arg_493_1.paintGo_)

				var_496_24:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_496_23)
				var_496_24.name = var_496_23
				var_496_24.transform.parent = arg_493_1.stage_.transform
				var_496_24.transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.bgs_[var_496_23] = var_496_24
			end

			local var_496_25 = arg_493_1.bgs_.SS2004.transform
			local var_496_26 = 2

			if var_496_26 < arg_493_1.time_ and arg_493_1.time_ <= var_496_26 + arg_496_0 then
				arg_493_1.var_.moveOldPosSS2004 = var_496_25.localPosition
			end

			local var_496_27 = 0.001

			if var_496_26 <= arg_493_1.time_ and arg_493_1.time_ < var_496_26 + var_496_27 then
				local var_496_28 = (arg_493_1.time_ - var_496_26) / var_496_27
				local var_496_29 = Vector3.New(0, 1, 10)

				var_496_25.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosSS2004, var_496_29, var_496_28)
			end

			if arg_493_1.time_ >= var_496_26 + var_496_27 and arg_493_1.time_ < var_496_26 + var_496_27 + arg_496_0 then
				var_496_25.localPosition = Vector3.New(0, 1, 10)
			end

			local var_496_30 = arg_493_1.bgs_.SS2004.transform
			local var_496_31 = 2.03333333333333

			if var_496_31 < arg_493_1.time_ and arg_493_1.time_ <= var_496_31 + arg_496_0 then
				arg_493_1.var_.moveOldPosSS2004 = var_496_30.localPosition
			end

			local var_496_32 = 3.3

			if var_496_31 <= arg_493_1.time_ and arg_493_1.time_ < var_496_31 + var_496_32 then
				local var_496_33 = (arg_493_1.time_ - var_496_31) / var_496_32
				local var_496_34 = Vector3.New(0.5, 1, 9)

				var_496_30.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosSS2004, var_496_34, var_496_33)
			end

			if arg_493_1.time_ >= var_496_31 + var_496_32 and arg_493_1.time_ < var_496_31 + var_496_32 + arg_496_0 then
				var_496_30.localPosition = Vector3.New(0.5, 1, 9)
			end

			if arg_493_1.frameCnt_ <= 1 then
				arg_493_1.dialog_:SetActive(false)
			end

			local var_496_35 = 4
			local var_496_36 = 1.225

			if var_496_35 < arg_493_1.time_ and arg_493_1.time_ <= var_496_35 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0

				arg_493_1.dialog_:SetActive(true)

				arg_493_1.dialogCg_.alpha = 0

				local var_496_37 = LeanTween.value(arg_493_1.dialog_, 0, 1, 0.3)

				var_496_37:setOnUpdate(LuaHelper.FloatAction(function(arg_498_0)
					arg_493_1.dialogCg_.alpha = arg_498_0
				end))
				var_496_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_493_1.dialog_)
					var_496_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_493_1.duration_ = arg_493_1.duration_ + 0.3

				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_38 = arg_493_1:GetWordFromCfg(420191118)
				local var_496_39 = arg_493_1:FormatText(var_496_38.content)

				arg_493_1.text_.text = var_496_39

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_40 = 49
				local var_496_41 = utf8.len(var_496_39)
				local var_496_42 = var_496_40 <= 0 and var_496_36 or var_496_36 * (var_496_41 / var_496_40)

				if var_496_42 > 0 and var_496_36 < var_496_42 then
					arg_493_1.talkMaxDuration = var_496_42
					var_496_35 = var_496_35 + 0.3

					if var_496_42 + var_496_35 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_42 + var_496_35
					end
				end

				arg_493_1.text_.text = var_496_39
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_43 = var_496_35 + 0.3
			local var_496_44 = math.max(var_496_36, arg_493_1.talkMaxDuration)

			if var_496_43 <= arg_493_1.time_ and arg_493_1.time_ < var_496_43 + var_496_44 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_43) / var_496_44

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_43 + var_496_44 and arg_493_1.time_ < var_496_43 + var_496_44 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.3,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play420191119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 420191119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play420191120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 1.25

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_2 = arg_500_1:GetWordFromCfg(420191119)
				local var_503_3 = arg_500_1:FormatText(var_503_2.content)

				arg_500_1.text_.text = var_503_3

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 50
				local var_503_5 = utf8.len(var_503_3)
				local var_503_6 = var_503_4 <= 0 and var_503_1 or var_503_1 * (var_503_5 / var_503_4)

				if var_503_6 > 0 and var_503_1 < var_503_6 then
					arg_500_1.talkMaxDuration = var_503_6

					if var_503_6 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_6 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_3
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_7 and arg_500_1.time_ < var_503_0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play420191120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 420191120
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play420191121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.775

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_2 = arg_504_1:GetWordFromCfg(420191120)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 31
				local var_507_5 = utf8.len(var_507_3)
				local var_507_6 = var_507_4 <= 0 and var_507_1 or var_507_1 * (var_507_5 / var_507_4)

				if var_507_6 > 0 and var_507_1 < var_507_6 then
					arg_504_1.talkMaxDuration = var_507_6

					if var_507_6 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_6 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_7 and arg_504_1.time_ < var_507_0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play420191121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 420191121
		arg_508_1.duration_ = 3.6

		local var_508_0 = {
			zh = 3.6,
			ja = 3.466
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play420191122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.bgs_.SS2004.transform
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.var_.moveOldPosSS2004 = var_511_0.localPosition
			end

			local var_511_2 = 0.125

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2
				local var_511_4 = Vector3.New(0.5, 1, 9)

				var_511_0.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPosSS2004, var_511_4, var_511_3)
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 then
				var_511_0.localPosition = Vector3.New(0.5, 1, 9)
			end

			local var_511_5 = arg_508_1.bgs_.SS2004.transform
			local var_511_6 = 0.125

			if var_511_6 < arg_508_1.time_ and arg_508_1.time_ <= var_511_6 + arg_511_0 then
				arg_508_1.var_.moveOldPosSS2004 = var_511_5.localPosition
			end

			local var_511_7 = 1.875

			if var_511_6 <= arg_508_1.time_ and arg_508_1.time_ < var_511_6 + var_511_7 then
				local var_511_8 = (arg_508_1.time_ - var_511_6) / var_511_7
				local var_511_9 = Vector3.New(0.6, 0.8, 8.5)

				var_511_5.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPosSS2004, var_511_9, var_511_8)
			end

			if arg_508_1.time_ >= var_511_6 + var_511_7 and arg_508_1.time_ < var_511_6 + var_511_7 + arg_511_0 then
				var_511_5.localPosition = Vector3.New(0.6, 0.8, 8.5)
			end

			if arg_508_1.frameCnt_ <= 1 then
				arg_508_1.dialog_:SetActive(false)
			end

			local var_511_10 = 2
			local var_511_11 = 0.125

			if var_511_10 < arg_508_1.time_ and arg_508_1.time_ <= var_511_10 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0

				arg_508_1.dialog_:SetActive(true)

				arg_508_1.dialogCg_.alpha = 0

				local var_511_12 = LeanTween.value(arg_508_1.dialog_, 0, 1, 0.3)

				var_511_12:setOnUpdate(LuaHelper.FloatAction(function(arg_512_0)
					arg_508_1.dialogCg_.alpha = arg_512_0
				end))
				var_511_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_508_1.dialog_)
					var_511_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_508_1.duration_ = arg_508_1.duration_ + 0.3

				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_13 = arg_508_1:FormatText(StoryNameCfg[328].name)

				arg_508_1.leftNameTxt_.text = var_511_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_14 = arg_508_1:GetWordFromCfg(420191121)
				local var_511_15 = arg_508_1:FormatText(var_511_14.content)

				arg_508_1.text_.text = var_511_15

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_16 = 5
				local var_511_17 = utf8.len(var_511_15)
				local var_511_18 = var_511_16 <= 0 and var_511_11 or var_511_11 * (var_511_17 / var_511_16)

				if var_511_18 > 0 and var_511_11 < var_511_18 then
					arg_508_1.talkMaxDuration = var_511_18
					var_511_10 = var_511_10 + 0.3

					if var_511_18 + var_511_10 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_18 + var_511_10
					end
				end

				arg_508_1.text_.text = var_511_15
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191121", "story_v_out_420191.awb") ~= 0 then
					local var_511_19 = manager.audio:GetVoiceLength("story_v_out_420191", "420191121", "story_v_out_420191.awb") / 1000

					if var_511_19 + var_511_10 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_19 + var_511_10
					end

					if var_511_14.prefab_name ~= "" and arg_508_1.actors_[var_511_14.prefab_name] ~= nil then
						local var_511_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_14.prefab_name].transform, "story_v_out_420191", "420191121", "story_v_out_420191.awb")

						arg_508_1:RecordAudio("420191121", var_511_20)
						arg_508_1:RecordAudio("420191121", var_511_20)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_420191", "420191121", "story_v_out_420191.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_420191", "420191121", "story_v_out_420191.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_21 = var_511_10 + 0.3
			local var_511_22 = math.max(var_511_11, arg_508_1.talkMaxDuration)

			if var_511_21 <= arg_508_1.time_ and arg_508_1.time_ < var_511_21 + var_511_22 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_21) / var_511_22

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_21 + var_511_22 and arg_508_1.time_ < var_511_21 + var_511_22 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.125,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.875,
				className = "StoryMoveNode",
				startTime = 0.125,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play420191122 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 420191122
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play420191123(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0
			local var_517_1 = 0.075

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_2 = arg_514_1:FormatText(StoryNameCfg[7].name)

				arg_514_1.leftNameTxt_.text = var_517_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_3 = arg_514_1:GetWordFromCfg(420191122)
				local var_517_4 = arg_514_1:FormatText(var_517_3.content)

				arg_514_1.text_.text = var_517_4

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 3
				local var_517_6 = utf8.len(var_517_4)
				local var_517_7 = var_517_5 <= 0 and var_517_1 or var_517_1 * (var_517_6 / var_517_5)

				if var_517_7 > 0 and var_517_1 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_0
					end
				end

				arg_514_1.text_.text = var_517_4
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_8 = math.max(var_517_1, arg_514_1.talkMaxDuration)

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_8 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_0) / var_517_8

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_0 + var_517_8 and arg_514_1.time_ < var_517_0 + var_517_8 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play420191123 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 420191123
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play420191124(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0.233333333332
			local var_521_1 = 1

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				local var_521_2 = "play"
				local var_521_3 = "effect"

				arg_518_1:AudioAction(var_521_2, var_521_3, "se_story_140", "se_story_140_curtain01", "")
			end

			local var_521_4 = 0
			local var_521_5 = 0.85

			if var_521_4 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(420191123)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_8 = 34
				local var_521_9 = utf8.len(var_521_7)
				local var_521_10 = var_521_8 <= 0 and var_521_5 or var_521_5 * (var_521_9 / var_521_8)

				if var_521_10 > 0 and var_521_5 < var_521_10 then
					arg_518_1.talkMaxDuration = var_521_10

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_11 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_11 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_11

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_11 and arg_518_1.time_ < var_521_4 + var_521_11 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play420191124 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 420191124
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play420191125(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = manager.ui.mainCamera.transform
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				local var_525_2 = arg_522_1.var_.effect11118
				local var_525_3
				local var_525_4 = var_525_0

				if not var_525_2 then
					var_525_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_guangban"), var_525_4)
					var_525_2.name = "11118"
					arg_522_1.var_.effect11118 = var_525_2
				else
					var_525_2.transform:SetParent(var_525_4)
				end

				var_525_2.transform.localPosition = Vector3.New(1.57, 0.49, -0.66)
				var_525_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_525_5 = 0
			local var_525_6 = 1.05

			if var_525_5 < arg_522_1.time_ and arg_522_1.time_ <= var_525_5 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_7 = arg_522_1:GetWordFromCfg(420191124)
				local var_525_8 = arg_522_1:FormatText(var_525_7.content)

				arg_522_1.text_.text = var_525_8

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 42
				local var_525_10 = utf8.len(var_525_8)
				local var_525_11 = var_525_9 <= 0 and var_525_6 or var_525_6 * (var_525_10 / var_525_9)

				if var_525_11 > 0 and var_525_6 < var_525_11 then
					arg_522_1.talkMaxDuration = var_525_11

					if var_525_11 + var_525_5 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_11 + var_525_5
					end
				end

				arg_522_1.text_.text = var_525_8
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_6, arg_522_1.talkMaxDuration)

			if var_525_5 <= arg_522_1.time_ and arg_522_1.time_ < var_525_5 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_5) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_5 + var_525_12 and arg_522_1.time_ < var_525_5 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play420191125 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 420191125
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play420191126(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 1.1

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_2 = arg_526_1:GetWordFromCfg(420191125)
				local var_529_3 = arg_526_1:FormatText(var_529_2.content)

				arg_526_1.text_.text = var_529_3

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_4 = 44
				local var_529_5 = utf8.len(var_529_3)
				local var_529_6 = var_529_4 <= 0 and var_529_1 or var_529_1 * (var_529_5 / var_529_4)

				if var_529_6 > 0 and var_529_1 < var_529_6 then
					arg_526_1.talkMaxDuration = var_529_6

					if var_529_6 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_6 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_3
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_7 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_7 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_7

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_7 and arg_526_1.time_ < var_529_0 + var_529_7 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play420191126 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 420191126
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play420191127(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0
			local var_533_1 = 0.825

			if var_533_0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_2 = arg_530_1:GetWordFromCfg(420191126)
				local var_533_3 = arg_530_1:FormatText(var_533_2.content)

				arg_530_1.text_.text = var_533_3

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_4 = 33
				local var_533_5 = utf8.len(var_533_3)
				local var_533_6 = var_533_4 <= 0 and var_533_1 or var_533_1 * (var_533_5 / var_533_4)

				if var_533_6 > 0 and var_533_1 < var_533_6 then
					arg_530_1.talkMaxDuration = var_533_6

					if var_533_6 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_6 + var_533_0
					end
				end

				arg_530_1.text_.text = var_533_3
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_7 = math.max(var_533_1, arg_530_1.talkMaxDuration)

			if var_533_0 <= arg_530_1.time_ and arg_530_1.time_ < var_533_0 + var_533_7 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_0) / var_533_7

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_0 + var_533_7 and arg_530_1.time_ < var_533_0 + var_533_7 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play420191127 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 420191127
		arg_534_1.duration_ = 1

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"

			SetActive(arg_534_1.choicesGo_, true)

			for iter_535_0, iter_535_1 in ipairs(arg_534_1.choices_) do
				local var_535_0 = iter_535_0 <= 1

				SetActive(iter_535_1.go, var_535_0)
			end

			arg_534_1.choices_[1].txt.text = arg_534_1:FormatText(StoryChoiceCfg[1245].name)
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play420191128(arg_534_1)
			end

			arg_534_1:RecordChoiceLog(420191127, 1245)
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			return
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play420191128 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 420191128
		arg_538_1.duration_ = 4.67

		local var_538_0 = {
			zh = 4.199999999999,
			ja = 4.666
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play420191129(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_1 = 1

			if var_541_0 <= arg_538_1.time_ and arg_538_1.time_ < var_541_0 + var_541_1 then
				local var_541_2 = (arg_538_1.time_ - var_541_0) / var_541_1
				local var_541_3 = Color.New(1, 1, 1)

				var_541_3.a = Mathf.Lerp(1, 0, var_541_2)
				arg_538_1.mask_.color = var_541_3
			end

			if arg_538_1.time_ >= var_541_0 + var_541_1 and arg_538_1.time_ < var_541_0 + var_541_1 + arg_541_0 then
				local var_541_4 = Color.New(1, 1, 1)
				local var_541_5 = 0

				arg_538_1.mask_.enabled = false
				var_541_4.a = var_541_5
				arg_538_1.mask_.color = var_541_4
			end

			local var_541_6 = "SS2004a"

			if arg_538_1.bgs_[var_541_6] == nil then
				local var_541_7 = Object.Instantiate(arg_538_1.paintGo_)

				var_541_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_541_6)
				var_541_7.name = var_541_6
				var_541_7.transform.parent = arg_538_1.stage_.transform
				var_541_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_538_1.bgs_[var_541_6] = var_541_7
			end

			local var_541_8 = 0

			if var_541_8 < arg_538_1.time_ and arg_538_1.time_ <= var_541_8 + arg_541_0 then
				local var_541_9 = manager.ui.mainCamera.transform.localPosition
				local var_541_10 = Vector3.New(0, 0, 10) + Vector3.New(var_541_9.x, var_541_9.y, 0)
				local var_541_11 = arg_538_1.bgs_.SS2004a

				var_541_11.transform.localPosition = var_541_10
				var_541_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_541_12 = var_541_11:GetComponent("SpriteRenderer")

				if var_541_12 and var_541_12.sprite then
					local var_541_13 = (var_541_11.transform.localPosition - var_541_9).z
					local var_541_14 = manager.ui.mainCameraCom_
					local var_541_15 = 2 * var_541_13 * Mathf.Tan(var_541_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_541_16 = var_541_15 * var_541_14.aspect
					local var_541_17 = var_541_12.sprite.bounds.size.x
					local var_541_18 = var_541_12.sprite.bounds.size.y
					local var_541_19 = var_541_16 / var_541_17
					local var_541_20 = var_541_15 / var_541_18
					local var_541_21 = var_541_20 < var_541_19 and var_541_19 or var_541_20

					var_541_11.transform.localScale = Vector3.New(var_541_21, var_541_21, 0)
				end

				for iter_541_0, iter_541_1 in pairs(arg_538_1.bgs_) do
					if iter_541_0 ~= "SS2004a" then
						iter_541_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_538_1.frameCnt_ <= 1 then
				arg_538_1.dialog_:SetActive(false)
			end

			local var_541_22 = 1
			local var_541_23 = 0.2

			if var_541_22 < arg_538_1.time_ and arg_538_1.time_ <= var_541_22 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0

				arg_538_1.dialog_:SetActive(true)

				arg_538_1.dialogCg_.alpha = 0

				local var_541_24 = LeanTween.value(arg_538_1.dialog_, 0, 1, 0.3)

				var_541_24:setOnUpdate(LuaHelper.FloatAction(function(arg_542_0)
					arg_538_1.dialogCg_.alpha = arg_542_0
				end))
				var_541_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_538_1.dialog_)
					var_541_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_538_1.duration_ = arg_538_1.duration_ + 0.3

				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_25 = arg_538_1:FormatText(StoryNameCfg[328].name)

				arg_538_1.leftNameTxt_.text = var_541_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_26 = arg_538_1:GetWordFromCfg(420191128)
				local var_541_27 = arg_538_1:FormatText(var_541_26.content)

				arg_538_1.text_.text = var_541_27

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_28 = 8
				local var_541_29 = utf8.len(var_541_27)
				local var_541_30 = var_541_28 <= 0 and var_541_23 or var_541_23 * (var_541_29 / var_541_28)

				if var_541_30 > 0 and var_541_23 < var_541_30 then
					arg_538_1.talkMaxDuration = var_541_30
					var_541_22 = var_541_22 + 0.3

					if var_541_30 + var_541_22 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_30 + var_541_22
					end
				end

				arg_538_1.text_.text = var_541_27
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191128", "story_v_out_420191.awb") ~= 0 then
					local var_541_31 = manager.audio:GetVoiceLength("story_v_out_420191", "420191128", "story_v_out_420191.awb") / 1000

					if var_541_31 + var_541_22 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_31 + var_541_22
					end

					if var_541_26.prefab_name ~= "" and arg_538_1.actors_[var_541_26.prefab_name] ~= nil then
						local var_541_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_26.prefab_name].transform, "story_v_out_420191", "420191128", "story_v_out_420191.awb")

						arg_538_1:RecordAudio("420191128", var_541_32)
						arg_538_1:RecordAudio("420191128", var_541_32)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_420191", "420191128", "story_v_out_420191.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_420191", "420191128", "story_v_out_420191.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_33 = var_541_22 + 0.3
			local var_541_34 = math.max(var_541_23, arg_538_1.talkMaxDuration)

			if var_541_33 <= arg_538_1.time_ and arg_538_1.time_ < var_541_33 + var_541_34 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_33) / var_541_34

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_33 + var_541_34 and arg_538_1.time_ < var_541_33 + var_541_34 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play420191129 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 420191129
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play420191130(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1085ui_story"]
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1085ui_story == nil then
				arg_544_1.var_.characterEffect1085ui_story = var_547_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_2 = 0.200000002980232

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 and not isNil(var_547_0) then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2

				if arg_544_1.var_.characterEffect1085ui_story and not isNil(var_547_0) then
					local var_547_4 = Mathf.Lerp(0, 0.5, var_547_3)

					arg_544_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_544_1.var_.characterEffect1085ui_story.fillRatio = var_547_4
				end
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1085ui_story then
				local var_547_5 = 0.5

				arg_544_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_544_1.var_.characterEffect1085ui_story.fillRatio = var_547_5
			end

			local var_547_6 = 0.200000002980232
			local var_547_7 = 1

			if var_547_6 < arg_544_1.time_ and arg_544_1.time_ <= var_547_6 + arg_547_0 then
				local var_547_8 = "play"
				local var_547_9 = "effect"

				arg_544_1:AudioAction(var_547_8, var_547_9, "se_story_140", "se_story_140_foley_glass", "")
			end

			local var_547_10 = 0
			local var_547_11 = 0.925

			if var_547_10 < arg_544_1.time_ and arg_544_1.time_ <= var_547_10 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_12 = arg_544_1:GetWordFromCfg(420191129)
				local var_547_13 = arg_544_1:FormatText(var_547_12.content)

				arg_544_1.text_.text = var_547_13

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_14 = 37
				local var_547_15 = utf8.len(var_547_13)
				local var_547_16 = var_547_14 <= 0 and var_547_11 or var_547_11 * (var_547_15 / var_547_14)

				if var_547_16 > 0 and var_547_11 < var_547_16 then
					arg_544_1.talkMaxDuration = var_547_16

					if var_547_16 + var_547_10 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_16 + var_547_10
					end
				end

				arg_544_1.text_.text = var_547_13
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_17 = math.max(var_547_11, arg_544_1.talkMaxDuration)

			if var_547_10 <= arg_544_1.time_ and arg_544_1.time_ < var_547_10 + var_547_17 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_10) / var_547_17

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_10 + var_547_17 and arg_544_1.time_ < var_547_10 + var_547_17 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play420191130 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 420191130
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play420191131(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 0.925

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_2 = arg_548_1:GetWordFromCfg(420191130)
				local var_551_3 = arg_548_1:FormatText(var_551_2.content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 37
				local var_551_5 = utf8.len(var_551_3)
				local var_551_6 = var_551_4 <= 0 and var_551_1 or var_551_1 * (var_551_5 / var_551_4)

				if var_551_6 > 0 and var_551_1 < var_551_6 then
					arg_548_1.talkMaxDuration = var_551_6

					if var_551_6 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_6 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_7 and arg_548_1.time_ < var_551_0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play420191131 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 420191131
		arg_552_1.duration_ = 4.15

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play420191132(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 2

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				local var_555_1 = manager.ui.mainCamera.transform.localPosition
				local var_555_2 = Vector3.New(0, 0, 10) + Vector3.New(var_555_1.x, var_555_1.y, 0)
				local var_555_3 = arg_552_1.bgs_.STblack

				var_555_3.transform.localPosition = var_555_2
				var_555_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_555_4 = var_555_3:GetComponent("SpriteRenderer")

				if var_555_4 and var_555_4.sprite then
					local var_555_5 = (var_555_3.transform.localPosition - var_555_1).z
					local var_555_6 = manager.ui.mainCameraCom_
					local var_555_7 = 2 * var_555_5 * Mathf.Tan(var_555_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_555_8 = var_555_7 * var_555_6.aspect
					local var_555_9 = var_555_4.sprite.bounds.size.x
					local var_555_10 = var_555_4.sprite.bounds.size.y
					local var_555_11 = var_555_8 / var_555_9
					local var_555_12 = var_555_7 / var_555_10
					local var_555_13 = var_555_12 < var_555_11 and var_555_11 or var_555_12

					var_555_3.transform.localScale = Vector3.New(var_555_13, var_555_13, 0)
				end

				for iter_555_0, iter_555_1 in pairs(arg_552_1.bgs_) do
					if iter_555_0 ~= "STblack" then
						iter_555_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_555_14 = 0

			if var_555_14 < arg_552_1.time_ and arg_552_1.time_ <= var_555_14 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_15 = 2

			if var_555_14 <= arg_552_1.time_ and arg_552_1.time_ < var_555_14 + var_555_15 then
				local var_555_16 = (arg_552_1.time_ - var_555_14) / var_555_15
				local var_555_17 = Color.New(0, 0, 0)

				var_555_17.a = Mathf.Lerp(0, 1, var_555_16)
				arg_552_1.mask_.color = var_555_17
			end

			if arg_552_1.time_ >= var_555_14 + var_555_15 and arg_552_1.time_ < var_555_14 + var_555_15 + arg_555_0 then
				local var_555_18 = Color.New(0, 0, 0)

				var_555_18.a = 1
				arg_552_1.mask_.color = var_555_18
			end

			local var_555_19 = 2

			if var_555_19 < arg_552_1.time_ and arg_552_1.time_ <= var_555_19 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_20 = 2

			if var_555_19 <= arg_552_1.time_ and arg_552_1.time_ < var_555_19 + var_555_20 then
				local var_555_21 = (arg_552_1.time_ - var_555_19) / var_555_20
				local var_555_22 = Color.New(0, 0, 0)

				var_555_22.a = Mathf.Lerp(1, 0, var_555_21)
				arg_552_1.mask_.color = var_555_22
			end

			if arg_552_1.time_ >= var_555_19 + var_555_20 and arg_552_1.time_ < var_555_19 + var_555_20 + arg_555_0 then
				local var_555_23 = Color.New(0, 0, 0)
				local var_555_24 = 0

				arg_552_1.mask_.enabled = false
				var_555_23.a = var_555_24
				arg_552_1.mask_.color = var_555_23
			end

			local var_555_25 = 2

			if var_555_25 < arg_552_1.time_ and arg_552_1.time_ <= var_555_25 + arg_555_0 then
				arg_552_1.fswbg_:SetActive(true)
				arg_552_1.dialog_:SetActive(false)

				arg_552_1.fswtw_.percent = 0

				local var_555_26 = arg_552_1:GetWordFromCfg(420191131)
				local var_555_27 = arg_552_1:FormatText(var_555_26.content)

				arg_552_1.fswt_.text = var_555_27

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.fswt_)

				arg_552_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_552_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_552_1.fswtw_:SetDirty()

				arg_552_1.typewritterCharCountI18N = 0

				SetActive(arg_552_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_552_1:ShowNextGo(false)
			end

			local var_555_28 = 3.3

			if var_555_28 < arg_552_1.time_ and arg_552_1.time_ <= var_555_28 + arg_555_0 then
				arg_552_1.var_.oldValueTypewriter = arg_552_1.fswtw_.percent

				SetActive(arg_552_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_552_1:ShowNextGo(false)
			end

			local var_555_29 = 6
			local var_555_30 = 0.4
			local var_555_31 = arg_552_1:GetWordFromCfg(420191131)
			local var_555_32 = arg_552_1:FormatText(var_555_31.content)
			local var_555_33, var_555_34 = arg_552_1:GetPercentByPara(var_555_32, 1)

			if var_555_28 < arg_552_1.time_ and arg_552_1.time_ <= var_555_28 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0

				local var_555_35 = var_555_29 <= 0 and var_555_30 or var_555_30 * ((var_555_34 - arg_552_1.typewritterCharCountI18N) / var_555_29)

				if var_555_35 > 0 and var_555_30 < var_555_35 then
					arg_552_1.talkMaxDuration = var_555_35

					if var_555_35 + var_555_28 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_35 + var_555_28
					end
				end
			end

			local var_555_36 = 0.4
			local var_555_37 = math.max(var_555_36, arg_552_1.talkMaxDuration)

			if var_555_28 <= arg_552_1.time_ and arg_552_1.time_ < var_555_28 + var_555_37 then
				local var_555_38 = (arg_552_1.time_ - var_555_28) / var_555_37

				arg_552_1.fswtw_.percent = Mathf.Lerp(arg_552_1.var_.oldValueTypewriter, var_555_33, var_555_38)
				arg_552_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_552_1.fswtw_:SetDirty()
			end

			if arg_552_1.time_ >= var_555_28 + var_555_37 and arg_552_1.time_ < var_555_28 + var_555_37 + arg_555_0 then
				arg_552_1.fswtw_.percent = var_555_33

				arg_552_1.fswtw_:SetDirty()
				arg_552_1:ShowNextGo(true)

				arg_552_1.typewritterCharCountI18N = var_555_34
			end

			local var_555_39 = 2

			if var_555_39 < arg_552_1.time_ and arg_552_1.time_ <= var_555_39 + arg_555_0 then
				local var_555_40 = arg_552_1.fswbg_.transform:Find("textbox/adapt/content") or arg_552_1.fswbg_.transform:Find("textbox/content")
				local var_555_41 = arg_552_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_555_42 = var_555_40:GetComponent("Text")
				local var_555_43 = var_555_40:GetComponent("RectTransform")

				var_555_42.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_555_43.offsetMin = Vector2.New(0, -70)
				var_555_43.offsetMax = Vector2.New(0, 0)
			end

			local var_555_44 = manager.ui.mainCamera.transform
			local var_555_45 = 1.66666666666667

			if var_555_45 < arg_552_1.time_ and arg_552_1.time_ <= var_555_45 + arg_555_0 then
				local var_555_46 = arg_552_1.var_.effect11118

				if var_555_46 then
					Object.Destroy(var_555_46)

					arg_552_1.var_.effect11118 = nil
				end
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play420191132 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 420191132
		arg_556_1.duration_ = 2.42

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play420191133(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.fswbg_:SetActive(true)
				arg_556_1.dialog_:SetActive(false)

				arg_556_1.fswtw_.percent = 0

				local var_559_1 = arg_556_1:GetWordFromCfg(420191132)
				local var_559_2 = arg_556_1:FormatText(var_559_1.content)

				arg_556_1.fswt_.text = var_559_2

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.fswt_)

				arg_556_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_556_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_556_1.fswtw_:SetDirty()

				arg_556_1.typewritterCharCountI18N = 0

				SetActive(arg_556_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_556_1:ShowNextGo(false)
			end

			local var_559_3 = 0.0166666666666667

			if var_559_3 < arg_556_1.time_ and arg_556_1.time_ <= var_559_3 + arg_559_0 then
				arg_556_1.var_.oldValueTypewriter = arg_556_1.fswtw_.percent

				SetActive(arg_556_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_556_1:ShowNextGo(false)
			end

			local var_559_4 = 36
			local var_559_5 = 2.4
			local var_559_6 = arg_556_1:GetWordFromCfg(420191132)
			local var_559_7 = arg_556_1:FormatText(var_559_6.content)
			local var_559_8, var_559_9 = arg_556_1:GetPercentByPara(var_559_7, 1)

			if var_559_3 < arg_556_1.time_ and arg_556_1.time_ <= var_559_3 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				local var_559_10 = var_559_4 <= 0 and var_559_5 or var_559_5 * ((var_559_9 - arg_556_1.typewritterCharCountI18N) / var_559_4)

				if var_559_10 > 0 and var_559_5 < var_559_10 then
					arg_556_1.talkMaxDuration = var_559_10

					if var_559_10 + var_559_3 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_10 + var_559_3
					end
				end
			end

			local var_559_11 = 2.4
			local var_559_12 = math.max(var_559_11, arg_556_1.talkMaxDuration)

			if var_559_3 <= arg_556_1.time_ and arg_556_1.time_ < var_559_3 + var_559_12 then
				local var_559_13 = (arg_556_1.time_ - var_559_3) / var_559_12

				arg_556_1.fswtw_.percent = Mathf.Lerp(arg_556_1.var_.oldValueTypewriter, var_559_8, var_559_13)
				arg_556_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_556_1.fswtw_:SetDirty()
			end

			if arg_556_1.time_ >= var_559_3 + var_559_12 and arg_556_1.time_ < var_559_3 + var_559_12 + arg_559_0 then
				arg_556_1.fswtw_.percent = var_559_8

				arg_556_1.fswtw_:SetDirty()
				arg_556_1:ShowNextGo(true)

				arg_556_1.typewritterCharCountI18N = var_559_9
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play420191133 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 420191133
		arg_560_1.duration_ = 3.02

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play420191134(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.fswbg_:SetActive(true)
				arg_560_1.dialog_:SetActive(false)

				arg_560_1.fswtw_.percent = 0

				local var_563_1 = arg_560_1:GetWordFromCfg(420191133)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.fswt_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.fswt_)

				arg_560_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_560_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_560_1.fswtw_:SetDirty()

				arg_560_1.typewritterCharCountI18N = 0

				SetActive(arg_560_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_560_1:ShowNextGo(false)
			end

			local var_563_3 = 0.0166666666666667

			if var_563_3 < arg_560_1.time_ and arg_560_1.time_ <= var_563_3 + arg_563_0 then
				arg_560_1.var_.oldValueTypewriter = arg_560_1.fswtw_.percent

				SetActive(arg_560_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_560_1:ShowNextGo(false)
			end

			local var_563_4 = 30
			local var_563_5 = 3
			local var_563_6 = arg_560_1:GetWordFromCfg(420191133)
			local var_563_7 = arg_560_1:FormatText(var_563_6.content)
			local var_563_8, var_563_9 = arg_560_1:GetPercentByPara(var_563_7, 1)

			if var_563_3 < arg_560_1.time_ and arg_560_1.time_ <= var_563_3 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0

				local var_563_10 = var_563_4 <= 0 and var_563_5 or var_563_5 * ((var_563_9 - arg_560_1.typewritterCharCountI18N) / var_563_4)

				if var_563_10 > 0 and var_563_5 < var_563_10 then
					arg_560_1.talkMaxDuration = var_563_10

					if var_563_10 + var_563_3 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_10 + var_563_3
					end
				end
			end

			local var_563_11 = 3
			local var_563_12 = math.max(var_563_11, arg_560_1.talkMaxDuration)

			if var_563_3 <= arg_560_1.time_ and arg_560_1.time_ < var_563_3 + var_563_12 then
				local var_563_13 = (arg_560_1.time_ - var_563_3) / var_563_12

				arg_560_1.fswtw_.percent = Mathf.Lerp(arg_560_1.var_.oldValueTypewriter, var_563_8, var_563_13)
				arg_560_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_560_1.fswtw_:SetDirty()
			end

			if arg_560_1.time_ >= var_563_3 + var_563_12 and arg_560_1.time_ < var_563_3 + var_563_12 + arg_563_0 then
				arg_560_1.fswtw_.percent = var_563_8

				arg_560_1.fswtw_:SetDirty()
				arg_560_1:ShowNextGo(true)

				arg_560_1.typewritterCharCountI18N = var_563_9
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play420191134 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 420191134
		arg_564_1.duration_ = 4.97

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
			arg_564_1.auto_ = false
		end

		function arg_564_1.playNext_(arg_566_0)
			arg_564_1.onStoryFinished_()
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.fswbg_:SetActive(true)
				arg_564_1.dialog_:SetActive(false)

				arg_564_1.fswtw_.percent = 0

				local var_567_1 = arg_564_1:GetWordFromCfg(420191134)
				local var_567_2 = arg_564_1:FormatText(var_567_1.content)

				arg_564_1.fswt_.text = var_567_2

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.fswt_)

				arg_564_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_564_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_564_1.fswtw_:SetDirty()

				arg_564_1.typewritterCharCountI18N = 0

				SetActive(arg_564_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_564_1:ShowNextGo(false)
			end

			local var_567_3 = 0.0166666666666667

			if var_567_3 < arg_564_1.time_ and arg_564_1.time_ <= var_567_3 + arg_567_0 then
				arg_564_1.var_.oldValueTypewriter = arg_564_1.fswtw_.percent

				SetActive(arg_564_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_564_1:ShowNextGo(false)
			end

			local var_567_4 = 32
			local var_567_5 = 2.13333333333333
			local var_567_6 = arg_564_1:GetWordFromCfg(420191134)
			local var_567_7 = arg_564_1:FormatText(var_567_6.content)
			local var_567_8, var_567_9 = arg_564_1:GetPercentByPara(var_567_7, 2)

			if var_567_3 < arg_564_1.time_ and arg_564_1.time_ <= var_567_3 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0

				local var_567_10 = var_567_4 <= 0 and var_567_5 or var_567_5 * ((var_567_9 - arg_564_1.typewritterCharCountI18N) / var_567_4)

				if var_567_10 > 0 and var_567_5 < var_567_10 then
					arg_564_1.talkMaxDuration = var_567_10

					if var_567_10 + var_567_3 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_10 + var_567_3
					end
				end
			end

			local var_567_11 = 2.13333333333333
			local var_567_12 = math.max(var_567_11, arg_564_1.talkMaxDuration)

			if var_567_3 <= arg_564_1.time_ and arg_564_1.time_ < var_567_3 + var_567_12 then
				local var_567_13 = (arg_564_1.time_ - var_567_3) / var_567_12

				arg_564_1.fswtw_.percent = Mathf.Lerp(arg_564_1.var_.oldValueTypewriter, var_567_8, var_567_13)
				arg_564_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_564_1.fswtw_:SetDirty()
			end

			if arg_564_1.time_ >= var_567_3 + var_567_12 and arg_564_1.time_ < var_567_3 + var_567_12 + arg_567_0 then
				arg_564_1.fswtw_.percent = var_567_8

				arg_564_1.fswtw_:SetDirty()
				arg_564_1:ShowNextGo(true)

				arg_564_1.typewritterCharCountI18N = var_567_9
			end

			local var_567_14 = 0

			if var_567_14 < arg_564_1.time_ and arg_564_1.time_ <= var_567_14 + arg_567_0 then
				arg_564_1.allBtn_.enabled = false
			end

			local var_567_15 = 1.33333333333333

			if arg_564_1.time_ >= var_567_14 + var_567_15 and arg_564_1.time_ < var_567_14 + var_567_15 + arg_567_0 then
				arg_564_1.allBtn_.enabled = true
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS2005",
		"TextureConfig/Background/ST76",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L16I",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/SS2004a"
	},
	voices = {
		"story_v_out_420191.awb"
	}
}
