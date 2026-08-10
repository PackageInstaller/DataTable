return {
	Play938072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938072001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I20f"

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
				local var_4_5 = arg_1_1.bgs_.I20f

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
					if iter_4_0 ~= "I20f" then
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

			local var_4_24 = 0.3
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.525

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(938072001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 21
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play938072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.675

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(938072002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 67
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938072003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.1

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(938072003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 4
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play938072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938072004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938072005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "10183"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

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

			local var_19_4 = arg_16_1.actors_["10183"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.actorSpriteComps10183 == nil then
				arg_16_1.var_.actorSpriteComps10183 = var_19_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_6 = 0.2

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.actorSpriteComps10183 then
					for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.actorSpriteComps10183 then
				for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_19_5 then
						if arg_16_1.isInRecall_ then
							iter_19_5.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps10183 = nil
			end

			local var_19_12 = arg_16_1.actors_["10183"].transform
			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1.var_.moveOldPos10183 = var_19_12.localPosition
				var_19_12.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10183", 3)

				local var_19_14 = var_19_12.childCount

				for iter_19_6 = 0, var_19_14 - 1 do
					local var_19_15 = var_19_12:GetChild(iter_19_6)

					if var_19_15.name == "split_9" or not string.find(var_19_15.name, "split") then
						var_19_15.gameObject:SetActive(true)
					else
						var_19_15.gameObject:SetActive(false)
					end
				end
			end

			local var_19_16 = 0.001

			if var_19_13 <= arg_16_1.time_ and arg_16_1.time_ < var_19_13 + var_19_16 then
				local var_19_17 = (arg_16_1.time_ - var_19_13) / var_19_16
				local var_19_18 = Vector3.New(0, -475, -325)

				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10183, var_19_18, var_19_17)
			end

			if arg_16_1.time_ >= var_19_13 + var_19_16 and arg_16_1.time_ < var_19_13 + var_19_16 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(0, -475, -325)
			end

			local var_19_19 = 0
			local var_19_20 = 0.4

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_21 = arg_16_1:FormatText(StoryNameCfg[1562].name)

				arg_16_1.leftNameTxt_.text = var_19_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_22 = arg_16_1:GetWordFromCfg(938072004)
				local var_19_23 = arg_16_1:FormatText(var_19_22.content)

				arg_16_1.text_.text = var_19_23

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_24 = 16
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
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_27 = math.max(var_19_20, arg_16_1.talkMaxDuration)

			if var_19_19 <= arg_16_1.time_ and arg_16_1.time_ < var_19_19 + var_19_27 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_19) / var_19_27

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_19 + var_19_27 and arg_16_1.time_ < var_19_19 + var_19_27 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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
	Play938072005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938072005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938072006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10183"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10183 = var_23_0.localPosition
				var_23_0.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10183", 3)

				local var_23_2 = var_23_0.childCount

				for iter_23_0 = 0, var_23_2 - 1 do
					local var_23_3 = var_23_0:GetChild(iter_23_0)

					if var_23_3.name == "split_10" then
						var_23_3:SetAsLastSibling()
						var_23_3.gameObject:SetActive(true)

						arg_20_1.var_.actorSpriteSplit10183 = var_23_3.gameObject:GetComponent(typeof(Image))

						arg_20_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_23_4 = 0.5

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_4 then
				local var_23_5 = (arg_20_1.time_ - var_23_1) / var_23_4
				local var_23_6 = Vector3.New(0, -475, -325)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10183, var_23_6, var_23_5)

				if arg_20_1.var_.actorSpriteSplit10183 ~= nil then
					arg_20_1.var_.actorSpriteSplit10183:SetAlpha(var_23_5)
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_4 and arg_20_1.time_ < var_23_1 + var_23_4 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -475, -325)

				if arg_20_1.var_.actorSpriteSplit10183 ~= nil then
					arg_20_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_23_7 = 0
			local var_23_8 = 0.85

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_9 = arg_20_1:FormatText(StoryNameCfg[1562].name)

				arg_20_1.leftNameTxt_.text = var_23_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(938072005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_12 = 34
				local var_23_13 = utf8.len(var_23_11)
				local var_23_14 = var_23_12 <= 0 and var_23_8 or var_23_8 * (var_23_13 / var_23_12)

				if var_23_14 > 0 and var_23_8 < var_23_14 then
					arg_20_1.talkMaxDuration = var_23_14

					if var_23_14 + var_23_7 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_7
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_15 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_15 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_7) / var_23_15

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_7 + var_23_15 and arg_20_1.time_ < var_23_7 + var_23_15 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play938072006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938072006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938072007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "128404"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(var_27_1, arg_24_1.canvasGo_.transform)

					var_27_2.transform:SetSiblingIndex(1)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs(var_27_3) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_4 = arg_24_1.actors_["128404"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.actorSpriteComps128404 == nil then
				arg_24_1.var_.actorSpriteComps128404 = var_27_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_6 = 0.2

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.actorSpriteComps128404 then
					for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_27_3 then
							if arg_24_1.isInRecall_ then
								local var_27_8 = Mathf.Lerp(iter_27_3.color.r, arg_24_1.hightColor1.r, var_27_7)
								local var_27_9 = Mathf.Lerp(iter_27_3.color.g, arg_24_1.hightColor1.g, var_27_7)
								local var_27_10 = Mathf.Lerp(iter_27_3.color.b, arg_24_1.hightColor1.b, var_27_7)

								iter_27_3.color = Color.New(var_27_8, var_27_9, var_27_10)
							else
								local var_27_11 = Mathf.Lerp(iter_27_3.color.r, 1, var_27_7)

								iter_27_3.color = Color.New(var_27_11, var_27_11, var_27_11)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.actorSpriteComps128404 then
				for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_27_5 then
						if arg_24_1.isInRecall_ then
							iter_27_5.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps128404 = nil
			end

			local var_27_12 = arg_24_1.actors_["10183"]
			local var_27_13 = 0

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps10183 == nil then
				arg_24_1.var_.actorSpriteComps10183 = var_27_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_14 = 0.2

			if var_27_13 <= arg_24_1.time_ and arg_24_1.time_ < var_27_13 + var_27_14 and not isNil(var_27_12) then
				local var_27_15 = (arg_24_1.time_ - var_27_13) / var_27_14

				if arg_24_1.var_.actorSpriteComps10183 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_27_7 then
							if arg_24_1.isInRecall_ then
								local var_27_16 = Mathf.Lerp(iter_27_7.color.r, arg_24_1.hightColor2.r, var_27_15)
								local var_27_17 = Mathf.Lerp(iter_27_7.color.g, arg_24_1.hightColor2.g, var_27_15)
								local var_27_18 = Mathf.Lerp(iter_27_7.color.b, arg_24_1.hightColor2.b, var_27_15)

								iter_27_7.color = Color.New(var_27_16, var_27_17, var_27_18)
							else
								local var_27_19 = Mathf.Lerp(iter_27_7.color.r, 0.5, var_27_15)

								iter_27_7.color = Color.New(var_27_19, var_27_19, var_27_19)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_13 + var_27_14 and arg_24_1.time_ < var_27_13 + var_27_14 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps10183 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_27_9 then
						if arg_24_1.isInRecall_ then
							iter_27_9.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10183 = nil
			end

			local var_27_20 = arg_24_1.actors_["128404"].transform
			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1.var_.moveOldPos128404 = var_27_20.localPosition
				var_27_20.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("128404", 4)

				local var_27_22 = var_27_20.childCount

				for iter_27_10 = 0, var_27_22 - 1 do
					local var_27_23 = var_27_20:GetChild(iter_27_10)

					if var_27_23.name == "split_10" or not string.find(var_27_23.name, "split") then
						var_27_23.gameObject:SetActive(true)
					else
						var_27_23.gameObject:SetActive(false)
					end
				end
			end

			local var_27_24 = 0.001

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_24 then
				local var_27_25 = (arg_24_1.time_ - var_27_21) / var_27_24
				local var_27_26 = Vector3.New(390.2, -356, -362.3)

				var_27_20.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos128404, var_27_26, var_27_25)
			end

			if arg_24_1.time_ >= var_27_21 + var_27_24 and arg_24_1.time_ < var_27_21 + var_27_24 + arg_27_0 then
				var_27_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_27_27 = arg_24_1.actors_["10183"].transform
			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.var_.moveOldPos10183 = var_27_27.localPosition
				var_27_27.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10183", 2)

				local var_27_29 = var_27_27.childCount

				for iter_27_11 = 0, var_27_29 - 1 do
					local var_27_30 = var_27_27:GetChild(iter_27_11)

					if var_27_30.name == "split_9" or not string.find(var_27_30.name, "split") then
						var_27_30.gameObject:SetActive(true)
					else
						var_27_30.gameObject:SetActive(false)
					end
				end
			end

			local var_27_31 = 0.001

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_31 then
				local var_27_32 = (arg_24_1.time_ - var_27_28) / var_27_31
				local var_27_33 = Vector3.New(-300, -475, -325)

				var_27_27.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10183, var_27_33, var_27_32)
			end

			if arg_24_1.time_ >= var_27_28 + var_27_31 and arg_24_1.time_ < var_27_28 + var_27_31 + arg_27_0 then
				var_27_27.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_27_34 = 0
			local var_27_35 = 0.325

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_36 = arg_24_1:FormatText(StoryNameCfg[6].name)

				arg_24_1.leftNameTxt_.text = var_27_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_37 = arg_24_1:GetWordFromCfg(938072006)
				local var_27_38 = arg_24_1:FormatText(var_27_37.content)

				arg_24_1.text_.text = var_27_38

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_39 = 13
				local var_27_40 = utf8.len(var_27_38)
				local var_27_41 = var_27_39 <= 0 and var_27_35 or var_27_35 * (var_27_40 / var_27_39)

				if var_27_41 > 0 and var_27_35 < var_27_41 then
					arg_24_1.talkMaxDuration = var_27_41

					if var_27_41 + var_27_34 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_41 + var_27_34
					end
				end

				arg_24_1.text_.text = var_27_38
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_42 = math.max(var_27_35, arg_24_1.talkMaxDuration)

			if var_27_34 <= arg_24_1.time_ and arg_24_1.time_ < var_27_34 + var_27_42 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_34) / var_27_42

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_34 + var_27_42 and arg_24_1.time_ < var_27_34 + var_27_42 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play938072007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938072007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938072008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "10144"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(var_31_1, arg_28_1.canvasGo_.transform)

					var_31_2.transform:SetSiblingIndex(1)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_28_1.isInRecall_ then
						for iter_31_0, iter_31_1 in ipairs(var_31_3) do
							iter_31_1.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_31_4 = arg_28_1.actors_["10144"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.actorSpriteComps10144 == nil then
				arg_28_1.var_.actorSpriteComps10144 = var_31_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_6 = 0.2

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.actorSpriteComps10144 then
					for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_31_3 then
							if arg_28_1.isInRecall_ then
								local var_31_8 = Mathf.Lerp(iter_31_3.color.r, arg_28_1.hightColor1.r, var_31_7)
								local var_31_9 = Mathf.Lerp(iter_31_3.color.g, arg_28_1.hightColor1.g, var_31_7)
								local var_31_10 = Mathf.Lerp(iter_31_3.color.b, arg_28_1.hightColor1.b, var_31_7)

								iter_31_3.color = Color.New(var_31_8, var_31_9, var_31_10)
							else
								local var_31_11 = Mathf.Lerp(iter_31_3.color.r, 1, var_31_7)

								iter_31_3.color = Color.New(var_31_11, var_31_11, var_31_11)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.actorSpriteComps10144 then
				for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_31_5 then
						if arg_28_1.isInRecall_ then
							iter_31_5.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10144 = nil
			end

			local var_31_12 = arg_28_1.actors_["128404"]
			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 and not isNil(var_31_12) and arg_28_1.var_.actorSpriteComps128404 == nil then
				arg_28_1.var_.actorSpriteComps128404 = var_31_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_14 = 0.2

			if var_31_13 <= arg_28_1.time_ and arg_28_1.time_ < var_31_13 + var_31_14 and not isNil(var_31_12) then
				local var_31_15 = (arg_28_1.time_ - var_31_13) / var_31_14

				if arg_28_1.var_.actorSpriteComps128404 then
					for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_31_7 then
							if arg_28_1.isInRecall_ then
								local var_31_16 = Mathf.Lerp(iter_31_7.color.r, arg_28_1.hightColor2.r, var_31_15)
								local var_31_17 = Mathf.Lerp(iter_31_7.color.g, arg_28_1.hightColor2.g, var_31_15)
								local var_31_18 = Mathf.Lerp(iter_31_7.color.b, arg_28_1.hightColor2.b, var_31_15)

								iter_31_7.color = Color.New(var_31_16, var_31_17, var_31_18)
							else
								local var_31_19 = Mathf.Lerp(iter_31_7.color.r, 0.5, var_31_15)

								iter_31_7.color = Color.New(var_31_19, var_31_19, var_31_19)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_13 + var_31_14 and arg_28_1.time_ < var_31_13 + var_31_14 + arg_31_0 and not isNil(var_31_12) and arg_28_1.var_.actorSpriteComps128404 then
				for iter_31_8, iter_31_9 in pairs(arg_28_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_31_9 then
						if arg_28_1.isInRecall_ then
							iter_31_9.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps128404 = nil
			end

			local var_31_20 = arg_28_1.actors_["10144"].transform
			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1.var_.moveOldPos10144 = var_31_20.localPosition
				var_31_20.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10144", 3)

				local var_31_22 = var_31_20.childCount

				for iter_31_10 = 0, var_31_22 - 1 do
					local var_31_23 = var_31_20:GetChild(iter_31_10)

					if var_31_23.name == "split_11" or not string.find(var_31_23.name, "split") then
						var_31_23.gameObject:SetActive(true)
					else
						var_31_23.gameObject:SetActive(false)
					end
				end
			end

			local var_31_24 = 0.001

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_24 then
				local var_31_25 = (arg_28_1.time_ - var_31_21) / var_31_24
				local var_31_26 = Vector3.New(-31.5, -381.1, -285.9)

				var_31_20.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10144, var_31_26, var_31_25)
			end

			if arg_28_1.time_ >= var_31_21 + var_31_24 and arg_28_1.time_ < var_31_21 + var_31_24 + arg_31_0 then
				var_31_20.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_31_27 = arg_28_1.actors_["128404"].transform
			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_27.localPosition
				var_31_27.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 7)

				local var_31_29 = var_31_27.childCount

				for iter_31_11 = 0, var_31_29 - 1 do
					local var_31_30 = var_31_27:GetChild(iter_31_11)

					if var_31_30.name == "" or not string.find(var_31_30.name, "split") then
						var_31_30.gameObject:SetActive(true)
					else
						var_31_30.gameObject:SetActive(false)
					end
				end
			end

			local var_31_31 = 0.001

			if var_31_28 <= arg_28_1.time_ and arg_28_1.time_ < var_31_28 + var_31_31 then
				local var_31_32 = (arg_28_1.time_ - var_31_28) / var_31_31
				local var_31_33 = Vector3.New(0, -2000, 0)

				var_31_27.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, var_31_33, var_31_32)
			end

			if arg_28_1.time_ >= var_31_28 + var_31_31 and arg_28_1.time_ < var_31_28 + var_31_31 + arg_31_0 then
				var_31_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_34 = arg_28_1.actors_["10183"].transform
			local var_31_35 = 0

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 then
				arg_28_1.var_.moveOldPos10183 = var_31_34.localPosition
				var_31_34.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10183", 7)

				local var_31_36 = var_31_34.childCount

				for iter_31_12 = 0, var_31_36 - 1 do
					local var_31_37 = var_31_34:GetChild(iter_31_12)

					if var_31_37.name == "" or not string.find(var_31_37.name, "split") then
						var_31_37.gameObject:SetActive(true)
					else
						var_31_37.gameObject:SetActive(false)
					end
				end
			end

			local var_31_38 = 0.001

			if var_31_35 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_38 then
				local var_31_39 = (arg_28_1.time_ - var_31_35) / var_31_38
				local var_31_40 = Vector3.New(0, -2000, 0)

				var_31_34.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10183, var_31_40, var_31_39)
			end

			if arg_28_1.time_ >= var_31_35 + var_31_38 and arg_28_1.time_ < var_31_35 + var_31_38 + arg_31_0 then
				var_31_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_41 = 0
			local var_31_42 = 0.8

			if var_31_41 < arg_28_1.time_ and arg_28_1.time_ <= var_31_41 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_43 = arg_28_1:FormatText(StoryNameCfg[1297].name)

				arg_28_1.leftNameTxt_.text = var_31_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_44 = arg_28_1:GetWordFromCfg(938072007)
				local var_31_45 = arg_28_1:FormatText(var_31_44.content)

				arg_28_1.text_.text = var_31_45

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_46 = 32
				local var_31_47 = utf8.len(var_31_45)
				local var_31_48 = var_31_46 <= 0 and var_31_42 or var_31_42 * (var_31_47 / var_31_46)

				if var_31_48 > 0 and var_31_42 < var_31_48 then
					arg_28_1.talkMaxDuration = var_31_48

					if var_31_48 + var_31_41 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_48 + var_31_41
					end
				end

				arg_28_1.text_.text = var_31_45
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_49 = math.max(var_31_42, arg_28_1.talkMaxDuration)

			if var_31_41 <= arg_28_1.time_ and arg_28_1.time_ < var_31_41 + var_31_49 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_41) / var_31_49

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_41 + var_31_49 and arg_28_1.time_ < var_31_41 + var_31_49 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938072008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938072008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938072009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10144"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10144 == nil then
				arg_32_1.var_.actorSpriteComps10144 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10144 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 0.5, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10144 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10144 = nil
			end

			local var_35_8 = 0
			local var_35_9 = 0.25

			if var_35_8 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_10 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_11 = arg_32_1:GetWordFromCfg(938072008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 10
				local var_35_14 = utf8.len(var_35_12)
				local var_35_15 = var_35_13 <= 0 and var_35_9 or var_35_9 * (var_35_14 / var_35_13)

				if var_35_15 > 0 and var_35_9 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_12
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play938072009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938072009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938072010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10144"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10144 = var_39_0.localPosition
				var_39_0.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10144", 7)

				local var_39_2 = var_39_0.childCount

				for iter_39_0 = 0, var_39_2 - 1 do
					local var_39_3 = var_39_0:GetChild(iter_39_0)

					if var_39_3.name == "" or not string.find(var_39_3.name, "split") then
						var_39_3.gameObject:SetActive(true)
					else
						var_39_3.gameObject:SetActive(false)
					end
				end
			end

			local var_39_4 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_4 then
				local var_39_5 = (arg_36_1.time_ - var_39_1) / var_39_4
				local var_39_6 = Vector3.New(0, -2000, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10144, var_39_6, var_39_5)
			end

			if arg_36_1.time_ >= var_39_1 + var_39_4 and arg_36_1.time_ < var_39_1 + var_39_4 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_7 = 0
			local var_39_8 = 0.7

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:GetWordFromCfg(938072009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 28
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_8 or var_39_8 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_8 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_7 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_7
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_8, arg_36_1.talkMaxDuration)

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_7) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_7 + var_39_14 and arg_36_1.time_ < var_39_7 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938072010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938072011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10144"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10144 == nil then
				arg_40_1.var_.actorSpriteComps10144 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps10144 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 1, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10144 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10144 = nil
			end

			local var_43_8 = arg_40_1.actors_["10144"].transform
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.var_.moveOldPos10144 = var_43_8.localPosition
				var_43_8.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10144", 3)

				local var_43_10 = var_43_8.childCount

				for iter_43_4 = 0, var_43_10 - 1 do
					local var_43_11 = var_43_8:GetChild(iter_43_4)

					if var_43_11.name == "split_11" or not string.find(var_43_11.name, "split") then
						var_43_11.gameObject:SetActive(true)
					else
						var_43_11.gameObject:SetActive(false)
					end
				end
			end

			local var_43_12 = 0.001

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_9) / var_43_12
				local var_43_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10144, var_43_14, var_43_13)
			end

			if arg_40_1.time_ >= var_43_9 + var_43_12 and arg_40_1.time_ < var_43_9 + var_43_12 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_43_15 = 0
			local var_43_16 = 0.525

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[1297].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(938072010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 21
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_23 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_23

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_23 and arg_40_1.time_ < var_43_15 + var_43_23 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938072011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938072012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.7

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[1297].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(938072011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 28
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play938072012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938072012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938072013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10144"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10144 == nil then
				arg_48_1.var_.actorSpriteComps10144 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps10144 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 0.5, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10144 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps10144 = nil
			end

			local var_51_8 = arg_48_1.actors_["10144"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos10144 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10144", 7)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(0, -2000, 0)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10144, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_51_15 = manager.ui.mainCamera.transform
			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				local var_51_17 = arg_48_1.var_.effectsuipianguangmang1
				local var_51_18
				local var_51_19 = var_51_15

				if not var_51_17 then
					var_51_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), var_51_19)
					var_51_17.name = "suipianguangmang1"
					arg_48_1.var_.effectsuipianguangmang1 = var_51_17
				else
					var_51_17.transform:SetParent(var_51_19)
				end

				var_51_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_51_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			local var_51_21 = 1.6

			if arg_48_1.time_ >= var_51_20 + var_51_21 and arg_48_1.time_ < var_51_20 + var_51_21 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_22 = 0
			local var_51_23 = 0.8

			if var_51_22 < arg_48_1.time_ and arg_48_1.time_ <= var_51_22 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_24 = arg_48_1:GetWordFromCfg(938072012)
				local var_51_25 = arg_48_1:FormatText(var_51_24.content)

				arg_48_1.text_.text = var_51_25

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_26 = 32
				local var_51_27 = utf8.len(var_51_25)
				local var_51_28 = var_51_26 <= 0 and var_51_23 or var_51_23 * (var_51_27 / var_51_26)

				if var_51_28 > 0 and var_51_23 < var_51_28 then
					arg_48_1.talkMaxDuration = var_51_28

					if var_51_28 + var_51_22 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_22
					end
				end

				arg_48_1.text_.text = var_51_25
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_29 = math.max(var_51_23, arg_48_1.talkMaxDuration)

			if var_51_22 <= arg_48_1.time_ and arg_48_1.time_ < var_51_22 + var_51_29 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_22) / var_51_29

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_22 + var_51_29 and arg_48_1.time_ < var_51_22 + var_51_29 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938072013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938072014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = manager.ui.mainCamera.transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.shakeOldPos = var_55_0.localPosition
			end

			local var_55_2 = 0.6

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / 0.066
				local var_55_4, var_55_5 = math.modf(var_55_3)

				var_55_0.localPosition = Vector3.New(var_55_5 * 0.13, var_55_5 * 0.13, var_55_5 * 0.13) + arg_52_1.var_.shakeOldPos
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = arg_52_1.var_.shakeOldPos
			end

			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_7 = 0.6

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_8 = 0
			local var_55_9 = 0.125

			if var_55_8 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_10 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_11 = arg_52_1:GetWordFromCfg(938072013)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 5
				local var_55_14 = utf8.len(var_55_12)
				local var_55_15 = var_55_13 <= 0 and var_55_9 or var_55_9 * (var_55_14 / var_55_13)

				if var_55_15 > 0 and var_55_9 < var_55_15 then
					arg_52_1.talkMaxDuration = var_55_15

					if var_55_15 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_12
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_16 and arg_52_1.time_ < var_55_8 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play938072014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938072014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938072015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "106603"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(var_59_1, arg_56_1.canvasGo_.transform)

					var_59_2.transform:SetSiblingIndex(1)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_56_1.isInRecall_ then
						for iter_59_0, iter_59_1 in ipairs(var_59_3) do
							iter_59_1.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_59_4 = arg_56_1.actors_["106603"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.actorSpriteComps106603 == nil then
				arg_56_1.var_.actorSpriteComps106603 = var_59_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_6 = 0.2

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.actorSpriteComps106603 then
					for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_59_3 then
							if arg_56_1.isInRecall_ then
								local var_59_8 = Mathf.Lerp(iter_59_3.color.r, arg_56_1.hightColor1.r, var_59_7)
								local var_59_9 = Mathf.Lerp(iter_59_3.color.g, arg_56_1.hightColor1.g, var_59_7)
								local var_59_10 = Mathf.Lerp(iter_59_3.color.b, arg_56_1.hightColor1.b, var_59_7)

								iter_59_3.color = Color.New(var_59_8, var_59_9, var_59_10)
							else
								local var_59_11 = Mathf.Lerp(iter_59_3.color.r, 1, var_59_7)

								iter_59_3.color = Color.New(var_59_11, var_59_11, var_59_11)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.actorSpriteComps106603 then
				for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_59_5 then
						if arg_56_1.isInRecall_ then
							iter_59_5.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps106603 = nil
			end

			local var_59_12 = arg_56_1.actors_["106603"].transform
			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1.var_.moveOldPos106603 = var_59_12.localPosition
				var_59_12.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("106603", 2)

				local var_59_14 = var_59_12.childCount

				for iter_59_6 = 0, var_59_14 - 1 do
					local var_59_15 = var_59_12:GetChild(iter_59_6)

					if var_59_15.name == "split_12" or not string.find(var_59_15.name, "split") then
						var_59_15.gameObject:SetActive(true)
					else
						var_59_15.gameObject:SetActive(false)
					end
				end
			end

			local var_59_16 = 0.001

			if var_59_13 <= arg_56_1.time_ and arg_56_1.time_ < var_59_13 + var_59_16 then
				local var_59_17 = (arg_56_1.time_ - var_59_13) / var_59_16
				local var_59_18 = Vector3.New(-510.9, -399.1, -303.3)

				var_59_12.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos106603, var_59_18, var_59_17)
			end

			if arg_56_1.time_ >= var_59_13 + var_59_16 and arg_56_1.time_ < var_59_13 + var_59_16 + arg_59_0 then
				var_59_12.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_59_19 = 0
			local var_59_20 = 0.225

			if var_59_19 < arg_56_1.time_ and arg_56_1.time_ <= var_59_19 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_21 = arg_56_1:FormatText(StoryNameCfg[32].name)

				arg_56_1.leftNameTxt_.text = var_59_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_22 = arg_56_1:GetWordFromCfg(938072014)
				local var_59_23 = arg_56_1:FormatText(var_59_22.content)

				arg_56_1.text_.text = var_59_23

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_24 = 9
				local var_59_25 = utf8.len(var_59_23)
				local var_59_26 = var_59_24 <= 0 and var_59_20 or var_59_20 * (var_59_25 / var_59_24)

				if var_59_26 > 0 and var_59_20 < var_59_26 then
					arg_56_1.talkMaxDuration = var_59_26

					if var_59_26 + var_59_19 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_26 + var_59_19
					end
				end

				arg_56_1.text_.text = var_59_23
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_27 = math.max(var_59_20, arg_56_1.talkMaxDuration)

			if var_59_19 <= arg_56_1.time_ and arg_56_1.time_ < var_59_19 + var_59_27 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_19) / var_59_27

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_19 + var_59_27 and arg_56_1.time_ < var_59_19 + var_59_27 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play938072015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938072015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938072016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "104902"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(var_63_1, arg_60_1.canvasGo_.transform)

					var_63_2.transform:SetSiblingIndex(1)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_60_1.isInRecall_ then
						for iter_63_0, iter_63_1 in ipairs(var_63_3) do
							iter_63_1.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_63_4 = arg_60_1.actors_["104902"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.actorSpriteComps104902 == nil then
				arg_60_1.var_.actorSpriteComps104902 = var_63_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_6 = 0.2

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.actorSpriteComps104902 then
					for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_63_3 then
							if arg_60_1.isInRecall_ then
								local var_63_8 = Mathf.Lerp(iter_63_3.color.r, arg_60_1.hightColor1.r, var_63_7)
								local var_63_9 = Mathf.Lerp(iter_63_3.color.g, arg_60_1.hightColor1.g, var_63_7)
								local var_63_10 = Mathf.Lerp(iter_63_3.color.b, arg_60_1.hightColor1.b, var_63_7)

								iter_63_3.color = Color.New(var_63_8, var_63_9, var_63_10)
							else
								local var_63_11 = Mathf.Lerp(iter_63_3.color.r, 1, var_63_7)

								iter_63_3.color = Color.New(var_63_11, var_63_11, var_63_11)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.actorSpriteComps104902 then
				for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_63_5 then
						if arg_60_1.isInRecall_ then
							iter_63_5.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps104902 = nil
			end

			local var_63_12 = arg_60_1.actors_["106603"]
			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 and not isNil(var_63_12) and arg_60_1.var_.actorSpriteComps106603 == nil then
				arg_60_1.var_.actorSpriteComps106603 = var_63_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_14 = 0.2

			if var_63_13 <= arg_60_1.time_ and arg_60_1.time_ < var_63_13 + var_63_14 and not isNil(var_63_12) then
				local var_63_15 = (arg_60_1.time_ - var_63_13) / var_63_14

				if arg_60_1.var_.actorSpriteComps106603 then
					for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_63_7 then
							if arg_60_1.isInRecall_ then
								local var_63_16 = Mathf.Lerp(iter_63_7.color.r, arg_60_1.hightColor2.r, var_63_15)
								local var_63_17 = Mathf.Lerp(iter_63_7.color.g, arg_60_1.hightColor2.g, var_63_15)
								local var_63_18 = Mathf.Lerp(iter_63_7.color.b, arg_60_1.hightColor2.b, var_63_15)

								iter_63_7.color = Color.New(var_63_16, var_63_17, var_63_18)
							else
								local var_63_19 = Mathf.Lerp(iter_63_7.color.r, 0.5, var_63_15)

								iter_63_7.color = Color.New(var_63_19, var_63_19, var_63_19)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_13 + var_63_14 and arg_60_1.time_ < var_63_13 + var_63_14 + arg_63_0 and not isNil(var_63_12) and arg_60_1.var_.actorSpriteComps106603 then
				for iter_63_8, iter_63_9 in pairs(arg_60_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_63_9 then
						if arg_60_1.isInRecall_ then
							iter_63_9.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps106603 = nil
			end

			local var_63_20 = arg_60_1.actors_["104902"].transform
			local var_63_21 = 0

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.var_.moveOldPos104902 = var_63_20.localPosition
				var_63_20.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("104902", 4)

				local var_63_22 = var_63_20.childCount

				for iter_63_10 = 0, var_63_22 - 1 do
					local var_63_23 = var_63_20:GetChild(iter_63_10)

					if var_63_23.name == "split_6" or not string.find(var_63_23.name, "split") then
						var_63_23.gameObject:SetActive(true)
					else
						var_63_23.gameObject:SetActive(false)
					end
				end
			end

			local var_63_24 = 0.001

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_24 then
				local var_63_25 = (arg_60_1.time_ - var_63_21) / var_63_24
				local var_63_26 = Vector3.New(390, -335, -360)

				var_63_20.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos104902, var_63_26, var_63_25)
			end

			if arg_60_1.time_ >= var_63_21 + var_63_24 and arg_60_1.time_ < var_63_21 + var_63_24 + arg_63_0 then
				var_63_20.localPosition = Vector3.New(390, -335, -360)
			end

			local var_63_27 = 0
			local var_63_28 = 0.225

			if var_63_27 < arg_60_1.time_ and arg_60_1.time_ <= var_63_27 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_29 = arg_60_1:FormatText(StoryNameCfg[562].name)

				arg_60_1.leftNameTxt_.text = var_63_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_30 = arg_60_1:GetWordFromCfg(938072015)
				local var_63_31 = arg_60_1:FormatText(var_63_30.content)

				arg_60_1.text_.text = var_63_31

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_32 = 9
				local var_63_33 = utf8.len(var_63_31)
				local var_63_34 = var_63_32 <= 0 and var_63_28 or var_63_28 * (var_63_33 / var_63_32)

				if var_63_34 > 0 and var_63_28 < var_63_34 then
					arg_60_1.talkMaxDuration = var_63_34

					if var_63_34 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_34 + var_63_27
					end
				end

				arg_60_1.text_.text = var_63_31
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_35 = math.max(var_63_28, arg_60_1.talkMaxDuration)

			if var_63_27 <= arg_60_1.time_ and arg_60_1.time_ < var_63_27 + var_63_35 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_27) / var_63_35

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_27 + var_63_35 and arg_60_1.time_ < var_63_27 + var_63_35 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play938072016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938072016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938072017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["104902"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps104902 == nil then
				arg_64_1.var_.actorSpriteComps104902 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps104902 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor2.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor2.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor2.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 0.5, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps104902 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps104902 = nil
			end

			local var_67_8 = arg_64_1.actors_["104902"].transform
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.var_.moveOldPos104902 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("104902", 7)

				local var_67_10 = var_67_8.childCount

				for iter_67_4 = 0, var_67_10 - 1 do
					local var_67_11 = var_67_8:GetChild(iter_67_4)

					if var_67_11.name == "" or not string.find(var_67_11.name, "split") then
						var_67_11.gameObject:SetActive(true)
					else
						var_67_11.gameObject:SetActive(false)
					end
				end
			end

			local var_67_12 = 0.001

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_9) / var_67_12
				local var_67_14 = Vector3.New(0, -2000, -360)

				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos104902, var_67_14, var_67_13)
			end

			if arg_64_1.time_ >= var_67_9 + var_67_12 and arg_64_1.time_ < var_67_9 + var_67_12 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_67_15 = arg_64_1.actors_["106603"].transform
			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.var_.moveOldPos106603 = var_67_15.localPosition
				var_67_15.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("106603", 7)

				local var_67_17 = var_67_15.childCount

				for iter_67_5 = 0, var_67_17 - 1 do
					local var_67_18 = var_67_15:GetChild(iter_67_5)

					if var_67_18.name == "" or not string.find(var_67_18.name, "split") then
						var_67_18.gameObject:SetActive(true)
					else
						var_67_18.gameObject:SetActive(false)
					end
				end
			end

			local var_67_19 = 0.001

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_19 then
				local var_67_20 = (arg_64_1.time_ - var_67_16) / var_67_19
				local var_67_21 = Vector3.New(0, -2000, 0)

				var_67_15.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos106603, var_67_21, var_67_20)
			end

			if arg_64_1.time_ >= var_67_16 + var_67_19 and arg_64_1.time_ < var_67_16 + var_67_19 + arg_67_0 then
				var_67_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_67_22 = 0
			local var_67_23 = 0.775

			if var_67_22 < arg_64_1.time_ and arg_64_1.time_ <= var_67_22 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_24 = arg_64_1:GetWordFromCfg(938072016)
				local var_67_25 = arg_64_1:FormatText(var_67_24.content)

				arg_64_1.text_.text = var_67_25

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_26 = 31
				local var_67_27 = utf8.len(var_67_25)
				local var_67_28 = var_67_26 <= 0 and var_67_23 or var_67_23 * (var_67_27 / var_67_26)

				if var_67_28 > 0 and var_67_23 < var_67_28 then
					arg_64_1.talkMaxDuration = var_67_28

					if var_67_28 + var_67_22 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_22
					end
				end

				arg_64_1.text_.text = var_67_25
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_29 = math.max(var_67_23, arg_64_1.talkMaxDuration)

			if var_67_22 <= arg_64_1.time_ and arg_64_1.time_ < var_67_22 + var_67_29 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_22) / var_67_29

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_22 + var_67_29 and arg_64_1.time_ < var_67_22 + var_67_29 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
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
	Play938072017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938072017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938072018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10144"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10144 == nil then
				arg_68_1.var_.actorSpriteComps10144 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10144 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10144 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10144 = nil
			end

			local var_71_8 = arg_68_1.actors_["10144"].transform
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.var_.moveOldPos10144 = var_71_8.localPosition
				var_71_8.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10144", 2)

				local var_71_10 = var_71_8.childCount

				for iter_71_4 = 0, var_71_10 - 1 do
					local var_71_11 = var_71_8:GetChild(iter_71_4)

					if var_71_11.name == "split_12" or not string.find(var_71_11.name, "split") then
						var_71_11.gameObject:SetActive(true)
					else
						var_71_11.gameObject:SetActive(false)
					end
				end
			end

			local var_71_12 = 0.001

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_9) / var_71_12
				local var_71_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10144, var_71_14, var_71_13)
			end

			if arg_68_1.time_ >= var_71_9 + var_71_12 and arg_68_1.time_ < var_71_9 + var_71_12 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_71_15 = 0
			local var_71_16 = 0.65

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[1297].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(938072017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 26
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_23 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_23 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_23

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_23 and arg_68_1.time_ < var_71_15 + var_71_23 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play938072018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938072018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938072019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "108301"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(var_75_1, arg_72_1.canvasGo_.transform)

					var_75_2.transform:SetSiblingIndex(1)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_72_1.isInRecall_ then
						for iter_75_0, iter_75_1 in ipairs(var_75_3) do
							iter_75_1.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_75_4 = arg_72_1.actors_["108301"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.actorSpriteComps108301 == nil then
				arg_72_1.var_.actorSpriteComps108301 = var_75_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_6 = 0.2

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.actorSpriteComps108301 then
					for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_75_3 then
							if arg_72_1.isInRecall_ then
								local var_75_8 = Mathf.Lerp(iter_75_3.color.r, arg_72_1.hightColor1.r, var_75_7)
								local var_75_9 = Mathf.Lerp(iter_75_3.color.g, arg_72_1.hightColor1.g, var_75_7)
								local var_75_10 = Mathf.Lerp(iter_75_3.color.b, arg_72_1.hightColor1.b, var_75_7)

								iter_75_3.color = Color.New(var_75_8, var_75_9, var_75_10)
							else
								local var_75_11 = Mathf.Lerp(iter_75_3.color.r, 1, var_75_7)

								iter_75_3.color = Color.New(var_75_11, var_75_11, var_75_11)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.actorSpriteComps108301 then
				for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_75_5 then
						if arg_72_1.isInRecall_ then
							iter_75_5.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps108301 = nil
			end

			local var_75_12 = arg_72_1.actors_["10144"]
			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 and not isNil(var_75_12) and arg_72_1.var_.actorSpriteComps10144 == nil then
				arg_72_1.var_.actorSpriteComps10144 = var_75_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_14 = 0.2

			if var_75_13 <= arg_72_1.time_ and arg_72_1.time_ < var_75_13 + var_75_14 and not isNil(var_75_12) then
				local var_75_15 = (arg_72_1.time_ - var_75_13) / var_75_14

				if arg_72_1.var_.actorSpriteComps10144 then
					for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_75_7 then
							if arg_72_1.isInRecall_ then
								local var_75_16 = Mathf.Lerp(iter_75_7.color.r, arg_72_1.hightColor2.r, var_75_15)
								local var_75_17 = Mathf.Lerp(iter_75_7.color.g, arg_72_1.hightColor2.g, var_75_15)
								local var_75_18 = Mathf.Lerp(iter_75_7.color.b, arg_72_1.hightColor2.b, var_75_15)

								iter_75_7.color = Color.New(var_75_16, var_75_17, var_75_18)
							else
								local var_75_19 = Mathf.Lerp(iter_75_7.color.r, 0.5, var_75_15)

								iter_75_7.color = Color.New(var_75_19, var_75_19, var_75_19)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_13 + var_75_14 and arg_72_1.time_ < var_75_13 + var_75_14 + arg_75_0 and not isNil(var_75_12) and arg_72_1.var_.actorSpriteComps10144 then
				for iter_75_8, iter_75_9 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_75_9 then
						if arg_72_1.isInRecall_ then
							iter_75_9.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10144 = nil
			end

			local var_75_20 = arg_72_1.actors_["108301"].transform
			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.var_.moveOldPos108301 = var_75_20.localPosition
				var_75_20.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("108301", 4)

				local var_75_22 = var_75_20.childCount

				for iter_75_10 = 0, var_75_22 - 1 do
					local var_75_23 = var_75_20:GetChild(iter_75_10)

					if var_75_23.name == "split_6" or not string.find(var_75_23.name, "split") then
						var_75_23.gameObject:SetActive(true)
					else
						var_75_23.gameObject:SetActive(false)
					end
				end
			end

			local var_75_24 = 0.001

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_24 then
				local var_75_25 = (arg_72_1.time_ - var_75_21) / var_75_24
				local var_75_26 = Vector3.New(460, -360, -195)

				var_75_20.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos108301, var_75_26, var_75_25)
			end

			if arg_72_1.time_ >= var_75_21 + var_75_24 and arg_72_1.time_ < var_75_21 + var_75_24 + arg_75_0 then
				var_75_20.localPosition = Vector3.New(460, -360, -195)
			end

			local var_75_27 = 0
			local var_75_28 = 0.9

			if var_75_27 < arg_72_1.time_ and arg_72_1.time_ <= var_75_27 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_29 = arg_72_1:FormatText(StoryNameCfg[1332].name)

				arg_72_1.leftNameTxt_.text = var_75_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_30 = arg_72_1:GetWordFromCfg(938072018)
				local var_75_31 = arg_72_1:FormatText(var_75_30.content)

				arg_72_1.text_.text = var_75_31

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_32 = 36
				local var_75_33 = utf8.len(var_75_31)
				local var_75_34 = var_75_32 <= 0 and var_75_28 or var_75_28 * (var_75_33 / var_75_32)

				if var_75_34 > 0 and var_75_28 < var_75_34 then
					arg_72_1.talkMaxDuration = var_75_34

					if var_75_34 + var_75_27 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_34 + var_75_27
					end
				end

				arg_72_1.text_.text = var_75_31
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_35 = math.max(var_75_28, arg_72_1.talkMaxDuration)

			if var_75_27 <= arg_72_1.time_ and arg_72_1.time_ < var_75_27 + var_75_35 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_27) / var_75_35

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_27 + var_75_35 and arg_72_1.time_ < var_75_27 + var_75_35 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938072019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938072019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938072020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10144"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10144 == nil then
				arg_76_1.var_.actorSpriteComps10144 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10144 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10144 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10144 = nil
			end

			local var_79_8 = arg_76_1.actors_["108301"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps108301 == nil then
				arg_76_1.var_.actorSpriteComps108301 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 0.2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps108301 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps108301 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps108301 = nil
			end

			local var_79_16 = arg_76_1.actors_["10144"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos10144 = var_79_16.localPosition
				var_79_16.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10144", 2)

				local var_79_18 = var_79_16.childCount

				for iter_79_8 = 0, var_79_18 - 1 do
					local var_79_19 = var_79_16:GetChild(iter_79_8)

					if var_79_19.name == "split_11" then
						var_79_19:SetAsLastSibling()
						var_79_19.gameObject:SetActive(true)

						arg_76_1.var_.actorSpriteSplit10144 = var_79_19.gameObject:GetComponent(typeof(Image))

						arg_76_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_79_20 = 0.5

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_20 then
				local var_79_21 = (arg_76_1.time_ - var_79_17) / var_79_20
				local var_79_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10144, var_79_22, var_79_21)

				if arg_76_1.var_.actorSpriteSplit10144 ~= nil then
					arg_76_1.var_.actorSpriteSplit10144:SetAlpha(var_79_21)
				end
			end

			if arg_76_1.time_ >= var_79_17 + var_79_20 and arg_76_1.time_ < var_79_17 + var_79_20 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_76_1.var_.actorSpriteSplit10144 ~= nil then
					arg_76_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_79_23 = 0
			local var_79_24 = 0.425

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[1297].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(938072019)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 17
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
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_31 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_31 and arg_76_1.time_ < var_79_23 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play938072020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938072020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938072021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["106603"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps106603 == nil then
				arg_80_1.var_.actorSpriteComps106603 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps106603 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								local var_83_4 = Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, var_83_3)
								local var_83_5 = Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, var_83_3)
								local var_83_6 = Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, var_83_3)

								iter_83_1.color = Color.New(var_83_4, var_83_5, var_83_6)
							else
								local var_83_7 = Mathf.Lerp(iter_83_1.color.r, 1, var_83_3)

								iter_83_1.color = Color.New(var_83_7, var_83_7, var_83_7)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps106603 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps106603 = nil
			end

			local var_83_8 = arg_80_1.actors_["10144"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps10144 == nil then
				arg_80_1.var_.actorSpriteComps10144 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps10144 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								local var_83_12 = Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, var_83_11)
								local var_83_13 = Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, var_83_11)
								local var_83_14 = Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, var_83_11)

								iter_83_5.color = Color.New(var_83_12, var_83_13, var_83_14)
							else
								local var_83_15 = Mathf.Lerp(iter_83_5.color.r, 0.5, var_83_11)

								iter_83_5.color = Color.New(var_83_15, var_83_15, var_83_15)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps10144 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps10144 = nil
			end

			local var_83_16 = arg_80_1.actors_["106603"].transform
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.var_.moveOldPos106603 = var_83_16.localPosition
				var_83_16.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("106603", 4)

				local var_83_18 = var_83_16.childCount

				for iter_83_8 = 0, var_83_18 - 1 do
					local var_83_19 = var_83_16:GetChild(iter_83_8)

					if var_83_19.name == "split_12" or not string.find(var_83_19.name, "split") then
						var_83_19.gameObject:SetActive(true)
					else
						var_83_19.gameObject:SetActive(false)
					end
				end
			end

			local var_83_20 = 0.001

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_20 then
				local var_83_21 = (arg_80_1.time_ - var_83_17) / var_83_20
				local var_83_22 = Vector3.New(453.9, -399.1, -303.3)

				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos106603, var_83_22, var_83_21)
			end

			if arg_80_1.time_ >= var_83_17 + var_83_20 and arg_80_1.time_ < var_83_17 + var_83_20 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_83_23 = arg_80_1.actors_["108301"].transform
			local var_83_24 = 0

			if var_83_24 < arg_80_1.time_ and arg_80_1.time_ <= var_83_24 + arg_83_0 then
				arg_80_1.var_.moveOldPos108301 = var_83_23.localPosition
				var_83_23.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("108301", 7)

				local var_83_25 = var_83_23.childCount

				for iter_83_9 = 0, var_83_25 - 1 do
					local var_83_26 = var_83_23:GetChild(iter_83_9)

					if var_83_26.name == "split_7" or not string.find(var_83_26.name, "split") then
						var_83_26.gameObject:SetActive(true)
					else
						var_83_26.gameObject:SetActive(false)
					end
				end
			end

			local var_83_27 = 0.001

			if var_83_24 <= arg_80_1.time_ and arg_80_1.time_ < var_83_24 + var_83_27 then
				local var_83_28 = (arg_80_1.time_ - var_83_24) / var_83_27
				local var_83_29 = Vector3.New(0, -2000, 0)

				var_83_23.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos108301, var_83_29, var_83_28)
			end

			if arg_80_1.time_ >= var_83_24 + var_83_27 and arg_80_1.time_ < var_83_24 + var_83_27 + arg_83_0 then
				var_83_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_83_30 = 0
			local var_83_31 = 0.075

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_32 = arg_80_1:FormatText(StoryNameCfg[32].name)

				arg_80_1.leftNameTxt_.text = var_83_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_33 = arg_80_1:GetWordFromCfg(938072020)
				local var_83_34 = arg_80_1:FormatText(var_83_33.content)

				arg_80_1.text_.text = var_83_34

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_35 = 3
				local var_83_36 = utf8.len(var_83_34)
				local var_83_37 = var_83_35 <= 0 and var_83_31 or var_83_31 * (var_83_36 / var_83_35)

				if var_83_37 > 0 and var_83_31 < var_83_37 then
					arg_80_1.talkMaxDuration = var_83_37

					if var_83_37 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_37 + var_83_30
					end
				end

				arg_80_1.text_.text = var_83_34
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_38 = math.max(var_83_31, arg_80_1.talkMaxDuration)

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_38 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_30) / var_83_38

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_30 + var_83_38 and arg_80_1.time_ < var_83_30 + var_83_38 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play938072021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 938072021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play938072022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10144"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps10144 == nil then
				arg_84_1.var_.actorSpriteComps10144 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps10144 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps10144 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps10144 = nil
			end

			local var_87_8 = arg_84_1.actors_["106603"]
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps106603 == nil then
				arg_84_1.var_.actorSpriteComps106603 = var_87_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_10 = 0.2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 and not isNil(var_87_8) then
				local var_87_11 = (arg_84_1.time_ - var_87_9) / var_87_10

				if arg_84_1.var_.actorSpriteComps106603 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								local var_87_12 = Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor2.r, var_87_11)
								local var_87_13 = Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor2.g, var_87_11)
								local var_87_14 = Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor2.b, var_87_11)

								iter_87_5.color = Color.New(var_87_12, var_87_13, var_87_14)
							else
								local var_87_15 = Mathf.Lerp(iter_87_5.color.r, 0.5, var_87_11)

								iter_87_5.color = Color.New(var_87_15, var_87_15, var_87_15)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps106603 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_87_7 then
						if arg_84_1.isInRecall_ then
							iter_87_7.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps106603 = nil
			end

			local var_87_16 = arg_84_1.actors_["10144"].transform
			local var_87_17 = 0

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 then
				arg_84_1.var_.moveOldPos10144 = var_87_16.localPosition
				var_87_16.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10144", 2)

				local var_87_18 = var_87_16.childCount

				for iter_87_8 = 0, var_87_18 - 1 do
					local var_87_19 = var_87_16:GetChild(iter_87_8)

					if var_87_19.name == "split_11" or not string.find(var_87_19.name, "split") then
						var_87_19.gameObject:SetActive(true)
					else
						var_87_19.gameObject:SetActive(false)
					end
				end
			end

			local var_87_20 = 0.001

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_20 then
				local var_87_21 = (arg_84_1.time_ - var_87_17) / var_87_20
				local var_87_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_87_16.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10144, var_87_22, var_87_21)
			end

			if arg_84_1.time_ >= var_87_17 + var_87_20 and arg_84_1.time_ < var_87_17 + var_87_20 + arg_87_0 then
				var_87_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_87_23 = 0
			local var_87_24 = 1.175

			if var_87_23 < arg_84_1.time_ and arg_84_1.time_ <= var_87_23 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_25 = arg_84_1:FormatText(StoryNameCfg[1297].name)

				arg_84_1.leftNameTxt_.text = var_87_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_26 = arg_84_1:GetWordFromCfg(938072021)
				local var_87_27 = arg_84_1:FormatText(var_87_26.content)

				arg_84_1.text_.text = var_87_27

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_28 = 47
				local var_87_29 = utf8.len(var_87_27)
				local var_87_30 = var_87_28 <= 0 and var_87_24 or var_87_24 * (var_87_29 / var_87_28)

				if var_87_30 > 0 and var_87_24 < var_87_30 then
					arg_84_1.talkMaxDuration = var_87_30

					if var_87_30 + var_87_23 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_30 + var_87_23
					end
				end

				arg_84_1.text_.text = var_87_27
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_31 = math.max(var_87_24, arg_84_1.talkMaxDuration)

			if var_87_23 <= arg_84_1.time_ and arg_84_1.time_ < var_87_23 + var_87_31 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_23) / var_87_31

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_23 + var_87_31 and arg_84_1.time_ < var_87_23 + var_87_31 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 938072022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play938072023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.25

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[1297].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(938072022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 50
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play938072023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 938072023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play938072024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.625

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[1297].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:GetWordFromCfg(938072023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 65
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
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play938072024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 938072024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play938072025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10144"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10144 == nil then
				arg_96_1.var_.actorSpriteComps10144 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps10144 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 0.5, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10144 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10144 = nil
			end

			local var_99_8 = 0
			local var_99_9 = 0.7

			if var_99_8 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:GetWordFromCfg(938072024)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_12 = 28
				local var_99_13 = utf8.len(var_99_11)
				local var_99_14 = var_99_12 <= 0 and var_99_9 or var_99_9 * (var_99_13 / var_99_12)

				if var_99_14 > 0 and var_99_9 < var_99_14 then
					arg_96_1.talkMaxDuration = var_99_14

					if var_99_14 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_15 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_15 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_15

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_15 and arg_96_1.time_ < var_99_8 + var_99_15 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play938072025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 938072025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play938072026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["106603"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps106603 == nil then
				arg_100_1.var_.actorSpriteComps106603 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps106603 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps106603 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps106603 = nil
			end

			local var_103_8 = arg_100_1.actors_["106603"].transform
			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 then
				arg_100_1.var_.moveOldPos106603 = var_103_8.localPosition
				var_103_8.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("106603", 4)

				local var_103_10 = var_103_8.childCount

				for iter_103_4 = 0, var_103_10 - 1 do
					local var_103_11 = var_103_8:GetChild(iter_103_4)

					if var_103_11.name == "split_12" or not string.find(var_103_11.name, "split") then
						var_103_11.gameObject:SetActive(true)
					else
						var_103_11.gameObject:SetActive(false)
					end
				end
			end

			local var_103_12 = 0.001

			if var_103_9 <= arg_100_1.time_ and arg_100_1.time_ < var_103_9 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_9) / var_103_12
				local var_103_14 = Vector3.New(453.9, -399.1, -303.3)

				var_103_8.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos106603, var_103_14, var_103_13)
			end

			if arg_100_1.time_ >= var_103_9 + var_103_12 and arg_100_1.time_ < var_103_9 + var_103_12 + arg_103_0 then
				var_103_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_103_15 = 0
			local var_103_16 = 0.825

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[32].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(938072025)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 33
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
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_23 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_23 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_23

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_23 and arg_100_1.time_ < var_103_15 + var_103_23 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play938072026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 938072026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play938072027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10144"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10144 == nil then
				arg_104_1.var_.actorSpriteComps10144 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps10144 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 1, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10144 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10144 = nil
			end

			local var_107_8 = arg_104_1.actors_["106603"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps106603 == nil then
				arg_104_1.var_.actorSpriteComps106603 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 0.2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps106603 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_12 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, var_107_11)
								local var_107_13 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, var_107_11)
								local var_107_14 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, var_107_11)

								iter_107_5.color = Color.New(var_107_12, var_107_13, var_107_14)
							else
								local var_107_15 = Mathf.Lerp(iter_107_5.color.r, 0.5, var_107_11)

								iter_107_5.color = Color.New(var_107_15, var_107_15, var_107_15)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps106603 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps106603 = nil
			end

			local var_107_16 = arg_104_1.actors_["10144"].transform
			local var_107_17 = 0

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.var_.moveOldPos10144 = var_107_16.localPosition
				var_107_16.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10144", 2)

				local var_107_18 = var_107_16.childCount

				for iter_107_8 = 0, var_107_18 - 1 do
					local var_107_19 = var_107_16:GetChild(iter_107_8)

					if var_107_19.name == "split_12" or not string.find(var_107_19.name, "split") then
						var_107_19.gameObject:SetActive(true)
					else
						var_107_19.gameObject:SetActive(false)
					end
				end
			end

			local var_107_20 = 0.001

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_20 then
				local var_107_21 = (arg_104_1.time_ - var_107_17) / var_107_20
				local var_107_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10144, var_107_22, var_107_21)
			end

			if arg_104_1.time_ >= var_107_17 + var_107_20 and arg_104_1.time_ < var_107_17 + var_107_20 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_107_23 = 0
			local var_107_24 = 0.475

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_25 = arg_104_1:FormatText(StoryNameCfg[1297].name)

				arg_104_1.leftNameTxt_.text = var_107_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_26 = arg_104_1:GetWordFromCfg(938072026)
				local var_107_27 = arg_104_1:FormatText(var_107_26.content)

				arg_104_1.text_.text = var_107_27

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_28 = 19
				local var_107_29 = utf8.len(var_107_27)
				local var_107_30 = var_107_28 <= 0 and var_107_24 or var_107_24 * (var_107_29 / var_107_28)

				if var_107_30 > 0 and var_107_24 < var_107_30 then
					arg_104_1.talkMaxDuration = var_107_30

					if var_107_30 + var_107_23 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_30 + var_107_23
					end
				end

				arg_104_1.text_.text = var_107_27
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_31 = math.max(var_107_24, arg_104_1.talkMaxDuration)

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_31 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_23) / var_107_31

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_23 + var_107_31 and arg_104_1.time_ < var_107_23 + var_107_31 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play938072027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 938072027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play938072028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["104902"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps104902 == nil then
				arg_108_1.var_.actorSpriteComps104902 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps104902 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 1, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps104902 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps104902 = nil
			end

			local var_111_8 = arg_108_1.actors_["10144"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10144 == nil then
				arg_108_1.var_.actorSpriteComps10144 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.2

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps10144 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								local var_111_12 = Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, var_111_11)
								local var_111_13 = Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, var_111_11)
								local var_111_14 = Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, var_111_11)

								iter_111_5.color = Color.New(var_111_12, var_111_13, var_111_14)
							else
								local var_111_15 = Mathf.Lerp(iter_111_5.color.r, 0.5, var_111_11)

								iter_111_5.color = Color.New(var_111_15, var_111_15, var_111_15)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10144 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10144 = nil
			end

			local var_111_16 = arg_108_1.actors_["104902"].transform
			local var_111_17 = 0

			if var_111_17 < arg_108_1.time_ and arg_108_1.time_ <= var_111_17 + arg_111_0 then
				arg_108_1.var_.moveOldPos104902 = var_111_16.localPosition
				var_111_16.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("104902", 2)

				local var_111_18 = var_111_16.childCount

				for iter_111_8 = 0, var_111_18 - 1 do
					local var_111_19 = var_111_16:GetChild(iter_111_8)

					if var_111_19.name == "split_6" or not string.find(var_111_19.name, "split") then
						var_111_19.gameObject:SetActive(true)
					else
						var_111_19.gameObject:SetActive(false)
					end
				end
			end

			local var_111_20 = 0.001

			if var_111_17 <= arg_108_1.time_ and arg_108_1.time_ < var_111_17 + var_111_20 then
				local var_111_21 = (arg_108_1.time_ - var_111_17) / var_111_20
				local var_111_22 = Vector3.New(-390, -335, -360)

				var_111_16.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos104902, var_111_22, var_111_21)
			end

			if arg_108_1.time_ >= var_111_17 + var_111_20 and arg_108_1.time_ < var_111_17 + var_111_20 + arg_111_0 then
				var_111_16.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_111_23 = arg_108_1.actors_["10144"].transform
			local var_111_24 = 0

			if var_111_24 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.var_.moveOldPos10144 = var_111_23.localPosition
				var_111_23.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("10144", 7)

				local var_111_25 = var_111_23.childCount

				for iter_111_9 = 0, var_111_25 - 1 do
					local var_111_26 = var_111_23:GetChild(iter_111_9)

					if var_111_26.name == "" or not string.find(var_111_26.name, "split") then
						var_111_26.gameObject:SetActive(true)
					else
						var_111_26.gameObject:SetActive(false)
					end
				end
			end

			local var_111_27 = 0.001

			if var_111_24 <= arg_108_1.time_ and arg_108_1.time_ < var_111_24 + var_111_27 then
				local var_111_28 = (arg_108_1.time_ - var_111_24) / var_111_27
				local var_111_29 = Vector3.New(0, -2000, 0)

				var_111_23.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10144, var_111_29, var_111_28)
			end

			if arg_108_1.time_ >= var_111_24 + var_111_27 and arg_108_1.time_ < var_111_24 + var_111_27 + arg_111_0 then
				var_111_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_111_30 = 0
			local var_111_31 = 0.525

			if var_111_30 < arg_108_1.time_ and arg_108_1.time_ <= var_111_30 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_32 = arg_108_1:FormatText(StoryNameCfg[562].name)

				arg_108_1.leftNameTxt_.text = var_111_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_33 = arg_108_1:GetWordFromCfg(938072027)
				local var_111_34 = arg_108_1:FormatText(var_111_33.content)

				arg_108_1.text_.text = var_111_34

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_35 = 21
				local var_111_36 = utf8.len(var_111_34)
				local var_111_37 = var_111_35 <= 0 and var_111_31 or var_111_31 * (var_111_36 / var_111_35)

				if var_111_37 > 0 and var_111_31 < var_111_37 then
					arg_108_1.talkMaxDuration = var_111_37

					if var_111_37 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_37 + var_111_30
					end
				end

				arg_108_1.text_.text = var_111_34
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_38 = math.max(var_111_31, arg_108_1.talkMaxDuration)

			if var_111_30 <= arg_108_1.time_ and arg_108_1.time_ < var_111_30 + var_111_38 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_30) / var_111_38

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_30 + var_111_38 and arg_108_1.time_ < var_111_30 + var_111_38 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 938072028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play938072029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10144"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10144 == nil then
				arg_112_1.var_.actorSpriteComps10144 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps10144 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 1, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10144 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10144 = nil
			end

			local var_115_8 = arg_112_1.actors_["104902"]
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps104902 == nil then
				arg_112_1.var_.actorSpriteComps104902 = var_115_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_10 = 0.2

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 and not isNil(var_115_8) then
				local var_115_11 = (arg_112_1.time_ - var_115_9) / var_115_10

				if arg_112_1.var_.actorSpriteComps104902 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								local var_115_12 = Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor2.r, var_115_11)
								local var_115_13 = Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor2.g, var_115_11)
								local var_115_14 = Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor2.b, var_115_11)

								iter_115_5.color = Color.New(var_115_12, var_115_13, var_115_14)
							else
								local var_115_15 = Mathf.Lerp(iter_115_5.color.r, 0.5, var_115_11)

								iter_115_5.color = Color.New(var_115_15, var_115_15, var_115_15)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps104902 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_115_7 then
						if arg_112_1.isInRecall_ then
							iter_115_7.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps104902 = nil
			end

			local var_115_16 = arg_112_1.actors_["10144"].transform
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.var_.moveOldPos10144 = var_115_16.localPosition
				var_115_16.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10144", 2)

				local var_115_18 = var_115_16.childCount

				for iter_115_8 = 0, var_115_18 - 1 do
					local var_115_19 = var_115_16:GetChild(iter_115_8)

					if var_115_19.name == "split_11" or not string.find(var_115_19.name, "split") then
						var_115_19.gameObject:SetActive(true)
					else
						var_115_19.gameObject:SetActive(false)
					end
				end
			end

			local var_115_20 = 0.001

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_20 then
				local var_115_21 = (arg_112_1.time_ - var_115_17) / var_115_20
				local var_115_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_115_16.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10144, var_115_22, var_115_21)
			end

			if arg_112_1.time_ >= var_115_17 + var_115_20 and arg_112_1.time_ < var_115_17 + var_115_20 + arg_115_0 then
				var_115_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_115_23 = 0
			local var_115_24 = 0.4

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_25 = arg_112_1:FormatText(StoryNameCfg[1297].name)

				arg_112_1.leftNameTxt_.text = var_115_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_26 = arg_112_1:GetWordFromCfg(938072028)
				local var_115_27 = arg_112_1:FormatText(var_115_26.content)

				arg_112_1.text_.text = var_115_27

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_28 = 16
				local var_115_29 = utf8.len(var_115_27)
				local var_115_30 = var_115_28 <= 0 and var_115_24 or var_115_24 * (var_115_29 / var_115_28)

				if var_115_30 > 0 and var_115_24 < var_115_30 then
					arg_112_1.talkMaxDuration = var_115_30

					if var_115_30 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_23
					end
				end

				arg_112_1.text_.text = var_115_27
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_31 = math.max(var_115_24, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_31 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_31

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_31 and arg_112_1.time_ < var_115_23 + var_115_31 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play938072029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 938072029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play938072030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["108301"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps108301 == nil then
				arg_116_1.var_.actorSpriteComps108301 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps108301 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 1, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps108301 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps108301 = nil
			end

			local var_119_8 = arg_116_1.actors_["10144"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps10144 == nil then
				arg_116_1.var_.actorSpriteComps10144 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps10144 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								local var_119_12 = Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, var_119_11)
								local var_119_13 = Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, var_119_11)
								local var_119_14 = Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, var_119_11)

								iter_119_5.color = Color.New(var_119_12, var_119_13, var_119_14)
							else
								local var_119_15 = Mathf.Lerp(iter_119_5.color.r, 0.5, var_119_11)

								iter_119_5.color = Color.New(var_119_15, var_119_15, var_119_15)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps10144 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10144 = nil
			end

			local var_119_16 = arg_116_1.actors_["108301"].transform
			local var_119_17 = 0

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.var_.moveOldPos108301 = var_119_16.localPosition
				var_119_16.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("108301", 4)

				local var_119_18 = var_119_16.childCount

				for iter_119_8 = 0, var_119_18 - 1 do
					local var_119_19 = var_119_16:GetChild(iter_119_8)

					if var_119_19.name == "split_6" or not string.find(var_119_19.name, "split") then
						var_119_19.gameObject:SetActive(true)
					else
						var_119_19.gameObject:SetActive(false)
					end
				end
			end

			local var_119_20 = 0.001

			if var_119_17 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_20 then
				local var_119_21 = (arg_116_1.time_ - var_119_17) / var_119_20
				local var_119_22 = Vector3.New(460, -360, -195)

				var_119_16.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos108301, var_119_22, var_119_21)
			end

			if arg_116_1.time_ >= var_119_17 + var_119_20 and arg_116_1.time_ < var_119_17 + var_119_20 + arg_119_0 then
				var_119_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_119_23 = arg_116_1.actors_["106603"].transform
			local var_119_24 = 0

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1.var_.moveOldPos106603 = var_119_23.localPosition
				var_119_23.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("106603", 7)

				local var_119_25 = var_119_23.childCount

				for iter_119_9 = 0, var_119_25 - 1 do
					local var_119_26 = var_119_23:GetChild(iter_119_9)

					if var_119_26.name == "split_12" or not string.find(var_119_26.name, "split") then
						var_119_26.gameObject:SetActive(true)
					else
						var_119_26.gameObject:SetActive(false)
					end
				end
			end

			local var_119_27 = 0.001

			if var_119_24 <= arg_116_1.time_ and arg_116_1.time_ < var_119_24 + var_119_27 then
				local var_119_28 = (arg_116_1.time_ - var_119_24) / var_119_27
				local var_119_29 = Vector3.New(0, -2000, 0)

				var_119_23.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos106603, var_119_29, var_119_28)
			end

			if arg_116_1.time_ >= var_119_24 + var_119_27 and arg_116_1.time_ < var_119_24 + var_119_27 + arg_119_0 then
				var_119_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_30 = 0
			local var_119_31 = 0.525

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_32 = arg_116_1:FormatText(StoryNameCfg[1332].name)

				arg_116_1.leftNameTxt_.text = var_119_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_33 = arg_116_1:GetWordFromCfg(938072029)
				local var_119_34 = arg_116_1:FormatText(var_119_33.content)

				arg_116_1.text_.text = var_119_34

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_35 = 21
				local var_119_36 = utf8.len(var_119_34)
				local var_119_37 = var_119_35 <= 0 and var_119_31 or var_119_31 * (var_119_36 / var_119_35)

				if var_119_37 > 0 and var_119_31 < var_119_37 then
					arg_116_1.talkMaxDuration = var_119_37

					if var_119_37 + var_119_30 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_37 + var_119_30
					end
				end

				arg_116_1.text_.text = var_119_34
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_38 = math.max(var_119_31, arg_116_1.talkMaxDuration)

			if var_119_30 <= arg_116_1.time_ and arg_116_1.time_ < var_119_30 + var_119_38 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_30) / var_119_38

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_30 + var_119_38 and arg_116_1.time_ < var_119_30 + var_119_38 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play938072030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 938072030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play938072031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["128404"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps128404 == nil then
				arg_120_1.var_.actorSpriteComps128404 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps128404 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								local var_123_4 = Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, var_123_3)
								local var_123_5 = Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, var_123_3)
								local var_123_6 = Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, var_123_3)

								iter_123_1.color = Color.New(var_123_4, var_123_5, var_123_6)
							else
								local var_123_7 = Mathf.Lerp(iter_123_1.color.r, 1, var_123_3)

								iter_123_1.color = Color.New(var_123_7, var_123_7, var_123_7)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps128404 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps128404 = nil
			end

			local var_123_8 = arg_120_1.actors_["108301"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps108301 == nil then
				arg_120_1.var_.actorSpriteComps108301 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps108301 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								local var_123_12 = Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, var_123_11)
								local var_123_13 = Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, var_123_11)
								local var_123_14 = Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, var_123_11)

								iter_123_5.color = Color.New(var_123_12, var_123_13, var_123_14)
							else
								local var_123_15 = Mathf.Lerp(iter_123_5.color.r, 0.5, var_123_11)

								iter_123_5.color = Color.New(var_123_15, var_123_15, var_123_15)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps108301 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps108301 = nil
			end

			local var_123_16 = arg_120_1.actors_["128404"].transform
			local var_123_17 = 0

			if var_123_17 < arg_120_1.time_ and arg_120_1.time_ <= var_123_17 + arg_123_0 then
				arg_120_1.var_.moveOldPos128404 = var_123_16.localPosition
				var_123_16.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("128404", 4)

				local var_123_18 = var_123_16.childCount

				for iter_123_8 = 0, var_123_18 - 1 do
					local var_123_19 = var_123_16:GetChild(iter_123_8)

					if var_123_19.name == "split_10" or not string.find(var_123_19.name, "split") then
						var_123_19.gameObject:SetActive(true)
					else
						var_123_19.gameObject:SetActive(false)
					end
				end
			end

			local var_123_20 = 0.001

			if var_123_17 <= arg_120_1.time_ and arg_120_1.time_ < var_123_17 + var_123_20 then
				local var_123_21 = (arg_120_1.time_ - var_123_17) / var_123_20
				local var_123_22 = Vector3.New(390.2, -356, -362.3)

				var_123_16.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos128404, var_123_22, var_123_21)
			end

			if arg_120_1.time_ >= var_123_17 + var_123_20 and arg_120_1.time_ < var_123_17 + var_123_20 + arg_123_0 then
				var_123_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_123_23 = arg_120_1.actors_["108301"].transform
			local var_123_24 = 0

			if var_123_24 < arg_120_1.time_ and arg_120_1.time_ <= var_123_24 + arg_123_0 then
				arg_120_1.var_.moveOldPos108301 = var_123_23.localPosition
				var_123_23.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("108301", 7)

				local var_123_25 = var_123_23.childCount

				for iter_123_9 = 0, var_123_25 - 1 do
					local var_123_26 = var_123_23:GetChild(iter_123_9)

					if var_123_26.name == "" or not string.find(var_123_26.name, "split") then
						var_123_26.gameObject:SetActive(true)
					else
						var_123_26.gameObject:SetActive(false)
					end
				end
			end

			local var_123_27 = 0.001

			if var_123_24 <= arg_120_1.time_ and arg_120_1.time_ < var_123_24 + var_123_27 then
				local var_123_28 = (arg_120_1.time_ - var_123_24) / var_123_27
				local var_123_29 = Vector3.New(0, -2000, 0)

				var_123_23.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos108301, var_123_29, var_123_28)
			end

			if arg_120_1.time_ >= var_123_24 + var_123_27 and arg_120_1.time_ < var_123_24 + var_123_27 + arg_123_0 then
				var_123_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_123_30 = 0
			local var_123_31 = 0.65

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_32 = arg_120_1:FormatText(StoryNameCfg[6].name)

				arg_120_1.leftNameTxt_.text = var_123_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_33 = arg_120_1:GetWordFromCfg(938072030)
				local var_123_34 = arg_120_1:FormatText(var_123_33.content)

				arg_120_1.text_.text = var_123_34

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_35 = 26
				local var_123_36 = utf8.len(var_123_34)
				local var_123_37 = var_123_35 <= 0 and var_123_31 or var_123_31 * (var_123_36 / var_123_35)

				if var_123_37 > 0 and var_123_31 < var_123_37 then
					arg_120_1.talkMaxDuration = var_123_37

					if var_123_37 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_37 + var_123_30
					end
				end

				arg_120_1.text_.text = var_123_34
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_38 = math.max(var_123_31, arg_120_1.talkMaxDuration)

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_38 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_30) / var_123_38

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_30 + var_123_38 and arg_120_1.time_ < var_123_30 + var_123_38 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play938072031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 938072031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play938072032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10144"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10144 == nil then
				arg_124_1.var_.actorSpriteComps10144 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10144 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 1, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10144 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10144 = nil
			end

			local var_127_8 = arg_124_1.actors_["128404"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps128404 == nil then
				arg_124_1.var_.actorSpriteComps128404 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps128404 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 0.5, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps128404 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps128404 = nil
			end

			local var_127_16 = arg_124_1.actors_["10144"].transform
			local var_127_17 = 0

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.var_.moveOldPos10144 = var_127_16.localPosition
				var_127_16.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10144", 2)

				local var_127_18 = var_127_16.childCount

				for iter_127_8 = 0, var_127_18 - 1 do
					local var_127_19 = var_127_16:GetChild(iter_127_8)

					if var_127_19.name == "split_11" or not string.find(var_127_19.name, "split") then
						var_127_19.gameObject:SetActive(true)
					else
						var_127_19.gameObject:SetActive(false)
					end
				end
			end

			local var_127_20 = 0.001

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_20 then
				local var_127_21 = (arg_124_1.time_ - var_127_17) / var_127_20
				local var_127_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_127_16.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10144, var_127_22, var_127_21)
			end

			if arg_124_1.time_ >= var_127_17 + var_127_20 and arg_124_1.time_ < var_127_17 + var_127_20 + arg_127_0 then
				var_127_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_127_23 = 0
			local var_127_24 = 0.925

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[1297].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(938072031)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 37
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_31 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_31 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_31

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_31 and arg_124_1.time_ < var_127_23 + var_127_31 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play938072032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 938072032
		arg_128_1.duration_ = 1

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"

			SetActive(arg_128_1.choicesGo_, true)

			for iter_129_0, iter_129_1 in ipairs(arg_128_1.choices_) do
				local var_129_0 = iter_129_0 <= 1

				SetActive(iter_129_1.go, var_129_0)
			end

			arg_128_1.choices_[1].txt.text = arg_128_1:FormatText(StoryChoiceCfg[1790].name)
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play938072033(arg_128_1)
			end

			arg_128_1:RecordChoiceLog(938072032, 1790)
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10144"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10144 == nil then
				arg_128_1.var_.actorSpriteComps10144 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps10144 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 0.5, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10144 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10144 = nil
			end

			local var_131_8 = 0

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			local var_131_9 = 0.6

			if arg_128_1.time_ >= var_131_8 + var_131_9 and arg_128_1.time_ < var_131_8 + var_131_9 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play938072033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 938072033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play938072034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10144"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10144 == nil then
				arg_132_1.var_.actorSpriteComps10144 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps10144 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 1, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10144 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10144 = nil
			end

			local var_135_8 = arg_132_1.actors_["10144"].transform
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.var_.moveOldPos10144 = var_135_8.localPosition
				var_135_8.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10144", 2)

				local var_135_10 = var_135_8.childCount

				for iter_135_4 = 0, var_135_10 - 1 do
					local var_135_11 = var_135_8:GetChild(iter_135_4)

					if var_135_11.name == "split_14" or not string.find(var_135_11.name, "split") then
						var_135_11.gameObject:SetActive(true)
					else
						var_135_11.gameObject:SetActive(false)
					end
				end
			end

			local var_135_12 = 0.001

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_12 then
				local var_135_13 = (arg_132_1.time_ - var_135_9) / var_135_12
				local var_135_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10144, var_135_14, var_135_13)
			end

			if arg_132_1.time_ >= var_135_9 + var_135_12 and arg_132_1.time_ < var_135_9 + var_135_12 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_135_15 = 0
			local var_135_16 = 0.075

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[1297].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(938072033)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 3
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_23 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_23 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_23

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_23 and arg_132_1.time_ < var_135_15 + var_135_23 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play938072034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 938072034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play938072035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10144"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10144 == nil then
				arg_136_1.var_.actorSpriteComps10144 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps10144 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 0.5, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10144 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10144 = nil
			end

			local var_139_8 = 0
			local var_139_9 = 1.075

			if var_139_8 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_10 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_11 = arg_136_1:GetWordFromCfg(938072034)
				local var_139_12 = arg_136_1:FormatText(var_139_11.content)

				arg_136_1.text_.text = var_139_12

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 43
				local var_139_14 = utf8.len(var_139_12)
				local var_139_15 = var_139_13 <= 0 and var_139_9 or var_139_9 * (var_139_14 / var_139_13)

				if var_139_15 > 0 and var_139_9 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_12
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play938072035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 938072035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play938072036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.3

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(938072035)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 52
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play938072036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 938072036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play938072037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10183"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10183 == nil then
				arg_144_1.var_.actorSpriteComps10183 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps10183 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 1, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10183 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10183 = nil
			end

			local var_147_8 = arg_144_1.actors_["10183"].transform
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.var_.moveOldPos10183 = var_147_8.localPosition
				var_147_8.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10183", 4)

				local var_147_10 = var_147_8.childCount

				for iter_147_4 = 0, var_147_10 - 1 do
					local var_147_11 = var_147_8:GetChild(iter_147_4)

					if var_147_11.name == "split_9" or not string.find(var_147_11.name, "split") then
						var_147_11.gameObject:SetActive(true)
					else
						var_147_11.gameObject:SetActive(false)
					end
				end
			end

			local var_147_12 = 0.001

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_9) / var_147_12
				local var_147_14 = Vector3.New(300, -475, -325)

				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10183, var_147_14, var_147_13)
			end

			if arg_144_1.time_ >= var_147_9 + var_147_12 and arg_144_1.time_ < var_147_9 + var_147_12 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(300, -475, -325)
			end

			local var_147_15 = 0
			local var_147_16 = 0.925

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_17 = arg_144_1:FormatText(StoryNameCfg[1562].name)

				arg_144_1.leftNameTxt_.text = var_147_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_18 = arg_144_1:GetWordFromCfg(938072036)
				local var_147_19 = arg_144_1:FormatText(var_147_18.content)

				arg_144_1.text_.text = var_147_19

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_20 = 37
				local var_147_21 = utf8.len(var_147_19)
				local var_147_22 = var_147_20 <= 0 and var_147_16 or var_147_16 * (var_147_21 / var_147_20)

				if var_147_22 > 0 and var_147_16 < var_147_22 then
					arg_144_1.talkMaxDuration = var_147_22

					if var_147_22 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_22 + var_147_15
					end
				end

				arg_144_1.text_.text = var_147_19
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_23 = math.max(var_147_16, arg_144_1.talkMaxDuration)

			if var_147_15 <= arg_144_1.time_ and arg_144_1.time_ < var_147_15 + var_147_23 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_15) / var_147_23

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_15 + var_147_23 and arg_144_1.time_ < var_147_15 + var_147_23 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play938072037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 938072037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play938072038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.2

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[1562].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(938072037)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 8
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play938072038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 938072038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play938072039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10183"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps10183 == nil then
				arg_152_1.var_.actorSpriteComps10183 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps10183 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor2.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor2.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor2.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 0.5, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps10183 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps10183 = nil
			end

			local var_155_8 = manager.ui.mainCamera.transform
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.var_.shakeOldPos = var_155_8.localPosition
			end

			local var_155_10 = 0.3

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_10 then
				local var_155_11 = (arg_152_1.time_ - var_155_9) / 0.066
				local var_155_12, var_155_13 = math.modf(var_155_11)

				var_155_8.localPosition = Vector3.New(var_155_13 * 0.13, var_155_13 * 0.13, var_155_13 * 0.13) + arg_152_1.var_.shakeOldPos
			end

			if arg_152_1.time_ >= var_155_9 + var_155_10 and arg_152_1.time_ < var_155_9 + var_155_10 + arg_155_0 then
				var_155_8.localPosition = arg_152_1.var_.shakeOldPos
			end

			local var_155_14 = manager.ui.mainCamera.transform
			local var_155_15 = 0.466666666666667

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.var_.shakeOldPos = var_155_14.localPosition
			end

			local var_155_16 = 0.3

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / 0.066
				local var_155_18, var_155_19 = math.modf(var_155_17)

				var_155_14.localPosition = Vector3.New(var_155_19 * 0.13, var_155_19 * 0.13, var_155_19 * 0.13) + arg_152_1.var_.shakeOldPos
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 then
				var_155_14.localPosition = arg_152_1.var_.shakeOldPos
			end

			local var_155_20 = 0

			if var_155_20 < arg_152_1.time_ and arg_152_1.time_ <= var_155_20 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			local var_155_21 = 0.766666666666667

			if arg_152_1.time_ >= var_155_20 + var_155_21 and arg_152_1.time_ < var_155_20 + var_155_21 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			local var_155_22 = 0
			local var_155_23 = 0.1

			if var_155_22 < arg_152_1.time_ and arg_152_1.time_ <= var_155_22 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_24 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_24:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_25 = arg_152_1:FormatText(StoryNameCfg[1565].name)

				arg_152_1.leftNameTxt_.text = var_155_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_26 = arg_152_1:GetWordFromCfg(938072038)
				local var_155_27 = arg_152_1:FormatText(var_155_26.content)

				arg_152_1.text_.text = var_155_27

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_28 = 4
				local var_155_29 = utf8.len(var_155_27)
				local var_155_30 = var_155_28 <= 0 and var_155_23 or var_155_23 * (var_155_29 / var_155_28)

				if var_155_30 > 0 and var_155_23 < var_155_30 then
					arg_152_1.talkMaxDuration = var_155_30
					var_155_22 = var_155_22 + 0.3

					if var_155_30 + var_155_22 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_30 + var_155_22
					end
				end

				arg_152_1.text_.text = var_155_27
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_31 = var_155_22 + 0.3
			local var_155_32 = math.max(var_155_23, arg_152_1.talkMaxDuration)

			if var_155_31 <= arg_152_1.time_ and arg_152_1.time_ < var_155_31 + var_155_32 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_31) / var_155_32

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_31 + var_155_32 and arg_152_1.time_ < var_155_31 + var_155_32 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play938072039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938072039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938072040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10183"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos10183 = var_161_0.localPosition
				var_161_0.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10183", 7)

				local var_161_2 = var_161_0.childCount

				for iter_161_0 = 0, var_161_2 - 1 do
					local var_161_3 = var_161_0:GetChild(iter_161_0)

					if var_161_3.name == "" or not string.find(var_161_3.name, "split") then
						var_161_3.gameObject:SetActive(true)
					else
						var_161_3.gameObject:SetActive(false)
					end
				end
			end

			local var_161_4 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_4 then
				local var_161_5 = (arg_158_1.time_ - var_161_1) / var_161_4
				local var_161_6 = Vector3.New(0, -2000, 0)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10183, var_161_6, var_161_5)
			end

			if arg_158_1.time_ >= var_161_1 + var_161_4 and arg_158_1.time_ < var_161_1 + var_161_4 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_161_7 = arg_158_1.actors_["10144"].transform
			local var_161_8 = 0

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.var_.moveOldPos10144 = var_161_7.localPosition
				var_161_7.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10144", 7)

				local var_161_9 = var_161_7.childCount

				for iter_161_1 = 0, var_161_9 - 1 do
					local var_161_10 = var_161_7:GetChild(iter_161_1)

					if var_161_10.name == "" or not string.find(var_161_10.name, "split") then
						var_161_10.gameObject:SetActive(true)
					else
						var_161_10.gameObject:SetActive(false)
					end
				end
			end

			local var_161_11 = 0.001

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_11 then
				local var_161_12 = (arg_158_1.time_ - var_161_8) / var_161_11
				local var_161_13 = Vector3.New(0, -2000, 0)

				var_161_7.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10144, var_161_13, var_161_12)
			end

			if arg_158_1.time_ >= var_161_8 + var_161_11 and arg_158_1.time_ < var_161_8 + var_161_11 + arg_161_0 then
				var_161_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_161_14 = manager.ui.mainCamera.transform
			local var_161_15 = 0

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				local var_161_16 = arg_158_1.var_.effectsuipianguangmang1

				if var_161_16 then
					Object.Destroy(var_161_16)

					arg_158_1.var_.effectsuipianguangmang1 = nil
				end
			end

			local var_161_17 = manager.ui.mainCamera.transform
			local var_161_18 = 0

			if var_161_18 < arg_158_1.time_ and arg_158_1.time_ <= var_161_18 + arg_161_0 then
				local var_161_19 = arg_158_1.var_.effectsuipianguangmang2
				local var_161_20
				local var_161_21 = var_161_17

				if not var_161_19 then
					var_161_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_161_21)
					var_161_19.name = "suipianguangmang2"
					arg_158_1.var_.effectsuipianguangmang2 = var_161_19
				else
					var_161_19.transform:SetParent(var_161_21)
				end

				var_161_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_161_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_161_22 = manager.ui.mainCamera.transform
			local var_161_23 = 1.73333333333333

			if var_161_23 < arg_158_1.time_ and arg_158_1.time_ <= var_161_23 + arg_161_0 then
				local var_161_24 = arg_158_1.var_.effectsuipianguangmang2

				if var_161_24 then
					Object.Destroy(var_161_24)

					arg_158_1.var_.effectsuipianguangmang2 = nil
				end
			end

			local var_161_25 = arg_158_1.bgs_.I20f.transform
			local var_161_26 = 0

			if var_161_26 < arg_158_1.time_ and arg_158_1.time_ <= var_161_26 + arg_161_0 then
				arg_158_1.var_.moveOldPosI20f = var_161_25.localPosition
			end

			local var_161_27 = 0.233333333333333

			if var_161_26 <= arg_158_1.time_ and arg_158_1.time_ < var_161_26 + var_161_27 then
				local var_161_28 = (arg_158_1.time_ - var_161_26) / var_161_27
				local var_161_29 = Vector3.New(0, 1, 9.5)

				var_161_25.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPosI20f, var_161_29, var_161_28)
			end

			if arg_158_1.time_ >= var_161_26 + var_161_27 and arg_158_1.time_ < var_161_26 + var_161_27 + arg_161_0 then
				var_161_25.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_161_30 = 0

			if var_161_30 < arg_158_1.time_ and arg_158_1.time_ <= var_161_30 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			local var_161_31 = 1.93333333333333

			if arg_158_1.time_ >= var_161_30 + var_161_31 and arg_158_1.time_ < var_161_30 + var_161_31 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end

			local var_161_32 = 0
			local var_161_33 = 0.875

			if var_161_32 < arg_158_1.time_ and arg_158_1.time_ <= var_161_32 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_34 = arg_158_1:GetWordFromCfg(938072039)
				local var_161_35 = arg_158_1:FormatText(var_161_34.content)

				arg_158_1.text_.text = var_161_35

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_36 = 35
				local var_161_37 = utf8.len(var_161_35)
				local var_161_38 = var_161_36 <= 0 and var_161_33 or var_161_33 * (var_161_37 / var_161_36)

				if var_161_38 > 0 and var_161_33 < var_161_38 then
					arg_158_1.talkMaxDuration = var_161_38

					if var_161_38 + var_161_32 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_38 + var_161_32
					end
				end

				arg_158_1.text_.text = var_161_35
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_39 = math.max(var_161_33, arg_158_1.talkMaxDuration)

			if var_161_32 <= arg_158_1.time_ and arg_158_1.time_ < var_161_32 + var_161_39 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_32) / var_161_39

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_32 + var_161_39 and arg_158_1.time_ < var_161_32 + var_161_39 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "I20f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.233333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play938072040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938072040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938072041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.45

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(938072040)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 58
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play938072041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938072041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938072042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10183"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10183 == nil then
				arg_166_1.var_.actorSpriteComps10183 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10183 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 1, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10183 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10183 = nil
			end

			local var_169_8 = arg_166_1.actors_["10183"].transform
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.var_.moveOldPos10183 = var_169_8.localPosition
				var_169_8.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10183", 2)

				local var_169_10 = var_169_8.childCount

				for iter_169_4 = 0, var_169_10 - 1 do
					local var_169_11 = var_169_8:GetChild(iter_169_4)

					if var_169_11.name == "split_10" or not string.find(var_169_11.name, "split") then
						var_169_11.gameObject:SetActive(true)
					else
						var_169_11.gameObject:SetActive(false)
					end
				end
			end

			local var_169_12 = 0.001

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_12 then
				local var_169_13 = (arg_166_1.time_ - var_169_9) / var_169_12
				local var_169_14 = Vector3.New(-300, -475, -325)

				var_169_8.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10183, var_169_14, var_169_13)
			end

			if arg_166_1.time_ >= var_169_9 + var_169_12 and arg_166_1.time_ < var_169_9 + var_169_12 + arg_169_0 then
				var_169_8.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_169_15 = 0
			local var_169_16 = 0.5

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[1562].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(938072041)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 20
				local var_169_21 = utf8.len(var_169_19)
				local var_169_22 = var_169_20 <= 0 and var_169_16 or var_169_16 * (var_169_21 / var_169_20)

				if var_169_22 > 0 and var_169_16 < var_169_22 then
					arg_166_1.talkMaxDuration = var_169_22

					if var_169_22 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_22 + var_169_15
					end
				end

				arg_166_1.text_.text = var_169_19
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_23 = math.max(var_169_16, arg_166_1.talkMaxDuration)

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_23 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_15) / var_169_23

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_15 + var_169_23 and arg_166_1.time_ < var_169_15 + var_169_23 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play938072042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938072042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938072043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10144"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10144 == nil then
				arg_170_1.var_.actorSpriteComps10144 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps10144 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 1, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10144 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10144 = nil
			end

			local var_173_8 = arg_170_1.actors_["10183"]
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps10183 == nil then
				arg_170_1.var_.actorSpriteComps10183 = var_173_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_10 = 0.2

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_10 and not isNil(var_173_8) then
				local var_173_11 = (arg_170_1.time_ - var_173_9) / var_173_10

				if arg_170_1.var_.actorSpriteComps10183 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								local var_173_12 = Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, var_173_11)
								local var_173_13 = Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, var_173_11)
								local var_173_14 = Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, var_173_11)

								iter_173_5.color = Color.New(var_173_12, var_173_13, var_173_14)
							else
								local var_173_15 = Mathf.Lerp(iter_173_5.color.r, 0.5, var_173_11)

								iter_173_5.color = Color.New(var_173_15, var_173_15, var_173_15)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_9 + var_173_10 and arg_170_1.time_ < var_173_9 + var_173_10 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps10183 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_173_7 then
						if arg_170_1.isInRecall_ then
							iter_173_7.color = arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_173_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10183 = nil
			end

			local var_173_16 = arg_170_1.actors_["10144"].transform
			local var_173_17 = 0

			if var_173_17 < arg_170_1.time_ and arg_170_1.time_ <= var_173_17 + arg_173_0 then
				arg_170_1.var_.moveOldPos10144 = var_173_16.localPosition
				var_173_16.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10144", 4)

				local var_173_18 = var_173_16.childCount

				for iter_173_8 = 0, var_173_18 - 1 do
					local var_173_19 = var_173_16:GetChild(iter_173_8)

					if var_173_19.name == "split_13" or not string.find(var_173_19.name, "split") then
						var_173_19.gameObject:SetActive(true)
					else
						var_173_19.gameObject:SetActive(false)
					end
				end
			end

			local var_173_20 = 0.001

			if var_173_17 <= arg_170_1.time_ and arg_170_1.time_ < var_173_17 + var_173_20 then
				local var_173_21 = (arg_170_1.time_ - var_173_17) / var_173_20
				local var_173_22 = Vector3.New(435.8, -381.1, -285.9)

				var_173_16.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10144, var_173_22, var_173_21)
			end

			if arg_170_1.time_ >= var_173_17 + var_173_20 and arg_170_1.time_ < var_173_17 + var_173_20 + arg_173_0 then
				var_173_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_173_23 = 0
			local var_173_24 = 0.15

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_25 = arg_170_1:FormatText(StoryNameCfg[1297].name)

				arg_170_1.leftNameTxt_.text = var_173_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_26 = arg_170_1:GetWordFromCfg(938072042)
				local var_173_27 = arg_170_1:FormatText(var_173_26.content)

				arg_170_1.text_.text = var_173_27

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_28 = 6
				local var_173_29 = utf8.len(var_173_27)
				local var_173_30 = var_173_28 <= 0 and var_173_24 or var_173_24 * (var_173_29 / var_173_28)

				if var_173_30 > 0 and var_173_24 < var_173_30 then
					arg_170_1.talkMaxDuration = var_173_30

					if var_173_30 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_30 + var_173_23
					end
				end

				arg_170_1.text_.text = var_173_27
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_31 = math.max(var_173_24, arg_170_1.talkMaxDuration)

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_31 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_23) / var_173_31

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_23 + var_173_31 and arg_170_1.time_ < var_173_23 + var_173_31 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play938072043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938072043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938072044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10183"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10183 == nil then
				arg_174_1.var_.actorSpriteComps10183 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps10183 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 1, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10183 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10183 = nil
			end

			local var_177_8 = arg_174_1.actors_["10144"]
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps10144 == nil then
				arg_174_1.var_.actorSpriteComps10144 = var_177_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_10 = 0.2

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_10 and not isNil(var_177_8) then
				local var_177_11 = (arg_174_1.time_ - var_177_9) / var_177_10

				if arg_174_1.var_.actorSpriteComps10144 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								local var_177_12 = Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor2.r, var_177_11)
								local var_177_13 = Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor2.g, var_177_11)
								local var_177_14 = Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor2.b, var_177_11)

								iter_177_5.color = Color.New(var_177_12, var_177_13, var_177_14)
							else
								local var_177_15 = Mathf.Lerp(iter_177_5.color.r, 0.5, var_177_11)

								iter_177_5.color = Color.New(var_177_15, var_177_15, var_177_15)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_9 + var_177_10 and arg_174_1.time_ < var_177_9 + var_177_10 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps10144 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_177_7 then
						if arg_174_1.isInRecall_ then
							iter_177_7.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10144 = nil
			end

			local var_177_16 = arg_174_1.actors_["10183"].transform
			local var_177_17 = 0

			if var_177_17 < arg_174_1.time_ and arg_174_1.time_ <= var_177_17 + arg_177_0 then
				arg_174_1.var_.moveOldPos10183 = var_177_16.localPosition
				var_177_16.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10183", 2)

				local var_177_18 = var_177_16.childCount

				for iter_177_8 = 0, var_177_18 - 1 do
					local var_177_19 = var_177_16:GetChild(iter_177_8)

					if var_177_19.name == "split_9" then
						var_177_19:SetAsLastSibling()
						var_177_19.gameObject:SetActive(true)

						arg_174_1.var_.actorSpriteSplit10183 = var_177_19.gameObject:GetComponent(typeof(Image))

						arg_174_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_177_20 = 0.5

			if var_177_17 <= arg_174_1.time_ and arg_174_1.time_ < var_177_17 + var_177_20 then
				local var_177_21 = (arg_174_1.time_ - var_177_17) / var_177_20
				local var_177_22 = Vector3.New(-300, -475, -325)

				var_177_16.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10183, var_177_22, var_177_21)

				if arg_174_1.var_.actorSpriteSplit10183 ~= nil then
					arg_174_1.var_.actorSpriteSplit10183:SetAlpha(var_177_21)
				end
			end

			if arg_174_1.time_ >= var_177_17 + var_177_20 and arg_174_1.time_ < var_177_17 + var_177_20 + arg_177_0 then
				var_177_16.localPosition = Vector3.New(-300, -475, -325)

				if arg_174_1.var_.actorSpriteSplit10183 ~= nil then
					arg_174_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_177_23 = 0
			local var_177_24 = 0.675

			if var_177_23 < arg_174_1.time_ and arg_174_1.time_ <= var_177_23 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_25 = arg_174_1:FormatText(StoryNameCfg[1562].name)

				arg_174_1.leftNameTxt_.text = var_177_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_26 = arg_174_1:GetWordFromCfg(938072043)
				local var_177_27 = arg_174_1:FormatText(var_177_26.content)

				arg_174_1.text_.text = var_177_27

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_28 = 27
				local var_177_29 = utf8.len(var_177_27)
				local var_177_30 = var_177_28 <= 0 and var_177_24 or var_177_24 * (var_177_29 / var_177_28)

				if var_177_30 > 0 and var_177_24 < var_177_30 then
					arg_174_1.talkMaxDuration = var_177_30

					if var_177_30 + var_177_23 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_30 + var_177_23
					end
				end

				arg_174_1.text_.text = var_177_27
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_31 = math.max(var_177_24, arg_174_1.talkMaxDuration)

			if var_177_23 <= arg_174_1.time_ and arg_174_1.time_ < var_177_23 + var_177_31 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_23) / var_177_31

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_23 + var_177_31 and arg_174_1.time_ < var_177_23 + var_177_31 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play938072044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938072044
		arg_178_1.duration_ = 5.4

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938072045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10183"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10183 == nil then
				arg_178_1.var_.actorSpriteComps10183 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps10183 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								local var_181_4 = Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor2.r, var_181_3)
								local var_181_5 = Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor2.g, var_181_3)
								local var_181_6 = Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor2.b, var_181_3)

								iter_181_1.color = Color.New(var_181_4, var_181_5, var_181_6)
							else
								local var_181_7 = Mathf.Lerp(iter_181_1.color.r, 0.5, var_181_3)

								iter_181_1.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10183 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_181_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10183 = nil
			end

			local var_181_8 = arg_178_1.actors_["10183"].transform
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.var_.moveOldPos10183 = var_181_8.localPosition
				var_181_8.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10183", 7)

				local var_181_10 = var_181_8.childCount

				for iter_181_4 = 0, var_181_10 - 1 do
					local var_181_11 = var_181_8:GetChild(iter_181_4)

					if var_181_11.name == "" or not string.find(var_181_11.name, "split") then
						var_181_11.gameObject:SetActive(true)
					else
						var_181_11.gameObject:SetActive(false)
					end
				end
			end

			local var_181_12 = 0.001

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_12 then
				local var_181_13 = (arg_178_1.time_ - var_181_9) / var_181_12
				local var_181_14 = Vector3.New(0, -2000, 0)

				var_181_8.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10183, var_181_14, var_181_13)
			end

			if arg_178_1.time_ >= var_181_9 + var_181_12 and arg_178_1.time_ < var_181_9 + var_181_12 + arg_181_0 then
				var_181_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_15 = arg_178_1.actors_["10144"].transform
			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.var_.moveOldPos10144 = var_181_15.localPosition
				var_181_15.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10144", 7)

				local var_181_17 = var_181_15.childCount

				for iter_181_5 = 0, var_181_17 - 1 do
					local var_181_18 = var_181_15:GetChild(iter_181_5)

					if var_181_18.name == "" or not string.find(var_181_18.name, "split") then
						var_181_18.gameObject:SetActive(true)
					else
						var_181_18.gameObject:SetActive(false)
					end
				end
			end

			local var_181_19 = 0.001

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_19 then
				local var_181_20 = (arg_178_1.time_ - var_181_16) / var_181_19
				local var_181_21 = Vector3.New(0, -2000, 0)

				var_181_15.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10144, var_181_21, var_181_20)
			end

			if arg_178_1.time_ >= var_181_16 + var_181_19 and arg_178_1.time_ < var_181_16 + var_181_19 + arg_181_0 then
				var_181_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_22 = manager.ui.mainCamera.transform
			local var_181_23 = 0

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1.var_.shakeOldPos = var_181_22.localPosition
			end

			local var_181_24 = 0.4

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_24 then
				local var_181_25 = (arg_178_1.time_ - var_181_23) / 0.066
				local var_181_26, var_181_27 = math.modf(var_181_25)

				var_181_22.localPosition = Vector3.New(var_181_27 * 0.13, var_181_27 * 0.13, var_181_27 * 0.13) + arg_178_1.var_.shakeOldPos
			end

			if arg_178_1.time_ >= var_181_23 + var_181_24 and arg_178_1.time_ < var_181_23 + var_181_24 + arg_181_0 then
				var_181_22.localPosition = arg_178_1.var_.shakeOldPos
			end

			local var_181_28 = 0

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 then
				arg_178_1.allBtn_.enabled = false
			end

			local var_181_29 = 0.4

			if arg_178_1.time_ >= var_181_28 + var_181_29 and arg_178_1.time_ < var_181_28 + var_181_29 + arg_181_0 then
				arg_178_1.allBtn_.enabled = true
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_30 = 0.4
			local var_181_31 = 0.775

			if var_181_30 < arg_178_1.time_ and arg_178_1.time_ <= var_181_30 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_32 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_32:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_33 = arg_178_1:GetWordFromCfg(938072044)
				local var_181_34 = arg_178_1:FormatText(var_181_33.content)

				arg_178_1.text_.text = var_181_34

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_35 = 31
				local var_181_36 = utf8.len(var_181_34)
				local var_181_37 = var_181_35 <= 0 and var_181_31 or var_181_31 * (var_181_36 / var_181_35)

				if var_181_37 > 0 and var_181_31 < var_181_37 then
					arg_178_1.talkMaxDuration = var_181_37
					var_181_30 = var_181_30 + 0.3

					if var_181_37 + var_181_30 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_37 + var_181_30
					end
				end

				arg_178_1.text_.text = var_181_34
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_38 = var_181_30 + 0.3
			local var_181_39 = math.max(var_181_31, arg_178_1.talkMaxDuration)

			if var_181_38 <= arg_178_1.time_ and arg_178_1.time_ < var_181_38 + var_181_39 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_38) / var_181_39

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_38 + var_181_39 and arg_178_1.time_ < var_181_38 + var_181_39 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play938072045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 938072045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play938072046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10144"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10144 == nil then
				arg_184_1.var_.actorSpriteComps10144 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps10144 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 1, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10144 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10144 = nil
			end

			local var_187_8 = arg_184_1.actors_["10144"].transform
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 then
				arg_184_1.var_.moveOldPos10144 = var_187_8.localPosition
				var_187_8.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10144", 3)

				local var_187_10 = var_187_8.childCount

				for iter_187_4 = 0, var_187_10 - 1 do
					local var_187_11 = var_187_8:GetChild(iter_187_4)

					if var_187_11.name == "split_14" or not string.find(var_187_11.name, "split") then
						var_187_11.gameObject:SetActive(true)
					else
						var_187_11.gameObject:SetActive(false)
					end
				end
			end

			local var_187_12 = 0.001

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_12 then
				local var_187_13 = (arg_184_1.time_ - var_187_9) / var_187_12
				local var_187_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_187_8.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10144, var_187_14, var_187_13)
			end

			if arg_184_1.time_ >= var_187_9 + var_187_12 and arg_184_1.time_ < var_187_9 + var_187_12 + arg_187_0 then
				var_187_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_187_15 = 0
			local var_187_16 = 0.3

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_17 = arg_184_1:FormatText(StoryNameCfg[1297].name)

				arg_184_1.leftNameTxt_.text = var_187_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_18 = arg_184_1:GetWordFromCfg(938072045)
				local var_187_19 = arg_184_1:FormatText(var_187_18.content)

				arg_184_1.text_.text = var_187_19

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_20 = 12
				local var_187_21 = utf8.len(var_187_19)
				local var_187_22 = var_187_20 <= 0 and var_187_16 or var_187_16 * (var_187_21 / var_187_20)

				if var_187_22 > 0 and var_187_16 < var_187_22 then
					arg_184_1.talkMaxDuration = var_187_22

					if var_187_22 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_19
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_23 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_23 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_23

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_23 and arg_184_1.time_ < var_187_15 + var_187_23 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play938072046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 938072046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play938072047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10144"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10144 == nil then
				arg_188_1.var_.actorSpriteComps10144 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps10144 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor2.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor2.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor2.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 0.5, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10144 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10144 = nil
			end

			local var_191_8 = arg_188_1.actors_["10144"].transform
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.var_.moveOldPos10144 = var_191_8.localPosition
				var_191_8.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10144", 7)

				local var_191_10 = var_191_8.childCount

				for iter_191_4 = 0, var_191_10 - 1 do
					local var_191_11 = var_191_8:GetChild(iter_191_4)

					if var_191_11.name == "" or not string.find(var_191_11.name, "split") then
						var_191_11.gameObject:SetActive(true)
					else
						var_191_11.gameObject:SetActive(false)
					end
				end
			end

			local var_191_12 = 0.001

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_12 then
				local var_191_13 = (arg_188_1.time_ - var_191_9) / var_191_12
				local var_191_14 = Vector3.New(0, -2000, 0)

				var_191_8.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10144, var_191_14, var_191_13)
			end

			if arg_188_1.time_ >= var_191_9 + var_191_12 and arg_188_1.time_ < var_191_9 + var_191_12 + arg_191_0 then
				var_191_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_191_15 = 0
			local var_191_16 = 0.875

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_17 = arg_188_1:GetWordFromCfg(938072046)
				local var_191_18 = arg_188_1:FormatText(var_191_17.content)

				arg_188_1.text_.text = var_191_18

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_19 = 35
				local var_191_20 = utf8.len(var_191_18)
				local var_191_21 = var_191_19 <= 0 and var_191_16 or var_191_16 * (var_191_20 / var_191_19)

				if var_191_21 > 0 and var_191_16 < var_191_21 then
					arg_188_1.talkMaxDuration = var_191_21

					if var_191_21 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_21 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_18
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_22 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_22 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_22

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_22 and arg_188_1.time_ < var_191_15 + var_191_22 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play938072047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 938072047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play938072048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10183"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps10183 == nil then
				arg_192_1.var_.actorSpriteComps10183 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps10183 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 1, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps10183 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10183 = nil
			end

			local var_195_8 = arg_192_1.actors_["10183"].transform
			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.var_.moveOldPos10183 = var_195_8.localPosition
				var_195_8.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10183", 2)

				local var_195_10 = var_195_8.childCount

				for iter_195_4 = 0, var_195_10 - 1 do
					local var_195_11 = var_195_8:GetChild(iter_195_4)

					if var_195_11.name == "split_12" or not string.find(var_195_11.name, "split") then
						var_195_11.gameObject:SetActive(true)
					else
						var_195_11.gameObject:SetActive(false)
					end
				end
			end

			local var_195_12 = 0.001

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_12 then
				local var_195_13 = (arg_192_1.time_ - var_195_9) / var_195_12
				local var_195_14 = Vector3.New(-300, -475, -325)

				var_195_8.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10183, var_195_14, var_195_13)
			end

			if arg_192_1.time_ >= var_195_9 + var_195_12 and arg_192_1.time_ < var_195_9 + var_195_12 + arg_195_0 then
				var_195_8.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_195_15 = 0
			local var_195_16 = 0.425

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_17 = arg_192_1:FormatText(StoryNameCfg[1562].name)

				arg_192_1.leftNameTxt_.text = var_195_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_18 = arg_192_1:GetWordFromCfg(938072047)
				local var_195_19 = arg_192_1:FormatText(var_195_18.content)

				arg_192_1.text_.text = var_195_19

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_20 = 17
				local var_195_21 = utf8.len(var_195_19)
				local var_195_22 = var_195_20 <= 0 and var_195_16 or var_195_16 * (var_195_21 / var_195_20)

				if var_195_22 > 0 and var_195_16 < var_195_22 then
					arg_192_1.talkMaxDuration = var_195_22

					if var_195_22 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_22 + var_195_15
					end
				end

				arg_192_1.text_.text = var_195_19
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_23 = math.max(var_195_16, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_23 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_23

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_23 and arg_192_1.time_ < var_195_15 + var_195_23 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play938072048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 938072048
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play938072049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10144"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10144 == nil then
				arg_196_1.var_.actorSpriteComps10144 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps10144 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 1, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10144 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10144 = nil
			end

			local var_199_8 = arg_196_1.actors_["10183"]
			local var_199_9 = 0

			if var_199_9 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.actorSpriteComps10183 == nil then
				arg_196_1.var_.actorSpriteComps10183 = var_199_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_10 = 0.2

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_10 and not isNil(var_199_8) then
				local var_199_11 = (arg_196_1.time_ - var_199_9) / var_199_10

				if arg_196_1.var_.actorSpriteComps10183 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								local var_199_12 = Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, var_199_11)
								local var_199_13 = Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, var_199_11)
								local var_199_14 = Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, var_199_11)

								iter_199_5.color = Color.New(var_199_12, var_199_13, var_199_14)
							else
								local var_199_15 = Mathf.Lerp(iter_199_5.color.r, 0.5, var_199_11)

								iter_199_5.color = Color.New(var_199_15, var_199_15, var_199_15)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_9 + var_199_10 and arg_196_1.time_ < var_199_9 + var_199_10 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.actorSpriteComps10183 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_199_7 then
						if arg_196_1.isInRecall_ then
							iter_199_7.color = arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_199_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10183 = nil
			end

			local var_199_16 = arg_196_1.actors_["10144"].transform
			local var_199_17 = 0

			if var_199_17 < arg_196_1.time_ and arg_196_1.time_ <= var_199_17 + arg_199_0 then
				arg_196_1.var_.moveOldPos10144 = var_199_16.localPosition
				var_199_16.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10144", 4)

				local var_199_18 = var_199_16.childCount

				for iter_199_8 = 0, var_199_18 - 1 do
					local var_199_19 = var_199_16:GetChild(iter_199_8)

					if var_199_19.name == "split_13" or not string.find(var_199_19.name, "split") then
						var_199_19.gameObject:SetActive(true)
					else
						var_199_19.gameObject:SetActive(false)
					end
				end
			end

			local var_199_20 = 0.001

			if var_199_17 <= arg_196_1.time_ and arg_196_1.time_ < var_199_17 + var_199_20 then
				local var_199_21 = (arg_196_1.time_ - var_199_17) / var_199_20
				local var_199_22 = Vector3.New(435.8, -381.1, -285.9)

				var_199_16.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10144, var_199_22, var_199_21)
			end

			if arg_196_1.time_ >= var_199_17 + var_199_20 and arg_196_1.time_ < var_199_17 + var_199_20 + arg_199_0 then
				var_199_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_199_23 = 0
			local var_199_24 = 0.2

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_25 = arg_196_1:FormatText(StoryNameCfg[1297].name)

				arg_196_1.leftNameTxt_.text = var_199_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_26 = arg_196_1:GetWordFromCfg(938072048)
				local var_199_27 = arg_196_1:FormatText(var_199_26.content)

				arg_196_1.text_.text = var_199_27

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_28 = 8
				local var_199_29 = utf8.len(var_199_27)
				local var_199_30 = var_199_28 <= 0 and var_199_24 or var_199_24 * (var_199_29 / var_199_28)

				if var_199_30 > 0 and var_199_24 < var_199_30 then
					arg_196_1.talkMaxDuration = var_199_30

					if var_199_30 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_30 + var_199_23
					end
				end

				arg_196_1.text_.text = var_199_27
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_31 = math.max(var_199_24, arg_196_1.talkMaxDuration)

			if var_199_23 <= arg_196_1.time_ and arg_196_1.time_ < var_199_23 + var_199_31 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_23) / var_199_31

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_23 + var_199_31 and arg_196_1.time_ < var_199_23 + var_199_31 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play938072049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 938072049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play938072050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10144"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10144 == nil then
				arg_200_1.var_.actorSpriteComps10144 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps10144 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor2.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor2.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor2.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 0.5, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10144 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10144 = nil
			end

			local var_203_8 = 0
			local var_203_9 = 0.775

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_10 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_10

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

				local var_203_11 = arg_200_1:GetWordFromCfg(938072049)
				local var_203_12 = arg_200_1:FormatText(var_203_11.content)

				arg_200_1.text_.text = var_203_12

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 31
				local var_203_14 = utf8.len(var_203_12)
				local var_203_15 = var_203_13 <= 0 and var_203_9 or var_203_9 * (var_203_14 / var_203_13)

				if var_203_15 > 0 and var_203_9 < var_203_15 then
					arg_200_1.talkMaxDuration = var_203_15

					if var_203_15 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_15 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_12
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_16 and arg_200_1.time_ < var_203_8 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play938072050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 938072050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play938072051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.85

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

				local var_207_3 = arg_204_1:GetWordFromCfg(938072050)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 34
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
	Play938072051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 938072051
		arg_208_1.duration_ = 6.05

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play938072052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10183"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos10183 = var_211_0.localPosition
				var_211_0.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10183", 7)

				local var_211_2 = var_211_0.childCount

				for iter_211_0 = 0, var_211_2 - 1 do
					local var_211_3 = var_211_0:GetChild(iter_211_0)

					if var_211_3.name == "" or not string.find(var_211_3.name, "split") then
						var_211_3.gameObject:SetActive(true)
					else
						var_211_3.gameObject:SetActive(false)
					end
				end
			end

			local var_211_4 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_4 then
				local var_211_5 = (arg_208_1.time_ - var_211_1) / var_211_4
				local var_211_6 = Vector3.New(0, -2000, 0)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10183, var_211_6, var_211_5)
			end

			if arg_208_1.time_ >= var_211_1 + var_211_4 and arg_208_1.time_ < var_211_1 + var_211_4 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_211_7 = arg_208_1.actors_["10144"].transform
			local var_211_8 = 0

			if var_211_8 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.var_.moveOldPos10144 = var_211_7.localPosition
				var_211_7.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10144", 7)

				local var_211_9 = var_211_7.childCount

				for iter_211_1 = 0, var_211_9 - 1 do
					local var_211_10 = var_211_7:GetChild(iter_211_1)

					if var_211_10.name == "" or not string.find(var_211_10.name, "split") then
						var_211_10.gameObject:SetActive(true)
					else
						var_211_10.gameObject:SetActive(false)
					end
				end
			end

			local var_211_11 = 0.001

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_11 then
				local var_211_12 = (arg_208_1.time_ - var_211_8) / var_211_11
				local var_211_13 = Vector3.New(0, -2000, 0)

				var_211_7.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10144, var_211_13, var_211_12)
			end

			if arg_208_1.time_ >= var_211_8 + var_211_11 and arg_208_1.time_ < var_211_8 + var_211_11 + arg_211_0 then
				var_211_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_211_14 = 0.3
			local var_211_15 = 1

			if var_211_14 < arg_208_1.time_ and arg_208_1.time_ <= var_211_14 + arg_211_0 then
				local var_211_16 = "play"
				local var_211_17 = "effect"

				arg_208_1:AudioAction(var_211_16, var_211_17, "se_story_1311", "se_story_1311_car01", "")
			end

			local var_211_18 = manager.ui.mainCamera.transform
			local var_211_19 = 0

			if var_211_19 < arg_208_1.time_ and arg_208_1.time_ <= var_211_19 + arg_211_0 then
				local var_211_20 = arg_208_1.var_.effectyinqingshengyin1
				local var_211_21
				local var_211_22 = var_211_18

				if not var_211_20 then
					var_211_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_211_22)
					var_211_20.name = "yinqingshengyin1"
					arg_208_1.var_.effectyinqingshengyin1 = var_211_20
				else
					var_211_20.transform:SetParent(var_211_22)
				end

				var_211_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_211_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_211_23 = 1.7777777777777777
				local var_211_24 = Screen.width / Screen.height
				local var_211_25 = var_211_24 / var_211_23
				local var_211_26 = Mathf.Max(var_211_23 / var_211_24, 1)

				var_211_20.transform.localScale = Vector3.New(var_211_20.transform.localScale.x * var_211_25, var_211_20.transform.localScale.y * var_211_26, var_211_20.transform.localScale.z)
			end

			local var_211_27 = 0

			if var_211_27 < arg_208_1.time_ and arg_208_1.time_ <= var_211_27 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_28 = 2

			if arg_208_1.time_ >= var_211_27 + var_211_28 and arg_208_1.time_ < var_211_27 + var_211_28 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_29 = 1.05
			local var_211_30 = 0.95

			if var_211_29 < arg_208_1.time_ and arg_208_1.time_ <= var_211_29 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_31 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_31:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_32 = arg_208_1:GetWordFromCfg(938072051)
				local var_211_33 = arg_208_1:FormatText(var_211_32.content)

				arg_208_1.text_.text = var_211_33

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_34 = 38
				local var_211_35 = utf8.len(var_211_33)
				local var_211_36 = var_211_34 <= 0 and var_211_30 or var_211_30 * (var_211_35 / var_211_34)

				if var_211_36 > 0 and var_211_30 < var_211_36 then
					arg_208_1.talkMaxDuration = var_211_36
					var_211_29 = var_211_29 + 0.3

					if var_211_36 + var_211_29 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_36 + var_211_29
					end
				end

				arg_208_1.text_.text = var_211_33
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_37 = var_211_29 + 0.3
			local var_211_38 = math.max(var_211_30, arg_208_1.talkMaxDuration)

			if var_211_37 <= arg_208_1.time_ and arg_208_1.time_ < var_211_37 + var_211_38 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_37) / var_211_38

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_37 + var_211_38 and arg_208_1.time_ < var_211_37 + var_211_38 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play938072052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938072052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938072053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.2

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(938072052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 8
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_8 and arg_214_1.time_ < var_217_0 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play938072053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938072053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938072054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["106603"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps106603 == nil then
				arg_218_1.var_.actorSpriteComps106603 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps106603 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								local var_221_4 = Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, var_221_3)
								local var_221_5 = Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, var_221_3)
								local var_221_6 = Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, var_221_3)

								iter_221_1.color = Color.New(var_221_4, var_221_5, var_221_6)
							else
								local var_221_7 = Mathf.Lerp(iter_221_1.color.r, 1, var_221_3)

								iter_221_1.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps106603 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_221_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps106603 = nil
			end

			local var_221_8 = arg_218_1.actors_["106603"].transform
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1.var_.moveOldPos106603 = var_221_8.localPosition
				var_221_8.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("106603", 3)

				local var_221_10 = var_221_8.childCount

				for iter_221_4 = 0, var_221_10 - 1 do
					local var_221_11 = var_221_8:GetChild(iter_221_4)

					if var_221_11.name == "split_12" or not string.find(var_221_11.name, "split") then
						var_221_11.gameObject:SetActive(true)
					else
						var_221_11.gameObject:SetActive(false)
					end
				end
			end

			local var_221_12 = 0.001

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_12 then
				local var_221_13 = (arg_218_1.time_ - var_221_9) / var_221_12
				local var_221_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_221_8.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos106603, var_221_14, var_221_13)
			end

			if arg_218_1.time_ >= var_221_9 + var_221_12 and arg_218_1.time_ < var_221_9 + var_221_12 + arg_221_0 then
				var_221_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_221_15 = 0
			local var_221_16 = 0.25

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[32].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(938072053)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 10
				local var_221_21 = utf8.len(var_221_19)
				local var_221_22 = var_221_20 <= 0 and var_221_16 or var_221_16 * (var_221_21 / var_221_20)

				if var_221_22 > 0 and var_221_16 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22

					if var_221_22 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_23 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_23 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_23

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_23 and arg_218_1.time_ < var_221_15 + var_221_23 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938072054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938072054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938072055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["106603"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps106603 == nil then
				arg_222_1.var_.actorSpriteComps106603 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps106603 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps106603 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps106603 = nil
			end

			local var_225_8 = manager.ui.mainCamera.transform
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.var_.shakeOldPos = var_225_8.localPosition
			end

			local var_225_10 = 0.6

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 then
				local var_225_11 = (arg_222_1.time_ - var_225_9) / 0.066
				local var_225_12, var_225_13 = math.modf(var_225_11)

				var_225_8.localPosition = Vector3.New(var_225_13 * 0.13, var_225_13 * 0.13, var_225_13 * 0.13) + arg_222_1.var_.shakeOldPos
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 then
				var_225_8.localPosition = arg_222_1.var_.shakeOldPos
			end

			local var_225_14 = 0

			if var_225_14 < arg_222_1.time_ and arg_222_1.time_ <= var_225_14 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			local var_225_15 = 0.6

			if arg_222_1.time_ >= var_225_14 + var_225_15 and arg_222_1.time_ < var_225_14 + var_225_15 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_16 = arg_222_1.actors_["128404"].transform
			local var_225_17 = 0

			if var_225_17 < arg_222_1.time_ and arg_222_1.time_ <= var_225_17 + arg_225_0 then
				arg_222_1.var_.moveOldPos128404 = var_225_16.localPosition
				var_225_16.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("128404", 2)

				local var_225_18 = var_225_16.childCount

				for iter_225_4 = 0, var_225_18 - 1 do
					local var_225_19 = var_225_16:GetChild(iter_225_4)

					if var_225_19.name == "split_7" or not string.find(var_225_19.name, "split") then
						var_225_19.gameObject:SetActive(true)
					else
						var_225_19.gameObject:SetActive(false)
					end
				end
			end

			local var_225_20 = 0.001

			if var_225_17 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_20 then
				local var_225_21 = (arg_222_1.time_ - var_225_17) / var_225_20
				local var_225_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_225_16.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos128404, var_225_22, var_225_21)
			end

			if arg_222_1.time_ >= var_225_17 + var_225_20 and arg_222_1.time_ < var_225_17 + var_225_20 + arg_225_0 then
				var_225_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_225_23 = arg_222_1.actors_["108301"].transform
			local var_225_24 = 0

			if var_225_24 < arg_222_1.time_ and arg_222_1.time_ <= var_225_24 + arg_225_0 then
				arg_222_1.var_.moveOldPos108301 = var_225_23.localPosition
				var_225_23.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("108301", 4)

				local var_225_25 = var_225_23.childCount

				for iter_225_5 = 0, var_225_25 - 1 do
					local var_225_26 = var_225_23:GetChild(iter_225_5)

					if var_225_26.name == "split_6" or not string.find(var_225_26.name, "split") then
						var_225_26.gameObject:SetActive(true)
					else
						var_225_26.gameObject:SetActive(false)
					end
				end
			end

			local var_225_27 = 0.001

			if var_225_24 <= arg_222_1.time_ and arg_222_1.time_ < var_225_24 + var_225_27 then
				local var_225_28 = (arg_222_1.time_ - var_225_24) / var_225_27
				local var_225_29 = Vector3.New(453.9, -399.1, -303.3)

				var_225_23.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos108301, var_225_29, var_225_28)
			end

			if arg_222_1.time_ >= var_225_24 + var_225_27 and arg_222_1.time_ < var_225_24 + var_225_27 + arg_225_0 then
				var_225_23.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_225_30 = arg_222_1.actors_["128404"]
			local var_225_31 = 0

			if var_225_31 < arg_222_1.time_ and arg_222_1.time_ <= var_225_31 + arg_225_0 and not isNil(var_225_30) and arg_222_1.var_.actorSpriteComps128404 == nil then
				arg_222_1.var_.actorSpriteComps128404 = var_225_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_32 = 0.2

			if var_225_31 <= arg_222_1.time_ and arg_222_1.time_ < var_225_31 + var_225_32 and not isNil(var_225_30) then
				local var_225_33 = (arg_222_1.time_ - var_225_31) / var_225_32

				if arg_222_1.var_.actorSpriteComps128404 then
					for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_225_7 then
							if arg_222_1.isInRecall_ then
								local var_225_34 = Mathf.Lerp(iter_225_7.color.r, arg_222_1.hightColor1.r, var_225_33)
								local var_225_35 = Mathf.Lerp(iter_225_7.color.g, arg_222_1.hightColor1.g, var_225_33)
								local var_225_36 = Mathf.Lerp(iter_225_7.color.b, arg_222_1.hightColor1.b, var_225_33)

								iter_225_7.color = Color.New(var_225_34, var_225_35, var_225_36)
							else
								local var_225_37 = Mathf.Lerp(iter_225_7.color.r, 1, var_225_33)

								iter_225_7.color = Color.New(var_225_37, var_225_37, var_225_37)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_31 + var_225_32 and arg_222_1.time_ < var_225_31 + var_225_32 + arg_225_0 and not isNil(var_225_30) and arg_222_1.var_.actorSpriteComps128404 then
				for iter_225_8, iter_225_9 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_225_9 then
						if arg_222_1.isInRecall_ then
							iter_225_9.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps128404 = nil
			end

			local var_225_38 = arg_222_1.actors_["108301"]
			local var_225_39 = 0

			if var_225_39 < arg_222_1.time_ and arg_222_1.time_ <= var_225_39 + arg_225_0 and not isNil(var_225_38) and arg_222_1.var_.actorSpriteComps108301 == nil then
				arg_222_1.var_.actorSpriteComps108301 = var_225_38:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_40 = 0.2

			if var_225_39 <= arg_222_1.time_ and arg_222_1.time_ < var_225_39 + var_225_40 and not isNil(var_225_38) then
				local var_225_41 = (arg_222_1.time_ - var_225_39) / var_225_40

				if arg_222_1.var_.actorSpriteComps108301 then
					for iter_225_10, iter_225_11 in pairs(arg_222_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_225_11 then
							if arg_222_1.isInRecall_ then
								local var_225_42 = Mathf.Lerp(iter_225_11.color.r, arg_222_1.hightColor1.r, var_225_41)
								local var_225_43 = Mathf.Lerp(iter_225_11.color.g, arg_222_1.hightColor1.g, var_225_41)
								local var_225_44 = Mathf.Lerp(iter_225_11.color.b, arg_222_1.hightColor1.b, var_225_41)

								iter_225_11.color = Color.New(var_225_42, var_225_43, var_225_44)
							else
								local var_225_45 = Mathf.Lerp(iter_225_11.color.r, 1, var_225_41)

								iter_225_11.color = Color.New(var_225_45, var_225_45, var_225_45)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_39 + var_225_40 and arg_222_1.time_ < var_225_39 + var_225_40 + arg_225_0 and not isNil(var_225_38) and arg_222_1.var_.actorSpriteComps108301 then
				for iter_225_12, iter_225_13 in pairs(arg_222_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_225_13 then
						if arg_222_1.isInRecall_ then
							iter_225_13.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_13.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps108301 = nil
			end

			local var_225_46 = 0
			local var_225_47 = 0.175

			if var_225_46 < arg_222_1.time_ and arg_222_1.time_ <= var_225_46 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_48 = arg_222_1:FormatText(StoryNameCfg[330].name)

				arg_222_1.leftNameTxt_.text = var_225_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_49 = arg_222_1:GetWordFromCfg(938072054)
				local var_225_50 = arg_222_1:FormatText(var_225_49.content)

				arg_222_1.text_.text = var_225_50

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_51 = 7
				local var_225_52 = utf8.len(var_225_50)
				local var_225_53 = var_225_51 <= 0 and var_225_47 or var_225_47 * (var_225_52 / var_225_51)

				if var_225_53 > 0 and var_225_47 < var_225_53 then
					arg_222_1.talkMaxDuration = var_225_53

					if var_225_53 + var_225_46 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_53 + var_225_46
					end
				end

				arg_222_1.text_.text = var_225_50
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_54 = math.max(var_225_47, arg_222_1.talkMaxDuration)

			if var_225_46 <= arg_222_1.time_ and arg_222_1.time_ < var_225_46 + var_225_54 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_46) / var_225_54

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_46 + var_225_54 and arg_222_1.time_ < var_225_46 + var_225_54 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play938072055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938072055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
			arg_226_1.auto_ = false
		end

		function arg_226_1.playNext_(arg_228_0)
			arg_226_1.onStoryFinished_()
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.075

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(938072055)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 3
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I20f"
	},
	voices = {}
}
